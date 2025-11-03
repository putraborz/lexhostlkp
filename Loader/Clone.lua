-- Clone.lua - Full Clone Version (Fixed)
local CloneModule = {}

function CloneModule.Initialize(ClonePage, player, character)
	
	local CloneTitle = Instance.new("TextLabel", ClonePage)
	CloneTitle.Size = UDim2.new(1, -10, 0, 40)
	CloneTitle.Position = UDim2.new(0, 5, 0, 10)
	CloneTitle.BackgroundTransparency = 1
	CloneTitle.Text = "🎭 Clone Player Avatar (Full)"
	CloneTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
	CloneTitle.Font = Enum.Font.GothamBold
	CloneTitle.TextSize = 20
	CloneTitle.TextXAlignment = Enum.TextXAlignment.Left

	local CloneDesc = Instance.new("TextLabel", ClonePage)
	CloneDesc.Size = UDim2.new(1, -10, 0, 30)
	CloneDesc.Position = UDim2.new(0, 5, 0, 55)
	CloneDesc.BackgroundTransparency = 1
	CloneDesc.Text = "Clone SEMUA aspek avatar: Accessories, Clothing, Body Colors, Face, Scales & More"
	CloneDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
	CloneDesc.Font = Enum.Font.Gotham
	CloneDesc.TextSize = 14
	CloneDesc.TextXAlignment = Enum.TextXAlignment.Left

	-- FULL CLONE FUNCTION - Clone Everything!
	local function clonePlayerAppearance(targetPlayer)
		if not targetPlayer or not targetPlayer.Character then 
			return false, "Target character not found"
		end
		
		if not player.Character then
			return false, "Your character not found"
		end
		
		local targetChar = targetPlayer.Character
		local myChar = player.Character
		
		-- PRIORITY METHOD: HumanoidDescription (Paling Lengkap & Akurat)
		local success = pcall(function()
			local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
			local myHumanoid = myChar:FindFirstChildOfClass("Humanoid")
			
			if targetHumanoid and myHumanoid then
				-- Dapatkan description lengkap dari target
				local desc = targetHumanoid:GetAppliedDescription()
				
				-- Clone SEMUA properti description
				local newDesc = Instance.new("HumanoidDescription")
				
				-- Body Parts & Scales
				newDesc.HeadScale = desc.HeadScale
				newDesc.BodyTypeScale = desc.BodyTypeScale
				newDesc.DepthScale = desc.DepthScale
				newDesc.HeightScale = desc.HeightScale
				newDesc.ProportionScale = desc.ProportionScale
				newDesc.WidthScale = desc.WidthScale
				
				-- Body Colors
				newDesc.HeadColor = desc.HeadColor
				newDesc.TorsoColor = desc.TorsoColor
				newDesc.LeftArmColor = desc.LeftArmColor
				newDesc.RightArmColor = desc.RightArmColor
				newDesc.LeftLegColor = desc.LeftLegColor
				newDesc.RightLegColor = desc.RightLegColor
				
				-- Face & Head
				newDesc.Face = desc.Face
				newDesc.Head = desc.Head
				
				-- Clothing
				newDesc.Shirt = desc.Shirt
				newDesc.Pants = desc.Pants
				newDesc.GraphicTShirt = desc.GraphicTShirt
				
				-- Body Parts (R15/R6)
				newDesc.Torso = desc.Torso
				newDesc.LeftArm = desc.LeftArm
				newDesc.RightArm = desc.RightArm
				newDesc.LeftLeg = desc.LeftLeg
				newDesc.RightLeg = desc.RightLeg
				
				-- Accessories (SEMUA!)
				newDesc.HatAccessory = desc.HatAccessory
				newDesc.HairAccessory = desc.HairAccessory
				newDesc.FaceAccessory = desc.FaceAccessory
				newDesc.NeckAccessory = desc.NeckAccessory
				newDesc.ShoulderAccessory = desc.ShoulderAccessory
				newDesc.FrontAccessory = desc.FrontAccessory
				newDesc.BackAccessory = desc.BackAccessory
				newDesc.WaistAccessory = desc.WaistAccessory
				
				-- Emotes (jika ada)
				pcall(function()
					for i = 1, 8 do
						local emote = desc:GetEmotes()[i]
						if emote then
							newDesc:SetEmotes({emote})
						end
					end
				end)
				
				-- Equipped Emotes
				pcall(function()
					for i = 1, 8 do
						local equipped = desc:GetEquippedEmotes()[i]
						if equipped then
							newDesc:SetEquippedEmotes({equipped})
						end
					end
				end)
				
				-- Animation IDs
				newDesc.ClimbAnimation = desc.ClimbAnimation
				newDesc.FallAnimation = desc.FallAnimation
				newDesc.IdleAnimation = desc.IdleAnimation
				newDesc.JumpAnimation = desc.JumpAnimation
				newDesc.RunAnimation = desc.RunAnimation
				newDesc.SwimAnimation = desc.SwimAnimation
				newDesc.WalkAnimation = desc.WalkAnimation
				
				-- Apply ke character kita
				myHumanoid:ApplyDescription(newDesc)
				
				-- Tunggu sedikit agar apply sempurna
				wait(0.5)
			end
		end)
		
		if success then
			-- TAMBAHAN: Clone manual untuk item yang mungkin terlewat
			pcall(function()
				-- Clone accessories yang mungkin belum ter-clone
				local existingAccessories = {}
				for _, acc in pairs(myChar:GetChildren()) do
					if acc:IsA("Accessory") then
						existingAccessories[acc.Name] = true
					end
				end
				
				for _, acc in pairs(targetChar:GetChildren()) do
					if acc:IsA("Accessory") and not existingAccessories[acc.Name] then
						local cloned = acc:Clone()
						cloned.Parent = myChar
					end
				end
				
				-- Clone BodyColors jika ada perbedaan
				local myBodyColors = myChar:FindFirstChild("Body Colors")
				local targetBodyColors = targetChar:FindFirstChild("Body Colors")
				
				if targetBodyColors then
					if not myBodyColors then
						myBodyColors = Instance.new("BodyColors", myChar)
					end
					myBodyColors.HeadColor = targetBodyColors.HeadColor
					myBodyColors.TorsoColor = targetBodyColors.TorsoColor
					myBodyColors.LeftArmColor = targetBodyColors.LeftArmColor
					myBodyColors.RightArmColor = targetBodyColors.RightArmColor
					myBodyColors.LeftLegColor = targetBodyColors.LeftLegColor
					myBodyColors.RightLegColor = targetBodyColors.RightLegColor
				end
				
				-- Clone shirt & pants ekstra
				for _, clothing in pairs(targetChar:GetChildren()) do
					if clothing:IsA("Shirt") or clothing:IsA("Pants") or clothing:IsA("ShirtGraphic") then
						-- Hapus yang lama
						for _, old in pairs(myChar:GetChildren()) do
							if old.ClassName == clothing.ClassName then
								old:Destroy()
							end
						end
						-- Clone yang baru
						clothing:Clone().Parent = myChar
					end
				end
				
				-- Clone face texture
				local myHead = myChar:FindFirstChild("Head")
				local targetHead = targetChar:FindFirstChild("Head")
				
				if myHead and targetHead then
					for _, decal in pairs(targetHead:GetChildren()) do
						if decal:IsA("Decal") then
							local myDecal = myHead:FindFirstChildOfClass("Decal")
							if myDecal then
								myDecal.Texture = decal.Texture
							else
								decal:Clone().Parent = myHead
							end
						end
					end
				end
				
				-- Clone body part meshes/special meshes
				for _, part in pairs(targetChar:GetChildren()) do
					if part:IsA("BasePart") then
						local myPart = myChar:FindFirstChild(part.Name)
						if myPart and myPart:IsA("BasePart") then
							-- Copy mesh jika ada
							for _, mesh in pairs(part:GetChildren()) do
								if mesh:IsA("SpecialMesh") or mesh:IsA("BlockMesh") then
									local myMesh = myPart:FindFirstChildOfClass(mesh.ClassName)
									if myMesh then
										myMesh.MeshId = mesh.MeshId
										myMesh.TextureId = mesh.TextureId
										myMesh.Scale = mesh.Scale
									end
								end
							end
							
							-- Copy warna body part
							pcall(function()
								myPart.Color = part.Color
								myPart.Material = part.Material
								myPart.Reflectance = part.Reflectance
								myPart.Transparency = part.Transparency
							end)
						end
					end
				end
			end)
			
			return true, "Full Clone Success!"
		else
			return false, "Clone failed - target may not be loaded"
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
					playerBtn.Text = "⏳ Cloning Full Avatar..."
					playerBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
					
					wait(0.3)
					local success, reason = clonePlayerAppearance(plr)
					
					if success then
						playerBtn.Text = "✅ Full Clone Success!"
						playerBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
					else
						playerBtn.Text = "❌ " .. tostring(reason)
						playerBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
					end
					
					wait(2)
					playerBtn.Text = displayText
					playerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
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
	InfoLabel.Text = "💡 Full Clone: Accessories, Clothing, Colors, Face, Scales, Animations & More!\nJika gagal, tunggu character target fully loaded."
	InfoLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
	InfoLabel.Font = Enum.Font.Gotham
	InfoLabel.TextSize = 12
	InfoLabel.TextWrapped = true
	InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
	InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
end

return CloneModule
