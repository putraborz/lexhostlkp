--// Parts Module - Part Manager
local PartsModule = {}

function PartsModule.Initialize(parent)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Title
    local Title = Instance.new("TextLabel", parent)
    Title.Text = "🎲 Part Manager"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(0, 220, 255)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 22
    
    -- Helper Functions
    local function CreateCard(yPos, height)
        local card = Instance.new("Frame", parent)
        card.Size = UDim2.new(1, -20, 0, height)
        card.Position = UDim2.new(0, 10, 0, yPos)
        card.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
        card.BackgroundTransparency = 0.3
        card.BorderSizePixel = 0
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
        local stroke = Instance.new("UIStroke", card)
        stroke.Color = Color3.fromRGB(0, 180, 255)
        stroke.Thickness = 2
        return card
    end
    
    local function CreateButton(parent, text, position, size, callback)
        local btn = Instance.new("TextButton", parent)
        btn.Text = text
        btn.Size = size
        btn.Position = position
        btn.BackgroundColor3 = Color3.fromRGB(15, 30, 60)
        btn.TextColor3 = Color3.fromRGB(0, 220, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(0, 200, 255)
        stroke.Thickness = 2
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(25, 50, 90)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(15, 30, 60)
        end)
        
        if callback then
            btn.MouseButton1Click:Connect(callback)
        end
        
        return btn
    end
    
    -- Get nearby parts
    local function GetNearbyParts(range)
        local parts = {}
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= character and not obj.Parent:FindFirstChild("Humanoid") then
                local dist = (obj.Position - rootPart.Position).Magnitude
                if dist <= range then
                    table.insert(parts, obj)
                end
            end
        end
        return parts
    end
    
    -- Info Card
    local InfoCard = CreateCard(60, 80)
    local InfoTitle = Instance.new("TextLabel", InfoCard)
    InfoTitle.Text = "ℹ️ Part Controls"
    InfoTitle.Size = UDim2.new(1, -20, 0, 25)
    InfoTitle.Position = UDim2.new(0, 10, 0, 5)
    InfoTitle.BackgroundTransparency = 1
    InfoTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    InfoTitle.Font = Enum.Font.GothamBold
    InfoTitle.TextSize = 15
    InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local InfoText = Instance.new("TextLabel", InfoCard)
    InfoText.Text = "Manipulate parts around you: randomize, steal, delete, and more!"
    InfoText.Size = UDim2.new(1, -20, 0, 40)
    InfoText.Position = UDim2.new(0, 10, 0, 30)
    InfoText.BackgroundTransparency = 1
    InfoText.TextColor3 = Color3.fromRGB(150, 200, 255)
    InfoText.Font = Enum.Font.Gotham
    InfoText.TextSize = 11
    InfoText.TextXAlignment = Enum.TextXAlignment.Left
    InfoText.TextYAlignment = Enum.TextYAlignment.Top
    InfoText.TextWrapped = true
    
    -- Range Settings
    local RangeCard = CreateCard(150, 120)
    local RangeTitle = Instance.new("TextLabel", RangeCard)
    RangeTitle.Text = "📏 Range Settings"
    RangeTitle.Size = UDim2.new(1, -20, 0, 25)
    RangeTitle.Position = UDim2.new(0, 10, 0, 5)
    RangeTitle.BackgroundTransparency = 1
    RangeTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    RangeTitle.Font = Enum.Font.GothamBold
    RangeTitle.TextSize = 15
    RangeTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local RangeLabel = Instance.new("TextLabel", RangeCard)
    RangeLabel.Text = "Current Range: 50 studs"
    RangeLabel.Size = UDim2.new(1, -20, 0, 25)
    RangeLabel.Position = UDim2.new(0, 10, 0, 35)
    RangeLabel.BackgroundTransparency = 1
    RangeLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    RangeLabel.Font = Enum.Font.Gotham
    RangeLabel.TextSize = 12
    RangeLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local RangeBox = Instance.new("TextBox", RangeCard)
    RangeBox.Size = UDim2.new(0.65, 0, 0, 40)
    RangeBox.Position = UDim2.new(0, 10, 0, 65)
    RangeBox.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    RangeBox.TextColor3 = Color3.fromRGB(0, 220, 255)
    RangeBox.PlaceholderText = "Range (10-500)"
    RangeBox.PlaceholderColor3 = Color3.fromRGB(100, 150, 200)
    RangeBox.Font = Enum.Font.Gotham
    RangeBox.TextSize = 13
    RangeBox.Text = "50"
    RangeBox.BorderSizePixel = 0
    Instance.new("UICorner", RangeBox).CornerRadius = UDim.new(0, 10)
    
    local currentRange = 50
    
    local SetRangeBtn = CreateButton(RangeCard, "Set Range", 
        UDim2.new(0.68, 0, 0, 65), 
        UDim2.new(0.28, 0, 0, 40),
        function()
            local range = tonumber(RangeBox.Text)
            if range and range >= 10 and range <= 500 then
                currentRange = range
                RangeLabel.Text = "Current Range: " .. range .. " studs"
            end
        end
    )
    
    -- Randomize Parts Card
    local RandomCard = CreateCard(280, 180)
    local RandomTitle = Instance.new("TextLabel", RandomCard)
    RandomTitle.Text = "🎲 Randomize Parts"
    RandomTitle.Size = UDim2.new(1, -20, 0, 25)
    RandomTitle.Position = UDim2.new(0, 10, 0, 5)
    RandomTitle.BackgroundTransparency = 1
    RandomTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    RandomTitle.Font = Enum.Font.GothamBold
    RandomTitle.TextSize = 15
    RandomTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local RandomInfo = Instance.new("TextLabel", RandomCard)
    RandomInfo.Text = "Randomize position, color, or size of nearby parts"
    RandomInfo.Size = UDim2.new(1, -20, 0, 20)
    RandomInfo.Position = UDim2.new(0, 10, 0, 30)
    RandomInfo.BackgroundTransparency = 1
    RandomInfo.TextColor3 = Color3.fromRGB(150, 200, 255)
    RandomInfo.Font = Enum.Font.Gotham
    RandomInfo.TextSize = 11
    RandomInfo.TextXAlignment = Enum.TextXAlignment.Left
    
    CreateButton(RandomCard, "🎨 Random Colors", 
        UDim2.new(0, 10, 0, 55), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                if part.Anchored == false or part.Anchored == true then
                    part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                end
            end
        end
    )
    
    CreateButton(RandomCard, "📐 Random Sizes", 
        UDim2.new(0.52, 0, 0, 55), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                if part.Anchored == false then
                    local scale = math.random(5, 20) / 10
                    part.Size = part.Size * scale
                end
            end
        end
    )
    
    CreateButton(RandomCard, "🌀 Random Positions", 
        UDim2.new(0, 10, 0, 95), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                if part.Anchored == false then
                    part.Position = part.Position + Vector3.new(
                        math.random(-10, 10),
                        math.random(-10, 10),
                        math.random(-10, 10)
                    )
                end
            end
        end
    )
    
    CreateButton(RandomCard, "🎰 Random All", 
        UDim2.new(0.52, 0, 0, 95), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                if part.Anchored == false then
                    local scale = math.random(5, 20) / 10
                    part.Size = part.Size * scale
                    part.Position = part.Position + Vector3.new(
                        math.random(-10, 10),
                        math.random(-10, 10),
                        math.random(-10, 10)
                    )
                end
            end
        end
    )
    
    CreateButton(RandomCard, "🔄 Reset All", 
        UDim2.new(0, 10, 0, 135), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                part.Transparency = 0
                part.Reflectance = 0
                part.Material = Enum.Material.Plastic
            end
        end
    )
    
    -- Steal/Bring Parts Card
    local StealCard = CreateCard(470, 180)
    local StealTitle = Instance.new("TextLabel", StealCard)
    StealTitle.Text = "🧲 Steal/Move Parts"
    StealTitle.Size = UDim2.new(1, -20, 0, 25)
    StealTitle.Position = UDim2.new(0, 10, 0, 5)
    StealTitle.BackgroundTransparency = 1
    StealTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    StealTitle.Font = Enum.Font.GothamBold
    StealTitle.TextSize = 15
    StealTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local StealInfo = Instance.new("TextLabel", StealCard)
    StealInfo.Text = "Bring parts to you or send them away"
    StealInfo.Size = UDim2.new(1, -20, 0, 20)
    StealInfo.Position = UDim2.new(0, 10, 0, 30)
    StealInfo.BackgroundTransparency = 1
    StealInfo.TextColor3 = Color3.fromRGB(150, 200, 255)
    StealInfo.Font = Enum.Font.Gotham
    StealInfo.TextSize = 11
    StealInfo.TextXAlignment = Enum.TextXAlignment.Left
    
    CreateButton(StealCard, "🧲 Bring All To Me", 
        UDim2.new(0, 10, 0, 55), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for i, part in pairs(parts) do
                if part.Anchored == false then
                    part.CFrame = rootPart.CFrame * CFrame.new(0, 5 + (i * 2), -5)
                end
            end
        end
    )
    
    CreateButton(StealCard, "💫 Orbit Around Me", 
        UDim2.new(0, 10, 0, 95), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            local angleStep = (2 * math.pi) / #parts
            for i, part in pairs(parts) do
                if part.Anchored == false then
                    local angle = angleStep * i
                    local radius = 10
                    local x = math.cos(angle) * radius
                    local z = math.sin(angle) * radius
                    part.CFrame = rootPart.CFrame * CFrame.new(x, 5, z)
                end
            end
        end
    )
    
    CreateButton(StealCard, "🚀 Fling Away", 
        UDim2.new(0, 10, 0, 135), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                if part.Anchored == false then
                    local velocity = Instance.new("BodyVelocity", part)
                    velocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    velocity.Velocity = (part.Position - rootPart.Position).Unit * 100
                    game:GetService("Debris"):AddItem(velocity, 0.5)
                end
            end
        end
    )
    
    -- Delete Parts Card
    local DeleteCard = CreateCard(660, 140)
    local DeleteTitle = Instance.new("TextLabel", DeleteCard)
    DeleteTitle.Text = "🗑️ Delete Parts"
    DeleteTitle.Size = UDim2.new(1, -20, 0, 25)
    DeleteTitle.Position = UDim2.new(0, 10, 0, 5)
    DeleteTitle.BackgroundTransparency = 1
    DeleteTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    DeleteTitle.Font = Enum.Font.GothamBold
    DeleteTitle.TextSize = 15
    DeleteTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local DeleteInfo = Instance.new("TextLabel", DeleteCard)
    DeleteInfo.Text = "⚠️ Warning: This will permanently delete parts!"
    DeleteInfo.Size = UDim2.new(1, -20, 0, 20)
    DeleteInfo.Position = UDim2.new(0, 10, 0, 30)
    DeleteInfo.BackgroundTransparency = 1
    DeleteInfo.TextColor3 = Color3.fromRGB(255, 150, 100)
    DeleteInfo.Font = Enum.Font.GothamBold
    DeleteInfo.TextSize = 11
    DeleteInfo.TextXAlignment = Enum.TextXAlignment.Left
    
    local DeleteBtn = CreateButton(DeleteCard, "🗑️ Delete Nearby Parts", 
        UDim2.new(0, 10, 0, 55), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                part:Destroy()
            end
        end
    )
    DeleteBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    DeleteBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    
    local DeleteUnanchoredBtn = CreateButton(DeleteCard, "Delete Unanchored", 
        UDim2.new(0.52, 0, 0, 55), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                if part.Anchored == false then
                    part:Destroy()
                end
            end
        end
    )
    DeleteUnanchoredBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 20)
    DeleteUnanchoredBtn.TextColor3 = Color3.fromRGB(255, 150, 100)
    
    local ClearWorkspaceBtn = CreateButton(DeleteCard, "⚠️ CLEAR ENTIRE WORKSPACE", 
        UDim2.new(0, 10, 0, 95), 
        UDim2.new(1, -20, 0, 35),
        function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Parent ~= character and not obj.Parent:FindFirstChild("Humanoid") then
                    obj:Destroy()
                end
            end
        end
    )
    ClearWorkspaceBtn.BackgroundColor3 = Color3.fromRGB(80, 10, 10)
    ClearWorkspaceBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    
    -- Part Effects Card
    local EffectsCard = CreateCard(810, 180)
    local EffectsTitle = Instance.new("TextLabel", EffectsCard)
    EffectsTitle.Text = "✨ Part Effects"
    EffectsTitle.Size = UDim2.new(1, -20, 0, 25)
    EffectsTitle.Position = UDim2.new(0, 10, 0, 5)
    EffectsTitle.BackgroundTransparency = 1
    EffectsTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    EffectsTitle.Font = Enum.Font.GothamBold
    EffectsTitle.TextSize = 15
    EffectsTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    CreateButton(EffectsCard, "💎 Make Neon", 
        UDim2.new(0, 10, 0, 35), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                part.Material = Enum.Material.Neon
            end
        end
    )
    
    CreateButton(EffectsCard, "✨ Make Glass", 
        UDim2.new(0.52, 0, 0, 35), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                part.Material = Enum.Material.Glass
                part.Transparency = 0.5
            end
        end
    )
    
    CreateButton(EffectsCard, "👻 Make Invisible", 
        UDim2.new(0, 10, 0, 75), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                part.Transparency = 1
            end
        end
    )
    
    CreateButton(EffectsCard, "👁️ Make Visible", 
        UDim2.new(0.52, 0, 0, 75), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                part.Transparency = 0
            end
        end
    )
    
    CreateButton(EffectsCard, "🔥 Add Fire", 
        UDim2.new(0, 10, 0, 115), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                if not part:FindFirstChild("Fire") then
                    Instance.new("Fire", part)
                end
            end
        end
    )
    
    CreateButton(EffectsCard, "💨 Add Smoke", 
        UDim2.new(0.52, 0, 0, 115), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                if not part:FindFirstChild("Smoke") then
                    Instance.new("Smoke", part)
                end
            end
        end
    )
    
    -- Parts List Card
    local ListCard = CreateCard(1000, 150)
    local ListTitle = Instance.new("TextLabel", ListCard)
    ListTitle.Text = "📋 Nearby Parts List"
    ListTitle.Size = UDim2.new(1, -20, 0, 25)
    ListTitle.Position = UDim2.new(0, 10, 0, 5)
    ListTitle.BackgroundTransparency = 1
    ListTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    ListTitle.Font = Enum.Font.GothamBold
    ListTitle.TextSize = 15
    ListTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local PartCountLabel = Instance.new("TextLabel", ListCard)
    PartCountLabel.Text = "Parts in range: 0"
    PartCountLabel.Size = UDim2.new(1, -20, 0, 20)
    PartCountLabel.Position = UDim2.new(0, 10, 0, 30)
    PartCountLabel.BackgroundTransparency = 1
    PartCountLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    PartCountLabel.Font = Enum.Font.Gotham
    PartCountLabel.TextSize = 12
    PartCountLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local PartsScroll = Instance.new("ScrollingFrame", ListCard)
    PartsScroll.Size = UDim2.new(1, -20, 0, 85)
    PartsScroll.Position = UDim2.new(0, 10, 0, 55)
    PartsScroll.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    PartsScroll.BackgroundTransparency = 0.5
    PartsScroll.BorderSizePixel = 0
    PartsScroll.ScrollBarThickness = 4
    PartsScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
    PartsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Instance.new("UICorner", PartsScroll).CornerRadius = UDim.new(0, 8)
    
    local UIList = Instance.new("UIListLayout", PartsScroll)
    UIList.Padding = UDim.new(0, 2)
    UIList.FillDirection = Enum.FillDirection.Vertical
    
    -- Update parts list
    spawn(function()
        while wait(2) do
            PartsScroll:ClearAllChildren()
            UIList = Instance.new("UIListLayout", PartsScroll)
            UIList.Padding = UDim.new(0, 2)
            
            local parts = GetNearbyParts(currentRange)
            PartCountLabel.Text = string.format("Parts in range: %d", #parts)
            
            for i, part in pairs(parts) do
                if i <= 50 then -- Limit to 50 for performance
                    local dist = (part.Position - rootPart.Position).Magnitude
                    local label = Instance.new("TextLabel", PartsScroll)
                    label.Text = string.format("• %s (%.1fm)", part.Name, dist)
                    label.Size = UDim2.new(1, 0, 0, 20)
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.fromRGB(180, 200, 255)
                    label.Font = Enum.Font.Gotham
                    label.TextSize = 10
                    label.TextXAlignment = Enum.TextXAlignment.Left
                    label.TextTruncate = Enum.TextTruncate.AtEnd
                end
            end
            
            PartsScroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
        end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, 1170)
end

return PartsModule
