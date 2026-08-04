# StringObfuscation Integration Guide for Vanity-General

This guide shows how to integrate StringObfuscation into your Vanity-General project.

> **Current state of the repo:** StringObfuscation is a **standalone
> library** in `src/security/` — it is **not bundled** into
> `dist/VanityGeneral_INTEGRATED.lua` anymore (the release pipeline's
> obfuscator replaced that role), and no `src/` module requires it. To use
> it in your own scripts, `require` it directly from `src/security/`. To
> bundle it into a custom build, add it to `MODULES` in `tools/build.py`
> (before any consumer) and follow the module contract (table at top,
> top-of-file requires, `return` at the end). The steps below are an
> **optional** integration for your own configuration/secrets.

## Architecture Overview

```
Vanity-General/
├── src/
│   ├── Configuration.lua       (settings; optional SecretManager host)
│   ├── ESP.lua                 (uses secrets only if you add them)
│   ├── CameraDirector.lua
│   ├── UI.lua                  (display secrets safely)
│   ├── Loader.lua              (entry point; load StringObfuscation first if used)
│   ├── MainController.lua      (alternative entry point)
│   └── security/
│       ├── StringObfuscation.lua   (core encryption)
│       ├── DebuggerDetection.lua
│       └── ProtectedSecrets.lua
├── dist/VanityGeneral_INTEGRATED.lua   (single-file build with all of the above)
└── tests/                        (StringObfuscation_TESTS.lua, StringObfuscation_DEMO.lua)
```

## Step 1: Configuration Setup (optional)

To host secrets in your configuration, add a `SecretManager` to
`src/Configuration.lua`. The module currently has no StringObfuscation
require — the following is what **you** would add:

```lua
-- Add to the top of src/Configuration.lua
local StringObfuscation = require(script.Parent.security.StringObfuscation)

-- Encryption level for different types of data
local ENCRYPT_LEVEL = {
    DEBUG = 1,        -- Debug tags (fast)
    API = 2,          -- API keys (balanced)
    SENSITIVE = 3,    -- Passwords (secure)
}

-- Set up secret manager for configuration
Config.SecretManager = StringObfuscation.createSecretManager()

-- Register any API keys or webhook URLs
-- Config.SecretManager:register("webhook_url", "https://webhook.site/your-id", ENCRYPT_LEVEL.API)
-- Config.SecretManager:register("api_key", "your_api_key", ENCRYPT_LEVEL.API)
```

Leave the rest of `src/Configuration.lua` (the `Config.Camera` / `Config.ESP` /
`Config.UI` tables, `DEFAULTS`, and `Config.reset()`) as it is — secrets live
alongside the plain settings, not inside them.

## Step 2: Update Loader.lua

`src/Loader.lua` currently requires only `Configuration`, `CameraDirector`,
`ESP`, and `UI`. If you added the Step 1 integration, require
StringObfuscation first so it is available before Configuration loads:

```lua
local success, err = pcall(function()
    -- Load StringObfuscation FIRST (only if Configuration depends on it)
    StringObfuscation = require(moduleLocation:WaitForChild("security"):WaitForChild("StringObfuscation", 5))

    -- Then Configuration (which may depend on StringObfuscation)
    Configuration = require(moduleLocation:WaitForChild("Configuration", 5))

    -- Then other modules
    CameraDirector = require(moduleLocation:WaitForChild("CameraDirector", 5))
    ESP = require(moduleLocation:WaitForChild("ESP", 5))
    UI = require(moduleLocation:WaitForChild("UI", 5))
end)

-- ... rest of Loader.lua remains the same
```

## Step 3: Using Secrets in Modules (optional patterns)

These snippets are illustrative patterns for your own code — the shipped
`src/ESP.lua` and `src/UI.lua` do not contain them.

### In ESP.lua

```lua
-- ESP.lua
local StringObfuscation = require(script.Parent.security.StringObfuscation)

-- Optional: Use obfuscated debug tag
local DEBUG_TAG = StringObfuscation.makeSecret("ESP_DEBUG", "esp_debug", 1)

function ESP:DebugLog(message)
    if DEBUG_TAG.value then
        print("[" .. DEBUG_TAG.value .. "] " .. message)
    end
end
```

### In UI.lua

```lua
-- UI.lua
local StringObfuscation = require(script.Parent.security.StringObfuscation)

-- Create obfuscated UI identifier
local UI_THEME_ID = StringObfuscation.makeSecret("VANITY_GENERAL_UI_v2", "ui_theme", 1)
```

## Step 4: Practical Example - Adding Webhooks

If you want to add webhook support with obfuscation:

```lua
-- In src/Configuration.lua (added by you — not present in the shipped module)
local StringObfuscation = require(script.Parent.security.StringObfuscation)

local Config = {}
Config.SecretManager = StringObfuscation.createSecretManager()

-- Initialize with empty webhook (user can set it)
Config.SecretManager:register("webhook_url", "", 2)
Config.SecretManager:register("webhook_enabled", "false", 1)

-- Helper function to set webhook
function Config.setWebhook(url)
    Config.SecretManager:register("webhook_url", url, 2)
end

-- Helper function to get webhook
function Config.getWebhook()
    return Config.SecretManager:get("webhook_url")
end

return Config
```

Then use it in your code:

```lua
-- In any module
local Configuration = require(script.Parent:FindFirstChild("Configuration"))

function sendWebhookNotification(message)
    local webhook_url = Configuration.getWebhook()
    if webhook_url and webhook_url ~= "" then
        -- Send notification to webhook
        print("Notification sent: " .. message)
    end
end
```

## Step 5: Auditing Setup (Optional)

For security monitoring, add audit logging:

```lua
-- In your main controller or logging module
local StringObfuscation = require(script.Parent.security.StringObfuscation)

local AuditService = {}

function AuditService.getReport()
    local stats = StringObfuscation.getStats()
    local logs = StringObfuscation.getAuditLog()
    
    return {
        statistics = stats,
        recent_activity = logs,
        status = "OK"
    }
end

function AuditService.checkForAnomalies()
    local logs = StringObfuscation.getAuditLog()
    
    -- Check for excessive access attempts
    local manager = {}
    for _, log in ipairs(logs) do
        if log.action == "secret_accessed" then
            manager[log.name] = (manager[log.name] or 0) + 1
        end
    end
    
    -- Warn if any secret accessed more than 1000 times
    for name, count in pairs(manager) do
        if count > 1000 then
            warn("[Audit] Secret '" .. name .. "' accessed " .. count .. " times")
        end
    end
end

return AuditService
```

## Integration Checklist

- [ ] Use `src/security/StringObfuscation.lua` (already in the repo — no copy needed)
- [ ] Update `src/Configuration.lua` with `SecretManager`
- [ ] Update `src/Loader.lua` to load StringObfuscation first
- [ ] Update `src/ESP.lua` (if using debug tags)
- [ ] Update `src/UI.lua` (if using theme identifiers)
- [ ] Add any sensitive configuration to SecretManager
- [ ] Test with `tests/StringObfuscation_TESTS.lua`
- [ ] Review `StringObfuscation_QUICKSTART.md`
- [ ] Test module loading in your environment

## Common Integration Patterns

### Pattern 1: Simple Webhook Integration

```lua
-- Configuration.lua
local manager = StringObfuscation.createSecretManager()
manager:register("webhook", "https://webhook.site/xxxxx", 2)

-- Use it:
function sendAlert(message)
    local webhook = manager:get("webhook")
    -- Send to webhook...
end
```

### Pattern 2: Multiple Environments

```lua
local manager = StringObfuscation.createSecretManager()

if isProduction then
    manager:register("api_key", "prod_key_xxx", 3)
    manager:register("api_url", "https://prod.api.com", 2)
else
    manager:register("api_key", "dev_key_xxx", 2)
    manager:register("api_url", "https://dev.api.com", 2)
end
```

### Pattern 3: Lazy Loading Secrets

```lua
local manager = StringObfuscation.createSecretManager()

-- Register but don't populate until needed
local function loadSecretsWhenNeeded()
    if not manager:getSecret("api_key") then
        -- Load from somewhere
        manager:register("api_key", loadApiKey(), 2)
    end
end
```

### Pattern 4: Automatic Cleanup

```lua
-- Clear old secrets periodically
local last_cleanup = os.time()

function cleanupSecrets()
    local now = os.time()
    if now - last_cleanup > 3600 then  -- Every hour
        local logs = StringObfuscation.getAuditLog()
        
        -- Clear unused secrets
        -- ... implement your logic
        
        last_cleanup = now
    end
end
```

## Testing Integration

Run the test suite in `tests/StringObfuscation_TESTS.lua` to verify everything
works (copy it in as a ModuleScript next to StringObfuscation first):

```lua
-- In your game
local StringObfuscation_TESTS = require(script.Parent:FindFirstChild("StringObfuscation_TESTS"))
-- Tests will run automatically
```

## Troubleshooting Integration

### Module loading fails
- Ensure `StringObfuscation.lua` is reachable from `Configuration.lua`
  (e.g. a `security` folder next to the modules, matching the require path)
- Check that module paths are correct
- Look for typos in `:WaitForChild()` calls

### Secrets not accessible
- Make sure to unlock vaults before accessing
- Check that SecretManager was properly initialized
- Verify the secret name matches when retrieving

### Performance issues
- Check audit log size (clear periodically if large)
- Monitor access patterns with `getStats()`
- Consider using Level 1 for frequently accessed data

## Next Steps

1. Read `StringObfuscation_QUICKSTART.md` for quick reference
2. Review `StringObfuscation_ADVANCED.md` for advanced features
3. Check `tests/StringObfuscation_DEMO.lua` for working examples
4. Run `tests/StringObfuscation_TESTS.lua` to verify functionality

## Version History

- **v2.0** - Initial Vanity-General integration
  - SecretManager for configuration
  - Vault for hierarchical secrets
  - Audit logging
  - Performance monitoring
