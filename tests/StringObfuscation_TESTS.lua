--[[
StringObfuscation Test Suite
Comprehensive tests for all encryption and secret management features.
]]

-- Locate the module: next to this script, or under a sibling "security" folder
-- (matches the repo layout: tests/ alongside src/security/).
local module = script.Parent:FindFirstChild("StringObfuscation")
    or (script.Parent.Parent and script.Parent.Parent:FindFirstChild("security")
        and script.Parent.Parent.security:FindFirstChild("StringObfuscation"))
assert(module, "[Tests] StringObfuscation module not found (expected next to this script or in a sibling 'security' folder)")
local StringObfuscation = require(module)

local Tests = {
    passed = 0,
    failed = 0,
    tests = {},
}

local function assert_equal(actual, expected, message)
    if actual == expected then
        return true
    else
        error(message or "Assertion failed: " .. tostring(actual) .. " ~= " .. tostring(expected))
    end
end

local function assert_true(value, message)
    if value then
        return true
    else
        error(message or "Assertion failed: value is not true")
    end
end

local function assert_false(value, message)
    if not value then
        return true
    else
        error(message or "Assertion failed: value is not false")
    end
end

local function assert_not_nil(value, message)
    if value ~= nil then
        return true
    else
        error(message or "Assertion failed: value is nil")
    end
end

local function test(name, fn)
    table.insert(Tests.tests, { name = name, fn = fn })
end

local function run_tests()
    print("\n" .. string.rep("=", 70))
    print("STRING OBFUSCATION TEST SUITE")
    print(string.rep("=", 70) .. "\n")

    for _, test_case in ipairs(Tests.tests) do
        local success, err = pcall(test_case.fn)

        if success then
            Tests.passed = Tests.passed + 1
            print("[PASS] " .. test_case.name)
        else
            Tests.failed = Tests.failed + 1
            print("[FAIL] " .. test_case.name)
            print("       Error: " .. tostring(err))
        end
    end

    print("\n" .. string.rep("=", 70))
    print("Results: " .. Tests.passed .. " passed, " .. Tests.failed .. " failed")
    print(string.rep("=", 70) .. "\n")

    return Tests.failed == 0
end

-- ============================================================================
-- BASIC ENCRYPTION TESTS
-- ============================================================================

test("Basic encryption", function()
    local original = "hello_world"
    local encrypted = StringObfuscation.encrypt(original, 1)
    assert_not_nil(encrypted)
    assert_true(#encrypted == #original, "Encrypted length should match original")
    assert_false(table.concat(encrypted) == original, "Encrypted should not be plaintext")
end)

test("Basic decryption", function()
    local original = "hello_world"
    local encrypted = StringObfuscation.encrypt(original, 1)
    local decrypted = StringObfuscation.decrypt(encrypted, 1)
    assert_equal(decrypted, original, "Decrypted should match original")
end)

test("Obfuscate/deobfuscate", function()
    local original = "secret_api_key_123"
    local obfuscated = StringObfuscation.obfuscate(original)
    local deobfuscated = StringObfuscation.deobfuscate(obfuscated)
    assert_equal(deobfuscated, original)
end)

test("Empty string encryption", function()
    local original = ""
    local encrypted = StringObfuscation.encrypt(original, 1)
    local decrypted = StringObfuscation.decrypt(encrypted, 1)
    assert_equal(decrypted, original)
end)

test("Long string encryption", function()
    local original = string.rep("A", 10000)
    local encrypted = StringObfuscation.encrypt(original, 1)
    local decrypted = StringObfuscation.decrypt(encrypted, 1)
    assert_equal(decrypted, original)
end)

-- ============================================================================
-- ENCRYPTION LEVEL TESTS
-- ============================================================================

test("Level 1 encryption", function()
    local original = "test_level_1"
    local encrypted = StringObfuscation.encrypt(original, 1)
    local decrypted = StringObfuscation.decrypt(encrypted, 1)
    assert_equal(decrypted, original)
end)

test("Level 2 encryption", function()
    local original = "test_level_2"
    local encrypted = StringObfuscation.encrypt(original, 2)
    local decrypted = StringObfuscation.decrypt(encrypted, 2)
    assert_equal(decrypted, original)
end)

test("Level 3 encryption", function()
    local original = "test_level_3"
    local encrypted = StringObfuscation.encrypt(original, 3)
    local decrypted = StringObfuscation.decrypt(encrypted, 3)
    assert_equal(decrypted, original)
end)

test("Different levels produce different output", function()
    local original = "same_string"
    local enc1 = StringObfuscation.encrypt(original, 1)
    local enc2 = StringObfuscation.encrypt(original, 2)
    local enc3 = StringObfuscation.encrypt(original, 3)

    -- Check that they're not identical
    local enc1_str = table.concat(enc1)
    local enc2_str = table.concat(enc2)
    local enc3_str = table.concat(enc3)

    assert_false(enc1_str == enc2_str, "Level 1 and 2 should differ")
    assert_false(enc2_str == enc3_str, "Level 2 and 3 should differ")
end)

-- ============================================================================
-- SECRET OBJECT TESTS
-- ============================================================================

test("makeSecret creates secret object", function()
    local secret = StringObfuscation.makeSecret("my_secret", "test_secret", 1)
    assert_not_nil(secret)
    assert_equal(secret.name, "test_secret")
    assert_equal(secret.level, 1)
end)

test("Secret value access works", function()
    local original = "secret_value"
    local secret = StringObfuscation.makeSecret(original, "test", 1)
    assert_equal(secret.value, original)
end)

test("Secret tostring returns [SECRET:name]", function()
    local secret = StringObfuscation.makeSecret("hidden", "my_secret", 1)
    local str = tostring(secret)
    assert_true(string.find(str, "SECRET") ~= nil)
    assert_true(string.find(str, "my_secret") ~= nil)
end)

test("Secret access_count increments", function()
    local secret = StringObfuscation.makeSecret("test", "counter", 1)
    assert_equal(secret.access_count, 0)
    local _ = secret.value
    assert_equal(secret.access_count, 1)
    local _ = secret.value
    assert_equal(secret.access_count, 2)
end)

test("Secret creation_time is set", function()
    local before = os.time()
    local secret = StringObfuscation.makeSecret("test", "timer", 1)
    local after = os.time()

    local created = secret.creation_time
    assert_true(created >= before and created <= after + 1)
end)

test("Secret age_seconds increases", function()
    local secret = StringObfuscation.makeSecret("test", "aging", 1)
    local age1 = secret.age_seconds

    -- Small delay
    for i = 1, 10000 do end

    local age2 = secret.age_seconds
    assert_true(age2 >= age1, "Age should increase or stay same")
end)

test("Secret last_access updates", function()
    local secret = StringObfuscation.makeSecret("test", "access_time", 1)
    local before = os.time()
    local _ = secret.value
    local accessed = secret.last_access
    local after = os.time()

    assert_true(accessed >= before and accessed <= after + 1)
end)

-- ============================================================================
-- SECRET CLEARING TESTS
-- ============================================================================

test("clearSecret works", function()
    local secret = StringObfuscation.makeSecret("test", "clear_test", 1)
    local value = secret.value  -- Access once

    assert_true(StringObfuscation.clearSecret(secret))
    assert_equal(secret.is_cleared, true)
end)

test("Cleared secret cannot be accessed", function()
    local secret = StringObfuscation.makeSecret("test", "clear_access", 1)
    StringObfuscation.clearSecret(secret)

    local value = secret.value
    assert_equal(value, nil)
end)

-- ============================================================================
-- BATCH OPERATIONS TESTS
-- ============================================================================

test("batchEncrypt", function()
    local strings = { "str1", "str2", "str3" }
    local encrypted = StringObfuscation.batchEncrypt(strings, 1)

    assert_equal(#encrypted, #strings)
end)

test("batchDecrypt", function()
    local strings = { "str1", "str2", "str3" }
    local encrypted = StringObfuscation.batchEncrypt(strings, 1)
    local decrypted = StringObfuscation.batchDecrypt(encrypted, 1)

    for i, str in ipairs(strings) do
        assert_equal(decrypted[i], str)
    end
end)

test("Batch operations preserve order", function()
    local strings = { "apple", "banana", "cherry", "date" }
    local encrypted = StringObfuscation.batchEncrypt(strings, 2)
    local decrypted = StringObfuscation.batchDecrypt(encrypted, 2)

    for i, str in ipairs(strings) do
        assert_equal(decrypted[i], str, "Order should be preserved at index " .. i)
    end
end)

-- ============================================================================
-- SECRET MANAGER TESTS
-- ============================================================================

test("SecretManager registration", function()
    local manager = StringObfuscation.createSecretManager()
    manager:register("key1", "value1", 1)

    local value = manager:get("key1")
    assert_equal(value, "value1")
end)

test("SecretManager multiple secrets", function()
    local manager = StringObfuscation.createSecretManager()
    manager:register("key1", "value1", 1)
    manager:register("key2", "value2", 1)
    manager:register("key3", "value3", 1)

    assert_equal(manager:get("key1"), "value1")
    assert_equal(manager:get("key2"), "value2")
    assert_equal(manager:get("key3"), "value3")
end)

test("SecretManager list", function()
    local manager = StringObfuscation.createSecretManager()
    manager:register("key1", "value1", 1)
    manager:register("key2", "value2", 1)

    local list = manager:list()
    assert_equal(#list, 2)
end)

test("SecretManager clear", function()
    local manager = StringObfuscation.createSecretManager()
    manager:register("key1", "value1", 1)

    assert_true(manager:clear("key1"))
    assert_equal(manager:get("key1"), nil)
end)

test("SecretManager clearAll", function()
    local manager = StringObfuscation.createSecretManager()
    manager:register("key1", "value1", 1)
    manager:register("key2", "value2", 1)

    manager:clearAll()
    local list = manager:list()
    assert_equal(#list, 0)
end)

-- ============================================================================
-- VAULT TESTS
-- ============================================================================

test("Vault creation and locking", function()
    local vault = StringObfuscation.createVault("password")
    assert_equal(vault._locked, true)
end)

test("Vault unlock with correct password", function()
    local vault = StringObfuscation.createVault("correct_password")
    local result = vault:unlock("correct_password")
    assert_true(result)
    assert_equal(vault._locked, false)
end)

test("Vault unlock with wrong password", function()
    local vault = StringObfuscation.createVault("correct_password")
    local result = vault:unlock("wrong_password")
    assert_false(result)
    assert_equal(vault._locked, true)
end)

test("Vault store while locked fails", function()
    local vault = StringObfuscation.createVault("password")
    local result = vault:store("key", "value", 1)
    assert_false(result)
end)

test("Vault store after unlock succeeds", function()
    local vault = StringObfuscation.createVault("password")
    vault:unlock("password")
    local result = vault:store("key", "value", 1)
    assert_true(result)
end)

test("Vault retrieve", function()
    local vault = StringObfuscation.createVault("password")
    vault:unlock("password")
    vault:store("key", "secret_value", 1)

    local value = vault:retrieve("key")
    assert_equal(value, "secret_value")
end)

test("Vault list", function()
    local vault = StringObfuscation.createVault("password")
    vault:unlock("password")
    vault:store("key1", "value1", 1)
    vault:store("key2", "value2", 1)

    local list = vault:list()
    assert_equal(#list, 2)
end)

test("Vault delete", function()
    local vault = StringObfuscation.createVault("password")
    vault:unlock("password")
    vault:store("key1", "value1", 1)

    assert_true(vault:delete("key1"))
    assert_equal(vault:retrieve("key1"), nil)
end)

test("Vault lock", function()
    local vault = StringObfuscation.createVault("password")
    vault:unlock("password")
    vault:lock()

    assert_equal(vault._locked, true)
    local result = vault:retrieve("key")
    assert_equal(result, nil)
end)

-- ============================================================================
-- STATISTICS AND AUDIT TESTS
-- ============================================================================

test("Statistics tracking", function()
    local initial_stats = StringObfuscation.getStats()

    StringObfuscation.encrypt("test", 1)
    local after_encrypt = StringObfuscation.getStats()

    assert_true(after_encrypt.encryptions > initial_stats.encryptions)
end)

test("Audit log creation", function()
    StringObfuscation.clearAuditLog()
    StringObfuscation.makeSecret("test", "audit_test", 1)

    local log = StringObfuscation.getAuditLog()
    assert_true(#log > 0)
end)

test("Audit log filtering by action", function()
    StringObfuscation.clearAuditLog()
    StringObfuscation.makeSecret("test1", "sec1", 1)
    StringObfuscation.makeSecret("test2", "sec2", 1)

    local filtered = StringObfuscation.getAuditLog({ action = "secret_created" })
    assert_true(#filtered >= 2)
end)

test("Audit log filtering by name", function()
    StringObfuscation.clearAuditLog()
    StringObfuscation.makeSecret("test", "specific_name", 1)

    local filtered = StringObfuscation.getAuditLog({ name = "specific_name" })
    assert_true(#filtered > 0)
end)

test("clearAuditLog", function()
    StringObfuscation.makeSecret("test", "clear_audit", 1)
    StringObfuscation.clearAuditLog()

    local log = StringObfuscation.getAuditLog()
    assert_equal(#log, 0)
end)

-- ============================================================================
-- SPECIAL CASES
-- ============================================================================

test("Special characters in strings", function()
    local special = "!@#$%^&*()_+-=[]{}|;:,.<>?"
    local encrypted = StringObfuscation.encrypt(special, 1)
    local decrypted = StringObfuscation.decrypt(encrypted, 1)
    assert_equal(decrypted, special)
end)

test("Unicode characters handling", function()
    local unicode = "Hello 世界 🌍"
    local encrypted = StringObfuscation.encrypt(unicode, 1)
    local decrypted = StringObfuscation.decrypt(encrypted, 1)
    assert_equal(decrypted, unicode)
end)

test("Numbers as strings", function()
    local numbers = "1234567890"
    local encrypted = StringObfuscation.encrypt(numbers, 1)
    local decrypted = StringObfuscation.decrypt(encrypted, 1)
    assert_equal(decrypted, numbers)
end)

test("Whitespace preservation", function()
    local with_spaces = "hello   world\n\t\r"
    local encrypted = StringObfuscation.encrypt(with_spaces, 1)
    local decrypted = StringObfuscation.decrypt(encrypted, 1)
    assert_equal(decrypted, with_spaces)
end)

-- ============================================================================
-- Run all tests
-- ============================================================================

run_tests()
