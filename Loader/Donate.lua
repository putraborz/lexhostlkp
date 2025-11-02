-- Donate.lua - Fake Donate Module
local DonateModule = {}

function DonateModule.Initialize(DonatePage)
	
	local Title = Instance.new("TextLabel", DonatePage)
	Title.Size = UDim2.new(1, -10, 0, 40)
	Title.Position = UDim2.new(0, 5, 0, 10)
	Title.BackgroundTransparency = 1
	Title.Text = "💰 Fake Donate"
	Title.TextColor3 = Color3.fromRGB(0, 220, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 20
	Title.TextXAlignment = Enum.TextXAlignment.Left

	local Desc = Instance.new("TextLabel", DonatePage)
	Desc.Size = UDim2.new(1, -10, 0, 30)
	Desc.Position = UDim2.new(0, 5, 0, 55)
	Desc.BackgroundTransparency = 1
	Desc.Text = "Fake donation notifications (CLIENT SIDE ONLY)"
	Desc.TextColor3 = Color3.fromRGB(150, 200, 255)
	Desc.Font = Enum.Font.Gotham
	Desc.TextSize = 14
	Desc.TextXAlignment = Enum.TextXAlignment.Left

	-- Launch Button
	local LaunchBtn = Instance.new("TextButton", DonatePage)
	LaunchBtn.Size = UDim2.new(1, -10, 0, 60)
	LaunchBtn.Position = UDim2.new(0, 5, 0, 100)
	LaunchBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	LaunchBtn.Text = "💰 Launch Fake Donate GUI"
	LaunchBtn.Font = Enum.Font.GothamBold
	LaunchBtn.TextSize = 18
	LaunchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	LaunchBtn.BorderSizePixel = 0
	local LaunchCorner = Instance.new("UICorner", LaunchBtn)
	LaunchCorner.CornerRadius = UDim.new(0, 12)
	LaunchBtn.MouseEnter:Connect(function() LaunchBtn.BackgroundColor3 = Color3.fromRGB(0, 240, 120) end)
	LaunchBtn.MouseLeave:Connect(function() LaunchBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100) end)

	LaunchBtn.MouseButton1Click:Connect(function()
		LaunchBtn.Text = "⏳ Loading..."
		LaunchBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
		
		local success, err = pcall(function()
			loadstring(game:HttpGet("https://protected-roblox-scripts.onrender.com/1014ed3c29bfbfde67c540dd0902da66"))()
		end)
		
		if success then
			LaunchBtn.Text = "✅ GUI Loaded!"
			LaunchBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		else
			LaunchBtn.Text = "❌ Failed to Load"
			LaunchBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
			warn("Fake Donate Error: " .. tostring(err))
		end
		
		wait(2)
		LaunchBtn.Text = "💰 Launch Fake Donate GUI"
		LaunchBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	end)

	-- Info Section
	local InfoFrame = Instance.new("Frame", DonatePage)
	InfoFrame.Size = UDim2.new(1, -10, 0, 80)
	InfoFrame.Position = UDim2.new(0, 5, 0, 175)
	InfoFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	InfoFrame.BorderSizePixel = 0
	local InfoCorner = Instance.new("UICorner", InfoFrame)
	InfoCorner.CornerRadius = UDim.new(0, 10)
	local InfoStroke = Instance.new("UIStroke", InfoFrame)
	InfoStroke.Color = Color3.fromRGB(0, 160, 255)
	InfoStroke.Thickness = 2

	local InfoText = Instance.new("TextLabel", InfoFrame)
	InfoText.Size = UDim2.new(1, -10, 1, -10)
	InfoText.Position = UDim2.new(0, 5, 0, 5)
	InfoText.BackgroundTransparency = 1
	InfoText.Text = "⚠️ IMPORTANT:\n\n• This is CLIENT SIDE ONLY\n• Only YOU can see the fake donations\n• Other players cannot see it\n• For pranking/trolling purposes only"
	InfoText.TextColor3 = Color3.fromRGB(255, 200, 100)
	InfoText.Font = Enum.Font.Gotham
	InfoText.TextSize = 13
	InfoText.TextWrapped = true
	InfoText.TextXAlignment = Enum.TextXAlignment.Left
	InfoText.TextYAlignment = Enum.TextYAlignment.Top
end

return DonateModule
