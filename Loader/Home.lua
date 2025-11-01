-- Home.lua
local HomeModule = {}

function HomeModule.Initialize(HomePage)
	local HomeTitle = Instance.new("TextLabel", HomePage)
	HomeTitle.BackgroundTransparency = 1
	HomeTitle.Size = UDim2.new(1, 0, 0, 40)
	HomeTitle.Font = Enum.Font.GothamBold
	HomeTitle.Text = "Welcome to LEX Host v3 Vip Edition"
	HomeTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
	HomeTitle.TextSize = 20

	local HomeDesc = Instance.new("TextLabel", HomePage)
	HomeDesc.BackgroundTransparency = 1
	HomeDesc.Position = UDim2.new(0, 0, 0, 50)
	HomeDesc.Size = UDim2.new(1, 0, 0, 200)
	HomeDesc.Font = Enum.Font.Gotham
	HomeDesc.Text = "Premium Exploit GUI\n\n✓ Multiple Game Modes\n✓ Movement Scripts\n✓ Teleport Features\n✓ Player Utilities\n✓ Copy Avatar\n\nSelect a tab to begin!"
	HomeDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
	HomeDesc.TextSize = 14
	HomeDesc.TextYAlignment = Enum.TextYAlignment.Top
end

return HomeModule
