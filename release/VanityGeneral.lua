local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({15,109,172,194,27,43,53,130,189})
local Configuration
local ConfigManager
local Utility
local CameraDirector
local ESP
local DrawingESP
local Visuals
local Webhook
local Triggerbot
local SilentAim
local Hitbox
local NoRecoil
local NoSpread
local UI
local Movement
local Controller
Configuration = (function()
local Configuration = {}
Configuration.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Prediction = 0,
Humanize = true,
Hitbox = (_V9({93,12,194,166,116,70,21,170,234,106,4,203,170,111,78,81,171})),
HitboxOptions = { (_V9({93,12,194,166,116,70,21,170,234,106,4,203,170,111,78,81,171})), (_V9({71,8,205,166})), (_V9({91,2,222,177,116})), (_V9({78,31,193,177})), (_V9({67,8,203,177})) },
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
WatermarkImageId = (_V9({62,94,149,250,47,30,3,187,142,55,88,148,250,46,29})),
}
Configuration.Webhook = {
Url = (_V9({})),
}
Configuration.Debug = false
local DEFAULTS = {
Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Prediction = 0,
Humanize = true,
Hitbox = (_V9({93,12,194,166,116,70,21,170,234,106,4,203,170,111,78,81,171})),
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
if type(value) == (_V9({123,12,206,174,126})) then
local target = Configuration[section][key]
if type(target) ~= (_V9({123,12,206,174,126})) then
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
return Configuration
end)()
ConfigManager = (function()
local ConfigManager = {}
local CONFIG_FOLDER = (_V9({89,12,194,171,111,82,114,231,211,106,31,205,174}))
local SAVED_SECTIONS = { (_V9({76,12,193,167,105,74})), (_V9({74,62,252})), (_V9({65,2,254,167,120,68,92,238})), (_V9({65,2,255,178,105,78,84,230})), (_V9({66,2,218,167,118,78,91,246})), (_V9({92,4,192,167,117,95,116,235,208})), (_V9({71,4,216,160,116,83})), (_V9({75,31,205,181,114,69,82})), (_V9({89,4,223,183,122,71,70})), (_V9({90,25,197,174,114,95,76})), (_V9({90,36})) }
local function fsAvailable()
return type(writefile) == (_V9({105,24,194,161,111,66,90,236}))
and type(readfile) == (_V9({105,24,194,161,111,66,90,236}))
and type(listfiles) == (_V9({105,24,194,161,111,66,90,236}))
end
local function ensureFolder()
if type(isfolder) == (_V9({105,24,194,161,111,66,90,236})) and type(makefolder) == (_V9({105,24,194,161,111,66,90,236})) then
if not isfolder(CONFIG_FOLDER) then
pcall(makefolder, CONFIG_FOLDER)
end
end
end
local function sanitizeName(name)
return (tostring(name or (_V9({}))):gsub((_V9({84,51,137,181,68,14,24,162,224})), (_V9({}))):gsub((_V9({81,72,223,233})), (_V9({}))):gsub((_V9({42,30,135,230})), (_V9({}))))
end
local function pathFor(name)
return CONFIG_FOLDER .. (_V9({32,29,222,173,125,66,89,231,226})) .. game.PlaceId .. (_V9({80})) .. name .. (_V9({33,7,223,173,117}))
end
local function legacyPathFor(name)
return CONFIG_FOLDER .. (_V9({32})) .. name .. (_V9({33,7,223,173,117}))
end
local function encodeValue(v)
local t = typeof(v)
if t == (_V9({76,2,192,173,105,24})) then
return { __t = (_V9({76,2,192,173,105,24})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({74,3,217,175,82,95,80,239})) then
return { __t = (_V9({74,3,217,175})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({123,12,206,174,126})) then
local out = {}
for k, val in pairs(v) do
if type(val) ~= (_V9({105,24,194,161,111,66,90,236})) then
local enc = encodeValue(val)
if enc ~= nil then
out[k] = enc
end
end
end
return out
elseif t == (_V9({97,24,193,160,126,89})) or t == (_V9({124,25,222,171,117,76})) or t == (_V9({109,2,195,174,126,74,91})) then
return v
end
return nil
end
local function decodeValue(v)
if type(v) ~= (_V9({123,12,206,174,126})) then
return v
end
if v.__t == (_V9({76,2,192,173,105,24})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({74,3,217,175})) then
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
if type(v) == (_V9({123,12,206,174,126})) and v.__t == nil then
if type(target[k]) == (_V9({123,12,206,174,126})) then
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
if not ok or type(files) ~= (_V9({123,12,206,174,126})) then
return out
end
for _, path in ipairs(files) do
local prefix = (_V9({127,31,195,164,114,71,80,221})) .. game.PlaceId .. (_V9({80}))
local name = tostring(path):match((_V9({39,54,242,237,71,118,30,171,152,33,7,223,173,117,15})))
if name and name:sub(1, #prefix) == prefix then
table.insert(out, name:sub(#prefix + 1))
end
end
table.sort(out)
return out
end
function ConfigManager.save(name, config)
if not fsAvailable() then
return false, (_V9({91,5,197,177,59,78,77,231,222,122,25,195,176,59,67,84,241,157,97,2,140,164,114,71,80,162,252,95,36}))
end
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({74,3,216,167,105,11,84,162,222,96,3,202,171,124,11,91,227,208,106}))
end
ensureFolder()
local data = {}
for _, section in ipairs(SAVED_SECTIONS) do
if type(config[section]) == (_V9({123,12,206,174,126})) then
data[section] = encodeValue(config[section])
end
end
local okJson, json = pcall(function()
return game:GetService((_V9({71,25,216,178,72,78,71,244,212,108,8}))):JSONEncode(data)
end)
if not okJson then
return false, (_V9({74,3,207,173,127,78,21,228,220,102,1,201,166,33,11})) .. tostring(json)
end
local okWrite, err = pcall(writefile, pathFor(name), json)
if not okWrite then
return false, (_V9({88,31,197,182,126,11,83,227,212,99,8,200,248,59})) .. tostring(err)
end
return true, name
end
function ConfigManager.load(name, config)
if not fsAvailable() then
return false, (_V9({91,5,197,177,59,78,77,231,222,122,25,195,176,59,67,84,241,157,97,2,140,164,114,71,80,162,252,95,36}))
end
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({74,3,216,167,105,11,84,162,222,96,3,202,171,124,11,91,227,208,106}))
end
local path = pathFor(name)
if type(isfile) == (_V9({105,24,194,161,111,66,90,236})) then
local okIs, exists = pcall(isfile, path)
if okIs and not exists then
local legacy = legacyPathFor(name)
local okLegacy, legacyExists = pcall(isfile, legacy)
if okLegacy and legacyExists then
path = legacy
else
return false, (_V9({65,2,140,161,116,69,83,235,218,47,3,205,175,126,79,21,165})) .. name .. (_V9({40}))
end
end
end
local okRead, raw = pcall(readfile, path)
if not okRead or type(raw) ~= (_V9({124,25,222,171,117,76})) then
return false, (_V9({93,8,205,166,59,77,84,235,209,106,9}))
end
local okJson, data = pcall(function()
return game:GetService((_V9({71,25,216,178,72,78,71,244,212,108,8}))):JSONDecode(raw)
end)
if not okJson or type(data) ~= (_V9({123,12,206,174,126})) then
return false, (_V9({91,5,205,182,59,77,92,238,216,47,4,223,172,60,95,21,244,220,99,4,200,226,81,120,122,204}))
end
for _, section in ipairs(SAVED_SECTIONS) do
if type(data[section]) == (_V9({123,12,206,174,126})) and type(config[section]) == (_V9({123,12,206,174,126})) then
applyInto(config[section], data[section])
end
end
return true, name
end
function ConfigManager.delete(name)
name = sanitizeName(name)
if name == (_V9({})) then
return false, (_V9({74,3,216,167,105,11,84,162,222,96,3,202,171,124,11,91,227,208,106}))
end
if type(delfile) ~= (_V9({105,24,194,161,111,66,90,236})) then
return false, (_V9({91,5,197,177,59,78,77,231,222,122,25,195,176,59,72,84,236,154,123,77,200,167,119,78,65,231,157,105,4,192,167,104}))
end
local ok, err = pcall(delfile, pathFor(name))
if not ok then
return false, tostring(err)
end
return true, name
end
return ConfigManager
end)()
Utility = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local TeleportService = game:GetService((_V9({91,8,192,167,107,68,71,246,238,106,31,218,171,120,78})))
local LocalPlayer = Players.LocalPlayer
local Utility = {}
local TeleportService = game:GetService((_V9({91,8,192,167,107,68,71,246,238,106,31,218,171,120,78})))
local ut_idleConnection
function Utility:Init(config)
if ut_idleConnection then
return
end
local vu = (type(VirtualUser) ~= (_V9({97,4,192})) and VirtualUser) or nil
if not vu then
pcall(function()
vu = game:GetService((_V9({89,4,222,182,110,74,89,215,206,106,31})))
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
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,238,106,31,218,167,105,11,93,237,205,47,11,205,171,119,78,81,184})), err)
end
return ok
end
function Utility:Rejoin()
local ok, err = pcall(function()
TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)
if not ok then
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,239,106,7,195,171,117,11,83,227,212,99,8,200,248})), err)
end
return ok
end
function Utility.getGuiParent()
local ok, hidden = pcall(function()
return gethui and gethui()
end)
if ok and hidden then
return hidden
end
local ok2, coreGui = pcall(function()
return game:GetService((_V9({76,2,222,167,92,94,92})))
end)
if ok2 and coreGui then
return coreGui
end
return LocalPlayer:WaitForChild((_V9({95,1,205,187,126,89,114,247,212})))
end
return Utility
end)()
CameraDirector = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local Workspace = game:GetService((_V9({88,2,222,169,104,91,84,225,216})))
local LocalPlayer = Players.LocalPlayer
local Utility = Utility
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
if descendant:IsA((_V9({66,2,200,167,119})))
and descendant:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
and not Players:GetPlayerFromCharacter(descendant)
then
table.insert(botCharacters, descendant)
end
end
return botCharacters
end
local Camera = Workspace.CurrentCamera
local cd_rng = Random.new()
local REGION_PARTS = {
Head = { (_V9({71,8,205,166})) },
Torso = { (_V9({90,29,220,167,105,127,90,240,206,96})), (_V9({67,2,219,167,105,127,90,240,206,96})), (_V9({91,2,222,177,116})), (_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})) },
Arms = {
(_V9({67,8,202,182,83,74,91,230})), (_V9({93,4,203,170,111,99,84,236,217})),
(_V9({67,8,202,182,87,68,66,231,207,78,31,193})), (_V9({93,4,203,170,111,103,90,245,216,125,44,222,175})),
(_V9({67,8,202,182,78,91,69,231,207,78,31,193})), (_V9({93,4,203,170,111,126,69,242,216,125,44,222,175})),
(_V9({67,8,202,182,59,106,71,239})), (_V9({93,4,203,170,111,11,116,240,208})),
},
Legs = {
(_V9({67,8,202,182,93,68,90,246})), (_V9({93,4,203,170,111,109,90,237,201})),
(_V9({67,8,202,182,87,68,66,231,207,67,8,203})), (_V9({93,4,203,170,111,103,90,245,216,125,33,201,165})),
(_V9({67,8,202,182,78,91,69,231,207,67,8,203})), (_V9({93,4,203,170,111,126,69,242,216,125,33,201,165})),
(_V9({67,8,202,182,59,103,80,229})), (_V9({93,4,203,170,111,11,121,231,218})),
},
}
local REGION_ORDER = { (_V9({71,8,205,166})), (_V9({91,2,222,177,116})), (_V9({78,31,193,177})), (_V9({67,8,203,177})) }
local rng = Random.new()
local function pickPartFromRegion(character, region)
local names = REGION_PARTS[region]
if not names then
return nil
end
for _, name in ipairs(names) do
local part = character:FindFirstChild(name)
if part and part:IsA((_V9({77,12,223,167,75,74,71,246}))) then
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
if descendant:IsA((_V9({77,12,223,167,75,74,71,246}))) then
return descendant
end
end
return nil
end
local function anchorPart(character)
return character:FindFirstChild((_V9({71,8,205,166})))
or character:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
or character:FindFirstChild((_V9({90,29,220,167,105,127,90,240,206,96})))
or character:FindFirstChild((_V9({91,2,222,177,116})))
or pickAnyPart(character)
end
local function rollWeightedRegion(weights)
local total = 0
for _, region in ipairs(REGION_ORDER) do
total = total + math.max(0, (weights and weights[region]) or 0)
end
if total <= 0 then
return (_V9({71,8,205,166}))
end
local roll = rng:NextNumber() * total
local acc = 0
for _, region in ipairs(REGION_ORDER) do
acc = acc + math.max(0, weights[region] or 0)
if roll <= acc then
return region
end
end
return (_V9({71,8,205,166}))
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
fovGui = Instance.new((_V9({92,14,222,167,126,69,114,247,212})))
fovGui.Name = (_V9({89,12,194,171,111,82,114,231,211,106,31,205,174,93,100,99}))
fovGui.ResetOnSpawn = false
fovGui.IgnoreGuiInset = true
fovGui.DisplayOrder = 998
local ok = pcall(function()
fovGui.Parent = Utility.getGuiParent()
end)
if not ok or not fovGui.Parent then
fovGui.Parent = LocalPlayer:WaitForChild((_V9({95,1,205,187,126,89,114,247,212})))
end
fovRing = Instance.new((_V9({73,31,205,175,126})))
fovRing.Name = (_V9({93,4,194,165}))
fovRing.AnchorPoint = Vector2.new(0.5, 0.5)
fovRing.Position = UDim2.fromScale(0.5, 0.5)
fovRing.BackgroundTransparency = 1
fovRing.BorderSizePixel = 0
fovRing.Parent = fovGui
local corner = Instance.new((_V9({90,36,239,173,105,69,80,240})))
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = fovRing
fovStroke = Instance.new((_V9({90,36,255,182,105,68,94,231})))
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
local humanoid = character:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
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
local myRoot = myChar and myChar:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
local maxRange = (espConfig and espConfig.MaxDistance) or math.huge
local function consider(character, result)
local humanoid = character and character:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
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
if mode and mode ~= (_V9({93,12,194,166,116,70,21,170,234,106,4,203,170,111,78,81,171})) and REGION_PARTS[mode] then
return mode
end
if self._lockedChar ~= character then
self._lockedChar = character
self._rolledRegion = rollWeightedRegion(config.TargetWeights)
end
return self._rolledRegion or (_V9({71,8,205,166}))
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
print((_V9({91,31,205,161,112,66,91,229,135})), target.Character.Name, (_V9({93,8,203,171,116,69,15})), region, (_V9({75,4,223,182,122,69,86,231,135})), math.floor(target.ScreenDistance))
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
CameraDirector.GetBotCharacters = getBotCharacters
return CameraDirector
end)()
ESP = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local Workspace = game:GetService((_V9({88,2,222,169,104,91,84,225,216})))
local LocalPlayer = Players.LocalPlayer
local Configuration = Configuration
local Utility = Utility
local ESP = {}
local entries = {}
local container
local boxGui
local DEPTH = Enum.HighlightDepthMode.AlwaysOnTop
local function isAlive(humanoid)
return humanoid and humanoid.Health > 0
end
local function espRootPart(character)
local hum = character:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
return (hum and hum.RootPart)
or character:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
or character:FindFirstChild((_V9({91,2,222,177,116})))
or character:FindFirstChild((_V9({90,29,220,167,105,127,90,240,206,96})))
or character.PrimaryPart
end
local function getBoxGui()
if boxGui and boxGui.Parent then
return boxGui
end
boxGui = Instance.new((_V9({92,14,222,167,126,69,114,247,212})))
boxGui.Name = (_V9({89,12,194,171,111,82,114,231,211,106,31,205,174,89,68,77,231,206}))
boxGui.ResetOnSpawn = false
boxGui.IgnoreGuiInset = true
boxGui.DisplayOrder = 996
local ok = pcall(function()
boxGui.Parent = Utility.getGuiParent()
end)
if not ok or not boxGui.Parent then
boxGui.Parent = LocalPlayer:WaitForChild((_V9({95,1,205,187,126,89,114,247,212})))
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
local head = character:FindFirstChild((_V9({71,8,205,166})))
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
local tag = Instance.new((_V9({77,4,192,174,121,68,84,240,217,72,24,197})))
tag.Name = (_V9({89,42,229,172,125,68}))
tag.Size = UDim2.fromOffset(200, 46)
tag.StudsOffset = Vector3.new(0, 2.7, 0)
tag.AlwaysOnTop = true
tag.Adornee = head
tag.Parent = head
local holder = Instance.new((_V9({73,31,205,175,126})))
holder.BackgroundTransparency = 1
holder.Size = UDim2.fromScale(1, 1)
holder.Parent = tag
local layout = Instance.new((_V9({90,36,224,171,104,95,121,227,196,96,24,216})))
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Parent = holder
local nameLbl = Instance.new((_V9({91,8,212,182,87,74,87,231,209})))
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
local distLbl = Instance.new((_V9({91,8,212,182,87,74,87,231,209})))
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
local healthBack = Instance.new((_V9({73,31,205,175,126})))
healthBack.LayoutOrder = 3
healthBack.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
healthBack.BackgroundTransparency = 0.3
healthBack.BorderSizePixel = 0
healthBack.Size = UDim2.new(0.55, 0, 0, 5)
healthBack.Visible = false
healthBack.Parent = holder
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = healthBack, CornerRadius = UDim.new(1, 0) })
local healthFill = Instance.new((_V9({73,31,205,175,126})))
healthFill.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
healthFill.BorderSizePixel = 0
healthFill.Size = UDim2.fromScale(1, 1)
healthFill.Parent = healthBack
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = healthFill, CornerRadius = UDim.new(1, 0) })
entry.nameTag = tag
entry.nameLabel = nameLbl
entry.distanceLabel = distLbl
entry.healthBack = healthBack
entry.healthFill = healthFill
entry.nameHead = head
end
local function updateInfoTag(name, entry, character, config)
local head = character:FindFirstChild((_V9({71,8,205,166}))) or character:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
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
local myRoot = myChar and myChar:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
local hrp = character:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
local d = (myRoot and hrp) and math.floor((hrp.Position - myRoot.Position).Magnitude + 0.5) or 0
entry.distanceLabel.Text = (_V9({84})) .. d .. (_V9({98,48}))
end
entry.healthBack.Visible = config.HealthBars
if config.HealthBars then
local humanoid = character:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
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
local myRoot = myChar and myChar:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
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
local hrp = character:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
local humanoid = character:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
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
local highlight = Instance.new((_V9({71,4,203,170,119,66,82,234,201})))
highlight.Name = (_V9({74,62,252,141,110,95,89,235,211,106}))
highlight.Enabled = false
highlight.FillColor = color
highlight.OutlineColor = color
highlight.Parent = container
local box = Instance.new((_V9({73,31,205,175,126})))
box.Name = (_V9({74,62,252,128,116,83}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = getBoxGui()
local boxStroke = Instance.new((_V9({90,36,255,182,105,68,94,231})))
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
if obj:IsA((_V9({71,24,193,163,117,68,92,230}))) then
local model = obj.Parent
if
model
and model:IsA((_V9({66,2,200,167,119})))
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
local humanoid = model:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
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
container = Instance.new((_V9({73,2,192,166,126,89})))
container.Name = (_V9({89,12,194,171,111,82,114,231,211,106,31,205,174,94,120,101}))
local ok = pcall(function()
container.Parent = Utility.getGuiParent()
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
return ESP
end)()
DrawingESP = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local Workspace = game:GetService((_V9({88,2,222,169,104,91,84,225,216})))
local LocalPlayer = Players.LocalPlayer
local DrawingESP = {}
local de_available = type(Drawing) == (_V9({123,12,206,174,126})) and type(Drawing.new) == (_V9({105,24,194,161,111,66,90,236}))
local de_warned = false
local de_entries = {}
local function de_newLine()
local line = Drawing.new((_V9({67,4,194,167})))
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
local humanoid = character and character:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
local root = character and character:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
if not (config.Boxes or config.Tracers) or not root or not (humanoid and humanoid.Health > 0) then
if entry then
de_hide(entry)
end
return
end
local head = character:FindFirstChild((_V9({71,8,205,166})))
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
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,255,96,21,131,150,105,74,86,231,207,47,40,255,146,59,69,80,231,217,124,77,216,170,126,11,113,240,220,120,4,194,165,59,71,92,224,207,110,31,213,226,249,171,161,162,211,96,25,140,163,109,74,92,238,220,109,1,201,226,114,69,21,246,213,102,30,140,167,99,78,86,247,201,96,31,130})))
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
return DrawingESP
end)()
Visuals = (function()
local Lighting = game:GetService((_V9({67,4,203,170,111,66,91,229})))
local Visuals = {}
local Lighting = game:GetService((_V9({67,4,203,170,111,66,91,229})))
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
return Visuals
end)()
Webhook = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local LocalPlayer = Players.LocalPlayer
local Configuration = Configuration
local Webhook = {}
Webhook.Version = (_V9({63}))
local function resolveHttpRequest()
local candidates = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, fn in ipairs(candidates) do
if type(fn) == (_V9({105,24,194,161,111,66,90,236})) then
return fn
end
end
return nil
end
local function resolveWebhookUrl()
local url = Configuration.Webhook.Url
if type(url) == (_V9({124,25,222,171,117,76})) and url ~= (_V9({})) then
return url
end
return nil
end
function Webhook.SetWebhook(url)
Configuration.Webhook.Url = tostring(url or (_V9({})))
return true
end
function Webhook.HasWebhook()
return resolveWebhookUrl() ~= nil
end
function Webhook.SendWebhook(content, opts)
opts = opts or {}
local url = resolveWebhookUrl()
if not url then
return false, (_V9({97,2,243,181,126,73,93,237,210,100}))
end
local req = resolveHttpRequest()
if not req then
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,243,96,77,228,150,79,123,21,240,216,126,24,201,177,111,11,83,247,211,108,25,197,173,117,11,84,244,220,102,1,205,160,119,78,21,235,211,47,25,196,171,104,11,80,250,216,108,24,216,173,105})))
return false, (_V9({97,2,243,170,111,95,69}))
end
local payload = {
username = opts.username or (_V9({89,12,194,171,111,82,24,197,216,97,8,222,163,119})),
avatar_url = opts.avatar_url,
content = content,
embeds = opts.embeds,
}
local ok, err = pcall(function()
local body = game:GetService((_V9({71,25,216,178,72,78,71,244,212,108,8}))):JSONEncode(payload)
return req({
Url = url,
Method = (_V9({95,34,255,150})),
Headers = { [(_V9({76,2,194,182,126,69,65,175,233,118,29,201}))] = (_V9({110,29,220,174,114,72,84,246,212,96,3,131,168,104,68,91})) },
Body = body,
})
end)
url = nil
if not ok then
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,234,106,15,196,173,116,64,21,241,216,97,9,140,164,122,66,89,231,217,53})), err)
return false, err
end
return true
end
function Webhook.SendLoadedEmbed(isDebugged)
local placeName = (_V9({48}))
pcall(function()
placeName = game:GetService((_V9({66,12,222,169,126,95,69,238,220,108,8,255,167,105,93,92,225,216}))):GetProductInfo(game.PlaceId).Name
end)
return Webhook.SendWebhook(nil, {
embeds = {
{
title = (_V9({89,12,194,171,111,82,27,230,216,121,77,235,167,117,78,71,227,209,47,1,195,163,127,78,81})),
color = 8666558,
fields = {
{ name = (_V9({95,1,205,187,126,89})), value = (_V9({111})) .. (LocalPlayer and LocalPlayer.Name or (_V9({48}))) .. (_V9({111})), inline = true },
{ name = (_V9({89,8,222,177,114,68,91})), value = (_V9({111,27})) .. tostring(Webhook.Version) .. (_V9({111})), inline = true },
{ name = (_V9({72,12,193,167})), value = placeName, inline = false },
{ name = (_V9({95,1,205,161,126,98,81})), value = (_V9({111})) .. tostring(game.PlaceId) .. (_V9({111})), inline = true },
{ name = (_V9({75,8,206,183,124,76,80,230})), value = (_V9({111})) .. tostring(isDebugged) .. (_V9({111})), inline = true },
},
footer = { text = os.date((_V9({42,52,129,231,118,6,16,230,157,42,37,150,231,86,17,16,209}))) },
},
},
})
end
return Webhook
end)()
Triggerbot = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local Workspace = game:GetService((_V9({88,2,222,169,104,91,84,225,216})))
local LocalPlayer = Players.LocalPlayer
local Triggerbot = {}
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
if type(mouse1click) == (_V9({105,24,194,161,111,66,90,236})) then
tb_click = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({105,24,194,161,111,66,90,236})) and type(mouse1release) == (_V9({105,24,194,161,111,66,90,236})) then
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
local model = result.Instance:FindFirstAncestorOfClass((_V9({66,2,200,167,119})))
local plr = model and Players:GetPlayerFromCharacter(model)
if not plr or plr == LocalPlayer then
return nil
end
if cameraConfig and cameraConfig.TeamCheck and plr.Team ~= nil and plr.Team == LocalPlayer.Team then
return nil
end
local hum = model:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
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
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,233,125,4,203,165,126,89,87,237,201,47,3,201,167,127,88,21,227,157,98,2,217,177,126,6,86,238,212,108,6,140,164,110,69,86,246,212,96,3,140,234,118,68,64,241,216,62,14,192,171,120,64,28,162,95,143,249,140,172,116,95,21,227,203,110,4,192,163,121,71,80,162,212,97,77,216,170,114,88,21,231,197,106,14,217,182,116,89,27})))
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
return Triggerbot
end)()
SilentAim = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local Workspace = game:GetService((_V9({88,2,222,169,104,91,84,225,216})))
local LocalPlayer = Players.LocalPlayer
local CameraDirector = CameraDirector
local SilentAim = {}
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
return type(checkcaller) == (_V9({105,24,194,161,111,66,90,236})) and not checkcaller()
end
function SilentAim:Init(config)
if sa_installed then
return
end
if type(hookmetamethod) ~= (_V9({105,24,194,161,111,66,90,236})) or type(getnamecallmethod) ~= (_V9({105,24,194,161,111,66,90,236})) then
if not sa_warned then
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,238,102,1,201,172,111,11,116,235,208,47,3,201,167,127,88,21,234,210,96,6,193,167,111,74,88,231,201,103,2,200,226,249,171,161,162,211,96,25,140,163,109,74,92,238,220,109,1,201,226,114,69,21,246,213,102,30,140,167,99,78,86,247,201,96,31,130})))
sa_warned = true
end
return
end
sa_installed = true
local oldNamecall
oldNamecall = hookmetamethod(game, (_V9({80,50,194,163,118,78,86,227,209,99})), function(self, ...)
if config.Enabled and sa_fromGameScript() then
local method = getnamecallmethod()
local part = sa_targetPart()
if part then
if method == (_V9({73,4,222,167,72,78,71,244,216,125})) or method == (_V9({70,3,218,173,112,78,102,231,207,121,8,222})) then
local args = { ... }
for i, value in ipairs(args) do
if typeof(value) == (_V9({89,8,207,182,116,89,6})) then
args[i] = part.Position
elseif typeof(value) == (_V9({76,43,222,163,118,78})) then
args[i] = part.CFrame
end
end
return oldNamecall(self, table.unpack(args))
end
if method == (_V9({93,12,213,161,122,88,65})) and self == Workspace then
local origin, direction, params = ...
if typeof(origin) == (_V9({89,8,207,182,116,89,6})) and typeof(direction) == (_V9({89,8,207,182,116,89,6})) then
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
oldIndex = hookmetamethod(game, (_V9({80,50,197,172,127,78,77})), function(self, key)
if config.Enabled and sa_fromGameScript() and self == mouse then
local part = sa_targetPart()
if part then
if key == (_V9({71,4,216})) then
return part.CFrame
end
if key == (_V9({91,12,222,165,126,95})) then
return part
end
end
end
return oldIndex(self, key)
end)
end
return SilentAim
end)()
Hitbox = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local LocalPlayer = Players.LocalPlayer
local CameraDirector = CameraDirector
local HitboxExpander = {}
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
local humanoid = character and character:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
local root = character and character:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
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
for _, character in ipairs(CameraDirector.GetBotCharacters()) do
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
return HitboxExpander
end)()
NoRecoil = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local UserInputService = game:GetService((_V9({90,30,201,176,82,69,69,247,201,92,8,222,180,114,72,80})))
local Workspace = game:GetService((_V9({88,2,222,169,104,91,84,225,216})))
local LocalPlayer = Players.LocalPlayer
local NoRecoil = {}
local function isFiring()
return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
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
local hum = char and char:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
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
NoRecoil.IsFiring = isFiring
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
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
if type(hookfunction) == (_V9({105,24,194,161,111,66,90,236})) then
return hookfunction
elseif type(replaceclosure) == (_V9({105,24,194,161,111,66,90,236})) then
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
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,243,96,77,255,178,105,78,84,230,157,97,8,201,166,104,11,83,247,211,108,25,197,173,117,11,93,237,210,100,4,194,165,59,3,93,237,210,100,11,217,172,120,95,92,237,211,38,77,78,66,143,11,91,237,201,47,12,218,163,114,71,84,224,209,106,77,197,172,59,95,93,235,206,47,8,212,167,120,94,65,237,207,33})))
ns_warned = true
end
return false
end
ns_installMath(hook)
ns_installRandom(hook)
if not (ns_mathHooked or ns_randHooked) then
if not ns_warned then
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,243,96,77,255,178,105,78,84,230,135,47,11,205,171,119,78,81,162,201,96,77,197,172,104,95,84,238,209,47,12,194,187,59,67,90,237,214,33})))
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
ns_active = (not config.RequireMouseDown) or NoRecoil.IsFiring()
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
return NoSpread
end)()
UI = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local UserInputService = game:GetService((_V9({90,30,201,176,82,69,69,247,201,92,8,222,180,114,72,80})))
local TweenService = game:GetService((_V9({91,26,201,167,117,120,80,240,203,102,14,201})))
local LocalPlayer = Players.LocalPlayer
local ConfigManager = ConfigManager
local Utility = Utility
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
local currentTab = (_V9({76,2,193,160,122,95}))
local layoutOrder = 0
local visible = false
local activeConfig
local onUnloadCallback
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
local btn = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = newInstance((_V9({73,31,205,175,126})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = box, CornerRadius = UDim.new(0, 3) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = box, Color = COLORS.border, Thickness = 1 })
local label = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local holder = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local label = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local track = newInstance((_V9({73,31,205,175,126})), {
Parent = holder,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = track, CornerRadius = UDim.new(1, 0) })
local fill = newInstance((_V9({73,31,205,175,126})), {
Parent = track,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = fill, CornerRadius = UDim.new(1, 0) })
local function format(v)
local base = isInt and tostring(math.floor(v + 0.5)) or string.format((_V9({42,67,158,164})), v)
return base .. suffix
end
local function apply(v)
v = math.clamp(v, min, max)
if isInt then
v = math.floor(v + 0.5)
end
local alpha = (max > min) and (v - min) / (max - min) or 0
fill.Size = UDim2.new(alpha, 0, 1, 0)
label.Text = text .. (_V9({53,77})) .. format(v)
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
local holder = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
ZIndex = 2,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local dropdown = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = dropdown, CornerRadius = UDim.new(0, 4) })
local open = false
local ROW_H = 24
local fullSize = #options * ROW_H
local listSize = math.min(fullSize, 7 * ROW_H)
local list = newInstance((_V9({92,14,222,173,119,71,92,236,218,73,31,205,175,126})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = list, CornerRadius = UDim.new(0, 4) })
for i, option in ipairs(options) do
local optionBtn = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
local holder = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local value = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local btn = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
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
local holder = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local stroke = newInstance((_V9({90,36,255,182,105,68,94,231})), {
Parent = holder,
Color = COLORS.border,
Thickness = 1,
Transparency = 0.3,
})
local box = newInstance((_V9({91,8,212,182,89,68,77})), {
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
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local holder = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
local fill = newInstance((_V9({73,31,205,175,126})), {
Parent = holder,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = COLORS.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = fill, CornerRadius = UDim.new(0, 6) })
local label = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local s = isInt and tostring(math.floor(v + 0.5)) or string.format((_V9({42,67,158,164})), v)
if showMax then
local m = isInt and tostring(math.floor(max + 0.5)) or string.format((_V9({42,67,158,164})), max)
return s .. (_V9({32})) .. m .. unit
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
label.Text = text .. (_V9({53,77})) .. fmt(v)
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
local holder = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
Parent = holder,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local dropdown = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
Parent = holder,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = dropdown, CornerRadius = UDim.new(0, 6) })
local dropStroke = newInstance((_V9({90,36,255,182,105,68,94,231})), {
Parent = dropdown,
Color = COLORS.border,
Thickness = 1,
Transparency = 0.3,
})
local valueLabel = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local caret = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
Parent = dropdown,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.accent,
Text = (_V9({237,251,18})),
})
local open = false
local ROW_H = 26
local fullSize = #options * ROW_H
local listSize = math.min(fullSize, 6 * ROW_H)
local list = newInstance((_V9({92,14,222,173,119,71,92,236,218,73,31,205,175,126})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = list, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = list, Color = COLORS.border, Thickness = 1, Transparency = 0.2 })
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
local optionBtn = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
local holder = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, SQ_H + 74),
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = holder, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = holder,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local heading = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
Parent = holder,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({76,2,192,173,105})),
})
local body = newInstance((_V9({73,31,205,175,126})), {
Parent = holder,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local sq = newInstance((_V9({73,31,205,175,126})), {
Parent = body,
Size = UDim2.new(1, -(HUE_W + GAP), 0, SQ_H),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = sq, CornerRadius = UDim.new(0, 4) })
local satLayer = newInstance((_V9({73,31,205,175,126})), {
Parent = sq,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = satLayer, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({90,36,235,176,122,79,92,231,211,123})), {
Parent = satLayer,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local valLayer = newInstance((_V9({73,31,205,175,126})), {
Parent = sq,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = valLayer, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({90,36,235,176,122,79,92,231,211,123})), {
Parent = valLayer,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local svDot = newInstance((_V9({73,31,205,175,126})), {
Parent = sq,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = svDot, CornerRadius = UDim.new(1, 0) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = svDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local hue = newInstance((_V9({73,31,205,175,126})), {
Parent = body,
Size = UDim2.fromOffset(HUE_W, SQ_H),
Position = UDim2.new(1, -HUE_W, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = hue, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({90,36,235,176,122,79,92,231,211,123})), {
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
local hueDot = newInstance((_V9({73,31,205,175,126})), {
Parent = hue,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = hueDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local preview = newInstance((_V9({73,31,205,175,126})), {
Parent = body,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, SQ_H + 6),
BackgroundColor3 = getColor(),
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = preview, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = preview, Color = COLORS.off, Thickness = 1 })
local hexLabel = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
hexLabel.Text = string.format((_V9({44,72,156,240,67,14,5,176,229,42,93,158,154,59,11,29,167,217,35,77,137,166,55,11,16,230,148})), r, g, b, r, g, b)
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
box.Text = (_V9({95,31,201,177,104,201,181,36}))
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
UI:Notify(string.format((_V9({42,30,140,171,104,11,84,238,207,106,12,200,187,59,73,90,247,211,107,77,216,173,59,14,70})), key.Name, conflict), 2.5)
else
setKey(key)
UI:Notify(string.format((_V9({42,30,140,160,116,94,91,230,157,123,2,140,231,104})), labelText, key.Name), 2)
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
if field ~= (_V9({98,8,194,183})) and config.UI.MenuKey == key then
return (_V9({66,8,194,183}))
end
if field ~= (_V9({110,4,193,160,116,95})) and config.Camera.ToggleKey == key then
return (_V9({78,4,193,160,116,95}))
end
if field ~= (_V9({106,30,220})) and config.ESP.ToggleKey == key then
return (_V9({74,62,252}))
end
if field ~= (_V9({105,2,218,161,114,89,86,238,216})) and config.Camera.FOVCircleKey == key then
return (_V9({73,34,250,226,88,66,71,225,209,106}))
end
if field ~= (_V9({97,2,222,167,120,68,92,238})) and config.NoRecoil.ToggleKey == key then
return (_V9({65,2,140,144,126,72,90,235,209}))
end
if field ~= (_V9({97,2,223,178,105,78,84,230})) and config.NoSpread.ToggleKey == key then
return (_V9({65,2,140,145,107,89,80,227,217}))
end
if field ~= (_V9({123,31,197,165,124,78,71,224,210,123})) and config.Triggerbot.ToggleKey == key then
return (_V9({91,31,197,165,124,78,71,224,210,123}))
end
if field ~= (_V9({108,1,197,161,112,95,69})) and config.Movement.ClickTPKey == key then
return (_V9({76,1,197,161,112,11,97,210}))
end
if field ~= (_V9({122,3,192,173,122,79})) and config.UI.UnloadKey == key then
return (_V9({90,3,192,173,122,79}))
end
return nil
end
local function makeKeybind(parent, labelText, getKey, setKey, conflictCheck)
local holder = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = COLORS.row,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = holder, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local box = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = box, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
newInstance((_V9({90,36,255,171,97,78,118,237,211,124,25,222,163,114,69,65})), { Parent = box, MinSize = Vector2.new(54, 22) })
wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
end
local function makeToggleWithKeybind(parent, text, getValue, onChange, keyLabel, getKey, setKey, conflictCheck)
local btn = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local check = newInstance((_V9({73,31,205,175,126})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = check, CornerRadius = UDim.new(0, 3) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = check, Color = COLORS.border, Thickness = 1 })
local label = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local box = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = box, CornerRadius = UDim.new(0, 4) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
newInstance((_V9({90,36,255,171,97,78,118,237,211,124,25,222,163,114,69,65})), { Parent = box, MinSize = Vector2.new(44, 20) })
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
local col = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
Parent = col,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return col
end
return column(1), column(2)
end
local function makeGroup(parent, title)
local wrapper = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = newInstance((_V9({73,31,205,175,126})), {
Parent = wrapper,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = box, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = box, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local veil = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = veil, CornerRadius = UDim.new(0, 6) })
local STRIPE, GAP = 0.72, 1
local hatch = newInstance((_V9({73,31,205,175,126})), {
Parent = veil,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = COLORS.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = hatch, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({90,36,235,176,122,79,92,231,211,123})), {
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
box:GetPropertyChangedSignal((_V9({78,15,223,173,119,94,65,231,238,102,23,201}))):Connect(syncWrapper)
syncWrapper()
local function setEnabled(enabled)
veil.Visible = not enabled
end
return box, setEnabled
end
local function makeSubTabHost(parent)
local bar = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local divider = newInstance((_V9({73,31,205,175,126})), {
Parent = parent,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = COLORS.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local area = newInstance((_V9({73,31,205,175,126})), {
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
local btn = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
local underline = newInstance((_V9({73,31,205,175,126})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = COLORS.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = newInstance((_V9({92,14,222,173,119,71,92,236,218,73,31,205,175,126})), {
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
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
newInstance((_V9({90,36,252,163,127,79,92,236,218})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
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
local left, right = makeColumns(host:add((_V9({78,4,193,160,116,95}))))
local aim = makeGroup(left, (_V9({78,4,193,160,116,95})))
makeToggleWithKeybind(aim, (_V9({74,3,205,160,119,78,81})), function()
return config.Camera.Enabled
end, function()
config.Camera.Enabled = not config.Camera.Enabled
end, (_V9({78,4,193,160,116,95,21,201,216,118})), function()
return config.Camera.ToggleKey
end, function(key)
config.Camera.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({110,4,193,160,116,95})))
end)
makeToggle(aim, (_V9({89,4,223,161,115,78,86,233})), function()
return config.Camera.WallCheck
end, function()
config.Camera.WallCheck = not config.Camera.WallCheck
end)
makeToggle(aim, (_V9({92,25,197,161,112,82,21,214,220,125,10,201,182})), function()
return config.Camera.StickyTarget
end, function()
config.Camera.StickyTarget = not config.Camera.StickyTarget
end)
makeToggle(aim, (_V9({91,12,222,165,126,95,21,192,210,123,30})), function()
return config.Camera.TargetBots
end, function()
config.Camera.TargetBots = not config.Camera.TargetBots
end)
makeToggle(aim, (_V9({91,8,205,175,59,104,93,231,222,100})), function()
return config.Camera.TeamCheck
end, function()
config.Camera.TeamCheck = not config.Camera.TeamCheck
end)
makeToggle(aim, (_V9({71,24,193,163,117,66,79,231})), function()
return config.Camera.Humanize
end, function()
config.Camera.Humanize = not config.Camera.Humanize
end)
makeToggleWithKeybind(aim, (_V9({73,34,250,226,88,66,71,225,209,106})), function()
return config.Camera.FOVCircle
end, function()
config.Camera.FOVCircle = not config.Camera.FOVCircle
end, (_V9({73,34,250,226,88,66,71,225,209,106,77,231,167,98})), function()
return config.Camera.FOVCircleKey
end, function(key)
config.Camera.FOVCircleKey = key
end, function(key)
return keyConflict(config, key, (_V9({105,2,218,161,114,89,86,238,216})))
end)
makeFillSlider(aim, (_V9({92,0,195,173,111,67,91,231,206,124})), 0.05, 1, function()
return config.Camera.Smoothness
end, function(val)
config.Camera.Smoothness = val
end, false)
makeFillSlider(aim, (_V9({95,31,201,166,114,72,65,235,210,97})), 0, 1, function()
return config.Camera.Prediction
end, function(val)
config.Camera.Prediction = val
end, false)
makeFillSlider(aim, (_V9({73,34,250})), 20, 800, function()
return config.Camera.FOV
end, function(val)
config.Camera.FOV = val
end, true, (_V9({127,21})), true)
makeFillSlider(aim, (_V9({66,12,212,226,95,66,70,246,220,97,14,201})), 100, 2000, function()
return config.Camera.MaxDistance
end, function(val)
config.Camera.MaxDistance = val
end, true, (_V9({98})), true)
local refreshWeightGate
local hitbox = makeGroup(right, (_V9({71,4,216,160,116,83})))
makeDropdownFull(hitbox, config.Camera.HitboxOptions, function()
return config.Camera.Hitbox
end, function(val)
config.Camera.Hitbox = val
if refreshWeightGate then
refreshWeightGate()
end
end)
local weights, setWeightsEnabled = makeGroup(right, (_V9({91,12,222,165,126,95,21,209,216,123,25,197,172,124,88})))
local function weightRow(name)
makeFillSlider(weights, name .. (_V9({47,58,201,171,124,67,65})), 0, 100, function()
return config.Camera.TargetWeights[name]
end, function(val)
config.Camera.TargetWeights[name] = val
end, true, (_V9({42})), true)
end
weightRow((_V9({71,8,205,166})))
weightRow((_V9({91,2,222,177,116})))
weightRow((_V9({78,31,193,177})))
weightRow((_V9({67,8,203,177})))
refreshWeightGate = function()
setWeightsEnabled(config.Camera.Hitbox == (_V9({93,12,194,166,116,70,21,170,234,106,4,203,170,111,78,81,171})))
end
refreshWeightGate()
table.insert(syncHandlers, refreshWeightGate)
local trigger = makeGroup(right, (_V9({91,31,197,165,124,78,71,224,210,123})))
makeToggleWithKeybind(trigger, (_V9({74,3,205,160,119,78,81})), function()
return config.Triggerbot.Enabled
end, function()
config.Triggerbot.Enabled = not config.Triggerbot.Enabled
end, (_V9({91,31,197,165,124,78,71,224,210,123,77,231,167,98})), function()
return config.Triggerbot.ToggleKey
end, function(key)
config.Triggerbot.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({123,31,197,165,124,78,71,224,210,123})))
end)
makeFillSlider(trigger, (_V9({66,4,194,226,95,78,89,227,196})), 0, 500, function()
return config.Triggerbot.MinDelay * 1000
end, function(val)
config.Triggerbot.MinDelay = val / 1000
end, true, (_V9({98,30})), true)
makeFillSlider(trigger, (_V9({66,12,212,226,95,78,89,227,196})), 0, 500, function()
return config.Triggerbot.MaxDelay * 1000
end, function(val)
config.Triggerbot.MaxDelay = val / 1000
end, true, (_V9({98,30})), true)
makeFillSlider(trigger, (_V9({66,12,212,226,95,66,70,246,220,97,14,201})), 100, 2000, function()
return config.Triggerbot.MaxDistance
end, function(val)
config.Triggerbot.MaxDistance = val
end, true, (_V9({98})), true)
makeToggle(trigger, (_V9({89,4,223,161,115,78,86,233})), function()
return config.Triggerbot.WallCheck
end, function()
config.Triggerbot.WallCheck = not config.Triggerbot.WallCheck
end)
local silent = makeGroup(right, (_V9({92,4,192,167,117,95,21,195,212,98})))
makeToggle(silent, (_V9({74,3,205,160,119,78,81})), function()
return config.SilentAim.Enabled
end, function()
config.SilentAim.Enabled = not config.SilentAim.Enabled
end)
local expander = makeGroup(right, (_V9({71,4,216,160,116,83,21,199,197,127,12,194,166,126,89})))
makeToggle(expander, (_V9({74,3,205,160,119,78,81})), function()
return config.Hitbox.Enabled
end, function()
config.Hitbox.Enabled = not config.Hitbox.Enabled
end)
makeFillSlider(expander, (_V9({92,4,214,167})), 1, 20, function()
return config.Hitbox.Size
end, function(val)
config.Hitbox.Size = val
end, true)
makeFillSlider(expander, (_V9({91,31,205,172,104,91,84,240,216,97,14,213})), 0, 1, function()
return config.Hitbox.Transparency
end, function(val)
config.Hitbox.Transparency = val
end, false)
left, right = makeColumns(host:add((_V9({88,8,205,178,116,69,70}))))
local recoil = makeGroup(left, (_V9({65,2,140,144,126,72,90,235,209})))
makeToggleWithKeybind(recoil, (_V9({74,3,205,160,119,78,81})), function()
return config.NoRecoil.Enabled
end, function()
config.NoRecoil.Enabled = not config.NoRecoil.Enabled
end, (_V9({65,2,140,144,126,72,90,235,209,47,38,201,187})), function()
return config.NoRecoil.ToggleKey
end, function(key)
config.NoRecoil.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({97,2,222,167,120,68,92,238})))
end)
makeToggle(recoil, (_V9({64,3,192,187,59,124,93,235,209,106,77,234,171,105,66,91,229})), function()
return config.NoRecoil.RequireMouseDown
end, function()
config.NoRecoil.RequireMouseDown = not config.NoRecoil.RequireMouseDown
end)
makeToggle(recoil, (_V9({78,1,192,173,108,11,116,235,208,47,41,195,181,117})), function()
return config.NoRecoil.AllowAim
end, function()
config.NoRecoil.AllowAim = not config.NoRecoil.AllowAim
end)
makeFillSlider(recoil, (_V9({92,25,222,167,117,76,65,234})), 0, 100, function()
return config.NoRecoil.Strength * 100
end, function(val)
config.NoRecoil.Strength = val / 100
end, true, (_V9({42})), true)
local spread = makeGroup(left, (_V9({65,2,140,145,107,89,80,227,217})))
makeToggleWithKeybind(spread, (_V9({74,3,205,160,119,78,81})), function()
return config.NoSpread.Enabled
end, function()
config.NoSpread.Enabled = not config.NoSpread.Enabled
end, (_V9({65,2,140,145,107,89,80,227,217,47,38,201,187})), function()
return config.NoSpread.ToggleKey
end, function(key)
config.NoSpread.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({97,2,223,178,105,78,84,230})))
end)
makeToggle(spread, (_V9({64,3,192,187,59,124,93,235,209,106,77,234,171,105,66,91,229})), function()
return config.NoSpread.RequireMouseDown
end, function()
config.NoSpread.RequireMouseDown = not config.NoSpread.RequireMouseDown
end)
makeFillSlider(spread, (_V9({92,25,222,167,117,76,65,234})), 0, 100, function()
return config.NoSpread.Strength * 100
end, function(val)
config.NoSpread.Strength = val / 100
end, true, (_V9({42})), true)
end
local function buildESPTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({74,62,252}))))
local esp = makeGroup(left, (_V9({74,62,252})))
makeToggleWithKeybind(esp, (_V9({74,3,205,160,119,78,81})), function()
return config.ESP.Enabled
end, function()
config.ESP.Enabled = not config.ESP.Enabled
end, (_V9({74,62,252,226,80,78,76})), function()
return config.ESP.ToggleKey
end, function(key)
config.ESP.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({106,30,220})))
end)
makeToggle(esp, (_V9({65,61,239,177})), function()
return config.ESP.NPCs
end, function()
config.ESP.NPCs = not config.ESP.NPCs
end)
makeFillSlider(esp, (_V9({66,12,212,226,95,66,70,246,220,97,14,201})), 100, 2000, function()
return config.ESP.MaxDistance
end, function(val)
config.ESP.MaxDistance = val
end, true, (_V9({98})), true)
local look = makeGroup(left, (_V9({78,29,220,167,122,89,84,236,222,106})))
makeToggle(look, (_V9({64,24,216,174,114,69,80,241})), function()
return config.ESP.Outlines
end, function()
config.ESP.Outlines = not config.ESP.Outlines
end)
makeToggle(look, (_V9({77,2,212,167,104})), function()
return config.ESP.Boxes
end, function()
config.ESP.Boxes = not config.ESP.Boxes
end)
makeToggle(look, (_V9({65,12,193,167,104})), function()
return config.ESP.Names
end, function()
config.ESP.Names = not config.ESP.Names
end)
makeToggle(look, (_V9({75,4,223,182,122,69,86,231})), function()
return config.ESP.Distance
end, function()
config.ESP.Distance = not config.ESP.Distance
end)
makeToggle(look, (_V9({71,8,205,174,111,67,21,192,220,125,30})), function()
return config.ESP.HealthBars
end, function()
config.ESP.HealthBars = not config.ESP.HealthBars
end)
makeToggle(look, (_V9({73,4,192,174,126,79})), function()
return config.ESP.Filled
end, function()
config.ESP.Filled = not config.ESP.Filled
end)
makeFillSlider(look, (_V9({64,24,216,174,114,69,80,162,242,127,12,207,171,111,82})), 0, 1, function()
return config.ESP.OutlineOpacity
end, function(val)
config.ESP.OutlineOpacity = val
end, false)
makeFillSlider(look, (_V9({73,4,192,174,59,100,69,227,222,102,25,213})), 0, 1, function()
return config.ESP.FillOpacity
end, function(val)
config.ESP.FillOpacity = val
end, false)
local drawing = makeGroup(right, (_V9({75,31,205,181,114,69,82,162,248,92,61})))
makeToggle(drawing, (_V9({77,2,212,167,104})), function()
return config.Drawing.Boxes
end, function()
config.Drawing.Boxes = not config.Drawing.Boxes
end)
makeToggle(drawing, (_V9({91,31,205,161,126,89,70})), function()
return config.Drawing.Tracers
end, function()
config.Drawing.Tracers = not config.Drawing.Tracers
end)
local world = makeGroup(right, (_V9({88,2,222,174,127})))
makeToggle(world, (_V9({73,24,192,174,121,89,92,229,213,123})), function()
return config.Visuals.Fullbright
end, function()
config.Visuals.Fullbright = not config.Visuals.Fullbright
end)
makeToggle(world, (_V9({65,2,140,132,116,76})), function()
return config.Visuals.NoFog
end, function()
config.Visuals.NoFog = not config.Visuals.NoFog
end)
left, right = makeColumns(host:add((_V9({76,2,192,173,105,88}))))
makeColorPicker(left, (_V9({64,24,216,174,114,69,80,162,254,96,1,195,176})), function()
return config.ESP.OutlineColor
end, function(c)
config.ESP.OutlineColor = c
end)
makeColorPicker(right, (_V9({73,4,192,174,59,104,90,238,210,125})), function()
return config.ESP.FillColor
end, function(c)
config.ESP.FillColor = c
end)
makeColorPicker(left, (_V9({77,2,212,226,88,68,89,237,207})), function()
return config.Drawing.BoxColor
end, function(c)
config.Drawing.BoxColor = c
end)
makeColorPicker(right, (_V9({91,31,205,161,126,89,21,193,210,99,2,222})), function()
return config.Drawing.TracerColor
end, function(c)
config.Drawing.TracerColor = c
end)
end
local function buildMovementTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({66,2,218,167,118,78,91,246}))))
local fly = makeGroup(left, (_V9({73,1,213})))
makeToggle(fly, (_V9({74,3,205,160,119,78,81})), function()
return config.Movement.FlyEnabled
end, function()
config.Movement.FlyEnabled = not config.Movement.FlyEnabled
end)
makeFillSlider(fly, (_V9({73,1,213,226,72,91,80,231,217})), 10, 200, function()
return config.Movement.FlySpeed
end, function(val)
config.Movement.FlySpeed = val
end, true)
local speed = makeGroup(left, (_V9({92,29,201,167,127})))
makeToggle(speed, (_V9({74,3,205,160,119,78,81})), function()
return config.Movement.SpeedEnabled
end, function()
config.Movement.SpeedEnabled = not config.Movement.SpeedEnabled
end)
makeFillSlider(speed, (_V9({92,29,201,167,127})), 16, 100, function()
return config.Movement.Speed
end, function(val)
config.Movement.Speed = val
end, true)
local misc = makeGroup(left, (_V9({64,25,196,167,105})))
makeToggle(misc, (_V9({65,2,207,174,114,91})), function()
return config.Movement.NoclipEnabled
end, function()
config.Movement.NoclipEnabled = not config.Movement.NoclipEnabled
end)
makeToggle(misc, (_V9({70,3,202,171,117,66,65,231,157,69,24,193,178})), function()
return config.Movement.InfJumpEnabled
end, function()
config.Movement.InfJumpEnabled = not config.Movement.InfJumpEnabled
end)
local tp = makeGroup(right, (_V9({76,1,197,161,112,11,97,210})))
makeToggle(tp, (_V9({74,3,205,160,119,78,81})), function()
return config.Movement.ClickTPEnabled
end, function()
config.Movement.ClickTPEnabled = not config.Movement.ClickTPEnabled
end)
makeKeybind(tp, (_V9({66,2,200,171,125,66,80,240,157,68,8,213})), function()
return config.Movement.ClickTPKey
end, function(key)
config.Movement.ClickTPKey = key
end, function(key)
return keyConflict(config, key, (_V9({108,1,197,161,112,95,69})))
end)
end
local function buildSettingsTab(parent, config)
layoutOrder = 0
local host = makeSubTabHost(parent)
local left, right = makeColumns(host:add((_V9({72,8,194,167,105,74,89}))))
local iface = makeGroup(left, (_V9({70,3,216,167,105,77,84,225,216})))
makeFillSlider(iface, (_V9({90,36,140,145,120,74,89,231})), 0.8, 1.5, function()
return config.UI.Scale
end, function(val)
config.UI.Scale = val
if windowScale then
windowScale.Scale = val
end
end, false)
makeToggle(iface, (_V9({68,8,213,160,114,69,81,162,237,110,3,201,174})), function()
return config.UI.KeybindPanel
end, function()
config.UI.KeybindPanel = not config.UI.KeybindPanel
if keybindPanel then
keybindPanel.Visible = config.UI.KeybindPanel
end
end)
makeToggle(iface, (_V9({91,12,222,165,126,95,21,198,212,124,29,192,163,98})), function()
return config.UI.TargetDisplay
end, function()
config.UI.TargetDisplay = not config.UI.TargetDisplay
targetDisplayOn = config.UI.TargetDisplay
if not targetDisplayOn and targetPanel then
targetPanel.Visible = false
end
end)
makeToggle(iface, (_V9({73,61,255,226,88,68,64,236,201,106,31})), function()
return config.UI.FPSCounter
end, function()
config.UI.FPSCounter = not config.UI.FPSCounter
if fpsPanel then
fpsPanel.Visible = config.UI.FPSCounter
end
end)
makeToggle(iface, (_V9({88,12,216,167,105,70,84,240,214})), function()
return config.UI.Watermark
end, function()
config.UI.Watermark = not config.UI.Watermark
if watermark then
watermark.Visible = config.UI.Watermark
end
end)
local account = makeGroup(right, (_V9({78,14,207,173,110,69,65})))
makeLabel(account, (_V9({90,30,201,176,117,74,88,231})), LocalPlayer and LocalPlayer.Name or (_V9({237,237,56})))
makeLabel(account, (_V9({75,4,223,178,119,74,76,162,243,110,0,201})), LocalPlayer and LocalPlayer.DisplayName or (_V9({237,237,56})))
makeLabel(account, (_V9({90,30,201,176,59,98,113})), LocalPlayer and tostring(LocalPlayer.UserId) or (_V9({237,237,56})))
makeToggle(account, (_V9({78,3,216,171,54,106,115,201})), function()
return config.Utility.AntiAFK
end, function()
config.Utility.AntiAFK = not config.Utility.AntiAFK
end)
makeButton(account, (_V9({92,8,222,180,126,89,21,202,210,127})), function()
Utility:ServerHop()
end)
makeButton(account, (_V9({93,8,198,173,114,69,21,209,216,125,27,201,176})), function()
Utility:Rejoin()
end)
left, right = makeColumns(host:add((_V9({76,2,194,164,114,76,70}))))
local cfg = makeGroup(left, (_V9({76,2,194,164,114,76,70})))
if not ConfigManager.isSupported() then
makeLabel(cfg, (_V9({92,25,205,182,110,88})), (_V9({90,3,223,183,107,91,90,240,201,106,9})))
return
end
local nameBox = makeTextBox(cfg, (_V9({108,2,194,164,114,76,21,236,220,98,8,78,66,189})))
local listHolder = newInstance((_V9({73,31,205,175,126})), {
Parent = cfg,
LayoutOrder = nextOrder(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
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
if not child:IsA((_V9({90,36,224,171,104,95,121,227,196,96,24,216}))) then
child:Destroy()
end
end
local names = ConfigManager.list()
if #names == 0 then
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
Parent = listHolder,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = COLORS.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({97,2,140,177,122,93,80,230,157,108,2,194,164,114,76,70})),
})
return
end
for i, name in ipairs(names) do
local selected = (nameBox.Text == name)
local row = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
Text = (_V9({47,77})) .. name,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = row, CornerRadius = UDim.new(0, 4) })
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
makeButton(cfg, (_V9({92,12,218,167})), function()
local ok, res = ConfigManager.save(nameBox.Text, config)
if ok then
UI:Notify((_V9({92,12,218,167,127,11,86,237,211,105,4,203,226,60})) .. res .. (_V9({40})), 2)
refreshList()
else
UI:Notify(tostring(res), 3)
end
end)
makeButton(cfg, (_V9({67,2,205,166})), function()
local ok, res = ConfigManager.load(nameBox.Text, config)
if ok then
if windowScale then
windowScale.Scale = config.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({67,2,205,166,126,79,21,225,210,97,11,197,165,59,12})) .. res .. (_V9({40})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
makeButton(cfg, (_V9({75,8,192,167,111,78})), function()
local ok, res = ConfigManager.delete(nameBox.Text)
if ok then
UI:Notify((_V9({75,8,192,167,111,78,81,162,222,96,3,202,171,124,11,18})) .. res .. (_V9({40})), 2)
nameBox.Text = (_V9({}))
refreshList()
else
UI:Notify(tostring(res), 3)
end
end, COLORS.danger)
refreshList()
end
local function buildTargetPanel(config)
targetPanel = newInstance((_V9({73,31,205,175,126})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = targetPanel, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = targetPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = targetPanel,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
Parent = targetPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local dot = newInstance((_V9({73,31,205,175,126})), {
Parent = targetPanel,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
fpsPanel = newInstance((_V9({73,31,205,175,126})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = fpsPanel, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = fpsPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = fpsPanel,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
Parent = fpsPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local dot = newInstance((_V9({73,31,205,175,126})), {
Parent = fpsPanel,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
fpsLabel = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
Text = (_V9({34,64,140,164,107,88})),
})
table.insert(syncHandlers, function()
if fpsPanel then
fpsPanel.Visible = config.UI.FPSCounter
end
end)
fpsPanel.Visible = config.UI.FPSCounter
end
local function buildWatermark(config)
watermark = newInstance((_V9({70,0,205,165,126,103,84,224,216,99})), {
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
keybindPanel = newInstance((_V9({73,31,205,175,126})), {
Parent = gui,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = COLORS.bg,
BorderSizePixel = 0,
Visible = false,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = keybindPanel, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = keybindPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), {
Parent = keybindPanel,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = keybindPanel,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = newInstance((_V9({73,31,205,175,126})), {
Parent = keybindPanel,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({68,8,213,160,114,69,81,241})),
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
makeKeybind(keybindPanel, (_V9({66,8,194,183})), function()
return config.UI.MenuKey
end, function(key)
config.UI.MenuKey = key
end, function(key)
return keyConflict(config, key, (_V9({98,8,194,183})))
end)
makeKeybind(keybindPanel, (_V9({78,4,193,160,116,95})), function()
return config.Camera.ToggleKey
end, function(key)
config.Camera.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({110,4,193,160,116,95})))
end)
makeKeybind(keybindPanel, (_V9({74,62,252})), function()
return config.ESP.ToggleKey
end, function(key)
config.ESP.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({106,30,220})))
end)
makeKeybind(keybindPanel, (_V9({73,34,250,226,88,66,71,225,209,106})), function()
return config.Camera.FOVCircleKey
end, function(key)
config.Camera.FOVCircleKey = key
end, function(key)
return keyConflict(config, key, (_V9({105,2,218,161,114,89,86,238,216})))
end)
makeKeybind(keybindPanel, (_V9({65,2,140,144,126,72,90,235,209})), function()
return config.NoRecoil.ToggleKey
end, function(key)
config.NoRecoil.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({97,2,222,167,120,68,92,238})))
end)
makeKeybind(keybindPanel, (_V9({65,2,140,145,107,89,80,227,217})), function()
return config.NoSpread.ToggleKey
end, function(key)
config.NoSpread.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({97,2,223,178,105,78,84,230})))
end)
makeKeybind(keybindPanel, (_V9({91,31,197,165,124,78,71,224,210,123})), function()
return config.Triggerbot.ToggleKey
end, function(key)
config.Triggerbot.ToggleKey = key
end, function(key)
return keyConflict(config, key, (_V9({123,31,197,165,124,78,71,224,210,123})))
end)
makeKeybind(keybindPanel, (_V9({90,3,192,173,122,79})), function()
return config.UI.UnloadKey
end, function(key)
config.UI.UnloadKey = key
end, function(key)
return keyConflict(config, key, (_V9({122,3,192,173,122,79})))
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
function UI:Init(config, onUnload)
if gui then
return
end
activeConfig = config
onUnloadCallback = onUnload
startInputRouter()
gui = newInstance((_V9({92,14,222,167,126,69,114,247,212})), {
Name = (_V9({89,12,194,171,111,82,114,231,211,106,31,205,174,78,98})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local ok = pcall(function()
gui.Parent = Utility.getGuiParent()
end)
if not ok or not gui.Parent then
gui.Parent = LocalPlayer:WaitForChild((_V9({95,1,205,187,126,89,114,247,212})))
end
mainWindow = newInstance((_V9({76,12,194,180,122,88,114,240,210,122,29})), {
Parent = gui,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = COLORS.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
windowScale = newInstance((_V9({90,36,255,161,122,71,80})), { Parent = mainWindow, Scale = config.UI.Scale })
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
local titleBar = newInstance((_V9({73,31,205,175,126})), {
Parent = mainWindow,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = titleBar, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({73,31,205,175,126})), {
Parent = titleBar,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = COLORS.bar,
BorderSizePixel = 0,
})
local dot = newInstance((_V9({73,31,205,175,126})), {
Parent = titleBar,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = dot, CornerRadius = UDim.new(1, 0) })
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
Parent = titleBar,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = COLORS.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({89,12,194,171,111,82,9,228,210,97,25,140,161,116,71,90,240,128,45,78,148,246,40,110,119,199,159,49,67,200,167,109,23,26,228,210,97,25,146,226,92,78,91,231,207,110,1}))
.. (_V9({51,11,195,172,111,11,86,237,209,96,31,145,224,56,19,116,181,254,78,93,142,252,59,11,21,64,10,47,77,140,180,43,23,26,228,210,97,25,146})),
ZIndex = 2,
})
newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
local sidebar = newInstance((_V9({73,31,205,175,126})), {
Parent = mainWindow,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = COLORS.panel,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = sidebar, CornerRadius = UDim.new(0, 6) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = sidebar, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = sidebar,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local tabList = newInstance((_V9({73,31,205,175,126})), {
Parent = sidebar,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,224,171,104,95,121,227,196,96,24,216})), { Parent = tabList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local unloadBtn = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
Text = (_V9({90,3,192,173,122,79})),
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = unloadBtn, CornerRadius = UDim.new(0, 6) })
local unloadStroke = newInstance((_V9({90,36,255,182,105,68,94,231})), {
Parent = unloadBtn,
Color = COLORS.danger,
Thickness = 1,
Transparency = 0.55,
})
unloadBtn.MouseButton1Click:Connect(function()
if onUnloadCallback then
onUnloadCallback()
end
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
local content = newInstance((_V9({73,31,205,175,126})), {
Parent = mainWindow,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
newInstance((_V9({90,36,252,163,127,79,92,236,218})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local tabs = { (_V9({76,2,193,160,122,95})), (_V9({89,4,223,183,122,71})), (_V9({66,2,218,167,118,78,91,246})), (_V9({92,8,216,182,114,69,82,241})) }
local tabFrames = {}
for i, tabName in ipairs(tabs) do
local isActive = currentTab == tabName
local tabBtn = newInstance((_V9({91,8,212,182,89,94,65,246,210,97})), {
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
Text = (_V9({47,77,140,226})) .. tabName,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = tabBtn, CornerRadius = UDim.new(0, 6) })
local stripe = newInstance((_V9({73,31,205,175,126})), {
Parent = tabBtn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = COLORS.accent,
BorderSizePixel = 0,
Visible = isActive,
ZIndex = 2,
})
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local tabFrame = newInstance((_V9({73,31,205,175,126})), {
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
buildCameraTab(tabFrames[(_V9({76,2,193,160,122,95}))].frame, config)
buildESPTab(tabFrames[(_V9({89,4,223,183,122,71}))].frame, config)
buildMovementTab(tabFrames[(_V9({66,2,218,167,118,78,91,246}))].frame, config)
buildSettingsTab(tabFrames[(_V9({92,8,216,182,114,69,82,241}))].frame, config)
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
if name and name ~= (_V9({})) and name ~= (_V9({65,2,194,167})) then
shown, colour = name, (_V9({44,85,152,241,94,105,112}))
else
shown, colour = (_V9({90,3,231,172,116,92,91})), (_V9({44,85,237,245,88,106,5}))
end
local text = (_V9({91,12,222,165,126,95,15,162,129,105,2,194,182,59,72,90,238,210,125,80,142})) .. colour .. (_V9({45,83})) .. shown .. (_V9({51,66,202,173,117,95,11}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(fps)
if not fpsLabel or not fpsPanel or not fpsPanel.Visible then
return
end
local text = string.format((_V9({51,11,195,172,111,11,86,237,209,96,31,145,224,56,19,1,177,248,77,40,142,252,62,79,9,173,219,96,3,216,252,59,77,69,241})), fps or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(id)
if not watermark then
return
end
local digits = tostring(id or (_V9({}))):match((_V9({42,9,135})))
watermark.Image = digits and ((_V9({125,15,212,163,104,88,80,246,212,107,87,131,237})) .. digits) or (_V9({}))
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
local toast = newInstance((_V9({91,8,212,182,87,74,87,231,209})), {
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
newInstance((_V9({90,36,239,173,105,69,80,240})), { Parent = toast, CornerRadius = UDim.new(0, 8) })
newInstance((_V9({90,36,255,182,105,68,94,231})), { Parent = toast, Color = COLORS.accent, Thickness = 1, Transparency = 0.3 })
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
return UI
end)()
Movement = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local UserInputService = game:GetService((_V9({90,30,201,176,82,69,69,247,201,92,8,222,180,114,72,80})))
local Workspace = game:GetService((_V9({88,2,222,169,104,91,84,225,216})))
local LocalPlayer = Players.LocalPlayer
local UI = UI
local Movement = {}
local BASE_WALKSPEED = 16
local JUMP_VELOCITY = 50
local mv_jumpConnection
local mv_clickConnection
local function mv_character()
local character = LocalPlayer.Character
local root = character and character:FindFirstChild((_V9({71,24,193,163,117,68,92,230,239,96,2,216,146,122,89,65})))
local humanoid = character and character:FindFirstChildOfClass((_V9({71,24,193,163,117,68,92,230})))
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
if part:IsA((_V9({77,12,223,167,75,74,71,246}))) then
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
return Movement
end)()
Controller = (function()
local Players = game:GetService((_V9({95,1,205,187,126,89,70})))
local RunService = game:GetService((_V9({93,24,194,145,126,89,67,235,222,106})))
local UserInputService = game:GetService((_V9({90,30,201,176,82,69,69,247,201,92,8,222,180,114,72,80})))
local LocalPlayer = Players.LocalPlayer
local Configuration = Configuration
local ConfigManager = ConfigManager
local CameraDirector = CameraDirector
local HitboxExpander = Hitbox
local SilentAim = SilentAim
local NoRecoil = NoRecoil
local NoSpread = NoSpread
local Triggerbot = Triggerbot
local ESP = ESP
local DrawingESP = DrawingESP
local Visuals = Visuals
local Utility = Utility
local UI = UI
local Movement = Movement
local Webhook = Webhook
local Controller = {}
Controller.Version = (_V9({63}))
Controller.Config = Configuration
Webhook.Version = Controller.Version
local running = false
local connections = {}
local aimbotSteering = false
local RECOIL_BIND = (_V9({89,12,194,171,111,82,114,231,211,106,31,205,174,73,78,86,237,212,99}))
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
warn(string.format((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,152,124,77,202,163,114,71,80,230,157,39,21,137,166,50,17,21,167,206})), name, st.failures, tostring(res)))
end
return false, nil
end
function Controller.IsRunning()
return running
end
function Controller.SaveConfig(name)
return ConfigManager.save(name, Configuration)
end
function Controller.LoadConfig(name)
local ok, res = ConfigManager.load(name, Configuration)
if ok then
pcall(function()
UI:SyncControls()
end)
end
return ok, res
end
function Controller.ListConfigs()
return ConfigManager.list()
end
function Controller.DeleteConfig(name)
return ConfigManager.delete(name)
end
function Controller.ServerHop()
return Utility:ServerHop()
end
function Controller.Rejoin()
return Utility:Rejoin()
end
function Controller.SetWatermarkImage(id)
Configuration.UI.WatermarkImageId = tostring(id or (_V9({})))
UI:SetWatermarkImage(Configuration.UI.WatermarkImageId)
return Controller
end
function Controller.SetWebhook(url)
return Webhook.SetWebhook(url)
end
function Controller.HasWebhook()
return Webhook.HasWebhook()
end
function Controller.SendWebhook(content, opts)
return Webhook.SendWebhook(content, opts)
end
function Controller.SendLoadedEmbed(isDebugged)
return Webhook.SendLoadedEmbed(isDebugged)
end
function Controller.Start()
if running then
return Controller
end
running = true
local ok, err = pcall(function()
ESP:Init()
UI:Init(Configuration, function()
Controller.Stop()
end)
Movement:Init(Configuration.Movement)
SilentAim:Init(Configuration.SilentAim)
Utility:Init(Configuration.Utility)
table.insert(connections, Players.PlayerAdded:Connect(function(player)
guarded((_V9({95,1,205,187,126,89,116,230,217,106,9})), ESP.OnPlayerAdded, ESP, player)
end))
table.insert(connections, Players.PlayerRemoving:Connect(function(player)
guarded((_V9({95,1,205,187,126,89,103,231,208,96,27,197,172,124})), ESP.OnPlayerRemoving, ESP, player)
end))
table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed or UI:IsCapturingKey() then
return
end
guarded((_V9({68,8,213,160,114,69,81,241})), function()
local key = input.KeyCode
if key == Configuration.UI.MenuKey then
UI:Toggle()
elseif key == Configuration.UI.UnloadKey then
Controller.Stop()
else
local toggles = {
{ Configuration.Camera, (_V9({74,3,205,160,119,78,81})), Configuration.Camera.ToggleKey },
{ Configuration.ESP, (_V9({74,3,205,160,119,78,81})), Configuration.ESP.ToggleKey },
{ Configuration.Camera, (_V9({73,34,250,129,114,89,86,238,216})), Configuration.Camera.FOVCircleKey },
{ Configuration.NoRecoil, (_V9({74,3,205,160,119,78,81})), Configuration.NoRecoil.ToggleKey },
{ Configuration.NoSpread, (_V9({74,3,205,160,119,78,81})), Configuration.NoSpread.ToggleKey },
{ Configuration.Triggerbot, (_V9({74,3,205,160,119,78,81})), Configuration.Triggerbot.ToggleKey },
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
guarded((_V9({74,62,252})), ESP.Update, ESP, Configuration.ESP)
local okAim, target = guarded((_V9({78,4,193,160,116,95})), CameraDirector.Update, CameraDirector, Configuration.Camera, Configuration.Debug)
if not okAim then
target = nil
end
if Configuration.UI.TargetDisplay then
guarded((_V9({91,12,222,165,126,95,21,230,212,124,29,192,163,98})), function()
local looking = CameraDirector:GetLookTarget(Configuration.ESP, Configuration.Camera)
UI:SetCurrentTarget(looking and looking.Name or nil)
end)
end
aimbotSteering = Configuration.Camera.Enabled and target ~= nil
guarded((_V9({65,2,255,178,105,78,84,230})), NoSpread.Update, NoSpread, Configuration.NoSpread)
guarded((_V9({91,31,197,165,124,78,71,224,210,123})), Triggerbot.Update, Triggerbot, Configuration.Triggerbot, Configuration.Camera)
guarded((_V9({66,2,218,167,118,78,91,246})), Movement.Update, Movement, dt, Configuration.Movement)
guarded((_V9({71,4,216,160,116,83})), HitboxExpander.Update, HitboxExpander, Configuration.Hitbox, Configuration.Camera)
guarded((_V9({75,31,205,181,114,69,82,162,248,92,61})), DrawingESP.Update, DrawingESP, Configuration.Drawing, Configuration.Camera)
guarded((_V9({89,4,223,183,122,71,70})), Visuals.Update, Visuals, Configuration.Visuals)
fpsAccum = fpsAccum + dt
fpsFrames = fpsFrames + 1
if fpsAccum >= 0.25 then
local fps = math.floor(fpsFrames / fpsAccum + 0.5)
fpsAccum, fpsFrames = 0, 0
if Configuration.UI.FPSCounter then
guarded((_V9({73,61,255,226,120,68,64,236,201,106,31})), UI.UpdateFPS, UI, fps)
end
end
end))
pcall(function()
RunService:UnbindFromRenderStep(RECOIL_BIND)
end)
pcall(function()
RunService:BindToRenderStep(RECOIL_BIND, Enum.RenderPriority.Camera.Value + 1, function()
guarded((_V9({65,2,254,167,120,68,92,238})), NoRecoil.Update, NoRecoil, Configuration.NoRecoil, aimbotSteering)
end)
end)
end)
if not ok then
warn((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,251,110,4,192,167,127,11,65,237,157,124,25,205,176,111,17})), err)
Controller.Stop()
return Controller
end
if getgenv then
getgenv().VanityGeneral = Controller
end
UI:Notify(string.format((_V9({89,12,194,171,111,82,24,197,216,97,8,222,163,119,11,89,237,220,107,8,200,226,59,201,181,32,157,47,61,222,167,104,88,21,167,206})), Configuration.UI.MenuKey.Name), 4)
print(string.format((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,239,122,3,194,171,117,76,21,170,203,42,30,133})), Controller.Version))
print(string.format((_V9({66,8,194,183,33,11,16,241,157,47,17,140,226,88,74,88,231,207,110,87,140,231,104,11,21,254,157,47,56,194,174,116,74,81,184,157,42,30})),
Configuration.UI.MenuKey.Name,
Configuration.Camera.ToggleKey.Name,
Configuration.UI.UnloadKey.Name))
if Webhook.HasWebhook() then
task.spawn(function()
Webhook.SendLoadedEmbed(false)
end)
end
return Controller
end
function Controller.Stop()
if not running then
return Controller
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
NoRecoil:Reset()
table.clear(guardState)
print((_V9({84,59,205,172,114,95,76,175,250,106,3,201,176,122,71,104,162,238,123,2,220,178,126,79})))
return Controller
end
function Controller.Toggle()
if running then
Controller.Stop()
else
Controller.Start()
end
return Controller
end
Controller.start = Controller.Start
Controller.stop = Controller.Stop
Controller.toggle = Controller.Toggle
return Controller
end)()
do
local Controller = Controller
if getgenv then
local previous = getgenv().VanityGeneral
if previous and previous ~= Controller and type(previous.Stop) == (_V9({105,24,194,161,111,66,90,236})) then
pcall(previous.Stop)
end
end
pcall(function()
Controller.Start()
end)
return Controller
end
