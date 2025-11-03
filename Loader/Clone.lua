-- Clone.lua - Full Clone Version (Fixed Loading Issue)
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
	CloneDesc.Text = "Clone SEMUA aspek: Accessories, Clothing, Colors, Face & More"
	CloneDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
	CloneDesc.Font = Enum.Font.Gotham
	CloneDesc.TextSize = 14
	CloneDesc.TextXAlignment = Enum.TextXAlignment.Left

	-- FULL CLONE FUNCTION - FIXED!
	local function clonePlayerAppearance(targetPlayer)
		if not targetPlayer then 
			return false, "Player not found"
		end
		
		if not player.Character then
			return false, "Your character not found"
		end
		
		-- Wait for target character to load
		local targetChar = targetPlayer.Character
		if not targetChar then
			targetPlayer.CharacterAdded:Wait()
			targetChar = targetPlayer.Character
			wait(1) -- Extra wait for full load
		end
		
		local myChar = player.Character
		
		-- Wait for humanoids
		local targetHumanoid = targetChar:WaitForChild("Humanoid", 5)
		local myHumanoid = myChar:WaitForChild("Humanoid", 5)
		
		if not targetHumanoid or not myHumanoid then
			return false, "Humanoid not found"
		end
		
		-- METHOD 1: HumanoidDescription (Primary)
		local success1 = pcall(function()
			local desc = targetHumanoid:GetAppliedDescription()
			myHumanoid:ApplyDescription(desc)
		end)
		
		wait(0.3)
		
		-- METHOD 2: Manual Clone (Comprehensive Backup)
		local success2 = pcall(function()
			-- Remove old accessories
			for _, obj in pairs(myChar:GetChildren()) do
				if obj:IsA("Accessory") or obj:IsA("Hat") then
					obj:Destroy()
				end
			end
			
			wait(0.1)
			
			-- Clone all accessories
			for _, obj in pairs(targetChar:GetChildren()) do
				if obj:IsA("Accessory") or obj:IsA("Hat") then
					local clone = obj:Clone()
					clone.Parent = myChar
				end
			end
			
			-- Remove old clothing
			for _, obj in pairs(myChar:GetChildren()) do
				if obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") then
					obj:Destroy()
				end
			end
			
			wait(0.1)
			
			-- Clone clothing
			for _, obj in pairs(targetChar:GetChildren()) do
				if obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") then
					obj:Clone().Parent = myChar
				end
			end
			
			-- Clone body colors
			local myBodyColors = myChar:FindFirstChild("Body Colors")
			local targetBodyColors = targetChar:FindFirstChild("Body Colors")
			
			if targetBodyColors then
				if not myBodyColors then
					myBodyColors = Instance.new("BodyColors")
					myBodyColors.Parent = myChar
				end
				myBodyColors.HeadColor = targetBodyColors.HeadColor
				myBodyColors.TorsoColor = targetBodyColors.TorsoColor
				myBodyColors.LeftArmColor = targetBodyColors.LeftArmColor
				myBodyColors.RightArmColor = targetBodyColors.RightArmColor
				myBodyColors.LeftLegColor = targetBodyColors.LeftLegColor
				myBodyColors.RightLegColor = targetBodyColors.RightLegColor
			end
			
			-- Clone face
			local myHead = myChar:FindFirstChild("Head")
			local targetHead = targetChar:FindFirstChild("Head")
			
			if myHead and targetHead then
				-- Remove old face
				for _, decal in pairs(myHead:GetChildren()) do
					if decal:IsA("Decal") then
						decal:Destroy()
					end
				end
				
				-- Clone new face
				for _, decal in pairs(targetHead:GetChildren()) do
					if decal:IsA("Decal") then
						decal:Clone().Parent = myHead
					end
				end
			end
			
			-- Clone body part colors
			for _, part in pairs(targetChar:GetChildren()) do
				if part:IsA("BasePart") then
					local myPart = myChar:FindFirstChild(part.Name)
					if myPart and myPart:IsA("BasePart") then
						pcall(function()
							myPart.BrickColor = part.BrickColor
						end)
					end
				end
			end
		end)
		
		if success1 or success2 then
			return true, "Clone Success!"
		else
			return false, "Clone failed"
		end
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
	PlayerListFrame.Size = UDim2.new(1, -10, 0, 250)
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
	PlayerListLayout.Padding = UDim.new(0, 3)

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
				playerBtn.Size = UDim2.new(1, -10, 0, 40)
				playerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
				playerBtn.BorderSizePixel = 0
				
				local displayText = plr.DisplayName
				if plr.DisplayName ~= plr.Name then
					displayText = plr.DisplayName .. " (@" .. plr.Name .. ")"
				end
				playerBtn.Text = displayText
				
				playerBtn.Font = Enum.Font.GothamBold
				playerBtn.TextSize = 14
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
					
					spawn(function()
						wait(0.2)
						local success, reason = clonePlayerAppearance(plr)
						
						if success then
							playerBtn.Text = "✅ Cloned!"
							playerBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
						else
							playerBtn.Text = "❌ " .. tostring(reason)
							playerBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
						end
						
						wait(1.5)
						playerBtn.Text = displayText
						playerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
					end)
				end)
				
				table.insert(playerButtons, playerBtn)
				totalHeight = totalHeight + 43
			end
		end
		
		PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
	end

	-- Initial player list
	updatePlayerList()

	-- Update list when players join/leave
	game.Players.PlayerAdded:Connect(function()
		wait(1)
		updatePlayerList()
	end)
	
	game.Players.PlayerRemoving:Connect(function()
		wait(0.5)
		updatePlayerList()
	end)

	-- Refresh Button
	local RefreshBtn = Instance.new("TextButton", ClonePage)
	RefreshBtn.Size = UDim2.new(1, -10, 0, 40)
	RefreshBtn.Position = UDim2.new(0, 5, 0, 395)
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
		RefreshBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
		updatePlayerList()
		wait(0.5)
		RefreshBtn.Text = "✅ Refreshed!"
		RefreshBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		wait(1)
		RefreshBtn.Text = "🔄 Refresh Player List"
		RefreshBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
	end)
	
	-- Info Label
	local InfoLabel = Instance.new("TextLabel", ClonePage)
	InfoLabel.Size = UDim2.new(1, -10, 0, 50)
	InfoLabel.Position = UDim2.new(0, 5, 0, 450)
	InfoLabel.BackgroundTransparency = 1
	InfoLabel.Text = "💡 Tip: Clone akan meng-copy SEMUA accessories, clothing, colors & face dari target player."
	InfoLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
	InfoLabel.Font = Enum.Font.Gotham
	InfoLabel.TextSize = 12
	InfoLabel.TextWrapped = true
	InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
	InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
end

return CloneModule
