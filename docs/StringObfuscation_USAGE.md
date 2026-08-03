# String Obfuscation Usage Guide

## Overview
StringObfuscation prevents sensitive strings (API keys, tokens, URLs, etc.) from appearing in plaintext in your Lua scripts or memory.

## Basic Usage

### Method 1: Simple Encrypt/Decrypt
```lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

-- Obfuscate a secret
local api_key = "sk-abc123xyz789"
local encrypted = StringObfuscation.obfuscate(api_key)
print(encrypted)  -- {184, 45, 201, ...} (byte array, not readable)

-- Decrypt when needed
local decrypted = StringObfuscation.deobfuscate(encrypted)
print(decrypted)  -- "sk-abc123xyz789"
```

### Method 2: Secret Objects (Recommended)
```lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

-- Create a secret object
local secret_token = StringObfuscation.makeSecret("your_secret_token_here")
print(secret_token)  -- "[SECRET]" (won't leak in logs)

-- Access the value when needed
local actual_token = secret_token.value
-- Use actual_token for API calls, etc.

-- Check how many times it was accessed
print(secret_token.access_count)
```

### Method 3: In Configuration
```lua
-- Configuration.lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

local Config = {
    Secrets = {
        APIKey = StringObfuscation.makeSecret("your_api_key"),
        AuthToken = StringObfuscation.makeSecret("your_token"),
        WebhookURL = StringObfuscation.makeSecret("https://webhook.site/xxxxx")
    }
}

-- Later in your code:
local actual_key = Config.Secrets.APIKey.value
local actual_token = Config.Secrets.AuthToken.value
```

## How It Works

The obfuscation uses XOR encryption with a shifting key:
- Each byte is XORed with `(0xAA + position) & 0xFF`
- Strings are stored as byte arrays instead of readable text
- Only decrypted in memory when `.value` is accessed
- Re-encrypts after use (in secret objects)

## Security Notes

⚠️ **This is NOT military-grade encryption** — it's obfuscation to:
- Prevent casual reading of your code
- Stop strings from appearing in binary string tables
- Make memory inspection slightly harder
- Reduce accidental exposure in logs/error messages

✅ **Use for:**
- API keys and tokens
- Webhook URLs
- Internal service URLs
- Debug credentials
- Configuration strings you don't want exposed

❌ **Don't use for:**
- Passwords that need cryptographic security
- Data that requires proven encryption standards
- Sensitive user data with compliance requirements

## Performance

- Encryption/decryption is fast (simple XOR operation)
- Secret objects cache decrypted values in memory
- Minimal overhead compared to plaintext strings

## Integration Examples

### In ESP.lua
```lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

local ESP = {}
ESP.Logger = StringObfuscation.makeSecret("ESP_DEBUG_LOG_KEY")

function ESP:DebugLog(message)
    if self.Logger.value then
        print("[" .. self.Logger.value .. "] " .. message)
    end
end
```

### In UI.lua
```lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

local UI = {}
UI.ThemeID = StringObfuscation.makeSecret("VANITY_GENERAL_UI_v1")

function UI:CreateTheme()
    return self.ThemeID.value
end
```

## Checking It Works

You can verify obfuscation is working by checking the binary/source:
```bash
# Before obfuscation
strings your_script.lua | grep "api_key"
# Output: api_key

# After obfuscation
strings your_script.lua | grep "api_key"
# Output: (empty - api_key is encrypted)
```

## Advanced Usage

### Creating a Secret Manager
```lua
local StringObfuscation = require(script.Parent:FindFirstChild("StringObfuscation"))

local SecretManager = {}
local secrets = {}

function SecretManager.register(name, value)
    secrets[name] = StringObfuscation.makeSecret(value)
end

function SecretManager.get(name)
    if secrets[name] then
        return secrets[name].value
    end
    return nil
end

function SecretManager.audit()
    local report = {}
    for name, secret in pairs(secrets) do
        table.insert(report, {
            name = name,
            accessed = secret.access_count,
            is_set = secret.value ~= nil
        })
    end
    return report
end

return SecretManager
```

## Cleanup

After using a secret value, you can optionally clear it:
```lua
local token = secret_obj.value
-- Use token...
secret_obj._decrypted = nil  -- Clear from memory
```

This forces re-decryption on next access, keeping secrets off memory longer.
