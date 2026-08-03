# StringObfuscation v2.0 - Complete API Reference

## Table of Contents

1. [Core Functions](#core-functions)
2. [Secret Objects](#secret-objects)
3. [Secret Manager](#secret-manager)
4. [Vault System](#vault-system)
5. [Statistics & Audit](#statistics--audit)
6. [Type Definitions](#type-definitions)

---

## Core Functions

### `StringObfuscation.encrypt(str, level)`

Encrypts a string using XOR encryption with key rotation.

**Parameters:**
- `str` (string) - The string to encrypt
- `level` (number, optional) - Encryption level (1, 2, or 3). Default: 1

**Returns:**
- table - Array of encrypted bytes

**Example:**
```lua
local encrypted = StringObfuscation.encrypt("hello", 1)
-- encrypted = {184, 229, 157, 172, 45}
```

### `StringObfuscation.decrypt(encrypted, level)`

Decrypts an encrypted byte array back to a string.

**Parameters:**
- `encrypted` (table) - Array of encrypted bytes
- `level` (number, optional) - Encryption level (must match encrypt level). Default: 1

**Returns:**
- string - The decrypted string

**Example:**
```lua
local decrypted = StringObfuscation.decrypt(encrypted, 1)
-- decrypted = "hello"
```

### `StringObfuscation.obfuscate(str, level)`

Alias for `encrypt()`. Obfuscates a string.

**Parameters:**
- `str` (string) - The string to obfuscate
- `level` (number, optional) - Encryption level. Default: 1

**Returns:**
- table - Array of obfuscated bytes

### `StringObfuscation.deobfuscate(encrypted, level)`

Alias for `decrypt()`. Deobfuscates a byte array.

**Parameters:**
- `encrypted` (table) - Array of obfuscated bytes
- `level` (number, optional) - Encryption level. Default: 1

**Returns:**
- string - The deobfuscated string

### `StringObfuscation.batchEncrypt(strings, level)`

Encrypts multiple strings efficiently.

**Parameters:**
- `strings` (table) - Array of strings to encrypt
- `level` (number, optional) - Encryption level. Default: 1

**Returns:**
- table - Array of encrypted byte arrays

**Example:**
```lua
local list = {"str1", "str2", "str3"}
local encrypted = StringObfuscation.batchEncrypt(list, 1)
```

### `StringObfuscation.batchDecrypt(encrypted_list, level)`

Decrypts multiple encrypted byte arrays efficiently.

**Parameters:**
- `encrypted_list` (table) - Array of encrypted byte arrays
- `level` (number, optional) - Encryption level. Default: 1

**Returns:**
- table - Array of decrypted strings

---

## Secret Objects

### `StringObfuscation.makeSecret(str, name, level)`

Creates a secret object with automatic encryption and caching.

**Parameters:**
- `str` (string) - The secret string
- `name` (string, optional) - Human-readable name for the secret
- `level` (number, optional) - Encryption level (1-3). Default: 1

**Returns:**
- table - Secret object with following properties and methods:

**Properties:**
- `secret.value` (string) - Get the decrypted value (lazy-loads and caches)
- `secret.access_count` (number) - Number of times `.value` was accessed
- `secret.last_access` (number) - Unix timestamp of last access
- `secret.creation_time` (number) - Unix timestamp of creation
- `secret.age_seconds` (number) - Age of secret in seconds
- `secret.level` (number) - Encryption level (1-3)
- `secret.name` (string) - Secret name
- `secret.is_cleared` (boolean) - Whether secret was cleared

**Methods:**
- `tostring(secret)` - Returns `[SECRET:name]` (won't leak value)

**Example:**
```lua
local api_key = StringObfuscation.makeSecret("sk-abc123", "prod_api_key", 2)

print(api_key)              -- [SECRET:prod_api_key]
print(api_key.value)        -- sk-abc123
print(api_key.access_count) -- 1
print(api_key.age_seconds)  -- 5
```

### `StringObfuscation.clearSecret(secret)`

Clears a secret from memory. After clearing, accessing `.value` returns nil.

**Parameters:**
- `secret` (table) - Secret object to clear

**Returns:**
- boolean - true if cleared, false if not a secret object

**Example:**
```lua
StringObfuscation.clearSecret(api_key)
print(api_key.value)  -- nil (and shows warning)
```

### `StringObfuscation.verifySecret(secret, expected_hash)`

Verifies a secret's integrity using hash comparison.

**Parameters:**
- `secret` (table) - Secret object to verify
- `expected_hash` (number, optional) - Expected hash value

**Returns:**
- boolean - true if verified

**Example:**
```lua
local secret = StringObfuscation.makeSecret("test", "verify_test")
local hash = secret._hash
-- ... later ...
if StringObfuscation.verifySecret(secret, hash) then
    print("Secret is valid")
end
```

### `StringObfuscation.revealSecret(secret)`

Utility function to extract value from secret or return unchanged.

**Parameters:**
- `secret` (table or any) - Secret object or any value

**Returns:**
- string or original type - The decrypted value or original input

**Example:**
```lua
local value = StringObfuscation.revealSecret(secret)
-- or for non-secrets:
local value = StringObfuscation.revealSecret("plaintext")  -- "plaintext"
```

---

## Secret Manager

### `StringObfuscation.createSecretManager()`

Creates a manager for multiple related secrets.

**Returns:**
- SecretManager - Manager object with following methods:

### `manager:register(name, value, level)`

Registers a new secret.

**Parameters:**
- `name` (string) - Unique identifier for the secret
- `value` (string) - The secret value
- `level` (number, optional) - Encryption level. Default: 1

**Returns:**
- table - Secret object, or nil if name already exists

**Example:**
```lua
local manager = StringObfuscation.createSecretManager()
manager:register("api_key", "sk-12345", 2)
manager:register("webhook", "https://...", 2)
```

### `manager:get(name)`

Retrieves and decrypts a secret value.

**Parameters:**
- `name` (string) - Secret name

**Returns:**
- string or nil - The decrypted value, or nil if not found

**Example:**
```lua
local key = manager:get("api_key")
```

### `manager:getSecret(name)`

Retrieves the full secret object (not just the value).

**Parameters:**
- `name` (string) - Secret name

**Returns:**
- table or nil - Full secret object with metadata

**Example:**
```lua
local secret_obj = manager:getSecret("api_key")
print(secret_obj.access_count)
```

### `manager:list()`

Lists all registered secrets with metadata.

**Returns:**
- table - Array of secret info objects:
  ```lua
  {
    {
        name = "api_key",
        accessed = 5,        -- access count
        age = 120,           -- age in seconds
        cleared = false
    },
    ...
  }
  ```

**Example:**
```lua
for _, info in ipairs(manager:list()) do
    print(info.name .. ": " .. info.accessed .. " accesses")
end
```

### `manager:clear(name)`

Clears and removes a specific secret.

**Parameters:**
- `name` (string) - Secret name to clear

**Returns:**
- boolean - true if cleared, false if not found

**Example:**
```lua
manager:clear("api_key")
```

### `manager:clearAll()`

Clears and removes all secrets.

**Returns:**
- nil

**Example:**
```lua
manager:clearAll()
```

---

## Vault System

### `StringObfuscation.createVault(password)`

Creates a password-protected vault for hierarchical secret storage.

**Parameters:**
- `password` (string) - Master password for the vault

**Returns:**
- Vault - Vault object with following methods:

### `vault:unlock(password)`

Unlocks the vault with the correct password.

**Parameters:**
- `password` (string) - Password to unlock

**Returns:**
- boolean - true if unlocked, false if wrong password

**Example:**
```lua
local vault = StringObfuscation.createVault("master_password")
vault:unlock("master_password")  -- true
vault:unlock("wrong_password")   -- false
```

### `vault:lock()`

Locks the vault, preventing access to secrets.

**Returns:**
- nil

**Example:**
```lua
vault:lock()
```

### `vault:store(name, value, level)`

Stores a secret in the vault (vault must be unlocked).

**Parameters:**
- `name` (string) - Secret identifier
- `value` (string) - Secret value
- `level` (number, optional) - Encryption level. Default: 2

**Returns:**
- boolean - true if stored, false if locked

**Example:**
```lua
vault:unlock("password")
vault:store("db_password", "secret_123", 3)
```

### `vault:retrieve(name)`

Retrieves a secret from the vault (vault must be unlocked).

**Parameters:**
- `name` (string) - Secret identifier

**Returns:**
- string or nil - Secret value, or nil if locked or not found

**Example:**
```lua
local password = vault:retrieve("db_password")
```

### `vault:getSecret(name)`

Retrieves the full secret object from the vault.

**Parameters:**
- `name` (string) - Secret identifier

**Returns:**
- table or nil - Full secret object

**Example:**
```lua
local secret_obj = vault:getSecret("db_password")
print(secret_obj.access_count)
```

### `vault:list()`

Lists all secret names in the vault (vault must be unlocked).

**Returns:**
- table - Array of secret names, or empty table if locked

**Example:**
```lua
vault:unlock("password")
for _, name in ipairs(vault:list()) do
    print(name)
end
```

### `vault:delete(name)`

Deletes a secret from the vault (vault must be unlocked).

**Parameters:**
- `name` (string) - Secret identifier

**Returns:**
- boolean - true if deleted, false if locked or not found

**Example:**
```lua
vault:delete("old_secret")
```

---

## Statistics & Audit

### `StringObfuscation.getStats()`

Gets current statistics about encryption operations.

**Returns:**
- table - Statistics object:
  ```lua
  {
    encryptions = 42,              -- Total encryptions
    decryptions = 40,              -- Total decryptions
    secrets_created = 12,          -- Total secrets made
    total_access_time_ms = 150.5,  -- Cumulative access time
    audit_log_size = 256           -- Audit log entries
  }
  ```

**Example:**
```lua
local stats = StringObfuscation.getStats()
print("Created " .. stats.secrets_created .. " secrets")
```

### `StringObfuscation.getAuditLog(filter)`

Retrieves audit log entries, optionally filtered.

**Parameters:**
- `filter` (table, optional) - Filter criteria:
  ```lua
  {
    action = "secret_accessed",  -- Filter by action
    name = "api_key",            -- Filter by secret name
    since = os.time() - 3600     -- Only after this timestamp
  }
  ```

**Returns:**
- table - Array of audit entries:
  ```lua
  {
    {
        timestamp = 1234567890,      -- Unix timestamp
        action = "secret_accessed",  -- Action type
        name = "api_key",            -- Secret name
        details = { ... }            -- Action-specific details
    },
    ...
  }
  ```

**Example:**
```lua
-- Get all accesses to specific secret
local logs = StringObfuscation.getAuditLog({
    action = "secret_accessed",
    name = "api_key"
})

for _, entry in ipairs(logs) do
    print(os.date("%H:%M:%S", entry.timestamp))
end
```

### `StringObfuscation.clearAuditLog()`

Clears all audit log entries.

**Returns:**
- boolean - Always true

**Example:**
```lua
StringObfuscation.clearAuditLog()
```

---

## Type Definitions

### Secret Object

```lua
{
    value,              -- (property) Decrypted string
    access_count,       -- (property) Number of accesses
    last_access,        -- (property) Unix timestamp
    creation_time,      -- (property) Unix timestamp
    age_seconds,        -- (property) Age in seconds
    level,              -- (property) Encryption level
    name,               -- (property) Secret name
    is_cleared,         -- (property) Cleared status
    _encrypted,         -- (internal) Encrypted bytes
    _decrypted,         -- (internal) Cached plaintext
    _hash,              -- (internal) Hash for verification
}
```

### SecretManager

```lua
{
    register(name, value, level),  -- (method) Register secret
    get(name),                     -- (method) Get decrypted value
    getSecret(name),               -- (method) Get full object
    list(),                        -- (method) List all
    clear(name),                   -- (method) Clear one
    clearAll()                     -- (method) Clear all
}
```

### Vault

```lua
{
    unlock(password),              -- (method) Unlock vault
    lock(),                        -- (method) Lock vault
    store(name, value, level),     -- (method) Store secret
    retrieve(name),                -- (method) Get secret
    getSecret(name),               -- (method) Get full object
    list(),                        -- (method) List contents
    delete(name)                   -- (method) Delete secret
}
```

### Audit Entry

```lua
{
    timestamp,                     -- (number) Unix timestamp
    action,                        -- (string) Action type
    name,                          -- (string) Secret name
    details                        -- (table) Action-specific data
}
```

---

## Constants

```lua
StringObfuscation.VERSION = "2.0"           -- Library version
```

## Encryption Levels

| Level | Key Strategy | Security | Speed | Use Case |
|-------|--------------|----------|-------|----------|
| 1 | Single rotation | Basic | 100% | Debug tags |
| 2 | Double rotation | Medium | 98% | API keys |
| 3 | Triple rotation | High | 95% | Passwords |

---

## Error Handling

StringObfuscation functions don't throw errors - they return nil or false on failure:

```lua
-- Safe patterns
local secret = StringObfuscation.makeSecret("value", "name")
local value = secret.value  -- Returns nil if cleared

local result = manager:clear("name")  -- Returns false if not found

local unlocked = vault:unlock("password")  -- Returns false if wrong
```

---

## Performance Characteristics

| Operation | Time | Notes |
|-----------|------|-------|
| Encrypt 100 bytes | ~0.5ms | Level-dependent |
| Decrypt 100 bytes | ~0.5ms | Level-dependent |
| First secret.value access | ~1ms | Includes decryption |
| Subsequent .value access | <0.1ms | Uses cache |
| Manager.get() | ~1ms | Decrypts if needed |
| Vault.retrieve() | ~1ms | Decrypts if needed |

---

## Version History

### v2.0 (Current)
- Multi-level encryption (3 levels)
- SecretManager for organized secrets
- Vault system with password protection
- Audit logging for all operations
- Statistics tracking
- Batch operations
- Memory clearing
- Hash verification

---

**For examples, see:**
- `StringObfuscation_QUICKSTART.md` - Quick reference
- `tests/StringObfuscation_DEMO.lua` - Working examples
- `StringObfuscation_ADVANCED.md` - Advanced usage
- `tests/StringObfuscation_TESTS.lua` - Test suite
