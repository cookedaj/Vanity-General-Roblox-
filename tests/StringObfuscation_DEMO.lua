--[[
StringObfuscation Demo
Demonstrates practical string obfuscation usage in your Vanity-General project.
]]

-- Locate the module: next to this script, or under a sibling "security" folder
-- (matches the repo layout: tests/ alongside src/security/).
local module = script.Parent:FindFirstChild("StringObfuscation")
    or (script.Parent.Parent and script.Parent.Parent:FindFirstChild("security")
        and script.Parent.Parent.security:FindFirstChild("StringObfuscation"))
assert(module, "[Demo] StringObfuscation module not found (expected next to this script or in a sibling 'security' folder)")
local StringObfuscation = require(module)

print("\n" .. string.rep("=", 60))
print("STRING OBFUSCATION DEMO")
print(string.rep("=", 60) .. "\n")

-- ============================================================================
-- EXAMPLE 1: Basic Encryption/Decryption
-- ============================================================================
print("[1] Basic Encryption/Decryption")
print(string.rep("-", 60))

local secret_api_key = "sk-proj-abcdef123456"
print("Original secret: " .. secret_api_key)

local encrypted = StringObfuscation.obfuscate(secret_api_key)
print("Encrypted (as bytes): " .. tostring(encrypted))
print("Encrypted length: " .. #encrypted)

local decrypted = StringObfuscation.deobfuscate(encrypted)
print("Decrypted: " .. decrypted)
print("Match: " .. tostring(decrypted == secret_api_key))
print()

-- ============================================================================
-- EXAMPLE 2: Secret Objects with Automatic Encryption
-- ============================================================================
print("[2] Secret Objects (Recommended Approach)")
print(string.rep("-", 60))

local webhook_url = StringObfuscation.makeSecret("https://webhook.site/unique-id-12345")
print("Secret object: " .. tostring(webhook_url))
print("Attempting to print directly won't leak the URL")

print("Accessing value: " .. webhook_url.value)
print("Access count: " .. webhook_url.access_count)
print()

-- ============================================================================
-- EXAMPLE 3: Multiple Secrets in a Table
-- ============================================================================
print("[3] Configuration with Multiple Secrets")
print(string.rep("-", 60))

local AppSecrets = {
    APIKey = StringObfuscation.makeSecret("key_abc123"),
    AuthToken = StringObfuscation.makeSecret("token_xyz789"),
    WebhookURL = StringObfuscation.makeSecret("https://api.example.com/webhook"),
    DatabasePassword = StringObfuscation.makeSecret("db_pass_secure_123"),
}

print("Defined 4 secrets:")
print("  - APIKey")
print("  - AuthToken")
print("  - WebhookURL")
print("  - DatabasePassword")
print()

print("Accessing APIKey: " .. AppSecrets.APIKey.value)
print("APIKey access count: " .. AppSecrets.APIKey.access_count)
print()

-- ============================================================================
-- EXAMPLE 4: Practical Use Case - Making API Call
-- ============================================================================
print("[4] Practical Example: Using Secrets for API Call")
print(string.rep("-", 60))

local function makeSecureAPICall(endpoint, secret_token)
    local actual_token = secret_token.value
    -- In real code, this would be:
    -- local response = http.post(endpoint, { headers = { Authorization = "Bearer " .. actual_token } })
    print("Making API call to: " .. endpoint)
    print("Using token: " .. actual_token:sub(1, 10) .. "...")
    print("Token access count now: " .. secret_token.access_count)
end

local api_endpoint = "https://api.example.com/data"
local api_token = StringObfuscation.makeSecret("secret_token_here_12345")

makeSecureAPICall(api_endpoint, api_token)
print()

-- ============================================================================
-- EXAMPLE 5: Comparison - Plaintext vs Obfuscated
-- ============================================================================
print("[5] Plaintext vs Obfuscated Comparison")
print(string.rep("-", 60))

-- This would appear in memory/strings:
local plaintext_secret = "my_secret_password_123"
print("Plaintext in code: " .. plaintext_secret)

-- This won't appear in plaintext:
local obfuscated_secret = StringObfuscation.makeSecret("my_secret_password_123")
print("Obfuscated object: " .. tostring(obfuscated_secret))
print("(The actual secret is hidden, only revealed on .value access)")
print()

-- ============================================================================
-- EXAMPLE 6: Audit Trail
-- ============================================================================
print("[6] Access Audit Trail")
print(string.rep("-", 60))

local audit_secret = StringObfuscation.makeSecret("audit_test_secret")

for i = 1, 5 do
    local _ = audit_secret.value
    print("Access #" .. i .. ": Count = " .. audit_secret.access_count)
end
print()

-- ============================================================================
-- EXAMPLE 7: Integration with Vanity-General
-- ============================================================================
print("[7] Vanity-General Integration Example")
print(string.rep("-", 60))

local VanityConfig = {
    System = {
        Name = "Vanity-General",
        Version = "1.0",
    },
    Secrets = {
        WebhookURL = StringObfuscation.makeSecret("https://webhook.example.com/vanity"),
        DebugToken = StringObfuscation.makeSecret("debug_token_xyz"),
        LogKey = StringObfuscation.makeSecret("log_encryption_key"),
    },
    Public = {
        MenuKey = "RightShift",
        CameraKey = "LeftAlt",
        UnloadKey = "End",
    }
}

print("Config structure created")
print("Public data (visible): " .. VanityConfig.Public.MenuKey)
print("Secret data (hidden): " .. tostring(VanityConfig.Secrets.WebhookURL))
print("Secret value when needed: " .. VanityConfig.Secrets.WebhookURL.value)
print()

-- ============================================================================
-- EXAMPLE 8: Safe String Handling
-- ============================================================================
print("[8] Safe String Handling")
print(string.rep("-", 60))

local function safeLog(message, secret)
    -- Don't log the raw secret value
    local secret_str = secret.value
    print("Log: " .. message .. " (token used " .. secret.access_count .. " times)")
    -- In real code, secret_str is cleared/forgotten after use
end

local logging_secret = StringObfuscation.makeSecret("log_secret_token")
safeLog("System initialized", logging_secret)
safeLog("User action detected", logging_secret)
print()

-- ============================================================================
-- SUMMARY
-- ============================================================================
print(string.rep("=", 60))
print("SUMMARY")
print(string.rep("=", 60))
print([[
String obfuscation prevents secrets from appearing in plaintext.

Key Benefits:
✓ Secrets not visible in source code strings
✓ Prevents 'strings' command from finding secrets in binaries
✓ Reduces exposure in memory dumps
✓ Access tracking with .access_count
✓ Easy to integrate into existing code

Use StringObfuscation.makeSecret() for most cases.
It provides the best balance of security and usability.

For more information, see: StringObfuscation_USAGE.md
]])
print(string.rep("=", 60) .. "\n")
