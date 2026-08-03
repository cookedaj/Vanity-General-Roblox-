--[[
ProtectedSecrets v1.0
Integration layer that wires DebuggerDetection into StringObfuscation.

Secrets are still encrypted/decrypted by StringObfuscation, but any operation
that would REVEAL a plaintext value (reveal / manager:get / vault:unlock /
vault:retrieve) is first gated by DebuggerDetection. When a debug environment
is detected the operation is blocked and logged as a tampering attempt, so
sensitive values are never decrypted while a debugger is watching.

By default a debug environment is Roblox Studio. Because that would also block
normal development, every entry point accepts `{ allow_in_studio = true }` to
opt out of the gate while iterating.
]]

local modules = script.Parent

local StringObfuscationModule = modules:FindFirstChild("StringObfuscation")
if not StringObfuscationModule then
    error("[ProtectedSecrets] Required module 'StringObfuscation' not found under " .. modules:GetFullName(), 2)
end

local DebuggerDetectionModule = modules:FindFirstChild("DebuggerDetection")
if not DebuggerDetectionModule then
    error("[ProtectedSecrets] Required module 'DebuggerDetection' not found under " .. modules:GetFullName(), 2)
end

local StringObfuscation = require(StringObfuscationModule)
local DebuggerDetection = require(DebuggerDetectionModule)

local ProtectedSecrets = {
    VERSION = "1.0",
}

-- Returns true when reveal-style operations should be refused.
local function isBlocked(allowInStudio)
    if allowInStudio then
        return false
    end
    return DebuggerDetection.IsBeingDebugged()
end

-- ==================== DIRECT SECRETS ====================

-- Thin passthrough so callers can use a single module for the whole flow.
function ProtectedSecrets.makeSecret(str, name, level)
    return StringObfuscation.makeSecret(str, name, level)
end

-- Reveal a secret's plaintext, gated by debugger detection.
function ProtectedSecrets.reveal(secret, opts)
    opts = opts or {}
    if isBlocked(opts.allow_in_studio) then
        DebuggerDetection.HandleTamperingAttempt(
            "reveal_while_debugged",
            secret and secret.name or "unknown"
        )
        return nil
    end
    return StringObfuscation.revealSecret(secret)
end

-- ==================== PROTECTED SECRET MANAGER ====================

-- Wraps StringObfuscation.createSecretManager; :get / :getSecret are gated.
function ProtectedSecrets.createProtectedManager(opts)
    opts = opts or {}
    local allowInStudio = opts.allow_in_studio == true
    local inner = StringObfuscation.createSecretManager()

    local manager = {}

    function manager:register(name, value, level)
        return inner:register(name, value, level)
    end

    function manager:get(name)
        if isBlocked(allowInStudio) then
            DebuggerDetection.HandleTamperingAttempt("secret_get_while_debugged", name)
            return nil
        end
        return inner:get(name)
    end

    function manager:getSecret(name)
        if isBlocked(allowInStudio) then
            DebuggerDetection.HandleTamperingAttempt("secret_object_while_debugged", name)
            return nil
        end
        return inner:getSecret(name)
    end

    function manager:list()
        return inner:list()
    end

    function manager:clear(name)
        return inner:clear(name)
    end

    function manager:clearAll()
        return inner:clearAll()
    end

    return manager
end

-- ==================== SECURE VAULT ====================

-- Wraps StringObfuscation.createVault; unlock / retrieve / getSecret are gated
-- so a locked vault cannot be opened while a debugger is attached.
function ProtectedSecrets.createSecureVault(password, opts)
    opts = opts or {}
    local allowInStudio = opts.allow_in_studio == true
    local inner = StringObfuscation.createVault(password)

    local vault = {}

    function vault:unlock(providedPassword)
        if isBlocked(allowInStudio) then
            DebuggerDetection.HandleTamperingAttempt("vault_unlock_while_debugged", "vault")
            return false
        end
        return inner:unlock(providedPassword)
    end

    function vault:retrieve(name)
        if isBlocked(allowInStudio) then
            DebuggerDetection.HandleTamperingAttempt("vault_retrieve_while_debugged", name)
            return nil
        end
        return inner:retrieve(name)
    end

    function vault:getSecret(name)
        if isBlocked(allowInStudio) then
            DebuggerDetection.HandleTamperingAttempt("vault_secret_while_debugged", name)
            return nil
        end
        return inner:getSecret(name)
    end

    -- Storing ciphertext and lifecycle ops don't leak plaintext, so pass through.
    function vault:store(name, value, level)
        return inner:store(name, value, level)
    end

    function vault:list()
        return inner:list()
    end

    function vault:delete(name)
        return inner:delete(name)
    end

    function vault:lock()
        return inner:lock()
    end

    return vault
end

-- ==================== REPORTING ====================

-- Merges statistics from both subsystems into one report.
function ProtectedSecrets.getReport()
    return {
        obfuscation = StringObfuscation.getStats(),
        detection = DebuggerDetection.GetStats(),
        is_debugged = DebuggerDetection.IsBeingDebugged(),
        timestamp = os.time(),
    }
end

-- ==================== INITIALIZATION ====================

-- Boots DebuggerDetection with the given options and returns a combined report.
function ProtectedSecrets.initialize(opts)
    opts = opts or {}

    DebuggerDetection.Initialize({
        enable_monitoring = opts.enable_monitoring ~= false,
        enable_continuous_verification = opts.enable_continuous_verification,
        verification_interval = opts.verification_interval,
    })

    return ProtectedSecrets.getReport()
end

return ProtectedSecrets
