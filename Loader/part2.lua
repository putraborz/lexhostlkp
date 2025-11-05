-- Part 2 Loader dengan Tombol Launch dan Deskripsi

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Loader Menu", "DarkTheme")

-- Main Tab
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Controls")

-- Deskripsi/Info
MainSection:NewLabel("Welcome")
MainSection:NewLabel("Version")
MainSection:NewLabel("Created")

-- Tombol Launch
MainSection:NewButton("Launch Script", "Click to launch the main script", function()
    print("Launching script...")
    
    -- Masukkan script utama Anda di sini
    loadstring(game:HttpGet("https://raw.githubusercontent.com/putraborz/lexhostlkp/main/main.lua"))()
    
    -- Atau gunakan kode custom Anda
    game.StarterGui:SetCore("SendNotification", {
        Title = "Script Loaded";
        Text = "Script berhasil dijalankan!";
        Duration = 3;
    })
end)

-- Tombol Dex Explorer (untuk debugging)
MainSection:NewButton("Open Dex Explorer", "Buka Dex untuk explore game", function()
    print("Opening Dex Explorer...")
    
    -- Load Dex Explorer
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Dex Opened";
        Text = "Dex Explorer telah dibuka!";
        Duration = 3;
    })
end)

-- Credits Section
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Information")

CreditsSection:NewLabel("Script")
CreditsSection:NewLabel("UII")
CreditsSection:NewLabel("Thanks for using!")

-- Close Button
MainSection:NewButton("Close Menu", "Tutup UI", function()
    Library:ToggleUI()
end)
