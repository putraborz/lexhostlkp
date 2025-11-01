-- Info.lua
local InfoModule = {}

function InfoModule.Initialize(InfoPage)
	local InfoTitle = Instance.new("TextLabel", InfoPage)
	InfoTitle.BackgroundTransparency = 1
	InfoTitle.Size = UDim2.new(1, 0, 0, 40)
	InfoTitle.Font = Enum.Font.GothamBold
	InfoTitle.Text = "About LEX Host v3"
	InfoTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
	InfoTitle.TextSize = 20

	local InfoText = Instance.new("TextLabel", InfoPage)
	InfoText.BackgroundTransparency = 1
	InfoText.Position = UDim2.new(0, 0, 0, 50)
	InfoText.Size = UDim2.new(1, 0, 0, 250)
	InfoText.Font = Enum.Font.Gotham
	InfoText.Text = [[Version: 3.0
Made by: LEX Dev

Features:
- Multiple game modes
- Auto Walk
- Advanced movement controls
- Player teleportation
- Copy Avatar
- ESP & FullBright
- Noclip & Fly
- Customizable speeds

Credits:
LEX Development Team

Thank you for using LEX Host!]]
	InfoText.TextColor3 = Color3.fromRGB(150, 200, 255)
	InfoText.TextSize = 14
	InfoText.TextYAlignment = Enum.TextYAlignment.Top
end

return InfoModule
