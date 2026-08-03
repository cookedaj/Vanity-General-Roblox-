local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({104,142,64,165,103,227,137,235,232})
local Players = game:GetService((_V9({56,226,33,220,2,145,250})))
local RunService = game:GetService((_V9({58,251,46,246,2,145,255,130,139,13})))
local UserInputService = game:GetService((_V9({61,253,37,215,46,141,249,158,156,59,235,50,211,14,128,236})))
local TweenService = game:GetService((_V9({60,249,37,192,9,176,236,153,158,1,237,37})))
local Workspace = game:GetService((_V9({63,225,50,206,20,147,232,136,141})))
local LocalPlayer = Players.LocalPlayer
local VanityGeneral
local StringObfuscation = {
VERSION = (_V9({90,160,112})),
_stats = {
encryptions = 0,
decryptions = 0,
secrets_created = 0,
total_access_time = 0,
},
_audit_log = {},
_max_audit_entries = 1000,
}
do
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
name = name or ((_V9({27,235,35,215,2,151,214})) .. tostring({}):match((_V9({88,246,101,221,76}))))
local encrypted = StringObfuscation.encrypt(str, level)
local hash = _simpleHash(str)
_addAuditEntry((_V9({27,235,35,215,2,151,214,136,154,13,239,52,192,3})), name, { level = level })
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
return (_V9({51,221,5,230,53,166,221,209})) .. name .. (_V9({53}))
end,
__index = function(self, key)
if key == (_V9({30,239,44,208,2})) then
if self._cleared then
warn((_V9({51,221,52,215,14,141,238,164,138,14,251,51,198,6,151,224,132,134,53,174,19,192,4,145,236,159,200,79})) .. self._name .. (_V9({79,174,55,196,20,195,234,135,141,9,252,37,193,71,130,231,143,200,11,239,46,203,8,151,169,137,141,72,239,35,198,2,144,250,142,140})))
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
_addAuditEntry((_V9({27,235,35,215,2,151,214,138,139,11,235,51,214,2,135})), self._name, {
access_num = self._access_count,
access_time_ms = access_time * 1000,
})
return self._decrypted
elseif key == (_V9({9,237,35,192,20,144,214,136,135,29,224,52})) then
return self._access_count
elseif key == (_V9({4,239,51,209,56,130,234,136,141,27,253})) then
return self._last_access
elseif key == (_V9({6,239,45,192})) then
return self._name
elseif key == (_V9({4,235,54,192,11})) then
return self._level
elseif key == (_V9({11,252,37,196,19,138,230,133,183,28,231,45,192})) then
return self._creation_time
elseif key == (_V9({9,233,37,250,20,134,234,132,134,12,253})) then
return os.time() - self._creation_time
elseif key == (_V9({1,253,31,198,11,134,232,153,141,12})) then
return self._cleared
end
return rawget(self, key)
end,
__metatable = (_V9({51,222,18,234,51,166,202,191,173,44,211}))
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
if type(secret) == (_V9({28,239,34,201,2})) and secret._encrypted then
secret._decrypted = nil
secret._cleared = true
_addAuditEntry((_V9({27,235,35,215,2,151,214,136,132,13,239,50,192,3})), secret._name, {})
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
if type(secret) == (_V9({28,239,34,201,2})) and secret._encrypted then
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
warn((_V9({51,221,37,198,21,134,253,166,137,6,239,39,192,21,190,169,184,141,11,252,37,209,71,196})) .. name .. (_V9({79,174,33,201,21,134,232,143,145,72,252,37,194,14,144,253,142,154,13,234})))
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
_password = StringObfuscation.makeSecret(password, (_V9({30,239,53,201,19,188,249,138,155,27,249,47,215,3})), 3),
_secrets = {},
_locked = true,
}
function vault:unlock(provided_password)
if self._password.value == provided_password then
self._locked = false
_addAuditEntry((_V9({30,239,53,201,19,188,252,133,132,7,237,43,192,3})), (_V9({30,239,53,201,19})), {})
return true
end
_addAuditEntry((_V9({30,239,53,201,19,188,252,133,132,7,237,43,250,1,130,224,135,141,12})), (_V9({30,239,53,201,19})), {})
return false
end
function vault:lock()
self._locked = true
_addAuditEntry((_V9({30,239,53,201,19,188,229,132,139,3,235,36})), (_V9({30,239,53,201,19})), {})
end
function vault:store(name, value, level)
if self._locked then
warn((_V9({51,216,33,208,11,151,212,203,190,9,251,44,209,71,138,250,203,132,7,237,43,192,3})))
return false
end
self._secrets[name] = StringObfuscation.makeSecret(value, name, level or 2)
_addAuditEntry((_V9({30,239,53,201,19,188,250,159,135,26,235})), name, {})
return true
end
function vault:retrieve(name)
if self._locked then
warn((_V9({51,216,33,208,11,151,212,203,190,9,251,44,209,71,138,250,203,132,7,237,43,192,3})))
return nil
end
if self._secrets[name] then
_addAuditEntry((_V9({30,239,53,201,19,188,251,142,156,26,231,37,211,2})), name, {})
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
warn((_V9({51,216,33,208,11,151,212,203,190,9,251,44,209,71,138,250,203,132,7,237,43,192,3})))
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
_addAuditEntry((_V9({30,239,53,201,19,188,237,142,132,13,250,37})), name, {})
return true
end
return false
end
return vault
end
end
local DebuggerDetection = {}
do
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
return game:GetService((_V9({58,251,46,246,2,145,255,130,139,13}))):IsStudio()
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
return nil, (_V9({27,225,53,215,4,134,214,158,134,9,248,33,204,11,130,235,135,141}))
end
local hash = tostring(#current_source) .. (_V9({82})) .. string.sub(current_source, 1, 50)
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
time_string = os.date((_V9({77,215,109,128,10,206,172,143,200,77,198,122,128,42,217,172,184})), tick()),
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
print((_V9({98,179,125,152,71,167,236,137,157,15,233,37,215,71,167,236,159,141,11,250,41,202,9,195,218,159,137,28,231,51,209,14,128,250,203,213,85,179})))
print((_V9({44,235,52,192,4,151,224,132,134,27,180,96})) .. stats.detections)
print((_V9({43,230,37,198,12,144,169,187,141,26,232,47,215,10,134,237,209,200})) .. stats.checks_performed)
print((_V9({60,239,45,213,2,145,224,133,143,72,207,52,209,2,142,249,159,155,82,174})) .. stats.tampering_attempts)
print((_V9({60,225,52,196,11,195,202,131,141,11,229,96,241,14,142,236,209,200})) .. string.format((_V9({77,160,114,195})), stats.total_check_time_ms) .. (_V9({5,253})))
print((_V9({41,251,36,204,19,195,197,132,143,72,203,46,209,21,138,236,152,210,72})) .. stats.audit_log_entries)
print((_V9({85,179,125,152,90,222,180,214,213,85,179,125,152,90,222,180,214,213,85,179,125,152,90,222,180,214,213,85,179,125,152,90,222,180,214,213,85,132})))
end
function DebuggerDetection.HandleDebuggerState(debugged)
if debugged then
DebugStatistics.detections = DebugStatistics.detections + 1
DebugLogAuditEvent((_V9({12,235,34,208,0,132,236,153,183,12,235,52,192,4,151,236,143})), (_V9({44,235,34,208,0,195,236,133,158,1,252,47,203,10,134,231,159,200,12,235,52,192,4,151,236,143})))
warn((_V9({51,221,37,198,18,145,224,159,145,53,174,4,192,5,150,238,140,141,26,174,36,192,19,134,234,159,141,12,174,162,37,243,195,251,158,134,6,231,46,194,71,138,231,203,152,26,225,36,208,4,151,224,132,134,69,253,33,195,2,195,228,132,140,13,160})))
return {
safe_mode = true,
reduced_logging = true,
skip_sensitive_ops = true,
detected_at = tick(),
}
else
DebugLogAuditEvent((_V9({6,225,50,200,6,143,214,142,144,13,237,53,209,14,140,231})), (_V9({38,225,96,193,2,129,252,140,143,13,252,96,193,2,151,236,136,156,13,234})))
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
DebugLogAuditEvent((_V9({28,239,45,213,2,145,224,133,143,55,239,52,209,2,142,249,159})), attempt_type .. (_V9({82,174})) .. tostring(details))
warn((_V9({51,221,37,198,18,145,224,159,145,72,207,44,192,21,151,212,203,188,9,227,48,192,21,138,231,140,200,9,250,52,192,10,147,253,203,140,13,250,37,198,19,134,237,209,200})) .. attempt_type)
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
DebugLogAuditEvent((_V9({5,225,46,204,19,140,251,130,134,15,209,51,209,6,145,253,142,140})), (_V9({58,235,33,201,74,151,224,134,141,72,234,37,199,18,132,169,134,135,6,231,52,202,21,138,231,140,200,9,237,52,204,17,130,253,142,140})))
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
DebuggerDetection.HandleTamperingAttempt((_V9({27,235,35,208,21,134,214,142,144,13,237,53,209,14,140,231,180,129,6,209,36,192,5,150,238})), (_V9({41,250,52,192,10,147,253,142,140,72,235,56,192,4,150,253,130,135,6,174,41,203,71,135,236,137,157,15,174,45,202,3,134})))
return nil
end
local success, result = pcall(callback)
if not success then
DebugLogAuditEvent((_V9({13,246,37,198,18,151,224,132,134,55,232,33,204,11,134,237})), tostring(result))
warn((_V9({51,221,37,198,18,145,224,159,145,53,174,19,192,4,150,251,142,200,13,246,37,198,18,151,224,132,134,72,232,33,204,11,134,237,209,200})) .. tostring(result))
return nil
end
DebugLogAuditEvent((_V9({13,246,37,198,18,151,224,132,134,55,253,53,198,4,134,250,152})), (_V9({59,235,35,208,21,134,169,136,135,12,235,96,192,31,134,234,158,156,13,234,96,214,18,128,234,142,155,27,232,53,201,11,154})))
return result
end
function DebuggerDetection.VerifyIntegrity()
local state = {
in_studio = DebuggerDetection.IsRunningInStudio(),
debugger_attached = DebuggerDetection.IsDebuggerAttached(),
environment_compromised = DebuggerDetection.IsEnvironmentCompromised(),
timestamp = tick(),
time_string = os.date((_V9({77,215,109,128,10,206,172,143,200,77,198,122,128,42,217,172,184})), tick()),
}
DebugLogAuditEvent((_V9({1,224,52,192,0,145,224,159,145,55,237,40,192,4,136})), state.debugger_attached and (_V9({43,193,13,245,53,172,196,162,187,45,202})) or (_V9({39,197})))
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
DebugLogAuditEvent((_V9({27,247,51,209,2,142,214,130,134,1,250,41,196,11,138,243,142,140})), (_V9({44,235,34,208,0,132,236,153,172,13,250,37,198,19,138,230,133,200,30,188,110,149,71,138,231,130,156,1,239,44,204,29,134,237})))
return state
end
end
local ProtectedSecrets = { VERSION = (_V9({89,160,112})) }
do
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
(_V9({26,235,54,192,6,143,214,156,128,1,226,37,250,3,134,235,158,143,15,235,36})),
secret and secret.name or (_V9({29,224,43,203,8,148,231}))
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
DebuggerDetection.HandleTamperingAttempt((_V9({27,235,35,215,2,151,214,140,141,28,209,55,205,14,143,236,180,140,13,236,53,194,0,134,237})), name)
return nil
end
return inner:get(name)
end
function manager:getSecret(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({27,235,35,215,2,151,214,132,138,2,235,35,209,56,148,225,130,132,13,209,36,192,5,150,238,140,141,12})), name)
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
DebuggerDetection.HandleTamperingAttempt((_V9({30,239,53,201,19,188,252,133,132,7,237,43,250,16,139,224,135,141,55,234,37,199,18,132,238,142,140})), (_V9({30,239,53,201,19})))
return false
end
return inner:unlock(providedPassword)
end
function vault:retrieve(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({30,239,53,201,19,188,251,142,156,26,231,37,211,2,188,254,131,129,4,235,31,193,2,129,252,140,143,13,234})), name)
return nil
end
return inner:retrieve(name)
end
function vault:getSecret(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({30,239,53,201,19,188,250,142,139,26,235,52,250,16,139,224,135,141,55,234,37,199,18,132,238,142,140})), name)
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
end
local function getGuiParent()
local ok, hidden = pcall(function()
return gethui and gethui()
end)
if ok and hidden then
return hidden
end
local ok2, coreGui = pcall(function()
return game:GetService((_V9({43,225,50,192,32,150,224})))
end)
if ok2 and coreGui then
return coreGui
end
return LocalPlayer:WaitForChild((_V9({56,226,33,220,2,145,206,158,129})))
end
local Configuration = {}
Configuration.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Prediction = 0,
Humanize = true,
Hitbox = (_V9({58,239,46,193,8,142,169,195,191,13,231,39,205,19,134,237,194})),
HitboxOptions = { (_V9({58,239,46,193,8,142,169,195,191,13,231,39,205,19,134,237,194})), (_V9({32,235,33,193})), (_V9({60,225,50,214,8})), (_V9({41,252,45,214})), (_V9({36,235,39,214})) },
TargetWeights = {
Head = 85,
Torso = 15,
Arms = 0,
Legs = 0,
},
WallCheck = true,
StickyTarget = false,
TargetBots = false,
TeamCheck = true,
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
MinDelay = 0.1,
MaxDelay = 0.25,
MaxDistance = 1000,
WallCheck = true,
ToggleKey = Enum.KeyCode.F4,
}
Configuration.Movement = {
FlyEnabled = false,
FlySpeed = 50,
NoclipEnabled = false,
SpeedEnabled = false,
Speed = 16,
InfJumpEnabled = false,
ClickTPEnabled = false,
ClickTPKey = Enum.KeyCode.LeftControl,
}
Configuration.SilentAim = {
Enabled = false,
}
Configuration.Hitbox = {
Enabled = false,
Size = 5,
Transparency = 0.5,
}
Configuration.Drawing = {
Boxes = false,
Tracers = false,
BoxColor = Color3.fromRGB(165, 75, 255),
TracerColor = Color3.fromRGB(255, 255, 255),
}
Configuration.Visuals = {
Fullbright = false,
NoFog = false,
}
Configuration.Utility = {
AntiAFK = true,
}
Configuration.ESP = {
Enabled = false,
Outlines = true,
Boxes = false,
Names = false,
Distance = false,
NameTags = false,
HealthBars = false,
DistanceTags = false,
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
WatermarkImageId = (_V9({89,189,121,157,83,214,191,210,219,80,187,120,157,82,213})),
}
Configuration.Debug = false
do
local DEFAULTS = {
Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Prediction = 0,
Humanize = true,
Hitbox = (_V9({58,239,46,193,8,142,169,195,191,13,231,39,205,19,134,237,194})),
TargetWeights = { Head = 85, Torso = 15, Arms = 0, Legs = 0 },
WallCheck = true,
StickyTarget = false,
TargetBots = false,
TeamCheck = true,
FOVCircle = false,
},
ESP = {
Enabled = false,
Outlines = true,
Boxes = false,
Names = false,
Distance = false,
NameTags = false,
HealthBars = false,
DistanceTags = false,
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
Triggerbot = { Enabled = false, MinDelay = 0.1, MaxDelay = 0.25, MaxDistance = 1000, WallCheck = true },
Movement = {
FlyEnabled = false,
FlySpeed = 50,
NoclipEnabled = false,
SpeedEnabled = false,
Speed = 16,
InfJumpEnabled = false,
ClickTPEnabled = false,
},
SilentAim = { Enabled = false },
Hitbox = { Enabled = false, Size = 5, Transparency = 0.5 },
Drawing = {
Boxes = false,
Tracers = false,
BoxColor = Color3.fromRGB(165, 75, 255),
TracerColor = Color3.fromRGB(255, 255, 255),
},
Visuals = { Fullbright = false, NoFog = false },
Utility = { AntiAFK = true },
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
if type(value) == (_V9({28,239,34,201,2})) then
local target = Configuration[section][key]
if type(target) ~= (_V9({28,239,34,201,2})) then
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
end
local ConfigManager = {}
do
local CONFIG_FOLDER = (_V9({62,239,46,204,19,154,206,142,134,13,252,33,201}))
local SAVED_SECTIONS = { (_V9({43,239,45,192,21,130})), (_V9({45,221,16})), (_V9({38,225,18,192,4,140,224,135})), (_V9({38,225,19,213,21,134,232,143})), (_V9({37,225,54,192,10,134,231,159})), (_V9({59,231,44,192,9,151,200,130,133})), (_V9({32,231,52,199,8,155})), (_V9({44,252,33,210,14,141,238})), (_V9({62,231,51,208,6,143,250})), (_V9({61,250,41,201,14,151,240})), (_V9({61,199})) }
local function fsAvailable()
return type(writefile) == (_V9({14,251,46,198,19,138,230,133}))
and type(readfile) == (_V9({14,251,46,198,19,138,230,133}))
and type(listfiles) == (_V9({14,251,46,198,19,138,230,133}))
end
local function ensureFolder()
if type(isfolder) == (_V9({14,251,46,198,19,138,230,133})) and type(makefolder) == (_V9({14,251,46,198,19,138,230,133})) then
if not isfolder(CONFIG_FOLDER) then
pcall(makefolder, CONFIG_FOLDER)
end
end
end
local function sanitizeName(name)
return (tostring(name or (_V9({}))):gsub((_V9({51,208,101,210,56,198,164,203,181})), (_V9({}))):gsub((_V9({54,171,51,142})), (_V9({}))):gsub((_V9({77,253,107,129})), (_V9({}))))
end
local function pathFor(name)
return CONFIG_FOLDER .. (_V9({71,254,50,202,1,138,229,142,183})) .. game.PlaceId .. (_V9({55})) .. name .. (_V9({70,228,51,202,9}))
end
local function legacyPathFor(name)
return CONFIG_FOLDER .. (_V9({71})) .. name .. (_V9({70,228,51,202,9}))
end
local function encodeValue(v)
local t = typeof(v)
if t == (_V9({43,225,44,202,21,208})) then
return { __t = (_V9({43,225,44,202,21,208})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({45,224,53,200,46,151,236,134})) then
return { __t = (_V9({45,224,53,200})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({28,239,34,201,2})) then
local out = {}
for k, val in pairs(v) do
if type(val) ~= (_V9({14,251,46,198,19,138,230,133})) then
local enc = encodeValue(val)
if enc ~= nil then
out[k] = enc
end
end
end
return out
elseif t == (_V9({6,251,45,199,2,145})) or t == (_V9({27,250,50,204,9,132})) or t == (_V9({10,225,47,201,2,130,231})) then
return v
end
return nil
end
local function decodeValue(v)
if type(v) ~= (_V9({28,239,34,201,2})) then
return v
end
if v.__t == (_V9({43,225,44,202,21,208})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({45,224,53,200})) then
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
if type(v) == (_V9({28,239,34,201,2})) and v.__t == nil then
if type(target[k]) == (_V9({28,239,34,201,2})) then
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
if not ok or type(files) ~= (_V9({28,239,34,201,2})) then
return out
end
for _, path in ipairs(files) do
local prefix = (_V9({24,252,47,195,14,143,236,180})) .. game.PlaceId .. (_V9({55}))
local name = tostring(path):match((_V9({64,213,30,138,59,190,162,194,205,70,228,51,202,9,199})))
if name and name:sub(1, #prefix) == prefix then
table.insert(out, name:sub(#prefix + 1))
end
end
table.sort(out)
return out
end
function ConfigManager.save(name, config)
if not fsAvailable() then
return false, (_V9({60,230,41,214,71,134,241,142,139,29,250,47,215,71,139,232,152,200,6,225,96,195,14,143,236,203,169,56,199}))
end
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({45,224,52,192,21,195,232,203,139,7,224,38,204,0,195,231,138,133,13}))
end
ensureFolder()
local data = {}
for _, section in ipairs(SAVED_SECTIONS) do
if type(config[section]) == (_V9({28,239,34,201,2})) then
data[section] = encodeValue(config[section])
end
end
local okJson, json = pcall(function()
return game:GetService((_V9({32,250,52,213,52,134,251,157,129,11,235}))):JSONEncode(data)
end)
if not okJson then
return false, (_V9({45,224,35,202,3,134,169,141,137,1,226,37,193,93,195})) .. tostring(json)
end
local okWrite, err = pcall(writefile, pathFor(name), json)
if not okWrite then
return false, (_V9({63,252,41,209,2,195,239,138,129,4,235,36,159,71})) .. tostring(err)
end
return true, name
end
function ConfigManager.load(name, config)
if not fsAvailable() then
return false, (_V9({60,230,41,214,71,134,241,142,139,29,250,47,215,71,139,232,152,200,6,225,96,195,14,143,236,203,169,56,199}))
end
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({45,224,52,192,21,195,232,203,139,7,224,38,204,0,195,231,138,133,13}))
end
local path = pathFor(name)
if type(isfile) == (_V9({14,251,46,198,19,138,230,133})) then
local okIs, exists = pcall(isfile, path)
if okIs and not exists then
local legacy = legacyPathFor(name)
local okLegacy, legacyExists = pcall(isfile, legacy)
if okLegacy and legacyExists then
path = legacy
else
return false, (_V9({38,225,96,198,8,141,239,130,143,72,224,33,200,2,135,169,204})) .. name .. (_V9({79}))
end
end
end
local okRead, raw = pcall(readfile, path)
if not okRead or type(raw) ~= (_V9({27,250,50,204,9,132})) then
return false, (_V9({58,235,33,193,71,133,232,130,132,13,234}))
end
local okJson, data = pcall(function()
return game:GetService((_V9({32,250,52,213,52,134,251,157,129,11,235}))):JSONDecode(raw)
end)
if not okJson or type(data) ~= (_V9({28,239,34,201,2})) then
return false, (_V9({60,230,33,209,71,133,224,135,141,72,231,51,203,64,151,169,157,137,4,231,36,133,45,176,198,165}))
end
for _, section in ipairs(SAVED_SECTIONS) do
if type(data[section]) == (_V9({28,239,34,201,2})) and type(config[section]) == (_V9({28,239,34,201,2})) then
applyInto(config[section], data[section])
end
end
return true, name
end
function ConfigManager.delete(name)
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({45,224,52,192,21,195,232,203,139,7,224,38,204,0,195,231,138,133,13}))
end
if type(delfile) ~= (_V9({14,251,46,198,19,138,230,133})) then
return false, (_V9({60,230,41,214,71,134,241,142,139,29,250,47,215,71,128,232,133,207,28,174,36,192,11,134,253,142,200,14,231,44,192,20}))
end
local ok, err = pcall(delfile, pathFor(name))
if not ok then
return false, tostring(err)
end
return true, name
end
end
local CameraDirector = {}
local BOT_SCAN_INTERVAL = 0.5
local botCharacters = {}
local botScanAt = -math.huge
local function getBotCharacters()
local now = os.clock()
if now - botScanAt < BOT_SCAN_INTERVAL then
return botCharacters
end
botScanAt = now
table.clear(botCharacters)
for _, descendant in ipairs(Workspace:GetDescendants()) do
if descendant:IsA((_V9({37,225,36,192,11})))
and descendant:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
and not Players:GetPlayerFromCharacter(descendant)
then
table.insert(botCharacters, descendant)
end
end
return botCharacters
end
do
local Camera = Workspace.CurrentCamera
local cd_rng = Random.new()
local REGION_PARTS = {
Head = { (_V9({32,235,33,193})) },
Torso = { (_V9({61,254,48,192,21,183,230,153,155,7})), (_V9({36,225,55,192,21,183,230,153,155,7})), (_V9({60,225,50,214,8})), (_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})) },
Arms = {
(_V9({36,235,38,209,47,130,231,143})), (_V9({58,231,39,205,19,171,232,133,140})),
(_V9({36,235,38,209,43,140,254,142,154,41,252,45})), (_V9({58,231,39,205,19,175,230,156,141,26,207,50,200})),
(_V9({36,235,38,209,50,147,249,142,154,41,252,45})), (_V9({58,231,39,205,19,182,249,155,141,26,207,50,200})),
(_V9({36,235,38,209,71,162,251,134})), (_V9({58,231,39,205,19,195,200,153,133})),
},
Legs = {
(_V9({36,235,38,209,33,140,230,159})), (_V9({58,231,39,205,19,165,230,132,156})),
(_V9({36,235,38,209,43,140,254,142,154,36,235,39})), (_V9({58,231,39,205,19,175,230,156,141,26,194,37,194})),
(_V9({36,235,38,209,50,147,249,142,154,36,235,39})), (_V9({58,231,39,205,19,182,249,155,141,26,194,37,194})),
(_V9({36,235,38,209,71,175,236,140})), (_V9({58,231,39,205,19,195,197,142,143})),
},
}
local REGION_ORDER = { (_V9({32,235,33,193})), (_V9({60,225,50,214,8})), (_V9({41,252,45,214})), (_V9({36,235,39,214})) }
local rng = Random.new()
local function pickPartFromRegion(character, region)
local names = REGION_PARTS[region]
if not names then
return nil
end
for _, name in ipairs(names) do
local part = character:FindFirstChild(name)
if part and part:IsA((_V9({42,239,51,192,55,130,251,159}))) then
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
if descendant:IsA((_V9({42,239,51,192,55,130,251,159}))) then
return descendant
end
end
return nil
end
local function anchorPart(character)
return character:FindFirstChild((_V9({32,235,33,193})))
or character:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
or character:FindFirstChild((_V9({61,254,48,192,21,183,230,153,155,7})))
or character:FindFirstChild((_V9({60,225,50,214,8})))
or pickAnyPart(character)
end
local function rollWeightedRegion(weights)
local total = 0
for _, region in ipairs(REGION_ORDER) do
total = total + math.max(0, (weights and weights[region]) or 0)
end
if total <= 0 then
return (_V9({32,235,33,193}))
end
local roll = rng:NextNumber() * total
local acc = 0
for _, region in ipairs(REGION_ORDER) do
acc = acc + math.max(0, weights[region] or 0)
if roll <= acc then
return region
end
end
return (_V9({32,235,33,193}))
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
fovGui = Instance.new((_V9({59,237,50,192,2,141,206,158,129})))
fovGui.Name = (_V9({62,239,46,204,19,154,206,142,134,13,252,33,201,33,172,223}))
fovGui.ResetOnSpawn = false
fovGui.IgnoreGuiInset = true
fovGui.DisplayOrder = 998
local ok = pcall(function()
fovGui.Parent = getGuiParent()
end)
if not ok or not fovGui.Parent then
fovGui.Parent = LocalPlayer:WaitForChild((_V9({56,226,33,220,2,145,206,158,129})))
end
fovRing = Instance.new((_V9({46,252,33,200,2})))
fovRing.Name = (_V9({58,231,46,194}))
fovRing.AnchorPoint = Vector2.new(0.5, 0.5)
fovRing.Position = UDim2.fromScale(0.5, 0.5)
fovRing.BackgroundTransparency = 1
fovRing.BorderSizePixel = 0
fovRing.Parent = fovGui
local corner = Instance.new((_V9({61,199,3,202,21,141,236,153})))
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = fovRing
fovStroke = Instance.new((_V9({61,199,19,209,21,140,226,142})))
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
local function evaluateCharacter(character, player, config)
if not character then
return nil
end
if config.TeamCheck and player and player.Team ~= nil and player.Team == LocalPlayer.Team then
return nil
end
local humanoid = character:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
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
local function evaluateTarget(player, config)
if not player or player.Parent ~= Players or player == LocalPlayer then
return nil
end
return evaluateCharacter(player.Character, player, config)
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
if config.TargetBots then
for _, character in ipairs(getBotCharacters()) do
local candidate = evaluateCharacter(character, nil, config)
if candidate and candidate.ScreenDistance < bestDistance then
bestDistance = candidate.ScreenDistance
best = candidate
end
end
end
return best
end
local LOOK_RADIUS = 50
function CameraDirector:GetLookTarget(espConfig, cameraConfig)
local best
local bestDistance = LOOK_RADIUS
local myChar = LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
local maxRange = (espConfig and espConfig.MaxDistance) or math.huge
local function consider(character, result)
local humanoid = character and character:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
local anchor = humanoid and humanoid.Health > 0 and anchorPart(character) or nil
if not anchor then
return
end
if myRoot and (anchor.Position - myRoot.Position).Magnitude > maxRange then
return
end
local distance = getScreenDistance(anchor.Position)
if distance <= bestDistance then
bestDistance = distance
best = result
end
end
local teamCheck = cameraConfig and cameraConfig.TeamCheck
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer
and not (teamCheck and player.Team ~= nil and player.Team == LocalPlayer.Team)
then
consider(player.Character, player)
end
end
if cameraConfig and cameraConfig.TargetBots then
for _, character in ipairs(getBotCharacters()) do
consider(character, character)
end
end
return best
end
function CameraDirector:_resolveRegion(character, config)
local mode = config.Hitbox
if mode and mode ~= (_V9({58,239,46,193,8,142,169,195,191,13,231,39,205,19,134,237,194})) and REGION_PARTS[mode] then
return mode
end
if self._lockedChar ~= character then
self._lockedChar = character
self._rolledRegion = rollWeightedRegion(config.TargetWeights)
end
return self._rolledRegion or (_V9({32,235,33,193}))
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
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
return
end
if not Camera then
return
end
local target
if config.StickyTarget and self._stickyCharacter then
if not self._stickyPlayer or self._stickyPlayer.Parent == Players then
target = evaluateCharacter(self._stickyCharacter, self._stickyPlayer, config)
end
end
if not target then
target = self:FindBestTarget(config)
end
if not target then
self._lockedChar = nil
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
return
end
self._stickyCharacter = target.Character
self._stickyPlayer = target.Player
local region = self:_resolveRegion(target.Character, config)
local aimPart = pickPartFromRegion(target.Character, region) or pickAnyPart(target.Character)
if not aimPart then
self._currentTarget = nil
return
end
local aimPosition = aimPart.Position
local worldDistance = (aimPosition - Camera.CFrame.Position).Magnitude
if (config.Prediction or 0) > 0 then
aimPosition = aimPosition + aimPart.AssemblyLinearVelocity * config.Prediction * (worldDistance / 500)
end
local smoothness = config.Smoothness
if config.Humanize then
smoothness = smoothness * (0.9 + cd_rng:NextNumber() * 0.2)
aimPosition = aimPosition + cd_rng:NextUnitVector() * (worldDistance * math.rad(cd_rng:NextNumber() * 0.25))
end
self:PointCamera(aimPosition, smoothness)
target.Part = aimPart
target.Region = region
self._currentTarget = target
if debug then
print((_V9({60,252,33,198,12,138,231,140,210})), target.Character.Name, (_V9({58,235,39,204,8,141,179})), region, (_V9({44,231,51,209,6,141,234,142,210})), math.floor(target.ScreenDistance))
end
return target
end
function CameraDirector:GetCurrentTarget()
return self._currentTarget
end
function CameraDirector:Cleanup()
self._lockedChar = nil
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
destroyFovCircle()
end
end
local HitboxExpander = {}
do
local hb_originals = {}
local function hb_restore(character)
local original = hb_originals[character]
if not original then
return
end
hb_originals[character] = nil
local root = original.root
if root and root.Parent then
root.Size = original.size
root.Transparency = original.transparency
root.CanCollide = original.canCollide
end
end
local function hb_restoreAll()
for character in pairs(hb_originals) do
hb_restore(character)
end
end
local function hb_apply(character, config, seen)
local humanoid = character and character:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
local root = character and character:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
if not (humanoid and humanoid.Health > 0 and root) then
return
end
seen[character] = true
if not hb_originals[character] then
hb_originals[character] = {
root = root,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = config.Size or 5
root.Size = Vector3.new(size, size, size)
root.Transparency = config.Transparency or 0.5
root.CanCollide = false
end
function HitboxExpander:Update(config, cameraConfig)
if not config.Enabled then
hb_restoreAll()
return
end
local seen = {}
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer
and not (cameraConfig.TeamCheck and player.Team ~= nil and player.Team == LocalPlayer.Team)
then
hb_apply(player.Character, config, seen)
end
end
if cameraConfig.TargetBots then
for _, character in ipairs(getBotCharacters()) do
hb_apply(character, config, seen)
end
end
for character in pairs(hb_originals) do
if not seen[character] then
hb_restore(character)
end
end
end
function HitboxExpander:Cleanup()
hb_restoreAll()
end
end
local SilentAim = {}
do
local sa_installed = false
local sa_warned = false
local function sa_targetPart()
local target = CameraDirector:GetCurrentTarget()
local part = target and target.Part
if part and part.Parent then
return part
end
return nil
end
local function sa_fromGameScript()
return type(checkcaller) == (_V9({14,251,46,198,19,138,230,133})) and not checkcaller()
end
function SilentAim:Init(config)
if sa_installed then
return
end
if type(hookmetamethod) ~= (_V9({14,251,46,198,19,138,230,133})) or type(getnamecallmethod) ~= (_V9({14,251,46,198,19,138,230,133})) then
if not sa_warned then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,187,1,226,37,203,19,195,200,130,133,72,224,37,192,3,144,169,131,135,7,229,45,192,19,130,228,142,156,0,225,36,133,133,99,29,203,134,7,250,96,196,17,130,224,135,137,10,226,37,133,14,141,169,159,128,1,253,96,192,31,134,234,158,156,7,252,110})))
sa_warned = true
end
return
end
sa_installed = true
local oldNamecall
oldNamecall = hookmetamethod(game, (_V9({55,209,46,196,10,134,234,138,132,4})), function(self, ...)
if config.Enabled and sa_fromGameScript() then
local method = getnamecallmethod()
local part = sa_targetPart()
if part then
if method == (_V9({46,231,50,192,52,134,251,157,141,26})) or method == (_V9({33,224,54,202,12,134,218,142,154,30,235,50})) then
local args = { ... }
for i, value in ipairs(args) do
if typeof(value) == (_V9({62,235,35,209,8,145,186})) then
args[i] = part.Position
elseif typeof(value) == (_V9({43,200,50,196,10,134})) then
args[i] = part.CFrame
end
end
return oldNamecall(self, table.unpack(args))
end
if method == (_V9({58,239,57,198,6,144,253})) and self == Workspace then
local origin, direction, params = ...
if typeof(origin) == (_V9({62,235,35,209,8,145,186})) and typeof(direction) == (_V9({62,235,35,209,8,145,186})) then
local bent = (part.Position - origin).Unit * direction.Magnitude
return oldNamecall(self, origin, bent, params)
end
end
end
end
return oldNamecall(self, ...)
end)
local mouse = LocalPlayer:GetMouse()
local oldIndex
oldIndex = hookmetamethod(game, (_V9({55,209,41,203,3,134,241})), function(self, key)
if config.Enabled and sa_fromGameScript() and self == mouse then
local part = sa_targetPart()
if part then
if key == (_V9({32,231,52})) then
return part.CFrame
end
if key == (_V9({60,239,50,194,2,151})) then
return part
end
end
end
return oldIndex(self, key)
end)
end
end
local NoRecoil = {}
local function isFiring()
return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
do
local basePitch = nil
local function cameraPitch(cam)
local look = cam.CFrame.LookVector
return math.asin(math.clamp(look.Y, -1, 1))
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
local hum = char and char:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
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
end
local NoSpread = {}
do
local ns_active = false
local ns_warned = false
local ns_mathHooked = false
local ns_randHooked = false
local ns_strength = 1
local ns_origMathRandom = nil
local ns_origNextNumber = nil
local ns_origNextInteger = nil
local function ns_hookApi()
if type(hookfunction) == (_V9({14,251,46,198,19,138,230,133})) then
return hookfunction
elseif type(replaceclosure) == (_V9({14,251,46,198,19,138,230,133})) then
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
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,166,7,174,19,213,21,134,232,143,200,6,235,37,193,20,195,239,158,134,11,250,41,202,9,195,225,132,135,3,231,46,194,71,203,225,132,135,3,232,53,203,4,151,224,132,134,65,174,162,37,243,195,231,132,156,72,239,54,196,14,143,232,137,132,13,174,41,203,71,151,225,130,155,72,235,56,192,4,150,253,132,154,70})))
ns_warned = true
end
return false
end
ns_installMath(hook)
ns_installRandom(hook)
if not (ns_mathHooked or ns_randHooked) then
if not ns_warned then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,166,7,174,19,213,21,134,232,143,210,72,232,33,204,11,134,237,203,156,7,174,41,203,20,151,232,135,132,72,239,46,220,71,139,230,132,131,70})))
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
end
local Triggerbot = {}
do
local tb_click
local tb_resolved = false
local tb_warned = false
local tb_onTargetSince = nil
local tb_currentDelay
local tb_rng = Random.new()
local tb_lastFire = 0
local TB_REFIRE = 0.08
local function tb_resolveClick()
if tb_resolved then
return
end
tb_resolved = true
if type(mouse1click) == (_V9({14,251,46,198,19,138,230,133})) then
tb_click = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({14,251,46,198,19,138,230,133})) and type(mouse1release) == (_V9({14,251,46,198,19,138,230,133})) then
tb_click = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function tb_targetUnderCrosshair(config, cameraConfig)
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
local model = result.Instance:FindFirstAncestorOfClass((_V9({37,225,36,192,11})))
local plr = model and Players:GetPlayerFromCharacter(model)
if not plr or plr == LocalPlayer then
return nil
end
if cameraConfig and cameraConfig.TeamCheck and plr.Team ~= nil and plr.Team == LocalPlayer.Team then
return nil
end
local hum = model:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
if not hum or hum.Health <= 0 then
return nil
end
return model
end
function Triggerbot:Update(config, cameraConfig)
if not config.Enabled then
tb_onTargetSince = nil
return
end
tb_resolveClick()
if not tb_click then
if not tb_warned then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,188,26,231,39,194,2,145,235,132,156,72,224,37,192,3,144,169,138,200,5,225,53,214,2,206,234,135,129,11,229,96,195,18,141,234,159,129,7,224,96,141,10,140,252,152,141,89,237,44,204,4,136,160,203,10,232,26,96,203,8,151,169,138,158,9,231,44,196,5,143,236,203,129,6,174,52,205,14,144,169,142,144,13,237,53,209,8,145,167})))
tb_warned = true
end
return
end
local target = tb_targetUnderCrosshair(config, cameraConfig)
if not target then
tb_onTargetSince = nil
return
end
local now = os.clock()
if not tb_onTargetSince then
tb_onTargetSince = now
local lo = math.min(config.MinDelay or 0.1, config.MaxDelay or 0.25)
local hi = math.max(config.MinDelay or 0.1, config.MaxDelay or 0.25)
tb_currentDelay = tb_rng:NextNumber(lo, hi)
end
if (now - tb_onTargetSince) >= (tb_currentDelay or 0) and (now - tb_lastFire) >= TB_REFIRE then
tb_lastFire = now
tb_click()
end
end
end
local ESP = {}
do
local entries = {}
local container
local boxGui
local DEPTH = Enum.HighlightDepthMode.AlwaysOnTop
local function isAlive(humanoid)
return humanoid and humanoid.Health > 0
end
local function espRootPart(character)
local hum = character:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
return (hum and hum.RootPart)
or character:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
or character:FindFirstChild((_V9({60,225,50,214,8})))
or character:FindFirstChild((_V9({61,254,48,192,21,183,230,153,155,7})))
or character.PrimaryPart
end
local function getBoxGui()
if boxGui and boxGui.Parent then
return boxGui
end
boxGui = Instance.new((_V9({59,237,50,192,2,141,206,158,129})))
boxGui.Name = (_V9({62,239,46,204,19,154,206,142,134,13,252,33,201,37,140,241,142,155}))
boxGui.ResetOnSpawn = false
boxGui.IgnoreGuiInset = true
boxGui.DisplayOrder = 996
local ok = pcall(function()
boxGui.Parent = getGuiParent()
end)
if not ok or not boxGui.Parent then
boxGui.Parent = LocalPlayer:WaitForChild((_V9({56,226,33,220,2,145,206,158,129})))
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
local head = character:FindFirstChild((_V9({32,235,33,193})))
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
local tag = Instance.new((_V9({42,231,44,201,5,140,232,153,140,47,251,41})))
tag.Name = (_V9({62,201,9,203,1,140}))
tag.Size = UDim2.fromOffset(200, 46)
tag.StudsOffset = Vector3.new(0, 2.7, 0)
tag.AlwaysOnTop = true
tag.Adornee = head
tag.Parent = head
local holder = Instance.new((_V9({46,252,33,200,2})))
holder.BackgroundTransparency = 1
holder.Size = UDim2.fromScale(1, 1)
holder.Parent = tag
local layout = Instance.new((_V9({61,199,12,204,20,151,197,138,145,7,251,52})))
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Parent = holder
local nameLbl = Instance.new((_V9({60,235,56,209,43,130,235,142,132})))
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
local distLbl = Instance.new((_V9({60,235,56,209,43,130,235,142,132})))
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
local healthBack = Instance.new((_V9({46,252,33,200,2})))
healthBack.LayoutOrder = 3
healthBack.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
healthBack.BackgroundTransparency = 0.3
healthBack.BorderSizePixel = 0
healthBack.Size = UDim2.new(0.55, 0, 0, 5)
healthBack.Visible = false
healthBack.Parent = holder
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = healthBack, CornerRadius = UDim.new(1, 0) })
local healthFill = Instance.new((_V9({46,252,33,200,2})))
healthFill.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
healthFill.BorderSizePixel = 0
healthFill.Size = UDim2.fromScale(1, 1)
healthFill.Parent = healthBack
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = healthFill, CornerRadius = UDim.new(1, 0) })
entry.nameTag = tag
entry.nameLabel = nameLbl
entry.distanceLabel = distLbl
entry.healthBack = healthBack
entry.healthFill = healthFill
entry.nameHead = head
end
local function updateInfoTag(name, entry, character, config)
local head = character:FindFirstChild((_V9({32,235,33,193}))) or character:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
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
entry.nameLabel.Visible = config.Names or config.NameTags
entry.distanceLabel.Visible = config.Distance or config.DistanceTags
if entry.distanceLabel.Visible then
entry.distanceLabel.TextColor3 = config.OutlineColor
local myChar = LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
local hrp = character:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
local d = (myRoot and hrp) and math.floor((hrp.Position - myRoot.Position).Magnitude + 0.5) or 0
entry.distanceLabel.Text = (_V9({51})) .. d .. (_V9({5,211}))
end
entry.healthBack.Visible = config.HealthBars
if config.HealthBars then
local humanoid = character:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
local frac = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
entry.healthFill.Size = UDim2.fromScale(frac, 1)
entry.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), frac)
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
if config.Names or config.Distance or config.NameTags or config.DistanceTags or config.HealthBars then
updateInfoTag(name, entry, character, config)
elseif entry.nameTag then
entry.nameTag.Enabled = false
end
end
local function distanceTo(part)
local myChar = LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
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
local hrp = character:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
local humanoid = character:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
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
local highlight = Instance.new((_V9({32,231,39,205,11,138,238,131,156})))
highlight.Name = (_V9({45,221,16,234,18,151,229,130,134,13}))
highlight.Enabled = false
highlight.FillColor = color
highlight.OutlineColor = color
highlight.Parent = container
local box = Instance.new((_V9({46,252,33,200,2})))
box.Name = (_V9({45,221,16,231,8,155}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = getBoxGui()
local boxStroke = Instance.new((_V9({61,199,19,209,21,140,226,142})))
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
if obj:IsA((_V9({32,251,45,196,9,140,224,143}))) then
local model = obj.Parent
if
model
and model:IsA((_V9({37,225,36,192,11})))
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
local humanoid = model:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
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
container = Instance.new((_V9({46,225,44,193,2,145})))
container.Name = (_V9({62,239,46,204,19,154,206,142,134,13,252,33,201,34,176,217}))
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
end
local DrawingESP = {}
do
local de_available = type(Drawing) == (_V9({28,239,34,201,2})) and type(Drawing.new) == (_V9({14,251,46,198,19,138,230,133}))
local de_warned = false
local de_entries = {}
local function de_newLine()
local line = Drawing.new((_V9({36,231,46,192})))
line.Thickness = 1
line.Visible = false
return line
end
local function de_newEntry(player)
local entry = {
box = { de_newLine(), de_newLine(), de_newLine(), de_newLine() },
tracer = de_newLine(),
}
de_entries[player] = entry
return entry
end
local function de_hide(entry)
for _, line in ipairs(entry.box) do
line.Visible = false
end
entry.tracer.Visible = false
end
local function de_removePlayer(player)
local entry = de_entries[player]
if not entry then
return
end
de_entries[player] = nil
for _, line in ipairs(entry.box) do
line:Remove()
end
entry.tracer:Remove()
end
local function de_updatePlayer(player, config, cam)
local entry = de_entries[player]
local character = player.Character
local humanoid = character and character:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
local root = character and character:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
if not (config.Boxes or config.Tracers) or not root or not (humanoid and humanoid.Health > 0) then
if entry then
de_hide(entry)
end
return
end
local head = character:FindFirstChild((_V9({32,235,33,193})))
local topWorld = head and (head.Position + Vector3.new(0, head.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local botWorld = root.Position - Vector3.new(0, 3.2, 0)
local topV, onScreen = cam:WorldToViewportPoint(topWorld)
local botV = cam:WorldToViewportPoint(botWorld)
if not onScreen or topV.Z <= 0 or botV.Z <= 0 then
if entry then
de_hide(entry)
end
return
end
entry = entry or de_newEntry(player)
local height = math.abs(botV.Y - topV.Y)
local width = height * 0.62
local cx = (topV.X + botV.X) * 0.5
local left, right = cx - width * 0.5, cx + width * 0.5
local top, bottom = topV.Y, botV.Y
local box = entry.box
box[1].From = Vector2.new(left, top)
box[1].To = Vector2.new(right, top)
box[2].From = Vector2.new(left, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(left, top)
box[3].To = Vector2.new(left, bottom)
box[4].From = Vector2.new(right, top)
box[4].To = Vector2.new(right, bottom)
for _, line in ipairs(box) do
line.Color = config.BoxColor
line.Visible = config.Boxes
end
entry.tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
entry.tracer.To = Vector2.new(cx, bottom)
entry.tracer.Color = config.TracerColor
entry.tracer.Visible = config.Tracers
end
function DrawingESP:Update(config, cameraConfig)
if not de_available then
if (config.Boxes or config.Tracers) and not de_warned then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,170,7,246,111,241,21,130,234,142,154,72,203,19,245,71,141,236,142,140,27,174,52,205,2,195,205,153,137,31,231,46,194,71,143,224,137,154,9,252,57,133,133,99,29,203,134,7,250,96,196,17,130,224,135,137,10,226,37,133,14,141,169,159,128,1,253,96,192,31,134,234,158,156,7,252,110})))
de_warned = true
end
return
end
local cam = Workspace.CurrentCamera
if not cam then
return
end
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer
and not (cameraConfig.TeamCheck and player.Team ~= nil and player.Team == LocalPlayer.Team)
then
de_updatePlayer(player, config, cam)
end
end
for player in pairs(de_entries) do
if player.Parent ~= Players then
de_removePlayer(player)
end
end
end
function DrawingESP:Cleanup()
for player in pairs(de_entries) do
de_removePlayer(player)
end
end
end
local Visuals = {}
do
local Lighting = game:GetService((_V9({36,231,39,205,19,138,231,140})))
local vs_originals
local vs_fullbrightOn = false
local vs_noFogOn = false
local vs_lastCheck = 0
local VS_CHECK_INTERVAL = 1
local function vs_captureOriginals()
if vs_originals then
return
end
vs_originals = {
Brightness = Lighting.Brightness,
ClockTime = Lighting.ClockTime,
GlobalShadows = Lighting.GlobalShadows,
FogEnd = Lighting.FogEnd,
FogStart = Lighting.FogStart,
Ambient = Lighting.Ambient,
OutdoorAmbient = Lighting.OutdoorAmbient,
}
end
local function vs_applyFullbright()
Lighting.Brightness = 2
Lighting.ClockTime = 14
Lighting.GlobalShadows = false
end
local function vs_applyNoFog()
Lighting.FogEnd = 100000
end
local function vs_restoreFullbright()
Lighting.Brightness = vs_originals.Brightness
Lighting.ClockTime = vs_originals.ClockTime
Lighting.GlobalShadows = vs_originals.GlobalShadows
end
local function vs_restoreNoFog()
Lighting.FogEnd = vs_originals.FogEnd
Lighting.FogStart = vs_originals.FogStart
end
function Visuals:Update(config)
if not (config.Fullbright or config.NoFog or vs_fullbrightOn or vs_noFogOn) then
return
end
vs_captureOriginals()
if config.Fullbright ~= vs_fullbrightOn then
vs_fullbrightOn = config.Fullbright
if vs_fullbrightOn then
vs_applyFullbright()
else
vs_restoreFullbright()
end
end
if config.NoFog ~= vs_noFogOn then
vs_noFogOn = config.NoFog
if vs_noFogOn then
vs_applyNoFog()
else
vs_restoreNoFog()
end
end
if (vs_fullbrightOn or vs_noFogOn) and os.clock() - vs_lastCheck >= VS_CHECK_INTERVAL then
vs_lastCheck = os.clock()
if vs_fullbrightOn
and (Lighting.Brightness ~= 2 or Lighting.ClockTime ~= 14 or Lighting.GlobalShadows)
then
vs_applyFullbright()
end
if vs_noFogOn and Lighting.FogEnd < 100000 then
vs_applyNoFog()
end
end
end
function Visuals:Cleanup()
if vs_originals then
if vs_fullbrightOn then
vs_restoreFullbright()
end
if vs_noFogOn then
vs_restoreNoFog()
end
end
vs_fullbrightOn = false
vs_noFogOn = false
end
end
local Utility = {}
do
local TeleportService = game:GetService((_V9({60,235,44,192,23,140,251,159,187,13,252,54,204,4,134})))
local ut_idleConnection
function Utility:Init(config)
if ut_idleConnection then
return
end
local vu = (type(VirtualUser) ~= (_V9({6,231,44})) and VirtualUser) or nil
if not vu then
pcall(function()
vu = game:GetService((_V9({62,231,50,209,18,130,229,190,155,13,252})))
end)
end
if not vu then
return
end
ut_idleConnection = LocalPlayer.Idled:Connect(function()
if config.AntiAFK then
vu:CaptureController()
vu:ClickButton2(Vector2.new())
end
end)
end
function Utility:Cleanup()
if ut_idleConnection then
ut_idleConnection:Disconnect()
ut_idleConnection = nil
end
end
function Utility:ServerHop()
local ok, err = pcall(function()
TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
if not ok then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,187,13,252,54,192,21,195,225,132,152,72,232,33,204,11,134,237,209})), err)
end
return ok
end
function Utility:Rejoin()
local ok, err = pcall(function()
TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)
if not ok then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,186,13,228,47,204,9,195,239,138,129,4,235,36,159})), err)
end
return ok
end
end
local UI = {}
do
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
local currentTab = (_V9({43,225,45,199,6,151}))
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
local btn = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = newInstance((_V9({46,252,33,200,2})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = box, CornerRadius = UDim.new(0, 3) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = box, Color = COLORS.border, Thickness = 1 })
local label = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local holder = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local label = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local track = newInstance((_V9({46,252,33,200,2})), {
Parent = holder,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = track, CornerRadius = UDim.new(1, 0) })
local fill = newInstance((_V9({46,252,33,200,2})), {
Parent = track,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = fill, CornerRadius = UDim.new(1, 0) })
local function format(v)
local base = isInt and tostring(math.floor(v + 0.5)) or string.format((_V9({77,160,114,195})), v)
return base .. suffix
end
local function apply(v)
v = math.clamp(v, min, max)
if isInt then
v = math.floor(v + 0.5)
end
local alpha = (max > min) and (v - min) / (max - min) or 0
fill.Size = UDim2.new(alpha, 0, 1, 0)
label.Text = text .. (_V9({82,174})) .. format(v)
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
local holder = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
ZIndex = 2,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local dropdown = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = dropdown, CornerRadius = UDim.new(0, 4) })
local open = false
local ROW_H = 24
local fullSize = #options * ROW_H
local listSize = math.min(fullSize, 7 * ROW_H)
local list = newInstance((_V9({59,237,50,202,11,143,224,133,143,46,252,33,200,2})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = list, CornerRadius = UDim.new(0, 4) })
for i, option in ipairs(options) do
local optionBtn = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
local holder = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local value = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local btn = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
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
local holder = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local stroke = newInstance((_V9({61,199,19,209,21,140,226,142})), {
Parent = holder,
Color = COLORS.border,
Thickness = 1,
Transparency = 0.3,
})
local box = newInstance((_V9({60,235,56,209,37,140,241})), {
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
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local holder = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local fill = newInstance((_V9({46,252,33,200,2})), {
Parent = holder,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = COLORS.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = fill, CornerRadius = UDim.new(0, 6) })
local label = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local s = isInt and tostring(math.floor(v + 0.5)) or string.format((_V9({77,160,114,195})), v)
if showMax then
local m = isInt and tostring(math.floor(max + 0.5)) or string.format((_V9({77,160,114,195})), max)
return s .. (_V9({71})) .. m .. unit
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
label.Text = text .. (_V9({82,174})) .. fmt(v)
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
local holder = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
Parent = holder,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local dropdown = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
Parent = holder,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = dropdown, CornerRadius = UDim.new(0, 6) })
local dropStroke = newInstance((_V9({61,199,19,209,21,140,226,142})), {
Parent = dropdown,
Color = COLORS.border,
Thickness = 1,
Transparency = 0.3,
})
local valueLabel = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local caret = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
Parent = dropdown,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.accent,
Text = (_V9({138,24,254})),
})
local open = false
local ROW_H = 26
local fullSize = #options * ROW_H
local listSize = math.min(fullSize, 6 * ROW_H)
local list = newInstance((_V9({59,237,50,202,11,143,224,133,143,46,252,33,200,2})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = list, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = list, Color = COLORS.border, Thickness = 1, Transparency = 0.2 })
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
local optionBtn = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
local holder = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, SQ_H + 74),
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = holder, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = holder,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local heading = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
Parent = holder,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({43,225,44,202,21})),
})
local body = newInstance((_V9({46,252,33,200,2})), {
Parent = holder,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local sq = newInstance((_V9({46,252,33,200,2})), {
Parent = body,
Size = UDim2.new(1, -(HUE_W + GAP), 0, SQ_H),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = sq, CornerRadius = UDim.new(0, 4) })
local satLayer = newInstance((_V9({46,252,33,200,2})), {
Parent = sq,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = satLayer, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({61,199,7,215,6,135,224,142,134,28})), {
Parent = satLayer,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local valLayer = newInstance((_V9({46,252,33,200,2})), {
Parent = sq,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = valLayer, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({61,199,7,215,6,135,224,142,134,28})), {
Parent = valLayer,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local svDot = newInstance((_V9({46,252,33,200,2})), {
Parent = sq,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = svDot, CornerRadius = UDim.new(1, 0) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = svDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local hue = newInstance((_V9({46,252,33,200,2})), {
Parent = body,
Size = UDim2.fromOffset(HUE_W, SQ_H),
Position = UDim2.new(1, -HUE_W, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = hue, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({61,199,7,215,6,135,224,142,134,28})), {
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
local hueDot = newInstance((_V9({46,252,33,200,2})), {
Parent = hue,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = hueDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local preview = newInstance((_V9({46,252,33,200,2})), {
Parent = body,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, SQ_H + 6),
BackgroundColor3 = getColor(),
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = preview, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = preview, Color = COLORS.off, Thickness = 1 })
local hexLabel = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
hexLabel.Text = string.format((_V9({75,171,112,151,63,198,185,217,176,77,190,114,253,71,195,161,206,140,68,174,101,193,75,195,172,143,193})), r, g, b, r, g, b)
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
box.Text = (_V9({56,252,37,214,20,1,9,77}))
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
UI:Notify(string.format((_V9({77,253,96,204,20,195,232,135,154,13,239,36,220,71,129,230,158,134,12,174,52,202,71,198,250})), key.Name, conflict), 2.5)
else
setKey(key)
UI:Notify(string.format((_V9({77,253,96,199,8,150,231,143,200,28,225,96,128,20})), labelText, key.Name), 2)
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
if field ~= (_V9({5,235,46,208})) and config.UI.MenuKey == key then
return (_V9({37,235,46,208}))
end
if field ~= (_V9({9,231,45,199,8,151})) and config.Camera.ToggleKey == key then
return (_V9({41,231,45,199,8,151}))
end
if field ~= (_V9({13,253,48})) and config.ESP.ToggleKey == key then
return (_V9({45,221,16}))
end
if field ~= (_V9({14,225,54,198,14,145,234,135,141})) and config.Camera.FOVCircleKey == key then
return (_V9({46,193,22,133,36,138,251,136,132,13}))
end
if field ~= (_V9({6,225,50,192,4,140,224,135})) and config.NoRecoil.ToggleKey == key then
return (_V9({38,225,96,247,2,128,230,130,132}))
end
if field ~= (_V9({6,225,51,213,21,134,232,143})) and config.NoSpread.ToggleKey == key then
return (_V9({38,225,96,246,23,145,236,138,140}))
end
if field ~= (_V9({28,252,41,194,0,134,251,137,135,28})) and config.Triggerbot.ToggleKey == key then
return (_V9({60,252,41,194,0,134,251,137,135,28}))
end
if field ~= (_V9({11,226,41,198,12,151,249})) and config.Movement.ClickTPKey == key then
return (_V9({43,226,41,198,12,195,221,187}))
end
if field ~= (_V9({29,224,44,202,6,135})) and config.UI.UnloadKey == key then
return (_V9({61,224,44,202,6,135}))
end
return nil
end
local function makeKeybind(parent, labelText, getKey, setKey, conflictCheck)
local holder = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local box = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = box, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
newInstance((_V9({61,199,19,204,29,134,202,132,134,27,250,50,196,14,141,253})), { Parent = box, MinSize = Vector2.new(54, 22) })
wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
end
local function makeToggleWithKeybind(parent, text, getValue, onChange, keyLabel, getKey, setKey, conflictCheck)
local btn = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local check = newInstance((_V9({46,252,33,200,2})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = check, CornerRadius = UDim.new(0, 3) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = check, Color = COLORS.border, Thickness = 1 })
local label = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local box = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = box, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
newInstance((_V9({61,199,19,204,29,134,202,132,134,27,250,50,196,14,141,253})), { Parent = box, MinSize = Vector2.new(44, 20) })
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
local col = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
Parent = col,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return col
end
return column(1), column(2)
end
local function makeGroup(parent, title)
local wrapper = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = newInstance((_V9({46,252,33,200,2})), {
Parent = wrapper,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = box, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = box, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local veil = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = veil, CornerRadius = UDim.new(0, 6) })
local STRIPE, GAP = 0.72, 1
local hatch = newInstance((_V9({46,252,33,200,2})), {
Parent = veil,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = COLORS.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = hatch, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({61,199,7,215,6,135,224,142,134,28})), {
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
box:GetPropertyChangedSignal((_V9({41,236,51,202,11,150,253,142,187,1,244,37}))):Connect(syncWrapper)
syncWrapper()
local function setEnabled(enabled)
veil.Visible = not enabled
end
return box, setEnabled
end
local function makeSubTabHost(parent)
local bar = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local divider = newInstance((_V9({46,252,33,200,2})), {
Parent = parent,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = COLORS.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local area = newInstance((_V9({46,252,33,200,2})), {
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
local btn = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
local underline = newInstance((_V9({46,252,33,200,2})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = COLORS.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = newInstance((_V9({59,237,50,202,11,143,224,133,143,46,252,33,200,2})), {
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
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
newInstance((_V9({61,199,16,196,3,135,224,133,143})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
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
local left, right = makeColumns(host:add((_V9({41,231,45,199,8,151}))))
local aim = makeGroup(left, (_V9({41,231,45,199,8,151})))
makeToggleWithKeybind(aim, (_V9({45,224,33,199,11,134,237})), function()
return config.Camera.Enabled
end, function()
config.Camera.Enabled = not config.Camera.Enabled
end, (_V9({41,231,45,199,8,151,169,160,141,17})), function()
return config.Camera.ToggleKey
end, function(key)
config.Camera.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({9,231,45,199,8,151})))
end)
makeToggle(aim, (_V9({62,231,51,198,15,134,234,128})), function()
return config.Camera.WallCheck
end, function()
config.Camera.WallCheck = not config.Camera.WallCheck
end)
makeToggle(aim, (_V9({59,250,41,198,12,154,169,191,137,26,233,37,209})), function()
return config.Camera.StickyTarget
end, function()
config.Camera.StickyTarget = not config.Camera.StickyTarget
end)
makeToggle(aim, (_V9({60,239,50,194,2,151,169,169,135,28,253})), function()
return config.Camera.TargetBots
end, function()
config.Camera.TargetBots = not config.Camera.TargetBots
end)
makeToggle(aim, (_V9({60,235,33,200,71,160,225,142,139,3})), function()
return config.Camera.TeamCheck
end, function()
config.Camera.TeamCheck = not config.Camera.TeamCheck
end)
makeToggle(aim, (_V9({32,251,45,196,9,138,243,142})), function()
return config.Camera.Humanize
end, function()
config.Camera.Humanize = not config.Camera.Humanize
end)
makeToggleWithKeybind(aim, (_V9({46,193,22,133,36,138,251,136,132,13})), function()
return config.Camera.FOVCircle
end, function()
config.Camera.FOVCircle = not config.Camera.FOVCircle
end, (_V9({46,193,22,133,36,138,251,136,132,13,174,11,192,30})), function()
return config.Camera.FOVCircleKey
end, function(key)
config.Camera.FOVCircleKey = key
end, function(key)
return keyConflict(config, key, (_V9({14,225,54,198,14,145,234,135,141})))
end)
makeFillSlider(aim, (_V9({59,227,47,202,19,139,231,142,155,27})), 0.05, 1, function()
return config.Camera.Smoothness
end, function(val)
config.Camera.Smoothness = val
end, false)
makeFillSlider(aim, (_V9({56,252,37,193,14,128,253,130,135,6})), 0, 1, function()
return config.Camera.Prediction
end, function(val)
config.Camera.Prediction = val
end, false)
makeFillSlider(aim, (_V9({46,193,22})), 20, 800, function()
return config.Camera.FOV
end, function(val)
config.Camera.FOV = val
end, true, (_V9({24,246})), true)
makeFillSlider(aim, (_V9({37,239,56,133,35,138,250,159,137,6,237,37})), 100, 2000, function()
return config.Camera.MaxDistance
end, function(val)
config.Camera.MaxDistance = val
end, true, (_V9({5})), true)
local refreshWeightGate
local hitbox = makeGroup(right, (_V9({32,231,52,199,8,155})))
makeDropdownFull(hitbox, config.Camera.HitboxOptions, function()
return config.Camera.Hitbox
end, function(val)
config.Camera.Hitbox = val
if refreshWeightGate then
refreshWeightGate()
end
end)
local weights, setWeightsEnabled = makeGroup(right, (_V9({60,239,50,194,2,151,169,184,141,28,250,41,203,0,144})))
local function weightRow(name)
makeFillSlider(weights, name .. (_V9({72,217,37,204,0,139,253})), 0, 100, function()
return config.Camera.TargetWeights[name]
end, function(val)
config.Camera.TargetWeights[name] = val
end, true, (_V9({77})), true)
end
weightRow((_V9({32,235,33,193})))
weightRow((_V9({60,225,50,214,8})))
weightRow((_V9({41,252,45,214})))
weightRow((_V9({36,235,39,214})))
refreshWeightGate = function()
setWeightsEnabled(config.Camera.Hitbox == (_V9({58,239,46,193,8,142,169,195,191,13,231,39,205,19,134,237,194})))
end
refreshWeightGate()
table.insert(syncHandlers, refreshWeightGate)
local trigger = makeGroup(right, (_V9({60,252,41,194,0,134,251,137,135,28})))
makeToggleWithKeybind(trigger, (_V9({45,224,33,199,11,134,237})), function()
return config.Triggerbot.Enabled
end, function()
config.Triggerbot.Enabled = not config.Triggerbot.Enabled
end, (_V9({60,252,41,194,0,134,251,137,135,28,174,11,192,30})), function()
return config.Triggerbot.ToggleKey
end, function(key)
config.Triggerbot.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({28,252,41,194,0,134,251,137,135,28})))
end)
makeFillSlider(trigger, (_V9({37,231,46,133,35,134,229,138,145})), 0, 500, function()
return config.Triggerbot.MinDelay * 1000
end, function(val)
config.Triggerbot.MinDelay = val / 1000
end, true, (_V9({5,253})), true)
makeFillSlider(trigger, (_V9({37,239,56,133,35,134,229,138,145})), 0, 500, function()
return config.Triggerbot.MaxDelay * 1000
end, function(val)
config.Triggerbot.MaxDelay = val / 1000
end, true, (_V9({5,253})), true)
makeFillSlider(trigger, (_V9({37,239,56,133,35,138,250,159,137,6,237,37})), 100, 2000, function()
return config.Triggerbot.MaxDistance
end, function(val)
config.Triggerbot.MaxDistance = val
end, true, (_V9({5})), true)
makeToggle(trigger, (_V9({62,231,51,198,15,134,234,128})), function()
return config.Triggerbot.WallCheck
end, function()
config.Triggerbot.WallCheck = not config.Triggerbot.WallCheck
end)
local silent = makeGroup(right, (_V9({59,231,44,192,9,151,169,170,129,5})))
makeToggle(silent, (_V9({45,224,33,199,11,134,237})), function()
return config.SilentAim.Enabled
end, function()
config.SilentAim.Enabled = not config.SilentAim.Enabled
end)
local expander = makeGroup(right, (_V9({32,231,52,199,8,155,169,174,144,24,239,46,193,2,145})))
makeToggle(expander, (_V9({45,224,33,199,11,134,237})), function()
return config.Hitbox.Enabled
end, function()
config.Hitbox.Enabled = not config.Hitbox.Enabled
end)
makeFillSlider(expander, (_V9({59,231,58,192})), 1, 20, function()
return config.Hitbox.Size
end, function(val)
config.Hitbox.Size = val
end, true)
makeFillSlider(expander, (_V9({60,252,33,203,20,147,232,153,141,6,237,57})), 0, 1, function()
return config.Hitbox.Transparency
end, function(val)
config.Hitbox.Transparency = val
end, false)
left, right = makeColumns(host:add((_V9({63,235,33,213,8,141,250}))))
local recoil = makeGroup(left, (_V9({38,225,96,247,2,128,230,130,132})))
makeToggleWithKeybind(recoil, (_V9({45,224,33,199,11,134,237})), function()
return config.NoRecoil.Enabled
end, function()
config.NoRecoil.Enabled = not config.NoRecoil.Enabled
end, (_V9({38,225,96,247,2,128,230,130,132,72,197,37,220})), function()
return config.NoRecoil.ToggleKey
end, function(key)
config.NoRecoil.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({6,225,50,192,4,140,224,135})))
end)
makeToggle(recoil, (_V9({39,224,44,220,71,180,225,130,132,13,174,6,204,21,138,231,140})), function()
return config.NoRecoil.RequireMouseDown
end, function()
config.NoRecoil.RequireMouseDown = not config.NoRecoil.RequireMouseDown
end)
makeToggle(recoil, (_V9({41,226,44,202,16,195,200,130,133,72,202,47,210,9})), function()
return config.NoRecoil.AllowAim
end, function()
config.NoRecoil.AllowAim = not config.NoRecoil.AllowAim
end)
makeFillSlider(recoil, (_V9({59,250,50,192,9,132,253,131})), 0, 100, function()
return config.NoRecoil.Strength * 100
end, function(val)
config.NoRecoil.Strength = val / 100
end, true, (_V9({77})), true)
local spread = makeGroup(left, (_V9({38,225,96,246,23,145,236,138,140})))
makeToggleWithKeybind(spread, (_V9({45,224,33,199,11,134,237})), function()
return config.NoSpread.Enabled
end, function()
config.NoSpread.Enabled = not config.NoSpread.Enabled
end, (_V9({38,225,96,246,23,145,236,138,140,72,197,37,220})), function()
return config.NoSpread.ToggleKey
end, function(key)
config.NoSpread.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({6,225,51,213,21,134,232,143})))
end)
makeToggle(spread, (_V9({39,224,44,220,71,180,225,130,132,13,174,6,204,21,138,231,140})), function()
return config.NoSpread.RequireMouseDown
end, function()
config.NoSpread.RequireMouseDown = not config.NoSpread.RequireMouseDown
end)
makeFillSlider(spread, (_V9({59,250,50,192,9,132,253,131})), 0, 100, function()
return config.NoSpread.Strength * 100
end, function(val)
config.NoSpread.Strength = val / 100
end, true, (_V9({77})), true)
end
local function buildESPTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({45,221,16}))))
local esp = makeGroup(left, (_V9({45,221,16})))
makeToggleWithKeybind(esp, (_V9({45,224,33,199,11,134,237})), function()
return config.ESP.Enabled
end, function()
config.ESP.Enabled = not config.ESP.Enabled
end, (_V9({45,221,16,133,44,134,240})), function()
return config.ESP.ToggleKey
end, function(key)
config.ESP.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({13,253,48})))
end)
makeToggle(esp, (_V9({38,222,3,214})), function()
return config.ESP.NPCs
end, function()
config.ESP.NPCs = not config.ESP.NPCs
end)
makeFillSlider(esp, (_V9({37,239,56,133,35,138,250,159,137,6,237,37})), 100, 2000, function()
return config.ESP.MaxDistance
end, function(val)
config.ESP.MaxDistance = val
end, true, (_V9({5})), true)
local look = makeGroup(left, (_V9({41,254,48,192,6,145,232,133,139,13})))
makeToggle(look, (_V9({39,251,52,201,14,141,236,152})), function()
return config.ESP.Outlines
end, function()
config.ESP.Outlines = not config.ESP.Outlines
end)
makeToggle(look, (_V9({42,225,56,192,20})), function()
return config.ESP.Boxes
end, function()
config.ESP.Boxes = not config.ESP.Boxes
end)
makeToggle(look, (_V9({38,239,45,192,20})), function()
return config.ESP.Names
end, function()
config.ESP.Names = not config.ESP.Names
end)
makeToggle(look, (_V9({44,231,51,209,6,141,234,142})), function()
return config.ESP.Distance
end, function()
config.ESP.Distance = not config.ESP.Distance
end)
makeToggle(look, (_V9({32,235,33,201,19,139,169,169,137,26,253})), function()
return config.ESP.HealthBars
end, function()
config.ESP.HealthBars = not config.ESP.HealthBars
end)
makeToggle(look, (_V9({46,231,44,201,2,135})), function()
return config.ESP.Filled
end, function()
config.ESP.Filled = not config.ESP.Filled
end)
makeFillSlider(look, (_V9({39,251,52,201,14,141,236,203,167,24,239,35,204,19,154})), 0, 1, function()
return config.ESP.OutlineOpacity
end, function(val)
config.ESP.OutlineOpacity = val
end, false)
makeFillSlider(look, (_V9({46,231,44,201,71,172,249,138,139,1,250,57})), 0, 1, function()
return config.ESP.FillOpacity
end, function(val)
config.ESP.FillOpacity = val
end, false)
local drawing = makeGroup(right, (_V9({44,252,33,210,14,141,238,203,173,59,222})))
makeToggle(drawing, (_V9({42,225,56,192,20})), function()
return config.Drawing.Boxes
end, function()
config.Drawing.Boxes = not config.Drawing.Boxes
end)
makeToggle(drawing, (_V9({60,252,33,198,2,145,250})), function()
return config.Drawing.Tracers
end, function()
config.Drawing.Tracers = not config.Drawing.Tracers
end)
local world = makeGroup(right, (_V9({63,225,50,201,3})))
makeToggle(world, (_V9({46,251,44,201,5,145,224,140,128,28})), function()
return config.Visuals.Fullbright
end, function()
config.Visuals.Fullbright = not config.Visuals.Fullbright
end)
makeToggle(world, (_V9({38,225,96,227,8,132})), function()
return config.Visuals.NoFog
end, function()
config.Visuals.NoFog = not config.Visuals.NoFog
end)
left, right = makeColumns(host:add((_V9({43,225,44,202,21,144}))))
makeColorPicker(left, (_V9({39,251,52,201,14,141,236,203,171,7,226,47,215})), function()
return config.ESP.OutlineColor
end, function(c)
config.ESP.OutlineColor = c
end)
makeColorPicker(right, (_V9({46,231,44,201,71,160,230,135,135,26})), function()
return config.ESP.FillColor
end, function(c)
config.ESP.FillColor = c
end)
makeColorPicker(left, (_V9({42,225,56,133,36,140,229,132,154})), function()
return config.Drawing.BoxColor
end, function(c)
config.Drawing.BoxColor = c
end)
makeColorPicker(right, (_V9({60,252,33,198,2,145,169,168,135,4,225,50})), function()
return config.Drawing.TracerColor
end, function(c)
config.Drawing.TracerColor = c
end)
end
local function buildMovementTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({37,225,54,192,10,134,231,159}))))
local fly = makeGroup(left, (_V9({46,226,57})))
makeToggle(fly, (_V9({45,224,33,199,11,134,237})), function()
return config.Movement.FlyEnabled
end, function()
config.Movement.FlyEnabled = not config.Movement.FlyEnabled
end)
makeFillSlider(fly, (_V9({46,226,57,133,52,147,236,142,140})), 10, 200, function()
return config.Movement.FlySpeed
end, function(val)
config.Movement.FlySpeed = val
end, true)
local speed = makeGroup(left, (_V9({59,254,37,192,3})))
makeToggle(speed, (_V9({45,224,33,199,11,134,237})), function()
return config.Movement.SpeedEnabled
end, function()
config.Movement.SpeedEnabled = not config.Movement.SpeedEnabled
end)
makeFillSlider(speed, (_V9({59,254,37,192,3})), 16, 100, function()
return config.Movement.Speed
end, function(val)
config.Movement.Speed = val
end, true)
local misc = makeGroup(left, (_V9({39,250,40,192,21})))
makeToggle(misc, (_V9({38,225,35,201,14,147})), function()
return config.Movement.NoclipEnabled
end, function()
config.Movement.NoclipEnabled = not config.Movement.NoclipEnabled
end)
makeToggle(misc, (_V9({33,224,38,204,9,138,253,142,200,34,251,45,213})), function()
return config.Movement.InfJumpEnabled
end, function()
config.Movement.InfJumpEnabled = not config.Movement.InfJumpEnabled
end)
local tp = makeGroup(right, (_V9({43,226,41,198,12,195,221,187})))
makeToggle(tp, (_V9({45,224,33,199,11,134,237})), function()
return config.Movement.ClickTPEnabled
end, function()
config.Movement.ClickTPEnabled = not config.Movement.ClickTPEnabled
end)
makeKeybind(tp, (_V9({37,225,36,204,1,138,236,153,200,35,235,57})), function()
return config.Movement.ClickTPKey
end, function(key)
config.Movement.ClickTPKey = key
end, function(key)
return keyConflict(config, key, (_V9({11,226,41,198,12,151,249})))
end)
end
local function buildSettingsTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({47,235,46,192,21,130,229}))))
local iface = makeGroup(left, (_V9({33,224,52,192,21,133,232,136,141})))
makeFillSlider(iface, (_V9({61,199,96,246,4,130,229,142})), 0.8, 1.5, function()
return config.UI.Scale
end, function(val)
config.UI.Scale = val
if windowScale then
windowScale.Scale = val
end
end, false)
makeToggle(iface, (_V9({35,235,57,199,14,141,237,203,184,9,224,37,201})), function()
return config.UI.KeybindPanel
end, function()
config.UI.KeybindPanel = not config.UI.KeybindPanel
if keybindPanel then
keybindPanel.Visible = config.UI.KeybindPanel
end
end)
makeToggle(iface, (_V9({60,239,50,194,2,151,169,175,129,27,254,44,196,30})), function()
return config.UI.TargetDisplay
end, function()
config.UI.TargetDisplay = not config.UI.TargetDisplay
targetDisplayOn = config.UI.TargetDisplay
if not targetDisplayOn and targetPanel then
targetPanel.Visible = false
end
end)
makeToggle(iface, (_V9({46,222,19,133,36,140,252,133,156,13,252})), function()
return config.UI.FPSCounter
end, function()
config.UI.FPSCounter = not config.UI.FPSCounter
if fpsPanel then
fpsPanel.Visible = config.UI.FPSCounter
end
end)
makeToggle(iface, (_V9({63,239,52,192,21,142,232,153,131})), function()
return config.UI.Watermark
end, function()
config.UI.Watermark = not config.UI.Watermark
if watermark then
watermark.Visible = config.UI.Watermark
end
end)
local account = makeGroup(right, (_V9({41,237,35,202,18,141,253})))
makeLabel(account, (_V9({61,253,37,215,9,130,228,142})), LocalPlayer and LocalPlayer.Name or (_V9({138,14,212})))
makeLabel(account, (_V9({44,231,51,213,11,130,240,203,166,9,227,37})), LocalPlayer and LocalPlayer.DisplayName or (_V9({138,14,212})))
makeLabel(account, (_V9({61,253,37,215,71,170,205})), LocalPlayer and tostring(LocalPlayer.UserId) or (_V9({138,14,212})))
makeToggle(account, (_V9({41,224,52,204,74,162,207,160})), function()
return config.Utility.AntiAFK
end, function()
config.Utility.AntiAFK = not config.Utility.AntiAFK
end)
makeButton(account, (_V9({59,235,50,211,2,145,169,163,135,24})), function()
Utility:ServerHop()
end)
makeButton(account, (_V9({58,235,42,202,14,141,169,184,141,26,248,37,215})), function()
Utility:Rejoin()
end)
left, right = makeColumns(host:add((_V9({43,225,46,195,14,132,250}))))
local cfg = makeGroup(left, (_V9({43,225,46,195,14,132,250})))
if not ConfigManager.isSupported() then
makeLabel(cfg, (_V9({59,250,33,209,18,144})), (_V9({61,224,51,208,23,147,230,153,156,13,234})))
return
end
local nameBox = makeTextBox(cfg, (_V9({11,225,46,195,14,132,169,133,137,5,235,162,37,193})))
local listHolder = newInstance((_V9({46,252,33,200,2})), {
Parent = cfg,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
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
if not child:IsA((_V9({61,199,12,204,20,151,197,138,145,7,251,52}))) then
child:Destroy()
end
end
local names = ConfigManager.list()
if #names == 0 then
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
Parent = listHolder,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({6,225,96,214,6,149,236,143,200,11,225,46,195,14,132,250})),
})
return
end
for i, name in ipairs(names) do
local selected = (nameBox.Text == name)
local row = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
Text = (_V9({72,174})) .. name,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = row, CornerRadius = UDim.new(0, 4) })
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
makeButton(cfg, (_V9({59,239,54,192})), function()
local ok, res = ConfigManager.save(nameBox.Text, config)
if ok then
UI:Notify((_V9({59,239,54,192,3,195,234,132,134,14,231,39,133,64})) .. res .. (_V9({79})), 2)
refreshList()
else
UI:Notify(tostring(res), 3)
end
end)
makeButton(cfg, (_V9({36,225,33,193})), function()
local ok, res = ConfigManager.load(nameBox.Text, config)
if ok then
if windowScale then
windowScale.Scale = config.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({36,225,33,193,2,135,169,136,135,6,232,41,194,71,196})) .. res .. (_V9({79})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
makeButton(cfg, (_V9({44,235,44,192,19,134})), function()
local ok, res = ConfigManager.delete(nameBox.Text)
if ok then
UI:Notify((_V9({44,235,44,192,19,134,237,203,139,7,224,38,204,0,195,174})) .. res .. (_V9({79})), 2)
nameBox.Text = (_V9({}))
refreshList()
else
UI:Notify(tostring(res), 3)
end
end, COLORS.danger)
refreshList()
end
local function buildTargetPanel(config)
targetPanel = newInstance((_V9({46,252,33,200,2})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = targetPanel, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = targetPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = targetPanel,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
Parent = targetPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local dot = newInstance((_V9({46,252,33,200,2})), {
Parent = targetPanel,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
fpsPanel = newInstance((_V9({46,252,33,200,2})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = fpsPanel, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = fpsPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = fpsPanel,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
Parent = fpsPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local dot = newInstance((_V9({46,252,33,200,2})), {
Parent = fpsPanel,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
fpsLabel = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
Text = (_V9({69,163,96,195,23,144})),
})
table.insert(syncHandlers, function()
if fpsPanel then
fpsPanel.Visible = config.UI.FPSCounter
end
end)
fpsPanel.Visible = config.UI.FPSCounter
end
local function buildWatermark(config)
watermark = newInstance((_V9({33,227,33,194,2,175,232,137,141,4})), {
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
keybindPanel = newInstance((_V9({46,252,33,200,2})), {
Parent = gui,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = COLORS.bg,
BorderSizePixel = 0,
Visible = false,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = keybindPanel, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = keybindPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), {
Parent = keybindPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = keybindPanel,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = newInstance((_V9({46,252,33,200,2})), {
Parent = keybindPanel,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({35,235,57,199,14,141,237,152})),
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
makeKeybind(keybindPanel, (_V9({37,235,46,208})), function()
return config.UI.MenuKey
end, function(key)
config.UI.MenuKey = key
end, function(key)
return keyConflict(config, key, (_V9({5,235,46,208})))
end)
makeKeybind(keybindPanel, (_V9({41,231,45,199,8,151})), function()
return config.Camera.ToggleKey
end, function(key)
config.Camera.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({9,231,45,199,8,151})))
end)
makeKeybind(keybindPanel, (_V9({45,221,16})), function()
return config.ESP.ToggleKey
end, function(key)
config.ESP.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({13,253,48})))
end)
makeKeybind(keybindPanel, (_V9({46,193,22,133,36,138,251,136,132,13})), function()
return config.Camera.FOVCircleKey
end, function(key)
config.Camera.FOVCircleKey = key
end, function(key)
return keyConflict(config, key, (_V9({14,225,54,198,14,145,234,135,141})))
end)
makeKeybind(keybindPanel, (_V9({38,225,96,247,2,128,230,130,132})), function()
return config.NoRecoil.ToggleKey
end, function(key)
config.NoRecoil.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({6,225,50,192,4,140,224,135})))
end)
makeKeybind(keybindPanel, (_V9({38,225,96,246,23,145,236,138,140})), function()
return config.NoSpread.ToggleKey
end, function(key)
config.NoSpread.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({6,225,51,213,21,134,232,143})))
end)
makeKeybind(keybindPanel, (_V9({60,252,41,194,0,134,251,137,135,28})), function()
return config.Triggerbot.ToggleKey
end, function(key)
config.Triggerbot.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({28,252,41,194,0,134,251,137,135,28})))
end)
makeKeybind(keybindPanel, (_V9({61,224,44,202,6,135})), function()
return config.UI.UnloadKey
end, function(key)
config.UI.UnloadKey = key
end, function(key)
return keyConflict(config, key, (_V9({29,224,44,202,6,135})))
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
gui = newInstance((_V9({59,237,50,192,2,141,206,158,129})), {
Name = (_V9({62,239,46,204,19,154,206,142,134,13,252,33,201,50,170})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local ok = pcall(function()
gui.Parent = getGuiParent()
end)
if not ok or not gui.Parent then
gui.Parent = LocalPlayer:WaitForChild((_V9({56,226,33,220,2,145,206,158,129})))
end
mainWindow = newInstance((_V9({43,239,46,211,6,144,206,153,135,29,254})), {
Parent = gui,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = COLORS.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
windowScale = newInstance((_V9({61,199,19,198,6,143,236})), { Parent = mainWindow, Scale = config.UI.Scale })
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
local titleBar = newInstance((_V9({46,252,33,200,2})), {
Parent = mainWindow,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = titleBar, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({46,252,33,200,2})), {
Parent = titleBar,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
local dot = newInstance((_V9({46,252,33,200,2})), {
Parent = titleBar,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
Parent = titleBar,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({62,239,46,204,19,154,181,141,135,6,250,96,198,8,143,230,153,213,74,173,120,145,84,166,203,174,202,86,160,36,192,17,223,166,141,135,6,250,126,133,32,134,231,142,154,9,226}))
.. (_V9({84,232,47,203,19,195,234,132,132,7,252,125,135,68,219,200,220,171,41,190,98,155,71,195,169,41,95,72,174,96,211,87,223,166,141,135,6,250,126})),
ZIndex = 2,
})
newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
local sidebar = newInstance((_V9({46,252,33,200,2})), {
Parent = mainWindow,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = sidebar, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = sidebar, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = sidebar,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local tabList = newInstance((_V9({46,252,33,200,2})), {
Parent = sidebar,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,12,204,20,151,197,138,145,7,251,52})), { Parent = tabList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local unloadBtn = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
Text = (_V9({61,224,44,202,6,135})),
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = unloadBtn, CornerRadius = UDim.new(0, 6) })
local unloadStroke = newInstance((_V9({61,199,19,209,21,140,226,142})), {
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
local content = newInstance((_V9({46,252,33,200,2})), {
Parent = mainWindow,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({61,199,16,196,3,135,224,133,143})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local tabs = { (_V9({43,225,45,199,6,151})), (_V9({62,231,51,208,6,143})), (_V9({37,225,54,192,10,134,231,159})), (_V9({59,235,52,209,14,141,238,152})) }
local tabFrames = {}
for i, tabName in ipairs(tabs) do
local isActive = currentTab == tabName
local tabBtn = newInstance((_V9({60,235,56,209,37,150,253,159,135,6})), {
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
Text = (_V9({72,174,96,133})) .. tabName,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = tabBtn, CornerRadius = UDim.new(0, 6) })
local stripe = newInstance((_V9({46,252,33,200,2})), {
Parent = tabBtn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
Visible = isActive,
ZIndex = 2,
})
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local tabFrame = newInstance((_V9({46,252,33,200,2})), {
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
buildCameraTab(tabFrames[(_V9({43,225,45,199,6,151}))].frame, config)
buildESPTab(tabFrames[(_V9({62,231,51,208,6,143}))].frame, config)
buildMovementTab(tabFrames[(_V9({37,225,54,192,10,134,231,159}))].frame, config)
buildSettingsTab(tabFrames[(_V9({59,235,52,209,14,141,238,152}))].frame, config)
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
if name and name ~= (_V9({})) and name ~= (_V9({38,225,46,192})) then
shown, colour = name, (_V9({75,182,116,150,34,161,204}))
else
shown, colour = (_V9({61,224,11,203,8,148,231})), (_V9({75,182,1,146,36,162,185}))
end
local text = (_V9({60,239,50,194,2,151,179,203,212,14,225,46,209,71,128,230,135,135,26,179,98})) .. colour .. (_V9({74,176})) .. shown .. (_V9({84,161,38,202,9,151,183}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(fps)
if not fpsLabel or not fpsPanel or not fpsPanel.Visible then
return
end
local text = string.format((_V9({84,232,47,203,19,195,234,132,132,7,252,125,135,68,219,189,216,173,42,203,98,155,66,135,181,196,142,7,224,52,155,71,133,249,152})), fps or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(id)
if not watermark then
return
end
local digits = tostring(id or (_V9({}))):match((_V9({77,234,107})))
watermark.Image = digits and ((_V9({26,236,56,196,20,144,236,159,129,12,180,111,138})) .. digits) or (_V9({}))
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
local toast = newInstance((_V9({60,235,56,209,43,130,235,142,132})), {
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
newInstance((_V9({61,199,3,202,21,141,236,153})), { Parent = toast, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({61,199,19,209,21,140,226,142})), { Parent = toast, Color = COLORS.accent, Thickness = 1, Transparency = 0.3 })
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
end
local Movement = {}
do
local BASE_WALKSPEED = 16
local JUMP_VELOCITY = 50
local mv_jumpConnection
local mv_clickConnection
local function mv_character()
local character = LocalPlayer.Character
local root = character and character:FindFirstChild((_V9({32,251,45,196,9,140,224,143,186,7,225,52,245,6,145,253})))
local humanoid = character and character:FindFirstChildOfClass((_V9({32,251,45,196,9,140,224,143})))
if not (character and root and humanoid and humanoid.Health > 0) then
return nil
end
return character, root, humanoid
end
local function mv_flyDirection(cam)
local look = cam.CFrame.LookVector
local flat = Vector3.new(look.X, 0, look.Z)
if flat.Magnitude < 0.001 then
flat = Vector3.new(0, 0, -1)
else
flat = flat.Unit
end
local right = cam.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local move = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
move = move + flat
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
move = move - flat
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
move = move + right
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
move = move - right
end
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
move = move + Vector3.yAxis
end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
move = move - Vector3.yAxis
end
if move.Magnitude > 0 then
return move.Unit
end
return nil
end
function Movement:Update(dt, config)
local character, root, humanoid = mv_character()
if config.NoclipEnabled and character then
for _, part in ipairs(character:GetDescendants()) do
if part:IsA((_V9({42,239,51,192,55,130,251,159}))) then
part.CanCollide = false
end
end
end
if not root then
return
end
if config.FlyEnabled then
local cam = Workspace.CurrentCamera
if cam then
root.AssemblyLinearVelocity = Vector3.zero
if not UI:IsCapturingKey() then
local dir = mv_flyDirection(cam)
if dir then
root.CFrame = root.CFrame + dir * (config.FlySpeed or 50) * dt
end
end
end
end
if config.SpeedEnabled then
local surplus = (config.Speed or BASE_WALKSPEED) - BASE_WALKSPEED
if surplus > 0 and humanoid.MoveDirection.Magnitude > 0 then
root.CFrame = root.CFrame + humanoid.MoveDirection * surplus * dt
end
end
end
local function mv_onJumpRequest(config)
if not config.InfJumpEnabled then
return
end
local _, root = mv_character()
if root then
local velocity = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(velocity.X, JUMP_VELOCITY, velocity.Z)
end
end
local function mv_onInput(config, input, gameProcessed)
if gameProcessed or UI:IsCapturingKey() then
return
end
if not config.ClickTPEnabled then
return
end
if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not UserInputService:IsKeyDown(config.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _, root = mv_character()
local mouse = LocalPlayer:GetMouse()
if root and mouse and mouse.Hit then
root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
end
end
function Movement:Init(config)
if not mv_jumpConnection then
mv_jumpConnection = UserInputService.JumpRequest:Connect(function()
mv_onJumpRequest(config)
end)
end
if not mv_clickConnection then
mv_clickConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
mv_onInput(config, input, gameProcessed)
end)
end
end
function Movement:Cleanup()
if mv_jumpConnection then
mv_jumpConnection:Disconnect()
mv_jumpConnection = nil
end
if mv_clickConnection then
mv_clickConnection:Disconnect()
mv_clickConnection = nil
end
end
end
VanityGeneral = {}
VanityGeneral.Version = (_V9({88}))
VanityGeneral.Config = Configuration
VanityGeneral.StringObfuscation = StringObfuscation
VanityGeneral.DebuggerDetection = DebuggerDetection
VanityGeneral.ProtectedSecrets = ProtectedSecrets
VanityGeneral.Secrets = ProtectedSecrets.createProtectedManager()
do
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
if type(fn) == (_V9({14,251,46,198,19,138,230,133})) then
return fn
end
end
return nil
end
local function resolveWebhookUrl()
if webhookViaManager then
local url = VanityGeneral.Secrets:get((_V9({31,235,34,205,8,140,226,180,157,26,226})))
if url then
return url
end
end
if #WEBHOOK_CIPHER > 0 then
if DebuggerDetection.IsBeingDebugged() then
DebuggerDetection.HandleTamperingAttempt((_V9({31,235,34,205,8,140,226,180,154,13,248,37,196,11,188,254,131,129,4,235,31,193,2,129,252,140,143,13,234})), (_V9({31,235,34,205,8,140,226})))
return nil
end
return StringObfuscation.decrypt(WEBHOOK_CIPHER, WEBHOOK_LEVEL)
end
return nil
end
function VanityGeneral.SetWebhook(url, level)
VanityGeneral.Secrets:clear((_V9({31,235,34,205,8,140,226,180,157,26,226})))
VanityGeneral.Secrets:register((_V9({31,235,34,205,8,140,226,180,157,26,226})), url, level or WEBHOOK_LEVEL)
webhookViaManager = true
return true
end
function VanityGeneral.EncryptWebhook(url, level)
level = level or WEBHOOK_LEVEL
local bytes = StringObfuscation.encrypt(url, level)
print(string.format((_V9({69,163,96,245,6,144,253,142,200,28,230,37,133,19,148,230,203,132,1,224,37,214,71,129,236,135,135,31,174,41,203,19,140,169,159,128,13,174,19,224,36,182,219,174,200,63,203,2,237,40,172,194,203,139,7,224,38,204,0,195,161,135,141,30,235,44,133,66,135,160,209})), level))
print(string.format((_V9({4,225,35,196,11,195,222,174,170,32,193,15,238,56,175,204,189,173,36,174,125,133,66,135})), level))
print((_V9({4,225,35,196,11,195,222,174,170,32,193,15,238,56,160,192,187,160,45,220,96,152,71,152,169})) .. table.concat(bytes, (_V9({68,174}))) .. (_V9({72,243})))
return bytes
end
function VanityGeneral.HasWebhook()
return webhookViaManager or #WEBHOOK_CIPHER > 0
end
function VanityGeneral.SendWebhook(content, opts)
opts = opts or {}
local url = resolveWebhookUrl()
if not url then
return false, (_V9({6,225,31,210,2,129,225,132,135,3,209,47,215,56,129,229,132,139,3,235,36}))
end
local req = resolveHttpRequest()
if not req then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,166,7,174,8,241,51,179,169,153,141,25,251,37,214,19,195,239,158,134,11,250,41,202,9,195,232,157,137,1,226,33,199,11,134,169,130,134,72,250,40,204,20,195,236,147,141,11,251,52,202,21})))
return false, (_V9({6,225,31,205,19,151,249}))
end
local payload = {
username = opts.username or (_V9({62,239,46,204,19,154,164,172,141,6,235,50,196,11})),
avatar_url = opts.avatar_url,
content = content,
embeds = opts.embeds,
}
local ok, err = pcall(function()
local body = game:GetService((_V9({32,250,52,213,52,134,251,157,129,11,235}))):JSONEncode(payload)
return req({
Url = url,
Method = (_V9({56,193,19,241})),
Headers = { [(_V9({43,225,46,209,2,141,253,198,188,17,254,37}))] = (_V9({9,254,48,201,14,128,232,159,129,7,224,111,207,20,140,231})) },
Body = body,
})
end)
url = nil
if not ok then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,191,13,236,40,202,8,136,169,152,141,6,234,96,195,6,138,229,142,140,82})), err)
return false, err
end
return true
end
function VanityGeneral.SendLoadedEmbed(isDebugged)
local placeName = (_V9({87}))
pcall(function()
placeName = game:GetService((_V9({37,239,50,206,2,151,249,135,137,11,235,19,192,21,149,224,136,141}))):GetProductInfo(game.PlaceId).Name
end)
return VanityGeneral.SendWebhook(nil, {
embeds = {
{
title = (_V9({62,239,46,204,19,154,167,143,141,30,174,7,192,9,134,251,138,132,72,226,47,196,3,134,237})),
color = 8666558,
fields = {
{ name = (_V9({56,226,33,220,2,145})), value = (_V9({8})) .. (LocalPlayer and LocalPlayer.Name or (_V9({87}))) .. (_V9({8})), inline = true },
{ name = (_V9({62,235,50,214,14,140,231})), value = (_V9({8,248})) .. tostring(VanityGeneral.Version) .. (_V9({8})), inline = true },
{ name = (_V9({47,239,45,192})), value = placeName, inline = false },
{ name = (_V9({56,226,33,198,2,170,237})), value = (_V9({8})) .. tostring(game.PlaceId) .. (_V9({8})), inline = true },
{ name = (_V9({44,235,34,208,0,132,236,143})), value = (_V9({8})) .. tostring(isDebugged) .. (_V9({8})), inline = true },
},
footer = { text = os.date((_V9({77,215,109,128,10,206,172,143,200,77,198,122,128,42,217,172,184}))) },
},
},
})
end
local running = false
local connections = {}
local aimbotSteering = false
local RECOIL_BIND = (_V9({62,239,46,204,19,154,206,142,134,13,252,33,201,53,134,234,132,129,4}))
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
warn(string.format((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,205,27,174,38,196,14,143,236,143,200,64,246,101,193,78,217,169,206,155})), name, st.failures, tostring(res)))
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
function VanityGeneral.ServerHop()
return Utility:ServerHop()
end
function VanityGeneral.Rejoin()
return Utility:Rejoin()
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
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,172,13,236,53,194,71,134,231,157,129,26,225,46,200,2,141,253,203,140,13,250,37,198,19,134,237,203,137,28,174,51,209,6,145,253,158,152,72,108,192,49,71,147,251,132,156,13,237,52,192,3,195,250,142,139,26,235,52,214,71,148,224,135,132,72,252,37,195,18,144,236,203,156,7,174,50,192,17,134,232,135,200,29,224,52,204,11,195,232,135,132,7,249,31,204,9,188,250,159,157,12,231,47,133,14,144,169,152,141,28,160})))
end
running = true
local ok, err = pcall(function()
ESP:Init()
UI:Init(Configuration)
Movement:Init(Configuration.Movement)
SilentAim:Init(Configuration.SilentAim)
Utility:Init(Configuration.Utility)
table.insert(connections, Players.PlayerAdded:Connect(function(player)
guarded((_V9({56,226,33,220,2,145,200,143,140,13,234})), ESP.OnPlayerAdded, ESP, player)
end))
table.insert(connections, Players.PlayerRemoving:Connect(function(player)
guarded((_V9({56,226,33,220,2,145,219,142,133,7,248,41,203,0})), ESP.OnPlayerRemoving, ESP, player)
end))
table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed or UI:IsCapturingKey() then
return
end
guarded((_V9({35,235,57,199,14,141,237,152})), function()
local key = input.KeyCode
if key == Configuration.UI.MenuKey then
UI:Toggle()
elseif key == Configuration.UI.UnloadKey then
VanityGeneral.Stop()
else
local toggles = {
{ Configuration.Camera, (_V9({45,224,33,199,11,134,237})), Configuration.Camera.ToggleKey },
{ Configuration.ESP, (_V9({45,224,33,199,11,134,237})), Configuration.ESP.ToggleKey },
{ Configuration.Camera, (_V9({46,193,22,230,14,145,234,135,141})), Configuration.Camera.FOVCircleKey },
{ Configuration.NoRecoil, (_V9({45,224,33,199,11,134,237})), Configuration.NoRecoil.ToggleKey },
{ Configuration.NoSpread, (_V9({45,224,33,199,11,134,237})), Configuration.NoSpread.ToggleKey },
{ Configuration.Triggerbot, (_V9({45,224,33,199,11,134,237})), Configuration.Triggerbot.ToggleKey },
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
guarded((_V9({45,221,16})), ESP.Update, ESP, Configuration.ESP)
local okAim, target = guarded((_V9({41,231,45,199,8,151})), CameraDirector.Update, CameraDirector, Configuration.Camera, Configuration.Debug)
if not okAim then
target = nil
end
if Configuration.UI.TargetDisplay then
guarded((_V9({60,239,50,194,2,151,169,143,129,27,254,44,196,30})), function()
local looking = CameraDirector:GetLookTarget(Configuration.ESP, Configuration.Camera)
UI:SetCurrentTarget(looking and looking.Name or nil)
end)
end
aimbotSteering = Configuration.Camera.Enabled and target ~= nil
guarded((_V9({38,225,19,213,21,134,232,143})), NoSpread.Update, NoSpread, Configuration.NoSpread)
guarded((_V9({60,252,41,194,0,134,251,137,135,28})), Triggerbot.Update, Triggerbot, Configuration.Triggerbot, Configuration.Camera)
guarded((_V9({37,225,54,192,10,134,231,159})), Movement.Update, Movement, dt, Configuration.Movement)
guarded((_V9({32,231,52,199,8,155})), HitboxExpander.Update, HitboxExpander, Configuration.Hitbox, Configuration.Camera)
guarded((_V9({44,252,33,210,14,141,238,203,173,59,222})), DrawingESP.Update, DrawingESP, Configuration.Drawing, Configuration.Camera)
guarded((_V9({62,231,51,208,6,143,250})), Visuals.Update, Visuals, Configuration.Visuals)
fpsAccum = fpsAccum + dt
fpsFrames = fpsFrames + 1
if fpsAccum >= 0.25 then
local fps = math.floor(fpsFrames / fpsAccum + 0.5)
fpsAccum, fpsFrames = 0, 0
if Configuration.UI.FPSCounter then
guarded((_V9({46,222,19,133,4,140,252,133,156,13,252})), UI.UpdateFPS, UI, fps)
end
end
end))
pcall(function()
RunService:UnbindFromRenderStep(RECOIL_BIND)
end)
pcall(function()
RunService:BindToRenderStep(RECOIL_BIND, Enum.RenderPriority.Camera.Value + 1, function()
guarded((_V9({38,225,18,192,4,140,224,135})), NoRecoil.Update, NoRecoil, Configuration.NoRecoil, aimbotSteering)
end)
end)
end)
if not ok then
warn((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,174,9,231,44,192,3,195,253,132,200,27,250,33,215,19,217})), err)
VanityGeneral.Stop()
return VanityGeneral
end
UI:Notify(string.format((_V9({62,239,46,204,19,154,164,172,141,6,235,50,196,11,195,229,132,137,12,235,36,133,71,1,9,73,200,72,222,50,192,20,144,169,206,155})), Configuration.UI.MenuKey.Name), 4)
print(string.format((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,186,29,224,46,204,9,132,169,195,158,77,253,105})), VanityGeneral.Version))
print(string.format((_V9({72,174,162,37,197,195,218,159,154,1,224,39,234,5,133,252,152,139,9,250,41,202,9,195,255,206,155,72,166,33,198,19,138,255,142,193})), StringObfuscation.VERSION))
print(string.format((_V9({72,174,162,37,197,195,205,142,138,29,233,39,192,21,167,236,159,141,11,250,41,202,9,195,255,217,198,88,174,104,200,8,141,224,159,135,26,231,46,194,93,195,232,136,156,1,248,37,137,71,135,236,137,157,15,233,37,193,93,195,172,152,193})), tostring(securityState.is_debugged)))
print(string.format((_V9({72,174,162,37,197,195,217,153,135,28,235,35,209,2,135,218,142,139,26,235,52,214,71,149,172,152,200,64,216,33,203,14,151,240,172,141,6,235,50,196,11,205,218,142,139,26,235,52,214,71,132,232,159,141,12,174,34,220,71,135,236,137,157,15,233,37,215,71,135,236,159,141,11,250,41,202,9,202})), ProtectedSecrets.VERSION))
print(string.format((_V9({37,235,46,208,93,195,172,152,200,72,242,96,133,36,130,228,142,154,9,180,96,128,20,195,169,151,200,72,219,46,201,8,130,237,209,200,77,253})),
Configuration.UI.MenuKey.Name,
Configuration.Camera.ToggleKey.Name,
Configuration.UI.UnloadKey.Name))
if not VanityGeneral.HasWebhook() and type(WEBHOOK_URL) == (_V9({27,250,50,204,9,132})) and WEBHOOK_URL ~= (_V9({})) then
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
Movement:Cleanup()
end)
pcall(function()
HitboxExpander:Cleanup()
end)
pcall(function()
DrawingESP:Cleanup()
end)
pcall(function()
Visuals:Cleanup()
end)
pcall(function()
Utility:Cleanup()
end)
pcall(function()
NoSpread:Cleanup()
end)
pcall(function()
ProtectedSecrets.shutdown()
end)
NoRecoil:Reset()
table.clear(guardState)
print((_V9({51,216,33,203,14,151,240,198,175,13,224,37,215,6,143,212,203,187,28,225,48,213,2,135})))
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
end
VanityGeneral.start = VanityGeneral.Start
VanityGeneral.stop = VanityGeneral.Stop
VanityGeneral.toggle = VanityGeneral.Toggle
if getgenv then
local previous = getgenv().VanityGeneral
if previous and previous ~= VanityGeneral and type(previous.Stop) == (_V9({14,251,46,198,19,138,230,133})) then
pcall(previous.Stop)
end
getgenv().VanityGeneral = VanityGeneral
end
pcall(function()
VanityGeneral.Start()
end)
return VanityGeneral
