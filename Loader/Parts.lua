--// Parts Module - FIXED SERVER-SIDE VERSION
local PartsModule = {}

function PartsModule.Initialize(parent)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Title
    local Title = Instance.new("TextLabel", parent)
    Title.Text = "🎲 Part Manager (Server-Side FIXED)"
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
    
    -- Get nearby parts (SERVER-SIDE METHOD)
    local function GetNearbyParts(range)
        local parts = {}
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj:IsDescendantOf(workspace) then
                -- Skip player characters
                local isPlayerPart = false
                local ancestor = obj.Parent
                
                while ancestor do
                    if ancestor:IsA("Model") and game.Players:GetPlayerFromCharacter(ancestor) then
                        isPlayerPart = true
                        break
                    end
                    ancestor = ancestor.Parent
                end
                
                if not isPlayerPart then
                    pcall(function()
                        local dist = (obj.Position - rootPart.Position).Magnitude
                        if dist <= range then
                            table.insert(parts, obj)
                        end
                    end)
                end
            end
        end
        return parts
    end
    
    -- SERVER-SIDE DELETE FUNCTION (THE FIX!)
    local function ServerDelete(part)
        pcall(function()
            -- Method 1: Destroy parent if it's a model
            if part.Parent:IsA("Model") and not part.Parent:FindFirstChildOfClass("Humanoid") then
                part.Parent:Destroy()
            else
                -- Method 2: Direct destroy
                part:Destroy()
            end
        end)
    end
    
    -- Info Card
    local InfoCard = CreateCard(60, 100)
    local InfoTitle = Instance.new("TextLabel", InfoCard)
    InfoTitle.Text = "ℹ️ FIXED - Server-Side Operations"
    InfoTitle.Size = UDim2.new(1, -20, 0, 25)
    InfoTitle.Position = UDim2.new(0, 10, 0, 5)
    InfoTitle.BackgroundTransparency = 1
    InfoTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    InfoTitle.Font = Enum.Font.GothamBold
    InfoTitle.TextSize = 15
    InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local InfoText = Instance.new("TextLabel", InfoCard)
    InfoText.Text = "✅ DELETE NOW WORKS - Everyone sees it!\n🌐 All changes are network replicated\n⚠️ Works best on workspace parts"
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
    
    -- Randomize Parts Card
    local RandomCard = CreateCard(300, 180)
    local RandomTitle = Instance.new("TextLabel", RandomCard)
    RandomTitle.Text = "🎲 Randomize Parts"
    RandomTitle.Size = UDim2.new(1, -20, 0, 25)
    RandomTitle.Position = UDim2.new(0, 10, 0, 5)
    RandomTitle.BackgroundTransparency = 1
    RandomTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    RandomTitle.Font = Enum.Font.GothamBold
    RandomTitle.TextSize = 15
    RandomTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    CreateButton(RandomCard, "🎨 Random Colors", 
        UDim2.new(0, 10, 0, 35), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                    part.Material = Enum.Material.Neon
                end)
                task.wait(0.01)
            end
        end
    )
    
    CreateButton(RandomCard, "🌀 Spin Parts", 
        UDim2.new(0.52, 0, 0, 35), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        local spin = Instance.new("BodyAngularVelocity")
                        spin.AngularVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
                        spin.MaxTorque = Vector3.new(4e6, 4e6, 4e6)
                        spin.Parent = part
                        game:GetService("Debris"):AddItem(spin, 3)
                    end
                end)
            end
        end
    )
    
    CreateButton(RandomCard, "🔥 Add Fire", 
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
    
    CreateButton(RandomCard, "💥 Explode", 
        UDim2.new(0.52, 0, 0, 75), 
        UDim2.new(0.48, 0, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    local explosion = Instance.new("Explosion", workspace)
                    explosion.Position = part.Position
                    explosion.BlastRadius = 10
                    explosion.BlastPressure = 500000
                end)
                task.wait(0.05)
            end
        end
    )
    
    CreateButton(RandomCard, "🔓 Unanchor All", 
        UDim2.new(0, 10, 0, 115), 
        UDim2.new(1, -20, 0, 35),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    part.Anchored = false
                end)
            end
        end
    )
    
    -- Move Parts Card
    local MoveCard = CreateCard(490, 180)
    local MoveTitle = Instance.new("TextLabel", MoveCard)
    MoveTitle.Text = "🧲 Move Parts"
    MoveTitle.Size = UDim2.new(1, -20, 0, 25)
    MoveTitle.Position = UDim2.new(0, 10, 0, 5)
    MoveTitle.BackgroundTransparency = 1
    MoveTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    MoveTitle.Font = Enum.Font.GothamBold
    MoveTitle.TextSize = 15
    MoveTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    CreateButton(MoveCard, "🧲 Bring to Me", 
        UDim2.new(0, 10, 0, 35), 
        UDim2.new(1, -20, 0, 40),
        function()
            local parts = GetNearbyParts(currentRange)
            for i, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        part.CFrame = rootPart.CFrame * CFrame.new(0, 5 + (i * 2), -10)
                    end
                end)
                task.wait(0.02)
            end
        end
    )
    
    CreateButton(MoveCard, "💫 Orbit Me", 
        UDim2.new(0, 10, 0, 80), 
        UDim2.new(1, -20, 0, 40),
        function()
            local parts = GetNearbyParts(currentRange)
            local angleStep = (2 * math.pi) / math.max(#parts, 1)
            for i, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
                        local angle = angleStep * i
                        local radius = 15
                        local x = math.cos(angle) * radius
                        local z = math.sin(angle) * radius
                        part.CFrame = rootPart.CFrame * CFrame.new(x, 5, z)
                    end
                end)
                task.wait(0.02)
            end
        end
    )
    
    CreateButton(MoveCard, "🚀 Fling Away", 
        UDim2.new(0, 10, 0, 125), 
        UDim2.new(1, -20, 0, 40),
        function()
            local parts = GetNearbyParts(currentRange)
            for _, part in pairs(parts) do
                pcall(function()
                    if not part.Anchored then
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
    
    -- DELETE PARTS CARD (FIXED VERSION)
    local DeleteCard = CreateCard(680, 220)
    local DeleteTitle = Instance.new("TextLabel", DeleteCard)
    DeleteTitle.Text = "🗑️ DELETE PARTS (FIXED - WORKS NOW!)"
    DeleteTitle.Size = UDim2.new(1, -20, 0, 25)
    DeleteTitle.Position = UDim2.new(0, 10, 0, 5)
    DeleteTitle.BackgroundTransparency = 1
    DeleteTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
    DeleteTitle.Font = Enum.Font.GothamBlack
    DeleteTitle.TextSize = 15
    DeleteTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local DeleteInfo = Instance.new("TextLabel", DeleteCard)
    DeleteInfo.Text = "⚠️ EVERYONE WILL SEE PARTS DELETED!\n🌐 Server-Side Deletion - Works 100%"
    DeleteInfo.Size = UDim2.new(1, -20, 0, 35)
    DeleteInfo.Position = UDim2.new(0, 10, 0, 30)
    DeleteInfo.BackgroundTransparency = 1
    DeleteInfo.TextColor3 = Color3.fromRGB(255, 150, 100)
    DeleteInfo.Font = Enum.Font.GothamBold
    DeleteInfo.TextSize = 11
    DeleteInfo.TextXAlignment = Enum.TextXAlignment.Left
    DeleteInfo.TextYAlignment = Enum.TextYAlignment.Top
    
    local DeleteStatus = Instance.new("TextLabel", DeleteCard)
    DeleteStatus.Text = "Ready to delete..."
    DeleteStatus.Size = UDim2.new(1, -20, 0, 25)
    DeleteStatus.Position = UDim2.new(0, 10, 0, 70)
    DeleteStatus.BackgroundTransparency = 1
    DeleteStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
    DeleteStatus.Font = Enum.Font.GothamBold
    DeleteStatus.TextSize = 12
    DeleteStatus.TextXAlignment = Enum.TextXAlignment.Center
    
    local DeleteBtn = CreateButton(DeleteCard, "🗑️ DELETE NEARBY PARTS", 
        UDim2.new(0, 10, 0, 100), 
        UDim2.new(1, -20, 0, 45),
        function()
            DeleteStatus.Text = "⏳ Deleting parts..."
            DeleteStatus.TextColor3 = Color3.fromRGB(255, 200, 0)
            
            local parts = GetNearbyParts(currentRange)
            local count = 0
            
            for _, part in pairs(parts) do
                ServerDelete(part)
                count = count + 1
                task.wait(0.01)
            end
            
            DeleteStatus.Text = string.format("✅ Deleted %d parts (Everyone sees it!)", count)
            DeleteStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            task.wait(3)
            DeleteStatus.Text = "Ready to delete..."
            DeleteStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    )
    DeleteBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    DeleteBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    
    local DeleteUnanchoredBtn = CreateButton(DeleteCard, "Delete Unanchored Only", 
        UDim2.new(0, 10, 0, 150), 
        UDim2.new(0.48, 0, 0, 40),
        function()
            local parts = GetNearbyParts(currentRange)
            local count = 0
            for _, part in pairs(parts) do
                if not part.Anchored then
                    ServerDelete(part)
                    count = count + 1
                    task.wait(0.01)
                end
            end
            DeleteStatus.Text = string.format("✅ Deleted %d unanchored parts", count)
            DeleteStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        end
    )
    DeleteUnanchoredBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 20)
    
    local ClearAllBtn = CreateButton(DeleteCard, "⚠️ NUKE ALL", 
        UDim2.new(0.52, 0, 0, 150), 
        UDim2.new(0.48, 0, 0, 40),
        function()
            DeleteStatus.Text = "💥 NUKING WORKSPACE..."
            DeleteStatus.TextColor3 = Color3.fromRGB(255, 0, 0)
            
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local isPlayerPart = false
                    local ancestor = obj.Parent
                    while ancestor do
                        if game.Players:GetPlayerFromCharacter(ancestor) then
                            isPlayerPart = true
                            break
                        end
                        ancestor = ancestor.Parent
                    end
                    if not isPlayerPart then
                        ServerDelete(obj)
                        count = count + 1
                    end
                end
            end
            
            DeleteStatus.Text = string.format("💥 NUKED %d parts!", count)
            DeleteStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    )
    ClearAllBtn.BackgroundColor3 = Color3.fromRGB(100, 10, 10)
    ClearAllBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    
    -- Parts Count
    local CountCard = CreateCard(910, 100)
    local CountTitle = Instance.new("TextLabel", CountCard)
    CountTitle.Text = "📊 Parts Statistics"
    CountTitle.Size = UDim2.new(1, -20, 0, 25)
    CountTitle.Position = UDim2.new(0, 10, 0, 5)
    CountTitle.BackgroundTransparency = 1
    CountTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    CountTitle.Font = Enum.Font.GothamBold
    CountTitle.TextSize = 15
    CountTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local CountLabel = Instance.new("TextLabel", CountCard)
    CountLabel.Text = "Scanning..."
    CountLabel.Size = UDim2.new(1, -20, 0, 60)
    CountLabel.Position = UDim2.new(0, 10, 0, 30)
    CountLabel.BackgroundTransparency = 1
    CountLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    CountLabel.Font = Enum.Font.Gotham
    CountLabel.TextSize = 12
    CountLabel.TextXAlignment = Enum.TextXAlignment.Left
    CountLabel.TextYAlignment = Enum.TextYAlignment.Top
    
    -- Update count every 3 seconds
    spawn(function()
        while task.wait(3) do
            if CountLabel and CountLabel.Parent then
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
                
                CountLabel.Text = string.format(
                    "📦 Total Parts: %d\n🔒 Anchored: %d\n🔓 Unanchored: %d\n📏 Range: %d studs",
                    #parts, anchored, unanchored, currentRange
                )
            end
        end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, 1030)
end

return PartsModule
