--// Clone.lua - Avatar Cloning Module (Server-Side)
--// Everyone can see the cloned avatar
local CloneModule = {}

function CloneModule.Initialize(ClonePage, player, character)
	
	local humanoid = character:WaitForChild("Humanoid")
	
	local CloneTitle = Instance.new("TextLabel", ClonePage)
	CloneTitle.Size = UDim2.new(1, -10, 0, 40)
	CloneTitle.Position = UDim2.new(0, 5, 0, 10)
	CloneTitle.BackgroundTransparency = 1
	CloneTitle.Text = "🎭 Clone Player Avatar (Server-Side)"
	CloneTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
	CloneTitle.Font = Enum.Font.GothamBold
	CloneTitle.TextSize = 20
	CloneTitle.TextXAlignment = Enum.TextXAlignment.Left

	local CloneDesc = Instance.new("TextLabel", ClonePage)
	CloneDesc.Size = UDim2.new(1, -10, 0, 50)
	CloneDesc.Position = UDim2.new(0, 5, 0, 55)
	CloneDesc.BackgroundTransparency = 1
	CloneDesc.Text = "✅ Perfect Clone - Everyone can see!\n🌐 Server-Side Replication - 100% Same Appearance"
	CloneDesc.TextColor3 = Color3.fromRGB(100, 255, 100)
	CloneDesc.Font = Enum.Font.GothamBold
	CloneDesc.TextSize = 12
	CloneDesc.TextXAlignment = Enum.TextXAlignment.Left
	CloneDesc.TextWrapped = true

	-- Info Card
	local InfoCard = Instance.new("Frame", ClonePage)
	InfoCard.Size = UDim2.new(1, -10, 0, 60)
	InfoCard.Position = UDim2.new(0, 5, 0, 115)
	InfoCard.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	InfoCard.BackgroundTransparency = 0.3
	InfoCard.BorderSizePixel = 0
	local InfoCorner = Instance.new("UICorner", InfoCard)
	InfoCorner.CornerRadius = UDim.new(0, 10)
	local InfoStroke = Instance.new("UIStroke", InfoCard)
	InfoStroke.Color = Color3.fromRGB(0, 180, 255)
	InfoStroke.Thickness = 2

	local InfoText = Instance.new("TextLabel", InfoCard)
	InfoText.Size = UDim2.new(1, -10, 1, -10)
	InfoText.Position = UDim2.new(0, 5, 0, 5)
	InfoText.BackgroundTransparency = 1
	InfoText.Text = "ℹ️ This clones:\n• Clothes, Accessories, Face, Body Colors, Scales, Everything!"
	InfoText.TextColor3 = Color3.fromRGB(150, 200, 255)
	InfoText.Font = Enum.Font.Gotham
	InfoText.TextSize = 11
	InfoText.TextXAlignment = Enum.TextXAlignment.Left
	InfoText.TextYAlignment = Enum.TextYAlignment.Top
	InfoText.TextWrapped = true

	-- Search by Username
	local UsernameLabel = Instance.new("TextLabel", ClonePage)
	UsernameLabel.Size = UDim2.new(1, -10, 0, 25)
	UsernameLabel.Position = UDim2.new(0, 5, 0, 185)
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Text = "🔹 Search by Username:"
	UsernameLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	UsernameLabel.Font = Enum.Font.GothamBold
	UsernameLabel.TextSize = 15
	UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left

	local UsernameBox = Instance.new("TextBox", ClonePage)
	UsernameBox.Size = UDim2.new(1, -10, 0, 40)
	UsernameBox.Position = UDim2.new(0, 5, 0, 215)
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
	DisplayLabel.Position = UDim2.new(0, 5, 0, 270)
	DisplayLabel.BackgroundTransparency = 1
	DisplayLabel.Text = "🔹 Search by DisplayName:"
	DisplayLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	DisplayLabel.Font = Enum.Font.GothamBold
	DisplayLabel.TextSize = 15
	DisplayLabel.TextXAlignment = Enum.TextXAlignment.Left

	local DisplayBox = Instance.new("TextBox", ClonePage)
	DisplayBox.Size = UDim2.new(1, -10, 0, 40)
	DisplayBox.Position = UDim2.new(0, 5, 0, 300)
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

	-- Status Label
	local StatusLabel = Instance.new("TextLabel", ClonePage)
	StatusLabel.Size = UDim2.new(1, -10, 0, 30)
	StatusLabel.Position = UDim2.new(0, 5, 0, 495)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.Text = "⚪ Ready to clone..."
	StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	StatusLabel.Font = Enum.Font.GothamBold
	StatusLabel.TextSize = 13
	StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

	-- Clone Function (PROPER METHOD - Server-Side)
	local function CloneAvatar(targetPlayer)
		if not targetPlayer then 
			return false, "Player not found"
		end
		
		if not targetPlayer.Character then
			return false, "Target has no character"
		end
		
		local targetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
		if not targetHumanoid then
			return false, "Target has no humanoid"
		end
		
		-- Method 1: Using GetAppliedDescription (BEST METHOD - Server Replicated)
		local success, result = pcall(function()
			-- Get the target's current appearance
			local targetDescription = targetHumanoid:GetAppliedDescription()
			
			-- Apply it to our character (This is SERVER-SIDE and visible to all!)
			humanoid:ApplyDescription(targetDescription)
			
			return true
		end)
		
		if success and result then
			return true, "Successfully cloned " .. targetPlayer.Name
		end
		
		-- Method 2: Fallback - Using UserId (if Method 1 fails)
		local success2, result2 = pcall(function()
			local targetUserId = targetPlayer.UserId
			local description = game.Players:GetHumanoidDescriptionFromUserId(targetUserId)
			humanoid:ApplyDescription(description)
			return true
		end)
		
		if success2 and result2 then
			return true, "Cloned from UserId: " .. targetPlayer.Name
		end
		
		return false, "Failed to clone avatar"
	end

	-- Clone by Username Button
	local CloneUsernameBtn = Instance.new("TextButton", ClonePage)
	CloneUsernameBtn.Size = UDim2.new(1, -10, 0, 45)
	CloneUsernameBtn.Position = UDim2.new(0, 5, 0, 355)
	CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	CloneUsernameBtn.Text = "🎭 Clone by Username"
	CloneUsernameBtn.Font = Enum.Font.GothamBold
	CloneUsernameBtn.TextSize = 16
	CloneUsernameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloneUsernameBtn.BorderSizePixel = 0
	local CloneUserCorner = Instance.new("UICorner", CloneUsernameBtn)
	CloneUserCorner.CornerRadius = UDim.new(0, 10)
	local CloneUserStroke = Instance.new("UIStroke", CloneUsernameBtn)
	CloneUserStroke.Color = Color3.fromRGB(0, 150, 255)
	CloneUserStroke.Thickness = 2
	
	CloneUsernameBtn.MouseEnter:Connect(function() 
		CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240)
		CloneUserStroke.Thickness = 3
	end)
	CloneUsernameBtn.MouseLeave:Connect(function() 
		CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
		CloneUserStroke.Thickness = 2
	end)

	CloneUsernameBtn.MouseButton1Click:Connect(function()
		local username = UsernameBox.Text
		if username ~= "" then
			StatusLabel.Text = "🔍 Searching for " .. username .. "..."
			StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
			
			local foundPlayer = nil
			for _, v in pairs(game.Players:GetPlayers()) do
				if v.Name:lower() == username:lower() or v.Name:lower():find(username:lower()) then
					foundPlayer = v
					break
				end
			end
			
			if foundPlayer then
				StatusLabel.Text = "⏳ Cloning " .. foundPlayer.Name .. "..."
				StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
				wait(0.5)
				
				local success, message = CloneAvatar(foundPlayer)
				if success then
					StatusLabel.Text = "✅ " .. message
					StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
					CloneUsernameBtn.Text = "✅ Cloned: " .. foundPlayer.Name
				else
					StatusLabel.Text = "❌ " .. message
					StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
					CloneUsernameBtn.Text = "❌ Clone Failed"
				end
				
				wait(2)
				CloneUsernameBtn.Text = "🎭 Clone by Username"
			else
				StatusLabel.Text = "❌ Player '" .. username .. "' not found in server"
				StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
				CloneUsernameBtn.Text = "❌ Player Not Found"
				wait(2)
				CloneUsernameBtn.Text = "🎭 Clone by Username"
			end
		else
			StatusLabel.Text = "⚠️ Please enter a username"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
		end
	end)

	-- Clone by DisplayName Button
	local CloneDisplayBtn = Instance.new("TextButton", ClonePage)
	CloneDisplayBtn.Size = UDim2.new(1, -10, 0, 45)
	CloneDisplayBtn.Position = UDim2.new(0, 5, 0, 410)
	CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
	CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
	CloneDisplayBtn.Font = Enum.Font.GothamBold
	CloneDisplayBtn.TextSize = 16
	CloneDisplayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloneDisplayBtn.BorderSizePixel = 0
	local CloneDispCorner = Instance.new("UICorner", CloneDisplayBtn)
	CloneDispCorner.CornerRadius = UDim.new(0, 10)
	local CloneDispStroke = Instance.new("UIStroke", CloneDisplayBtn)
	CloneDispStroke.Color = Color3.fromRGB(150, 0, 255)
	CloneDispStroke.Thickness = 2
	
	CloneDisplayBtn.MouseEnter:Connect(function() 
		CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 240)
		CloneDispStroke.Thickness = 3
	end)
	CloneDisplayBtn.MouseLeave:Connect(function() 
		CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
		CloneDispStroke.Thickness = 2
	end)

	CloneDisplayBtn.MouseButton1Click:Connect(function()
		local displayname = DisplayBox.Text
		if displayname ~= "" then
			StatusLabel.Text = "🔍 Searching for " .. displayname .. "..."
			StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
			
			local foundPlayer = nil
			for _, v in pairs(game.Players:GetPlayers()) do
				if v.DisplayName:lower() == displayname:lower() or v.DisplayName:lower():find(displayname:lower()) then
					foundPlayer = v
					break
				end
			end
			
			if foundPlayer then
				StatusLabel.Text = "⏳ Cloning " .. foundPlayer.DisplayName .. "..."
				StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
				wait(0.5)
				
				local success, message = CloneAvatar(foundPlayer)
				if success then
					StatusLabel.Text = "✅ " .. message
					StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
					CloneDisplayBtn.Text = "✅ Cloned: " .. foundPlayer.DisplayName
				else
					StatusLabel.Text = "❌ " .. message
					StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
					CloneDisplayBtn.Text = "❌ Clone Failed"
				end
				
				wait(2)
				CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
			else
				StatusLabel.Text = "❌ Player '" .. displayname .. "' not found in server"
				StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
				CloneDisplayBtn.Text = "❌ Player Not Found"
				wait(2)
				CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
			end
		else
			StatusLabel.Text = "⚠️ Please enter a display name"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
		end
	end)

	-- Reset Avatar Button
	local ResetBtn = Instance.new("TextButton", ClonePage)
	ResetBtn.Size = UDim2.new(1, -10, 0, 45)
	ResetBtn.Position = UDim2.new(0, 5, 0, 540)
	ResetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	ResetBtn.Text = "🔄 Reset to Original Avatar"
	ResetBtn.Font = Enum.Font.GothamBold
	ResetBtn.TextSize = 16
	ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	ResetBtn.BorderSizePixel = 0
	local ResetCorner = Instance.new("UICorner", ResetBtn)
	ResetCorner.CornerRadius = UDim.new(0, 10)
	local ResetStroke = Instance.new("UIStroke", ResetBtn)
	ResetStroke.Color = Color3.fromRGB(255, 100, 100)
	ResetStroke.Thickness = 2
	
	ResetBtn.MouseEnter:Connect(function() 
		ResetBtn.BackgroundColor3 = Color3.fromRGB(240, 70, 70)
		ResetStroke.Thickness = 3
	end)
	ResetBtn.MouseLeave:Connect(function() 
		ResetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		ResetStroke.Thickness = 2
	end)

	ResetBtn.MouseButton1Click:Connect(function()
		StatusLabel.Text = "⏳ Resetting to original avatar..."
		StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
		
		local success, result = pcall(function()
			local originalDescription = game.Players:GetHumanoidDescriptionFromUserId(player.UserId)
			humanoid:ApplyDescription(originalDescription)
		end)
		
		if success then
			StatusLabel.Text = "✅ Reset to original avatar"
			StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
			ResetBtn.Text = "✅ Avatar Reset!"
			wait(2)
			ResetBtn.Text = "🔄 Reset to Original Avatar"
		else
			StatusLabel.Text = "❌ Failed to reset avatar"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		end
	end)

	-- Quick Clone (Players in Server)
	local QuickCloneFrame = Instance.new("Frame", ClonePage)
	QuickCloneFrame.Size = UDim2.new(1, -10, 0, 200)
	QuickCloneFrame.Position = UDim2.new(0, 5, 0, 600)
	QuickCloneFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	QuickCloneFrame.BackgroundTransparency = 0.3
	QuickCloneFrame.BorderSizePixel = 0
	local QuickCorner = Instance.new("UICorner", QuickCloneFrame)
	QuickCorner.CornerRadius = UDim.new(0, 10)
	local QuickStroke = Instance.new("UIStroke", QuickCloneFrame)
	QuickStroke.Color = Color3.fromRGB(0, 180, 255)
	QuickStroke.Thickness = 2

	local QuickTitle = Instance.new("TextLabel", QuickCloneFrame)
	QuickTitle.Size = UDim2.new(1, -10, 0, 30)
	QuickTitle.Position = UDim2.new(0, 5, 0, 5)
	QuickTitle.BackgroundTransparency = 1
	QuickTitle.Text = "⚡ Quick Clone - Players in Server"
	QuickTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
	QuickTitle.Font = Enum.Font.GothamBold
	QuickTitle.TextSize = 15
	QuickTitle.TextXAlignment = Enum.TextXAlignment.Left

	local QuickScroll = Instance.new("ScrollingFrame", QuickCloneFrame)
	QuickScroll.Size = UDim2.new(1, -10, 0, 155)
	QuickScroll.Position = UDim2.new(0, 5, 0, 40)
	QuickScroll.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
	QuickScroll.BackgroundTransparency = 0.5
	QuickScroll.BorderSizePixel = 0
	QuickScroll.ScrollBarThickness = 6
	QuickScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
	QuickScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	local QuickScrollCorner = Instance.new("UICorner", QuickScroll)
	QuickScrollCorner.CornerRadius = UDim.new(0, 8)

	local UIList = Instance.new("UIListLayout", QuickScroll)
	UIList.Padding = UDim.new(0, 5)
	UIList.FillDirection = Enum.FillDirection.Vertical

	-- Update player list
	local function UpdatePlayerList()
		QuickScroll:ClearAllChildren()
		UIList = Instance.new("UIListLayout", QuickScroll)
		UIList.Padding = UDim.new(0, 5)
		
		for _, targetPlayer in pairs(game.Players:GetPlayers()) do
			if targetPlayer ~= player then
				local playerBtn = Instance.new("TextButton", QuickScroll)
				playerBtn.Size = UDim2.new(1, -5, 0, 35)
				playerBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 60)
				playerBtn.Text = string.format("👤 %s (@%s)", targetPlayer.DisplayName, targetPlayer.Name)
				playerBtn.TextColor3 = Color3.fromRGB(150, 200, 255)
				playerBtn.Font = Enum.Font.Gotham
				playerBtn.TextSize = 12
				playerBtn.BorderSizePixel = 0
				playerBtn.TextXAlignment = Enum.TextXAlignment.Left
				local btnCorner = Instance.new("UICorner", playerBtn)
				btnCorner.CornerRadius = UDim.new(0, 8)
				
				local btnStroke = Instance.new("UIStroke", playerBtn)
				btnStroke.Color = Color3.fromRGB(0, 150, 255)
				btnStroke.Thickness = 1
				
				playerBtn.MouseEnter:Connect(function()
					playerBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 90)
					btnStroke.Thickness = 2
				end)
				playerBtn.MouseLeave:Connect(function()
					playerBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 60)
					btnStroke.Thickness = 1
				end)
				
				playerBtn.MouseButton1Click:Connect(function()
					StatusLabel.Text = "⏳ Cloning " .. targetPlayer.Name .. "..."
					StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
					
					local success, message = CloneAvatar(targetPlayer)
					if success then
						StatusLabel.Text = "✅ " .. message
						StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
						playerBtn.Text = "✅ Cloned!"
						wait(1)
						playerBtn.Text = string.format("👤 %s (@%s)", targetPlayer.DisplayName, targetPlayer.Name)
					else
						StatusLabel.Text = "❌ " .. message
						StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
					end
				end)
			end
		end
		
		QuickScroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
	end

	-- Update player list every 3 seconds
	spawn(function()
		while wait(3) do
			if QuickScroll and QuickScroll.Parent then
				UpdatePlayerList()
			end
		end
	end)
	
	-- Initial update
	UpdatePlayerList()
	
	ClonePage.CanvasSize = UDim2.new(0, 0, 0, 820)
end

return CloneModule
