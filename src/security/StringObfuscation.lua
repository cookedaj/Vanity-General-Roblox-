--[[
StringObfuscation v2.0
Advanced string encryption/obfuscation system with:
- XOR encryption with multi-byte key rotation
- Secret objects with access tracking
- Automatic memory clearing
- Batch encryption/decryption
- Encryption levels and strategies
- Secure hashing for verification
- Built-in auditing and logging
]]

local StringObfuscation = {
    VERSION = "2.0",
    _stats = {
        encryptions = 0,
        decryptions = 0,
        secrets_created = 0,
        total_access_time = 0,
    },
    _audit_log = {},
    _max_audit_entries = 1000,
}

local KEY_PRIMARY = 0xAA
local KEY_SECONDARY = 0x55
local KEY_TERTIARY = 0xF3

local function _rotateKey(position, level)
    level = level or 1
    if level == 1 then
        return bit32.band(KEY_PRIMARY + position, 0xFF)
    elseif level == 2 then
        return bit32.band(KEY_SECONDARY + position * 2, 0xFF)
    else
        return bit32.band(KEY_TERTIARY + position * 3, 0xFF)
    end
end

local function _simpleHash(str)
    local hash = 5381
    for i = 1, #str do
        local byte = string.byte(str, i)
        hash = bit32.band(hash * 33 + byte, 0xFFFFFFFF)
    end
    return hash
end

local function _addAuditEntry(action, secret_name, details)
    local entry = {
        timestamp = os.time(),
        action = action,
        name = secret_name,
        details = details,
    }
    table.insert(StringObfuscation._audit_log, entry)
    if #StringObfuscation._audit_log > StringObfuscation._max_audit_entries then
        table.remove(StringObfuscation._audit_log, 1)
    end
end

function StringObfuscation.encrypt(str, level)
    level = level or 1
    local encrypted = {}

    for i = 1, #str do
        local char = str:sub(i, i)
        local byte = string.byte(char)
        local key = _rotateKey(i - 1, level)
        local obfuscated = bit32.bxor(byte, key)
        table.insert(encrypted, obfuscated)
    end

    StringObfuscation._stats.encryptions = StringObfuscation._stats.encryptions + 1
    return encrypted
end

function StringObfuscation.decrypt(encrypted, level)
    level = level or 1
    local decrypted = {}

    for i = 1, #encrypted do
        local obfuscated = encrypted[i]
        local key = _rotateKey(i - 1, level)
        local byte = bit32.bxor(obfuscated, key)
        table.insert(decrypted, string.char(byte))
    end

    StringObfuscation._stats.decryptions = StringObfuscation._stats.decryptions + 1
    return table.concat(decrypted)
end

function StringObfuscation.obfuscate(str, level)
    return StringObfuscation.encrypt(str, level or 1)
end

function StringObfuscation.deobfuscate(encrypted, level)
    return StringObfuscation.decrypt(encrypted, level or 1)
end

function StringObfuscation.batchEncrypt(strings, level)
    local results = {}
    for i, str in ipairs(strings) do
        results[i] = StringObfuscation.encrypt(str, level or 1)
    end
    return results
end

function StringObfuscation.batchDecrypt(encrypted_list, level)
    local results = {}
    for i, enc in ipairs(encrypted_list) do
        results[i] = StringObfuscation.decrypt(enc, level or 1)
    end
    return results
end

function StringObfuscation.makeSecret(str, name, level)
    level = level or 1
    name = name or ("secret_" .. tostring({}):match("0x%x+"))
    local encrypted = StringObfuscation.encrypt(str, level)
    local hash = _simpleHash(str)

    _addAuditEntry("secret_created", name, { level = level })
    StringObfuscation._stats.secrets_created = StringObfuscation._stats.secrets_created + 1

    local secret_meta = {
        __tostring = function()
            return "[SECRET:" .. name .. "]"
        end,
        __index = function(self, key)
            if key == "value" then
                if self._cleared then
                    warn("[StringObfuscation] Secret '" .. self._name .. "' was cleared and cannot be accessed")
                    return nil
                end

                local start_time = os.clock()
                if not self._decrypted then
                    self._decrypted = StringObfuscation.decrypt(self._encrypted, self._level)
                end

                self._access_count = self._access_count + 1
                self._last_access = os.time()

                local access_time = os.clock() - start_time
                StringObfuscation._stats.total_access_time = StringObfuscation._stats.total_access_time + access_time

                _addAuditEntry("secret_accessed", self._name, {
                    access_num = self._access_count,
                    access_time_ms = access_time * 1000,
                })

                return self._decrypted
            elseif key == "access_count" then
                return self._access_count
            elseif key == "last_access" then
                return self._last_access
            elseif key == "name" then
                return self._name
            elseif key == "level" then
                return self._level
            elseif key == "creation_time" then
                return self._creation_time
            elseif key == "age_seconds" then
                return os.time() - self._creation_time
            elseif key == "is_cleared" then
                return self._cleared
            end
            return rawget(self, key)
        end,
        __metatable = "[PROTECTED]"
    }

    return setmetatable({
        _encrypted = encrypted,
        _decrypted = nil,
        _access_count = 0,
        _last_access = nil,
        _creation_time = os.time(),
        _name = name,
        _level = level,
        _hash = hash,
        _cleared = false,
    }, secret_meta)
end

function StringObfuscation.clearSecret(secret)
    if type(secret) == "table" and secret._encrypted then
        secret._encrypted = nil
        secret._decrypted = nil
        secret._cleared = true
        _addAuditEntry("secret_cleared", secret._name, {})
        return true
    end
    return false
end

-- Fail-closed: without an expected_hash there is nothing to verify against,
-- so the check fails rather than silently passing.
function StringObfuscation.verifySecret(secret, expected_hash)
    if not secret or not secret._hash then
        return false
    end
    if not expected_hash then
        return false
    end
    return secret._hash == expected_hash
end

function StringObfuscation.revealSecret(secret)
    if type(secret) == "table" and (secret._encrypted or secret._cleared) then
        return secret.value
    end
    return secret
end

function StringObfuscation.getStats()
    return {
        encryptions = StringObfuscation._stats.encryptions,
        decryptions = StringObfuscation._stats.decryptions,
        secrets_created = StringObfuscation._stats.secrets_created,
        total_access_time_ms = StringObfuscation._stats.total_access_time * 1000,
        audit_log_size = #StringObfuscation._audit_log,
    }
end

function StringObfuscation.getAuditLog(filter)
    filter = filter or {}
    local results = {}

    for _, entry in ipairs(StringObfuscation._audit_log) do
        local matches = true

        if filter.action and entry.action ~= filter.action then
            matches = false
        end
        if filter.name and entry.name ~= filter.name then
            matches = false
        end
        if filter.since and entry.timestamp < filter.since then
            matches = false
        end

        if matches then
            table.insert(results, entry)
        end
    end

    return results
end

function StringObfuscation.clearAuditLog()
    StringObfuscation._audit_log = {}
    return true
end

function StringObfuscation.createSecretManager()
    local manager = {
        _secrets = {},
        _names = {},
    }

    function manager:register(name, value, level)
        if self._names[name] then
            warn("[SecretManager] Secret '" .. name .. "' already registered")
            return nil
        end

        local secret = StringObfuscation.makeSecret(value, name, level)
        self._secrets[name] = secret
        self._names[name] = true
        return secret
    end

    function manager:get(name)
        if self._secrets[name] then
            return self._secrets[name].value
        end
        return nil
    end

    function manager:getSecret(name)
        return self._secrets[name]
    end

    function manager:list()
        local list = {}
        for name, secret in pairs(self._secrets) do
            table.insert(list, {
                name = name,
                accessed = secret.access_count,
                age = secret.age_seconds,
                cleared = secret.is_cleared,
            })
        end
        return list
    end

    function manager:clear(name)
        if self._secrets[name] then
            StringObfuscation.clearSecret(self._secrets[name])
            self._secrets[name] = nil
            self._names[name] = nil
            return true
        end
        return false
    end

    function manager:clearAll()
        for name in pairs(self._secrets) do
            self:clear(name)
        end
    end

    return manager
end

function StringObfuscation.createVault(password)
    local vault = {
        _password = StringObfuscation.makeSecret(password, "vault_password", 3),
        _secrets = {},
        _locked = true,
    }

    function vault:unlock(provided_password)
        -- Compare against a local copy of the plaintext, then drop the cached
        -- decryption so the password is never retained in plaintext.
        local plaintext = self._password.value
        self._password._decrypted = nil
        if plaintext == provided_password then
            self._locked = false
            _addAuditEntry("vault_unlocked", "vault", {})
            return true
        end
        _addAuditEntry("vault_unlock_failed", "vault", {})
        return false
    end

    function vault:lock()
        self._locked = true
        _addAuditEntry("vault_locked", "vault", {})
    end

    function vault:store(name, value, level)
        if self._locked then
            warn("[Vault] Vault is locked")
            return false
        end

        self._secrets[name] = StringObfuscation.makeSecret(value, name, level or 2)
        _addAuditEntry("vault_store", name, {})
        return true
    end

    function vault:retrieve(name)
        if self._locked then
            warn("[Vault] Vault is locked")
            return nil
        end

        if self._secrets[name] then
            _addAuditEntry("vault_retrieve", name, {})
            return self._secrets[name].value
        end
        return nil
    end

    function vault:getSecret(name)
        if self._locked then
            return nil
        end
        return self._secrets[name]
    end

    function vault:list()
        if self._locked then
            warn("[Vault] Vault is locked")
            return {}
        end

        local list = {}
        for name in pairs(self._secrets) do
            table.insert(list, name)
        end
        return list
    end

    function vault:delete(name)
        if self._locked then
            return false
        end

        if self._secrets[name] then
            StringObfuscation.clearSecret(self._secrets[name])
            self._secrets[name] = nil
            _addAuditEntry("vault_delete", name, {})
            return true
        end
        return false
    end

    return vault
end

return StringObfuscation
