-- Modes.lua
-- Upload file ini ke GitHub repository kamu

local ModesModule = {}

function ModesModule.Initialize(ModesPage)
	local Gunung = {
		"ATIN NEW","YAHAYUK NEW","WKSPEDISI ANTARTIKA NEW","MOUNT YNTKTS NEW",
		"SAKAHAYNG","STECU NEW","BALI HOT EXPEDITION","MOUNT KOMANG",
		"MOUNT PRAMBANAN","MOUNT MONO","MOUNT SUMBING","MOUNT GEMI","MOUNT KOHARU",
		"MOUNT GATAULAH","MOUNT YAREU","MOUNT RUNIA","MOUNT FREESTYLE","MOUNT WASABI",
		"KOTA BUKAN GUNUNG","MOUNT BAGEN DAH","MOUNT RAGON","MOUNT YAUDAH DEH"
	}

	for i, name in ipairs(Gunung) do
		local btn = Instance.new("TextButton", ModesPage)
		btn.Size = UDim2.new(1, -10, 0, 35)
		btn.Position = UDim2.new(0, 5, 0, (i - 1) * 40)
		btn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
		btn.Text = name
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 14
		btn.TextColor3 = Color3.fromRGB(0, 190, 255)
		local s = Instance.new("UIStroke", btn)
		s.Color = Color3.fromRGB(0, 160, 255)
		s.Thickness = 1
		Instance.new("UICorner", btn)
		
		btn.MouseButton1Click:Connect(function()
			local ids = {
				["ATIN NEW"]="iw5xHtvD",["YAHAYUK NEW"]="UK8nspn0",
				["WKSPEDISI ANTARTIKA NEW"]="mqEjFxVj",["MOUNT YNTKTS NEW"]="k0bc5h4m",
				["SAKAHAYNG"]="zishUBsB",["STECU NEW"]="VdUnM88V",
				["BALI HOT EXPEDITION"]="e82WGJas",["MOUNT KOMANG"]="QYcyGtMR",
				["MOUNT PRAMBANAN"]="GysqQgpx",["MOUNT MONO"]="Ha8qwDeB",
				["MOUNT SUMBING"]="FqQwFJLe",["MOUNT GEMI"]="516Y0aw1",
				["MOUNT KOHARU"]="Rs6hy7xx",
				["MOUNT GATAULAH"]="mHKk8MWt",
				["MOUNT YAREU"]="9UQvZUD0",
				["MOUNT RUNIA"]="4EdbphD2",
				["MOUNT FREESTYLE"]="psau2RQS",
				["MOUNT WASABI"]="havaSrhe",
				["KOTA BUKAN GUNUNG"]="ExbeHa2g",
				["MOUNT BAGEN DAH"]="sJpbmQnx",
				["MOUNT RAGON"]="18ybUNsa",
				["MOUNT YAUDAH DEH"]="fYYZu2sG"
			}
			loadstring(game:HttpGet("https://pastebin.com/raw/"..ids[name]))()
		end)
	end
end

return ModesModule
