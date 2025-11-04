--[[
    Fisch Auto Farm Configuration
    AUTO RUNNING VERSION
]]

_G.FischConfig = {
    -- Main Features (true = AUTO START saat script load)
    AutoCast = true,        -- ✅ Langsung jalan saat load
    AutoReel = true,        -- ✅ Langsung jalan saat load
    AutoShake = true,       -- ✅ Auto shake saat reel
    AutoSell = false,       -- ❌ Disabled by default (bahaya kalo teleport)
    
    -- Performance Settings
    CastPower = 100,        -- Power lempar (0-100)
    Delay = 0.5,            -- Delay antar aksi
    
    -- Extra Features
    AntiAFK = true,         -- Anti kick AFK
    
    -- Advanced
    Debug = false,
}

return _G.FischConfig
