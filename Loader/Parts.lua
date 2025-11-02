-- Parts.lua - Parts Management Module (Enhanced)
local PartsModule = {}

function PartsModule.Initialize(PartsPage, player, character)
	
	local Title = Instance.new("TextLabel", PartsPage)
	Title.Size = UDim2.new(1, -10, 0, 40)
	Title.Position = UDim2.new(0, 5, 0, 10)
	Title.BackgroundTransparency = 1
	Title.Text = "🧱 Parts Tools"
	Title.TextColor3 = Color3.fromRGB(0, 220, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 20
	Title.TextXAlignment = Enum.TextXAlignment.Left

	local Desc = Instance.new("TextLabel", PartsPage)
	Desc.Size = UDim2.new(1, -10, 0, 30)
	Desc.Position = UDim2.new(0, 5, 0, 55)
	Desc.BackgroundTransparency = 1
	Desc.Text = "Advanced part manipulation tools"
	Desc.TextColor3 = Color3.fromRGB(150, 200, 255)
	Desc.Font = Enum.Font.Gotham
	Desc.TextSize = 14
	Desc.TextXAlignment = Enum.TextXAlignment.Left

	-- Unanchored Part Abuse
	local AbuseLabel = Instance.new("TextLabel", PartsPage)
	AbuseLabel.Size = UDim2.new(1, -10, 0, 30)
	AbuseLabel.Position = UDim2.new(0, 5, 0, 100)
	AbuseLabel.BackgroundTransparency = 1
	AbuseLabel.Text = "⚡ Unanchored Part Control"
	AbuseLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	AbuseLabel.Font = Enum.Font.GothamBold
	AbuseLabel.TextSize = 16
	AbuseLabel.TextXAlignment = Enum.TextXAlignment.Left

	local AbuseBtn = Instance.new("TextButton", PartsPage)
	AbuseBtn.Size = UDim2.new(1, -10, 0, 50)
	AbuseBtn.Position = UDim2.new(0, 5, 0, 135)
	AbuseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 100)
	AbuseBtn.Text = "⚡ Launch Part Abuse GUI"
	AbuseBtn.Font = Enum.Font.GothamBold
	AbuseBtn.TextSize = 16
	AbuseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	AbuseBtn.BorderSizePixel = 0
	local AbuseCorner = Instance.new("UICorner", AbuseBtn)
	AbuseCorner.CornerRadius = UDim.new(0, 10)
	AbuseBtn.MouseEnter:Connect(function() AbuseBtn.BackgroundColor3 = Color3.fromRGB(240, 0, 120) end)
	AbuseBtn.MouseLeave:Connect(function() AbuseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 100) end)

	AbuseBtn.MouseButton1Click:Connect(function()
		AbuseBtn.Text = "⏳ Loading..."
		AbuseBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
		
		local success, err = pcall(function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Unanchored-Part-Abuse-WIP-23861"))()
		end)
		
		if success then
			AbuseBtn.Text = "✅ Loaded!"
			AbuseBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		else
			AbuseBtn.Text = "❌ Failed"
			AbuseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
			warn("Part Abuse Error: " .. tostring(err))
		end
		
		wait(2)
		AbuseBtn.Text = "⚡ Launch Part Abuse GUI"
		AbuseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 100)
	end)

	-- Text to Blocks
	local TextLabel = Instance.new("TextLabel", PartsPage)
	TextLabel.Size = UDim2.new(1, -10, 0, 30)
	TextLabel.Position = UDim2.new(0, 5, 0, 205)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = "📝 Text to Blocks"
	TextLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.TextSize = 16
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	local TextBtn = Instance.new("TextButton", PartsPage)
	TextBtn.Size = UDim2.new(1, -10, 0, 50)
	TextBtn.Position = UDim2.new(0, 5, 0, 240)
	TextBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	TextBtn.Text = "📝 Launch Text Builder"
	TextBtn.Font = Enum.Font.GothamBold
	TextBtn.TextSize = 16
	TextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBtn.BorderSizePixel = 0
	local TextCorner = Instance.new("UICorner", TextBtn)
	TextCorner.CornerRadius = UDim.new(0, 10)
	TextBtn.MouseEnter:Connect(function() TextBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240) end)
	TextBtn.MouseLeave:Connect(function() TextBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) end)

	TextBtn.MouseButton1Click:Connect(function()
		TextBtn.Text = "⏳ Loading..."
		TextBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
		
		local success, err = pcall(function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Text-to-Blocks-WIP-20736"))()
		end)
		
		if success then
			TextBtn.Text = "✅ Loaded!"
			TextBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		else
			TextBtn.Text = "❌ Failed"
			TextBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
			warn("Text to Blocks Error: " .. tostring(err))
		end
		
		wait(2)
		TextBtn.Text = "📝 Launch Text Builder"
		TextBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	end)

	-- Universal Lib
	local LibLabel = Instance.new("TextLabel", PartsPage)
	LibLabel.Size = UDim2.new(1, -10, 0, 30)
	LibLabel.Position = UDim2.new(0, 5, 0, 310)
	LibLabel.BackgroundTransparency = 1
	LibLabel.Text = "📚 Universal Library"
	LibLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	LibLabel.Font = Enum.Font.GothamBold
	LibLabel.TextSize = 16
	LibLabel.TextXAlignment = Enum.TextXAlignment.Left

	local LibBtn = Instance.new("TextButton", PartsPage)
	LibBtn.Size = UDim2.new(1, -10, 0, 50)
	LibBtn.Position = UDim2.new(0, 5, 0, 345)
	LibBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
	LibBtn.Text = "📚 Load Universal Lib"
	LibBtn.Font = Enum.Font.GothamBold
	LibBtn.TextSize = 16
	LibBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	LibBtn.BorderSizePixel = 0
	local LibCorner = Instance.new("UICorner", LibBtn)
	LibCorner.CornerRadius = UDim.new(0, 10)
	LibBtn.MouseEnter:Connect(function() LibBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 240) end)
	LibBtn.MouseLeave:Connect(function() LibBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200) end)

	LibBtn.MouseButton1Click:Connect(function()
		LibBtn.Text = "⏳ Loading..."
		LibBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
		
		local success, err = pcall(function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Lib-18698"))()
		end)
		
		if success then
			LibBtn.Text = "✅ Loaded!"
			LibBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		else
			LibBtn.Text = "❌ Failed"
			LibBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
			warn("Universal Lib Error: " .. tostring(err))
		end
		
		wait(2)
		LibBtn.Text = "📚 Load Universal Lib"
		LibBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
	end)

	-- Drag UI
	local DragLabel = Instance.new("TextLabel", PartsPage)
	DragLabel.Size = UDim2.new(1, -10, 0, 30)
	DragLabel.Position = UDim2.new(0, 5, 0, 415)
	DragLabel.BackgroundTransparency = 1
	DragLabel.Text = "📱 Drag UI (Mobile Support)"
	DragLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	DragLabel.Font = Enum.Font.GothamBold
	DragLabel.TextSize = 16
	DragLabel.TextXAlignment = Enum.TextXAlignment.Left

	local DragBtn = Instance.new("TextButton", PartsPage)
	DragBtn.Size = UDim2.new(1, -10, 0, 50)
	DragBtn.Position = UDim2.new(0, 5, 0, 450)
	DragBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
	DragBtn.Text = "📱 Launch Drag UI"
	DragBtn.Font = Enum.Font.GothamBold
	DragBtn.TextSize = 16
	DragBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	DragBtn.BorderSizePixel = 0
	local DragCorner = Instance.new("UICorner", DragBtn)
	DragCorner.CornerRadius = UDim.new(0, 10)
	DragBtn.MouseEnter:Connect(function() DragBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 120) end)
	DragBtn.MouseLeave:Connect(function() DragBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100) end)

	DragBtn.MouseButton1Click:Connect(function()
		DragBtn.Text = "⏳ Loading..."
		DragBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
		
		local success, err = pcall(function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Drag-UI-SUPPORTS-MOBILE-22790"))()
		end)
		
		if success then
			DragBtn.Text = "✅ Loaded!"
			DragBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		else
			DragBtn.Text = "❌ Failed"
			DragBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
			warn("Drag UI Error: " .. tostring(err))
		end
		
		wait(2)
		DragBtn.Text = "📱 Launch Drag UI"
		DragBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
	end)

	-- Info Section
	local InfoLabel = Instance.new("TextLabel", PartsPage)
	InfoLabel.Size = UDim2.new(1, -10, 0, 60)
	InfoLabel.Position = UDim2.new(0, 5, 0, 520)
	InfoLabel.BackgroundTransparency = 1
	InfoLabel.Text = "💡 Tip: These are advanced part manipulation tools. Use with caution!"
	InfoLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
	InfoLabel.Font = Enum.Font.Gotham
	InfoLabel.TextSize = 13
	InfoLabel.TextWrapped = true
	InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
	InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
end

return PartsModule
