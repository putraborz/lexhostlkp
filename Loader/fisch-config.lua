--[[
    Fisch Auto Farm Configuration
    Edit settings here
]]

_G.FischConfig = {
    -- Main Settings
    AutoFish = true,
    AutoCast = true,
    AutoReel = true,
    AutoShake = true,
    AutoSell = false,
    
    -- Performance Settings
    CastPower = 100,        -- 0-100
    Delay = 0.5,            -- Delay between actions (seconds)
    SafeMode = true,        -- Reduces detection risk
    
    -- Extra Settings
    AntiAFK = true,
    AutoEquip = true,
    Notifications = true,
    
    -- Advanced (Don't change unless you know what you're doing)
    Debug = false,
    WebhookURL = "",        -- Discord webhook for notifications
}

return _G.FischConfig
