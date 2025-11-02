-- Clone.lua - Enhanced with Player List
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
	CloneDesc.Text = "Select player from list or search by username"
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
		
		local anchoredParts = {}
		if hrp and hrp:IsA("BasePart") then
			table.insert(anchoredParts, hrp)
			hrp.Anchored = true
		end
		
		local prevPlatformStand = humanoid.PlatformStand
		humanoid.PlatformStand = true
		
		local ok, err = pcall(function()
			humanoid:ApplyDescription(humanoidDescription)
		end)
		
		wait(0.2)
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
			return false, "User not found"
		end
		
		local humanoidDescription
		local ok, err = pcall(function()
			humanoidDescription = game.Players:GetHumanoidDescriptionFromUserId(targetId)
		end)
		
		if not ok or not humanoidDescription then
			return false, "Failed to get description"
		end
		
		local char = player.Character
		if not char or not char.Parent then
			return false, "Character not spawned"
		end
		
		return safeApplyDescriptionToCharacter(char, humanoidDescription)
	end

	-- Player List Section
	local PlayerListLabel = Instance.new("TextLabel", ClonePage)
	PlayerListLabel.Size = UDim2.new(1, -10, 0, 25)
	PlayerListLabel.Position = UDim2.new(0, 5, 0, 100)
	PlayerListLabel.BackgroundTransparency = 1
	PlayerListLabel.Text = "👥 Players in Server (Click to Clone)"
	PlayerListLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	PlayerListLabel.Font = Enum.Font.GothamBold
	PlayerListLabel.TextSize = 15
	PlayerListLabel.TextXAlignment = Enum.TextXAlignment.Left

	local PlayerListFrame = Instance.new("ScrollingFrame", ClonePage)
	PlayerListFrame.Size = UDim2.new(1, -10, 0, 200)
	PlayerListFrame.Position = UDim2.new(0, 5, 0, 130)
	PlayerListFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	PlayerListFrame.BorderSizePixel = 0
	PlayerListFrame.ScrollBarThickness = 6
	PlayerListFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
	PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	local PlayerListCorner = Instance.new("UICorner", PlayerListFrame)
	PlayerListCorner.CornerRadius = UDim.new(0, 8)
	local PlayerListStroke = Instance.new("UIStroke", PlayerListFrame)
	PlayerListStroke.Color = Color3.fromRGB(0, 160, 255)
	PlayerListStroke.Thickness = 2
	
	local PlayerListLayout = Instance.new("UIListLayout", PlayerListFrame)
	PlayerListLayout.SortOrder = Enum.SortOrder.Name
	PlayerListLayout.Padding = UDim.new(0, 2)

	local playerButtons = {}

	local function updatePlayerList()
		-- Clear existing buttons
		for _, btn in pairs(playerButtons) do
			if btn and btn.Parent then
				btn:Destroy()
			end
		end
		playerButtons = {}

		local totalHeight = 0
		for _, plr in pairs(game.Players:GetPlayers()) do
			if plr ~= player then
				local playerBtn = Instance.new("TextButton", PlayerListFrame)
				playerBtn.Size = UDim2.new(1, -10, 0, 35)
				playerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
				playerBtn.BorderSizePixel = 0
				
				local displayText = plr.DisplayName
				if plr.DisplayName ~= plr.Name then
					displayText = plr.DisplayName .. " (@" .. plr.Name .. ")"
				end
				playerBtn.Text = displayText
				
				playerBtn.Font = Enum.Font.Gotham
				playerBtn.TextSize = 13
				playerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
				playerBtn.TextXAlignment = Enum.TextXAlignment.Left
				playerBtn.TextTruncate = Enum.TextTruncate.AtEnd
				
				local btnCorner = Instance.new("UICorner", playerBtn)
				btnCorner.CornerRadius = UDim.new(0, 6)
				
				local btnPadding = Instance.new("UIPadding", playerBtn)
				btnPadding.PaddingLeft = UDim.new(0, 10)
				
				playerBtn.MouseEnter:Connect(function()
					playerBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 90)
				end)
				
				playerBtn.MouseLeave:Connect(function()
					playerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
				end)
				
				playerBtn.MouseButton1Click:Connect(function()
					playerBtn.Text = "⏳ Cloning..."
					playerBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
					
					local success, reason = changeAvatarByUsername(plr.Name)
					
					if success then
						playerBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
						wait(1)
						playerBtn.Text = displayText
						playerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
					else
						playerBtn.Text = "❌ Failed"
						playerBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
						wait(1)
						playerBtn.Text = displayText
						playerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
					end
				end)
				
				table.insert(playerButtons, playerBtn)
				totalHeight = totalHeight + 37
			end
		end
		
		PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
	end

	-- Initial player list
	updatePlayerList()

	-- Update list when players join/leave
	game.Players.PlayerAdded:Connect(updatePlayerList)
	game.Players.PlayerRemoving:Connect(updatePlayerList)

	-- Search by Username
	local UsernameLabel = Instance.new("TextLabel", ClonePage)
	UsernameLabel.Size = UDim2.new(1, -10, 0, 25)
	UsernameLabel.Position = UDim2.new(0, 5, 0, 345)
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Text = "🔍 Search by Username (Any Player)"
	UsernameLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	UsernameLabel.Font = Enum.Font.GothamBold
	UsernameLabel.TextSize = 15
	UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left

	local UsernameBox = Instance.new("TextBox", ClonePage)
	UsernameBox.Size = UDim2.new(0.65, -10, 0, 40)
	UsernameBox.Position = UDim2.new(0, 5, 0, 375)
	UsernameBox.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	UsernameBox.PlaceholderText = "Enter username..."
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

	local CloneUsernameBtn = Instance.new("TextButton", ClonePage)
	CloneUsernameBtn.Size = UDim2.new(0.35, -5, 0, 40)
	CloneUsernameBtn.Position = UDim2.new(0.65, 5, 0, 375)
	CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	CloneUsernameBtn.Text = "Clone"
	CloneUsernameBtn.Font = Enum.Font.GothamBold
	CloneUsernameBtn.TextSize = 14
	CloneUsernameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloneUsernameBtn.BorderSizePixel = 0
	local CloneUserCorner = Instance.new("UICorner", CloneUsernameBtn)
	CloneUserCorner.CornerRadius = UDim.new(0, 8)
	CloneUsernameBtn.MouseEnter:Connect(function() CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240) end)
	CloneUsernameBtn.MouseLeave:Connect(function() CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) end)

	CloneUsernameBtn.MouseButton1Click:Connect(function()
		local username = UsernameBox.Text
		if username ~= "" then
			CloneUsernameBtn.Text = "⏳..."
			CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
			
			local success, reason = changeAvatarByUsername(username)
			
			if success then
				CloneUsernameBtn.Text = "✅ Done"
				CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
			else
				CloneUsernameBtn.Text = "❌ Failed"
				CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
			end
			
			wait(1.5)
			CloneUsernameBtn.Text = "Clone"
			CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
		end
	end)

	-- Refresh Button
	local RefreshBtn = Instance.new("TextButton", ClonePage)
	RefreshBtn.Size = UDim2.new(1, -10, 0, 35)
	RefreshBtn.Position = UDim2.new(0, 5, 0, 430)
	RefreshBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
	RefreshBtn.Text = "🔄 Refresh Player List"
	RefreshBtn.Font = Enum.Font.GothamBold
	RefreshBtn.TextSize = 14
	RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	RefreshBtn.BorderSizePixel = 0
	local RefreshCorner = Instance.new("UICorner", RefreshBtn)
	RefreshCorner.CornerRadius = UDim.new(0, 8)
	RefreshBtn.MouseEnter:Connect(function() RefreshBtn.BackgroundColor3 = Color3.fromRGB(70, 120, 180) end)
	RefreshBtn.MouseLeave:Connect(function() RefreshBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 150) end)

	RefreshBtn.MouseButton1Click:Connect(function()
		RefreshBtn.Text = "⏳ Refreshing..."
		updatePlayerList()
		wait(0.5)
		RefreshBtn.Text = "🔄 Refresh Player List"
	end)
end

return CloneModule
