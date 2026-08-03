--==============================================================================
-- VANITY-GENERAL v0 - FULLY INTEGRATED BUILD
--
-- Complete system combining:
-- • DebuggerDetection v2.0 (anti-tampering, security monitoring)
-- • StringObfuscation v2.0 (multi-level encryption, secrets management)
-- • Configuration (centralized settings)
-- • CameraDirector (smooth aim tracking)
-- • ESP (player highlighting)
-- • UI (modern tabbed interface with keybind customization)
-- • MainController (unified lifecycle management)
--
-- Usage:
--   local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
--   VanityGeneral.Start()
--   -- VanityGeneral.Stop() to tear down
--   -- VanityGeneral.Toggle() to toggle start/stop
--
-- Keys: RightShift = menu | LeftAlt = camera tracking | End = unload
--==============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Forward-declared so UI callbacks (e.g. the Security tab's webhook button) can
-- reference the controller table. It's assigned (not re-declared) in the
-- CONTROLLER section at the bottom.
local VanityGeneral

--==============================================================================
-- STRING OBFUSCATION v2.0
-- Advanced string encryption/obfuscation system with multi-level encryption,
-- secret objects, secret manager, vault system, audit logging, and statistics.
--==============================================================================

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
	name = name or ("secret_" .. tostring({}):match("0x%x+"))
	local encrypted = StringObfuscation.encrypt(str, level)
	local hash = _simpleHash(str)

	_addAuditEntry("secret_created", name, { level = level })
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
		secret._decrypted = nil
		secret._cleared = true
		_addAuditEntry("secret_cleared", secret._name, {})
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
	if type(secret) == "table" and secret._encrypted then
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
		if self._password.value == provided_password then
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

--==============================================================================
-- DEBUGGER DETECTION v2.0
-- Enterprise-grade defensive measures for detecting tampering and debugging.
--==============================================================================

local DebuggerDetection = {}
local DebugAuditLog = {}
local DebugStatistics = {
	detections = 0,
	checks_performed = 0,
	tampering_attempts = 0,
	total_check_time_ms = 0,
}
local DebugMonitoringActive = false
local DebugMonitorConnection = nil -- Heartbeat monitor; disconnected on unload

function DebuggerDetection.IsRunningInStudio()
	return game:GetService("RunService"):IsStudio()
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
		return nil, "source_unavailable"
	end

	local hash = tostring(#current_source) .. ":" .. string.sub(current_source, 1, 50)
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
		details = details or "",
		timestamp = tick(),
		time_string = os.date("%Y-%m-%d %H:%M:%S", tick()),
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
	print("\n=== Debugger Detection Statistics ===")
	print("Detections: " .. stats.detections)
	print("Checks Performed: " .. stats.checks_performed)
	print("Tampering Attempts: " .. stats.tampering_attempts)
	print("Total Check Time: " .. string.format("%.2f", stats.total_check_time_ms) .. "ms")
	print("Audit Log Entries: " .. stats.audit_log_entries)
	print("=====================================\n")
end

function DebuggerDetection.HandleDebuggerState(debugged)
	if debugged then
		DebugStatistics.detections = DebugStatistics.detections + 1
		DebugLogAuditEvent("debugger_detected", "Debug environment detected")
		warn("[Security] Debugger detected — running in production-safe mode.")
		return {
			safe_mode = true,
			reduced_logging = true,
			skip_sensitive_ops = true,
			detected_at = tick(),
		}
	else
		DebugLogAuditEvent("normal_execution", "No debugger detected")
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
	DebugLogAuditEvent("tampering_attempt", attempt_type .. ": " .. tostring(details))
	warn("[Security Alert] Tampering attempt detected: " .. attempt_type)
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

	-- Stored so Stop() can disconnect it. Previously this Heartbeat connection was
	-- never kept, so it kept running every frame forever after an Unload.
	DebugMonitorConnection = RunService.Heartbeat:Connect(CheckDebugState)
	DebugLogAuditEvent("monitoring_started", "Real-time debug monitoring activated")

	return CheckDebugState
end

-- Disconnects the Heartbeat monitor so unloading leaves nothing running.
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
		DebuggerDetection.HandleTamperingAttempt("secure_execution_in_debug", "Attempted execution in debug mode")
		return nil
	end

	local success, result = pcall(callback)

	if not success then
		DebugLogAuditEvent("execution_failed", tostring(result))
		warn("[Security] Secure execution failed: " .. tostring(result))
		return nil
	end

	DebugLogAuditEvent("execution_success", "Secure code executed successfully")
	return result
end

function DebuggerDetection.VerifyIntegrity()
	local state = {
		in_studio = DebuggerDetection.IsRunningInStudio(),
		debugger_attached = DebuggerDetection.IsDebuggerAttached(),
		environment_compromised = DebuggerDetection.IsEnvironmentCompromised(),
		timestamp = tick(),
		time_string = os.date("%Y-%m-%d %H:%M:%S", tick()),
	}

	DebugLogAuditEvent("integrity_check", state.debugger_attached and "COMPROMISED" or "OK")
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

	DebugLogAuditEvent("system_initialized", "DebuggerDetection v2.0 initialized")
	return state
end

--==============================================================================
-- PROTECTED SECRETS v1.0
-- Integration layer that wires DebuggerDetection into StringObfuscation.
--
-- Secrets are still encrypted/decrypted by StringObfuscation, but any operation
-- that would REVEAL a plaintext value (reveal / manager:get / vault:unlock /
-- vault:retrieve) is first gated by DebuggerDetection. When a debug environment
-- is detected the operation is blocked and logged as a tampering attempt, so
-- sensitive values are never decrypted while a debugger is watching.
--
-- By default a debug environment is Roblox Studio. Because that would also
-- block normal development, every entry point accepts
-- `{ allow_in_studio = true }` to opt out of the gate while iterating.
--==============================================================================

local ProtectedSecrets = { VERSION = "1.0" }

-- Returns true when reveal-style operations should be refused.
local function _secretsBlocked(allowInStudio)
	if allowInStudio then
		return false
	end
	return DebuggerDetection.IsBeingDebugged()
end

-- ==================== DIRECT SECRETS ====================

function ProtectedSecrets.makeSecret(str, name, level)
	return StringObfuscation.makeSecret(str, name, level)
end

-- Reveal a secret's plaintext, gated by debugger detection.
function ProtectedSecrets.reveal(secret, opts)
	opts = opts or {}
	if _secretsBlocked(opts.allow_in_studio) then
		DebuggerDetection.HandleTamperingAttempt(
			"reveal_while_debugged",
			secret and secret.name or "unknown"
		)
		return nil
	end
	return StringObfuscation.revealSecret(secret)
end

-- ==================== PROTECTED SECRET MANAGER ====================

-- Wraps StringObfuscation.createSecretManager; :get / :getSecret are gated.
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
			DebuggerDetection.HandleTamperingAttempt("secret_get_while_debugged", name)
			return nil
		end
		return inner:get(name)
	end

	function manager:getSecret(name)
		if _secretsBlocked(allowInStudio) then
			DebuggerDetection.HandleTamperingAttempt("secret_object_while_debugged", name)
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

-- ==================== SECURE VAULT ====================

-- Wraps StringObfuscation.createVault; unlock / retrieve / getSecret are gated
-- so a locked vault cannot be opened while a debugger is attached.
function ProtectedSecrets.createSecureVault(password, opts)
	opts = opts or {}
	local allowInStudio = opts.allow_in_studio == true
	local inner = StringObfuscation.createVault(password)

	local vault = {}

	function vault:unlock(providedPassword)
		if _secretsBlocked(allowInStudio) then
			DebuggerDetection.HandleTamperingAttempt("vault_unlock_while_debugged", "vault")
			return false
		end
		return inner:unlock(providedPassword)
	end

	function vault:retrieve(name)
		if _secretsBlocked(allowInStudio) then
			DebuggerDetection.HandleTamperingAttempt("vault_retrieve_while_debugged", name)
			return nil
		end
		return inner:retrieve(name)
	end

	function vault:getSecret(name)
		if _secretsBlocked(allowInStudio) then
			DebuggerDetection.HandleTamperingAttempt("vault_secret_while_debugged", name)
			return nil
		end
		return inner:getSecret(name)
	end

	-- Storing ciphertext and lifecycle ops don't leak plaintext, so pass through.
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

-- ==================== REPORTING ====================

-- Merges statistics from both subsystems into one report.
function ProtectedSecrets.getReport()
	return {
		obfuscation = StringObfuscation.getStats(),
		detection = DebuggerDetection.GetStats(),
		is_debugged = DebuggerDetection.IsBeingDebugged(),
		timestamp = os.time(),
	}
end

-- ==================== INITIALIZATION ====================

-- Boots DebuggerDetection with the given options and returns a combined report.
-- MainController's Start() calls this (not DebuggerDetection.Initialize
-- directly) so startup gets both monitoring armed and the merged
-- obfuscation+detection report in one call.
function ProtectedSecrets.initialize(opts)
	opts = opts or {}

	DebuggerDetection.Initialize({
		enable_monitoring = opts.enable_monitoring ~= false,
		enable_continuous_verification = opts.enable_continuous_verification,
		verification_interval = opts.verification_interval,
	})

	return ProtectedSecrets.getReport()
end

-- Tears down anything initialize() started, so unloading leaves nothing running.
function ProtectedSecrets.shutdown()
	DebuggerDetection.StopMonitoring()
end

-- Exploit-friendly GUI parent: prefer a hidden container, then CoreGui, then PlayerGui.
local function getGuiParent()
	local ok, hidden = pcall(function()
		return gethui and gethui()
	end)
	if ok and hidden then
		return hidden
	end

	local ok2, coreGui = pcall(function()
		return game:GetService("CoreGui")
	end)
	if ok2 and coreGui then
		return coreGui
	end

	return LocalPlayer:WaitForChild("PlayerGui")
end

--==============================================================================
-- CONFIGURATION
-- Centralized settings and single source of truth.
--==============================================================================

local Configuration = {}

Configuration.Camera = {
	Enabled = false,
	-- LOWER = harder/snappier lock, HIGHER = slower, smoother follow.
	Smoothness = 0.85,
	-- Targeting cone radius in PIXELS from the crosshair (what the FOV circle draws).
	FOV = 200,
	-- World range limit in studs from your character.
	MaxDistance = 1000,

	-- Hitbox mode: "Random (Weighted)" uses TargetWeights below; otherwise a
	-- specific region ("Head" / "Torso" / "Arms" / "Legs") is aimed at directly.
	Hitbox = "Random (Weighted)",
	HitboxOptions = { "Random (Weighted)", "Head", "Torso", "Arms", "Legs" },

	-- 0-100 chance weights per body region, used only in Random (Weighted) mode.
	-- They don't need to sum to 100 — they're relative.
	TargetWeights = {
		Head = 85,
		Torso = 15,
		Arms = 0,
		Legs = 0,
	},

	WallCheck = true,     -- require line of sight to the target
	StickyTarget = false, -- keep the current target until it dies / leaves / exits FOV
	TargetBots = false,   -- also target NPCs (non-player models with a Humanoid)
	TeamCheck = true,     -- never target players on your own team
	FOVCircle = false,    -- draw the targeting radius on screen

	ToggleKey = Enum.KeyCode.LeftAlt,
	FOVCircleKey = Enum.KeyCode.F1,
}

Configuration.NoRecoil = {
	Enabled = false,
	-- 0..1 hold strength (1 = fully locked to where you started firing).
	Strength = 1,
	-- Only lock while the fire button (LMB) is held.
	RequireMouseDown = true,
	-- Still allow pulling the aim downward while firing (climb stays blocked).
	AllowAim = false,
	ToggleKey = Enum.KeyCode.F2,
}

Configuration.NoSpread = {
	Enabled = false,
	-- 0..1 how far each spread roll is pulled toward centre. 1 = dead centre
	-- (no spread at all), 0.5 = half the cone, 0 = untouched.
	Strength = 1,
	-- Only suppress spread rolls while the fire button (LMB) is held. Leaving this
	-- on keeps the rest of the game's randomness untouched except while shooting.
	RequireMouseDown = true,
	ToggleKey = Enum.KeyCode.F3,
}

Configuration.Triggerbot = {
	Enabled = false,
	Delay = 0.05,       -- seconds the crosshair must sit on a target before firing
	MaxDistance = 1000, -- studs; shots past this are ignored
	WallCheck = true,   -- "Vischeck": require line of sight (off = fire through walls)
	ToggleKey = Enum.KeyCode.F4,
}

Configuration.ESP = {
	Enabled = false,
	-- Render styles; independent, so any combination can be on at once.
	Outlines = true, -- Highlight silhouette
	Boxes = false,   -- 2D screen-space box
	Names = false,   -- player name floating above the head
	Distance = false, -- meters from your character, under the name
	NPCs = false,    -- also highlight non-player characters (mobs/dummies)
	OutlineColor = Color3.fromRGB(165, 75, 255),
	FillColor = Color3.fromRGB(165, 75, 255),
	Filled = false,
	OutlineOpacity = 1,
	FillOpacity = 0.4,
	MaxDistance = 1000,
	ToggleKey = Enum.KeyCode.RightAlt, -- keybind for toggling ESP, like the aimbot
}

Configuration.UI = {
	Scale = 1,
	MenuKey = Enum.KeyCode.RightShift,
	UnloadKey = Enum.KeyCode.End,
	Visible = false, -- the menu itself; opened with MenuKey, not an Interface toggle
	-- Interface overlays all start ON.
	KeybindPanel = true,  -- standalone keybind window
	TargetDisplay = true, -- popup naming whoever you're looking at
	FPSCounter = true,    -- bottom-right fps readout
	Watermark = true,     -- bottom-left watermark logo
	-- Uploaded image id for the watermark logo. Leave "" to hide it.
	-- This is the IMAGE id (a Decal id renders as nothing) — resolved from
	-- decal 123653124904094 via InsertService:LoadAsset -> Decal.Texture.
	WatermarkImageId = "139845693858856",
}

Configuration.Debug = false

local DEFAULTS = {
	Camera = {
		Enabled = false,
		Smoothness = 0.85,
		FOV = 200,
		MaxDistance = 1000,
		Hitbox = "Random (Weighted)",
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
			if type(value) == "table" then
				-- Copy nested defaults (e.g. TargetWeights) into the existing table
				-- so we never alias the DEFAULTS table itself.
				local target = Configuration[section][key]
				if type(target) ~= "table" then
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

--==============================================================================
-- CONFIG MANAGER
-- Saves/loads the whole Configuration to the executor's filesystem as JSON, so
-- settings survive between sessions. Color3 and EnumItem (keybinds) can't be
-- represented in JSON, so they're tagged and rebuilt on load.
--==============================================================================

local ConfigManager = {}
local CONFIG_FOLDER = "VanityGeneral"
local SAVED_SECTIONS = { "Camera", "ESP", "NoRecoil", "NoSpread", "UI" }

-- Executors vary in what file APIs they expose; everything degrades gracefully.
local function fsAvailable()
	return type(writefile) == "function"
		and type(readfile) == "function"
		and type(listfiles) == "function"
end

local function ensureFolder()
	if type(isfolder) == "function" and type(makefolder) == "function" then
		if not isfolder(CONFIG_FOLDER) then
			pcall(makefolder, CONFIG_FOLDER)
		end
	end
end

-- Strips anything that could break a file path.
local function sanitizeName(name)
	return (tostring(name or ""):gsub("[^%w_%- ]", ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function pathFor(name)
	return CONFIG_FOLDER .. "/" .. name .. ".json"
end

local function encodeValue(v)
	local t = typeof(v)
	if t == "Color3" then
		return { __t = "Color3", r = v.R, g = v.G, b = v.B }
	elseif t == "EnumItem" then
		return { __t = "Enum", e = tostring(v.EnumType), n = v.Name }
	elseif t == "table" then
		local out = {}
		for k, val in pairs(v) do
			if type(val) ~= "function" then
				local enc = encodeValue(val)
				if enc ~= nil then
					out[k] = enc
				end
			end
		end
		return out
	elseif t == "number" or t == "string" or t == "boolean" then
		return v
	end
	return nil -- functions, Instances, anything else: not persisted
end

local function decodeValue(v)
	if type(v) ~= "table" then
		return v
	end
	if v.__t == "Color3" then
		return Color3.new(v.r or 0, v.g or 0, v.b or 0)
	end
	if v.__t == "Enum" then
		local ok, item = pcall(function()
			return Enum[v.e][v.n]
		end)
		if ok then
			return item
		end
		return nil -- unknown key: leave the existing bind alone
	end
	return v
end

-- Copies decoded values into the live tables in place, so every closure that
-- captured a config table keeps working.
local function applyInto(target, src)
	for k, v in pairs(src) do
		if type(v) == "table" and v.__t == nil then
			if type(target[k]) == "table" then
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
	if not ok or type(files) ~= "table" then
		return out
	end

	for _, path in ipairs(files) do
		local name = tostring(path):match("([^/\\]+)%.json$")
		if name then
			table.insert(out, name)
		end
	end
	table.sort(out)
	return out
end

function ConfigManager.save(name, config)
	if not fsAvailable() then
		return false, "This executor has no file API"
	end

	name = sanitizeName(name)
	if name == "" then
		return false, "Enter a config name"
	end

	ensureFolder()

	local data = {}
	for _, section in ipairs(SAVED_SECTIONS) do
		if type(config[section]) == "table" then
			data[section] = encodeValue(config[section])
		end
	end

	local okJson, json = pcall(function()
		return game:GetService("HttpService"):JSONEncode(data)
	end)
	if not okJson then
		return false, "Encode failed: " .. tostring(json)
	end

	local okWrite, err = pcall(writefile, pathFor(name), json)
	if not okWrite then
		return false, "Write failed: " .. tostring(err)
	end
	return true, name
end

function ConfigManager.load(name, config)
	if not fsAvailable() then
		return false, "This executor has no file API"
	end

	name = sanitizeName(name)
	if name == "" then
		return false, "Enter a config name"
	end

	local path = pathFor(name)
	if type(isfile) == "function" then
		local okIs, exists = pcall(isfile, path)
		if okIs and not exists then
			return false, "No config named '" .. name .. "'"
		end
	end

	local okRead, raw = pcall(readfile, path)
	if not okRead or type(raw) ~= "string" then
		return false, "Read failed"
	end

	local okJson, data = pcall(function()
		return game:GetService("HttpService"):JSONDecode(raw)
	end)
	if not okJson or type(data) ~= "table" then
		return false, "That file isn't valid JSON"
	end

	for _, section in ipairs(SAVED_SECTIONS) do
		if type(data[section]) == "table" and type(config[section]) == "table" then
			applyInto(config[section], data[section])
		end
	end
	return true, name
end

function ConfigManager.delete(name)
	name = sanitizeName(name)
	if name == "" then
		return false, "Enter a config name"
	end
	if type(delfile) ~= "function" then
		return false, "This executor can't delete files"
	end

	local ok, err = pcall(delfile, pathFor(name))
	if not ok then
		return false, tostring(err)
	end
	return true, name
end

--==============================================================================
-- CAMERA DIRECTOR
-- Smooth camera tracking toward prioritized, visible, alive targets.
--==============================================================================

local CameraDirector = {}
local Camera = Workspace.CurrentCamera

-- Body regions map to the actual part names each rig type uses. Targeting picks a
-- region (a fixed one, or a weighted-random roll), then the first part that region
-- actually has on the target's character — so it works on both R15 and R6.
local REGION_PARTS = {
	Head = { "Head" },
	Torso = { "UpperTorso", "LowerTorso", "Torso", "HumanoidRootPart" },
	Arms = {
		"LeftHand", "RightHand",
		"LeftLowerArm", "RightLowerArm",
		"LeftUpperArm", "RightUpperArm",
		"Left Arm", "Right Arm",
	},
	Legs = {
		"LeftFoot", "RightFoot",
		"LeftLowerLeg", "RightLowerLeg",
		"LeftUpperLeg", "RightUpperLeg",
		"Left Leg", "Right Leg",
	},
}
local REGION_ORDER = { "Head", "Torso", "Arms", "Legs" }

local rng = Random.new()

local function pickPartFromRegion(character, region)
	local names = REGION_PARTS[region]
	if not names then
		return nil
	end
	for _, name in ipairs(names) do
		local part = character:FindFirstChild(name)
		if part and part:IsA("BasePart") then
			return part
		end
	end
	return nil
end

-- First available part across all regions, then any BasePart as a last resort.
local function pickAnyPart(character)
	for _, region in ipairs(REGION_ORDER) do
		local part = pickPartFromRegion(character, region)
		if part then
			return part
		end
	end
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			return descendant
		end
	end
	return nil
end

-- Stable reference part used to decide WHICH character to target, so the choice of
-- character never jitters with the weighted aim-part roll.
local function anchorPart(character)
	return character:FindFirstChild("Head")
		or character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")
		or pickAnyPart(character)
end

-- Weighted-random region using the 0-100 weights. Falls back to Head when every
-- weight is zero so tracking still does something sensible.
local function rollWeightedRegion(weights)
	local total = 0
	for _, region in ipairs(REGION_ORDER) do
		total = total + math.max(0, (weights and weights[region]) or 0)
	end
	if total <= 0 then
		return "Head"
	end
	local roll = rng:NextNumber() * total
	local acc = 0
	for _, region in ipairs(REGION_ORDER) do
		acc = acc + math.max(0, weights[region] or 0)
		if roll <= acc then
			return region
		end
	end
	return "Head"
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

-- ===== FOV circle =============================================================
-- Drawn as a GUI ring instead of via the Drawing library. The old version checked
-- `type(Drawing) == "table"`, which is false on executors that expose Drawing as
-- userdata — so it silently never rendered. A ring works everywhere.
local FOV_RING_COLOR = Color3.fromRGB(132, 62, 190) -- matches the UI accent
local fovGui, fovRing, fovStroke

local function ensureFovRing()
	if fovRing and fovRing.Parent then
		return fovRing
	end

	fovGui = Instance.new("ScreenGui")
	fovGui.Name = "VanityGeneralFOV"
	fovGui.ResetOnSpawn = false
	fovGui.IgnoreGuiInset = true -- same space as Camera:WorldToViewportPoint
	fovGui.DisplayOrder = 998

	local ok = pcall(function()
		fovGui.Parent = getGuiParent()
	end)
	if not ok or not fovGui.Parent then
		fovGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	fovRing = Instance.new("Frame")
	fovRing.Name = "Ring"
	fovRing.AnchorPoint = Vector2.new(0.5, 0.5)
	fovRing.Position = UDim2.fromScale(0.5, 0.5)
	fovRing.BackgroundTransparency = 1
	fovRing.BorderSizePixel = 0
	fovRing.Parent = fovGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = fovRing

	fovStroke = Instance.new("UIStroke")
	fovStroke.Thickness = 1.5
	fovStroke.Transparency = 0.2
	fovStroke.Color = FOV_RING_COLOR
	fovStroke.Parent = fovRing

	return fovRing
end

-- Sized straight off config.FOV, so the ring always shows the real targeting cone.
local function updateFovCircle(config)
	-- Independent of the aimbot: the circle shows whenever FOV Circle is ticked,
	-- so you can see and tune the cone with the aimbot switched off.
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

-- Builds a target table for a character if it currently passes every filter,
-- else nil. `player` is nil for bot (NPC) targets, so target.Player needs a
-- nil-check downstream.
local function evaluateCharacter(character, player, config)
	if not character then
		return nil
	end

	-- Team Check: never target teammates. Teamless players (Team == nil) stay
	-- targetable; bots (player == nil) are unaffected.
	if config.TeamCheck and player and player.Team ~= nil and player.Team == LocalPlayer.Team then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return nil
	end

	local anchor = anchorPart(character)
	if not anchor then
		return nil
	end

	-- On-screen cone: how far from the crosshair the target may be, in pixels.
	local distance = getScreenDistance(anchor.Position)
	if distance >= (config.FOV or 200) then
		return nil
	end

	-- MaxDistance is a world-space range in studs (matches the UI's "m" label).
	local worldDistance = (anchor.Position - Camera.CFrame.Position).Magnitude
	if worldDistance > config.MaxDistance then
		return nil
	end

	if config.WallCheck and not isVisible(anchor.Position, character) then
		return nil
	end

	return { Player = player, Character = character, Anchor = anchor, ScreenDistance = distance }
end

-- Player wrapper around evaluateCharacter: rejects yourself and gone players.
local function evaluateTarget(player, config)
	if not player or player.Parent ~= Players or player == LocalPlayer then
		return nil
	end

	return evaluateCharacter(player.Character, player, config)
end

-- Cached list of NPC ("bot") characters for the Target Bots mode. Scanning the
-- whole Workspace every frame is too expensive, so the list refreshes at most
-- every BOT_SCAN_INTERVAL seconds and the scan only runs while TargetBots is on.
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
		if descendant:IsA("Model")
			and descendant:FindFirstChildOfClass("Humanoid")
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

-- How close to the crosshair (in pixels) somebody must be for the Target Display
-- to name them. Outside this the popup reads "UnKnown".
local LOOK_RADIUS = 50

-- Whoever you're LOOKING at, for the Target Display popup. Deliberately separate
-- from the aimbot's filters: no wall check (so people behind walls/floors still
-- register) and ranged by the ESP render distance rather than the aimbot's. Off-
-- screen players score math.huge from getScreenDistance, so they never win.
-- With Target Bots on NPCs count too; the popup then shows the model name.
function CameraDirector:GetLookTarget(espConfig, cameraConfig)
	local best
	local bestDistance = LOOK_RADIUS -- anything further from the crosshair is ignored

	local myChar = LocalPlayer.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	local maxRange = (espConfig and espConfig.MaxDistance) or math.huge

	-- Scores one character; `result` is what the popup names (player or model).
	local function consider(character, result)
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
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

	-- Team Check skips teammates; teamless players and bots stay eligible.
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

-- Chooses the region to aim at. A specific Hitbox mode uses that region directly;
-- "Random (Weighted)" rolls once per acquired target and stays locked so the
-- camera doesn't jump between body parts every frame.
function CameraDirector:_resolveRegion(character, config)
	local mode = config.Hitbox

	if mode and mode ~= "Random (Weighted)" and REGION_PARTS[mode] then
		return mode
	end

	if self._lockedChar ~= character then
		self._lockedChar = character
		self._rolledRegion = rollWeightedRegion(config.TargetWeights)
	end
	return self._rolledRegion or "Head"
end

function CameraDirector:PointCamera(targetPosition, smoothness)
	local desired = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
	-- Lower Smoothness = harder lock. The slider is inverted into the lerp alpha,
	-- so a small value snaps onto the target and a large value eases in slowly.
	-- Floored at 0.02 so the smoothest setting still tracks instead of freezing.
	local alpha = math.clamp(1 - (smoothness or 0), 0.02, 1)
	Camera.CFrame = Camera.CFrame:Lerp(desired, alpha)
end

-- Update camera tracking. `debug` is the top-level Configuration.Debug flag
-- (it does not live inside the Camera config table).
function CameraDirector:Update(config, debug)
	Camera = Workspace.CurrentCamera
	updateFovCircle(config)

	if not config.Enabled then
		self._lockedChar = nil -- reset the weighted lock so re-enabling re-rolls
		self._stickyCharacter = nil
		self._stickyPlayer = nil
		return
	end

	if not Camera then
		return
	end

	-- Sticky target: stay on the current character while it still passes every
	-- filter, otherwise reacquire the best one. Stops the aim flicking between
	-- targets. Tracks the character (not just the player) so bot targets stick
	-- too; the player reference is kept only to detect a player leaving.
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
		print("Tracking:", target.Character.Name, "Region:", region, "Distance:", math.floor(target.ScreenDistance))
	end

	return target
end

function CameraDirector:Cleanup()
	self._lockedChar = nil
	self._stickyCharacter = nil
	self._stickyPlayer = nil
	destroyFovCircle()
end

--==============================================================================
-- NO RECOIL
-- Hard vertical aim-lock. When you start firing it captures your look pitch and
-- forces the camera back to it every frame, so recoil literally cannot climb the
-- crosshair off target (matching a "zero recoil" cheat). Works on games that
-- apply recoil to the camera. `Strength` scales how hard it holds (1 = fully
-- locked); `AllowAim` still lets you pull downward while firing.
--==============================================================================

local NoRecoil = {}
local basePitch = nil

local function cameraPitch(cam)
	local look = cam.CFrame.LookVector
	return math.asin(math.clamp(look.Y, -1, 1))
end

local function isFiring()
	return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end

-- aimbotActive: when the camera director is actively steering the view, skip the
-- pitch lock (which also steers the CFrame) so the two don't fight. The
-- CameraOffset kill still runs, since it doesn't touch the aim direction.
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
		basePitch = nil -- re-lock on the first firing frame
		return
	end

	-- Always kill recoil/shake applied through Humanoid.CameraOffset. This is a
	-- very common Roblox recoil source (the whole view kicks) and zeroing it
	-- removes kick on every axis at once — the piece the pitch lock alone can't
	-- catch. There's no reason to want No Recoil on but this off, so it's not a
	-- switch; it just runs whenever No Recoil is active.
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.CameraOffset = Vector3.new(0, 0, 0)
	end

	-- Pitch lock steers the camera CFrame, so hand off to the aimbot when it's on.
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
		basePitch = pitch -- lock to wherever you started firing
		return
	end

	local drift = pitch - basePitch
	if config.AllowAim and drift < 0 then
		-- Pulled below the lock (aiming down) — adopt the lower baseline instead of
		-- fighting it, so you keep downward control while the climb stays blocked.
		basePitch = pitch
		return
	end

	if drift ~= 0 then
		-- Force the view straight back to the locked pitch.
		cam.CFrame = cam.CFrame * CFrame.Angles(-drift * strength, 0, 0)
	end
end

function NoRecoil:Reset()
	basePitch = nil
end

--==============================================================================
-- NO SPREAD
-- Best-effort removal of client-side bullet spread. Many Roblox guns pick their
-- fire direction on the client by adding a random cone via math.random; when
-- enabled this routes those rolls to the MIDDLE of their range (zero deviation)
-- so shots land dead-center. Only affects games that compute spread on the
-- CLIENT — server-authoritative spread can't be changed from here. Needs an
-- executor with function hooking (hookfunction / replaceclosure); if absent the
-- feature simply warns once and stays inert.
--==============================================================================

local NoSpread = {}
local ns_active = false
local ns_warned = false
local ns_mathHooked = false
local ns_randHooked = false
local ns_strength = 1 -- 0..1, mirrored from config each frame
local ns_origMathRandom = nil
local ns_origNextNumber = nil
local ns_origNextInteger = nil

local function ns_hookApi()
	if type(hookfunction) == "function" then
		return hookfunction
	elseif type(replaceclosure) == "function" then
		return replaceclosure
	end
	return nil
end

-- Midpoint of a math.random(...) call, i.e. the centre of the spread cone.
-- Mirrors math.random's three argument forms.
local function ns_mathMid(a, b)
	if a == nil then
		return 0.5
	elseif b == nil then
		return math.floor((1 + a) / 2 + 0.5)
	else
		return math.floor((a + b) / 2 + 0.5)
	end
end

-- Pulls a roll from its real value toward the centre by Strength. At 1 it lands
-- dead centre (no spread); at 0.5 the cone is halved; at 0 it's untouched. This
-- is what makes the Strength slider meaningful rather than just on/off.
local function ns_pull(original, centre, isInt)
	local v = original + (centre - original) * ns_strength
	if isInt then
		return math.floor(v + 0.5)
	end
	return v
end

-- Covers guns that use math.random for their spread cone.
local function ns_installMath(hook)
	if ns_mathHooked then
		return
	end
	local ok, ret = pcall(hook, math.random, function(...)
		local original = ns_origMathRandom(...)
		if ns_active and ns_strength > 0 then
			local a, b = ...
			-- math.random() returns a float; the (n) and (a,b) forms return integers.
			return ns_pull(original, ns_mathMid(a, b), a ~= nil)
		end
		return original
	end)
	if ok then
		ns_origMathRandom = ret
		ns_mathHooked = true
	end
end

-- Covers guns that use a Random.new() object (NextNumber / NextInteger). The
-- method closures are shared across all Random instances, so hooking them once
-- from a sample instance affects every gun that uses them.
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
			warn("[Vanity-General] No Spread needs function hooking (hookfunction) — not available in this executor.")
			ns_warned = true
		end
		return false
	end

	ns_installMath(hook)
	ns_installRandom(hook)

	if not (ns_mathHooked or ns_randHooked) then
		if not ns_warned then
			warn("[Vanity-General] No Spread: failed to install any hook.")
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

-- Restores the originals (called on unload) so no global hook lingers.
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

--==============================================================================
-- TRIGGERBOT
-- Fires when the crosshair is over a living player. It raycasts from the exact
-- centre of the screen, so a wall between you and the target blocks the shot
-- (inherent line-of-sight). Fires only after a reaction Delay and within
-- MaxDistance. Needs an executor mouse-click function (mouse1click / press+release).
--==============================================================================

local Triggerbot = {}
local tb_click -- resolved click function
local tb_resolved = false
local tb_warned = false
local tb_onTargetSince = nil -- os.clock when the crosshair first landed on a target
local tb_lastFire = 0
local TB_REFIRE = 0.08 -- min seconds between shots so it can't spam every frame

local function tb_resolveClick()
	if tb_resolved then
		return
	end
	tb_resolved = true

	if type(mouse1click) == "function" then
		tb_click = function()
			mouse1click()
		end
	elseif type(mouse1press) == "function" and type(mouse1release) == "function" then
		tb_click = function()
			mouse1press()
			task.delay(0.04, function()
				pcall(mouse1release)
			end)
		end
	end
end

-- Returns the character model under the crosshair (living, not you), else nil.
local function tb_targetUnderCrosshair(config, cameraConfig)
	local cam = Workspace.CurrentCamera
	if not cam then
		return nil
	end

	local vs = cam.ViewportSize
	local ray = cam:ViewportPointToRay(vs.X / 2, vs.Y / 2)

	local params = RaycastParams.new()
	if config.WallCheck then
		-- Vischeck ON: hit the first thing, so walls between you and the target block.
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = { LocalPlayer.Character }
	else
		-- Vischeck OFF: only collide with other players' characters, so the ray
		-- passes straight through walls and still registers a target behind them.
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

	local model = result.Instance:FindFirstAncestorOfClass("Model")
	local plr = model and Players:GetPlayerFromCharacter(model)
	if not plr or plr == LocalPlayer then
		return nil
	end

	-- Team Check (lives in the Camera config): never fire on teammates.
	-- Teamless players (Team == nil) stay fair game.
	if cameraConfig and cameraConfig.TeamCheck and plr.Team ~= nil and plr.Team == LocalPlayer.Team then
		return nil
	end

	local hum = model:FindFirstChildOfClass("Humanoid")
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
			warn("[Vanity-General] Triggerbot needs a mouse-click function (mouse1click) — not available in this executor.")
			tb_warned = true
		end
		return
	end

	local target = tb_targetUnderCrosshair(config, cameraConfig)
	if not target then
		tb_onTargetSince = nil -- reset the reaction timer when off-target
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

--==============================================================================
-- ESP
-- Player highlighting with outlines, optional fill, and shell-based thickness.
--==============================================================================

local ESP = {}
local entries = {}
local container
local boxGui -- ScreenGui holding the 2D boxes (Boxes mode)
local DEPTH = Enum.HighlightDepthMode.AlwaysOnTop

local function isAlive(humanoid)
	return humanoid and humanoid.Health > 0
end

-- The part to anchor ESP to, robust across rig types and custom NPCs.
local function espRootPart(character)
	local hum = character:FindFirstChildOfClass("Humanoid")
	return (hum and hum.RootPart)
		or character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("Torso")
		or character:FindFirstChild("UpperTorso")
		or character.PrimaryPart
end

local function getBoxGui()
	if boxGui and boxGui.Parent then
		return boxGui
	end

	boxGui = Instance.new("ScreenGui")
	boxGui.Name = "VanityGeneralBoxes"
	boxGui.ResetOnSpawn = false
	boxGui.IgnoreGuiInset = true -- matches Camera:WorldToViewportPoint space
	boxGui.DisplayOrder = 996

	local ok = pcall(function()
		boxGui.Parent = getGuiParent()
	end)
	if not ok or not boxGui.Parent then
		boxGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	return boxGui
end

-- Screen-space box around a character. Unlike Highlight (which has no outline
-- width at all), a UIStroke has a real pixel Thickness, so this is what a
-- width-adjustable border would hang off.
local function updateBox(entry, character, config)
	local cam = Workspace.CurrentCamera
	local root = espRootPart(character)
	if not cam or not root or not entry.box then
		if entry.box then
			entry.box.Visible = false
		end
		return
	end

	local head = character:FindFirstChild("Head")
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

-- Name tag: a BillboardGui parented straight to the head so it always renders
-- (a billboard inside a ScreenGui doesn't). Recreated on respawn since the old
-- one dies with the old head. Local-only, so it never replicates.
-- The head tag carries two stacked lines: the name and the distance. A
-- UIListLayout skips invisible lines, so either shows on its own (centered) or
-- both stack. Parented to the head so it always renders and dies with respawns.
local function makeInfoTag(entry, name, head, config)
	local tag = Instance.new("BillboardGui")
	tag.Name = "VGInfo"
	tag.Size = UDim2.fromOffset(200, 34)
	tag.StudsOffset = Vector3.new(0, 2.7, 0)
	tag.AlwaysOnTop = true
	tag.Adornee = head
	tag.Parent = head

	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.fromScale(1, 1)
	holder.Parent = tag

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Parent = holder

	local nameLbl = Instance.new("TextLabel")
	nameLbl.LayoutOrder = 1
	nameLbl.BackgroundTransparency = 1
	nameLbl.Size = UDim2.new(1, 0, 0, 16)
	nameLbl.Font = Enum.Font.GothamBold
	nameLbl.TextSize = 13
	nameLbl.TextColor3 = config.OutlineColor
	nameLbl.TextStrokeTransparency = 0.35 -- dark stroke so it reads anywhere
	nameLbl.Text = name
	nameLbl.Visible = false
	nameLbl.Parent = holder

	local distLbl = Instance.new("TextLabel")
	distLbl.LayoutOrder = 2
	distLbl.BackgroundTransparency = 1
	distLbl.Size = UDim2.new(1, 0, 0, 14)
	distLbl.Font = Enum.Font.Gotham
	distLbl.TextSize = 12
	distLbl.TextColor3 = config.OutlineColor
	distLbl.TextStrokeTransparency = 0.4
	distLbl.Text = ""
	distLbl.Visible = false
	distLbl.Parent = holder

	entry.nameTag = tag
	entry.nameLabel = nameLbl
	entry.distanceLabel = distLbl
	entry.nameHead = head
end

local function updateInfoTag(name, entry, character, config)
	local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
	if not head then
		if entry.nameTag then
			entry.nameTag.Enabled = false
		end
		return
	end

	-- (Re)build if missing, destroyed with the old character, or the head changed.
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
		local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
		local hrp = character:FindFirstChild("HumanoidRootPart")
		local d = (myRoot and hrp) and math.floor((hrp.Position - myRoot.Position).Magnitude + 0.5) or 0
		entry.distanceLabel.Text = "[" .. d .. "m]"
	end

	entry.nameTag.Enabled = true
end

-- Hides everything this player owns (used on death, out of range, ESP off).
local function hidePlayer(entry)
	entry.hl.Enabled = false
	if entry.box then
		entry.box.Visible = false
	end
	if entry.nameTag then
		entry.nameTag.Enabled = false
	end
end

-- Draws one character (player OR npc) with the current ESP styles. `name` is what
-- the Names line shows. Any character-model with a HumanoidRootPart works here.
local function renderCharacter(entry, character, name, config)
	-- The two styles are independent, so both can draw at once.
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

-- Distance from the local character to a part, in studs (nil root = 0).
local function distanceTo(part)
	local myChar = LocalPlayer.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
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

	local hrp = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")

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

-- Creates the instances one ESP target needs (highlight + box). Shared by
-- players and NPCs; the info tag is built lazily on the head later.
local function newEspEntry(color)
	color = color or Color3.fromRGB(165, 75, 255)

	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPOutline"
	highlight.Enabled = false
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.Parent = container

	local box = Instance.new("Frame")
	box.Name = "ESPBox"
	box.BackgroundColor3 = color
	box.BackgroundTransparency = 1
	box.BorderSizePixel = 0
	box.Visible = false
	box.Parent = getBoxGui()

	local boxStroke = Instance.new("UIStroke")
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

-- ===== NPC ESP =============================================================
-- "NPC" is defined game-agnostically: any Model in Workspace that has a
-- Humanoid but is NOT a player's character. Rescanned on a timer (a full
-- descendant walk is too heavy per-frame); rendered every frame like players.
local npcEntries = {} -- model -> entry
local lastNpcScan = 0
local NPC_SCAN_INTERVAL = 1 -- seconds between Workspace rescans

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
		if obj:IsA("Humanoid") then
			local model = obj.Parent
			if
				model
				and model:IsA("Model")
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

	-- Drop any we tracked that are gone or no longer qualify.
	for model in pairs(npcEntries) do
		if not current[model] or not model.Parent then
			removeNPC(model)
		end
	end
end

local function updateNPC(model, entry, config)
	local root = espRootPart(model)
	local humanoid = model:FindFirstChildOfClass("Humanoid")

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

	container = Instance.new("Folder")
	container.Name = "VanityGeneralESP"

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

	-- NPCs: rescan on a timer, render every frame. When off, drop them all.
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

--==============================================================================
-- UI
-- Modern tabbed interface with dark theme, smooth animations, keybind customization
--==============================================================================

local UI = {}

-- Deep purple + black theme.
local COLORS = {
	bg = Color3.fromRGB(10, 8, 14),        -- near-black window
	bar = Color3.fromRGB(16, 12, 22),      -- title bar / sidebar
	panel = Color3.fromRGB(19, 15, 26),    -- group box fill
	row = Color3.fromRGB(26, 20, 36),      -- control rows
	rowHover = Color3.fromRGB(38, 29, 52), -- hover lift
	accent = Color3.fromRGB(132, 62, 190), -- deep purple
	accentDim = Color3.fromRGB(92, 44, 134),
	border = Color3.fromRGB(44, 34, 60),   -- group outlines
	off = Color3.fromRGB(36, 28, 48),      -- unchecked / inactive
	text = Color3.fromRGB(226, 220, 238),
	textSub = Color3.fromRGB(138, 124, 160),
	danger = Color3.fromRGB(188, 52, 88),
}

local FADE_TIME = 0.18
local ANIM = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local gui
local mainWindow
local windowScale
local currentTab = "Combat"
local layoutOrder = 0
local visible = false
local activeConfig -- stored by Init so visibility can be written back to config

local uisConnections = {}
local moveHandlers = {}
local releaseHandlers = {}
local syncHandlers = {}

local targetPanel, targetPanelLabel -- floating "who you're locked onto" popup
local targetDisplayOn = false
local keybindPanel -- standalone keybind window (Settings > Interface toggle)
local watermark -- bottom-left watermark logo
local fpsPanel, fpsLabel -- bottom-right fps readout
local activeCapture
local capturingKey = false
local activeDropdown = nil -- { frame, close, contains } for the one open dropdown

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

	-- Click anywhere outside an open dropdown closes it.
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

-- Compact checkbox row: small square on the left, label beside it.
local function makeToggle(parent, text, getValue, onChange)
	local btn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	})

	local box = newInstance("Frame", {
		Parent = btn,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.fromOffset(13, 13),
		BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 3) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.border, Thickness = 1 })

	local label = newInstance("TextLabel", {
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
	suffix = suffix or ""
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	local label = newInstance("TextLabel", {
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

	local track = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.new(1, -16, 0, 6),
		Position = UDim2.new(0, 8, 0, 26),
		BackgroundColor3 = COLORS.off,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = track, CornerRadius = UDim.new(1, 0) })

	local fill = newInstance("Frame", {
		Parent = track,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = fill, CornerRadius = UDim.new(1, 0) })

	local function format(v)
		local base = isInt and tostring(math.floor(v + 0.5)) or string.format("%.2f", v)
		return base .. suffix
	end

	local function apply(v)
		v = math.clamp(v, min, max)
		if isInt then
			v = math.floor(v + 0.5)
		end
		local alpha = (max > min) and (v - min) / (max - min) or 0
		fill.Size = UDim2.new(alpha, 0, 1, 0)
		label.Text = text .. ": " .. format(v)
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
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
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

	local dropdown = newInstance("TextButton", {
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

	newInstance("UICorner", { Parent = dropdown, CornerRadius = UDim.new(0, 4) })

	local open = false
	local ROW_H = 24
	local fullSize = #options * ROW_H
	-- Cap the open height so long lists (e.g. every body part) stay on-screen and
	-- scroll instead of running off the bottom.
	local listSize = math.min(fullSize, 7 * ROW_H)

	local list = newInstance("ScrollingFrame", {
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

	newInstance("UICorner", { Parent = list, CornerRadius = UDim.new(0, 4) })

	for i, option in ipairs(options) do
		local optionBtn = newInstance("TextButton", {
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
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
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

	local value = newInstance("TextLabel", {
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

-- Clickable action button with hover feedback. `color` defaults to the accent.
local function makeButton(parent, text, onClick, color)
	local base = color or COLORS.accent
	local hover = Color3.new(
		math.min(base.R + 0.1, 1),
		math.min(base.G + 0.1, 1),
		math.min(base.B + 0.1, 1)
	)

	local btn = newInstance("TextButton", {
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

	newInstance("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })

	btn.MouseButton1Click:Connect(onClick)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, ANIM, { BackgroundColor3 = hover }):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, ANIM, { BackgroundColor3 = base }):Play()
	end)

	return btn
end

-- Single-line text input. Returns the TextBox so callers can read/set .Text.
local function makeTextBox(parent, placeholder)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })
	local stroke = newInstance("UIStroke", {
		Parent = holder,
		Color = COLORS.border,
		Thickness = 1,
		Transparency = 0.3,
	})

	local box = newInstance("TextBox", {
		Parent = holder,
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		PlaceholderText = placeholder or "",
		PlaceholderColor3 = COLORS.textSub,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Text = "",
	})

	box.Focused:Connect(function()
		TweenService:Create(stroke, ANIM, { Transparency = 0, Color = COLORS.accent }):Play()
	end)

	box.FocusLost:Connect(function()
		TweenService:Create(stroke, ANIM, { Transparency = 0.3, Color = COLORS.border }):Play()
	end)

	return box
end

-- Small section header ("TARGET SETTINGS", "HITBOX") to group related controls.
local function makeHeader(parent, text)
	newInstance("TextLabel", {
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

-- Filled-row slider: the accent fill grows with the value and the label sits on
-- top, e.g. "Head Weight: 85/100%". showMax appends "/<max><unit>".
local function makeFillSlider(parent, text, min, max, getValue, setValue, isInt, unit, showMax)
	unit = unit or ""

	local holder = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
		ClipsDescendants = true,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	local fill = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = COLORS.accent,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		ZIndex = 1,
	})

	newInstance("UICorner", { Parent = fill, CornerRadius = UDim.new(0, 6) })

	local label = newInstance("TextLabel", {
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
		local s = isInt and tostring(math.floor(v + 0.5)) or string.format("%.2f", v)
		if showMax then
			local m = isInt and tostring(math.floor(max + 0.5)) or string.format("%.2f", max)
			return s .. "/" .. m .. unit
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
		label.Text = text .. ": " .. fmt(v)
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

-- Full-width dropdown. The option list expands INLINE (growing the panel and
-- pushing whatever follows down) rather than floating over the layout — floating
-- got clipped by the scroll panel and drawn over by sibling group boxes.
local function makeDropdownFull(parent, options, getValue, onChange)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	newInstance("UIListLayout", {
		Parent = holder,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4),
	})

	local dropdown = newInstance("TextButton", {
		Parent = holder,
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	})

	newInstance("UICorner", { Parent = dropdown, CornerRadius = UDim.new(0, 6) })
	local dropStroke = newInstance("UIStroke", {
		Parent = dropdown,
		Color = COLORS.border,
		Thickness = 1,
		Transparency = 0.3,
	})

	local valueLabel = newInstance("TextLabel", {
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

	local caret = newInstance("TextLabel", {
		Parent = dropdown,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		Size = UDim2.fromOffset(14, 14),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.accent,
		Text = "▾",
	})

	local open = false
	local ROW_H = 26
	local fullSize = #options * ROW_H
	local listSize = math.min(fullSize, 6 * ROW_H)

	local list = newInstance("ScrollingFrame", {
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

	newInstance("UICorner", { Parent = list, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = list, Color = COLORS.border, Thickness = 1, Transparency = 0.2 })

	local optionButtons = {}

	-- Repaints every row so the active choice reads as selected.
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
			activeDropdown.close() -- only one open at a time
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
		local optionBtn = newInstance("TextButton", {
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

-- HSV color picker: saturation/value square + hue strip + hex readout.
local function makeColorPicker(parent, title, getColor, setColor)
	local h, s, v = getColor():ToHSV()
	local SQ_H, HUE_W, GAP = 120, 16, 8

	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, SQ_H + 74),
		BackgroundColor3 = COLORS.panel,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = holder, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
	newInstance("UIPadding", {
		Parent = holder,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	local heading = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = title or "Color",
	})

	local body = newInstance("Frame", {
		Parent = holder,
		Position = UDim2.fromOffset(0, 20),
		Size = UDim2.new(1, 0, 1, -20),
		BackgroundTransparency = 1,
	})

	local sq = newInstance("Frame", {
		Parent = body,
		Size = UDim2.new(1, -(HUE_W + GAP), 0, SQ_H), -- responsive: fits any column width
		BackgroundColor3 = Color3.fromHSV(h, 1, 1),
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = sq, CornerRadius = UDim.new(0, 4) })

	local satLayer = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = satLayer, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
		Parent = satLayer,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1),
		}),
	})

	local valLayer = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = valLayer, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
		Parent = valLayer,
		Rotation = 90,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(1, 0),
		}),
	})

	local svDot = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromOffset(10, 10),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 5,
	})
	newInstance("UICorner", { Parent = svDot, CornerRadius = UDim.new(1, 0) })
	newInstance("UIStroke", { Parent = svDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })

	local hue = newInstance("Frame", {
		Parent = body,
		Size = UDim2.fromOffset(HUE_W, SQ_H),
		Position = UDim2.new(1, -HUE_W, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = hue, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
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

	local hueDot = newInstance("Frame", {
		Parent = hue,
		Size = UDim2.new(1, 4, 0, 4),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, h, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 5,
	})
	newInstance("UIStroke", { Parent = hueDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })

	local preview = newInstance("Frame", {
		Parent = body,
		Size = UDim2.fromOffset(22, 22),
		Position = UDim2.fromOffset(0, SQ_H + 6),
		BackgroundColor3 = getColor(),
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = preview, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = preview, Color = COLORS.off, Thickness = 1 })

	local hexLabel = newInstance("TextLabel", {
		Parent = body,
		Size = UDim2.new(1, -30, 0, 22),
		Position = UDim2.fromOffset(30, SQ_H + 6),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "",
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
		hexLabel.Text = string.format("#%02X%02X%02X  (%d, %d, %d)", r, g, b, r, g, b)
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

-- Wires capture/refresh/sync behavior onto an already-created keybind box
-- (a TextButton). Shared by the standalone keybind row and the inline
-- toggle+keybind control so the capture state machine lives in one place.
local function wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
	local listening = false

	local function refresh()
		if listening then
			box.Text = "Press…"
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
				UI:Notify(string.format("%s is already bound to %s", key.Name, conflict), 2.5)
			else
				setKey(key)
				UI:Notify(string.format("%s bound to %s", labelText, key.Name), 2)
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

-- Returns the name of the action already using `key` (excluding `field`), or nil.
-- Fields: menu, aimbot, esp, fovcircle, norecoil, nospread, unload.
local function keyConflict(config, key, field)
	if field ~= "menu" and config.UI.MenuKey == key then
		return "Menu"
	end
	if field ~= "aimbot" and config.Camera.ToggleKey == key then
		return "Aimbot"
	end
	if field ~= "esp" and config.ESP.ToggleKey == key then
		return "ESP"
	end
	if field ~= "fovcircle" and config.Camera.FOVCircleKey == key then
		return "FOV Circle"
	end
	if field ~= "norecoil" and config.NoRecoil.ToggleKey == key then
		return "No Recoil"
	end
	if field ~= "nospread" and config.NoSpread.ToggleKey == key then
		return "No Spread"
	end
	if field ~= "triggerbot" and config.Triggerbot.ToggleKey == key then
		return "Triggerbot"
	end
	if field ~= "unload" and config.UI.UnloadKey == key then
		return "Unload"
	end
	return nil
end

-- Standalone keybind row: a label on the left and a clickable key box on the right.
local function makeKeybind(parent, labelText, getKey, setKey, conflictCheck)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
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

	local box = newInstance("TextButton", {
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

	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
	newInstance("UIPadding", {
		Parent = box,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})
	newInstance("UISizeConstraint", { Parent = box, MinSize = Vector2.new(54, 22) })

	wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
end

-- Toggle row with an inline keybind box sitting just left of the switch. The row
-- itself toggles on click; the key box captures its own clicks (it's on top) so
-- rebinding never flips the toggle.
-- Checkbox row with an inline keybind box on the right. The row toggles; the key
-- box captures its own clicks (it sits on top) so rebinding never flips it.
local function makeToggleWithKeybind(parent, text, getValue, onChange, keyLabel, getKey, setKey, conflictCheck)
	local btn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 24),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	})

	local check = newInstance("Frame", {
		Parent = btn,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.fromOffset(13, 13),
		BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = check, CornerRadius = UDim.new(0, 3) })
	newInstance("UIStroke", { Parent = check, Color = COLORS.border, Thickness = 1 })

	local label = newInstance("TextLabel", {
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

	local box = newInstance("TextButton", {
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

	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
	newInstance("UIPadding", {
		Parent = box,
		PaddingLeft = UDim.new(0, 7),
		PaddingRight = UDim.new(0, 7),
	})
	newInstance("UISizeConstraint", { Parent = box, MinSize = Vector2.new(44, 20) })

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

-- Splits a tab panel into two side-by-side columns (the tab's own layout is
-- horizontal). Groups get distributed between them for the two-column look.
local function makeColumns(parent)
	local function column(order)
		local col = newInstance("Frame", {
			Parent = parent,
			LayoutOrder = order,
			Size = UDim2.new(0.5, -4, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})
		newInstance("UIListLayout", {
			Parent = col,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		})
		return col
	end
	return column(1), column(2)
end

-- Bordered, titled panel. Returns:
--   content   -- parent controls to this
--   setEnabled(bool) -- greys the panel out and blocks input when false
local function makeGroup(parent, title)
	-- Wrapper holds the panel plus the disabled veil. It deliberately has NO
	-- AutomaticSize: AutomaticSize measures the veil too, so the veil (sized off
	-- the wrapper) and the wrapper would inflate each other into a giant box. Its
	-- height is instead synced from the panel below, which nothing else depends on.
	local wrapper = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	local box = newInstance("Frame", {
		Parent = wrapper,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = COLORS.panel,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
	newInstance("UIPadding", {
		Parent = box,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})
	newInstance("UIListLayout", {
		Parent = box,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
	})

	newInstance("TextLabel", {
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

	-- Disabled veil: dims the panel AND hatches it with diagonal lines so it reads
	-- as unusable. It's a TextButton (not a Frame+Active) because only a button
	-- reliably swallows the press that starts a slider drag.
	local veil = newInstance("TextButton", {
		Parent = wrapper,
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = COLORS.bg,
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		Visible = false,
		Active = true,
		AutoButtonColor = false,
		Text = "",
		ClipsDescendants = true,
		ZIndex = 50,
	})
	newInstance("UICorner", { Parent = veil, CornerRadius = UDim.new(0, 6) })

	-- Diagonal hatching drawn with a rotated GRADIENT, not rotated frames:
	-- ClipsDescendants does not clip rotated children in Roblox, so the old stripe
	-- frames escaped the panel and smeared across the whole menu. A gradient is
	-- painted inside its own frame, so it can never spill.
	local STRIPE, GAP = 0.72, 1 -- transparency of a stripe vs the space between
	local hatch = newInstance("Frame", {
		Parent = veil,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = COLORS.textSub,
		BorderSizePixel = 0,
		ZIndex = 51,
	})
	newInstance("UICorner", { Parent = hatch, CornerRadius = UDim.new(0, 6) })
	newInstance("UIGradient", {
		Parent = hatch,
		Rotation = 35,
		-- Alternating hard bands (paired keypoints make the edges crisp).
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

	-- Keep the wrapper exactly as tall as the panel. AbsoluteSize is already
	-- post-UIScale while Size offsets get scaled again, so divide it back out.
	local function syncWrapper()
		local sc = (windowScale and windowScale.Scale) or 1
		if sc <= 0 then
			sc = 1
		end
		wrapper.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / sc)
	end

	box:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncWrapper)
	syncWrapper()

	local function setEnabled(enabled)
		veil.Visible = not enabled
	end

	return box, setEnabled
end

-- Sub-tab bar across the top of a section, with one scrolling two-column panel
-- per sub-tab below it. Returns a host whose :add(name) creates a sub-tab and
-- returns its content frame (pass that to makeColumns). First added shows first.
local function makeSubTabHost(parent)
	local bar = newInstance("Frame", {
		Parent = parent,
		Size = UDim2.new(1, 0, 0, 24),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	newInstance("UIListLayout", {
		Parent = bar,
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 14),
	})

	-- Thin divider under the bar.
	local divider = newInstance("Frame", {
		Parent = parent,
		Position = UDim2.fromOffset(0, 27),
		Size = UDim2.new(1, -6, 0, 1),
		BackgroundColor3 = COLORS.border,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
	})

	local area = newInstance("Frame", {
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

		local btn = newInstance("TextButton", {
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

		local underline = newInstance("Frame", {
			Parent = btn,
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 1, 1),
			Size = UDim2.new(1, 0, 0, 2),
			BackgroundColor3 = COLORS.accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = underline, CornerRadius = UDim.new(1, 0) })

		local frame = newInstance("ScrollingFrame", {
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
		newInstance("UIListLayout", {
			Parent = frame,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, 8),
		})
		newInstance("UIPadding", { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })

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
	local left, right = makeColumns(host:add("Aimbot"))

	local aim = makeGroup(left, "Aimbot")

	makeToggleWithKeybind(aim, "Enabled", function()
		return config.Camera.Enabled
	end, function()
		config.Camera.Enabled = not config.Camera.Enabled
	end, "Aimbot Key", function()
		return config.Camera.ToggleKey
	end, function(key)
		config.Camera.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "aimbot")
	end)

	makeToggle(aim, "Vischeck", function()
		return config.Camera.WallCheck
	end, function()
		config.Camera.WallCheck = not config.Camera.WallCheck
	end)

	makeToggle(aim, "Sticky Target", function()
		return config.Camera.StickyTarget
	end, function()
		config.Camera.StickyTarget = not config.Camera.StickyTarget
	end)

	makeToggle(aim, "Target Bots", function()
		return config.Camera.TargetBots
	end, function()
		config.Camera.TargetBots = not config.Camera.TargetBots
	end)

	makeToggle(aim, "Team Check", function()
		return config.Camera.TeamCheck
	end, function()
		config.Camera.TeamCheck = not config.Camera.TeamCheck
	end)

	makeToggleWithKeybind(aim, "FOV Circle", function()
		return config.Camera.FOVCircle
	end, function()
		config.Camera.FOVCircle = not config.Camera.FOVCircle
	end, "FOV Circle Key", function()
		return config.Camera.FOVCircleKey
	end, function(key)
		config.Camera.FOVCircleKey = key
	end, function(key)
		return keyConflict(config, key, "fovcircle")
	end)

	makeFillSlider(aim, "Smoothness", 0.05, 1, function()
		return config.Camera.Smoothness
	end, function(val)
		config.Camera.Smoothness = val
	end, false)

	-- FOV drives both the targeting cone and the on-screen circle.
	makeFillSlider(aim, "FOV", 20, 800, function()
		return config.Camera.FOV
	end, function(val)
		config.Camera.FOV = val
	end, true, "px", true)

	makeFillSlider(aim, "Max Distance", 100, 2000, function()
		return config.Camera.MaxDistance
	end, function(val)
		config.Camera.MaxDistance = val
	end, true, "m", true)

	-- Declared up front so the dropdown's callback can refresh the weights gate,
	-- which is created just below it.
	local refreshWeightGate

	local hitbox = makeGroup(right, "Hitbox")
	makeDropdownFull(hitbox, config.Camera.HitboxOptions, function()
		return config.Camera.Hitbox
	end, function(val)
		config.Camera.Hitbox = val
		if refreshWeightGate then
			refreshWeightGate()
		end
	end)

	-- Per-region weights live with the Hitbox mode that uses them, on the right.
	local weights, setWeightsEnabled = makeGroup(right, "Target Settings")

	local function weightRow(name)
		makeFillSlider(weights, name .. " Weight", 0, 100, function()
			return config.Camera.TargetWeights[name]
		end, function(val)
			config.Camera.TargetWeights[name] = val
		end, true, "%", true)
	end

	weightRow("Head")
	weightRow("Torso")
	weightRow("Arms")
	weightRow("Legs")

	-- Weights only do anything in Random (Weighted); grey the panel out and block
	-- input when a specific body part is picked instead.
	refreshWeightGate = function()
		setWeightsEnabled(config.Camera.Hitbox == "Random (Weighted)")
	end
	refreshWeightGate()
	table.insert(syncHandlers, refreshWeightGate)

	-- Triggerbot lives with the Aimbot on this sub-tab.
	local trigger = makeGroup(right, "Triggerbot")

	makeToggleWithKeybind(trigger, "Enabled", function()
		return config.Triggerbot.Enabled
	end, function()
		config.Triggerbot.Enabled = not config.Triggerbot.Enabled
	end, "Triggerbot Key", function()
		return config.Triggerbot.ToggleKey
	end, function(key)
		config.Triggerbot.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "triggerbot")
	end)

	makeFillSlider(trigger, "Delay", 0, 500, function()
		return config.Triggerbot.Delay * 1000
	end, function(val)
		config.Triggerbot.Delay = val / 1000
	end, true, "ms", true)

	makeFillSlider(trigger, "Max Distance", 100, 2000, function()
		return config.Triggerbot.MaxDistance
	end, function(val)
		config.Triggerbot.MaxDistance = val
	end, true, "m", true)

	makeToggle(trigger, "Vischeck", function()
		return config.Triggerbot.WallCheck
	end, function()
		config.Triggerbot.WallCheck = not config.Triggerbot.WallCheck
	end)

	------------------------------------------------------------------- Weapons --
	left, right = makeColumns(host:add("Weapons"))

	local recoil = makeGroup(left, "No Recoil")

	makeToggleWithKeybind(recoil, "Enabled", function()
		return config.NoRecoil.Enabled
	end, function()
		config.NoRecoil.Enabled = not config.NoRecoil.Enabled
	end, "No Recoil Key", function()
		return config.NoRecoil.ToggleKey
	end, function(key)
		config.NoRecoil.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "norecoil")
	end)

	makeToggle(recoil, "Only While Firing", function()
		return config.NoRecoil.RequireMouseDown
	end, function()
		config.NoRecoil.RequireMouseDown = not config.NoRecoil.RequireMouseDown
	end)

	makeToggle(recoil, "Allow Aim Down", function()
		return config.NoRecoil.AllowAim
	end, function()
		config.NoRecoil.AllowAim = not config.NoRecoil.AllowAim
	end)

	makeFillSlider(recoil, "Strength", 0, 100, function()
		return config.NoRecoil.Strength * 100
	end, function(val)
		config.NoRecoil.Strength = val / 100
	end, true, "%", true)

	local spread = makeGroup(left, "No Spread")

	makeToggleWithKeybind(spread, "Enabled", function()
		return config.NoSpread.Enabled
	end, function()
		config.NoSpread.Enabled = not config.NoSpread.Enabled
	end, "No Spread Key", function()
		return config.NoSpread.ToggleKey
	end, function(key)
		config.NoSpread.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "nospread")
	end)

	makeToggle(spread, "Only While Firing", function()
		return config.NoSpread.RequireMouseDown
	end, function()
		config.NoSpread.RequireMouseDown = not config.NoSpread.RequireMouseDown
	end)

	makeFillSlider(spread, "Strength", 0, 100, function()
		return config.NoSpread.Strength * 100
	end, function(val)
		config.NoSpread.Strength = val / 100
	end, true, "%", true)
end

local function buildESPTab(parent, config)
	layoutOrder = 0
	local host = makeSubTabHost(parent)
	local left, right = makeColumns(host:add("ESP"))

	local esp = makeGroup(left, "ESP")

	makeToggleWithKeybind(esp, "Enabled", function()
		return config.ESP.Enabled
	end, function()
		config.ESP.Enabled = not config.ESP.Enabled
	end, "ESP Key", function()
		return config.ESP.ToggleKey
	end, function(key)
		config.ESP.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "esp")
	end)

	makeToggle(esp, "NPCs", function()
		return config.ESP.NPCs
	end, function()
		config.ESP.NPCs = not config.ESP.NPCs
	end)

	makeFillSlider(esp, "Max Distance", 100, 2000, function()
		return config.ESP.MaxDistance
	end, function(val)
		config.ESP.MaxDistance = val
	end, true, "m", true)

	-- Appearance: render style, fill toggle, then the opacities at the bottom.
	local look = makeGroup(left, "Appearance")

	makeToggle(look, "Outlines", function()
		return config.ESP.Outlines
	end, function()
		config.ESP.Outlines = not config.ESP.Outlines
	end)

	makeToggle(look, "Boxes", function()
		return config.ESP.Boxes
	end, function()
		config.ESP.Boxes = not config.ESP.Boxes
	end)

	makeToggle(look, "Names", function()
		return config.ESP.Names
	end, function()
		config.ESP.Names = not config.ESP.Names
	end)

	makeToggle(look, "Distance", function()
		return config.ESP.Distance
	end, function()
		config.ESP.Distance = not config.ESP.Distance
	end)

	makeToggle(look, "Filled", function()
		return config.ESP.Filled
	end, function()
		config.ESP.Filled = not config.ESP.Filled
	end)

	makeFillSlider(look, "Outline Opacity", 0, 1, function()
		return config.ESP.OutlineOpacity
	end, function(val)
		config.ESP.OutlineOpacity = val
	end, false)

	makeFillSlider(look, "Fill Opacity", 0, 1, function()
		return config.ESP.FillOpacity
	end, function(val)
		config.ESP.FillOpacity = val
	end, false)

	----------------------------------------------------------------- Colors -----
	left, right = makeColumns(host:add("Colors"))

	makeColorPicker(left, "Outline Color", function()
		return config.ESP.OutlineColor
	end, function(c)
		config.ESP.OutlineColor = c
	end)

	makeColorPicker(right, "Fill Color", function()
		return config.ESP.FillColor
	end, function(c)
		config.ESP.FillColor = c
	end)
end

local function buildSettingsTab(parent, config)
	layoutOrder = 0
	local host = makeSubTabHost(parent)
	local left, right = makeColumns(host:add("General"))

	local iface = makeGroup(left, "Interface")
	makeFillSlider(iface, "UI Scale", 0.8, 1.5, function()
		return config.UI.Scale
	end, function(val)
		config.UI.Scale = val
		if windowScale then
			windowScale.Scale = val
		end
	end, false)

	-- Opens the standalone keybind window (built by buildKeybindPanel).
	makeToggle(iface, "Keybind Panel", function()
		return config.UI.KeybindPanel
	end, function()
		config.UI.KeybindPanel = not config.UI.KeybindPanel
		if keybindPanel then
			keybindPanel.Visible = config.UI.KeybindPanel
		end
	end)

	makeToggle(iface, "Target Display", function()
		return config.UI.TargetDisplay
	end, function()
		config.UI.TargetDisplay = not config.UI.TargetDisplay
		targetDisplayOn = config.UI.TargetDisplay
		if not targetDisplayOn and targetPanel then
			targetPanel.Visible = false
		end
	end)

	makeToggle(iface, "FPS Counter", function()
		return config.UI.FPSCounter
	end, function()
		config.UI.FPSCounter = not config.UI.FPSCounter
		if fpsPanel then
			fpsPanel.Visible = config.UI.FPSCounter
		end
	end)

	makeToggle(iface, "Watermark", function()
		return config.UI.Watermark
	end, function()
		config.UI.Watermark = not config.UI.Watermark
		if watermark then
			watermark.Visible = config.UI.Watermark
		end
	end)

	local account = makeGroup(right, "Account")
	makeLabel(account, "Username", LocalPlayer and LocalPlayer.Name or "—")
	makeLabel(account, "Display Name", LocalPlayer and LocalPlayer.DisplayName or "—")
	makeLabel(account, "User ID", LocalPlayer and tostring(LocalPlayer.UserId) or "—")

	------------------------------------------------------------------ Configs ---
	-- Save / load / delete named setting profiles.
	left, right = makeColumns(host:add("Configs"))
	local cfg = makeGroup(left, "Configs")

	if not ConfigManager.isSupported() then
		makeLabel(cfg, "Status", "Unsupported")
		return
	end

	local nameBox = makeTextBox(cfg, "config name…")

	-- Scrollable list of saved configs; clicking one selects it into the box.
	local listHolder = newInstance("Frame", {
		Parent = cfg,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	newInstance("UIListLayout", {
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
			if not child:IsA("UIListLayout") then
				child:Destroy()
			end
		end

		local names = ConfigManager.list()
		if #names == 0 then
			newInstance("TextLabel", {
				Parent = listHolder,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 22),
				BackgroundTransparency = 1,
				Font = Enum.Font.Gotham,
				TextSize = 11,
				TextColor3 = COLORS.textSub,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = "no saved configs",
			})
			return
		end

		for i, name in ipairs(names) do
			local selected = (nameBox.Text == name)
			local row = newInstance("TextButton", {
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
				Text = "  " .. name,
			})
			newInstance("UICorner", { Parent = row, CornerRadius = UDim.new(0, 4) })

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

	makeButton(cfg, "Save", function()
		local ok, res = ConfigManager.save(nameBox.Text, config)
		if ok then
			UI:Notify("Saved config '" .. res .. "'", 2)
			refreshList()
		else
			UI:Notify(tostring(res), 3)
		end
	end)

	makeButton(cfg, "Load", function()
		local ok, res = ConfigManager.load(nameBox.Text, config)
		if ok then
			-- Push every loaded value back into the controls, and re-apply UI scale.
			if windowScale then
				windowScale.Scale = config.UI.Scale
			end
			UI:SyncControls()
			UI:Notify("Loaded config '" .. res .. "'", 2)
		else
			UI:Notify(tostring(res), 3)
		end
	end)

	makeButton(cfg, "Delete", function()
		local ok, res = ConfigManager.delete(nameBox.Text)
		if ok then
			UI:Notify("Deleted config '" .. res .. "'", 2)
			nameBox.Text = ""
			refreshList()
		else
			UI:Notify(tostring(res), 3)
		end
	end, COLORS.danger)

	refreshList()
end

-- Bottom-right watermark: brand, player name and a live FPS readout. Toggled by
-- the "Watermark" switch under Settings > Interface.
-- Floating popup naming whoever the aimbot is currently locked onto. Only shows
-- while there IS a target, so it behaves like a callout rather than a static row.
-- Draggable; toggled by "Target Display" under Settings > Interface.
local function buildTargetPanel(config)
	targetPanel = newInstance("Frame", {
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

	newInstance("UICorner", { Parent = targetPanel, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = targetPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
	newInstance("UIPadding", {
		Parent = targetPanel,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 12),
	})
	newInstance("UIListLayout", {
		Parent = targetPanel,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
	})

	local dot = newInstance("Frame", {
		Parent = targetPanel,
		LayoutOrder = 0,
		Size = UDim2.fromOffset(6, 6),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

	targetPanelLabel = newInstance("TextLabel", {
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
		Text = "",
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

-- Bottom-right fps readout. Toggled by "FPS Counter" under Settings > Interface.
local function buildFpsPanel(config)
	fpsPanel = newInstance("Frame", {
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

	newInstance("UICorner", { Parent = fpsPanel, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = fpsPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
	newInstance("UIPadding", {
		Parent = fpsPanel,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 12),
	})
	newInstance("UIListLayout", {
		Parent = fpsPanel,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
	})

	local dot = newInstance("Frame", {
		Parent = fpsPanel,
		LayoutOrder = 0,
		Size = UDim2.fromOffset(6, 6),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

	fpsLabel = newInstance("TextLabel", {
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
		Text = "-- fps",
	})

	table.insert(syncHandlers, function()
		if fpsPanel then
			fpsPanel.Visible = config.UI.FPSCounter
		end
	end)

	fpsPanel.Visible = config.UI.FPSCounter
end

local function buildWatermark(config)
	-- Just the logo: no panel, border or text. ScaleType.Fit letterboxes inside
	-- the box, so any source aspect ratio stays undistorted. Sits bottom-LEFT so
	-- it doesn't collide with the fps counter in the bottom-right.
	watermark = newInstance("ImageLabel", {
		Parent = gui,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 14, 1, -14),
		Size = UDim2.fromOffset(180, 64),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScaleType = Enum.ScaleType.Fit,
		Image = "",
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

-- Standalone, draggable window listing every bound key. Each row is a live
-- keybind control, so you can rebind straight from here. Toggled by the
-- "Keybind Panel" switch under Settings > Interface.
local function buildKeybindPanel(config)
	layoutOrder = 0

	keybindPanel = newInstance("Frame", {
		Parent = gui,
		Size = UDim2.fromOffset(230, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.fromOffset(680, 100),
		BackgroundColor3 = COLORS.bg,
		BorderSizePixel = 0,
		Visible = false,
	})

	newInstance("UICorner", { Parent = keybindPanel, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = keybindPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
	newInstance("UIListLayout", {
		Parent = keybindPanel,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
	})
	newInstance("UIPadding", {
		Parent = keybindPanel,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	-- Title bar doubles as the drag handle.
	local bar = newInstance("Frame", {
		Parent = keybindPanel,
		LayoutOrder = 0,
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = bar, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = bar,
		Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "Keybinds",
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

	makeKeybind(keybindPanel, "Menu", function()
		return config.UI.MenuKey
	end, function(key)
		config.UI.MenuKey = key
	end, function(key)
		return keyConflict(config, key, "menu")
	end)

	makeKeybind(keybindPanel, "Aimbot", function()
		return config.Camera.ToggleKey
	end, function(key)
		config.Camera.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "aimbot")
	end)

	makeKeybind(keybindPanel, "ESP", function()
		return config.ESP.ToggleKey
	end, function(key)
		config.ESP.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "esp")
	end)

	makeKeybind(keybindPanel, "FOV Circle", function()
		return config.Camera.FOVCircleKey
	end, function(key)
		config.Camera.FOVCircleKey = key
	end, function(key)
		return keyConflict(config, key, "fovcircle")
	end)

	makeKeybind(keybindPanel, "No Recoil", function()
		return config.NoRecoil.ToggleKey
	end, function(key)
		config.NoRecoil.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "norecoil")
	end)

	makeKeybind(keybindPanel, "No Spread", function()
		return config.NoSpread.ToggleKey
	end, function(key)
		config.NoSpread.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "nospread")
	end)

	makeKeybind(keybindPanel, "Triggerbot", function()
		return config.Triggerbot.ToggleKey
	end, function(key)
		config.Triggerbot.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "triggerbot")
	end)

	makeKeybind(keybindPanel, "Unload", function()
		return config.UI.UnloadKey
	end, function(key)
		config.UI.UnloadKey = key
	end, function(key)
		return keyConflict(config, key, "unload")
	end)

	-- Keeps the window in step with the config (e.g. after a Reset).
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

	-- Keep Configuration.UI.Visible in sync with the actual window state
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

	gui = newInstance("ScreenGui", {
		Name = "VanityGeneralUI",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
	})

	local ok = pcall(function()
		gui.Parent = getGuiParent()
	end)
	if not ok or not gui.Parent then
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	mainWindow = newInstance("CanvasGroup", {
		Parent = gui,
		Size = UDim2.fromOffset(580, 400),
		Position = UDim2.fromOffset(60, 80),
		BackgroundColor3 = COLORS.bg,
		BorderSizePixel = 0,
		GroupTransparency = 1,
		Visible = false,
	})

	windowScale = newInstance("UIScale", { Parent = mainWindow, Scale = config.UI.Scale })
	newInstance("UICorner", { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })

	-- Title bar spans the top; it's the drag handle.
	local titleBar = newInstance("Frame", {
		Parent = mainWindow,
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = titleBar, CornerRadius = UDim.new(0, 8) })
	newInstance("Frame", { -- square off the lower edge of the rounded bar
		Parent = titleBar,
		Size = UDim2.new(1, 0, 0, 12),
		Position = UDim2.new(0, 0, 1, -12),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})

	local dot = newInstance("Frame", {
		Parent = titleBar,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 12, 0.5, 0),
		Size = UDim2.fromOffset(8, 8),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
		ZIndex = 2,
	})
	newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

	newInstance("TextLabel", {
		Parent = titleBar,
		Size = UDim2.new(1, -34, 1, 0),
		Position = UDim2.fromOffset(28, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		-- RichText so ".dev" picks up the accent colour.
		RichText = true,
		Text = 'Vanity<font color="#843EBE">.dev</font> General'
			.. '<font color="#8A7CA0">   ·   v0</font>',
		ZIndex = 2,
	})

	newInstance("TextLabel", { -- local player name on the right, like the reference
		Parent = titleBar,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.new(0, 140, 1, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.textSub,
		TextXAlignment = Enum.TextXAlignment.Right,
		Text = LocalPlayer and LocalPlayer.Name or "",
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

	-- Left sidebar: an inset panel of its own (rounded + outlined to match the
	-- content groups), tabs stacked at the top, Unload pinned to the bottom.
	local sidebar = newInstance("Frame", {
		Parent = mainWindow,
		Position = UDim2.fromOffset(10, 44),
		Size = UDim2.new(0, 120, 1, -54),
		BackgroundColor3 = COLORS.panel,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = sidebar, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = sidebar, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
	newInstance("UIPadding", {
		Parent = sidebar,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	-- Tabs live in their own list so the Unload button can sit at the bottom.
	local tabList = newInstance("Frame", {
		Parent = sidebar,
		Size = UDim2.new(1, 0, 1, -40),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	newInstance("UIListLayout", { Parent = tabList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })

	local unloadBtn = newInstance("TextButton", {
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
		Text = "Unload",
	})
	newInstance("UICorner", { Parent = unloadBtn, CornerRadius = UDim.new(0, 6) })
	local unloadStroke = newInstance("UIStroke", {
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

	-- Right content area: one scrolling panel per tab, layered and toggled.
	-- Starts after the inset sidebar (10 margin + 120 wide + 10 gutter).
	local content = newInstance("Frame", {
		Parent = mainWindow,
		Position = UDim2.fromOffset(140, 44),
		Size = UDim2.new(1, -150, 1, -54),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	newInstance("UIPadding", {
		Parent = content,
		PaddingRight = UDim.new(0, 4),
	})

	local tabs = { "Combat", "Visual", "Settings" }
	local tabFrames = {}

	for i, tabName in ipairs(tabs) do
		local isActive = currentTab == tabName

		local tabBtn = newInstance("TextButton", {
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
			Text = "    " .. tabName,
		})

		newInstance("UICorner", { Parent = tabBtn, CornerRadius = UDim.new(0, 6) })

		local stripe = newInstance("Frame", {
			Parent = tabBtn,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 5, 0.5, 0),
			Size = UDim2.fromOffset(3, 16),
			BackgroundColor3 = COLORS.accent,
			BorderSizePixel = 0,
			Visible = isActive,
			ZIndex = 2,
		})
		newInstance("UICorner", { Parent = stripe, CornerRadius = UDim.new(1, 0) })

		-- Fixed-height scroll panel + AutomaticCanvasSize = reliable vertical scroll.
		-- Plain container; the sub-tab host (makeSubTabHost) fills it with a
		-- sub-tab bar plus one scrolling two-column panel per sub-tab.
		local tabFrame = newInstance("Frame", {
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

	buildCameraTab(tabFrames["Combat"].frame, config)
	buildESPTab(tabFrames["Visual"].frame, config)
	buildSettingsTab(tabFrames["Settings"].frame, config)
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

-- Called every frame by the controller. Stays visible whenever the option is on,
-- showing "UnKnown" when nobody is in view.
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
	if name and name ~= "" and name ~= "None" then
		shown, colour = name, "#843EBE"
	else
		shown, colour = "UnKnown", "#8A7CA0" -- muted, so it reads as "nobody"
	end

	local text = 'Target: <font color="' .. colour .. '">' .. shown .. "</font>"
	if targetPanelLabel.Text ~= text then
		targetPanelLabel.Text = text
	end
end

-- Refreshes the fps readout. No-ops when the counter is off or not built.
function UI:UpdateFPS(fps)
	if not fpsLabel or not fpsPanel or not fpsPanel.Visible then
		return
	end
	local text = string.format('<font color="#843EBE">%d</font> fps', fps or 0)
	if fpsLabel.Text ~= text then
		fpsLabel.Text = text
	end
end

-- Points the watermark at an uploaded image. Accepts a bare id,
-- "rbxassetid://123", or a number; "" (or nil) clears it.
function UI:SetWatermarkImage(id)
	if not watermark then
		return
	end

	local digits = tostring(id or ""):match("%d+")
	watermark.Image = digits and ("rbxassetid://" .. digits) or ""
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

	local toast = newInstance("TextLabel", {
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

	newInstance("UICorner", { Parent = toast, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = toast, Color = COLORS.accent, Thickness = 1, Transparency = 0.3 })

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
	keybindPanel = nil -- destroyed with the ScreenGui below
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

--==============================================================================
-- MAIN CONTROLLER - Entry Point
-- Orchestrates all systems (DebuggerDetection, StringObfuscation, ESP, Camera, UI)
--==============================================================================

-- Assigns to the forward-declared local at the top of the file (no `local` here).
VanityGeneral = {}
VanityGeneral.Version = "0"
VanityGeneral.Config = Configuration
VanityGeneral.StringObfuscation = StringObfuscation
VanityGeneral.DebuggerDetection = DebuggerDetection
VanityGeneral.ProtectedSecrets = ProtectedSecrets

-- Debugger-gated store for anything the app itself needs to keep secret
-- (webhook URLs, remote keys, etc). Reveal-style reads on this manager refuse
-- and log a tampering attempt while a debugger/Studio is attached; fill it in
-- via VanityGeneral.Secrets:register(name, value, level) before Start().
VanityGeneral.Secrets = ProtectedSecrets.createProtectedManager()

--==============================================================================
-- SECURE WEBHOOK
-- On load the script pings a Discord webhook (player name / game / etc). The URL
-- is kept encrypted in memory and only decrypts to actually send when NO
-- debugger/Studio is attached.
--
-- SETUP — pick ONE:
--   (1) EASIEST: paste your webhook URL into WEBHOOK_URL just below. It's stored
--       encrypted in memory on Start; the plaintext only lives in this one line.
--   (2) Runtime: getgenv().VanityGeneral.SetWebhook("https://discord.com/...")
--   (3) No plaintext in the file at all: run
--         getgenv().VanityGeneral.EncryptWebhook("https://discord.com/...")
--       once, then paste the printed line over WEBHOOK_CIPHER below.
--==============================================================================

-- Webhook is configured via the pre-encrypted cipher below (option 3), so no
-- plaintext URL lives in this file. Leave WEBHOOK_URL empty.
local WEBHOOK_URL = ""

local WEBHOOK_LEVEL = 2
local WEBHOOK_CIPHER = { 61, 35, 45, 43, 46, 101, 78, 76, 1, 14, 26, 8, 2, 29, 21, 93, 22, 24, 20, 84, 28, 15, 232, 172, 242, 226, 235, 227, 226, 224, 250, 224, 186, 166, 172, 168, 173, 175, 151, 145, 148, 150, 157, 146, 158, 158, 129, 139, 128, 132, 143, 142, 146, 210, 151, 244, 143, 132, 139, 164, 136, 171, 231, 226, 177, 133, 173, 154, 167, 236, 152, 219, 131, 140, 167, 156, 220, 187, 128, 164, 141, 145, 156, 191, 201, 155, 87, 74, 108, 48, 113, 89, 101, 119, 87, 85, 32, 101, 75, 85, 109, 101, 108, 21, 108, 125, 126, 28, 100, 78, 118, 106, 108, 7, 64, 114, 15, 11, 57, 53, 26 }
local webhookViaManager = false -- true once SetWebhook stores a URL in Secrets

-- Finds whatever HTTP-POST function this executor exposes.
local function resolveHttpRequest()
	local candidates = {
		(syn and syn.request),
		(http and http.request),
		http_request,
		request,
		(fluxus and fluxus.request),
	}
	for _, fn in ipairs(candidates) do
		if type(fn) == "function" then
			return fn
		end
	end
	return nil
end

-- Returns the plaintext URL only when revealing is allowed (no debugger),
-- otherwise nil. Never logs a false tampering hit when no webhook is configured.
local function resolveWebhookUrl()
	if webhookViaManager then
		-- :get is gated inside ProtectedSecrets — nil while debugged.
		local url = VanityGeneral.Secrets:get("webhook_url")
		if url then
			return url
		end
	end
	if #WEBHOOK_CIPHER > 0 then
		if DebuggerDetection.IsBeingDebugged() then
			DebuggerDetection.HandleTamperingAttempt("webhook_reveal_while_debugged", "webhook")
			return nil
		end
		return StringObfuscation.decrypt(WEBHOOK_CIPHER, WEBHOOK_LEVEL)
	end
	return nil
end

-- Store/replace the webhook URL (Option A). Encrypted immediately in memory.
function VanityGeneral.SetWebhook(url, level)
	VanityGeneral.Secrets:clear("webhook_url") -- no-op if not present
	VanityGeneral.Secrets:register("webhook_url", url, level or WEBHOOK_LEVEL)
	webhookViaManager = true
	return true
end

-- Prints a paste-ready encrypted array for WEBHOOK_CIPHER (Option B) so the
-- plaintext URL never has to live in this file.
function VanityGeneral.EncryptWebhook(url, level)
	level = level or WEBHOOK_LEVEL
	local bytes = StringObfuscation.encrypt(url, level)
	print(string.format("-- Paste the two lines below into the SECURE WEBHOOK config (level %d):", level))
	print(string.format("local WEBHOOK_LEVEL = %d", level))
	print("local WEBHOOK_CIPHER = { " .. table.concat(bytes, ", ") .. " }")
	return bytes
end

-- True if either configuration path has a URL available.
function VanityGeneral.HasWebhook()
	return webhookViaManager or #WEBHOOK_CIPHER > 0
end

-- Sends a Discord message. Returns false (never throws) when unconfigured,
-- blocked by the debugger gate, or the executor has no HTTP function.
function VanityGeneral.SendWebhook(content, opts)
	opts = opts or {}

	local url = resolveWebhookUrl()
	if not url then
		return false, "no_webhook_or_blocked"
	end

	local req = resolveHttpRequest()
	if not req then
		warn("[Vanity-General] No HTTP request function available in this executor")
		return false, "no_http"
	end

	local payload = {
		username = opts.username or "Vanity-General",
		avatar_url = opts.avatar_url,
		content = content,
		embeds = opts.embeds,
	}

	local ok, err = pcall(function()
		local body = game:GetService("HttpService"):JSONEncode(payload)
		return req({
			Url = url,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = body,
		})
	end)
	url = nil -- drop the plaintext reference promptly

	if not ok then
		warn("[Vanity-General] Webhook send failed:", err)
		return false, err
	end
	return true
end

-- The nice "loaded" embed. Kept here so both Start and manual calls can reuse it.
function VanityGeneral.SendLoadedEmbed(isDebugged)
	local placeName = "?"
	pcall(function()
		placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	end)

	return VanityGeneral.SendWebhook(nil, {
		embeds = {
			{
				title = "Vanity.dev General loaded",
				color = 8666558, -- accent purple (0x843EBE)
				fields = {
					{ name = "Player", value = "`" .. (LocalPlayer and LocalPlayer.Name or "?") .. "`", inline = true },
					{ name = "Version", value = "`v" .. tostring(VanityGeneral.Version) .. "`", inline = true },
					{ name = "Game", value = placeName, inline = false },
					{ name = "PlaceId", value = "`" .. tostring(game.PlaceId) .. "`", inline = true },
					{ name = "Debugged", value = "`" .. tostring(isDebugged) .. "`", inline = true },
				},
				footer = { text = os.date("%Y-%m-%d %H:%M:%S") },
			},
		},
	})
end

local running = false
local connections = {}
local aimbotSteering = false -- set each frame; tells NoRecoil to stand down
local RECOIL_BIND = "VanityGeneralRecoil" -- BindToRenderStep name (runs after camera)

-- Per-frame crash guard. A raw error inside a RenderStepped handler repeats every
-- frame, flooding the console and tanking FPS. This swallows the error, keeps the
-- rest of the frame running, and reports at most once every few seconds per site.
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
		warn(string.format("[Vanity-General] %s failed (x%d): %s", name, st.failures, tostring(res)))
	end
	return false, nil
end

function VanityGeneral.IsRunning()
	return running
end

-- Config profiles, also usable from the console:
--   VanityGeneral.SaveConfig("legit") / .LoadConfig("legit") / .ListConfigs()
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

-- Sets the watermark logo from an uploaded image id (bare id or rbxassetid://).
-- Persists into config so it survives a menu rebuild.
function VanityGeneral.SetWatermarkImage(id)
	Configuration.UI.WatermarkImageId = tostring(id or "")
	UI:SetWatermarkImage(Configuration.UI.WatermarkImageId)
	return VanityGeneral
end

-- Combined DebuggerDetection + StringObfuscation stats plus current debug state.
function VanityGeneral.GetSecurityReport()
	return ProtectedSecrets.getReport()
end

function VanityGeneral.Start()
	if running then
		return VanityGeneral
	end

	-- Routes through ProtectedSecrets so the same Initialize call that arms
	-- DebuggerDetection also hands back a combined obfuscation+detection report.
	local securityState = ProtectedSecrets.initialize({ enable_monitoring = true })
	if securityState.is_debugged then
		warn("[Vanity-General] Debug environment detected at startup — protected secrets will refuse to reveal until allow_in_studio is set.")
	end

	running = true

	local ok, err = pcall(function()
		ESP:Init()

		UI:Init(Configuration)

		table.insert(connections, Players.PlayerAdded:Connect(function(player)
			guarded("PlayerAdded", ESP.OnPlayerAdded, ESP, player)
		end))

		table.insert(connections, Players.PlayerRemoving:Connect(function(player)
			guarded("PlayerRemoving", ESP.OnPlayerRemoving, ESP, player)
		end))

		table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed or UI:IsCapturingKey() then
				return
			end

			-- Guarded so a bad SyncControls/toggle can't kill the input connection.
			guarded("Keybinds", function()
				-- Data-driven so adding a bind is one row, not another elseif branch.
				local key = input.KeyCode
				if key == Configuration.UI.MenuKey then
					UI:Toggle()
				elseif key == Configuration.UI.UnloadKey then
					VanityGeneral.Stop()
				else
					local toggles = {
						{ Configuration.Camera, "Enabled", Configuration.Camera.ToggleKey },
						{ Configuration.ESP, "Enabled", Configuration.ESP.ToggleKey },
						{ Configuration.Camera, "FOVCircle", Configuration.Camera.FOVCircleKey },
						{ Configuration.NoRecoil, "Enabled", Configuration.NoRecoil.ToggleKey },
						{ Configuration.NoSpread, "Enabled", Configuration.NoSpread.ToggleKey },
						{ Configuration.Triggerbot, "Enabled", Configuration.Triggerbot.ToggleKey },
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

		-- Rolling FPS sample for the counter, refreshed ~4x a second.
		local fpsAccum, fpsFrames = 0, 0

		-- Every subsystem runs behind `guarded`, so one throwing (a destroyed part,
		-- a nil character mid-respawn) can't kill the loop or spam the console.
		table.insert(connections, RunService.RenderStepped:Connect(function(dt)
			guarded("ESP", ESP.Update, ESP, Configuration.ESP)

			local okAim, target = guarded("Aimbot", CameraDirector.Update, CameraDirector, Configuration.Camera, Configuration.Debug)
			if not okAim then
				target = nil
			end

			-- Target Display names whoever you're LOOKING at (walls ignored, ESP
			-- render distance), independent of whether the aimbot has a lock. Only
			-- resolved while the popup is on, so it costs nothing when off.
			if Configuration.UI.TargetDisplay then
				guarded("Target display", function()
					local looking = CameraDirector:GetLookTarget(Configuration.ESP, Configuration.Camera)
					UI:SetCurrentTarget(looking and looking.Name or nil)
				end)
			end

			-- Record whether the aimbot owns the camera this frame (NoRecoil reads it).
			aimbotSteering = Configuration.Camera.Enabled and target ~= nil

			-- Neutralize client-side bullet spread rolls when enabled.
			guarded("NoSpread", NoSpread.Update, NoSpread, Configuration.NoSpread)

			-- Auto-fire when the crosshair is on a target.
			guarded("Triggerbot", Triggerbot.Update, Triggerbot, Configuration.Triggerbot, Configuration.Camera)

			-- Averaging over a window rather than 1/dt keeps the readout steady.
			fpsAccum = fpsAccum + dt
			fpsFrames = fpsFrames + 1
			if fpsAccum >= 0.25 then
				local fps = math.floor(fpsFrames / fpsAccum + 0.5)
				fpsAccum, fpsFrames = 0, 0
				if Configuration.UI.FPSCounter then
					guarded("FPS counter", UI.UpdateFPS, UI, fps)
				end
			end
		end))

		-- Run NoRecoil AFTER the game's camera update (recoil is applied there), so
		-- our correction is the last word each frame and the climb is fully undone.
		-- RenderStepped runs before the camera, which is why the old inline call only
		-- reduced recoil instead of removing it.
		pcall(function()
			RunService:UnbindFromRenderStep(RECOIL_BIND) -- clear any stale bind first
		end)
		pcall(function()
			RunService:BindToRenderStep(RECOIL_BIND, Enum.RenderPriority.Camera.Value + 1, function()
				guarded("NoRecoil", NoRecoil.Update, NoRecoil, Configuration.NoRecoil, aimbotSteering)
			end)
		end)
	end)

	if not ok then
		warn("[Vanity-General] Failed to start:", err)
		VanityGeneral.Stop()
		return VanityGeneral
	end

	UI:Notify(string.format("Vanity-General loaded  •  Press %s", Configuration.UI.MenuKey.Name), 4)

	print(string.format("[Vanity-General] Running (v%s)", VanityGeneral.Version))
	print(string.format("  • StringObfuscation v%s (active)", StringObfuscation.VERSION))
	print(string.format("  • DebuggerDetection v2.0 (monitoring: active, debugged: %s)", tostring(securityState.is_debugged)))
	print(string.format("  • ProtectedSecrets v%s (VanityGeneral.Secrets gated by debugger detection)", ProtectedSecrets.VERSION))
	print(string.format("Menu: %s  |  Camera: %s  |  Unload: %s",
		Configuration.UI.MenuKey.Name,
		Configuration.Camera.ToggleKey.Name,
		Configuration.UI.UnloadKey.Name))

	-- Pick up the pasted WEBHOOK_URL (option 1) if present and not already set.
	if not VanityGeneral.HasWebhook() and type(WEBHOOK_URL) == "string" and WEBHOOK_URL ~= "" then
		pcall(VanityGeneral.SetWebhook, WEBHOOK_URL)
	end

	-- Fire-and-forget "loaded" ping as a Discord embed. No-ops silently if no
	-- webhook is configured or a debugger is attached (the URL won't decrypt).
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
		CameraDirector:Cleanup() -- removes the FOV circle drawing
	end)
	pcall(function()
		NoSpread:Cleanup() -- restore original math.random so no global hook lingers
	end)
	pcall(function()
		ProtectedSecrets.shutdown() -- disconnects the Heartbeat debug monitor
	end)
	NoRecoil:Reset()
	table.clear(guardState) -- fresh error throttling on the next Start

	print("[Vanity-General] Stopped")
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
	if previous and previous ~= VanityGeneral and type(previous.Stop) == "function" then
		pcall(previous.Stop)
	end
	getgenv().VanityGeneral = VanityGeneral
end

-- Auto-start when the file is executed directly (run from the executor's script
-- list, or pasted whole into the console). Harmless if you instead use
-- loadstring(readfile("..."))().Start() — Start() guards against running twice.
-- Wrapped in pcall so a start failure still returns the module for manual use.
pcall(function()
	VanityGeneral.Start()
end)

return VanityGeneral
