# VanityGeneral + StringObfuscation - Quick Reference Card

## The Loadstring

```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
VanityGeneral.Start()
```

That's it. Everything is included.

## Access StringObfuscation

```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
local SO = VanityGeneral.StringObfuscation
```

## Common Tasks (Copy & Paste)

### Create a Secret
```lua
local secret = SO.makeSecret("my_secret_value", "secret_name", 2)
print(secret.value)  -- Get the value
```

### Multiple Secrets with Manager
```lua
local secrets = SO.createSecretManager()
secrets:register("api_key", "sk-12345", 2)
secrets:register("webhook", "https://webhook.site/xxx", 2)

local key = secrets:get("api_key")
local url = secrets:get("webhook")
```

### Password-Protected Vault
```lua
local vault = SO.createVault("master_password")
vault:unlock("master_password")
vault:store("password", "secret_password_123", 3)

local pwd = vault:retrieve("password")
vault:lock()
```

### Batch Encrypt/Decrypt
```lua
local strings = {"secret1", "secret2", "secret3"}
local encrypted = SO.batchEncrypt(strings, 2)
local decrypted = SO.batchDecrypt(encrypted, 2)
```

### Check Statistics
```lua
local stats = SO.getStats()
print("Secrets created: " .. stats.secrets_created)
print("Total access time: " .. stats.total_access_time_ms .. "ms")
```

### View Audit Log
```lua
local logs = SO.getAuditLog()
for _, entry in ipairs(logs) do
    print(entry.action .. ": " .. entry.name)
end
```

## Encryption Levels (Pick One)

```lua
SO.makeSecret("value", "name", 1)  -- Level 1: Fast
SO.makeSecret("value", "name", 2)  -- Level 2: Balanced (recommended)
SO.makeSecret("value", "name", 3)  -- Level 3: Secure
```

## VanityGeneral Controls

```lua
VanityGeneral.Start()   -- Start script
VanityGeneral.Stop()    -- Stop script
VanityGeneral.Toggle()  -- Toggle on/off
VanityGeneral.Config    -- Access config

-- Modify config
VanityGeneral.Config.ESP.Enabled = true
VanityGeneral.Config.Camera.Smoothness = 0.2
```

## Full Script Template

```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
local SO = VanityGeneral.StringObfuscation

-- Set up your secrets
local config = {
    secrets = SO.createSecretManager(),
}

config.secrets:register("api_key", "sk-abc123", 2)
config.secrets:register("webhook", "https://webhook.site/xxx", 2)

-- Start VanityGeneral
VanityGeneral.Start()

-- Use secrets in your code
function makeAPICall()
    local key = config.secrets:get("api_key")
    -- Use key here...
end
```

## File Location

Place `VanityGeneral_INTEGRATED.lua` (from `dist/`, ~168KB) in your executor's workspace directory, then:

```lua
local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
```

## What's Included

✅ Full VanityGeneral (ESP, Camera, UI)
✅ StringObfuscation v2.0 (complete)
✅ Secret Manager
✅ Vault System
✅ Audit Logging
✅ Statistics Tracking

## Documentation

- **LOADSTRING_GUIDE.md** — Detailed usage guide
- **StringObfuscation_QUICKSTART.md** — StringObfuscation quick start
- **StringObfuscation_API.md** — Complete API reference
- **StringObfuscation_ADVANCED.md** — Advanced features

## One-Liner Examples

```lua
-- Run everything
loadstring(readfile("VanityGeneral_INTEGRATED.lua"))().Start()

-- Get StringObfuscation
local SO = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))().StringObfuscation

-- Create a secret immediately
local secret = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))().StringObfuscation.makeSecret("value", "name", 2)
```

---

**That's all you need to get started!**
