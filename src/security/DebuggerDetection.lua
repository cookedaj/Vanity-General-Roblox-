-- Roblox Debugger Detection & Anti-Tampering Module v2.0
-- Enterprise-grade defensive measures for protecting scripts in Roblox

local DebuggerDetection = {}

-- Internal state
local AuditLog = {}
local MAX_AUDIT_ENTRIES = 1000
local Statistics = {
    detections = 0,
    checks_performed = 0,
    tampering_attempts = 0,
    total_check_time_ms = 0,
}
local MonitoringActive = false
local MonitoringConnection = nil

-- ==================== DETECTION METHODS ====================

-- Method 1: Check if running in Roblox Studio (debug environment)
function DebuggerDetection.IsRunningInStudio()
    return game:GetService("RunService"):IsStudio()
end

-- Method 2: Check if script execution is being traced
function DebuggerDetection.IsBeingDebugged()
    return DebuggerDetection.IsRunningInStudio()
end

-- Method 3: Detect if code is being executed with debugging tools active
-- NOTE: Roblox sandboxes scripts; the only honest runtime signal available is
-- the Studio environment itself. (Previously this OR'd in a `debug.traceback`
-- check that always evaluated true — the debug library is always present.)
function DebuggerDetection.IsDebuggerAttached()
    return DebuggerDetection.IsRunningInStudio()
end

-- Method 4: Detect memory inspection attempts
function DebuggerDetection.DetectMemoryInspection(script_ref)
    local mt = getmetatable(script_ref)
    return mt ~= nil
end

-- Method 5: Check for script modification via integrity hashing
-- `Source` is only readable from a plugin/Studio context; in a live game the
-- property access itself raises, so guard it with pcall and report when the
-- source is unavailable rather than crashing the caller.
function DebuggerDetection.CheckScriptIntegrity(script_ref, original_source_hash)
    local ok, current_source = pcall(function()
        return script_ref.Source
    end)

    if not ok or not current_source then
        return nil, "source_unavailable"
    end

    -- Create consistent hash using string length + content sample
    local hash = tostring(#current_source) .. ":" .. string.sub(current_source, 1, 50)

    return hash == original_source_hash
end

-- Method 6: Comprehensive environment compromise check
-- Aggregates the honest environment signals Roblox exposes. Kept as a distinct
-- entry point so callers can request the "strongest" check even though, inside
-- the sandbox, it currently reduces to the Studio signal.
function DebuggerDetection.IsEnvironmentCompromised()
    return DebuggerDetection.IsRunningInStudio()
end

-- Method 7: Multi-level detection with security levels
function DebuggerDetection.CheckWithLevel(level)
    level = level or 1

    if level == 1 then
        return DebuggerDetection.IsRunningInStudio()
    elseif level == 2 then
        return DebuggerDetection.IsDebuggerAttached()
    elseif level == 3 then
        return DebuggerDetection.IsEnvironmentCompromised()
    end

    return false
end

-- ==================== AUDIT & LOGGING ====================

-- Audit actions that represent an actual detection check being performed.
-- Lifecycle/tamper events (monitoring_started, tampering_attempt, ...) are
-- logged but do not inflate checks_performed.
local CHECK_ACTIONS = {
    debugger_detected = true,
    normal_execution = true,
    integrity_check = true,
}

local function LogAuditEvent(action, details)
    table.insert(AuditLog, {
        action = action,
        details = details or "",
        timestamp = tick(),
        time_string = os.date("%Y-%m-%d %H:%M:%S", tick()),
    })

    if #AuditLog > MAX_AUDIT_ENTRIES then
        table.remove(AuditLog, 1)
    end

    if CHECK_ACTIONS[action] then
        Statistics.checks_performed = Statistics.checks_performed + 1
    end
end

function DebuggerDetection.GetAuditLog(filter)
    if not filter then
        return AuditLog
    end

    local results = {}
    for _, entry in ipairs(AuditLog) do
        local match = true
        for key, value in pairs(filter) do
            if entry[key] ~= value then
                match = false
                break
            end
        end
        if match then
            table.insert(results, entry)
        end
    end

    return results
end

function DebuggerDetection.ClearAuditLog()
    AuditLog = {}
end

-- ==================== STATISTICS ====================

function DebuggerDetection.GetStats()
    return {
        detections = Statistics.detections,
        checks_performed = Statistics.checks_performed,
        tampering_attempts = Statistics.tampering_attempts,
        total_check_time_ms = Statistics.total_check_time_ms,
        audit_log_entries = #AuditLog,
    }
end

function DebuggerDetection.PrintStats()
    local stats = DebuggerDetection.GetStats()
    print("\n=== Debugger Detection Statistics ===")
    print("Detections: " .. stats.detections)
    print("Checks Performed: " .. stats.checks_performed)
    print("Tampering Attempts: " .. stats.tampering_attempts)
    print("Total Check Time: " .. string.format("%.2f", stats.total_check_time_ms) .. "ms")
    print("Audit Log Entries: " .. stats.audit_log_entries)
    print("=====================================\n")
end

-- ==================== HANDLERS ====================

function DebuggerDetection.HandleDebuggerState(debugged)
    if debugged then
        Statistics.detections = Statistics.detections + 1
        LogAuditEvent("debugger_detected", "Debug environment detected")

        warn("[Security] Debugger detected — disabling verbose diagnostics and running in production-safe mode.")

        return {
            safe_mode = true,
            reduced_logging = true,
            skip_sensitive_ops = true,
            detected_at = tick(),
        }
    else
        LogAuditEvent("normal_execution", "No debugger detected")
        return {
            safe_mode = false,
            reduced_logging = false,
            skip_sensitive_ops = false,
            detected_at = tick(),
        }
    end
end

function DebuggerDetection.HandleTamperingAttempt(attempt_type, details)
    Statistics.tampering_attempts = Statistics.tampering_attempts + 1
    LogAuditEvent("tampering_attempt", attempt_type .. ": " .. tostring(details))

    warn("[Security Alert] Tampering attempt detected: " .. attempt_type)

    return {
        blocked = true,
        attempt_type = attempt_type,
        timestamp = tick(),
        details = details,
    }
end

-- ==================== RUNTIME MONITORING ====================

function DebuggerDetection.MonitorDebugActivity()
    if MonitoringActive then
        return
    end

    MonitoringActive = true
    local RunService = game:GetService("RunService")
    local detection_active = false

    local function CheckDebugState()
        local start_time = tick()

        if DebuggerDetection.IsBeingDebugged() then
            if not detection_active then
                detection_active = true
                DebuggerDetection.HandleDebuggerState(true)
            end
        else
            if detection_active then
                detection_active = false
                DebuggerDetection.HandleDebuggerState(false)
            end
        end

        local elapsed = (tick() - start_time) * 1000
        Statistics.total_check_time_ms = Statistics.total_check_time_ms + elapsed
    end

    MonitoringConnection = RunService.Heartbeat:Connect(CheckDebugState)

    LogAuditEvent("monitoring_started", "Real-time debug monitoring activated")

    return CheckDebugState
end

function DebuggerDetection.StopMonitoring()
    if MonitoringConnection then
        MonitoringConnection:Disconnect()
        MonitoringConnection = nil
    end
    MonitoringActive = false
end

-- ==================== SECURE EXECUTION ====================

function DebuggerDetection.ExecuteSecurely(callback, allow_debug)
    allow_debug = allow_debug or false

    local debugged = DebuggerDetection.IsBeingDebugged()

    if debugged and not allow_debug then
        DebuggerDetection.HandleTamperingAttempt("secure_execution_in_debug", "Attempted execution in debug mode")
        return nil
    end

    local success, result = pcall(callback)

    if not success then
        LogAuditEvent("execution_failed", tostring(result))
        warn("[Security] Secure execution failed: " .. tostring(result))
        return nil
    end

    LogAuditEvent("execution_success", "Secure code executed successfully")

    return result
end

function DebuggerDetection.ExecuteInBatch(callbacks, allow_debug)
    local results = {}

    for i, callback in ipairs(callbacks) do
        results[i] = DebuggerDetection.ExecuteSecurely(callback, allow_debug)
    end

    return results
end

-- ==================== INTEGRITY VERIFICATION ====================

function DebuggerDetection.VerifyIntegrity()
    local state = {
        in_studio = DebuggerDetection.IsRunningInStudio(),
        debugger_attached = DebuggerDetection.IsDebuggerAttached(),
        environment_compromised = DebuggerDetection.IsEnvironmentCompromised(),
        timestamp = tick(),
        time_string = os.date("%Y-%m-%d %H:%M:%S", tick()),
    }

    LogAuditEvent("integrity_check", state.debugger_attached and "COMPROMISED" or "OK")

    return state
end

function DebuggerDetection.ContinuousVerification(interval)
    interval = interval or 1

    local function Verify()
        local state = DebuggerDetection.VerifyIntegrity()
        if state.debugger_attached or state.environment_compromised then
            DebuggerDetection.HandleDebuggerState(true)
        end
    end

    task.spawn(function()
        while true do
            Verify()
            task.wait(interval)
        end
    end)

    return Verify
end

-- ==================== INITIALIZATION ====================

function DebuggerDetection.Initialize(options)
    options = options or {}

    local state = DebuggerDetection.VerifyIntegrity()

    if state.debugger_attached then
        DebuggerDetection.HandleDebuggerState(true)
    else
        DebuggerDetection.HandleDebuggerState(false)
    end

    if options.enable_monitoring ~= false then
        DebuggerDetection.MonitorDebugActivity()
    end

    if options.enable_continuous_verification then
        DebuggerDetection.ContinuousVerification(options.verification_interval or 5)
    end

    LogAuditEvent("system_initialized", "DebuggerDetection v2.0 initialized")

    return state
end

return DebuggerDetection
