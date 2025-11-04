local ServerModule = {}

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

function ServerModule.Initialize(ServerPage, player)
    -- Gunakan localplayer jika tidak tersedia
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
    Instance.new("UICorner", PrivateBtn).CornerRadius = UDim.new(0, 10)

    PrivateBtn.MouseEnter:Connect(function()
        PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240)
    end)

    PrivateBtn.MouseLeave:Connect(function()
        PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    end)

    --------------------------------------------------------------------
    -- ✅ FIXED: CREATE PRIVATE SERVER WITH NO FALLBACK
    --------------------------------------------------------------------
    PrivateBtn.MouseButton1Click:Connect(function()
        PrivateBtn.Text = "⏳ Creating Private Server..."
        PrivateBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)

        local success, reservedServerCode = pcall(function()
            return TeleportService:ReserveServer(game.PlaceId)
        end)

        if success and reservedServerCode then
            PrivateBtn.Text = "✅ Teleporting..."
            PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

            wait(0.5) -- Delay before teleport

            local successTeleport = pcall(function()
                TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, { player })
            end)

            if successTeleport then
                pcall(function()
                    setclipboard("Private Server Code: " .. reservedServerCode)
                end)

                pcall(function()
                    StarterGui:SetCore("SendNotification", {
                        Title = "Success!",
                        Text = "Private Server Created! Code copied to clipboard.",
                        Duration = 5
                    })
                end)
            else
                PrivateBtn.Text = "❌ Teleport Failed"
                PrivateBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

                pcall(function()
                    StarterGui:SetCore("SendNotification", {
                        Title = "Error",
                        Text = "Failed to teleport to the private server.",
                        Duration = 5
                    })
                end)
            end
        else
            PrivateBtn.Text = "❌ Server Reserve Failed"
            PrivateBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "Error",
                    Text = "Could not reserve a private server. Game may not support it.",
                    Duration = 5
                })
            end)
        end

        wait(3)
        PrivateBtn.Text = "🔒 Create Private Server"
        PrivateBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    end)

    -- ❯ Server Info (tidak diubah)
    -- ❯ Copy Job ID
    -- ❯ Copy Place ID
    -- ❯ Rejoin
    -- ❯ Server Hop
    -- Semua bagian lainnya tetap sama sesuai dengan struktur sebelumnya
    -- (silakan tempel lanjutannya dari versi original milikmu setelah bagian ini)
end

return ServerModule
