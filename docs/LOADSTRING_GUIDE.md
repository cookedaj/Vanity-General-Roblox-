# VanityGeneral + StringObfuscation - Combined Loadstring Guide

## Quick Start

The integrated build `dist/VanityGeneral_INTEGRATED.lua` includes StringObfuscation v2.0 in a single file. Use this loadstring in your executor:

```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
VanityGeneral.Start()
```

## Complete Usage

### Loading
```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
```

### Starting the Script
```lua
VanityGeneral.Start()
```

### Using StringObfuscation (Included)
```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
local SO = VanityGeneral.StringObfuscation

-- Create a secret
local secret = SO.makeSecret("api_key_12345", "api_key", 2)
print(secret.value)  -- api_key_12345 (hidden from casual viewing)

-- Use SecretManager
local manager = SO.createSecretManager()
manager:register("webhook", "https://webhook.site/xxx", 2)
local url = manager:get("webhook")

-- Use Vault
local vault = SO.createVault("master_password")
vault:unlock("master_password")
vault:store("db_password", "secure_pass", 3)
```

### Available Methods

#### Configuration
```lua
VanityGeneral.Config                   -- Access current config
VanityGeneral.Config.Camera            -- Camera settings
VanityGeneral.Config.ESP               -- ESP settings
VanityGeneral.Config.UI                -- UI settings
VanityGeneral.Config.reset()           -- Reset to defaults
```

#### Control
```lua
VanityGeneral.Start()                  -- Start the script
VanityGeneral.Stop()                   -- Stop the script
VanityGeneral.Toggle()                 -- Toggle start/stop
VanityGeneral.IsRunning()              -- Check if running
```

#### StringObfuscation Access
```lua
VanityGeneral.StringObfuscation        -- Access encryption system
```

## StringObfuscation Full API

### Basic Functions
```lua
local SO = VanityGeneral.StringObfuscation

-- Encrypt/decrypt
local encrypted = SO.encrypt("secret", 2)
local decrypted = SO.decrypt(encrypted, 2)

-- Secret objects (recommended)
local secret = SO.makeSecret("value", "name", 2)
print(secret.value)                    -- Get value
print(secret.access_count)             -- Times accessed
print(secret.age_seconds)              -- Age in seconds
```

### Secret Manager
```lua
local manager = SO.createSecretManager()

manager:register("api_key", "sk-12345", 2)
manager:register("token", "token_xyz", 1)

print(manager:get("api_key"))          -- Get value
print(manager:getSecret("api_key"))    -- Get full object
print(manager:list())                  -- List all

manager:clear("api_key")               -- Clear one
manager:clearAll()                     -- Clear all
```

### Vault System
```lua
local vault = SO.createVault("password")

vault:unlock("password")               -- Unlock
vault:store("db_pass", "secret", 3)    -- Store secret
print(vault:retrieve("db_pass"))       -- Get secret
print(vault:list())                    -- List contents
vault:delete("db_pass")                -- Delete secret
vault:lock()                           -- Lock vault
```

### Statistics & Audit
```lua
-- Get statistics
local stats = SO.getStats()
print(stats.secrets_created)           -- Total secrets
print(stats.encryptions)               -- Total encryptions
print(stats.total_access_time_ms)      -- Total access time

-- Get audit log
local logs = SO.getAuditLog()
for _, entry in ipairs(logs) do
    print(entry.action, entry.name, entry.timestamp)
end

-- Filter audit log
local accessed = SO.getAuditLog({
    action = "secret_accessed",
    name = "api_key"
})

-- Clear audit log
SO.clearAuditLog()
```

## Encryption Levels

| Level | Speed | Security | Use Case |
|-------|-------|----------|----------|
| 1 | 100% | Basic | Debug tags, public data |
| 2 | 98% | Medium | API keys, webhooks |
| 3 | 95% | High | Passwords, admin tokens |

```lua
local secret1 = SO.makeSecret("value", "name", 1)  -- Fast
local secret2 = SO.makeSecret("value", "name", 2)  -- Balanced
local secret3 = SO.makeSecret("value", "name", 3)  -- Secure
```

## Practical Examples

### Example 1: Protect API Keys
```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
local SO = VanityGeneral.StringObfuscation

local config = {
    api_key = SO.makeSecret("sk-abc123xyz789", "prod_api_key", 2),
    webhook = SO.makeSecret("https://webhook.site/xxx", "webhook", 2),
}

-- Later, use them
function sendRequest()
    local key = config.api_key.value
    -- Make API call with key
end

VanityGeneral.Start()
```

### Example 2: Organized Secrets with Manager
```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
local SO = VanityGeneral.StringObfuscation

local secrets = SO.createSecretManager()
secrets:register("api_key", "sk-12345", 2)
secrets:register("webhook_url", "https://...", 2)
secrets:register("auth_token", "token_xyz", 2)

-- Later
local key = secrets:get("api_key")
local url = secrets:get("webhook_url")

VanityGeneral.Start()
```

### Example 3: Secure Configuration with Vault
```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
local SO = VanityGeneral.StringObfuscation

local vault = SO.createVault("master_password")
vault:unlock("master_password")

vault:store("database_password", "db_secret_123", 3)
vault:store("admin_token", "admin_xyz", 3)

-- Access when needed
function accessDatabase()
    local password = vault:retrieve("database_password")
    -- Connect to database
end

VanityGeneral.Start()
```

## Keys in VanityGeneral

- **RightShift** — Toggle menu (customizable)
- **LeftAlt** — Toggle camera tracking (customizable)
- **End** — Unload script (customizable)

## Version Information

- **VanityGeneral**: INTEGRATED single-file build (with StringObfuscation integrated)
- **StringObfuscation**: v2.0
- **Combined size**: ~168KB (single file)

## File Path

Make sure `VanityGeneral_INTEGRATED.lua` (from `dist/`) is in your executor's workspace:
```
readfile("VanityGeneral_INTEGRATED.lua")  -- Current directory
```

Or use a full path:
```
loadstring(readfile("C:\\path\\to\\VanityGeneral_INTEGRATED.lua"))()
```

## Troubleshooting

**Q: Module not found**
- Make sure VanityGeneral_INTEGRATED.lua is in your executor's directory
- Check file path spelling

**Q: StringObfuscation not accessible**
- Use `VanityGeneral.StringObfuscation` after loading
- Don't try to require it separately

**Q: Need individual modules?**
- Use the modular source in `src/` (Loader.lua or MainController.lua entry)
- Or copy-paste individual sections from the StringObfuscation guides

## Next Steps

- Start VanityGeneral: `VanityGeneral.Start()`
- Access StringObfuscation: `VanityGeneral.StringObfuscation`
- Read StringObfuscation_QUICKSTART.md for more examples
- Read StringObfuscation_API.md for complete reference

## Support

All StringObfuscation features are documented in:
- `StringObfuscation_QUICKSTART.md` — Quick reference
- `StringObfuscation_API.md` — Complete API
- `StringObfuscation_ADVANCED.md` — Advanced features
- `tests/StringObfuscation_DEMO.lua` — Working examples
