--// Optimizer.lua - Performance Enhancement
local Optimizer = {}

-- Throttle function - limit how often a function runs
function Optimizer.Throttle(func, delay)
    local lastRun = 0
    return function(...)
        local now = tick()
        if now - lastRun >= delay then
            lastRun = now
            return func(...)
        end
    end
end

-- Debounce function - prevent spam clicking
function Optimizer.Debounce(func, delay)
    local debouncing = false
    return function(...)
        if not debouncing then
            debouncing = true
            func(...)
            wait(delay)
            debouncing = false
        end
    end
end

-- Safe connection cleanup
function Optimizer.CleanupConnections(connectionTable)
    for _, connection in pairs(connectionTable) do
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end
end

-- Optimized GetDescendants with caching
local descendantsCache = {}
local cacheTimeout = 2 -- Cache for 2 seconds

function Optimizer.GetDescendantsCached(instance, cacheKey)
    local now = tick()
    if descendantsCache[cacheKey] and (now - descendantsCache[cacheKey].time) < cacheTimeout then
        return descendantsCache[cacheKey].data
    end
    
    local descendants = instance:GetDescendants()
    descendantsCache[cacheKey] = {
        data = descendants,
        time = now
    }
    return descendants
end

return Optimizer
