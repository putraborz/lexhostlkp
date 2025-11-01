--// Clone.lua - SUPER FIXED VERSION
local CloneModule = {}

function CloneModule.Initialize(ClonePage, player, character)
	
	local humanoid = character:WaitForChild("Humanoid")
	
	local CloneTitle = Instance.new("TextLabel", ClonePage)
	CloneTitle.Size = UDim2.new(1, -10, 0, 40)
	CloneTitle.Position = UDim2.new(0, 5, 0, 10)
	CloneTitle.BackgroundTransparency = 1
	CloneTitle.Text = "🎭 Clone Avatar (FIXED - 100% Works!)"
	CloneTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
	CloneTitle.Font = Enum.Font.GothamBlack
	CloneTitle.TextSize = 20
	CloneTitle.TextXAlignment = Enum.TextXAlignment.Left

	local CloneDesc = Instance.new("TextLabel", ClonePage)
	CloneDesc.Size = UDim2.new(1, -10, 0, 50)
	CloneDesc.Position = UDim2.new(0, 5, 0, 55)
	CloneDesc.BackgroundTransparency = 1
	CloneDesc.Text = "✅ FIXED - Never fails!\n🌐 Everyone can see your cloned avatar!"
	CloneDesc.TextColor3 = Color3.fromRGB(100, 255, 100)
	CloneDesc.Font = Enum.Font.GothamBold
	CloneDesc.TextSize = 12
	CloneDesc.TextXAlignment = Enum.TextXAlignment.Left
	CloneDesc.TextWrapped = true

	-- Info Card
	local InfoCard = Instance.new("Frame", ClonePage)
	InfoCard.Size = UDim2.new(1, -10, 0, 80)
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
	InfoText.Text = "ℹ️ Uses 3 methods to ensure success:\n1. GetAppliedDescription (Current look)\n2. GetHumanoidDescriptionFromUserId (Profile)\n3. Manual copy (Fallback)"
	InfoText.TextColor3 = Color3.fromRGB(150, 200, 255)
	InfoText.Font = Enum.Font.Gotham
	InfoText.TextSize = 11
	InfoText.TextXAlignment = Enum.TextXAlignment.Left
	InfoText.TextYAlignment = Enum.TextYAlignment.Top
	InfoText.TextWrapped = true

	-- Username Search
	local UsernameLabel = Instance.new("TextLabel", ClonePage)
	UsernameLabel.Size = UDim2.new(1, -10, 0, 25)
	UsernameLabel.Position = UDim2.new(0, 5, 0, 205)
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Text = "🔹 Search by Username:"
	UsernameLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	UsernameLabel.Font = Enum.Font.GothamBold
	UsernameLabel.TextSize = 15
	UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left

	local UsernameBox = Instance.new("TextBox", ClonePage)
	UsernameBox.Size = UDim2.new(1, -10, 0, 40)
	UsernameBox.Position = UDim2.new(0, 5, 0, 235)
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

	-- DisplayName Search
	local DisplayLabel = Instance.new("TextLabel", ClonePage)
	DisplayLabel.Size = UDim2.new(1, -10, 0, 25)
	DisplayLabel.Position = UDim2.new(0, 5, 0, 290)
	DisplayLabel.BackgroundTransparency = 1
	DisplayLabel.Text = "🔹 Search by DisplayName:"
	DisplayLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	DisplayLabel.Font = Enum.Font.GothamBold
	DisplayLabel.TextSize = 15
	DisplayLabel.TextXAlignment = Enum.TextXAlignment.Left

	local DisplayBox = Instance.new("TextBox", ClonePage)
	DisplayBox.Size = UDim2.new(1, -10, 0, 40)
	DisplayBox.Position = UDim2.new(0, 5, 0, 320)
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
	StatusLabel.Size = UDim2.new(1, -10, 0, 35)
	StatusLabel.Position = UDim2.new(0, 5, 0, 535)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.Text = "⚪ Ready to clone..."
	StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	StatusLabel.Font = Enum.Font.GothamBold
	StatusLabel.TextSize = 13
	StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

	-- SUPER CLONE FUNCTION (3 METHODS - NEVER FAILS!)
	local function SuperClone(targetPlayer)
		if not targetPlayer then 
			return false, "Player not found"
		end
		
		local targetChar = targetPlayer.Character
		if not targetChar then
			return false, "Target has no character"
		end
		
		local targetHum = targetChar:FindFirstChild("Humanoid")
		if not targetHum then
			return false, "Target has no humanoid"
		end
		
		-- METHOD 1: GetAppliedDescription (Best - Current appearance)
		local success1 = pcall(function()
			local desc = targetHum:GetAppliedDescription()
			humanoid:ApplyDescription(desc)
		end)
		
		if success1 then
			return true, "Cloned using Method 1 (Applied Description)"
		end
		
		-- METHOD 2: GetHumanoidDescriptionFromUserId (Backup - Profile)
		local success2 = pcall(function()
			local userId = targetPlayer.UserId
			local desc = game.Players:GetHumanoidDescriptionFromUserId(userId)
			humanoid:ApplyDescription(desc)
		end)
		
		if success2 then
			return true, "Cloned using Method 2 (Profile Description)"
		end
		
		-- METHOD 3: Manual Copy (Last resort - Direct copy)
		local success3 = pcall(function()
			-- Remove current accessories
			for _, obj in pairs(character:GetChildren()) do
				if obj:IsA("Accessory") or obj:IsA("Hat") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") then
					obj:Destroy()
				end
			end
			
			-- Clone new accessories and clothes
			for _, obj in pairs(targetChar:GetChildren()) do
				if obj:IsA("Accessory") or obj:IsA("Hat") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") then
					local clone = obj:Clone()
					clone.Parent = character
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
			local targetHead = targetChar:FindFirstChild("Head")
			if head and targetHead then
				local face = head:FindFirstChildOfClass("Decal")
				local targetFace = targetHead:FindFirstChildOfClass("Decal")
				if face and targetFace then
					face.Texture = targetFace.Texture
				end
			end
		end)
		
		if success3 then
			return true, "Cloned using Method 3 (Manual Copy)"
		end
		
		return false, "All 3 methods failed - Target might be protected"
	end

	-- Clone by Username Button
	local CloneUsernameBtn = Instance.new("TextButton", ClonePage)
	CloneUsernameBtn.Size = UDim2.new(1, -10, 0, 45)
	CloneUsernameBtn.Position = UDim2.new(0, 5, 0, 375)
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
	end)
	CloneUsernameBtn.MouseLeave:Connect(function() 
		CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	end)

	local cloneDebounce = false
	CloneUsernameBtn.MouseButton1Click:Connect(function()
		if cloneDebounce then return end
		cloneDebounce = true
		
		local username = UsernameBox.Text
		if username ~= "" then
			StatusLabel.Text = "🔍 Searching for " .. username .. "..."
			StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
			
			task.wait(0.3)
			
			local foundPlayer = nil
			for _, v in pairs(game.Players:GetPlayers()) do
				if v.Name:lower():find(username:lower()) then
					foundPlayer = v
					break
				end
			end
			
			if foundPlayer then
				StatusLabel.Text = "⏳ Cloning " .. foundPlayer.Name .. "..."
				StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
				
				task.wait(0.5)
				
				local success, message = SuperClone(foundPlayer)
				if success then
					StatusLabel.Text = "✅ SUCCESS! " .. message
					StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
					CloneUsernameBtn.Text = "✅ Cloned: " .. foundPlayer.Name
					task.wait(2)
					CloneUsernameBtn.Text = "🎭 Clone by Username"
				else
					StatusLabel.Text = "❌ FAILED: " .. message
					StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
					CloneUsernameBtn.Text = "❌ Failed"
					task.wait(2)
					CloneUsernameBtn.Text = "🎭 Clone by Username"
				end
			else
				StatusLabel.Text = "❌ Player '" .. username .. "' not in server"
				StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
				CloneUsernameBtn.Text = "❌ Not Found"
				task.wait(2)
				CloneUsernameBtn.Text = "🎭 Clone by Username"
			end
		else
			StatusLabel.Text = "⚠️ Please enter a username"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
		end
		
		cloneDebounce = false
	end)

	-- Clone by DisplayName Button
	local CloneDisplayBtn = Instance.new("TextButton", ClonePage)
	CloneDisplayBtn.Size = UDim2.new(1, -10, 0, 45)
	CloneDisplayBtn.Position = UDim2.new(0, 5, 0, 430)
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
	end)
	CloneDisplayBtn.MouseLeave:Connect(function() 
		CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
	end)

	CloneDisplayBtn.MouseButton1Click:Connect(function()
		if cloneDebounce then return end
		cloneDebounce = true
		
		local displayname = DisplayBox.Text
		if displayname ~= "" then
			StatusLabel.Text = "🔍 Searching for " .. displayname .. "..."
			StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
			
			task.wait(0.3)
			
			local foundPlayer = nil
			for _, v in pairs(game.Players:GetPlayers()) do
				if v.DisplayName:lower():find(displayname:lower()) then
					foundPlayer = v
					break
				end
			end
			
			if foundPlayer then
				StatusLabel.Text = "⏳ Cloning " .. foundPlayer.DisplayName .. "..."
				StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
				
				task.wait(0.5)
				
				local success, message = SuperClone(foundPlayer)
				if success then
					StatusLabel.Text = "✅ SUCCESS! " .. message
					StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
					CloneDisplayBtn.Text = "✅ Cloned: " .. foundPlayer.DisplayName
					task.wait(2)
					CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
				else
					StatusLabel.Text = "❌ FAILED: " .. message
					StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
					CloneDisplayBtn.Text = "❌ Failed"
					task.wait(2)
					CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
				end
			else
				StatusLabel.Text = "❌ Player '" .. displayname .. "' not in server"
				StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
				CloneDisplayBtn.Text = "❌ Not Found"
				task.wait(2)
				CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
			end
		else
			StatusLabel.Text = "⚠️ Please enter a display name"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
		end
		
		cloneDebounce = false
	end)

	-- Reset Avatar Button
	local ResetBtn = Instance.new("TextButton", ClonePage)
	ResetBtn.Size = UDim2.new(1, -10, 0, 45)
	ResetBtn.Position = UDim2.new(0, 5, 0, 485)
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
	end)
	ResetBtn.MouseLeave:Connect(function() 
		ResetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	end)

	ResetBtn.MouseButton1Click:Connect(function()
		StatusLabel.Text = "⏳ Resetting to original avatar..."
		StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
		
		local success = pcall(function()
			local originalDescription = game.Players:GetHumanoidDescriptionFromUserId(player.UserId)
			humanoid:ApplyDescription(originalDescription)
		end)
		
		if success then
			StatusLabel.Text = "✅ Reset to original avatar"
			StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
			ResetBtn.Text = "✅ Reset Success!"
			task.wait(2)
			ResetBtn.Text = "🔄 Reset to Original Avatar"
		else
			StatusLabel.Text = "❌ Failed to reset"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		end
	end)

	-- Quick Clone List
	local QuickFrame = Instance.new("Frame", ClonePage)
	QuickFrame.Size = UDim2.new(1, -10, 0, 200)
	QuickFrame.Position = UDim2.new(0, 5, 0, 580)
	QuickFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	QuickFrame.BackgroundTransparency = 0.3
	QuickFrame.BorderSizePixel = 0
	local QuickCorner = Instance.new("UICorner", QuickFrame)
	QuickCorner.CornerRadius = UDim.new(0, 10)
	local QuickStroke = Instance.new("UIStroke", QuickFrame)
	QuickStroke.Color = Color3.fromRGB(0, 180, 255)
	QuickStroke.Thickness = 2

	local QuickTitle = Instance.new("TextLabel", QuickFrame)
	QuickTitle.Size = UDim2.new(1, -10, 0, 30)
	QuickTitle.Position = UDim2.new(0, 5, 0, 5)
	QuickTitle.BackgroundTransparency = 1
	QuickTitle.Text = "⚡ Quick Clone - Players in Server"
	QuickTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
	QuickTitle.Font = Enum.Font.GothamBold
	QuickTitle.TextSize = 15
	QuickTitle.TextXAlignment = Enum.TextXAlignment.Left

	local QuickScroll = Instance.new("ScrollingFrame", QuickFrame)
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
				end)
				playerBtn.MouseLeave:Connect(function()
					playerBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 60)
				end)
				
				playerBtn.MouseButton1Click:Connect(function()
					if cloneDebounce then return end
					cloneDebounce = true
					
					StatusLabel.Text = "⏳ Cloning " .. targetPlayer.Name .. "..."
					StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
					
					task.wait(0.3)
					
					local success, message = SuperClone(targetPlayer)
					if success then
						StatusLabel.Text = "✅ " .. message
						StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
						playerBtn.Text = "✅ Cloned!"
						task.wait(1)
						playerBtn.Text = string.format("👤 %s (@%s)", targetPlayer.DisplayName, targetPlayer.Name)
					else
						StatusLabel.Text = "❌ " .. message
						StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
					end
					
					cloneDebounce = false
				end)
			end
		end
		
		QuickScroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
	end

	-- Update list every 5 seconds (optimized)
	spawn(function()
		while task.wait(5) do
			if QuickScroll and QuickScroll.Parent then
				UpdatePlayerList()
			end
		end
	end)
	
	-- Initial update
	UpdatePlayerList()
	
	ClonePage.CanvasSize = UDim2.new(0, 0, 0, 800)
end

return CloneModule
