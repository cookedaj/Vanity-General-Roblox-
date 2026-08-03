# DebuggerDetection v2.0 - Anti-Tampering Guide

## Overview
DebuggerDetection v2.0 provides defensive measures for protecting scripts in Roblox:
- **Environment detection** (Studio / debug environment checks)
- **Real-time monitoring** for runtime debug attempts
- **Audit logging** for all security events
- **Statistics tracking** for security analytics
- **Secure execution** wrappers for sensitive code
- **Batch operations** for multiple checks
- **Integrity verification** for script protection

> **Honest capability note:** Roblox sandboxes scripts heavily, and the only
> runtime debugger signal this implementation can actually observe is the
> Roblox Studio environment itself (`RunService:IsStudio()`). All three
> detection levels — `IsBeingDebugged()`, `IsDebuggerAttached()`, and
> `IsEnvironmentCompromised()` — currently reduce to that single check, as the
> module's own comments admit. Treat this as Studio detection plus an
> audit/secure-execution framework, not as a real debugger detector.

## Core Features

### 1. Detection Levels

```lua
local DD = require(script.Parent:FindFirstChild("DebuggerDetection"))

-- Level 1: Basic Studio detection
local debugged = DD.CheckWithLevel(1)

-- Level 2: Debugger attachment check (same Studio signal)
local debugged = DD.CheckWithLevel(2)

-- Level 3: Environment compromise check (same Studio signal)
local debugged = DD.CheckWithLevel(3)
```

**What the levels actually do:**
- All three levels currently call `RunService:IsStudio()` under the hood.
  They exist as separate entry points so callers can pick a "strength" today
  and get stronger checks later without changing call sites.
- There is no meaningful performance difference between levels — each is a
  single property lookup.

### 2. Individual Detection Methods

```lua
local DD = require(script:WaitForChild("DebuggerDetection"))

-- Studio / debug-environment check
print(DD.IsBeingDebugged())

-- Attached-debugger check (currently the same Studio signal)
print(DD.IsDebuggerAttached())

-- Environment compromise check (currently the same Studio signal)
print(DD.IsEnvironmentCompromised())

-- Memory inspection detection (checks whether the value has a metatable)
print(DD.DetectMemoryInspection(script))

-- Script integrity verification (Studio/plugin context only — `Source`
-- is not readable in live games; returns nil, "source_unavailable" there)
local hash = tostring(#script.Source) .. ":" .. string.sub(script.Source, 1, 50)
print(DD.CheckScriptIntegrity(script, hash))
```

### 3. Real-Time Monitoring

Monitor for debug attempts during runtime:

```lua
local DD = require(script:WaitForChild("DebuggerDetection"))

-- Start monitoring (runs every heartbeat)
DD.MonitorDebugActivity()

-- OR initialize with monitoring enabled
DD.Initialize({
    enable_monitoring = true,
})

-- The system will automatically alert and log if a debugger is attached
```

### 4. Continuous Verification

Periodically verify environment integrity:

```lua
local DD = require(script:WaitForChild("DebuggerDetection"))

-- Verify every 5 seconds
DD.Initialize({
    enable_continuous_verification = true,
    verification_interval = 5,
})

-- Manual verification
local state = DD.VerifyIntegrity()
print("Studio: " .. tostring(state.in_studio))
print("Debugger attached: " .. tostring(state.debugger_attached))
print("Environment compromised: " .. tostring(state.environment_compromised))
```

### 5. Secure Code Execution

Prevent sensitive code from running in debug mode:

```lua
local DD = require(script:WaitForChild("DebuggerDetection"))

-- Execute only if NOT debugged (default)
DD.ExecuteSecurely(function()
    print("This runs only in production mode")
    -- Your sensitive code here
end)

-- OR allow execution in debug mode
DD.ExecuteSecurely(function()
    print("This runs regardless of debug state")
end, true)  -- allow_debug = true
```

### 6. Batch Execution

Execute multiple secure operations:

```lua
local DD = require(script:WaitForChild("DebuggerDetection"))

local results = DD.ExecuteInBatch({
    function() return "Operation 1" end,
    function() return "Operation 2" end,
    function() return "Operation 3" end,
})

-- results[1], results[2], results[3] now contain return values
```

### 7. Audit Logging

Track all security-related events:

```lua
local DD = require(script:WaitForChild("DebuggerDetection"))

-- Initialize (automatically starts logging)
DD.Initialize()

-- Get all audit logs
local logs = DD.GetAuditLog()
for _, entry in ipairs(logs) do
    print(entry.action .. " @ " .. entry.time_string)
end

-- Filter audit logs
local detections = DD.GetAuditLog({
    action = "debugger_detected"
})

for _, entry in ipairs(detections) do
    print("Detection: " .. entry.details)
end

-- Clear logs when done
DD.ClearAuditLog()
```

### 8. Statistics & Monitoring

Track detection statistics:

```lua
local DD = require(script:WaitForChild("DebuggerDetection"))

DD.Initialize()

-- Later, get statistics
local stats = DD.GetStats()
print("Detections: " .. stats.detections)
print("Checks: " .. stats.checks_performed)
print("Tampering attempts: " .. stats.tampering_attempts)
print("Total check time: " .. stats.total_check_time_ms .. "ms")

-- Pretty print statistics
DD.PrintStats()
```

## Real-World Examples

### Example 1: Initialize with Full Protection

```lua
local DD = require(script.Parent:FindFirstChild("DebuggerDetection"))

-- Start with all protections active
local state = DD.Initialize({
    enable_monitoring = true,
    enable_continuous_verification = true,
    verification_interval = 10,
})

if state.debugger_attached then
    warn("Script is running in debug environment!")
else
    print("Running in production mode")
end
```

### Example 2: Protect Sensitive API Calls

```lua
local DD = require(script.Parent:FindFirstChild("DebuggerDetection"))
local HttpService = game:GetService("HttpService")

local function MakeSecureAPICall(url, data)
    return DD.ExecuteSecurely(function()
        local response = HttpService:PostAsyncWithCredentials(url, data, Enum.HttpContentType.ApplicationJson)
        return HttpService:JSONDecode(response)
    end)
end

-- This will only execute if not in debug mode
local result = MakeSecureAPICall("https://api.example.com/endpoint", {})
```

### Example 3: Conditional Feature Access

```lua
local DD = require(script.Parent:FindFirstChild("DebuggerDetection"))

local Features = {
    DatabaseAccess = not DD.IsBeingDebugged(),
    SensitiveLogging = not DD.IsBeingDebugged(),
    APIIntegration = not DD.IsEnvironmentCompromised(),
}

if Features.DatabaseAccess then
    -- Connect to production database
else
    -- Use mock/test database
end
```

### Example 4: Security Audit Report

```lua
local DD = require(script.Parent:FindFirstChild("DebuggerDetection"))

local function GenerateSecurityReport()
    print("\n=== SECURITY AUDIT REPORT ===\n")

    local state = DD.VerifyIntegrity()
    print("Environment Status:")
    print("  In Studio: " .. tostring(state.in_studio))
    print("  Debugger Attached: " .. tostring(state.debugger_attached))
    print("  Compromised: " .. tostring(state.environment_compromised))

    DD.PrintStats()

    print("Recent Security Events:")
    local recent_logs = DD.GetAuditLog()
    for i = math.max(1, #recent_logs - 9), #recent_logs do
        if recent_logs[i] then
            print("  " .. recent_logs[i].action .. " - " .. recent_logs[i].time_string)
        end
    end

    print("\n===========================\n")
end

GenerateSecurityReport()
```

### Example 5: Multi-Level Protection

Note: all three levels currently check the same Studio signal (see the
capability note above), so this is belt-and-suspenders, not three independent
checks.

```lua
local DD = require(script.Parent:FindFirstChild("DebuggerDetection"))

local function PerformSensitiveOperation()
    -- Level 1 check
    if DD.CheckWithLevel(1) then
        return nil
    end

    -- Level 2 check
    if DD.CheckWithLevel(2) then
        return nil
    end

    -- Level 3 check
    if DD.CheckWithLevel(3) then
        return nil
    end

    -- Safe to proceed
    return "Operation completed successfully"
end

local result = PerformSensitiveOperation()
```

## Best Practices

### ✅ DO

1. **Initialize early in your script**
   ```lua
   local DD = require(script:WaitForChild("DebuggerDetection"))
   DD.Initialize()
   ```

2. **Enable monitoring for continuous protection**
   ```lua
   DD.Initialize({ enable_monitoring = true })
   ```

3. **Check before executing sensitive code**
   ```lua
   if not DD.IsBeingDebugged() then
       -- Execute sensitive operation
   end
   ```

4. **Use secure execution wrappers**
   ```lua
   DD.ExecuteSecurely(function()
       -- Sensitive code
   end)
   ```

5. **Review audit logs regularly**
   ```lua
   local logs = DD.GetAuditLog()
   ```

### ❌ DON'T

1. **Don't ignore initialization**
   ```lua
   -- Bad: No protection active
   local result = SomeFunction()
   ```

2. **Don't store detection results**
   ```lua
   -- Bad: Cached result can be stale
   local cached = DD.IsBeingDebugged()
   if cached then end  -- May be inaccurate later
   ```

3. **Don't execute sensitive code without checking**
   ```lua
   -- Bad: No protection
   local apiKey = GetSecretKey()
   ```

4. **Don't disable monitoring in production**
   ```lua
   -- Bad: Turns off protection
   DD.Initialize({ enable_monitoring = false })
   ```

5. **Don't ignore audit logs**
   ```lua
   -- Bad: No visibility into security events
   DD.GetAuditLog()  -- and ignore the result
   ```

## Performance Considerations

### Detection Speed
- All checks are single property lookups (`RunService:IsStudio()`); there is
  no meaningful cost difference between levels 1, 2, and 3.
- Continuous verification runs on a `task.wait(interval)` loop, so it does
  not add per-frame work unless you use `MonitorDebugActivity()` (Heartbeat).

### Memory Usage
- Base module: ~5KB
- Per audit entry: ~200 bytes
- Statistics tracking: minimal overhead

### Optimization Tips

1. **Use one check level consistently** — since levels are equivalent today,
   pick one and keep call sites simple
   ```lua
   if DD.CheckWithLevel(1) then end
   ```

2. **Cache non-critical checks**
   ```lua
   local initial_check = DD.VerifyIntegrity()
   -- Use cached result for non-sensitive operations
   ```

3. **Clear audit log periodically**
   ```lua
   if #DD.GetAuditLog() > 1000 then
       DD.ClearAuditLog()
   end
   ```

## Troubleshooting

### Detection always returns true in Studio
This is expected behavior. Studio is a debug environment, so `IsBeingDebugged()` will always return true. Test production behavior on live servers.

### Audit log growing too large
Clear it periodically with `DD.ClearAuditLog()` or use log rotation in your monitoring system.

### Want to allow certain operations in debug mode
Use the second parameter of `ExecuteSecurely`:
```lua
DD.ExecuteSecurely(function()
    -- This runs in debug and production
end, true)  -- allow_debug = true
```

## API Reference

See inline comments in `src/security/DebuggerDetection.lua` for complete API documentation with parameters and return values.
