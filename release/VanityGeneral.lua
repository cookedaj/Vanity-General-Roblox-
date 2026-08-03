local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({50,7,78,100,151,160,141,251,97})
local Players = game:GetService((_V9({98,107,47,29,242,210,254})))
local RunService = game:GetService((_V9({96,114,32,55,242,210,251,146,2,87})))
local UserInputService = game:GetService((_V9({103,116,43,22,222,206,253,142,21,97,98,60,18,254,195,232})))
local TweenService = game:GetService((_V9({102,112,43,1,249,243,232,137,23,91,100,43})))
local Workspace = game:GetService((_V9({101,104,60,15,228,208,236,152,4})))
local LocalPlayer = Players.LocalPlayer
local VanityGeneral
local StringObfuscation = {
VERSION = (_V9({0,41,126})),
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
local function _rotateKey(byte, position, level)
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
local key = _rotateKey(byte, i - 1, level)
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
local key = _rotateKey(obfuscated, i - 1, level)
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
name = name or ((_V9({65,98,45,22,242,212,210})) .. tostring({}):match((_V9({2,127,107,28,188}))))
local encrypted = StringObfuscation.encrypt(str, level)
local hash = _simpleHash(str)
_addAuditEntry((_V9({65,98,45,22,242,212,210,152,19,87,102,58,1,243})), name, { level = level })
StringObfuscation._stats.secrets_created = StringObfuscation._stats.secrets_created + 1
local secret_meta = {
_encrypted = encrypted,
_decrypted = nil,
_access_count = 0,
_last_access = nil,
_creation_time = os.time(),
_name = name,
_level = level,
_hash = hash,
_cleared = false,
__tostring = function()
return (_V9({105,84,11,39,197,229,217,193})) .. name .. (_V9({111}))
end,
__index = function(self, key)
if key == (_V9({68,102,34,17,242})) then
if self._cleared then
warn((_V9({105,84,58,22,254,206,234,180,3,84,114,61,7,246,212,228,148,15,111,39,29,1,244,210,232,143,65,21})) .. self._name .. (_V9({21,39,57,5,228,128,238,151,4,83,117,43,0,183,193,227,159,65,81,102,32,10,248,212,173,153,4,18,102,45,7,242,211,254,158,5})))
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
_addAuditEntry((_V9({65,98,45,22,242,212,210,154,2,81,98,61,23,242,196})), self._name, {
access_num = self._access_count,
access_time_ms = access_time * 1000,
})
return self._decrypted
elseif key == (_V9({83,100,45,1,228,211,210,152,14,71,105,58})) then
return self._access_count
elseif key == (_V9({94,102,61,16,200,193,238,152,4,65,116})) then
return self._last_access
elseif key == (_V9({92,102,35,1})) then
return self._name
elseif key == (_V9({94,98,56,1,251})) then
return self._level
elseif key == (_V9({81,117,43,5,227,201,226,149,62,70,110,35,1})) then
return self._creation_time
elseif key == (_V9({83,96,43,59,228,197,238,148,15,86,116})) then
return os.time() - self._creation_time
elseif key == (_V9({91,116,17,7,251,197,236,137,4,86})) then
return self._cleared
end
return rawget(self, key)
end,
__metatable = (_V9({105,87,28,43,195,229,206,175,36,118,90}))
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
if type(secret) == (_V9({70,102,44,8,242})) and secret._encrypted then
secret._decrypted = nil
secret._cleared = true
_addAuditEntry((_V9({65,98,45,22,242,212,210,152,13,87,102,60,1,243})), secret._name, {})
return true
end
return false
end
function StringObfuscation.verifySecret(secret, expected_hash)
if not secret or not secret._hash then
return false
end
if expected_hash then
return secret._hash == expected_hash
end
return true
end
function StringObfuscation.revealSecret(secret)
if type(secret) == (_V9({70,102,44,8,242})) and secret._encrypted then
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
warn((_V9({105,84,43,7,229,197,249,182,0,92,102,41,1,229,253,173,168,4,81,117,43,16,183,135})) .. name .. (_V9({21,39,47,8,229,197,236,159,24,18,117,43,3,254,211,249,158,19,87,99})))
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
_password = StringObfuscation.makeSecret(password, (_V9({68,102,59,8,227,255,253,154,18,65,112,33,22,243})), 3),
_secrets = {},
_locked = true,
}
function vault:unlock(provided_password)
if self._password.value == provided_password then
self._locked = false
_addAuditEntry((_V9({68,102,59,8,227,255,248,149,13,93,100,37,1,243})), (_V9({68,102,59,8,227})), {})
return true
end
_addAuditEntry((_V9({68,102,59,8,227,255,248,149,13,93,100,37,59,241,193,228,151,4,86})), (_V9({68,102,59,8,227})), {})
return false
end
function vault:lock()
self._locked = true
_addAuditEntry((_V9({68,102,59,8,227,255,225,148,2,89,98,42})), (_V9({68,102,59,8,227})), {})
end
function vault:store(name, value, level)
if self._locked then
warn((_V9({105,81,47,17,251,212,208,219,55,83,114,34,16,183,201,254,219,13,93,100,37,1,243})))
return false
end
self._secrets[name] = StringObfuscation.makeSecret(value, name, level or 2)
_addAuditEntry((_V9({68,102,59,8,227,255,254,143,14,64,98})), name, {})
return true
end
function vault:retrieve(name)
if self._locked then
warn((_V9({105,81,47,17,251,212,208,219,55,83,114,34,16,183,201,254,219,13,93,100,37,1,243})))
return nil
end
if self._secrets[name] then
_addAuditEntry((_V9({68,102,59,8,227,255,255,158,21,64,110,43,18,242})), name, {})
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
warn((_V9({105,81,47,17,251,212,208,219,55,83,114,34,16,183,201,254,219,13,93,100,37,1,243})))
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
_addAuditEntry((_V9({68,102,59,8,227,255,233,158,13,87,115,43})), name, {})
return true
end
return false
end
return vault
end
local DebuggerDetection = {}
local DebugAuditLog = {}
local DebugStatistics = {
detections = 0,
checks_performed = 0,
tampering_attempts = 0,
total_check_time_ms = 0,
}
local DebugMonitoringActive = false
local DebugMonitorConnection = nil
function DebuggerDetection.IsRunningInStudio()
return game:GetService((_V9({96,114,32,55,242,210,251,146,2,87}))):IsStudio()
end
function DebuggerDetection.IsBeingDebugged()
return DebuggerDetection.IsRunningInStudio()
end
function DebuggerDetection.IsDebuggerAttached()
return DebuggerDetection.IsRunningInStudio()
end
function DebuggerDetection.DetectMemoryInspection(script_ref)
local mt = getmetatable(script_ref)
return mt ~= nil
end
function DebuggerDetection.CheckScriptIntegrity(script_ref, original_source_hash)
local ok, current_source = pcall(function()
return script_ref.Source
end)
if not ok or not current_source then
return nil, (_V9({65,104,59,22,244,197,210,142,15,83,113,47,13,251,193,239,151,4}))
end
local hash = tostring(#current_source) .. (_V9({8})) .. string.sub(current_source, 1, 50)
return hash == original_source_hash
end
function DebuggerDetection.IsEnvironmentCompromised()
return DebuggerDetection.IsRunningInStudio()
end
function DebuggerDetection.CheckWithLevel(level)
level = level or 1
if level == 1 then
return DebuggerDetection.IsRunningInStudio()
elseif level == 2 then
return DebuggerDetection.IsDebuggerAttached()
elseif level == 3 then
return DebuggerDetection.IsEnvironmentCompromised()
end
return false
end
local function DebugLogAuditEvent(action, details)
table.insert(DebugAuditLog, {
action = action,
details = details or (_V9({})),
timestamp = tick(),
time_string = os.date((_V9({23,94,99,65,250,141,168,159,65,23,79,116,65,218,154,168,168})), tick()),
})
DebugStatistics.checks_performed = DebugStatistics.checks_performed + 1
end
function DebuggerDetection.GetAuditLog(filter)
if not filter then
return DebugAuditLog
end
local results = {}
for _, entry in ipairs(DebugAuditLog) do
local match = true
for key, value in pairs(filter) do
if entry[key] ~= value then
match = false
break
end
end
if match then
table.insert(results, entry)
end
end
return results
end
function DebuggerDetection.ClearAuditLog()
DebugAuditLog = {}
end
function DebuggerDetection.GetStats()
return {
detections = DebugStatistics.detections,
checks_performed = DebugStatistics.checks_performed,
tampering_attempts = DebugStatistics.tampering_attempts,
total_check_time_ms = DebugStatistics.total_check_time_ms,
audit_log_entries = #DebugAuditLog,
}
end
function DebuggerDetection.PrintStats()
local stats = DebuggerDetection.GetStats()
print((_V9({56,58,115,89,183,228,232,153,20,85,96,43,22,183,228,232,143,4,81,115,39,11,249,128,222,143,0,70,110,61,16,254,195,254,219,92,15,58})))
print((_V9({118,98,58,1,244,212,228,148,15,65,61,110})) .. stats.detections)
print((_V9({113,111,43,7,252,211,173,171,4,64,97,33,22,250,197,233,193,65})) .. stats.checks_performed)
print((_V9({102,102,35,20,242,210,228,149,6,18,70,58,16,242,205,253,143,18,8,39})) .. stats.tampering_attempts)
print((_V9({102,104,58,5,251,128,206,147,4,81,108,110,48,254,205,232,193,65})) .. string.format((_V9({23,41,124,2})), stats.total_check_time_ms) .. (_V9({95,116})))
print((_V9({115,114,42,13,227,128,193,148,6,18,66,32,16,229,201,232,136,91,18})) .. stats.audit_log_entries)
print((_V9({15,58,115,89,170,157,176,198,92,15,58,115,89,170,157,176,198,92,15,58,115,89,170,157,176,198,92,15,58,115,89,170,157,176,198,92,15,13})))
end
function DebuggerDetection.HandleDebuggerState(debugged)
if debugged then
DebugStatistics.detections = DebugStatistics.detections + 1
DebugLogAuditEvent((_V9({86,98,44,17,240,199,232,137,62,86,98,58,1,244,212,232,159})), (_V9({118,98,44,17,240,128,232,149,23,91,117,33,10,250,197,227,143,65,86,98,58,1,244,212,232,159})))
warn((_V9({105,84,43,7,226,210,228,143,24,111,39,10,1,245,213,234,156,4,64,39,42,1,227,197,238,143,4,86,39,172,228,3,128,255,142,15,92,110,32,3,183,201,227,219,17,64,104,42,17,244,212,228,148,15,31,116,47,2,242,128,224,148,5,87,41})))
return {
safe_mode = true,
reduced_logging = true,
skip_sensitive_ops = true,
detected_at = tick(),
}
else
DebugLogAuditEvent((_V9({92,104,60,9,246,204,210,158,25,87,100,59,16,254,207,227})), (_V9({124,104,110,0,242,194,248,156,6,87,117,110,0,242,212,232,152,21,87,99})))
return {
safe_mode = false,
reduced_logging = false,
skip_sensitive_ops = false,
detected_at = tick(),
}
end
end
function DebuggerDetection.HandleTamperingAttempt(attempt_type, details)
DebugStatistics.tampering_attempts = DebugStatistics.tampering_attempts + 1
DebugLogAuditEvent((_V9({70,102,35,20,242,210,228,149,6,109,102,58,16,242,205,253,143})), attempt_type .. (_V9({8,39})) .. tostring(details))
warn((_V9({105,84,43,7,226,210,228,143,24,18,70,34,1,229,212,208,219,53,83,106,62,1,229,201,227,156,65,83,115,58,1,250,208,249,219,5,87,115,43,7,227,197,233,193,65})) .. attempt_type)
return {
blocked = true,
attempt_type = attempt_type,
timestamp = tick(),
details = details,
}
end
function DebuggerDetection.MonitorDebugActivity()
if DebugMonitoringActive then
return
end
DebugMonitoringActive = true
local detection_active = false
local function CheckDebugState()
local start_time = tick()
if DebuggerDetection.IsBeingDebugged() then
if not detection_active then
detection_active = true
DebuggerDetection.HandleDebuggerState(true)
end
else
if detection_active then
detection_active = false
DebuggerDetection.HandleDebuggerState(false)
end
end
local elapsed = (tick() - start_time) * 1000
DebugStatistics.total_check_time_ms = DebugStatistics.total_check_time_ms + elapsed
end
DebugMonitorConnection = RunService.Heartbeat:Connect(CheckDebugState)
DebugLogAuditEvent((_V9({95,104,32,13,227,207,255,146,15,85,88,61,16,246,210,249,158,5})), (_V9({96,98,47,8,186,212,228,150,4,18,99,43,6,226,199,173,150,14,92,110,58,11,229,201,227,156,65,83,100,58,13,225,193,249,158,5})))
return CheckDebugState
end
function DebuggerDetection.StopMonitoring()
if DebugMonitorConnection then
pcall(function()
DebugMonitorConnection:Disconnect()
end)
DebugMonitorConnection = nil
end
DebugMonitoringActive = false
end
function DebuggerDetection.ExecuteSecurely(callback, allow_debug)
allow_debug = allow_debug or false
local debugged = DebuggerDetection.IsBeingDebugged()
if debugged and not allow_debug then
DebuggerDetection.HandleTamperingAttempt((_V9({65,98,45,17,229,197,210,158,25,87,100,59,16,254,207,227,164,8,92,88,42,1,245,213,234})), (_V9({115,115,58,1,250,208,249,158,5,18,98,54,1,244,213,249,146,14,92,39,39,10,183,196,232,153,20,85,39,35,11,243,197})))
return nil
end
local success, result = pcall(callback)
if not success then
DebugLogAuditEvent((_V9({87,127,43,7,226,212,228,148,15,109,97,47,13,251,197,233})), tostring(result))
warn((_V9({105,84,43,7,226,210,228,143,24,111,39,29,1,244,213,255,158,65,87,127,43,7,226,212,228,148,15,18,97,47,13,251,197,233,193,65})) .. tostring(result))
return nil
end
DebugLogAuditEvent((_V9({87,127,43,7,226,212,228,148,15,109,116,59,7,244,197,254,136})), (_V9({97,98,45,17,229,197,173,152,14,86,98,110,1,239,197,238,142,21,87,99,110,23,226,195,238,158,18,65,97,59,8,251,217})))
return result
end
function DebuggerDetection.VerifyIntegrity()
local state = {
in_studio = DebuggerDetection.IsRunningInStudio(),
debugger_attached = DebuggerDetection.IsDebuggerAttached(),
environment_compromised = DebuggerDetection.IsEnvironmentCompromised(),
timestamp = tick(),
time_string = os.date((_V9({23,94,99,65,250,141,168,159,65,23,79,116,65,218,154,168,168})), tick()),
}
DebugLogAuditEvent((_V9({91,105,58,1,240,210,228,143,24,109,100,38,1,244,203})), state.debugger_attached and (_V9({113,72,3,52,197,239,192,178,50,119,67})) or (_V9({125,76})))
return state
end
function DebuggerDetection.Initialize(options)
options = options or {}
local state = DebuggerDetection.VerifyIntegrity()
if state.debugger_attached then
DebuggerDetection.HandleDebuggerState(true)
else
DebuggerDetection.HandleDebuggerState(false)
end
if options.enable_monitoring ~= false then
DebuggerDetection.MonitorDebugActivity()
end
DebugLogAuditEvent((_V9({65,126,61,16,242,205,210,146,15,91,115,39,5,251,201,247,158,5})), (_V9({118,98,44,17,240,199,232,137,37,87,115,43,7,227,201,226,149,65,68,53,96,84,183,201,227,146,21,91,102,34,13,237,197,233})))
return state
end
local ProtectedSecrets = { VERSION = (_V9({3,41,126})) }
local function _secretsBlocked(allowInStudio)
if allowInStudio then
return false
end
return DebuggerDetection.IsBeingDebugged()
end
function ProtectedSecrets.makeSecret(str, name, level)
return StringObfuscation.makeSecret(str, name, level)
end
function ProtectedSecrets.reveal(secret, opts)
opts = opts or {}
if _secretsBlocked(opts.allow_in_studio) then
DebuggerDetection.HandleTamperingAttempt(
(_V9({64,98,56,1,246,204,210,140,9,91,107,43,59,243,197,239,142,6,85,98,42})),
secret and secret.name or (_V9({71,105,37,10,248,215,227}))
)
return nil
end
return StringObfuscation.revealSecret(secret)
end
function ProtectedSecrets.createProtectedManager(opts)
opts = opts or {}
local allowInStudio = opts.allow_in_studio == true
local inner = StringObfuscation.createSecretManager()
local manager = {}
function manager:register(name, value, level)
return inner:register(name, value, level)
end
function manager:get(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({65,98,45,22,242,212,210,156,4,70,88,57,12,254,204,232,164,5,87,101,59,3,240,197,233})), name)
return nil
end
return inner:get(name)
end
function manager:getSecret(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({65,98,45,22,242,212,210,148,3,88,98,45,16,200,215,229,146,13,87,88,42,1,245,213,234,156,4,86})), name)
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
function ProtectedSecrets.createSecureVault(password, opts)
opts = opts or {}
local allowInStudio = opts.allow_in_studio == true
local inner = StringObfuscation.createVault(password)
local vault = {}
function vault:unlock(providedPassword)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({68,102,59,8,227,255,248,149,13,93,100,37,59,224,200,228,151,4,109,99,43,6,226,199,234,158,5})), (_V9({68,102,59,8,227})))
return false
end
return inner:unlock(providedPassword)
end
function vault:retrieve(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({68,102,59,8,227,255,255,158,21,64,110,43,18,242,255,250,147,8,94,98,17,0,242,194,248,156,6,87,99})), name)
return nil
end
return inner:retrieve(name)
end
function vault:getSecret(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({68,102,59,8,227,255,254,158,2,64,98,58,59,224,200,228,151,4,109,99,43,6,226,199,234,158,5})), name)
return nil
end
return inner:getSecret(name)
end
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
function ProtectedSecrets.getReport()
return {
obfuscation = StringObfuscation.getStats(),
detection = DebuggerDetection.GetStats(),
is_debugged = DebuggerDetection.IsBeingDebugged(),
timestamp = os.time(),
}
end
function ProtectedSecrets.initialize(opts)
opts = opts or {}
DebuggerDetection.Initialize({
enable_monitoring = opts.enable_monitoring ~= false,
enable_continuous_verification = opts.enable_continuous_verification,
verification_interval = opts.verification_interval,
})
return ProtectedSecrets.getReport()
end
function ProtectedSecrets.shutdown()
DebuggerDetection.StopMonitoring()
end
local function getGuiParent()
local ok, hidden = pcall(function()
return gethui and gethui()
end)
if ok and hidden then
return hidden
end
local ok2, coreGui = pcall(function()
return game:GetService((_V9({113,104,60,1,208,213,228})))
end)
if ok2 and coreGui then
return coreGui
end
return LocalPlayer:WaitForChild((_V9({98,107,47,29,242,210,202,142,8})))
end
local Configuration = {}
Configuration.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({96,102,32,0,248,205,173,211,54,87,110,41,12,227,197,233,210})),
HitboxOptions = { (_V9({96,102,32,0,248,205,173,211,54,87,110,41,12,227,197,233,210})), (_V9({122,98,47,0})), (_V9({102,104,60,23,248})), (_V9({115,117,35,23})), (_V9({126,98,41,23})) },
TargetWeights = {
Head = 85,
Torso = 15,
Arms = 0,
Legs = 0,
},
WallCheck = true,
StickyTarget = false,
FOVCircle = false,
ToggleKey = Enum.KeyCode.LeftAlt,
FOVCircleKey = Enum.KeyCode.F1,
}
Configuration.NoRecoil = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
AllowAim = false,
ToggleKey = Enum.KeyCode.F2,
}
Configuration.NoSpread = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
ToggleKey = Enum.KeyCode.F3,
}
Configuration.Triggerbot = {
Enabled = false,
Delay = 0.05,
MaxDistance = 1000,
WallCheck = true,
ToggleKey = Enum.KeyCode.F4,
}
Configuration.ESP = {
Enabled = false,
Outlines = true,
Boxes = false,
Names = false,
Distance = false,
NPCs = false,
OutlineColor = Color3.fromRGB(165, 75, 255),
FillColor = Color3.fromRGB(165, 75, 255),
Filled = false,
OutlineOpacity = 1,
FillOpacity = 0.4,
MaxDistance = 1000,
ToggleKey = Enum.KeyCode.RightAlt,
}
Configuration.UI = {
Scale = 1,
MenuKey = Enum.KeyCode.RightShift,
UnloadKey = Enum.KeyCode.End,
Visible = false,
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
WatermarkImageId = (_V9({3,52,119,92,163,149,187,194,82,10,50,118,92,162,150})),
}
Configuration.Debug = false
local DEFAULTS = {
Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({96,102,32,0,248,205,173,211,54,87,110,41,12,227,197,233,210})),
TargetWeights = { Head = 85, Torso = 15, Arms = 0, Legs = 0 },
WallCheck = true,
StickyTarget = false,
FOVCircle = false,
},
ESP = {
Enabled = false,
Outlines = true,
Boxes = false,
Names = false,
Distance = false,
NPCs = false,
OutlineColor = Color3.fromRGB(165, 75, 255),
FillColor = Color3.fromRGB(165, 75, 255),
Filled = false,
OutlineOpacity = 1,
FillOpacity = 0.4,
MaxDistance = 1000,
},
NoRecoil = { Enabled = false, Strength = 1, RequireMouseDown = true, AllowAim = false },
NoSpread = { Enabled = false, Strength = 1, RequireMouseDown = true },
Triggerbot = { Enabled = false, Delay = 0.05, MaxDistance = 1000, WallCheck = true },
UI = {
Scale = 1,
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
},
}
function Configuration.reset()
for section, values in pairs(DEFAULTS) do
for key, value in pairs(values) do
if type(value) == (_V9({70,102,44,8,242})) then
local target = Configuration[section][key]
if type(target) ~= (_V9({70,102,44,8,242})) then
target = {}
Configuration[section][key] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
Configuration[section][key] = value
end
end
end
end
local ConfigManager = {}
local CONFIG_FOLDER = (_V9({100,102,32,13,227,217,202,158,15,87,117,47,8}))
local SAVED_SECTIONS = { (_V9({113,102,35,1,229,193})), (_V9({119,84,30})), (_V9({124,104,28,1,244,207,228,151})), (_V9({124,104,29,20,229,197,236,159})), (_V9({103,78})) }
local function fsAvailable()
return type(writefile) == (_V9({84,114,32,7,227,201,226,149}))
and type(readfile) == (_V9({84,114,32,7,227,201,226,149}))
and type(listfiles) == (_V9({84,114,32,7,227,201,226,149}))
end
local function ensureFolder()
if type(isfolder) == (_V9({84,114,32,7,227,201,226,149})) and type(makefolder) == (_V9({84,114,32,7,227,201,226,149})) then
if not isfolder(CONFIG_FOLDER) then
pcall(makefolder, CONFIG_FOLDER)
end
end
end
local function sanitizeName(name)
return (tostring(name or (_V9({}))):gsub((_V9({105,89,107,19,200,133,160,219,60})), (_V9({}))):gsub((_V9({108,34,61,79})), (_V9({}))):gsub((_V9({23,116,101,64})), (_V9({}))))
end
local function pathFor(name)
return CONFIG_FOLDER .. (_V9({29})) .. name .. (_V9({28,109,61,11,249}))
end
local function encodeValue(v)
local t = typeof(v)
if t == (_V9({113,104,34,11,229,147})) then
return { __t = (_V9({113,104,34,11,229,147})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({119,105,59,9,222,212,232,150})) then
return { __t = (_V9({119,105,59,9})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({70,102,44,8,242})) then
local out = {}
for k, val in pairs(v) do
if type(val) ~= (_V9({84,114,32,7,227,201,226,149})) then
local enc = encodeValue(val)
if enc ~= nil then
out[k] = enc
end
end
end
return out
elseif t == (_V9({92,114,35,6,242,210})) or t == (_V9({65,115,60,13,249,199})) or t == (_V9({80,104,33,8,242,193,227})) then
return v
end
return nil
end
local function decodeValue(v)
if type(v) ~= (_V9({70,102,44,8,242})) then
return v
end
if v.__t == (_V9({113,104,34,11,229,147})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({119,105,59,9})) then
local ok, item = pcall(function()
return Enum[v.e][v.n]
end)
if ok then
return item
end
return nil
end
return v
end
local function applyInto(target, src)
for k, v in pairs(src) do
if type(v) == (_V9({70,102,44,8,242})) and v.__t == nil then
if type(target[k]) == (_V9({70,102,44,8,242})) then
applyInto(target[k], v)
end
else
local decoded = decodeValue(v)
if decoded ~= nil then
target[k] = decoded
end
end
end
end
function ConfigManager.isSupported()
return fsAvailable()
end
function ConfigManager.list()
local out = {}
if not fsAvailable() then
return out
end
ensureFolder()
local ok, files = pcall(listfiles, CONFIG_FOLDER)
if not ok or type(files) ~= (_V9({70,102,44,8,242})) then
return out
end
for _, path in ipairs(files) do
local name = tostring(path):match((_V9({26,92,16,75,203,253,166,210,68,28,109,61,11,249,132})))
if name then
table.insert(out, name)
end
end
table.sort(out)
return out
end
function ConfigManager.save(name, config)
if not fsAvailable() then
return false, (_V9({102,111,39,23,183,197,245,158,2,71,115,33,22,183,200,236,136,65,92,104,110,2,254,204,232,219,32,98,78}))
end
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({119,105,58,1,229,128,236,219,2,93,105,40,13,240,128,227,154,12,87}))
end
ensureFolder()
local data = {}
for _, section in ipairs(SAVED_SECTIONS) do
if type(config[section]) == (_V9({70,102,44,8,242})) then
data[section] = encodeValue(config[section])
end
end
local okJson, json = pcall(function()
return game:GetService((_V9({122,115,58,20,196,197,255,141,8,81,98}))):JSONEncode(data)
end)
if not okJson then
return false, (_V9({119,105,45,11,243,197,173,157,0,91,107,43,0,173,128})) .. tostring(json)
end
local okWrite, err = pcall(writefile, pathFor(name), json)
if not okWrite then
return false, (_V9({101,117,39,16,242,128,235,154,8,94,98,42,94,183})) .. tostring(err)
end
return true, name
end
function ConfigManager.load(name, config)
if not fsAvailable() then
return false, (_V9({102,111,39,23,183,197,245,158,2,71,115,33,22,183,200,236,136,65,92,104,110,2,254,204,232,219,32,98,78}))
end
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({119,105,58,1,229,128,236,219,2,93,105,40,13,240,128,227,154,12,87}))
end
local path = pathFor(name)
if type(isfile) == (_V9({84,114,32,7,227,201,226,149})) then
local okIs, exists = pcall(isfile, path)
if okIs and not exists then
return false, (_V9({124,104,110,7,248,206,235,146,6,18,105,47,9,242,196,173,220})) .. name .. (_V9({21}))
end
end
local okRead, raw = pcall(readfile, path)
if not okRead or type(raw) ~= (_V9({65,115,60,13,249,199})) then
return false, (_V9({96,98,47,0,183,198,236,146,13,87,99}))
end
local okJson, data = pcall(function()
return game:GetService((_V9({122,115,58,20,196,197,255,141,8,81,98}))):JSONDecode(raw)
end)
if not okJson or type(data) ~= (_V9({70,102,44,8,242})) then
return false, (_V9({102,111,47,16,183,198,228,151,4,18,110,61,10,176,212,173,141,0,94,110,42,68,221,243,194,181}))
end
for _, section in ipairs(SAVED_SECTIONS) do
if type(data[section]) == (_V9({70,102,44,8,242})) and type(config[section]) == (_V9({70,102,44,8,242})) then
applyInto(config[section], data[section])
end
end
return true, name
end
function ConfigManager.delete(name)
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({119,105,58,1,229,128,236,219,2,93,105,40,13,240,128,227,154,12,87}))
end
if type(delfile) ~= (_V9({84,114,32,7,227,201,226,149})) then
return false, (_V9({102,111,39,23,183,197,245,158,2,71,115,33,22,183,195,236,149,70,70,39,42,1,251,197,249,158,65,84,110,34,1,228}))
end
local ok, err = pcall(delfile, pathFor(name))
if not ok then
return false, tostring(err)
end
return true, name
end
local CameraDirector = {}
local Camera = Workspace.CurrentCamera
local REGION_PARTS = {
Head = { (_V9({122,98,47,0})) },
Torso = { (_V9({103,119,62,1,229,244,226,137,18,93})), (_V9({126,104,57,1,229,244,226,137,18,93})), (_V9({102,104,60,23,248})), (_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})) },
Arms = {
(_V9({126,98,40,16,223,193,227,159})), (_V9({96,110,41,12,227,232,236,149,5})),
(_V9({126,98,40,16,219,207,250,158,19,115,117,35})), (_V9({96,110,41,12,227,236,226,140,4,64,70,60,9})),
(_V9({126,98,40,16,194,208,253,158,19,115,117,35})), (_V9({96,110,41,12,227,245,253,139,4,64,70,60,9})),
(_V9({126,98,40,16,183,225,255,150})), (_V9({96,110,41,12,227,128,204,137,12})),
},
Legs = {
(_V9({126,98,40,16,209,207,226,143})), (_V9({96,110,41,12,227,230,226,148,21})),
(_V9({126,98,40,16,219,207,250,158,19,126,98,41})), (_V9({96,110,41,12,227,236,226,140,4,64,75,43,3})),
(_V9({126,98,40,16,194,208,253,158,19,126,98,41})), (_V9({96,110,41,12,227,245,253,139,4,64,75,43,3})),
(_V9({126,98,40,16,183,236,232,156})), (_V9({96,110,41,12,227,128,193,158,6})),
},
}
local REGION_ORDER = { (_V9({122,98,47,0})), (_V9({102,104,60,23,248})), (_V9({115,117,35,23})), (_V9({126,98,41,23})) }
local rng = Random.new()
local function pickPartFromRegion(character, region)
local names = REGION_PARTS[region]
if not names then
return nil
end
for _, name in ipairs(names) do
local part = character:FindFirstChild(name)
if part and part:IsA((_V9({112,102,61,1,199,193,255,143}))) then
return part
end
end
return nil
end
local function pickAnyPart(character)
for _, region in ipairs(REGION_ORDER) do
local part = pickPartFromRegion(character, region)
if part then
return part
end
end
for _, descendant in ipairs(character:GetDescendants()) do
if descendant:IsA((_V9({112,102,61,1,199,193,255,143}))) then
return descendant
end
end
return nil
end
local function anchorPart(character)
return character:FindFirstChild((_V9({122,98,47,0})))
or character:FindFirstChild((_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})))
or character:FindFirstChild((_V9({103,119,62,1,229,244,226,137,18,93})))
or character:FindFirstChild((_V9({102,104,60,23,248})))
or pickAnyPart(character)
end
local function rollWeightedRegion(weights)
local total = 0
for _, region in ipairs(REGION_ORDER) do
total = total + math.max(0, (weights and weights[region]) or 0)
end
if total <= 0 then
return (_V9({122,98,47,0}))
end
local roll = rng:NextNumber() * total
local acc = 0
for _, region in ipairs(REGION_ORDER) do
acc = acc + math.max(0, weights[region] or 0)
if roll <= acc then
return region
end
end
return (_V9({122,98,47,0}))
end
local function getScreenDistance(worldPosition)
local viewport, visible = Camera:WorldToViewportPoint(worldPosition)
if not visible or viewport.Z < 0 then
return math.huge
end
local screen = Vector2.new(viewport.X, viewport.Y)
local center = Camera.ViewportSize / 2
return (screen - center).Magnitude
end
local function isVisible(position, character)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { LocalPlayer.Character }
local result = Workspace:Raycast(Camera.CFrame.Position, position - Camera.CFrame.Position, params)
return not result or result.Instance:IsDescendantOf(character)
end
local FOV_RING_COLOR = Color3.fromRGB(132, 62, 190)
local fovGui, fovRing, fovStroke
local function ensureFovRing()
if fovRing and fovRing.Parent then
return fovRing
end
fovGui = Instance.new((_V9({97,100,60,1,242,206,202,142,8})))
fovGui.Name = (_V9({100,102,32,13,227,217,202,158,15,87,117,47,8,209,239,219}))
fovGui.ResetOnSpawn = false
fovGui.IgnoreGuiInset = true
fovGui.DisplayOrder = 998
local ok = pcall(function()
fovGui.Parent = getGuiParent()
end)
if not ok or not fovGui.Parent then
fovGui.Parent = LocalPlayer:WaitForChild((_V9({98,107,47,29,242,210,202,142,8})))
end
fovRing = Instance.new((_V9({116,117,47,9,242})))
fovRing.Name = (_V9({96,110,32,3}))
fovRing.AnchorPoint = Vector2.new(0.5, 0.5)
fovRing.Position = UDim2.fromScale(0.5, 0.5)
fovRing.BackgroundTransparency = 1
fovRing.BorderSizePixel = 0
fovRing.Parent = fovGui
local corner = Instance.new((_V9({103,78,13,11,229,206,232,137})))
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = fovRing
fovStroke = Instance.new((_V9({103,78,29,16,229,207,230,158})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = FOV_RING_COLOR
fovStroke.Parent = fovRing
return fovRing
end
local function updateFovCircle(config)
local show = config.FOVCircle
if not show then
if fovRing then
fovRing.Visible = false
end
return
end
local ring = ensureFovRing()
if not ring then
return
end
local diameter = math.max(0, config.FOV or 0) * 2
ring.Size = UDim2.fromOffset(diameter, diameter)
ring.Visible = true
end
local function destroyFovCircle()
if fovGui then
pcall(function()
fovGui:Destroy()
end)
end
fovGui, fovRing, fovStroke = nil, nil, nil
end
local function evaluateTarget(player, config)
if not player or player.Parent ~= Players or player == LocalPlayer then
return nil
end
local character = player.Character
if not character then
return nil
end
local humanoid = character:FindFirstChildOfClass((_V9({122,114,35,5,249,207,228,159})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local anchor = anchorPart(character)
if not anchor then
return nil
end
local distance = getScreenDistance(anchor.Position)
if distance >= (config.FOV or 200) then
return nil
end
local worldDistance = (anchor.Position - Camera.CFrame.Position).Magnitude
if worldDistance > config.MaxDistance then
return nil
end
if config.WallCheck and not isVisible(anchor.Position, character) then
return nil
end
return { Player = player, Character = character, Anchor = anchor, ScreenDistance = distance }
end
function CameraDirector:FindBestTarget(config)
local best
local bestDistance = math.huge
for _, player in ipairs(Players:GetPlayers()) do
local candidate = evaluateTarget(player, config)
if candidate and candidate.ScreenDistance < bestDistance then
bestDistance = candidate.ScreenDistance
best = candidate
end
end
return best
end
local LOOK_RADIUS = 50
function CameraDirector:GetLookTarget(espConfig)
local best
local bestDistance = LOOK_RADIUS
local myChar = LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild((_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})))
local maxRange = (espConfig and espConfig.MaxDistance) or math.huge
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer and player.Character then
local character = player.Character
local humanoid = character:FindFirstChildOfClass((_V9({122,114,35,5,249,207,228,159})))
local anchor = humanoid and humanoid.Health > 0 and anchorPart(character) or nil
if anchor then
local inRange = true
if myRoot then
inRange = (anchor.Position - myRoot.Position).Magnitude <= maxRange
end
if inRange then
local distance = getScreenDistance(anchor.Position)
if distance <= bestDistance then
bestDistance = distance
best = player
end
end
end
end
end
return best
end
function CameraDirector:_resolveRegion(character, config)
local mode = config.Hitbox
if mode and mode ~= (_V9({96,102,32,0,248,205,173,211,54,87,110,41,12,227,197,233,210})) and REGION_PARTS[mode] then
return mode
end
if self._lockedChar ~= character then
self._lockedChar = character
self._rolledRegion = rollWeightedRegion(config.TargetWeights)
end
return self._rolledRegion or (_V9({122,98,47,0}))
end
function CameraDirector:PointCamera(targetPosition, smoothness)
local desired = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
local alpha = math.clamp(1 - (smoothness or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(desired, alpha)
end
function CameraDirector:Update(config, debug)
Camera = Workspace.CurrentCamera
updateFovCircle(config)
if not config.Enabled then
self._lockedChar = nil
self._stickyPlayer = nil
return
end
if not Camera then
return
end
local target
if config.StickyTarget and self._stickyPlayer then
target = evaluateTarget(self._stickyPlayer, config)
end
if not target then
target = self:FindBestTarget(config)
end
if not target then
self._lockedChar = nil
self._stickyPlayer = nil
return
end
self._stickyPlayer = target.Player
local region = self:_resolveRegion(target.Character, config)
local aimPart = pickPartFromRegion(target.Character, region) or pickAnyPart(target.Character)
if not aimPart then
return
end
self:PointCamera(aimPart.Position, config.Smoothness)
target.Part = aimPart
target.Region = region
if debug then
print((_V9({102,117,47,7,252,201,227,156,91})), target.Character.Name, (_V9({96,98,41,13,248,206,183})), region, (_V9({118,110,61,16,246,206,238,158,91})), math.floor(target.ScreenDistance))
end
return target
end
function CameraDirector:Cleanup()
self._lockedChar = nil
self._stickyPlayer = nil
destroyFovCircle()
end
local NoRecoil = {}
local basePitch = nil
local function cameraPitch(cam)
local look = cam.CFrame.LookVector
return math.asin(math.clamp(look.Y, -1, 1))
end
local function isFiring()
return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
function NoRecoil:Update(config, aimbotActive)
if not config.Enabled then
basePitch = nil
return
end
local cam = Workspace.CurrentCamera
if not cam then
basePitch = nil
return
end
if config.RequireMouseDown and not isFiring() then
basePitch = nil
return
end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChildOfClass((_V9({122,114,35,5,249,207,228,159})))
if hum then
hum.CameraOffset = Vector3.new(0, 0, 0)
end
if aimbotActive then
basePitch = nil
return
end
local strength = math.clamp(config.Strength, 0, 1)
if strength <= 0 then
basePitch = nil
return
end
local pitch = cameraPitch(cam)
if basePitch == nil then
basePitch = pitch
return
end
local drift = pitch - basePitch
if config.AllowAim and drift < 0 then
basePitch = pitch
return
end
if drift ~= 0 then
cam.CFrame = cam.CFrame * CFrame.Angles(-drift * strength, 0, 0)
end
end
function NoRecoil:Reset()
basePitch = nil
end
local NoSpread = {}
local ns_active = false
local ns_warned = false
local ns_mathHooked = false
local ns_randHooked = false
local ns_strength = 1
local ns_origMathRandom = nil
local ns_origNextNumber = nil
local ns_origNextInteger = nil
local function ns_hookApi()
if type(hookfunction) == (_V9({84,114,32,7,227,201,226,149})) then
return hookfunction
elseif type(replaceclosure) == (_V9({84,114,32,7,227,201,226,149})) then
return replaceclosure
end
return nil
end
local function ns_mathMid(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function ns_pull(original, centre, isInt)
local v = original + (centre - original) * ns_strength
if isInt then
return math.floor(v + 0.5)
end
return v
end
local function ns_installMath(hook)
if ns_mathHooked then
return
end
local ok, ret = pcall(hook, math.random, function(...)
local original = ns_origMathRandom(...)
if ns_active and ns_strength > 0 then
local a, b = ...
return ns_pull(original, ns_mathMid(a, b), a ~= nil)
end
return original
end)
if ok then
ns_origMathRandom = ret
ns_mathHooked = true
end
end
local function ns_installRandom(hook)
if ns_randHooked then
return
end
local ok = pcall(function()
local sample = Random.new()
ns_origNextNumber = hook(sample.NextNumber, function(self, ...)
local original = ns_origNextNumber(self, ...)
if ns_active and ns_strength > 0 then
local mn, mx = ...
local centre = (mn == nil) and 0.5 or ((mn + mx) / 2)
return ns_pull(original, centre, false)
end
return original
end)
ns_origNextInteger = hook(sample.NextInteger, function(self, ...)
local original = ns_origNextInteger(self, ...)
if ns_active and ns_strength > 0 then
local mn, mx = ...
return ns_pull(original, (mn + mx) / 2, true)
end
return original
end)
end)
if ok then
ns_randHooked = true
end
end
function NoSpread:_install()
if ns_mathHooked or ns_randHooked then
return true
end
local hook = ns_hookApi()
if not hook then
if not ns_warned then
warn((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,47,93,39,29,20,229,197,236,159,65,92,98,43,0,228,128,235,142,15,81,115,39,11,249,128,229,148,14,89,110,32,3,183,136,229,148,14,89,97,59,10,244,212,228,148,15,27,39,172,228,3,128,227,148,21,18,102,56,5,254,204,236,153,13,87,39,39,10,183,212,229,146,18,18,98,54,1,244,213,249,148,19,28})))
ns_warned = true
end
return false
end
ns_installMath(hook)
ns_installRandom(hook)
if not (ns_mathHooked or ns_randHooked) then
if not ns_warned then
warn((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,47,93,39,29,20,229,197,236,159,91,18,97,47,13,251,197,233,219,21,93,39,39,10,228,212,236,151,13,18,102,32,29,183,200,226,148,10,28})))
ns_warned = true
end
return false
end
return true
end
function NoSpread:Update(config)
ns_strength = math.clamp(config.Strength or 1, 0, 1)
if config.Enabled then
if not (ns_mathHooked or ns_randHooked) and not self:_install() then
return
end
ns_active = (not config.RequireMouseDown) or isFiring()
else
ns_active = false
end
end
function NoSpread:Cleanup()
ns_active = false
local hook = ns_hookApi()
if not hook then
return
end
if ns_mathHooked and ns_origMathRandom then
pcall(hook, math.random, ns_origMathRandom)
ns_mathHooked = false
end
if ns_randHooked then
pcall(function()
local sample = Random.new()
if ns_origNextNumber then
hook(sample.NextNumber, ns_origNextNumber)
end
if ns_origNextInteger then
hook(sample.NextInteger, ns_origNextInteger)
end
end)
ns_randHooked = false
end
end
local Triggerbot = {}
local tb_click
local tb_resolved = false
local tb_warned = false
local tb_onTargetSince = nil
local tb_lastFire = 0
local TB_REFIRE = 0.08
local function tb_resolveClick()
if tb_resolved then
return
end
tb_resolved = true
if type(mouse1click) == (_V9({84,114,32,7,227,201,226,149})) then
tb_click = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({84,114,32,7,227,201,226,149})) and type(mouse1release) == (_V9({84,114,32,7,227,201,226,149})) then
tb_click = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function tb_targetUnderCrosshair(config)
local cam = Workspace.CurrentCamera
if not cam then
return nil
end
local vs = cam.ViewportSize
local ray = cam:ViewportPointToRay(vs.X / 2, vs.Y / 2)
local params = RaycastParams.new()
if config.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { LocalPlayer.Character }
else
local chars = {}
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= LocalPlayer and plr.Character then
table.insert(chars, plr.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = chars
end
local result = Workspace:Raycast(ray.Origin, ray.Direction * (config.MaxDistance or 1000), params)
if not result then
return nil
end
local model = result.Instance:FindFirstAncestorOfClass((_V9({127,104,42,1,251})))
local plr = model and Players:GetPlayerFromCharacter(model)
if not plr or plr == LocalPlayer then
return nil
end
local hum = model:FindFirstChildOfClass((_V9({122,114,35,5,249,207,228,159})))
if not hum or hum.Health <= 0 then
return nil
end
return model
end
function Triggerbot:Update(config)
if not config.Enabled then
tb_onTargetSince = nil
return
end
tb_resolveClick()
if not tb_click then
if not tb_warned then
warn((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,53,64,110,41,3,242,210,239,148,21,18,105,43,1,243,211,173,154,65,95,104,59,23,242,141,238,151,8,81,108,110,2,226,206,238,143,8,93,105,110,76,250,207,248,136,4,3,100,34,13,244,203,164,219,131,178,147,110,10,248,212,173,154,23,83,110,34,5,245,204,232,219,8,92,39,58,12,254,211,173,158,25,87,100,59,16,248,210,163})))
tb_warned = true
end
return
end
local target = tb_targetUnderCrosshair(config)
if not target then
tb_onTargetSince = nil
return
end
local now = os.clock()
if not tb_onTargetSince then
tb_onTargetSince = now
end
if (now - tb_onTargetSince) >= (config.Delay or 0) and (now - tb_lastFire) >= TB_REFIRE then
tb_lastFire = now
tb_click()
end
end
local ESP = {}
local entries = {}
local container
local boxGui
local DEPTH = Enum.HighlightDepthMode.AlwaysOnTop
local function isAlive(humanoid)
return humanoid and humanoid.Health > 0
end
local function espRootPart(character)
local hum = character:FindFirstChildOfClass((_V9({122,114,35,5,249,207,228,159})))
return (hum and hum.RootPart)
or character:FindFirstChild((_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})))
or character:FindFirstChild((_V9({102,104,60,23,248})))
or character:FindFirstChild((_V9({103,119,62,1,229,244,226,137,18,93})))
or character.PrimaryPart
end
local function getBoxGui()
if boxGui and boxGui.Parent then
return boxGui
end
boxGui = Instance.new((_V9({97,100,60,1,242,206,202,142,8})))
boxGui.Name = (_V9({100,102,32,13,227,217,202,158,15,87,117,47,8,213,207,245,158,18}))
boxGui.ResetOnSpawn = false
boxGui.IgnoreGuiInset = true
boxGui.DisplayOrder = 996
local ok = pcall(function()
boxGui.Parent = getGuiParent()
end)
if not ok or not boxGui.Parent then
boxGui.Parent = LocalPlayer:WaitForChild((_V9({98,107,47,29,242,210,202,142,8})))
end
return boxGui
end
local function updateBox(entry, character, config)
local cam = Workspace.CurrentCamera
local root = espRootPart(character)
if not cam or not root or not entry.box then
if entry.box then
entry.box.Visible = false
end
return
end
local head = character:FindFirstChild((_V9({122,98,47,0})))
local topWorld = head and (head.Position + Vector3.new(0, head.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local botWorld = root.Position - Vector3.new(0, 3.2, 0)
local topV, onScreen = cam:WorldToViewportPoint(topWorld)
local botV = cam:WorldToViewportPoint(botWorld)
if not onScreen or topV.Z <= 0 then
entry.box.Visible = false
return
end
local height = math.abs(botV.Y - topV.Y)
local width = height * 0.62
local cx = (topV.X + botV.X) * 0.5
local cy = (topV.Y + botV.Y) * 0.5
entry.box.Size = UDim2.fromOffset(width, height)
entry.box.Position = UDim2.fromOffset(cx - width * 0.5, cy - height * 0.5)
entry.box.BackgroundColor3 = config.FillColor
entry.box.BackgroundTransparency = config.Filled and (1 - config.FillOpacity) or 1
entry.boxStroke.Color = config.OutlineColor
entry.boxStroke.Transparency = 1 - config.OutlineOpacity
entry.box.Visible = true
end
local function makeInfoTag(entry, name, head, config)
local tag = Instance.new((_V9({112,110,34,8,245,207,236,137,5,117,114,39})))
tag.Name = (_V9({100,64,7,10,241,207}))
tag.Size = UDim2.fromOffset(200, 34)
tag.StudsOffset = Vector3.new(0, 2.7, 0)
tag.AlwaysOnTop = true
tag.Adornee = head
tag.Parent = head
local holder = Instance.new((_V9({116,117,47,9,242})))
holder.BackgroundTransparency = 1
holder.Size = UDim2.fromScale(1, 1)
holder.Parent = tag
local layout = Instance.new((_V9({103,78,2,13,228,212,193,154,24,93,114,58})))
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Parent = holder
local nameLbl = Instance.new((_V9({102,98,54,16,219,193,239,158,13})))
nameLbl.LayoutOrder = 1
nameLbl.BackgroundTransparency = 1
nameLbl.Size = UDim2.new(1, 0, 0, 16)
nameLbl.Font = Enum.Font.GothamBold
nameLbl.TextSize = 13
nameLbl.TextColor3 = config.OutlineColor
nameLbl.TextStrokeTransparency = 0.35
nameLbl.Text = name
nameLbl.Visible = false
nameLbl.Parent = holder
local distLbl = Instance.new((_V9({102,98,54,16,219,193,239,158,13})))
distLbl.LayoutOrder = 2
distLbl.BackgroundTransparency = 1
distLbl.Size = UDim2.new(1, 0, 0, 14)
distLbl.Font = Enum.Font.Gotham
distLbl.TextSize = 12
distLbl.TextColor3 = config.OutlineColor
distLbl.TextStrokeTransparency = 0.4
distLbl.Text = (_V9({}))
distLbl.Visible = false
distLbl.Parent = holder
entry.nameTag = tag
entry.nameLabel = nameLbl
entry.distanceLabel = distLbl
entry.nameHead = head
end
local function updateInfoTag(name, entry, character, config)
local head = character:FindFirstChild((_V9({122,98,47,0}))) or character:FindFirstChild((_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})))
if not head then
if entry.nameTag then
entry.nameTag.Enabled = false
end
return
end
if not entry.nameTag or not entry.nameTag.Parent or entry.nameHead ~= head then
if entry.nameTag then
pcall(function()
entry.nameTag:Destroy()
end)
end
makeInfoTag(entry, name, head, config)
end
entry.nameLabel.TextColor3 = config.OutlineColor
entry.nameLabel.Visible = config.Names
entry.distanceLabel.Visible = config.Distance
if config.Distance then
entry.distanceLabel.TextColor3 = config.OutlineColor
local myChar = LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild((_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})))
local hrp = character:FindFirstChild((_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})))
local d = (myRoot and hrp) and math.floor((hrp.Position - myRoot.Position).Magnitude + 0.5) or 0
entry.distanceLabel.Text = (_V9({105})) .. d .. (_V9({95,90}))
end
entry.nameTag.Enabled = true
end
local function hidePlayer(entry)
entry.hl.Enabled = false
if entry.box then
entry.box.Visible = false
end
if entry.nameTag then
entry.nameTag.Enabled = false
end
end
local function renderCharacter(entry, character, name, config)
if config.Outlines then
if entry.hl.Adornee ~= character then
entry.hl.Adornee = character
end
entry.hl.OutlineColor = config.OutlineColor
entry.hl.FillColor = config.FillColor
entry.hl.OutlineTransparency = 1 - config.OutlineOpacity
entry.hl.FillTransparency = config.Filled and (1 - config.FillOpacity) or 1
entry.hl.DepthMode = DEPTH
entry.hl.Enabled = true
else
entry.hl.Enabled = false
end
if config.Boxes then
updateBox(entry, character, config)
elseif entry.box then
entry.box.Visible = false
end
if config.Names or config.Distance then
updateInfoTag(name, entry, character, config)
elseif entry.nameTag then
entry.nameTag.Enabled = false
end
end
local function distanceTo(part)
local myChar = LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild((_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})))
if not myRoot or not part then
return 0
end
return (part.Position - myRoot.Position).Magnitude
end
local function updatePlayer(player, entry, config)
local character = player.Character
if not character then
hidePlayer(entry)
return
end
local hrp = character:FindFirstChild((_V9({122,114,35,5,249,207,228,159,51,93,104,58,52,246,210,249})))
local humanoid = character:FindFirstChildOfClass((_V9({122,114,35,5,249,207,228,159})))
if not config.Enabled or not hrp or not isAlive(humanoid) then
hidePlayer(entry)
return
end
if distanceTo(hrp) > config.MaxDistance then
hidePlayer(entry)
return
end
renderCharacter(entry, character, player.Name, config)
end
local function newEspEntry(color)
color = color or Color3.fromRGB(165, 75, 255)
local highlight = Instance.new((_V9({122,110,41,12,251,201,234,147,21})))
highlight.Name = (_V9({119,84,30,43,226,212,225,146,15,87}))
highlight.Enabled = false
highlight.FillColor = color
highlight.OutlineColor = color
highlight.Parent = container
local box = Instance.new((_V9({116,117,47,9,242})))
box.Name = (_V9({119,84,30,38,248,216}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = getBoxGui()
local boxStroke = Instance.new((_V9({103,78,29,16,229,207,230,158})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = highlight, box = box, boxStroke = boxStroke }
end
local function destroyEntry(entry)
if entry.hl then
entry.hl:Destroy()
end
if entry.box then
entry.box:Destroy()
end
if entry.nameTag then
pcall(function()
entry.nameTag:Destroy()
end)
end
end
local function addPlayer(player, defaultColor)
if player == LocalPlayer or entries[player] then
return
end
entries[player] = newEspEntry(defaultColor)
end
local function removePlayer(player)
local entry = entries[player]
if not entry then
return
end
destroyEntry(entry)
entries[player] = nil
end
local npcEntries = {}
local lastNpcScan = 0
local NPC_SCAN_INTERVAL = 1
local function removeNPC(model)
local entry = npcEntries[model]
if not entry then
return
end
destroyEntry(entry)
npcEntries[model] = nil
end
local function rescanNPCs()
local current = {}
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj:IsA((_V9({122,114,35,5,249,207,228,159}))) then
local model = obj.Parent
if
model
and model:IsA((_V9({127,104,42,1,251})))
and model ~= LocalPlayer.Character
and not Players:GetPlayerFromCharacter(model)
then
current[model] = true
if not npcEntries[model] then
npcEntries[model] = newEspEntry(Configuration.ESP.OutlineColor)
end
end
end
end
for model in pairs(npcEntries) do
if not current[model] or not model.Parent then
removeNPC(model)
end
end
end
local function updateNPC(model, entry, config)
local root = espRootPart(model)
local humanoid = model:FindFirstChildOfClass((_V9({122,114,35,5,249,207,228,159})))
if not model.Parent or not root or not isAlive(humanoid) then
hidePlayer(entry)
return
end
if distanceTo(root) > config.MaxDistance then
hidePlayer(entry)
return
end
renderCharacter(entry, model, model.Name, config)
end
function ESP:Init()
if container then
return
end
container = Instance.new((_V9({116,104,34,0,242,210})))
container.Name = (_V9({100,102,32,13,227,217,202,158,15,87,117,47,8,210,243,221}))
local ok = pcall(function()
container.Parent = getGuiParent()
end)
if not ok or not container.Parent then
container.Parent = Workspace
end
for _, player in ipairs(Players:GetPlayers()) do
addPlayer(player, Configuration.ESP.OutlineColor)
end
end
function ESP:Update(config)
for _, player in ipairs(Players:GetPlayers()) do
if not entries[player] then
addPlayer(player, config.OutlineColor)
end
end
for player, entry in pairs(entries) do
if player.Parent == Players then
updatePlayer(player, entry, config)
else
removePlayer(player)
end
end
if config.Enabled and config.NPCs then
if os.clock() - lastNpcScan >= NPC_SCAN_INTERVAL then
lastNpcScan = os.clock()
rescanNPCs()
end
for model, entry in pairs(npcEntries) do
updateNPC(model, entry, config)
end
elseif next(npcEntries) then
for model in pairs(npcEntries) do
removeNPC(model)
end
end
end
function ESP:OnPlayerAdded(player)
addPlayer(player, Configuration.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(player)
removePlayer(player)
end
function ESP:Cleanup()
for player in pairs(entries) do
removePlayer(player)
end
for model in pairs(npcEntries) do
removeNPC(model)
end
if container then
container:Destroy()
container = nil
end
if boxGui then
boxGui:Destroy()
boxGui = nil
end
end
local UI = {}
local COLORS = {
bg = Color3.fromRGB(10, 8, 14),
bar = Color3.fromRGB(16, 12, 22),
panel = Color3.fromRGB(19, 15, 26),
row = Color3.fromRGB(26, 20, 36),
rowHover = Color3.fromRGB(38, 29, 52),
accent = Color3.fromRGB(132, 62, 190),
accentDim = Color3.fromRGB(92, 44, 134),
border = Color3.fromRGB(44, 34, 60),
off = Color3.fromRGB(36, 28, 48),
text = Color3.fromRGB(226, 220, 238),
textSub = Color3.fromRGB(138, 124, 160),
danger = Color3.fromRGB(188, 52, 88),
}
local FADE_TIME = 0.18
local ANIM = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local gui
local mainWindow
local windowScale
local currentTab = (_V9({113,104,35,6,246,212}))
local layoutOrder = 0
local visible = false
local activeConfig
local uisConnections = {}
local moveHandlers = {}
local releaseHandlers = {}
local syncHandlers = {}
local targetPanel, targetPanelLabel
local targetDisplayOn = false
local keybindPanel
local watermark
local fpsPanel, fpsLabel
local activeCapture
local capturingKey = false
local activeDropdown = nil
local function newInstance(class, props)
local inst = Instance.new(class)
for k, v in pairs(props) do
inst[k] = v
end
return inst
end
local function nextOrder()
layoutOrder = layoutOrder + 1
return layoutOrder
end
local function isPointer(input)
return input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch
end
local function isMovement(input)
return input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch
end
local function startInputRouter()
table.insert(uisConnections, UserInputService.InputChanged:Connect(function(input)
if not isMovement(input) then
return
end
for _, fn in ipairs(moveHandlers) do
fn(input)
end
end))
table.insert(uisConnections, UserInputService.InputEnded:Connect(function(input)
if not isPointer(input) then
return
end
for _, fn in ipairs(releaseHandlers) do
fn(input)
end
end))
table.insert(uisConnections, UserInputService.InputBegan:Connect(function(input)
if not activeDropdown or not isPointer(input) then
return
end
local pos = Vector2.new(input.Position.X, input.Position.Y)
if not activeDropdown.contains(pos) then
activeDropdown.close()
end
end))
table.insert(uisConnections, UserInputService.InputBegan:Connect(function(input)
if not activeCapture then
return
end
if input.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local key = input.KeyCode
if key == Enum.KeyCode.Unknown then
return
end
if key == Enum.KeyCode.Escape then
activeCapture.finish(nil)
else
activeCapture.finish(key)
end
end))
end
local function makeToggle(parent, text, getValue, onChange)
local btn = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = newInstance((_V9({116,117,47,9,242})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = box, CornerRadius = UDim.new(0, 3) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = box, Color = COLORS.border, Thickness = 1 })
local label = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = getValue() and COLORS.text or COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local function refresh()
local on = getValue()
TweenService:Create(box, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
TweenService:Create(label, ANIM, { TextColor3 = on and COLORS.text or COLORS.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
onChange()
refresh()
end)
btn.MouseEnter:Connect(function()
if not getValue() then
box.BackgroundColor3 = COLORS.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not getValue() then
box.BackgroundColor3 = COLORS.off
end
end)
table.insert(syncHandlers, refresh)
end
local function makeSlider(parent, text, min, max, getValue, setValue, isInt, suffix)
suffix = suffix or (_V9({}))
local holder = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local label = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = holder,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local track = newInstance((_V9({116,117,47,9,242})), {
Parent = holder,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = track, CornerRadius = UDim.new(1, 0) })
local fill = newInstance((_V9({116,117,47,9,242})), {
Parent = track,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = fill, CornerRadius = UDim.new(1, 0) })
local function format(v)
local base = isInt and tostring(math.floor(v + 0.5)) or string.format((_V9({23,41,124,2})), v)
return base .. suffix
end
local function apply(v)
v = math.clamp(v, min, max)
if isInt then
v = math.floor(v + 0.5)
end
local alpha = (max > min) and (v - min) / (max - min) or 0
fill.Size = UDim2.new(alpha, 0, 1, 0)
label.Text = text .. (_V9({8,39})) .. format(v)
setValue(v)
end
apply(getValue())
local dragging = false
local function fromInput(px)
local alpha = math.clamp((px - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
apply(min + alpha * (max - min))
end
track.InputBegan:Connect(function(input)
if isPointer(input) then
dragging = true
fromInput(input.Position.X)
end
end)
table.insert(moveHandlers, function(input)
if dragging then
fromInput(input.Position.X)
end
end)
table.insert(releaseHandlers, function()
dragging = false
end)
table.insert(syncHandlers, function()
apply(getValue())
end)
end
local function makeDropdown(parent, text, options, getValue, onChange)
local holder = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
ZIndex = 2,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = holder,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local dropdown = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = holder,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = COLORS.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = COLORS.text,
Text = getValue(),
ZIndex = 3,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = dropdown, CornerRadius = UDim.new(0, 4) })
local open = false
local ROW_H = 24
local fullSize = #options * ROW_H
local listSize = math.min(fullSize, 7 * ROW_H)
local list = newInstance((_V9({97,100,60,11,251,204,228,149,6,116,117,47,9,242})), {
Parent = dropdown,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, fullSize),
ScrollBarThickness = 4,
ScrollBarImageColor3 = COLORS.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = list, CornerRadius = UDim.new(0, 4) })
for i, option in ipairs(options) do
local optionBtn = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = list,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = COLORS.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = COLORS.text,
Text = option,
AutoButtonColor = false,
ZIndex = 11,
})
optionBtn.MouseButton1Click:Connect(function()
onChange(option)
dropdown.Text = option
open = false
TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(FADE_TIME, function()
if not open then
list.Visible = false
end
end)
end)
optionBtn.MouseEnter:Connect(function()
optionBtn.BackgroundColor3 = COLORS.rowHover
end)
optionBtn.MouseLeave:Connect(function()
optionBtn.BackgroundColor3 = COLORS.off
end)
end
dropdown.MouseButton1Click:Connect(function()
open = not open
if open then
list.Visible = true
TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, listSize) }):Play()
else
TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(FADE_TIME, function()
if not open then
list.Visible = false
end
end)
end
end)
table.insert(syncHandlers, function()
dropdown.Text = getValue()
end)
end
local function makeLabel(parent, text, initialValue)
local holder = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = holder,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local value = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = holder,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = COLORS.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = initialValue,
})
return value
end
local function makeButton(parent, text, onClick, color)
local base = color or COLORS.accent
local hover = Color3.new(
math.min(base.R + 0.1, 1),
math.min(base.G + 0.1, 1),
math.min(base.B + 0.1, 1)
)
local btn = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = base,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(onClick)
btn.MouseEnter:Connect(function()
TweenService:Create(btn, ANIM, { BackgroundColor3 = hover }):Play()
end)
btn.MouseLeave:Connect(function()
TweenService:Create(btn, ANIM, { BackgroundColor3 = base }):Play()
end)
return btn
end
local function makeTextBox(parent, placeholder)
local holder = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local stroke = newInstance((_V9({103,78,29,16,229,207,230,158})), {
Parent = holder,
Color = COLORS.border,
Thickness = 1,
Transparency = 0.3,
})
local box = newInstance((_V9({102,98,54,16,213,207,245})), {
Parent = holder,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.text,
PlaceholderText = placeholder or (_V9({})),
PlaceholderColor3 = COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
TweenService:Create(stroke, ANIM, { Transparency = 0, Color = COLORS.accent }):Play()
end)
box.FocusLost:Connect(function()
TweenService:Create(stroke, ANIM, { Transparency = 0.3, Color = COLORS.border }):Play()
end)
return box
end
local function makeHeader(parent, text)
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function makeFillSlider(parent, text, min, max, getValue, setValue, isInt, unit, showMax)
unit = unit or (_V9({}))
local holder = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local fill = newInstance((_V9({116,117,47,9,242})), {
Parent = holder,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = COLORS.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = fill, CornerRadius = UDim.new(0, 6) })
local label = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = holder,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
ZIndex = 3,
})
local function fmt(v)
local s = isInt and tostring(math.floor(v + 0.5)) or string.format((_V9({23,41,124,2})), v)
if showMax then
local m = isInt and tostring(math.floor(max + 0.5)) or string.format((_V9({23,41,124,2})), max)
return s .. (_V9({29})) .. m .. unit
end
return s .. unit
end
local function apply(v)
v = math.clamp(v, min, max)
if isInt then
v = math.floor(v + 0.5)
end
local alpha = (max > min) and (v - min) / (max - min) or 0
fill.Size = UDim2.new(alpha, 0, 1, 0)
label.Text = text .. (_V9({8,39})) .. fmt(v)
setValue(v)
end
apply(getValue())
local dragging = false
local function fromInput(px)
local alpha = math.clamp((px - holder.AbsolutePosition.X) / holder.AbsoluteSize.X, 0, 1)
apply(min + alpha * (max - min))
end
holder.InputBegan:Connect(function(input)
if isPointer(input) then
dragging = true
fromInput(input.Position.X)
end
end)
table.insert(moveHandlers, function(input)
if dragging then
fromInput(input.Position.X)
end
end)
table.insert(releaseHandlers, function()
dragging = false
end)
table.insert(syncHandlers, function()
apply(getValue())
end)
end
local function makeDropdownFull(parent, options, getValue, onChange)
local holder = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = holder,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local dropdown = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = holder,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = dropdown, CornerRadius = UDim.new(0, 6) })
local dropStroke = newInstance((_V9({103,78,29,16,229,207,230,158})), {
Parent = dropdown,
Color = COLORS.border,
Thickness = 1,
Transparency = 0.3,
})
local valueLabel = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = dropdown,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = getValue(),
})
local caret = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = dropdown,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.accent,
Text = (_V9({208,145,240})),
})
local open = false
local ROW_H = 26
local fullSize = #options * ROW_H
local listSize = math.min(fullSize, 6 * ROW_H)
local list = newInstance((_V9({97,100,60,11,251,204,228,149,6,116,117,47,9,242})), {
Parent = holder,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, fullSize),
ScrollBarThickness = 4,
ScrollBarImageColor3 = COLORS.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = list, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = list, Color = COLORS.border, Thickness = 1, Transparency = 0.2 })
local optionButtons = {}
local function paintOptions()
local current = getValue()
for option, btn in pairs(optionButtons) do
local selected = (option == current)
btn.BackgroundColor3 = selected and COLORS.accent or COLORS.panel
btn.BackgroundTransparency = selected and 0 or 1
btn.TextColor3 = selected and Color3.fromRGB(255, 255, 255) or COLORS.textSub
btn.Font = selected and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function collapse()
if not open then
return
end
open = false
if activeDropdown and activeDropdown.frame == dropdown then
activeDropdown = nil
end
TweenService:Create(caret, ANIM, { Rotation = 0 }):Play()
TweenService:Create(dropStroke, ANIM, { Transparency = 0.3 }):Play()
TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(FADE_TIME, function()
if not open then
list.Visible = false
end
end)
end
local function expand()
if open then
return
end
if activeDropdown and activeDropdown.close then
activeDropdown.close()
end
open = true
paintOptions()
list.Visible = true
TweenService:Create(caret, ANIM, { Rotation = 180 }):Play()
TweenService:Create(dropStroke, ANIM, { Transparency = 0 }):Play()
TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, listSize) }):Play()
activeDropdown = {
frame = dropdown,
close = collapse,
contains = function(pos)
local function inside(obj)
local p, s = obj.AbsolutePosition, obj.AbsoluteSize
return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
end
return inside(dropdown) or (list.Visible and inside(list))
end,
}
end
for i, option in ipairs(options) do
local optionBtn = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = list,
Size = UDim2.new(1, 0, 0, ROW_H),
Position = UDim2.fromOffset(0, (i - 1) * ROW_H),
BackgroundColor3 = COLORS.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = COLORS.textSub,
Text = option,
AutoButtonColor = false,
})
optionButtons[option] = optionBtn
optionBtn.MouseButton1Click:Connect(function()
onChange(option)
valueLabel.Text = option
paintOptions()
collapse()
end)
optionBtn.MouseEnter:Connect(function()
if option ~= getValue() then
optionBtn.BackgroundTransparency = 0
optionBtn.BackgroundColor3 = COLORS.rowHover
optionBtn.TextColor3 = COLORS.text
end
end)
optionBtn.MouseLeave:Connect(function()
paintOptions()
end)
end
paintOptions()
dropdown.MouseButton1Click:Connect(function()
if open then
collapse()
else
expand()
end
end)
dropdown.MouseEnter:Connect(function()
if not open then
TweenService:Create(dropdown, ANIM, { BackgroundColor3 = COLORS.rowHover }):Play()
end
end)
dropdown.MouseLeave:Connect(function()
if not open then
TweenService:Create(dropdown, ANIM, { BackgroundColor3 = COLORS.row }):Play()
end
end)
table.insert(syncHandlers, function()
valueLabel.Text = getValue()
paintOptions()
end)
end
local function makeColorPicker(parent, title, getColor, setColor)
local h, s, v = getColor():ToHSV()
local SQ_H, HUE_W, GAP = 120, 16, 8
local holder = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, SQ_H + 74),
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = holder, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = holder,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local heading = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = holder,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({113,104,34,11,229})),
})
local body = newInstance((_V9({116,117,47,9,242})), {
Parent = holder,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local sq = newInstance((_V9({116,117,47,9,242})), {
Parent = body,
Size = UDim2.new(1, -(HUE_W + GAP), 0, SQ_H),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = sq, CornerRadius = UDim.new(0, 4) })
local satLayer = newInstance((_V9({116,117,47,9,242})), {
Parent = sq,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = satLayer, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({103,78,9,22,246,196,228,158,15,70})), {
Parent = satLayer,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local valLayer = newInstance((_V9({116,117,47,9,242})), {
Parent = sq,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = valLayer, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({103,78,9,22,246,196,228,158,15,70})), {
Parent = valLayer,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local svDot = newInstance((_V9({116,117,47,9,242})), {
Parent = sq,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = svDot, CornerRadius = UDim.new(1, 0) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = svDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local hue = newInstance((_V9({116,117,47,9,242})), {
Parent = body,
Size = UDim2.fromOffset(HUE_W, SQ_H),
Position = UDim2.new(1, -HUE_W, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = hue, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({103,78,9,22,246,196,228,158,15,70})), {
Parent = hue,
Rotation = 90,
Color = ColorSequence.new({
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
}),
})
local hueDot = newInstance((_V9({116,117,47,9,242})), {
Parent = hue,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = hueDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local preview = newInstance((_V9({116,117,47,9,242})), {
Parent = body,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, SQ_H + 6),
BackgroundColor3 = getColor(),
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = preview, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = preview, Color = COLORS.off, Thickness = 1 })
local hexLabel = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = body,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, SQ_H + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function refresh(writeBack)
local col = Color3.fromHSV(h, s, v)
if writeBack ~= false then
setColor(col)
end
sq.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
svDot.Position = UDim2.new(s, 0, 1 - v, 0)
hueDot.Position = UDim2.new(0.5, 0, h, 0)
preview.BackgroundColor3 = col
local r = math.floor(col.R * 255 + 0.5)
local g = math.floor(col.G * 255 + 0.5)
local b = math.floor(col.B * 255 + 0.5)
hexLabel.Text = string.format((_V9({17,34,126,86,207,133,189,201,57,23,55,124,60,183,128,165,222,5,30,39,107,0,187,128,168,159,72})), r, g, b, r, g, b)
end
refresh(false)
local svDrag, hueDrag = false, false
local function svFrom(px, py)
s = math.clamp((px - sq.AbsolutePosition.X) / sq.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((py - sq.AbsolutePosition.Y) / sq.AbsoluteSize.Y, 0, 1)
refresh()
end
local function hueFrom(py)
h = math.clamp((py - hue.AbsolutePosition.Y) / hue.AbsoluteSize.Y, 0, 1)
refresh()
end
sq.InputBegan:Connect(function(input)
if isPointer(input) then
svDrag = true
svFrom(input.Position.X, input.Position.Y)
end
end)
hue.InputBegan:Connect(function(input)
if isPointer(input) then
hueDrag = true
hueFrom(input.Position.Y)
end
end)
table.insert(moveHandlers, function(input)
if svDrag then
svFrom(input.Position.X, input.Position.Y)
end
if hueDrag then
hueFrom(input.Position.Y)
end
end)
table.insert(releaseHandlers, function()
svDrag, hueDrag = false, false
end)
table.insert(syncHandlers, function()
h, s, v = getColor():ToHSV()
refresh(false)
end)
end
local function wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
local listening = false
local function refresh()
if listening then
box.Text = (_V9({98,117,43,23,228,66,13,93}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = COLORS.accent
else
box.Text = getKey().Name
box.TextColor3 = COLORS.accent
box.BackgroundColor3 = COLORS.bar
end
end
local capture = {}
function capture.finish(key)
listening = false
activeCapture = nil
task.defer(function()
capturingKey = false
end)
if key then
local conflict = conflictCheck and conflictCheck(key)
if conflict then
UI:Notify(string.format((_V9({23,116,110,13,228,128,236,151,19,87,102,42,29,183,194,226,142,15,86,39,58,11,183,133,254})), key.Name, conflict), 2.5)
else
setKey(key)
UI:Notify(string.format((_V9({23,116,110,6,248,213,227,159,65,70,104,110,65,228})), labelText, key.Name), 2)
end
end
refresh()
end
function capture.cancel()
listening = false
refresh()
end
box.MouseButton1Click:Connect(function()
if listening then
activeCapture = nil
task.defer(function()
capturingKey = false
end)
capture.cancel()
return
end
if activeCapture then
activeCapture.cancel()
end
activeCapture = capture
capturingKey = true
listening = true
refresh()
end)
box.MouseEnter:Connect(function()
if not listening then
box.BackgroundColor3 = COLORS.rowHover
end
end)
box.MouseLeave:Connect(function()
if not listening then
box.BackgroundColor3 = COLORS.bar
end
end)
table.insert(syncHandlers, function()
if activeCapture == capture then
activeCapture = nil
task.defer(function()
capturingKey = false
end)
listening = false
end
refresh()
end)
refresh()
end
local function keyConflict(config, key, field)
if field ~= (_V9({95,98,32,17})) and config.UI.MenuKey == key then
return (_V9({127,98,32,17}))
end
if field ~= (_V9({83,110,35,6,248,212})) and config.Camera.ToggleKey == key then
return (_V9({115,110,35,6,248,212}))
end
if field ~= (_V9({87,116,62})) and config.ESP.ToggleKey == key then
return (_V9({119,84,30}))
end
if field ~= (_V9({84,104,56,7,254,210,238,151,4})) and config.Camera.FOVCircleKey == key then
return (_V9({116,72,24,68,212,201,255,152,13,87}))
end
if field ~= (_V9({92,104,60,1,244,207,228,151})) and config.NoRecoil.ToggleKey == key then
return (_V9({124,104,110,54,242,195,226,146,13}))
end
if field ~= (_V9({92,104,61,20,229,197,236,159})) and config.NoSpread.ToggleKey == key then
return (_V9({124,104,110,55,231,210,232,154,5}))
end
if field ~= (_V9({70,117,39,3,240,197,255,153,14,70})) and config.Triggerbot.ToggleKey == key then
return (_V9({102,117,39,3,240,197,255,153,14,70}))
end
if field ~= (_V9({71,105,34,11,246,196})) and config.UI.UnloadKey == key then
return (_V9({103,105,34,11,246,196}))
end
return nil
end
local function makeKeybind(parent, labelText, getKey, setKey, conflictCheck)
local holder = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = holder,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = labelText,
})
local box = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = holder,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -6, 0.5, 0),
Size = UDim2.fromOffset(0, 22),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = COLORS.accent,
Text = getKey().Name,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = box, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
newInstance((_V9({103,78,29,13,237,197,206,148,15,65,115,60,5,254,206,249})), { Parent = box, MinSize = Vector2.new(54, 22) })
wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
end
local function makeToggleWithKeybind(parent, text, getValue, onChange, keyLabel, getKey, setKey, conflictCheck)
local btn = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local check = newInstance((_V9({116,117,47,9,242})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = check, CornerRadius = UDim.new(0, 3) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = check, Color = COLORS.border, Thickness = 1 })
local label = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = getValue() and COLORS.text or COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local box = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = btn,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, 0, 0.5, 0),
Size = UDim2.fromOffset(0, 20),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = COLORS.accent,
Text = getKey().Name,
ZIndex = 3,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = box, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
newInstance((_V9({103,78,29,13,237,197,206,148,15,65,115,60,5,254,206,249})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function refresh()
local on = getValue()
TweenService:Create(check, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
TweenService:Create(label, ANIM, { TextColor3 = on and COLORS.text or COLORS.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
onChange()
refresh()
end)
table.insert(syncHandlers, refresh)
wireKeybindBox(box, keyLabel, getKey, setKey, conflictCheck)
end
local function makeColumns(parent)
local function column(order)
local col = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = col,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return col
end
return column(1), column(2)
end
local function makeGroup(parent, title)
local wrapper = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = newInstance((_V9({116,117,47,9,242})), {
Parent = wrapper,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = box, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = box, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = box,
LayoutOrder = -1,
Size = UDim2.new(1, 0, 0, 15),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title,
})
local veil = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = wrapper,
Position = UDim2.fromOffset(0, 0),
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = COLORS.bg,
BackgroundTransparency = 0.45,
BorderSizePixel = 0,
Visible = false,
Active = true,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
ZIndex = 50,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = veil, CornerRadius = UDim.new(0, 6) })
local STRIPE, GAP = 0.72, 1
local hatch = newInstance((_V9({116,117,47,9,242})), {
Parent = veil,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = COLORS.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = hatch, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({103,78,9,22,246,196,228,158,15,70})), {
Parent = hatch,
Rotation = 35,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.000, GAP),
NumberSequenceKeypoint.new(0.119, GAP),
NumberSequenceKeypoint.new(0.120, STRIPE),
NumberSequenceKeypoint.new(0.199, STRIPE),
NumberSequenceKeypoint.new(0.200, GAP),
NumberSequenceKeypoint.new(0.319, GAP),
NumberSequenceKeypoint.new(0.320, STRIPE),
NumberSequenceKeypoint.new(0.399, STRIPE),
NumberSequenceKeypoint.new(0.400, GAP),
NumberSequenceKeypoint.new(0.519, GAP),
NumberSequenceKeypoint.new(0.520, STRIPE),
NumberSequenceKeypoint.new(0.599, STRIPE),
NumberSequenceKeypoint.new(0.600, GAP),
NumberSequenceKeypoint.new(0.719, GAP),
NumberSequenceKeypoint.new(0.720, STRIPE),
NumberSequenceKeypoint.new(0.799, STRIPE),
NumberSequenceKeypoint.new(0.800, GAP),
NumberSequenceKeypoint.new(0.919, GAP),
NumberSequenceKeypoint.new(0.920, STRIPE),
NumberSequenceKeypoint.new(1.000, STRIPE),
}),
})
local function syncWrapper()
local sc = (windowScale and windowScale.Scale) or 1
if sc <= 0 then
sc = 1
end
wrapper.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / sc)
end
box:GetPropertyChangedSignal((_V9({115,101,61,11,251,213,249,158,50,91,125,43}))):Connect(syncWrapper)
syncWrapper()
local function setEnabled(enabled)
veil.Visible = not enabled
end
return box, setEnabled
end
local function makeSubTabHost(parent)
local bar = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local divider = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = COLORS.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local area = newInstance((_V9({116,117,47,9,242})), {
Parent = parent,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local host = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
host.current = name
for n, f in pairs(host.frames) do
f.Visible = (n == name)
end
for n, b in pairs(host.buttons) do
local active = (n == name)
TweenService:Create(b.btn, ANIM, { TextColor3 = active and COLORS.text or COLORS.textSub }):Play()
TweenService:Create(b.underline, ANIM, { BackgroundTransparency = active and 0 or 1 }):Play()
end
end
function host:add(name)
self.order = self.order + 1
local btn = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = bar,
LayoutOrder = self.order,
Size = UDim2.fromOffset(0, 24),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = COLORS.textSub,
Text = name,
})
local underline = newInstance((_V9({116,117,47,9,242})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = COLORS.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = newInstance((_V9({97,100,60,11,251,204,228,149,6,116,117,47,9,242})), {
Parent = area,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = false,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 5,
ScrollBarImageColor3 = COLORS.accent,
ScrollBarImageTransparency = 0.25,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
newInstance((_V9({103,78,30,5,243,196,228,149,6})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = btn, underline = underline }
self.frames[name] = frame
btn.MouseButton1Click:Connect(function()
select(name)
end)
btn.MouseEnter:Connect(function()
if host.current ~= name then
btn.TextColor3 = COLORS.text
end
end)
btn.MouseLeave:Connect(function()
if host.current ~= name then
btn.TextColor3 = COLORS.textSub
end
end)
if not self.current then
select(name)
end
return frame
end
return host
end
local function buildCameraTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({115,110,35,6,248,212}))))
local aim = makeGroup(left, (_V9({115,110,35,6,248,212})))
makeToggleWithKeybind(aim, (_V9({119,105,47,6,251,197,233})), function()
return config.Camera.Enabled
end, function()
config.Camera.Enabled = not config.Camera.Enabled
end, (_V9({115,110,35,6,248,212,173,176,4,75})), function()
return config.Camera.ToggleKey
end, function(key)
config.Camera.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({83,110,35,6,248,212})))
end)
makeToggle(aim, (_V9({100,110,61,7,255,197,238,144})), function()
return config.Camera.WallCheck
end, function()
config.Camera.WallCheck = not config.Camera.WallCheck
end)
makeToggle(aim, (_V9({97,115,39,7,252,217,173,175,0,64,96,43,16})), function()
return config.Camera.StickyTarget
end, function()
config.Camera.StickyTarget = not config.Camera.StickyTarget
end)
makeToggleWithKeybind(aim, (_V9({116,72,24,68,212,201,255,152,13,87})), function()
return config.Camera.FOVCircle
end, function()
config.Camera.FOVCircle = not config.Camera.FOVCircle
end, (_V9({116,72,24,68,212,201,255,152,13,87,39,5,1,238})), function()
return config.Camera.FOVCircleKey
end, function(key)
config.Camera.FOVCircleKey = key
end, function(key)
return keyConflict(config, key, (_V9({84,104,56,7,254,210,238,151,4})))
end)
makeFillSlider(aim, (_V9({97,106,33,11,227,200,227,158,18,65})), 0.05, 1, function()
return config.Camera.Smoothness
end, function(val)
config.Camera.Smoothness = val
end, false)
makeFillSlider(aim, (_V9({116,72,24})), 20, 800, function()
return config.Camera.FOV
end, function(val)
config.Camera.FOV = val
end, true, (_V9({66,127})), true)
makeFillSlider(aim, (_V9({127,102,54,68,211,201,254,143,0,92,100,43})), 100, 2000, function()
return config.Camera.MaxDistance
end, function(val)
config.Camera.MaxDistance = val
end, true, (_V9({95})), true)
local refreshWeightGate
local hitbox = makeGroup(right, (_V9({122,110,58,6,248,216})))
makeDropdownFull(hitbox, config.Camera.HitboxOptions, function()
return config.Camera.Hitbox
end, function(val)
config.Camera.Hitbox = val
if refreshWeightGate then
refreshWeightGate()
end
end)
local weights, setWeightsEnabled = makeGroup(right, (_V9({102,102,60,3,242,212,173,168,4,70,115,39,10,240,211})))
local function weightRow(name)
makeFillSlider(weights, name .. (_V9({18,80,43,13,240,200,249})), 0, 100, function()
return config.Camera.TargetWeights[name]
end, function(val)
config.Camera.TargetWeights[name] = val
end, true, (_V9({23})), true)
end
weightRow((_V9({122,98,47,0})))
weightRow((_V9({102,104,60,23,248})))
weightRow((_V9({115,117,35,23})))
weightRow((_V9({126,98,41,23})))
refreshWeightGate = function()
setWeightsEnabled(config.Camera.Hitbox == (_V9({96,102,32,0,248,205,173,211,54,87,110,41,12,227,197,233,210})))
end
refreshWeightGate()
table.insert(syncHandlers, refreshWeightGate)
local trigger = makeGroup(right, (_V9({102,117,39,3,240,197,255,153,14,70})))
makeToggleWithKeybind(trigger, (_V9({119,105,47,6,251,197,233})), function()
return config.Triggerbot.Enabled
end, function()
config.Triggerbot.Enabled = not config.Triggerbot.Enabled
end, (_V9({102,117,39,3,240,197,255,153,14,70,39,5,1,238})), function()
return config.Triggerbot.ToggleKey
end, function(key)
config.Triggerbot.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({70,117,39,3,240,197,255,153,14,70})))
end)
makeFillSlider(trigger, (_V9({118,98,34,5,238})), 0, 500, function()
return config.Triggerbot.Delay * 1000
end, function(val)
config.Triggerbot.Delay = val / 1000
end, true, (_V9({95,116})), true)
makeFillSlider(trigger, (_V9({127,102,54,68,211,201,254,143,0,92,100,43})), 100, 2000, function()
return config.Triggerbot.MaxDistance
end, function(val)
config.Triggerbot.MaxDistance = val
end, true, (_V9({95})), true)
makeToggle(trigger, (_V9({100,110,61,7,255,197,238,144})), function()
return config.Triggerbot.WallCheck
end, function()
config.Triggerbot.WallCheck = not config.Triggerbot.WallCheck
end)
left, right = makeColumns(host:add((_V9({101,98,47,20,248,206,254}))))
local recoil = makeGroup(left, (_V9({124,104,110,54,242,195,226,146,13})))
makeToggleWithKeybind(recoil, (_V9({119,105,47,6,251,197,233})), function()
return config.NoRecoil.Enabled
end, function()
config.NoRecoil.Enabled = not config.NoRecoil.Enabled
end, (_V9({124,104,110,54,242,195,226,146,13,18,76,43,29})), function()
return config.NoRecoil.ToggleKey
end, function(key)
config.NoRecoil.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({92,104,60,1,244,207,228,151})))
end)
makeToggle(recoil, (_V9({125,105,34,29,183,247,229,146,13,87,39,8,13,229,201,227,156})), function()
return config.NoRecoil.RequireMouseDown
end, function()
config.NoRecoil.RequireMouseDown = not config.NoRecoil.RequireMouseDown
end)
makeToggle(recoil, (_V9({115,107,34,11,224,128,204,146,12,18,67,33,19,249})), function()
return config.NoRecoil.AllowAim
end, function()
config.NoRecoil.AllowAim = not config.NoRecoil.AllowAim
end)
makeFillSlider(recoil, (_V9({97,115,60,1,249,199,249,147})), 0, 100, function()
return config.NoRecoil.Strength * 100
end, function(val)
config.NoRecoil.Strength = val / 100
end, true, (_V9({23})), true)
local spread = makeGroup(left, (_V9({124,104,110,55,231,210,232,154,5})))
makeToggleWithKeybind(spread, (_V9({119,105,47,6,251,197,233})), function()
return config.NoSpread.Enabled
end, function()
config.NoSpread.Enabled = not config.NoSpread.Enabled
end, (_V9({124,104,110,55,231,210,232,154,5,18,76,43,29})), function()
return config.NoSpread.ToggleKey
end, function(key)
config.NoSpread.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({92,104,61,20,229,197,236,159})))
end)
makeToggle(spread, (_V9({125,105,34,29,183,247,229,146,13,87,39,8,13,229,201,227,156})), function()
return config.NoSpread.RequireMouseDown
end, function()
config.NoSpread.RequireMouseDown = not config.NoSpread.RequireMouseDown
end)
makeFillSlider(spread, (_V9({97,115,60,1,249,199,249,147})), 0, 100, function()
return config.NoSpread.Strength * 100
end, function(val)
config.NoSpread.Strength = val / 100
end, true, (_V9({23})), true)
end
local function buildESPTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({119,84,30}))))
local esp = makeGroup(left, (_V9({119,84,30})))
makeToggleWithKeybind(esp, (_V9({119,105,47,6,251,197,233})), function()
return config.ESP.Enabled
end, function()
config.ESP.Enabled = not config.ESP.Enabled
end, (_V9({119,84,30,68,220,197,244})), function()
return config.ESP.ToggleKey
end, function(key)
config.ESP.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({87,116,62})))
end)
makeToggle(esp, (_V9({124,87,13,23})), function()
return config.ESP.NPCs
end, function()
config.ESP.NPCs = not config.ESP.NPCs
end)
makeFillSlider(esp, (_V9({127,102,54,68,211,201,254,143,0,92,100,43})), 100, 2000, function()
return config.ESP.MaxDistance
end, function(val)
config.ESP.MaxDistance = val
end, true, (_V9({95})), true)
local look = makeGroup(left, (_V9({115,119,62,1,246,210,236,149,2,87})))
makeToggle(look, (_V9({125,114,58,8,254,206,232,136})), function()
return config.ESP.Outlines
end, function()
config.ESP.Outlines = not config.ESP.Outlines
end)
makeToggle(look, (_V9({112,104,54,1,228})), function()
return config.ESP.Boxes
end, function()
config.ESP.Boxes = not config.ESP.Boxes
end)
makeToggle(look, (_V9({124,102,35,1,228})), function()
return config.ESP.Names
end, function()
config.ESP.Names = not config.ESP.Names
end)
makeToggle(look, (_V9({118,110,61,16,246,206,238,158})), function()
return config.ESP.Distance
end, function()
config.ESP.Distance = not config.ESP.Distance
end)
makeToggle(look, (_V9({116,110,34,8,242,196})), function()
return config.ESP.Filled
end, function()
config.ESP.Filled = not config.ESP.Filled
end)
makeFillSlider(look, (_V9({125,114,58,8,254,206,232,219,46,66,102,45,13,227,217})), 0, 1, function()
return config.ESP.OutlineOpacity
end, function(val)
config.ESP.OutlineOpacity = val
end, false)
makeFillSlider(look, (_V9({116,110,34,8,183,239,253,154,2,91,115,55})), 0, 1, function()
return config.ESP.FillOpacity
end, function(val)
config.ESP.FillOpacity = val
end, false)
left, right = makeColumns(host:add((_V9({113,104,34,11,229,211}))))
makeColorPicker(left, (_V9({125,114,58,8,254,206,232,219,34,93,107,33,22})), function()
return config.ESP.OutlineColor
end, function(c)
config.ESP.OutlineColor = c
end)
makeColorPicker(right, (_V9({116,110,34,8,183,227,226,151,14,64})), function()
return config.ESP.FillColor
end, function(c)
config.ESP.FillColor = c
end)
end
local function buildSettingsTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({117,98,32,1,229,193,225}))))
local iface = makeGroup(left, (_V9({123,105,58,1,229,198,236,152,4})))
makeFillSlider(iface, (_V9({103,78,110,55,244,193,225,158})), 0.8, 1.5, function()
return config.UI.Scale
end, function(val)
config.UI.Scale = val
if windowScale then
windowScale.Scale = val
end
end, false)
makeToggle(iface, (_V9({121,98,55,6,254,206,233,219,49,83,105,43,8})), function()
return config.UI.KeybindPanel
end, function()
config.UI.KeybindPanel = not config.UI.KeybindPanel
if keybindPanel then
keybindPanel.Visible = config.UI.KeybindPanel
end
end)
makeToggle(iface, (_V9({102,102,60,3,242,212,173,191,8,65,119,34,5,238})), function()
return config.UI.TargetDisplay
end, function()
config.UI.TargetDisplay = not config.UI.TargetDisplay
targetDisplayOn = config.UI.TargetDisplay
if not targetDisplayOn and targetPanel then
targetPanel.Visible = false
end
end)
makeToggle(iface, (_V9({116,87,29,68,212,207,248,149,21,87,117})), function()
return config.UI.FPSCounter
end, function()
config.UI.FPSCounter = not config.UI.FPSCounter
if fpsPanel then
fpsPanel.Visible = config.UI.FPSCounter
end
end)
makeToggle(iface, (_V9({101,102,58,1,229,205,236,137,10})), function()
return config.UI.Watermark
end, function()
config.UI.Watermark = not config.UI.Watermark
if watermark then
watermark.Visible = config.UI.Watermark
end
end)
local account = makeGroup(right, (_V9({115,100,45,11,226,206,249})))
makeLabel(account, (_V9({103,116,43,22,249,193,224,158})), LocalPlayer and LocalPlayer.Name or (_V9({208,135,218})))
makeLabel(account, (_V9({118,110,61,20,251,193,244,219,47,83,106,43})), LocalPlayer and LocalPlayer.DisplayName or (_V9({208,135,218})))
makeLabel(account, (_V9({103,116,43,22,183,233,201})), LocalPlayer and tostring(LocalPlayer.UserId) or (_V9({208,135,218})))
left, right = makeColumns(host:add((_V9({113,104,32,2,254,199,254}))))
local cfg = makeGroup(left, (_V9({113,104,32,2,254,199,254})))
if not ConfigManager.isSupported() then
makeLabel(cfg, (_V9({97,115,47,16,226,211})), (_V9({103,105,61,17,231,208,226,137,21,87,99})))
return
end
local nameBox = makeTextBox(cfg, (_V9({81,104,32,2,254,199,173,149,0,95,98,172,228,49})))
local listHolder = newInstance((_V9({116,117,47,9,242})), {
Parent = cfg,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = listHolder,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local refreshList
local function selectName(name)
nameBox.Text = name
refreshList()
end
refreshList = function()
for _, child in ipairs(listHolder:GetChildren()) do
if not child:IsA((_V9({103,78,2,13,228,212,193,154,24,93,114,58}))) then
child:Destroy()
end
end
local names = ConfigManager.list()
if #names == 0 then
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = listHolder,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({92,104,110,23,246,214,232,159,65,81,104,32,2,254,199,254})),
})
return
end
for i, name in ipairs(names) do
local selected = (nameBox.Text == name)
local row = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = listHolder,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = selected and COLORS.accent or COLORS.row,
BackgroundTransparency = selected and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = selected and Color3.fromRGB(255, 255, 255) or COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({18,39})) .. name,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
selectName(name)
end)
row.MouseEnter:Connect(function()
if nameBox.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = COLORS.rowHover
end
end)
row.MouseLeave:Connect(function()
if nameBox.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = COLORS.row
end
end)
end
end
makeButton(cfg, (_V9({97,102,56,1})), function()
local ok, res = ConfigManager.save(nameBox.Text, config)
if ok then
UI:Notify((_V9({97,102,56,1,243,128,238,148,15,84,110,41,68,176})) .. res .. (_V9({21})), 2)
refreshList()
else
UI:Notify(tostring(res), 3)
end
end)
makeButton(cfg, (_V9({126,104,47,0})), function()
local ok, res = ConfigManager.load(nameBox.Text, config)
if ok then
if windowScale then
windowScale.Scale = config.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({126,104,47,0,242,196,173,152,14,92,97,39,3,183,135})) .. res .. (_V9({21})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
makeButton(cfg, (_V9({118,98,34,1,227,197})), function()
local ok, res = ConfigManager.delete(nameBox.Text)
if ok then
UI:Notify((_V9({118,98,34,1,227,197,233,219,2,93,105,40,13,240,128,170})) .. res .. (_V9({21})), 2)
nameBox.Text = (_V9({}))
refreshList()
else
UI:Notify(tostring(res), 3)
end
end, COLORS.danger)
refreshList()
end
local function buildTargetPanel(config)
targetPanel = newInstance((_V9({116,117,47,9,242})), {
Parent = gui,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = COLORS.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = targetPanel, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = targetPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = targetPanel,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = targetPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local dot = newInstance((_V9({116,117,47,9,242})), {
Parent = targetPanel,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = targetPanel,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({})),
})
local dragging, dragStart, startPos
targetPanel.InputBegan:Connect(function(input)
if isPointer(input) then
dragging = true
dragStart = input.Position
startPos = targetPanel.Position
end
end)
table.insert(moveHandlers, function(input)
if dragging and targetPanel then
local delta = input.Position - dragStart
targetPanel.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)
table.insert(releaseHandlers, function()
dragging = false
end)
table.insert(syncHandlers, function()
targetDisplayOn = config.UI.TargetDisplay
if not targetDisplayOn and targetPanel then
targetPanel.Visible = false
end
end)
targetDisplayOn = config.UI.TargetDisplay
end
local function buildFpsPanel(config)
fpsPanel = newInstance((_V9({116,117,47,9,242})), {
Parent = gui,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = COLORS.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = fpsPanel, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = fpsPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = fpsPanel,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = fpsPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local dot = newInstance((_V9({116,117,47,9,242})), {
Parent = fpsPanel,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
fpsLabel = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = fpsPanel,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({31,42,110,2,231,211})),
})
table.insert(syncHandlers, function()
if fpsPanel then
fpsPanel.Visible = config.UI.FPSCounter
end
end)
fpsPanel.Visible = config.UI.FPSCounter
end
local function buildWatermark(config)
watermark = newInstance((_V9({123,106,47,3,242,236,236,153,4,94})), {
Parent = gui,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 14, 1, -14),
Size = UDim2.fromOffset(180, 64),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Fit,
Image = (_V9({})),
Visible = false,
})
UI:SetWatermarkImage(config.UI.WatermarkImageId)
table.insert(syncHandlers, function()
if watermark then
watermark.Visible = config.UI.Watermark
end
end)
watermark.Visible = config.UI.Watermark
end
local function buildKeybindPanel(config)
layoutOrder = 0
keybindPanel = newInstance((_V9({116,117,47,9,242})), {
Parent = gui,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = COLORS.bg,
BorderSizePixel = 0,
Visible = false,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = keybindPanel, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = keybindPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), {
Parent = keybindPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = keybindPanel,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = newInstance((_V9({116,117,47,9,242})), {
Parent = keybindPanel,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({121,98,55,6,254,206,233,136})),
})
local dragging, dragStart, startPos
bar.InputBegan:Connect(function(input)
if isPointer(input) then
dragging = true
dragStart = input.Position
startPos = keybindPanel.Position
end
end)
table.insert(moveHandlers, function(input)
if dragging and keybindPanel then
local delta = input.Position - dragStart
keybindPanel.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)
table.insert(releaseHandlers, function()
dragging = false
end)
makeKeybind(keybindPanel, (_V9({127,98,32,17})), function()
return config.UI.MenuKey
end, function(key)
config.UI.MenuKey = key
end, function(key)
return keyConflict(config, key, (_V9({95,98,32,17})))
end)
makeKeybind(keybindPanel, (_V9({115,110,35,6,248,212})), function()
return config.Camera.ToggleKey
end, function(key)
config.Camera.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({83,110,35,6,248,212})))
end)
makeKeybind(keybindPanel, (_V9({119,84,30})), function()
return config.ESP.ToggleKey
end, function(key)
config.ESP.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({87,116,62})))
end)
makeKeybind(keybindPanel, (_V9({116,72,24,68,212,201,255,152,13,87})), function()
return config.Camera.FOVCircleKey
end, function(key)
config.Camera.FOVCircleKey = key
end, function(key)
return keyConflict(config, key, (_V9({84,104,56,7,254,210,238,151,4})))
end)
makeKeybind(keybindPanel, (_V9({124,104,110,54,242,195,226,146,13})), function()
return config.NoRecoil.ToggleKey
end, function(key)
config.NoRecoil.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({92,104,60,1,244,207,228,151})))
end)
makeKeybind(keybindPanel, (_V9({124,104,110,55,231,210,232,154,5})), function()
return config.NoSpread.ToggleKey
end, function(key)
config.NoSpread.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({92,104,61,20,229,197,236,159})))
end)
makeKeybind(keybindPanel, (_V9({102,117,39,3,240,197,255,153,14,70})), function()
return config.Triggerbot.ToggleKey
end, function(key)
config.Triggerbot.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({70,117,39,3,240,197,255,153,14,70})))
end)
makeKeybind(keybindPanel, (_V9({103,105,34,11,246,196})), function()
return config.UI.UnloadKey
end, function(key)
config.UI.UnloadKey = key
end, function(key)
return keyConflict(config, key, (_V9({71,105,34,11,246,196})))
end)
table.insert(syncHandlers, function()
if keybindPanel then
keybindPanel.Visible = config.UI.KeybindPanel
end
end)
keybindPanel.Visible = config.UI.KeybindPanel
end
local function setVisible(state)
if not mainWindow or state == visible then
return
end
visible = state
if activeConfig and activeConfig.UI then
activeConfig.UI.Visible = state
end
if state then
mainWindow.Visible = true
mainWindow.GroupTransparency = 1
TweenService:Create(mainWindow, TweenInfo.new(FADE_TIME), { GroupTransparency = 0 }):Play()
else
local tween = TweenService:Create(mainWindow, TweenInfo.new(FADE_TIME), { GroupTransparency = 1 })
tween.Completed:Once(function()
if not visible and mainWindow then
mainWindow.Visible = false
end
end)
tween:Play()
end
end
function UI:Init(config)
if gui then
return
end
activeConfig = config
startInputRouter()
gui = newInstance((_V9({97,100,60,1,242,206,202,142,8})), {
Name = (_V9({100,102,32,13,227,217,202,158,15,87,117,47,8,194,233})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local ok = pcall(function()
gui.Parent = getGuiParent()
end)
if not ok or not gui.Parent then
gui.Parent = LocalPlayer:WaitForChild((_V9({98,107,47,29,242,210,202,142,8})))
end
mainWindow = newInstance((_V9({113,102,32,18,246,211,202,137,14,71,119})), {
Parent = gui,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = COLORS.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
windowScale = newInstance((_V9({103,78,29,7,246,204,232})), { Parent = mainWindow, Scale = config.UI.Scale })
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
local titleBar = newInstance((_V9({116,117,47,9,242})), {
Parent = mainWindow,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = titleBar, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({116,117,47,9,242})), {
Parent = titleBar,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
local dot = newInstance((_V9({116,117,47,9,242})), {
Parent = titleBar,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = titleBar,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({100,102,32,13,227,217,177,157,14,92,115,110,7,248,204,226,137,92,16,36,118,80,164,229,207,190,67,12,41,42,1,225,156,162,157,14,92,115,112,68,208,197,227,158,19,83,107}))
.. (_V9({14,97,33,10,227,128,238,148,13,93,117,115,70,180,152,204,204,34,115,55,108,90,183,128,173,57,214,18,39,110,18,167,156,162,157,14,92,115,112})),
ZIndex = 2,
})
newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = titleBar,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.new(0, 140, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = LocalPlayer and LocalPlayer.Name or (_V9({})),
ZIndex = 2,
})
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
if isPointer(input) then
dragging = true
dragStart = input.Position
startPos = mainWindow.Position
end
end)
table.insert(moveHandlers, function(input)
if dragging then
local delta = input.Position - dragStart
mainWindow.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)
table.insert(releaseHandlers, function()
dragging = false
end)
local sidebar = newInstance((_V9({116,117,47,9,242})), {
Parent = mainWindow,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = sidebar, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = sidebar, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = sidebar,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local tabList = newInstance((_V9({116,117,47,9,242})), {
Parent = sidebar,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,2,13,228,212,193,154,24,93,114,58})), { Parent = tabList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local unloadBtn = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = sidebar,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.danger,
Text = (_V9({103,105,34,11,246,196})),
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = unloadBtn, CornerRadius = UDim.new(0, 6) })
local unloadStroke = newInstance((_V9({103,78,29,16,229,207,230,158})), {
Parent = unloadBtn,
Color = COLORS.danger,
Thickness = 1,
Transparency = 0.55,
})
unloadBtn.MouseButton1Click:Connect(function()
VanityGeneral.Stop()
end)
unloadBtn.MouseEnter:Connect(function()
TweenService:Create(unloadBtn, ANIM, {
BackgroundColor3 = COLORS.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
TweenService:Create(unloadStroke, ANIM, { Transparency = 0 }):Play()
end)
unloadBtn.MouseLeave:Connect(function()
TweenService:Create(unloadBtn, ANIM, {
BackgroundColor3 = COLORS.row,
TextColor3 = COLORS.danger,
}):Play()
TweenService:Create(unloadStroke, ANIM, { Transparency = 0.55 }):Play()
end)
local content = newInstance((_V9({116,117,47,9,242})), {
Parent = mainWindow,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({103,78,30,5,243,196,228,149,6})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local tabs = { (_V9({113,104,35,6,246,212})), (_V9({100,110,61,17,246,204})), (_V9({97,98,58,16,254,206,234,136})) }
local tabFrames = {}
for i, tabName in ipairs(tabs) do
local isActive = currentTab == tabName
local tabBtn = newInstance((_V9({102,98,54,16,213,213,249,143,14,92})), {
Parent = tabList,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = COLORS.rowHover,
BackgroundTransparency = isActive and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = isActive and COLORS.text or COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({18,39,110,68})) .. tabName,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = tabBtn, CornerRadius = UDim.new(0, 6) })
local stripe = newInstance((_V9({116,117,47,9,242})), {
Parent = tabBtn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
Visible = isActive,
ZIndex = 2,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local tabFrame = newInstance((_V9({116,117,47,9,242})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = isActive,
})
tabFrames[tabName] = { btn = tabBtn, frame = tabFrame, stripe = stripe }
tabBtn.MouseButton1Click:Connect(function()
currentTab = tabName
for name, tab in pairs(tabFrames) do
local active = name == tabName
tab.frame.Visible = active
tab.stripe.Visible = active
TweenService:Create(tab.btn, ANIM, {
BackgroundTransparency = active and 0 or 1,
TextColor3 = active and COLORS.text or COLORS.textSub,
}):Play()
end
end)
tabBtn.MouseEnter:Connect(function()
if currentTab ~= tabName then
TweenService:Create(tabBtn, ANIM, { BackgroundTransparency = 0.6 }):Play()
end
end)
tabBtn.MouseLeave:Connect(function()
if currentTab ~= tabName then
TweenService:Create(tabBtn, ANIM, { BackgroundTransparency = 1 }):Play()
end
end)
end
buildCameraTab(tabFrames[(_V9({113,104,35,6,246,212}))].frame, config)
buildESPTab(tabFrames[(_V9({100,110,61,17,246,204}))].frame, config)
buildSettingsTab(tabFrames[(_V9({97,98,58,16,254,206,234,136}))].frame, config)
buildKeybindPanel(config)
buildTargetPanel(config)
buildFpsPanel(config)
buildWatermark(config)
if config.UI.Visible then
setVisible(true)
end
end
function UI:Toggle()
setVisible(not visible)
end
function UI:Show()
setVisible(true)
end
function UI:Hide()
setVisible(false)
end
function UI:SetCurrentTarget(name)
if not targetPanel then
return
end
if targetPanel.Visible ~= targetDisplayOn then
targetPanel.Visible = targetDisplayOn
end
if not targetDisplayOn or not targetPanelLabel then
return
end
local shown, colour
if name and name ~= (_V9({})) and name ~= (_V9({124,104,32,1})) then
shown, colour = name, (_V9({17,63,122,87,210,226,200}))
else
shown, colour = (_V9({103,105,5,10,248,215,227})), (_V9({17,63,15,83,212,225,189}))
end
local text = (_V9({102,102,60,3,242,212,183,219,93,84,104,32,16,183,195,226,151,14,64,58,108})) .. colour .. (_V9({16,57})) .. shown .. (_V9({14,40,40,11,249,212,179}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(fps)
if not fpsLabel or not fpsPanel or not fpsPanel.Visible then
return
end
local text = string.format((_V9({14,97,33,10,227,128,238,148,13,93,117,115,70,180,152,185,200,36,112,66,108,90,178,196,177,212,7,93,105,58,90,183,198,253,136})), fps or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(id)
if not watermark then
return
end
local digits = tostring(id or (_V9({}))):match((_V9({23,99,101})))
watermark.Image = digits and ((_V9({64,101,54,5,228,211,232,143,8,86,61,97,75})) .. digits) or (_V9({}))
end
function UI:SyncControls()
for _, fn in ipairs(syncHandlers) do
fn()
end
end
function UI:IsCapturingKey()
return capturingKey
end
function UI:Notify(text, duration)
if not gui then
return
end
duration = duration or 3
local toast = newInstance((_V9({102,98,54,16,219,193,239,158,13})), {
Parent = gui,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 12),
Size = UDim2.fromOffset(math.max(200, #text * 8 + 28), 34),
BackgroundColor3 = COLORS.bar,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = COLORS.text,
Text = text,
})
newInstance((_V9({103,78,13,11,229,206,232,137})), { Parent = toast, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({103,78,29,16,229,207,230,158})), { Parent = toast, Color = COLORS.accent, Thickness = 1, Transparency = 0.3 })
TweenService:Create(toast, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(duration, function()
if toast and toast.Parent then
local out = TweenService:Create(toast, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
out.Completed:Once(function()
if toast then
toast:Destroy()
end
end)
out:Play()
end
end)
end
function UI:Cleanup()
for _, conn in ipairs(uisConnections) do
conn:Disconnect()
end
table.clear(uisConnections)
table.clear(moveHandlers)
table.clear(releaseHandlers)
table.clear(syncHandlers)
activeCapture = nil
capturingKey = false
activeDropdown = nil
targetPanel, targetPanelLabel = nil, nil
targetDisplayOn = false
keybindPanel = nil
watermark = nil
fpsPanel, fpsLabel = nil, nil
windowScale = nil
if gui then
gui:Destroy()
gui = nil
mainWindow = nil
end
visible = false
end
VanityGeneral = {}
VanityGeneral.Version = (_V9({2}))
VanityGeneral.Config = Configuration
VanityGeneral.StringObfuscation = StringObfuscation
VanityGeneral.DebuggerDetection = DebuggerDetection
VanityGeneral.ProtectedSecrets = ProtectedSecrets
VanityGeneral.Secrets = ProtectedSecrets.createProtectedManager()
local WEBHOOK_URL = (_V9({}))
local WEBHOOK_LEVEL = 2
local WEBHOOK_CIPHER = { 61, 35, 45, 43, 46, 101, 78, 76, 1, 14, 26, 8, 2, 29, 21, 93, 22, 24, 20, 84, 28, 15, 232, 172, 242, 226, 235, 227, 226, 224, 250, 224, 186, 166, 172, 168, 173, 175, 151, 145, 148, 150, 157, 146, 158, 158, 129, 139, 128, 132, 143, 142, 146, 210, 151, 244, 143, 132, 139, 164, 136, 171, 231, 226, 177, 133, 173, 154, 167, 236, 152, 219, 131, 140, 167, 156, 220, 187, 128, 164, 141, 145, 156, 191, 201, 155, 87, 74, 108, 48, 113, 89, 101, 119, 87, 85, 32, 101, 75, 85, 109, 101, 108, 21, 108, 125, 126, 28, 100, 78, 118, 106, 108, 7, 64, 114, 15, 11, 57, 53, 26 }
local webhookViaManager = false
local function resolveHttpRequest()
local candidates = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, fn in ipairs(candidates) do
if type(fn) == (_V9({84,114,32,7,227,201,226,149})) then
return fn
end
end
return nil
end
local function resolveWebhookUrl()
if webhookViaManager then
local url = VanityGeneral.Secrets:get((_V9({69,98,44,12,248,207,230,164,20,64,107})))
if url then
return url
end
end
if #WEBHOOK_CIPHER > 0 then
if DebuggerDetection.IsBeingDebugged() then
DebuggerDetection.HandleTamperingAttempt((_V9({69,98,44,12,248,207,230,164,19,87,113,43,5,251,255,250,147,8,94,98,17,0,242,194,248,156,6,87,99})), (_V9({69,98,44,12,248,207,230})))
return nil
end
return StringObfuscation.decrypt(WEBHOOK_CIPHER, WEBHOOK_LEVEL)
end
return nil
end
function VanityGeneral.SetWebhook(url, level)
VanityGeneral.Secrets:clear((_V9({69,98,44,12,248,207,230,164,20,64,107})))
VanityGeneral.Secrets:register((_V9({69,98,44,12,248,207,230,164,20,64,107})), url, level or WEBHOOK_LEVEL)
webhookViaManager = true
return true
end
function VanityGeneral.EncryptWebhook(url, level)
level = level or WEBHOOK_LEVEL
local bytes = StringObfuscation.encrypt(url, level)
print(string.format((_V9({31,42,110,52,246,211,249,158,65,70,111,43,68,227,215,226,219,13,91,105,43,23,183,194,232,151,14,69,39,39,10,227,207,173,143,9,87,39,29,33,212,245,223,190,65,101,66,12,44,216,239,198,219,2,93,105,40,13,240,128,165,151,4,68,98,34,68,178,196,164,193})), level))
print(string.format((_V9({94,104,45,5,251,128,218,190,35,122,72,1,47,200,236,200,173,36,126,39,115,68,178,196})), level))
print((_V9({94,104,45,5,251,128,218,190,35,122,72,1,47,200,227,196,171,41,119,85,110,89,183,219,173})) .. table.concat(bytes, (_V9({30,39}))) .. (_V9({18,122})))
return bytes
end
function VanityGeneral.HasWebhook()
return webhookViaManager or #WEBHOOK_CIPHER > 0
end
function VanityGeneral.SendWebhook(content, opts)
opts = opts or {}
local url = resolveWebhookUrl()
if not url then
return false, (_V9({92,104,17,19,242,194,229,148,14,89,88,33,22,200,194,225,148,2,89,98,42}))
end
local req = resolveHttpRequest()
if not req then
warn((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,47,93,39,6,48,195,240,173,137,4,67,114,43,23,227,128,235,142,15,81,115,39,11,249,128,236,141,0,91,107,47,6,251,197,173,146,15,18,115,38,13,228,128,232,131,4,81,114,58,11,229})))
return false, (_V9({92,104,17,12,227,212,253}))
end
local payload = {
username = opts.username or (_V9({100,102,32,13,227,217,160,188,4,92,98,60,5,251})),
avatar_url = opts.avatar_url,
content = content,
embeds = opts.embeds,
}
local ok, err = pcall(function()
local body = game:GetService((_V9({122,115,58,20,196,197,255,141,8,81,98}))):JSONEncode(payload)
return req({
Url = url,
Method = (_V9({98,72,29,48})),
Headers = { [(_V9({113,104,32,16,242,206,249,214,53,75,119,43}))] = (_V9({83,119,62,8,254,195,236,143,8,93,105,97,14,228,207,227})) },
Body = body,
})
end)
url = nil
if not ok then
warn((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,54,87,101,38,11,248,203,173,136,4,92,99,110,2,246,201,225,158,5,8})), err)
return false, err
end
return true
end
function VanityGeneral.SendLoadedEmbed(isDebugged)
local placeName = (_V9({13}))
pcall(function()
placeName = game:GetService((_V9({127,102,60,15,242,212,253,151,0,81,98,29,1,229,214,228,152,4}))):GetProductInfo(game.PlaceId).Name
end)
return VanityGeneral.SendWebhook(nil, {
embeds = {
{
title = (_V9({100,102,32,13,227,217,163,159,4,68,39,9,1,249,197,255,154,13,18,107,33,5,243,197,233})),
color = 8666558,
fields = {
{ name = (_V9({98,107,47,29,242,210})), value = (_V9({82})) .. (LocalPlayer and LocalPlayer.Name or (_V9({13}))) .. (_V9({82})), inline = true },
{ name = (_V9({100,98,60,23,254,207,227})), value = (_V9({82,113})) .. tostring(VanityGeneral.Version) .. (_V9({82})), inline = true },
{ name = (_V9({117,102,35,1})), value = placeName, inline = false },
{ name = (_V9({98,107,47,7,242,233,233})), value = (_V9({82})) .. tostring(game.PlaceId) .. (_V9({82})), inline = true },
{ name = (_V9({118,98,44,17,240,199,232,159})), value = (_V9({82})) .. tostring(isDebugged) .. (_V9({82})), inline = true },
},
footer = { text = os.date((_V9({23,94,99,65,250,141,168,159,65,23,79,116,65,218,154,168,168}))) },
},
},
})
end
local running = false
local connections = {}
local aimbotSteering = false
local RECOIL_BIND = (_V9({100,102,32,13,227,217,202,158,15,87,117,47,8,197,197,238,148,8,94}))
local guardState = {}
local GUARD_WARN_INTERVAL = 5
local function guarded(name, fn, ...)
local ok, res = pcall(fn, ...)
if ok then
local st = guardState[name]
if st then
st.failures = 0
end
return true, res
end
local st = guardState[name]
if not st then
st = { failures = 0, lastWarn = -math.huge }
guardState[name] = st
end
st.failures = st.failures + 1
local now = os.clock()
if now - st.lastWarn >= GUARD_WARN_INTERVAL then
st.lastWarn = now
warn(string.format((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,68,65,39,40,5,254,204,232,159,65,26,127,107,0,190,154,173,222,18})), name, st.failures, tostring(res)))
end
return false, nil
end
function VanityGeneral.IsRunning()
return running
end
function VanityGeneral.SaveConfig(name)
return ConfigManager.save(name, Configuration)
end
function VanityGeneral.LoadConfig(name)
local ok, res = ConfigManager.load(name, Configuration)
if ok then
pcall(function()
UI:SyncControls()
end)
end
return ok, res
end
function VanityGeneral.ListConfigs()
return ConfigManager.list()
end
function VanityGeneral.DeleteConfig(name)
return ConfigManager.delete(name)
end
function VanityGeneral.SetWatermarkImage(id)
Configuration.UI.WatermarkImageId = tostring(id or (_V9({})))
UI:SetWatermarkImage(Configuration.UI.WatermarkImageId)
return VanityGeneral
end
function VanityGeneral.GetSecurityReport()
return ProtectedSecrets.getReport()
end
function VanityGeneral.Start()
if running then
return VanityGeneral
end
local securityState = ProtectedSecrets.initialize({ enable_monitoring = true })
if securityState.is_debugged then
warn((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,37,87,101,59,3,183,197,227,141,8,64,104,32,9,242,206,249,219,5,87,115,43,7,227,197,233,219,0,70,39,61,16,246,210,249,142,17,18,229,206,240,183,208,255,148,21,87,100,58,1,243,128,254,158,2,64,98,58,23,183,215,228,151,13,18,117,43,2,226,211,232,219,21,93,39,60,1,225,197,236,151,65,71,105,58,13,251,128,236,151,13,93,112,17,13,249,255,254,143,20,86,110,33,68,254,211,173,136,4,70,41})))
end
running = true
local ok, err = pcall(function()
ESP:Init()
UI:Init(Configuration)
table.insert(connections, Players.PlayerAdded:Connect(function(player)
guarded((_V9({98,107,47,29,242,210,204,159,5,87,99})), ESP.OnPlayerAdded, ESP, player)
end))
table.insert(connections, Players.PlayerRemoving:Connect(function(player)
guarded((_V9({98,107,47,29,242,210,223,158,12,93,113,39,10,240})), ESP.OnPlayerRemoving, ESP, player)
end))
table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed or UI:IsCapturingKey() then
return
end
guarded((_V9({121,98,55,6,254,206,233,136})), function()
local key = input.KeyCode
if key == Configuration.UI.MenuKey then
UI:Toggle()
elseif key == Configuration.UI.UnloadKey then
VanityGeneral.Stop()
else
local toggles = {
{ Configuration.Camera, (_V9({119,105,47,6,251,197,233})), Configuration.Camera.ToggleKey },
{ Configuration.ESP, (_V9({119,105,47,6,251,197,233})), Configuration.ESP.ToggleKey },
{ Configuration.Camera, (_V9({116,72,24,39,254,210,238,151,4})), Configuration.Camera.FOVCircleKey },
{ Configuration.NoRecoil, (_V9({119,105,47,6,251,197,233})), Configuration.NoRecoil.ToggleKey },
{ Configuration.NoSpread, (_V9({119,105,47,6,251,197,233})), Configuration.NoSpread.ToggleKey },
{ Configuration.Triggerbot, (_V9({119,105,47,6,251,197,233})), Configuration.Triggerbot.ToggleKey },
}
for _, t in ipairs(toggles) do
if key == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local fpsAccum, fpsFrames = 0, 0
table.insert(connections, RunService.RenderStepped:Connect(function(dt)
guarded((_V9({119,84,30})), ESP.Update, ESP, Configuration.ESP)
local okAim, target = guarded((_V9({115,110,35,6,248,212})), CameraDirector.Update, CameraDirector, Configuration.Camera, Configuration.Debug)
if not okAim then
target = nil
end
if Configuration.UI.TargetDisplay then
guarded((_V9({102,102,60,3,242,212,173,159,8,65,119,34,5,238})), function()
local looking = CameraDirector:GetLookTarget(Configuration.ESP)
UI:SetCurrentTarget(looking and looking.Name or nil)
end)
end
aimbotSteering = Configuration.Camera.Enabled and target ~= nil
guarded((_V9({124,104,29,20,229,197,236,159})), NoSpread.Update, NoSpread, Configuration.NoSpread)
guarded((_V9({102,117,39,3,240,197,255,153,14,70})), Triggerbot.Update, Triggerbot, Configuration.Triggerbot)
fpsAccum = fpsAccum + dt
fpsFrames = fpsFrames + 1
if fpsAccum >= 0.25 then
local fps = math.floor(fpsFrames / fpsAccum + 0.5)
fpsAccum, fpsFrames = 0, 0
if Configuration.UI.FPSCounter then
guarded((_V9({116,87,29,68,244,207,248,149,21,87,117})), UI.UpdateFPS, UI, fps)
end
end
end))
pcall(function()
RunService:UnbindFromRenderStep(RECOIL_BIND)
end)
pcall(function()
RunService:BindToRenderStep(RECOIL_BIND, Enum.RenderPriority.Camera.Value + 1, function()
guarded((_V9({124,104,28,1,244,207,228,151})), NoRecoil.Update, NoRecoil, Configuration.NoRecoil, aimbotSteering)
end)
end)
end)
if not ok then
warn((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,39,83,110,34,1,243,128,249,148,65,65,115,47,22,227,154})), err)
VanityGeneral.Stop()
return VanityGeneral
end
UI:Notify(string.format((_V9({100,102,32,13,227,217,160,188,4,92,98,60,5,251,128,225,148,0,86,98,42,68,183,66,13,89,65,18,87,60,1,228,211,173,222,18})), Configuration.UI.MenuKey.Name), 4)
print(string.format((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,51,71,105,32,13,249,199,173,211,23,23,116,103})), VanityGeneral.Version))
print(string.format((_V9({18,39,172,228,53,128,222,143,19,91,105,41,43,245,198,248,136,2,83,115,39,11,249,128,251,222,18,18,47,47,7,227,201,251,158,72})), StringObfuscation.VERSION))
print(string.format((_V9({18,39,172,228,53,128,201,158,3,71,96,41,1,229,228,232,143,4,81,115,39,11,249,128,251,201,79,2,39,102,9,248,206,228,143,14,64,110,32,3,173,128,236,152,21,91,113,43,72,183,196,232,153,20,85,96,43,0,173,128,168,136,72})), tostring(securityState.is_debugged)))
print(string.format((_V9({18,39,172,228,53,128,221,137,14,70,98,45,16,242,196,222,158,2,64,98,58,23,183,214,168,136,65,26,81,47,10,254,212,244,188,4,92,98,60,5,251,142,222,158,2,64,98,58,23,183,199,236,143,4,86,39,44,29,183,196,232,153,20,85,96,43,22,183,196,232,143,4,81,115,39,11,249,137})), ProtectedSecrets.VERSION))
print(string.format((_V9({127,98,32,17,173,128,168,136,65,18,123,110,68,212,193,224,158,19,83,61,110,65,228,128,173,135,65,18,82,32,8,248,193,233,193,65,23,116})),
Configuration.UI.MenuKey.Name,
Configuration.Camera.ToggleKey.Name,
Configuration.UI.UnloadKey.Name))
if not VanityGeneral.HasWebhook() and type(WEBHOOK_URL) == (_V9({65,115,60,13,249,199})) and WEBHOOK_URL ~= (_V9({})) then
pcall(VanityGeneral.SetWebhook, WEBHOOK_URL)
end
if VanityGeneral.HasWebhook() then
task.spawn(function()
VanityGeneral.SendLoadedEmbed(securityState.is_debugged)
end)
end
return VanityGeneral
end
function VanityGeneral.Stop()
if not running then
return VanityGeneral
end
running = false
for _, conn in ipairs(connections) do
pcall(function()
conn:Disconnect()
end)
end
table.clear(connections)
pcall(function()
RunService:UnbindFromRenderStep(RECOIL_BIND)
end)
aimbotSteering = false
pcall(function()
ESP:Cleanup()
end)
pcall(function()
UI:Cleanup()
end)
pcall(function()
CameraDirector:Cleanup()
end)
pcall(function()
NoSpread:Cleanup()
end)
pcall(function()
ProtectedSecrets.shutdown()
end)
NoRecoil:Reset()
table.clear(guardState)
print((_V9({105,81,47,10,254,212,244,214,38,87,105,43,22,246,204,208,219,50,70,104,62,20,242,196})))
return VanityGeneral
end
function VanityGeneral.Toggle()
if running then
VanityGeneral.Stop()
else
VanityGeneral.Start()
end
return VanityGeneral
end
VanityGeneral.start = VanityGeneral.Start
VanityGeneral.stop = VanityGeneral.Stop
VanityGeneral.toggle = VanityGeneral.Toggle
if getgenv then
local previous = getgenv().VanityGeneral
if previous and previous ~= VanityGeneral and type(previous.Stop) == (_V9({84,114,32,7,227,201,226,149})) then
pcall(previous.Stop)
end
getgenv().VanityGeneral = VanityGeneral
end
pcall(function()
VanityGeneral.Start()
end)
return VanityGeneral
