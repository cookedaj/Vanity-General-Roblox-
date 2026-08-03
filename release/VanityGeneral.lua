local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({147,221,247,177,179,116,186,205,118})
local Players = game:GetService((_V9({195,177,150,200,214,6,201})))
local RunService = game:GetService((_V9({193,168,153,226,214,6,204,164,21,246})))
local UserInputService = game:GetService((_V9({198,174,146,195,250,26,202,184,2,192,184,133,199,218,23,223})))
local TweenService = game:GetService((_V9({199,170,146,212,221,39,223,191,0,250,190,146})))
local Workspace = game:GetService((_V9({196,178,133,218,192,4,219,174,19})))
local LocalPlayer = Players.LocalPlayer
local VanityGeneral
local StringObfuscation = {
VERSION = (_V9({161,243,199})),
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
name = name or ((_V9({224,184,148,195,214,0,229})) .. tostring({}):match((_V9({163,165,210,201,152}))))
local encrypted = StringObfuscation.encrypt(str, level)
local hash = _simpleHash(str)
_addAuditEntry((_V9({224,184,148,195,214,0,229,174,4,246,188,131,212,215})), name, { level = level })
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
return (_V9({200,142,178,242,225,49,238,247})) .. name .. (_V9({206}))
end,
__index = function(self, key)
if key == (_V9({229,188,155,196,214})) then
if self._cleared then
warn((_V9({200,142,131,195,218,26,221,130,20,245,168,132,210,210,0,211,162,24,206,253,164,212,208,6,223,185,86,180})) .. self._name .. (_V9({180,253,128,208,192,84,217,161,19,242,175,146,213,147,21,212,169,86,240,188,153,223,220,0,154,175,19,179,188,148,210,214,7,201,168,18})))
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
_addAuditEntry((_V9({224,184,148,195,214,0,229,172,21,240,184,132,194,214,16})), self._name, {
access_num = self._access_count,
access_time_ms = access_time * 1000,
})
return self._decrypted
elseif key == (_V9({242,190,148,212,192,7,229,174,25,230,179,131})) then
return self._access_count
elseif key == (_V9({255,188,132,197,236,21,217,174,19,224,174})) then
return self._last_access
elseif key == (_V9({253,188,154,212})) then
return self._name
elseif key == (_V9({255,184,129,212,223})) then
return self._level
elseif key == (_V9({240,175,146,208,199,29,213,163,41,231,180,154,212})) then
return self._creation_time
elseif key == (_V9({242,186,146,238,192,17,217,162,24,247,174})) then
return os.time() - self._creation_time
elseif key == (_V9({250,174,168,210,223,17,219,191,19,247})) then
return self._cleared
end
return rawget(self, key)
end,
__metatable = (_V9({200,141,165,254,231,49,249,153,51,215,128}))
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
if type(secret) == (_V9({231,188,149,221,214})) and secret._encrypted then
secret._decrypted = nil
secret._cleared = true
_addAuditEntry((_V9({224,184,148,195,214,0,229,174,26,246,188,133,212,215})), secret._name, {})
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
if type(secret) == (_V9({231,188,149,221,214})) and secret._encrypted then
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
warn((_V9({200,142,146,210,193,17,206,128,23,253,188,144,212,193,41,154,158,19,240,175,146,197,147,83})) .. name .. (_V9({180,253,150,221,193,17,219,169,15,179,175,146,214,218,7,206,168,4,246,185})))
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
_password = StringObfuscation.makeSecret(password, (_V9({229,188,130,221,199,43,202,172,5,224,170,152,195,215})), 3),
_secrets = {},
_locked = true,
}
function vault:unlock(provided_password)
if self._password.value == provided_password then
self._locked = false
_addAuditEntry((_V9({229,188,130,221,199,43,207,163,26,252,190,156,212,215})), (_V9({229,188,130,221,199})), {})
return true
end
_addAuditEntry((_V9({229,188,130,221,199,43,207,163,26,252,190,156,238,213,21,211,161,19,247})), (_V9({229,188,130,221,199})), {})
return false
end
function vault:lock()
self._locked = true
_addAuditEntry((_V9({229,188,130,221,199,43,214,162,21,248,184,147})), (_V9({229,188,130,221,199})), {})
end
function vault:store(name, value, level)
if self._locked then
warn((_V9({200,139,150,196,223,0,231,237,32,242,168,155,197,147,29,201,237,26,252,190,156,212,215})))
return false
end
self._secrets[name] = StringObfuscation.makeSecret(value, name, level or 2)
_addAuditEntry((_V9({229,188,130,221,199,43,201,185,25,225,184})), name, {})
return true
end
function vault:retrieve(name)
if self._locked then
warn((_V9({200,139,150,196,223,0,231,237,32,242,168,155,197,147,29,201,237,26,252,190,156,212,215})))
return nil
end
if self._secrets[name] then
_addAuditEntry((_V9({229,188,130,221,199,43,200,168,2,225,180,146,199,214})), name, {})
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
warn((_V9({200,139,150,196,223,0,231,237,32,242,168,155,197,147,29,201,237,26,252,190,156,212,215})))
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
_addAuditEntry((_V9({229,188,130,221,199,43,222,168,26,246,169,146})), name, {})
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
return game:GetService((_V9({193,168,153,226,214,6,204,164,21,246}))):IsStudio()
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
return nil, (_V9({224,178,130,195,208,17,229,184,24,242,171,150,216,223,21,216,161,19}))
end
local hash = tostring(#current_source) .. (_V9({169})) .. string.sub(current_source, 1, 50)
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
time_string = os.date((_V9({182,132,218,148,222,89,159,169,86,182,149,205,148,254,78,159,158})), tick()),
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
print((_V9({153,224,202,140,147,48,223,175,3,244,186,146,195,147,48,223,185,19,240,169,158,222,221,84,233,185,23,231,180,132,197,218,23,201,237,75,174,224})))
print((_V9({215,184,131,212,208,0,211,162,24,224,231,215})) .. stats.detections)
print((_V9({208,181,146,210,216,7,154,157,19,225,187,152,195,222,17,222,247,86})) .. stats.checks_performed)
print((_V9({199,188,154,193,214,6,211,163,17,179,156,131,197,214,25,202,185,5,169,253})) .. stats.tampering_attempts)
print((_V9({199,178,131,208,223,84,249,165,19,240,182,215,229,218,25,223,247,86})) .. string.format((_V9({182,243,197,215})), stats.total_check_time_ms) .. (_V9({254,174})))
print((_V9({210,168,147,216,199,84,246,162,17,179,152,153,197,193,29,223,190,76,179})) .. stats.audit_log_entries)
print((_V9({174,224,202,140,142,73,135,240,75,174,224,202,140,142,73,135,240,75,174,224,202,140,142,73,135,240,75,174,224,202,140,142,73,135,240,75,174,215})))
end
function DebuggerDetection.HandleDebuggerState(debugged)
if debugged then
DebugStatistics.detections = DebugStatistics.detections + 1
DebugLogAuditEvent((_V9({247,184,149,196,212,19,223,191,41,247,184,131,212,208,0,223,169})), (_V9({215,184,149,196,212,84,223,163,0,250,175,152,223,222,17,212,185,86,247,184,131,212,208,0,223,169})))
warn((_V9({200,142,146,210,198,6,211,185,15,206,253,179,212,209,1,221,170,19,225,253,147,212,199,17,217,185,19,247,253,21,49,39,84,200,184,24,253,180,153,214,147,29,212,237,6,225,178,147,196,208,0,211,162,24,190,174,150,215,214,84,215,162,18,246,243})))
return {
safe_mode = true,
reduced_logging = true,
skip_sensitive_ops = true,
detected_at = tick(),
}
else
DebugLogAuditEvent((_V9({253,178,133,220,210,24,229,168,14,246,190,130,197,218,27,212})), (_V9({221,178,215,213,214,22,207,170,17,246,175,215,213,214,0,223,174,2,246,185})))
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
DebugLogAuditEvent((_V9({231,188,154,193,214,6,211,163,17,204,188,131,197,214,25,202,185})), attempt_type .. (_V9({169,253})) .. tostring(details))
warn((_V9({200,142,146,210,198,6,211,185,15,179,156,155,212,193,0,231,237,34,242,176,135,212,193,29,212,170,86,242,169,131,212,222,4,206,237,18,246,169,146,210,199,17,222,247,86})) .. attempt_type)
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
DebugLogAuditEvent((_V9({254,178,153,216,199,27,200,164,24,244,130,132,197,210,6,206,168,18})), (_V9({193,184,150,221,158,0,211,160,19,179,185,146,211,198,19,154,160,25,253,180,131,222,193,29,212,170,86,242,190,131,216,197,21,206,168,18})))
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
DebuggerDetection.HandleTamperingAttempt((_V9({224,184,148,196,193,17,229,168,14,246,190,130,197,218,27,212,146,31,253,130,147,212,209,1,221})), (_V9({210,169,131,212,222,4,206,168,18,179,184,143,212,208,1,206,164,25,253,253,158,223,147,16,223,175,3,244,253,154,222,215,17})))
return nil
end
local success, result = pcall(callback)
if not success then
DebugLogAuditEvent((_V9({246,165,146,210,198,0,211,162,24,204,187,150,216,223,17,222})), tostring(result))
warn((_V9({200,142,146,210,198,6,211,185,15,206,253,164,212,208,1,200,168,86,246,165,146,210,198,0,211,162,24,179,187,150,216,223,17,222,247,86})) .. tostring(result))
return nil
end
DebugLogAuditEvent((_V9({246,165,146,210,198,0,211,162,24,204,174,130,210,208,17,201,190})), (_V9({192,184,148,196,193,17,154,174,25,247,184,215,212,203,17,217,184,2,246,185,215,194,198,23,217,168,5,224,187,130,221,223,13})))
return result
end
function DebuggerDetection.VerifyIntegrity()
local state = {
in_studio = DebuggerDetection.IsRunningInStudio(),
debugger_attached = DebuggerDetection.IsDebuggerAttached(),
environment_compromised = DebuggerDetection.IsEnvironmentCompromised(),
timestamp = tick(),
time_string = os.date((_V9({182,132,218,148,222,89,159,169,86,182,149,205,148,254,78,159,158})), tick()),
}
DebugLogAuditEvent((_V9({250,179,131,212,212,6,211,185,15,204,190,159,212,208,31})), state.debugger_attached and (_V9({208,146,186,225,225,59,247,132,37,214,153})) or (_V9({220,150})))
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
DebugLogAuditEvent((_V9({224,164,132,197,214,25,229,164,24,250,169,158,208,223,29,192,168,18})), (_V9({215,184,149,196,212,19,223,191,50,246,169,146,210,199,29,213,163,86,229,239,217,129,147,29,212,164,2,250,188,155,216,201,17,222})))
return state
end
local ProtectedSecrets = { VERSION = (_V9({162,243,199})) }
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
(_V9({225,184,129,212,210,24,229,186,30,250,177,146,238,215,17,216,184,17,244,184,147})),
secret and secret.name or (_V9({230,179,156,223,220,3,212}))
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
DebuggerDetection.HandleTamperingAttempt((_V9({224,184,148,195,214,0,229,170,19,231,130,128,217,218,24,223,146,18,246,191,130,214,212,17,222})), name)
return nil
end
return inner:get(name)
end
function manager:getSecret(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({224,184,148,195,214,0,229,162,20,249,184,148,197,236,3,210,164,26,246,130,147,212,209,1,221,170,19,247})), name)
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
DebuggerDetection.HandleTamperingAttempt((_V9({229,188,130,221,199,43,207,163,26,252,190,156,238,196,28,211,161,19,204,185,146,211,198,19,221,168,18})), (_V9({229,188,130,221,199})))
return false
end
return inner:unlock(providedPassword)
end
function vault:retrieve(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({229,188,130,221,199,43,200,168,2,225,180,146,199,214,43,205,165,31,255,184,168,213,214,22,207,170,17,246,185})), name)
return nil
end
return inner:retrieve(name)
end
function vault:getSecret(name)
if _secretsBlocked(allowInStudio) then
DebuggerDetection.HandleTamperingAttempt((_V9({229,188,130,221,199,43,201,168,21,225,184,131,238,196,28,211,161,19,204,185,146,211,198,19,221,168,18})), name)
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
return game:GetService((_V9({208,178,133,212,244,1,211})))
end)
if ok2 and coreGui then
return coreGui
end
return LocalPlayer:WaitForChild((_V9({195,177,150,200,214,6,253,184,31})))
end
local Configuration = {}
Configuration.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({193,188,153,213,220,25,154,229,33,246,180,144,217,199,17,222,228})),
HitboxOptions = { (_V9({193,188,153,213,220,25,154,229,33,246,180,144,217,199,17,222,228})), (_V9({219,184,150,213})), (_V9({199,178,133,194,220})), (_V9({210,175,154,194})), (_V9({223,184,144,194})) },
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
WatermarkImageId = (_V9({162,238,206,137,135,65,140,244,69,171,232,207,137,134,66})),
}
Configuration.Debug = false
local DEFAULTS = {
Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({193,188,153,213,220,25,154,229,33,246,180,144,217,199,17,222,228})),
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
if type(value) == (_V9({231,188,149,221,214})) then
local target = Configuration[section][key]
if type(target) ~= (_V9({231,188,149,221,214})) then
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
local CONFIG_FOLDER = (_V9({197,188,153,216,199,13,253,168,24,246,175,150,221}))
local SAVED_SECTIONS = { (_V9({208,188,154,212,193,21})), (_V9({214,142,167})), (_V9({221,178,165,212,208,27,211,161})), (_V9({221,178,164,193,193,17,219,169})), (_V9({198,148})) }
local function fsAvailable()
return type(writefile) == (_V9({245,168,153,210,199,29,213,163}))
and type(readfile) == (_V9({245,168,153,210,199,29,213,163}))
and type(listfiles) == (_V9({245,168,153,210,199,29,213,163}))
end
local function ensureFolder()
if type(isfolder) == (_V9({245,168,153,210,199,29,213,163})) and type(makefolder) == (_V9({245,168,153,210,199,29,213,163})) then
if not isfolder(CONFIG_FOLDER) then
pcall(makefolder, CONFIG_FOLDER)
end
end
end
local function sanitizeName(name)
return (tostring(name or (_V9({}))):gsub((_V9({200,131,210,198,236,81,151,237,43})), (_V9({}))):gsub((_V9({205,248,132,154})), (_V9({}))):gsub((_V9({182,174,220,149})), (_V9({}))))
end
local function pathFor(name)
return CONFIG_FOLDER .. (_V9({188})) .. name .. (_V9({189,183,132,222,221}))
end
local function encodeValue(v)
local t = typeof(v)
if t == (_V9({208,178,155,222,193,71})) then
return { __t = (_V9({208,178,155,222,193,71})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({214,179,130,220,250,0,223,160})) then
return { __t = (_V9({214,179,130,220})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({231,188,149,221,214})) then
local out = {}
for k, val in pairs(v) do
if type(val) ~= (_V9({245,168,153,210,199,29,213,163})) then
local enc = encodeValue(val)
if enc ~= nil then
out[k] = enc
end
end
end
return out
elseif t == (_V9({253,168,154,211,214,6})) or t == (_V9({224,169,133,216,221,19})) or t == (_V9({241,178,152,221,214,21,212})) then
return v
end
return nil
end
local function decodeValue(v)
if type(v) ~= (_V9({231,188,149,221,214})) then
return v
end
if v.__t == (_V9({208,178,155,222,193,71})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({214,179,130,220})) then
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
if type(v) == (_V9({231,188,149,221,214})) and v.__t == nil then
if type(target[k]) == (_V9({231,188,149,221,214})) then
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
if not ok or type(files) ~= (_V9({231,188,149,221,214})) then
return out
end
for _, path in ipairs(files) do
local name = tostring(path):match((_V9({187,134,169,158,239,41,145,228,83,189,183,132,222,221,80})))
if name then
table.insert(out, name)
end
end
table.sort(out)
return out
end
function ConfigManager.save(name, config)
if not fsAvailable() then
return false, (_V9({199,181,158,194,147,17,194,168,21,230,169,152,195,147,28,219,190,86,253,178,215,215,218,24,223,237,55,195,148}))
end
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({214,179,131,212,193,84,219,237,21,252,179,145,216,212,84,212,172,27,246}))
end
ensureFolder()
local data = {}
for _, section in ipairs(SAVED_SECTIONS) do
if type(config[section]) == (_V9({231,188,149,221,214})) then
data[section] = encodeValue(config[section])
end
end
local okJson, json = pcall(function()
return game:GetService((_V9({219,169,131,193,224,17,200,187,31,240,184}))):JSONEncode(data)
end)
if not okJson then
return false, (_V9({214,179,148,222,215,17,154,171,23,250,177,146,213,137,84})) .. tostring(json)
end
local okWrite, err = pcall(writefile, pathFor(name), json)
if not okWrite then
return false, (_V9({196,175,158,197,214,84,220,172,31,255,184,147,139,147})) .. tostring(err)
end
return true, name
end
function ConfigManager.load(name, config)
if not fsAvailable() then
return false, (_V9({199,181,158,194,147,17,194,168,21,230,169,152,195,147,28,219,190,86,253,178,215,215,218,24,223,237,55,195,148}))
end
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({214,179,131,212,193,84,219,237,21,252,179,145,216,212,84,212,172,27,246}))
end
local path = pathFor(name)
if type(isfile) == (_V9({245,168,153,210,199,29,213,163})) then
local okIs, exists = pcall(isfile, path)
if okIs and not exists then
return false, (_V9({221,178,215,210,220,26,220,164,17,179,179,150,220,214,16,154,234})) .. name .. (_V9({180}))
end
end
local okRead, raw = pcall(readfile, path)
if not okRead or type(raw) ~= (_V9({224,169,133,216,221,19})) then
return false, (_V9({193,184,150,213,147,18,219,164,26,246,185}))
end
local okJson, data = pcall(function()
return game:GetService((_V9({219,169,131,193,224,17,200,187,31,240,184}))):JSONDecode(raw)
end)
if not okJson or type(data) ~= (_V9({231,188,149,221,214})) then
return false, (_V9({199,181,150,197,147,18,211,161,19,179,180,132,223,148,0,154,187,23,255,180,147,145,249,39,245,131}))
end
for _, section in ipairs(SAVED_SECTIONS) do
if type(data[section]) == (_V9({231,188,149,221,214})) and type(config[section]) == (_V9({231,188,149,221,214})) then
applyInto(config[section], data[section])
end
end
return true, name
end
function ConfigManager.delete(name)
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({214,179,131,212,193,84,219,237,21,252,179,145,216,212,84,212,172,27,246}))
end
if type(delfile) ~= (_V9({245,168,153,210,199,29,213,163})) then
return false, (_V9({199,181,158,194,147,17,194,168,21,230,169,152,195,147,23,219,163,81,231,253,147,212,223,17,206,168,86,245,180,155,212,192}))
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
Head = { (_V9({219,184,150,213})) },
Torso = { (_V9({198,173,135,212,193,32,213,191,5,252})), (_V9({223,178,128,212,193,32,213,191,5,252})), (_V9({199,178,133,194,220})), (_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})) },
Arms = {
(_V9({223,184,145,197,251,21,212,169})), (_V9({193,180,144,217,199,60,219,163,18})),
(_V9({223,184,145,197,255,27,205,168,4,210,175,154})), (_V9({193,180,144,217,199,56,213,186,19,225,156,133,220})),
(_V9({223,184,145,197,230,4,202,168,4,210,175,154})), (_V9({193,180,144,217,199,33,202,189,19,225,156,133,220})),
(_V9({223,184,145,197,147,53,200,160})), (_V9({193,180,144,217,199,84,251,191,27})),
},
Legs = {
(_V9({223,184,145,197,245,27,213,185})), (_V9({193,180,144,217,199,50,213,162,2})),
(_V9({223,184,145,197,255,27,205,168,4,223,184,144})), (_V9({193,180,144,217,199,56,213,186,19,225,145,146,214})),
(_V9({223,184,145,197,230,4,202,168,4,223,184,144})), (_V9({193,180,144,217,199,33,202,189,19,225,145,146,214})),
(_V9({223,184,145,197,147,56,223,170})), (_V9({193,180,144,217,199,84,246,168,17})),
},
}
local REGION_ORDER = { (_V9({219,184,150,213})), (_V9({199,178,133,194,220})), (_V9({210,175,154,194})), (_V9({223,184,144,194})) }
local rng = Random.new()
local function pickPartFromRegion(character, region)
local names = REGION_PARTS[region]
if not names then
return nil
end
for _, name in ipairs(names) do
local part = character:FindFirstChild(name)
if part and part:IsA((_V9({209,188,132,212,227,21,200,185}))) then
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
if descendant:IsA((_V9({209,188,132,212,227,21,200,185}))) then
return descendant
end
end
return nil
end
local function anchorPart(character)
return character:FindFirstChild((_V9({219,184,150,213})))
or character:FindFirstChild((_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})))
or character:FindFirstChild((_V9({198,173,135,212,193,32,213,191,5,252})))
or character:FindFirstChild((_V9({199,178,133,194,220})))
or pickAnyPart(character)
end
local function rollWeightedRegion(weights)
local total = 0
for _, region in ipairs(REGION_ORDER) do
total = total + math.max(0, (weights and weights[region]) or 0)
end
if total <= 0 then
return (_V9({219,184,150,213}))
end
local roll = rng:NextNumber() * total
local acc = 0
for _, region in ipairs(REGION_ORDER) do
acc = acc + math.max(0, weights[region] or 0)
if roll <= acc then
return region
end
end
return (_V9({219,184,150,213}))
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
fovGui = Instance.new((_V9({192,190,133,212,214,26,253,184,31})))
fovGui.Name = (_V9({197,188,153,216,199,13,253,168,24,246,175,150,221,245,59,236}))
fovGui.ResetOnSpawn = false
fovGui.IgnoreGuiInset = true
fovGui.DisplayOrder = 998
local ok = pcall(function()
fovGui.Parent = getGuiParent()
end)
if not ok or not fovGui.Parent then
fovGui.Parent = LocalPlayer:WaitForChild((_V9({195,177,150,200,214,6,253,184,31})))
end
fovRing = Instance.new((_V9({213,175,150,220,214})))
fovRing.Name = (_V9({193,180,153,214}))
fovRing.AnchorPoint = Vector2.new(0.5, 0.5)
fovRing.Position = UDim2.fromScale(0.5, 0.5)
fovRing.BackgroundTransparency = 1
fovRing.BorderSizePixel = 0
fovRing.Parent = fovGui
local corner = Instance.new((_V9({198,148,180,222,193,26,223,191})))
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = fovRing
fovStroke = Instance.new((_V9({198,148,164,197,193,27,209,168})))
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
local humanoid = character:FindFirstChildOfClass((_V9({219,168,154,208,221,27,211,169})))
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
if descendant:IsA((_V9({222,178,147,212,223})))
and descendant:FindFirstChildOfClass((_V9({219,168,154,208,221,27,211,169})))
and not Players:GetPlayerFromCharacter(descendant)
then
table.insert(botCharacters, descendant)
end
end
return botCharacters
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
local myRoot = myChar and myChar:FindFirstChild((_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})))
local maxRange = (espConfig and espConfig.MaxDistance) or math.huge
local function consider(character, result)
local humanoid = character and character:FindFirstChildOfClass((_V9({219,168,154,208,221,27,211,169})))
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
if mode and mode ~= (_V9({193,188,153,213,220,25,154,229,33,246,180,144,217,199,17,222,228})) and REGION_PARTS[mode] then
return mode
end
if self._lockedChar ~= character then
self._lockedChar = character
self._rolledRegion = rollWeightedRegion(config.TargetWeights)
end
return self._rolledRegion or (_V9({219,184,150,213}))
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
return
end
self._stickyCharacter = target.Character
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
print((_V9({199,175,150,210,216,29,212,170,76})), target.Character.Name, (_V9({193,184,144,216,220,26,128})), region, (_V9({215,180,132,197,210,26,217,168,76})), math.floor(target.ScreenDistance))
end
return target
end
function CameraDirector:Cleanup()
self._lockedChar = nil
self._stickyCharacter = nil
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
local hum = char and char:FindFirstChildOfClass((_V9({219,168,154,208,221,27,211,169})))
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
if type(hookfunction) == (_V9({245,168,153,210,199,29,213,163})) then
return hookfunction
elseif type(replaceclosure) == (_V9({245,168,153,210,199,29,213,163})) then
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
warn((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,56,252,253,164,193,193,17,219,169,86,253,184,146,213,192,84,220,184,24,240,169,158,222,221,84,210,162,25,248,180,153,214,147,92,210,162,25,248,187,130,223,208,0,211,162,24,186,253,21,49,39,84,212,162,2,179,188,129,208,218,24,219,175,26,246,253,158,223,147,0,210,164,5,179,184,143,212,208,1,206,162,4,189})))
ns_warned = true
end
return false
end
ns_installMath(hook)
ns_installRandom(hook)
if not (ns_mathHooked or ns_randHooked) then
if not ns_warned then
warn((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,56,252,253,164,193,193,17,219,169,76,179,187,150,216,223,17,222,237,2,252,253,158,223,192,0,219,161,26,179,188,153,200,147,28,213,162,29,189})))
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
if type(mouse1click) == (_V9({245,168,153,210,199,29,213,163})) then
tb_click = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({245,168,153,210,199,29,213,163})) and type(mouse1release) == (_V9({245,168,153,210,199,29,213,163})) then
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
local model = result.Instance:FindFirstAncestorOfClass((_V9({222,178,147,212,223})))
local plr = model and Players:GetPlayerFromCharacter(model)
if not plr or plr == LocalPlayer then
return nil
end
if cameraConfig and cameraConfig.TeamCheck and plr.Team ~= nil and plr.Team == LocalPlayer.Team then
return nil
end
local hum = model:FindFirstChildOfClass((_V9({219,168,154,208,221,27,211,169})))
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
warn((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,34,225,180,144,214,214,6,216,162,2,179,179,146,212,215,7,154,172,86,254,178,130,194,214,89,217,161,31,240,182,215,215,198,26,217,185,31,252,179,215,153,222,27,207,190,19,162,190,155,216,208,31,147,237,148,19,73,215,223,220,0,154,172,0,242,180,155,208,209,24,223,237,31,253,253,131,217,218,7,154,168,14,246,190,130,197,220,6,148})))
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
local hum = character:FindFirstChildOfClass((_V9({219,168,154,208,221,27,211,169})))
return (hum and hum.RootPart)
or character:FindFirstChild((_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})))
or character:FindFirstChild((_V9({199,178,133,194,220})))
or character:FindFirstChild((_V9({198,173,135,212,193,32,213,191,5,252})))
or character.PrimaryPart
end
local function getBoxGui()
if boxGui and boxGui.Parent then
return boxGui
end
boxGui = Instance.new((_V9({192,190,133,212,214,26,253,184,31})))
boxGui.Name = (_V9({197,188,153,216,199,13,253,168,24,246,175,150,221,241,27,194,168,5}))
boxGui.ResetOnSpawn = false
boxGui.IgnoreGuiInset = true
boxGui.DisplayOrder = 996
local ok = pcall(function()
boxGui.Parent = getGuiParent()
end)
if not ok or not boxGui.Parent then
boxGui.Parent = LocalPlayer:WaitForChild((_V9({195,177,150,200,214,6,253,184,31})))
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
local head = character:FindFirstChild((_V9({219,184,150,213})))
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
local tag = Instance.new((_V9({209,180,155,221,209,27,219,191,18,212,168,158})))
tag.Name = (_V9({197,154,190,223,213,27}))
tag.Size = UDim2.fromOffset(200, 34)
tag.StudsOffset = Vector3.new(0, 2.7, 0)
tag.AlwaysOnTop = true
tag.Adornee = head
tag.Parent = head
local holder = Instance.new((_V9({213,175,150,220,214})))
holder.BackgroundTransparency = 1
holder.Size = UDim2.fromScale(1, 1)
holder.Parent = tag
local layout = Instance.new((_V9({198,148,187,216,192,0,246,172,15,252,168,131})))
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Parent = holder
local nameLbl = Instance.new((_V9({199,184,143,197,255,21,216,168,26})))
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
local distLbl = Instance.new((_V9({199,184,143,197,255,21,216,168,26})))
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
local head = character:FindFirstChild((_V9({219,184,150,213}))) or character:FindFirstChild((_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})))
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
local myRoot = myChar and myChar:FindFirstChild((_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})))
local hrp = character:FindFirstChild((_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})))
local d = (myRoot and hrp) and math.floor((hrp.Position - myRoot.Position).Magnitude + 0.5) or 0
entry.distanceLabel.Text = (_V9({200})) .. d .. (_V9({254,128}))
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
local myRoot = myChar and myChar:FindFirstChild((_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})))
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
local hrp = character:FindFirstChild((_V9({219,168,154,208,221,27,211,169,36,252,178,131,225,210,6,206})))
local humanoid = character:FindFirstChildOfClass((_V9({219,168,154,208,221,27,211,169})))
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
local highlight = Instance.new((_V9({219,180,144,217,223,29,221,165,2})))
highlight.Name = (_V9({214,142,167,254,198,0,214,164,24,246}))
highlight.Enabled = false
highlight.FillColor = color
highlight.OutlineColor = color
highlight.Parent = container
local box = Instance.new((_V9({213,175,150,220,214})))
box.Name = (_V9({214,142,167,243,220,12}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = getBoxGui()
local boxStroke = Instance.new((_V9({198,148,164,197,193,27,209,168})))
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
if obj:IsA((_V9({219,168,154,208,221,27,211,169}))) then
local model = obj.Parent
if
model
and model:IsA((_V9({222,178,147,212,223})))
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
local humanoid = model:FindFirstChildOfClass((_V9({219,168,154,208,221,27,211,169})))
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
container = Instance.new((_V9({213,178,155,213,214,6})))
container.Name = (_V9({197,188,153,216,199,13,253,168,24,246,175,150,221,246,39,234}))
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
local currentTab = (_V9({208,178,154,211,210,0}))
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
local btn = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = newInstance((_V9({213,175,150,220,214})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = box, CornerRadius = UDim.new(0, 3) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = box, Color = COLORS.border, Thickness = 1 })
local label = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local holder = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local label = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local track = newInstance((_V9({213,175,150,220,214})), {
Parent = holder,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = track, CornerRadius = UDim.new(1, 0) })
local fill = newInstance((_V9({213,175,150,220,214})), {
Parent = track,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = fill, CornerRadius = UDim.new(1, 0) })
local function format(v)
local base = isInt and tostring(math.floor(v + 0.5)) or string.format((_V9({182,243,197,215})), v)
return base .. suffix
end
local function apply(v)
v = math.clamp(v, min, max)
if isInt then
v = math.floor(v + 0.5)
end
local alpha = (max > min) and (v - min) / (max - min) or 0
fill.Size = UDim2.new(alpha, 0, 1, 0)
label.Text = text .. (_V9({169,253})) .. format(v)
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
local holder = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
ZIndex = 2,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local dropdown = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = dropdown, CornerRadius = UDim.new(0, 4) })
local open = false
local ROW_H = 24
local fullSize = #options * ROW_H
local listSize = math.min(fullSize, 7 * ROW_H)
local list = newInstance((_V9({192,190,133,222,223,24,211,163,17,213,175,150,220,214})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = list, CornerRadius = UDim.new(0, 4) })
for i, option in ipairs(options) do
local optionBtn = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
local holder = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local value = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local btn = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
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
local holder = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local stroke = newInstance((_V9({198,148,164,197,193,27,209,168})), {
Parent = holder,
Color = COLORS.border,
Thickness = 1,
Transparency = 0.3,
})
local box = newInstance((_V9({199,184,143,197,241,27,194})), {
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
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local holder = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local fill = newInstance((_V9({213,175,150,220,214})), {
Parent = holder,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = COLORS.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = fill, CornerRadius = UDim.new(0, 6) })
local label = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local s = isInt and tostring(math.floor(v + 0.5)) or string.format((_V9({182,243,197,215})), v)
if showMax then
local m = isInt and tostring(math.floor(max + 0.5)) or string.format((_V9({182,243,197,215})), max)
return s .. (_V9({188})) .. m .. unit
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
label.Text = text .. (_V9({169,253})) .. fmt(v)
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
local holder = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
Parent = holder,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local dropdown = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
Parent = holder,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = dropdown, CornerRadius = UDim.new(0, 6) })
local dropStroke = newInstance((_V9({198,148,164,197,193,27,209,168})), {
Parent = dropdown,
Color = COLORS.border,
Thickness = 1,
Transparency = 0.3,
})
local valueLabel = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local caret = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
Parent = dropdown,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.accent,
Text = (_V9({113,75,73})),
})
local open = false
local ROW_H = 26
local fullSize = #options * ROW_H
local listSize = math.min(fullSize, 6 * ROW_H)
local list = newInstance((_V9({192,190,133,222,223,24,211,163,17,213,175,150,220,214})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = list, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = list, Color = COLORS.border, Thickness = 1, Transparency = 0.2 })
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
local optionBtn = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
local holder = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, SQ_H + 74),
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = holder, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = holder,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local heading = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
Parent = holder,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({208,178,155,222,193})),
})
local body = newInstance((_V9({213,175,150,220,214})), {
Parent = holder,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local sq = newInstance((_V9({213,175,150,220,214})), {
Parent = body,
Size = UDim2.new(1, -(HUE_W + GAP), 0, SQ_H),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = sq, CornerRadius = UDim.new(0, 4) })
local satLayer = newInstance((_V9({213,175,150,220,214})), {
Parent = sq,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = satLayer, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({198,148,176,195,210,16,211,168,24,231})), {
Parent = satLayer,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local valLayer = newInstance((_V9({213,175,150,220,214})), {
Parent = sq,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = valLayer, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({198,148,176,195,210,16,211,168,24,231})), {
Parent = valLayer,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local svDot = newInstance((_V9({213,175,150,220,214})), {
Parent = sq,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = svDot, CornerRadius = UDim.new(1, 0) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = svDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local hue = newInstance((_V9({213,175,150,220,214})), {
Parent = body,
Size = UDim2.fromOffset(HUE_W, SQ_H),
Position = UDim2.new(1, -HUE_W, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = hue, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({198,148,176,195,210,16,211,168,24,231})), {
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
local hueDot = newInstance((_V9({213,175,150,220,214})), {
Parent = hue,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = hueDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local preview = newInstance((_V9({213,175,150,220,214})), {
Parent = body,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, SQ_H + 6),
BackgroundColor3 = getColor(),
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = preview, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = preview, Color = COLORS.off, Thickness = 1 })
local hexLabel = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
hexLabel.Text = string.format((_V9({176,248,199,131,235,81,138,255,46,182,237,197,233,147,84,146,232,18,191,253,210,213,159,84,159,169,95})), r, g, b, r, g, b)
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
box.Text = (_V9({195,175,146,194,192,150,58,107}))
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
UI:Notify(string.format((_V9({182,174,215,216,192,84,219,161,4,246,188,147,200,147,22,213,184,24,247,253,131,222,147,81,201})), key.Name, conflict), 2.5)
else
setKey(key)
UI:Notify(string.format((_V9({182,174,215,211,220,1,212,169,86,231,178,215,148,192})), labelText, key.Name), 2)
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
if field ~= (_V9({254,184,153,196})) and config.UI.MenuKey == key then
return (_V9({222,184,153,196}))
end
if field ~= (_V9({242,180,154,211,220,0})) and config.Camera.ToggleKey == key then
return (_V9({210,180,154,211,220,0}))
end
if field ~= (_V9({246,174,135})) and config.ESP.ToggleKey == key then
return (_V9({214,142,167}))
end
if field ~= (_V9({245,178,129,210,218,6,217,161,19})) and config.Camera.FOVCircleKey == key then
return (_V9({213,146,161,145,240,29,200,174,26,246}))
end
if field ~= (_V9({253,178,133,212,208,27,211,161})) and config.NoRecoil.ToggleKey == key then
return (_V9({221,178,215,227,214,23,213,164,26}))
end
if field ~= (_V9({253,178,132,193,193,17,219,169})) and config.NoSpread.ToggleKey == key then
return (_V9({221,178,215,226,195,6,223,172,18}))
end
if field ~= (_V9({231,175,158,214,212,17,200,175,25,231})) and config.Triggerbot.ToggleKey == key then
return (_V9({199,175,158,214,212,17,200,175,25,231}))
end
if field ~= (_V9({230,179,155,222,210,16})) and config.UI.UnloadKey == key then
return (_V9({198,179,155,222,210,16}))
end
return nil
end
local function makeKeybind(parent, labelText, getKey, setKey, conflictCheck)
local holder = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local box = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = box, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
newInstance((_V9({198,148,164,216,201,17,249,162,24,224,169,133,208,218,26,206})), { Parent = box, MinSize = Vector2.new(54, 22) })
wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
end
local function makeToggleWithKeybind(parent, text, getValue, onChange, keyLabel, getKey, setKey, conflictCheck)
local btn = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local check = newInstance((_V9({213,175,150,220,214})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = check, CornerRadius = UDim.new(0, 3) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = check, Color = COLORS.border, Thickness = 1 })
local label = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local box = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = box, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
newInstance((_V9({198,148,164,216,201,17,249,162,24,224,169,133,208,218,26,206})), { Parent = box, MinSize = Vector2.new(44, 20) })
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
local col = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
Parent = col,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return col
end
return column(1), column(2)
end
local function makeGroup(parent, title)
local wrapper = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = newInstance((_V9({213,175,150,220,214})), {
Parent = wrapper,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = box, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = box, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local veil = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = veil, CornerRadius = UDim.new(0, 6) })
local STRIPE, GAP = 0.72, 1
local hatch = newInstance((_V9({213,175,150,220,214})), {
Parent = veil,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = COLORS.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = hatch, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({198,148,176,195,210,16,211,168,24,231})), {
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
box:GetPropertyChangedSignal((_V9({210,191,132,222,223,1,206,168,37,250,167,146}))):Connect(syncWrapper)
syncWrapper()
local function setEnabled(enabled)
veil.Visible = not enabled
end
return box, setEnabled
end
local function makeSubTabHost(parent)
local bar = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local divider = newInstance((_V9({213,175,150,220,214})), {
Parent = parent,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = COLORS.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local area = newInstance((_V9({213,175,150,220,214})), {
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
local btn = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
local underline = newInstance((_V9({213,175,150,220,214})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = COLORS.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = newInstance((_V9({192,190,133,222,223,24,211,163,17,213,175,150,220,214})), {
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
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
newInstance((_V9({198,148,167,208,215,16,211,163,17})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
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
local left, right = makeColumns(host:add((_V9({210,180,154,211,220,0}))))
local aim = makeGroup(left, (_V9({210,180,154,211,220,0})))
makeToggleWithKeybind(aim, (_V9({214,179,150,211,223,17,222})), function()
return config.Camera.Enabled
end, function()
config.Camera.Enabled = not config.Camera.Enabled
end, (_V9({210,180,154,211,220,0,154,134,19,234})), function()
return config.Camera.ToggleKey
end, function(key)
config.Camera.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({242,180,154,211,220,0})))
end)
makeToggle(aim, (_V9({197,180,132,210,219,17,217,166})), function()
return config.Camera.WallCheck
end, function()
config.Camera.WallCheck = not config.Camera.WallCheck
end)
makeToggle(aim, (_V9({192,169,158,210,216,13,154,153,23,225,186,146,197})), function()
return config.Camera.StickyTarget
end, function()
config.Camera.StickyTarget = not config.Camera.StickyTarget
end)
makeToggle(aim, (_V9({199,188,133,214,214,0,154,143,25,231,174})), function()
return config.Camera.TargetBots
end, function()
config.Camera.TargetBots = not config.Camera.TargetBots
end)
makeToggle(aim, (_V9({199,184,150,220,147,55,210,168,21,248})), function()
return config.Camera.TeamCheck
end, function()
config.Camera.TeamCheck = not config.Camera.TeamCheck
end)
makeToggleWithKeybind(aim, (_V9({213,146,161,145,240,29,200,174,26,246})), function()
return config.Camera.FOVCircle
end, function()
config.Camera.FOVCircle = not config.Camera.FOVCircle
end, (_V9({213,146,161,145,240,29,200,174,26,246,253,188,212,202})), function()
return config.Camera.FOVCircleKey
end, function(key)
config.Camera.FOVCircleKey = key
end, function(key)
return keyConflict(config, key, (_V9({245,178,129,210,218,6,217,161,19})))
end)
makeFillSlider(aim, (_V9({192,176,152,222,199,28,212,168,5,224})), 0.05, 1, function()
return config.Camera.Smoothness
end, function(val)
config.Camera.Smoothness = val
end, false)
makeFillSlider(aim, (_V9({213,146,161})), 20, 800, function()
return config.Camera.FOV
end, function(val)
config.Camera.FOV = val
end, true, (_V9({227,165})), true)
makeFillSlider(aim, (_V9({222,188,143,145,247,29,201,185,23,253,190,146})), 100, 2000, function()
return config.Camera.MaxDistance
end, function(val)
config.Camera.MaxDistance = val
end, true, (_V9({254})), true)
local refreshWeightGate
local hitbox = makeGroup(right, (_V9({219,180,131,211,220,12})))
makeDropdownFull(hitbox, config.Camera.HitboxOptions, function()
return config.Camera.Hitbox
end, function(val)
config.Camera.Hitbox = val
if refreshWeightGate then
refreshWeightGate()
end
end)
local weights, setWeightsEnabled = makeGroup(right, (_V9({199,188,133,214,214,0,154,158,19,231,169,158,223,212,7})))
local function weightRow(name)
makeFillSlider(weights, name .. (_V9({179,138,146,216,212,28,206})), 0, 100, function()
return config.Camera.TargetWeights[name]
end, function(val)
config.Camera.TargetWeights[name] = val
end, true, (_V9({182})), true)
end
weightRow((_V9({219,184,150,213})))
weightRow((_V9({199,178,133,194,220})))
weightRow((_V9({210,175,154,194})))
weightRow((_V9({223,184,144,194})))
refreshWeightGate = function()
setWeightsEnabled(config.Camera.Hitbox == (_V9({193,188,153,213,220,25,154,229,33,246,180,144,217,199,17,222,228})))
end
refreshWeightGate()
table.insert(syncHandlers, refreshWeightGate)
local trigger = makeGroup(right, (_V9({199,175,158,214,212,17,200,175,25,231})))
makeToggleWithKeybind(trigger, (_V9({214,179,150,211,223,17,222})), function()
return config.Triggerbot.Enabled
end, function()
config.Triggerbot.Enabled = not config.Triggerbot.Enabled
end, (_V9({199,175,158,214,212,17,200,175,25,231,253,188,212,202})), function()
return config.Triggerbot.ToggleKey
end, function(key)
config.Triggerbot.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({231,175,158,214,212,17,200,175,25,231})))
end)
makeFillSlider(trigger, (_V9({215,184,155,208,202})), 0, 500, function()
return config.Triggerbot.Delay * 1000
end, function(val)
config.Triggerbot.Delay = val / 1000
end, true, (_V9({254,174})), true)
makeFillSlider(trigger, (_V9({222,188,143,145,247,29,201,185,23,253,190,146})), 100, 2000, function()
return config.Triggerbot.MaxDistance
end, function(val)
config.Triggerbot.MaxDistance = val
end, true, (_V9({254})), true)
makeToggle(trigger, (_V9({197,180,132,210,219,17,217,166})), function()
return config.Triggerbot.WallCheck
end, function()
config.Triggerbot.WallCheck = not config.Triggerbot.WallCheck
end)
left, right = makeColumns(host:add((_V9({196,184,150,193,220,26,201}))))
local recoil = makeGroup(left, (_V9({221,178,215,227,214,23,213,164,26})))
makeToggleWithKeybind(recoil, (_V9({214,179,150,211,223,17,222})), function()
return config.NoRecoil.Enabled
end, function()
config.NoRecoil.Enabled = not config.NoRecoil.Enabled
end, (_V9({221,178,215,227,214,23,213,164,26,179,150,146,200})), function()
return config.NoRecoil.ToggleKey
end, function(key)
config.NoRecoil.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({253,178,133,212,208,27,211,161})))
end)
makeToggle(recoil, (_V9({220,179,155,200,147,35,210,164,26,246,253,177,216,193,29,212,170})), function()
return config.NoRecoil.RequireMouseDown
end, function()
config.NoRecoil.RequireMouseDown = not config.NoRecoil.RequireMouseDown
end)
makeToggle(recoil, (_V9({210,177,155,222,196,84,251,164,27,179,153,152,198,221})), function()
return config.NoRecoil.AllowAim
end, function()
config.NoRecoil.AllowAim = not config.NoRecoil.AllowAim
end)
makeFillSlider(recoil, (_V9({192,169,133,212,221,19,206,165})), 0, 100, function()
return config.NoRecoil.Strength * 100
end, function(val)
config.NoRecoil.Strength = val / 100
end, true, (_V9({182})), true)
local spread = makeGroup(left, (_V9({221,178,215,226,195,6,223,172,18})))
makeToggleWithKeybind(spread, (_V9({214,179,150,211,223,17,222})), function()
return config.NoSpread.Enabled
end, function()
config.NoSpread.Enabled = not config.NoSpread.Enabled
end, (_V9({221,178,215,226,195,6,223,172,18,179,150,146,200})), function()
return config.NoSpread.ToggleKey
end, function(key)
config.NoSpread.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({253,178,132,193,193,17,219,169})))
end)
makeToggle(spread, (_V9({220,179,155,200,147,35,210,164,26,246,253,177,216,193,29,212,170})), function()
return config.NoSpread.RequireMouseDown
end, function()
config.NoSpread.RequireMouseDown = not config.NoSpread.RequireMouseDown
end)
makeFillSlider(spread, (_V9({192,169,133,212,221,19,206,165})), 0, 100, function()
return config.NoSpread.Strength * 100
end, function(val)
config.NoSpread.Strength = val / 100
end, true, (_V9({182})), true)
end
local function buildESPTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({214,142,167}))))
local esp = makeGroup(left, (_V9({214,142,167})))
makeToggleWithKeybind(esp, (_V9({214,179,150,211,223,17,222})), function()
return config.ESP.Enabled
end, function()
config.ESP.Enabled = not config.ESP.Enabled
end, (_V9({214,142,167,145,248,17,195})), function()
return config.ESP.ToggleKey
end, function(key)
config.ESP.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({246,174,135})))
end)
makeToggle(esp, (_V9({221,141,180,194})), function()
return config.ESP.NPCs
end, function()
config.ESP.NPCs = not config.ESP.NPCs
end)
makeFillSlider(esp, (_V9({222,188,143,145,247,29,201,185,23,253,190,146})), 100, 2000, function()
return config.ESP.MaxDistance
end, function(val)
config.ESP.MaxDistance = val
end, true, (_V9({254})), true)
local look = makeGroup(left, (_V9({210,173,135,212,210,6,219,163,21,246})))
makeToggle(look, (_V9({220,168,131,221,218,26,223,190})), function()
return config.ESP.Outlines
end, function()
config.ESP.Outlines = not config.ESP.Outlines
end)
makeToggle(look, (_V9({209,178,143,212,192})), function()
return config.ESP.Boxes
end, function()
config.ESP.Boxes = not config.ESP.Boxes
end)
makeToggle(look, (_V9({221,188,154,212,192})), function()
return config.ESP.Names
end, function()
config.ESP.Names = not config.ESP.Names
end)
makeToggle(look, (_V9({215,180,132,197,210,26,217,168})), function()
return config.ESP.Distance
end, function()
config.ESP.Distance = not config.ESP.Distance
end)
makeToggle(look, (_V9({213,180,155,221,214,16})), function()
return config.ESP.Filled
end, function()
config.ESP.Filled = not config.ESP.Filled
end)
makeFillSlider(look, (_V9({220,168,131,221,218,26,223,237,57,227,188,148,216,199,13})), 0, 1, function()
return config.ESP.OutlineOpacity
end, function(val)
config.ESP.OutlineOpacity = val
end, false)
makeFillSlider(look, (_V9({213,180,155,221,147,59,202,172,21,250,169,142})), 0, 1, function()
return config.ESP.FillOpacity
end, function(val)
config.ESP.FillOpacity = val
end, false)
left, right = makeColumns(host:add((_V9({208,178,155,222,193,7}))))
makeColorPicker(left, (_V9({220,168,131,221,218,26,223,237,53,252,177,152,195})), function()
return config.ESP.OutlineColor
end, function(c)
config.ESP.OutlineColor = c
end)
makeColorPicker(right, (_V9({213,180,155,221,147,55,213,161,25,225})), function()
return config.ESP.FillColor
end, function(c)
config.ESP.FillColor = c
end)
end
local function buildSettingsTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({212,184,153,212,193,21,214}))))
local iface = makeGroup(left, (_V9({218,179,131,212,193,18,219,174,19})))
makeFillSlider(iface, (_V9({198,148,215,226,208,21,214,168})), 0.8, 1.5, function()
return config.UI.Scale
end, function(val)
config.UI.Scale = val
if windowScale then
windowScale.Scale = val
end
end, false)
makeToggle(iface, (_V9({216,184,142,211,218,26,222,237,38,242,179,146,221})), function()
return config.UI.KeybindPanel
end, function()
config.UI.KeybindPanel = not config.UI.KeybindPanel
if keybindPanel then
keybindPanel.Visible = config.UI.KeybindPanel
end
end)
makeToggle(iface, (_V9({199,188,133,214,214,0,154,137,31,224,173,155,208,202})), function()
return config.UI.TargetDisplay
end, function()
config.UI.TargetDisplay = not config.UI.TargetDisplay
targetDisplayOn = config.UI.TargetDisplay
if not targetDisplayOn and targetPanel then
targetPanel.Visible = false
end
end)
makeToggle(iface, (_V9({213,141,164,145,240,27,207,163,2,246,175})), function()
return config.UI.FPSCounter
end, function()
config.UI.FPSCounter = not config.UI.FPSCounter
if fpsPanel then
fpsPanel.Visible = config.UI.FPSCounter
end
end)
makeToggle(iface, (_V9({196,188,131,212,193,25,219,191,29})), function()
return config.UI.Watermark
end, function()
config.UI.Watermark = not config.UI.Watermark
if watermark then
watermark.Visible = config.UI.Watermark
end
end)
local account = makeGroup(right, (_V9({210,190,148,222,198,26,206})))
makeLabel(account, (_V9({198,174,146,195,221,21,215,168})), LocalPlayer and LocalPlayer.Name or (_V9({113,93,99})))
makeLabel(account, (_V9({215,180,132,193,223,21,195,237,56,242,176,146})), LocalPlayer and LocalPlayer.DisplayName or (_V9({113,93,99})))
makeLabel(account, (_V9({198,174,146,195,147,61,254})), LocalPlayer and tostring(LocalPlayer.UserId) or (_V9({113,93,99})))
left, right = makeColumns(host:add((_V9({208,178,153,215,218,19,201}))))
local cfg = makeGroup(left, (_V9({208,178,153,215,218,19,201})))
if not ConfigManager.isSupported() then
makeLabel(cfg, (_V9({192,169,150,197,198,7})), (_V9({198,179,132,196,195,4,213,191,2,246,185})))
return
end
local nameBox = makeTextBox(cfg, (_V9({240,178,153,215,218,19,154,163,23,254,184,21,49,21})))
local listHolder = newInstance((_V9({213,175,150,220,214})), {
Parent = cfg,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
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
if not child:IsA((_V9({198,148,187,216,192,0,246,172,15,252,168,131}))) then
child:Destroy()
end
end
local names = ConfigManager.list()
if #names == 0 then
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
Parent = listHolder,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({253,178,215,194,210,2,223,169,86,240,178,153,215,218,19,201})),
})
return
end
for i, name in ipairs(names) do
local selected = (nameBox.Text == name)
local row = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
Text = (_V9({179,253})) .. name,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = row, CornerRadius = UDim.new(0, 4) })
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
makeButton(cfg, (_V9({192,188,129,212})), function()
local ok, res = ConfigManager.save(nameBox.Text, config)
if ok then
UI:Notify((_V9({192,188,129,212,215,84,217,162,24,245,180,144,145,148})) .. res .. (_V9({180})), 2)
refreshList()
else
UI:Notify(tostring(res), 3)
end
end)
makeButton(cfg, (_V9({223,178,150,213})), function()
local ok, res = ConfigManager.load(nameBox.Text, config)
if ok then
if windowScale then
windowScale.Scale = config.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({223,178,150,213,214,16,154,174,25,253,187,158,214,147,83})) .. res .. (_V9({180})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
makeButton(cfg, (_V9({215,184,155,212,199,17})), function()
local ok, res = ConfigManager.delete(nameBox.Text)
if ok then
UI:Notify((_V9({215,184,155,212,199,17,222,237,21,252,179,145,216,212,84,157})) .. res .. (_V9({180})), 2)
nameBox.Text = (_V9({}))
refreshList()
else
UI:Notify(tostring(res), 3)
end
end, COLORS.danger)
refreshList()
end
local function buildTargetPanel(config)
targetPanel = newInstance((_V9({213,175,150,220,214})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = targetPanel, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = targetPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = targetPanel,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
Parent = targetPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local dot = newInstance((_V9({213,175,150,220,214})), {
Parent = targetPanel,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
fpsPanel = newInstance((_V9({213,175,150,220,214})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = fpsPanel, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = fpsPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = fpsPanel,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
Parent = fpsPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local dot = newInstance((_V9({213,175,150,220,214})), {
Parent = fpsPanel,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
fpsLabel = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
Text = (_V9({190,240,215,215,195,7})),
})
table.insert(syncHandlers, function()
if fpsPanel then
fpsPanel.Visible = config.UI.FPSCounter
end
end)
fpsPanel.Visible = config.UI.FPSCounter
end
local function buildWatermark(config)
watermark = newInstance((_V9({218,176,150,214,214,56,219,175,19,255})), {
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
keybindPanel = newInstance((_V9({213,175,150,220,214})), {
Parent = gui,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = COLORS.bg,
BorderSizePixel = 0,
Visible = false,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = keybindPanel, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = keybindPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), {
Parent = keybindPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = keybindPanel,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = newInstance((_V9({213,175,150,220,214})), {
Parent = keybindPanel,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({216,184,142,211,218,26,222,190})),
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
makeKeybind(keybindPanel, (_V9({222,184,153,196})), function()
return config.UI.MenuKey
end, function(key)
config.UI.MenuKey = key
end, function(key)
return keyConflict(config, key, (_V9({254,184,153,196})))
end)
makeKeybind(keybindPanel, (_V9({210,180,154,211,220,0})), function()
return config.Camera.ToggleKey
end, function(key)
config.Camera.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({242,180,154,211,220,0})))
end)
makeKeybind(keybindPanel, (_V9({214,142,167})), function()
return config.ESP.ToggleKey
end, function(key)
config.ESP.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({246,174,135})))
end)
makeKeybind(keybindPanel, (_V9({213,146,161,145,240,29,200,174,26,246})), function()
return config.Camera.FOVCircleKey
end, function(key)
config.Camera.FOVCircleKey = key
end, function(key)
return keyConflict(config, key, (_V9({245,178,129,210,218,6,217,161,19})))
end)
makeKeybind(keybindPanel, (_V9({221,178,215,227,214,23,213,164,26})), function()
return config.NoRecoil.ToggleKey
end, function(key)
config.NoRecoil.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({253,178,133,212,208,27,211,161})))
end)
makeKeybind(keybindPanel, (_V9({221,178,215,226,195,6,223,172,18})), function()
return config.NoSpread.ToggleKey
end, function(key)
config.NoSpread.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({253,178,132,193,193,17,219,169})))
end)
makeKeybind(keybindPanel, (_V9({199,175,158,214,212,17,200,175,25,231})), function()
return config.Triggerbot.ToggleKey
end, function(key)
config.Triggerbot.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({231,175,158,214,212,17,200,175,25,231})))
end)
makeKeybind(keybindPanel, (_V9({198,179,155,222,210,16})), function()
return config.UI.UnloadKey
end, function(key)
config.UI.UnloadKey = key
end, function(key)
return keyConflict(config, key, (_V9({230,179,155,222,210,16})))
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
gui = newInstance((_V9({192,190,133,212,214,26,253,184,31})), {
Name = (_V9({197,188,153,216,199,13,253,168,24,246,175,150,221,230,61})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local ok = pcall(function()
gui.Parent = getGuiParent()
end)
if not ok or not gui.Parent then
gui.Parent = LocalPlayer:WaitForChild((_V9({195,177,150,200,214,6,253,184,31})))
end
mainWindow = newInstance((_V9({208,188,153,199,210,7,253,191,25,230,173})), {
Parent = gui,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = COLORS.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
windowScale = newInstance((_V9({198,148,164,210,210,24,223})), { Parent = mainWindow, Scale = config.UI.Scale })
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
local titleBar = newInstance((_V9({213,175,150,220,214})), {
Parent = mainWindow,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = titleBar, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({213,175,150,220,214})), {
Parent = titleBar,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
local dot = newInstance((_V9({213,175,150,220,214})), {
Parent = titleBar,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
Parent = titleBar,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({197,188,153,216,199,13,134,171,25,253,169,215,210,220,24,213,191,75,177,254,207,133,128,49,248,136,84,173,243,147,212,197,72,149,171,25,253,169,201,145,244,17,212,168,4,242,177}))
.. (_V9({175,187,152,223,199,84,217,162,26,252,175,202,147,144,76,251,250,53,210,237,213,143,147,84,154,15,193,179,253,215,199,131,72,149,171,25,253,169,201})),
ZIndex = 2,
})
newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
local sidebar = newInstance((_V9({213,175,150,220,214})), {
Parent = mainWindow,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = sidebar, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = sidebar, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = sidebar,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local tabList = newInstance((_V9({213,175,150,220,214})), {
Parent = sidebar,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,187,216,192,0,246,172,15,252,168,131})), { Parent = tabList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local unloadBtn = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
Text = (_V9({198,179,155,222,210,16})),
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = unloadBtn, CornerRadius = UDim.new(0, 6) })
local unloadStroke = newInstance((_V9({198,148,164,197,193,27,209,168})), {
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
local content = newInstance((_V9({213,175,150,220,214})), {
Parent = mainWindow,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({198,148,167,208,215,16,211,163,17})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local tabs = { (_V9({208,178,154,211,210,0})), (_V9({197,180,132,196,210,24})), (_V9({192,184,131,197,218,26,221,190})) }
local tabFrames = {}
for i, tabName in ipairs(tabs) do
local isActive = currentTab == tabName
local tabBtn = newInstance((_V9({199,184,143,197,241,1,206,185,25,253})), {
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
Text = (_V9({179,253,215,145})) .. tabName,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = tabBtn, CornerRadius = UDim.new(0, 6) })
local stripe = newInstance((_V9({213,175,150,220,214})), {
Parent = tabBtn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
Visible = isActive,
ZIndex = 2,
})
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local tabFrame = newInstance((_V9({213,175,150,220,214})), {
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
buildCameraTab(tabFrames[(_V9({208,178,154,211,210,0}))].frame, config)
buildESPTab(tabFrames[(_V9({197,180,132,196,210,24}))].frame, config)
buildSettingsTab(tabFrames[(_V9({192,184,131,197,218,26,221,190}))].frame, config)
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
if name and name ~= (_V9({})) and name ~= (_V9({221,178,153,212})) then
shown, colour = name, (_V9({176,229,195,130,246,54,255}))
else
shown, colour = (_V9({198,179,188,223,220,3,212})), (_V9({176,229,182,134,240,53,138}))
end
local text = (_V9({199,188,133,214,214,0,128,237,74,245,178,153,197,147,23,213,161,25,225,224,213})) .. colour .. (_V9({177,227})) .. shown .. (_V9({175,242,145,222,221,0,132}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(fps)
if not fpsLabel or not fpsPanel or not fpsPanel.Visible then
return
end
local text = string.format((_V9({175,187,152,223,199,84,217,162,26,252,175,202,147,144,76,142,254,51,209,152,213,143,150,16,134,226,16,252,179,131,143,147,18,202,190})), fps or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(id)
if not watermark then
return
end
local digits = tostring(id or (_V9({}))):match((_V9({182,185,220})))
watermark.Image = digits and ((_V9({225,191,143,208,192,7,223,185,31,247,231,216,158})) .. digits) or (_V9({}))
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
local toast = newInstance((_V9({199,184,143,197,255,21,216,168,26})), {
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
newInstance((_V9({198,148,180,222,193,26,223,191})), { Parent = toast, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({198,148,164,197,193,27,209,168})), { Parent = toast, Color = COLORS.accent, Thickness = 1, Transparency = 0.3 })
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
VanityGeneral.Version = (_V9({163}))
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
if type(fn) == (_V9({245,168,153,210,199,29,213,163})) then
return fn
end
end
return nil
end
local function resolveWebhookUrl()
if webhookViaManager then
local url = VanityGeneral.Secrets:get((_V9({228,184,149,217,220,27,209,146,3,225,177})))
if url then
return url
end
end
if #WEBHOOK_CIPHER > 0 then
if DebuggerDetection.IsBeingDebugged() then
DebuggerDetection.HandleTamperingAttempt((_V9({228,184,149,217,220,27,209,146,4,246,171,146,208,223,43,205,165,31,255,184,168,213,214,22,207,170,17,246,185})), (_V9({228,184,149,217,220,27,209})))
return nil
end
return StringObfuscation.decrypt(WEBHOOK_CIPHER, WEBHOOK_LEVEL)
end
return nil
end
function VanityGeneral.SetWebhook(url, level)
VanityGeneral.Secrets:clear((_V9({228,184,149,217,220,27,209,146,3,225,177})))
VanityGeneral.Secrets:register((_V9({228,184,149,217,220,27,209,146,3,225,177})), url, level or WEBHOOK_LEVEL)
webhookViaManager = true
return true
end
function VanityGeneral.EncryptWebhook(url, level)
level = level or WEBHOOK_LEVEL
local bytes = StringObfuscation.encrypt(url, level)
print(string.format((_V9({190,240,215,225,210,7,206,168,86,231,181,146,145,199,3,213,237,26,250,179,146,194,147,22,223,161,25,228,253,158,223,199,27,154,185,30,246,253,164,244,240,33,232,136,86,196,152,181,249,252,59,241,237,21,252,179,145,216,212,84,146,161,19,229,184,155,145,150,16,147,247})), level))
print(string.format((_V9({255,178,148,208,223,84,237,136,52,219,146,184,250,236,56,255,155,51,223,253,202,145,150,16})), level))
print((_V9({255,178,148,208,223,84,237,136,52,219,146,184,250,236,55,243,157,62,214,143,215,140,147,15,154})) .. table.concat(bytes, (_V9({191,253}))) .. (_V9({179,160})))
return bytes
end
function VanityGeneral.HasWebhook()
return webhookViaManager or #WEBHOOK_CIPHER > 0
end
function VanityGeneral.SendWebhook(content, opts)
opts = opts or {}
local url = resolveWebhookUrl()
if not url then
return false, (_V9({253,178,168,198,214,22,210,162,25,248,130,152,195,236,22,214,162,21,248,184,147}))
end
local req = resolveHttpRequest()
if not req then
warn((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,56,252,253,191,229,231,36,154,191,19,226,168,146,194,199,84,220,184,24,240,169,158,222,221,84,219,187,23,250,177,150,211,223,17,154,164,24,179,169,159,216,192,84,223,181,19,240,168,131,222,193})))
return false, (_V9({253,178,168,217,199,0,202}))
end
local payload = {
username = opts.username or (_V9({197,188,153,216,199,13,151,138,19,253,184,133,208,223})),
avatar_url = opts.avatar_url,
content = content,
embeds = opts.embeds,
}
local ok, err = pcall(function()
local body = game:GetService((_V9({219,169,131,193,224,17,200,187,31,240,184}))):JSONEncode(payload)
return req({
Url = url,
Method = (_V9({195,146,164,229})),
Headers = { [(_V9({208,178,153,197,214,26,206,224,34,234,173,146}))] = (_V9({242,173,135,221,218,23,219,185,31,252,179,216,219,192,27,212})) },
Body = body,
})
end)
url = nil
if not ok then
warn((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,33,246,191,159,222,220,31,154,190,19,253,185,215,215,210,29,214,168,18,169})), err)
return false, err
end
return true
end
function VanityGeneral.SendLoadedEmbed(isDebugged)
local placeName = (_V9({172}))
pcall(function()
placeName = game:GetService((_V9({222,188,133,218,214,0,202,161,23,240,184,164,212,193,2,211,174,19}))):GetProductInfo(game.PlaceId).Name
end)
return VanityGeneral.SendWebhook(nil, {
embeds = {
{
title = (_V9({197,188,153,216,199,13,148,169,19,229,253,176,212,221,17,200,172,26,179,177,152,208,215,17,222})),
color = 8666558,
fields = {
{ name = (_V9({195,177,150,200,214,6})), value = (_V9({243})) .. (LocalPlayer and LocalPlayer.Name or (_V9({172}))) .. (_V9({243})), inline = true },
{ name = (_V9({197,184,133,194,218,27,212})), value = (_V9({243,171})) .. tostring(VanityGeneral.Version) .. (_V9({243})), inline = true },
{ name = (_V9({212,188,154,212})), value = placeName, inline = false },
{ name = (_V9({195,177,150,210,214,61,222})), value = (_V9({243})) .. tostring(game.PlaceId) .. (_V9({243})), inline = true },
{ name = (_V9({215,184,149,196,212,19,223,169})), value = (_V9({243})) .. tostring(isDebugged) .. (_V9({243})), inline = true },
},
footer = { text = os.date((_V9({182,132,218,148,222,89,159,169,86,182,149,205,148,254,78,159,158}))) },
},
},
})
end
local running = false
local connections = {}
local aimbotSteering = false
local RECOIL_BIND = (_V9({197,188,153,216,199,13,253,168,24,246,175,150,221,225,17,217,162,31,255}))
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
warn(string.format((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,83,224,253,145,208,218,24,223,169,86,187,165,210,213,154,78,154,232,5})), name, st.failures, tostring(res)))
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
warn((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,50,246,191,130,214,147,17,212,187,31,225,178,153,220,214,26,206,237,18,246,169,146,210,199,17,222,237,23,231,253,132,197,210,6,206,184,6,179,63,119,37,147,4,200,162,2,246,190,131,212,215,84,201,168,21,225,184,131,194,147,3,211,161,26,179,175,146,215,198,7,223,237,2,252,253,133,212,197,17,219,161,86,230,179,131,216,223,84,219,161,26,252,170,168,216,221,43,201,185,3,247,180,152,145,218,7,154,190,19,231,243})))
end
running = true
local ok, err = pcall(function()
ESP:Init()
UI:Init(Configuration)
table.insert(connections, Players.PlayerAdded:Connect(function(player)
guarded((_V9({195,177,150,200,214,6,251,169,18,246,185})), ESP.OnPlayerAdded, ESP, player)
end))
table.insert(connections, Players.PlayerRemoving:Connect(function(player)
guarded((_V9({195,177,150,200,214,6,232,168,27,252,171,158,223,212})), ESP.OnPlayerRemoving, ESP, player)
end))
table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed or UI:IsCapturingKey() then
return
end
guarded((_V9({216,184,142,211,218,26,222,190})), function()
local key = input.KeyCode
if key == Configuration.UI.MenuKey then
UI:Toggle()
elseif key == Configuration.UI.UnloadKey then
VanityGeneral.Stop()
else
local toggles = {
{ Configuration.Camera, (_V9({214,179,150,211,223,17,222})), Configuration.Camera.ToggleKey },
{ Configuration.ESP, (_V9({214,179,150,211,223,17,222})), Configuration.ESP.ToggleKey },
{ Configuration.Camera, (_V9({213,146,161,242,218,6,217,161,19})), Configuration.Camera.FOVCircleKey },
{ Configuration.NoRecoil, (_V9({214,179,150,211,223,17,222})), Configuration.NoRecoil.ToggleKey },
{ Configuration.NoSpread, (_V9({214,179,150,211,223,17,222})), Configuration.NoSpread.ToggleKey },
{ Configuration.Triggerbot, (_V9({214,179,150,211,223,17,222})), Configuration.Triggerbot.ToggleKey },
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
guarded((_V9({214,142,167})), ESP.Update, ESP, Configuration.ESP)
local okAim, target = guarded((_V9({210,180,154,211,220,0})), CameraDirector.Update, CameraDirector, Configuration.Camera, Configuration.Debug)
if not okAim then
target = nil
end
if Configuration.UI.TargetDisplay then
guarded((_V9({199,188,133,214,214,0,154,169,31,224,173,155,208,202})), function()
local looking = CameraDirector:GetLookTarget(Configuration.ESP, Configuration.Camera)
UI:SetCurrentTarget(looking and looking.Name or nil)
end)
end
aimbotSteering = Configuration.Camera.Enabled and target ~= nil
guarded((_V9({221,178,164,193,193,17,219,169})), NoSpread.Update, NoSpread, Configuration.NoSpread)
guarded((_V9({199,175,158,214,212,17,200,175,25,231})), Triggerbot.Update, Triggerbot, Configuration.Triggerbot, Configuration.Camera)
fpsAccum = fpsAccum + dt
fpsFrames = fpsFrames + 1
if fpsAccum >= 0.25 then
local fps = math.floor(fpsFrames / fpsAccum + 0.5)
fpsAccum, fpsFrames = 0, 0
if Configuration.UI.FPSCounter then
guarded((_V9({213,141,164,145,208,27,207,163,2,246,175})), UI.UpdateFPS, UI, fps)
end
end
end))
pcall(function()
RunService:UnbindFromRenderStep(RECOIL_BIND)
end)
pcall(function()
RunService:BindToRenderStep(RECOIL_BIND, Enum.RenderPriority.Camera.Value + 1, function()
guarded((_V9({221,178,165,212,208,27,211,161})), NoRecoil.Update, NoRecoil, Configuration.NoRecoil, aimbotSteering)
end)
end)
end)
if not ok then
warn((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,48,242,180,155,212,215,84,206,162,86,224,169,150,195,199,78})), err)
VanityGeneral.Stop()
return VanityGeneral
end
UI:Notify(string.format((_V9({197,188,153,216,199,13,151,138,19,253,184,133,208,223,84,214,162,23,247,184,147,145,147,150,58,111,86,179,141,133,212,192,7,154,232,5})), Configuration.UI.MenuKey.Name), 4)
print(string.format((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,36,230,179,153,216,221,19,154,229,0,182,174,222})), VanityGeneral.Version))
print(string.format((_V9({179,253,21,49,17,84,233,185,4,250,179,144,254,209,18,207,190,21,242,169,158,222,221,84,204,232,5,179,245,150,210,199,29,204,168,95})), StringObfuscation.VERSION))
print(string.format((_V9({179,253,21,49,17,84,254,168,20,230,186,144,212,193,48,223,185,19,240,169,158,222,221,84,204,255,88,163,253,223,220,220,26,211,185,25,225,180,153,214,137,84,219,174,2,250,171,146,157,147,16,223,175,3,244,186,146,213,137,84,159,190,95})), tostring(securityState.is_debugged)))
print(string.format((_V9({179,253,21,49,17,84,234,191,25,231,184,148,197,214,16,233,168,21,225,184,131,194,147,2,159,190,86,187,139,150,223,218,0,195,138,19,253,184,133,208,223,90,233,168,21,225,184,131,194,147,19,219,185,19,247,253,149,200,147,16,223,175,3,244,186,146,195,147,16,223,185,19,240,169,158,222,221,93})), ProtectedSecrets.VERSION))
print(string.format((_V9({222,184,153,196,137,84,159,190,86,179,161,215,145,240,21,215,168,4,242,231,215,148,192,84,154,177,86,179,136,153,221,220,21,222,247,86,182,174})),
Configuration.UI.MenuKey.Name,
Configuration.Camera.ToggleKey.Name,
Configuration.UI.UnloadKey.Name))
if not VanityGeneral.HasWebhook() and type(WEBHOOK_URL) == (_V9({224,169,133,216,221,19})) and WEBHOOK_URL ~= (_V9({})) then
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
print((_V9({200,139,150,223,218,0,195,224,49,246,179,146,195,210,24,231,237,37,231,178,135,193,214,16})))
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
if previous and previous ~= VanityGeneral and type(previous.Stop) == (_V9({245,168,153,210,199,29,213,163})) then
pcall(previous.Stop)
end
getgenv().VanityGeneral = VanityGeneral
end
pcall(function()
VanityGeneral.Start()
end)
return VanityGeneral
