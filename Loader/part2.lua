-- Script untuk bagian (Part) tombol Launch
local part = Instance.new("Part")
part.Name = "LaunchButton"
part.Size = Vector3.new(4, 1, 4) -- Ukuran tombol
part.Position = Vector3.new(0, 5, 0) -- Posisi tombol di workspace
part.Anchored = true
part.CanCollide = false
part.BrickColor = BrickColor.new("Bright green") -- Warna hijau
part.Parent = workspace

-- Menambahkan ClickDetector ke tombol
local clickDetector = Instance.new("ClickDetector")
clickDetector.Parent = part

-- Script untuk menangani klik tombol
local script = Instance.new("Script")
script.Source = [[
local part = script.Parent
local clickDetector = part:FindFirstChild("ClickDetector")

clickDetector.MouseClick:Connect(function(player)
    -- URL yang akan dimuat
    local url = "https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau"
    
    -- Menggunakan pcall untuk menangani error
    local success, code = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and code then
        -- Memuat dan menjalankan kode dari URL
        local success2, result = pcall(function()
            loadstring(code)()
        end)
        
        if not success2 then
            warn("Error executing loaded code: " .. result)
        end
    else
        warn("Failed to fetch code from URL: " .. (code or "unknown error"))
    end
end)
]]
script.Parent = part
