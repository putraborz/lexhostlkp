-- Server.lua - Private Server & Server Management Module (No Permission Check)
local ServerModule = {}

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

function ServerModule.Initialize(ServerPage, player)
    -- Jika player tidak diberikan, gunakan LocalPlayer
    player = player or Players.LocalPlayer
    
    local Title = Instance.new("TextLabel", ServerPage)
    Title.Size = UDim2.new(1, -10, 0, 40)
    Title.Position = UDim2.new(0, 5, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "🌐 Server Manager"
    Title.TextColor3 = Color3.fromRGB(0, 220, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Desc = Instance.new("TextLabel", ServerPage)
    Desc.Size = UDim2.new(1, -10, 0, 30)
    Desc.Position = UDim2.new(0, 5, 0, 55)
    Desc.BackgroundTransparency = 1
    Desc.Text = "Create private servers and manage game instances"
    Desc.TextColor3 = Color3.fromRGB(150, 200, 255)
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 14
    Desc.TextXAlignment = Enum.TextXAlignment.Left

    -- Create Private Server Section
    local PrivateLabel = Instance.new("TextLabel", ServerPage)
    PrivateLabel.Size = UDim2.new(1, -10, 0, 30)
    PrivateLabel.Position = UDim2.new(0, 5, 0, 100)
    PrivateLabel.BackgroundTransparency = 1
    PrivateLabel.Text = "🔒 Create Private Server"
    PrivateLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    PrivateLabel.Font = Enum.Font.GothamBold
    PrivateLabel.TextSize = 16
    PrivateLabel.TextXAlignment = Enum.TextXAlignment.Left

    local PrivateBtn = Instance.new("TextButton", ServerPage)
    PrivateBtn.Size = UDim2.new(1, -10, 0, 50)
    PrivateBtn.Position = UDim2.new(0, 5, 0, 135)
    PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    PrivateBtn.Text = "🔒 Create Private Server"
    PrivateBtn.Font = Enum.Font.GothamBold
    PrivateBtn.TextSize = 16
    PrivateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PrivateBtn.BorderSizePixel = 0
    
    local PrivateCorner = Instance.new("UICorner", PrivateBtn)
    PrivateCorner.CornerRadius = UDim.new(0, 10)
    
    PrivateBtn.MouseEnter:Connect(function()
        PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240)
    end)
    
    PrivateBtn.MouseLeave:Connect(function()
        PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    end)

    --------------------------------------------------------------------
    -- CREATE PRIVATE SERVER (TANPA CEK IZIN - LANGSUNG BUAT)
    --------------------------------------------------------------------
    PrivateBtn.MouseButton1Click:Connect(function()
        PrivateBtn.Text = "⏳ Creating Server..."
        PrivateBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
        
        -- Method 1: Coba ReserveServer langsung
        local success, result = pcall(function()
            return TeleportService:ReserveServer(game.PlaceId)
        end)
        
        if success and result then
            -- Server berhasil direservasi
            PrivateBtn.Text = "✅ Server Created! Teleporting..."
            PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            wait(0.5)
            
            -- Teleport ke private server
            local teleportSuccess = pcall(function()
                TeleportService:TeleportToPrivateServer(game.PlaceId, result, {player})
            end)
            
            if teleportSuccess then
                -- Simpan access code ke clipboard jika memungkinkan
                pcall(function()
                    setclipboard("Private Server Code: " .. result)
                end)
                
                -- Notifikasi sukses
                pcall(function()
                    StarterGui:SetCore("SendNotification", {
                        Title = "Success!",
                        Text = "Private Server Created! Code copied to clipboard",
                        Duration = 5
                    })
                end)
            else
                -- Jika teleport gagal, coba alternatif
                PrivateBtn.Text = "⏳ Trying Alternative..."
                wait(0.5)
                
                -- Method 2: Coba dengan TeleportAsync
                local altSuccess = pcall(function()
                    local options = Instance.new("TeleportOptions")
                    options.ServerInstanceId = result
                    options.ShouldReserveServer = true
                    TeleportService:TeleportAsync(game.PlaceId, {player}, options)
                end)
                
                if not altSuccess then
                    PrivateBtn.Text = "❌ Teleport Failed"
                    PrivateBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
                    wait(2)
                end
            end
        else
            -- Jika ReserveServer gagal, coba method alternatif
            PrivateBtn.Text = "⏳ Trying Alternative Method..."
            PrivateBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
            wait(0.5)
            
            -- Method 3: Coba dengan TeleportOptions
            local altSuccess2 = pcall(function()
                local options = Instance.new("TeleportOptions")
                options.ShouldReserveServer = true
                TeleportService:TeleportAsync(game.PlaceId, {player}, options)
            end)
            
            if altSuccess2 then
                PrivateBtn.Text = "✅ Success!"
                PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            else
                -- Method 4: Coba tanpa reservasi (buat server baru)
                local finalSuccess = pcall(function()
                    TeleportService:Teleport(game.PlaceId, player, nil, nil)
                end)
                
                if finalSuccess then
                    PrivateBtn.Text = "✅ New Server Created!"
                    PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                else
                    PrivateBtn.Text = "❌ Failed (Game may not support)"
                    PrivateBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
                    
                    pcall(function()
                        StarterGui:SetCore("SendNotification", {
                            Title = "Error",
                            Text = "This game may not support private servers",
                            Duration = 5
                        })
                    end)
                end
            end
        end
        
        -- Reset button setelah 3 detik
        wait(3)
        PrivateBtn.Text = "🔒 Create Private Server"
        PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    end)

    -- Server Info Section
    local InfoLabel = Instance.new("TextLabel", ServerPage)
    InfoLabel.Size = UDim2.new(1, -10, 0, 30)
    InfoLabel.Position = UDim2.new(0, 5, 0, 205)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "📊 Server Information"
    InfoLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    InfoLabel.Font = Enum.Font.GothamBold
    InfoLabel.TextSize = 16
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Left

    local InfoFrame = Instance.new("Frame", ServerPage)
    InfoFrame.Size = UDim2.new(1, -10, 0, 145)
    InfoFrame.Position = UDim2.new(0, 5, 0, 240)
    InfoFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
    InfoFrame.BorderSizePixel = 0
    local InfoCorner = Instance.new("UICorner", InfoFrame)
    InfoCorner.CornerRadius = UDim.new(0, 10)
    local InfoStroke = Instance.new("UIStroke", InfoFrame)
    InfoStroke.Color = Color3.fromRGB(0, 160, 255)
    InfoStroke.Thickness = 2

    local PlaceIdLabel = Instance.new("TextLabel", InfoFrame)
    PlaceIdLabel.Size = UDim2.new(1, -10, 0, 25)
    PlaceIdLabel.Position = UDim2.new(0, 5, 0, 5)
    PlaceIdLabel.BackgroundTransparency = 1
    PlaceIdLabel.Text = "Place ID: " .. game.PlaceId
    PlaceIdLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
    PlaceIdLabel.Font = Enum.Font.Gotham
    PlaceIdLabel.TextSize = 13
    PlaceIdLabel.TextXAlignment = Enum.TextXAlignment.Left

    local JobIdLabel = Instance.new("TextLabel", InfoFrame)
    JobIdLabel.Size = UDim2.new(1, -10, 0, 25)
    JobIdLabel.Position = UDim2.new(0, 5, 0, 35)
    JobIdLabel.BackgroundTransparency = 1
    JobIdLabel.Text = "Job ID: " .. game.JobId
    JobIdLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
    JobIdLabel.Font = Enum.Font.Gotham
    JobIdLabel.TextSize = 13
    JobIdLabel.TextXAlignment = Enum.TextXAlignment.Left

    local PlayersLabel = Instance.new("TextLabel", InfoFrame)
    PlayersLabel.Size = UDim2.new(1, -10, 0, 25)
    PlayersLabel.Position = UDim2.new(0, 5, 0, 65)
    PlayersLabel.BackgroundTransparency = 1
    PlayersLabel.Text = "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
    PlayersLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
    PlayersLabel.Font = Enum.Font.Gotham
    PlayersLabel.TextSize = 13
    PlayersLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ServerTypeLabel = Instance.new("TextLabel", InfoFrame)
    ServerTypeLabel.Size = UDim2.new(1, -10, 0, 25)
    ServerTypeLabel.Position = UDim2.new(0, 5, 0, 95)
    ServerTypeLabel.BackgroundTransparency = 1
    local isPrivate = game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0
    ServerTypeLabel.Text = "Server Type: " .. (isPrivate and "Private 🔒" or "Public 🌐")
    ServerTypeLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
    ServerTypeLabel.Font = Enum.Font.Gotham
    ServerTypeLabel.TextSize = 13
    ServerTypeLabel.TextXAlignment = Enum.TextXAlignment.Left

    local GameNameLabel = Instance.new("TextLabel", InfoFrame)
    GameNameLabel.Size = UDim2.new(1, -10, 0, 25)
    GameNameLabel.Position = UDim2.new(0, 5, 0, 120)
    GameNameLabel.BackgroundTransparency = 1
    
    local gameName = "Unknown"
    pcall(function()
        gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    
    GameNameLabel.Text = "Game: " .. gameName
    GameNameLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
    GameNameLabel.Font = Enum.Font.Gotham
    GameNameLabel.TextSize = 13
    GameNameLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Update player count
    Players.PlayerAdded:Connect(function()
        PlayersLabel.Text = "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
    end)
    
    Players.PlayerRemoving:Connect(function()
        wait(0.1)
        PlayersLabel.Text = "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
    end)

    -- Copy Job ID Button
    local CopyJobBtn = Instance.new("TextButton", ServerPage)
    CopyJobBtn.Size = UDim2.new(0.48, -5, 0, 45)
    CopyJobBtn.Position = UDim2.new(0, 5, 0, 400)
    CopyJobBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    CopyJobBtn.Text = "📋 Copy Job ID"
    CopyJobBtn.Font = Enum.Font.GothamBold
    CopyJobBtn.TextSize = 14
    CopyJobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyJobBtn.BorderSizePixel = 0
    
    local CopyJobCorner = Instance.new("UICorner", CopyJobBtn)
    CopyJobCorner.CornerRadius = UDim.new(0, 10)
    
    CopyJobBtn.MouseEnter:Connect(function()
        CopyJobBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 240)
    end)
    
    CopyJobBtn.MouseLeave:Connect(function()
        CopyJobBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    end)

    CopyJobBtn.MouseButton1Click:Connect(function()
        local success = pcall(function()
            setclipboard(game.JobId)
        end)
        
        if success then
            CopyJobBtn.Text = "✅ Copied!"
            CopyJobBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            CopyJobBtn.Text = "❌ Failed"
            CopyJobBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        end
        
        wait(2)
        CopyJobBtn.Text = "📋 Copy Job ID"
        CopyJobBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    end)

    -- Copy Place ID Button
    local CopyPlaceBtn = Instance.new("TextButton", ServerPage)
    CopyPlaceBtn.Size = UDim2.new(0.48, -5, 0, 45)
    CopyPlaceBtn.Position = UDim2.new(0.52, 5, 0, 400)
    CopyPlaceBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    CopyPlaceBtn.Text = "📋 Copy Place ID"
    CopyPlaceBtn.Font = Enum.Font.GothamBold
    CopyPlaceBtn.TextSize = 14
    CopyPlaceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyPlaceBtn.BorderSizePixel = 0
    
    local CopyPlaceCorner = Instance.new("UICorner", CopyPlaceBtn)
    CopyPlaceCorner.CornerRadius = UDim.new(0, 10)
    
    CopyPlaceBtn.MouseEnter:Connect(function()
        CopyPlaceBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 240)
    end)
    
    CopyPlaceBtn.MouseLeave:Connect(function()
        CopyPlaceBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    end)

    CopyPlaceBtn.MouseButton1Click:Connect(function()
        local success = pcall(function()
            setclipboard(tostring(game.PlaceId))
        end)
        
        if success then
            CopyPlaceBtn.Text = "✅ Copied!"
            CopyPlaceBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            CopyPlaceBtn.Text = "❌ Failed"
            CopyPlaceBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        end
        
        wait(2)
        CopyPlaceBtn.Text = "📋 Copy Place ID"
        CopyPlaceBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    end)

    -- Rejoin Server Button
    local RejoinBtn = Instance.new("TextButton", ServerPage)
    RejoinBtn.Size = UDim2.new(1, -10, 0, 45)
    RejoinBtn.Position = UDim2.new(0, 5, 0, 460)
    RejoinBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    RejoinBtn.Text = "🔄 Rejoin Server"
    RejoinBtn.Font = Enum.Font.GothamBold
    RejoinBtn.TextSize = 16
    RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    RejoinBtn.BorderSizePixel = 0
    
    local RejoinCorner = Instance.new("UICorner", RejoinBtn)
    RejoinCorner.CornerRadius = UDim.new(0, 10)
    
    RejoinBtn.MouseEnter:Connect(function()
        RejoinBtn.BackgroundColor3 = Color3.fromRGB(70, 180, 70)
    end)
    
    RejoinBtn.MouseLeave:Connect(function()
        RejoinBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    end)

    RejoinBtn.MouseButton1Click:Connect(function()
        RejoinBtn.Text = "⏳ Rejoining..."
        RejoinBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
        wait(0.5)
        
        local success = pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
        end)
        
        if not success then
            -- Try alternative rejoin
            pcall(function()
                TeleportService:Teleport(game.PlaceId, player)
            end)
        end
    end)

    -- Server Hop Button
    local ServerHopBtn = Instance.new("TextButton", ServerPage)
    ServerHopBtn.Size = UDim2.new(1, -10, 0, 45)
    ServerHopBtn.Position = UDim2.new(0, 5, 0, 520)
    ServerHopBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    ServerHopBtn.Text = "🌍 Server Hop (Random)"
    ServerHopBtn.Font = Enum.Font.GothamBold
    ServerHopBtn.TextSize = 16
    ServerHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ServerHopBtn.BorderSizePixel = 0
    
    local ServerHopCorner = Instance.new("UICorner", ServerHopBtn)
    ServerHopCorner.CornerRadius = UDim.new(0, 10)
    
    ServerHopBtn.MouseEnter:Connect(function()
        ServerHopBtn.BackgroundColor3 = Color3.fromRGB(240, 120, 0)
    end)
    
    ServerHopBtn.MouseLeave:Connect(function()
        ServerHopBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    end)

    ServerHopBtn.MouseButton1Click:Connect(function()
        ServerHopBtn.Text = "⏳ Finding Server..."
        ServerHopBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
        
        local success, servers = pcall(function()
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            return HttpService:JSONDecode(game:HttpGet(url))
        end)
        
        if success and servers and servers.data then
            local serverList = {}
            for _, server in pairs(servers.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(serverList, server.id)
                end
            end
            
            if #serverList > 0 then
                local randomServer = serverList[math.random(1, #serverList)]
                ServerHopBtn.Text = "✅ Teleporting..."
                ServerHopBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                wait(0.5)
                
                pcall(function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, player)
                end)
            else
                -- Jika tidak ada server, buat server baru
                ServerHopBtn.Text = "📍 Creating New Server..."
                ServerHopBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
                wait(0.5)
                
                pcall(function()
                    TeleportService:Teleport(game.PlaceId, player)
                end)
            end
        else
            -- Fallback: teleport ke server random
            pcall(function()
                TeleportService:Teleport(game.PlaceId, player)
            end)
        end
    end)
end

return ServerModule
