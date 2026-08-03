# StringObfuscation v2.0 - Quick Start

## 30-Second Overview

StringObfuscation prevents your secrets (API keys, tokens, URLs) from appearing in plaintext in your code.

```lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

-- Create a secret
local api_key = StringObfuscation.makeSecret("sk-12345", "api_key")

-- Use it
print(api_key)           -- Output: [SECRET:api_key] (won't leak!)
print(api_key.value)     -- Output: sk-12345 (hidden from casual viewing)
```

## Three Ways to Use It

### 1. **Simple Secret Objects** (Easiest)

For individual secrets:

```lua
local secret = StringObfuscation.makeSecret("my_secret", "secret_name", 1)
local actual_value = secret.value
```

**When to use:** Single secrets, debug tokens, temporary keys

### 2. **Secret Manager** (Recommended)

For related secrets in one place:

```lua
local manager = StringObfuscation.createSecretManager()

manager:register("api_key", "sk-12345", 1)
manager:register("webhook", "https://...", 2)

-- Later:
local key = manager:get("api_key")
```

**When to use:** Configuration, multiple related secrets

### 3. **Vault** (Most Secure)

For highly sensitive secrets requiring unlock:

```lua
local vault = StringObfuscation.createVault("master_password")

vault:unlock("master_password")
vault:store("db_password", "secure_pass", 3)

-- Later:
local pass = vault:retrieve("db_password")
```

**When to use:** Database credentials, admin tokens, production secrets

## Real-World Example

```lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

-- Create configuration with secrets
local Config = {}
Config.manager = StringObfuscation.createSecretManager()

-- Register API credentials
Config.manager:register("api_key", "sk-proj-abc123xyz", 2)
Config.manager:register("webhook_url", "https://webhook.site/xxxxx", 2)

-- Use later:
function makeAPIRequest(endpoint)
    local key = Config.manager:get("api_key")
    local url = Config.manager:get("webhook_url")
    
    -- Make request with key and url
    print("Request to " .. endpoint)
end

makeAPIRequest("/users")
```

## Encryption Levels

| Level | Speed | Security | Use Case |
|-------|-------|----------|----------|
| 1 | 100% | Basic | Public data, debug tokens |
| 2 | 98% | Medium | API keys, webhooks |
| 3 | 95% | High | Passwords, admin tokens |

```lua
-- Level 1: Fast, basic obfuscation
local secret1 = StringObfuscation.makeSecret("value", "name", 1)

-- Level 2: Balanced (recommended)
local secret2 = StringObfuscation.makeSecret("value", "name", 2)

-- Level 3: Strongest encryption
local secret3 = StringObfuscation.makeSecret("value", "name", 3)
```

## Common Tasks

### Encrypt a string
```lua
local encrypted = StringObfuscation.encrypt("my_secret", 1)
local decrypted = StringObfuscation.decrypt(encrypted, 1)
```

### Create a secret object
```lua
local secret = StringObfuscation.makeSecret("value", "name", 2)
print(secret.value)  -- Get the value
print(secret.access_count)  -- How many times accessed
```

### Manage multiple secrets
```lua
local manager = StringObfuscation.createSecretManager()
manager:register("key1", "val1")
manager:register("key2", "val2")

print(manager:get("key1"))  -- "val1"
manager:clear("key1")  -- Clear it
```

### Password-protected vault
```lua
local vault = StringObfuscation.createVault("master_password")

-- Unlock first
vault:unlock("master_password")

-- Store secrets
vault:store("db_pass", "super_secret_123", 3)

-- Retrieve
print(vault:retrieve("db_pass"))

-- Lock when done
vault:lock()
```

### Check usage statistics
```lua
local stats = StringObfuscation.getStats()
print("Created " .. stats.secrets_created .. " secrets")
print("Access time: " .. stats.total_access_time_ms .. "ms")
```

### View audit log
```lua
local logs = StringObfuscation.getAuditLog()
for _, entry in ipairs(logs) do
    print(entry.action .. " - " .. entry.name)
end
```

## Integration with Vanity-General

### In Configuration.lua

```lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

local Config = {}
Config.Secrets = StringObfuscation.createSecretManager()

-- Register all sensitive data
Config.Secrets:register("webhook_url", "https://webhook.site/your-id", 2)
Config.Secrets:register("api_key", "your-api-key", 2)

-- Public configuration stays normal
Config.UI = {
    MenuKey = Enum.KeyCode.RightShift,
    Scale = 1,
}

return Config
```

### In your modules

```lua
local Configuration = require(script.Parent:FindFirstChild("Configuration"))

function sendWebhook(data)
    local url = Configuration.Secrets:get("webhook_url")
    -- Use url...
end
```

## Best Practices

✅ **DO:**
- Use Level 2-3 for sensitive data
- Use SecretManager for configuration
- Use Vault for hierarchical access
- Check audit logs occasionally
- Clear secrets when done

❌ **DON'T:**
- Print secret values to logs
- Store decrypted values in globals
- Use Level 1 for passwords
- Forget to unlock vaults
- Leave secrets uncleared

## Troubleshooting

**Q: Secret showing as `[SECRET]` but I can't access it**
```lua
-- Use .value property
local actual = secret.value
```

**Q: Vault says "locked" when I try to use it**
```lua
-- Unlock first with correct password
vault:unlock("your_password")
```

**Q: How do I know if it's working?**
```lua
-- Check stats
local stats = StringObfuscation.getStats()
print("Secrets created: " .. stats.secrets_created)
```

**Q: How much overhead does this add?**
- Per secret: ~1KB base
- Access time: <1ms first time, <0.1ms cached
- Encryption speed: ~1000 strings/second

## Next Steps

- Read `StringObfuscation_ADVANCED.md` for advanced features
- Run `tests/StringObfuscation_TESTS.lua` to verify everything works
- Check `tests/StringObfuscation_DEMO.lua` for more examples
- Integrate with your configuration system

## Need Help?

See the full API in `src/security/StringObfuscation.lua` with detailed inline documentation.

For issues or questions, check:
1. `StringObfuscation_USAGE.md` - detailed usage guide
2. `StringObfuscation_ADVANCED.md` - advanced features
3. `tests/StringObfuscation_DEMO.lua` - working examples
