local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({8,34,138,253,249,58,186,198,57})
local _v11
local _v13
local _v12
local _v46
local _v10
local _v9
local ESP
local _v17
local Visuals
local _v48
local Triggerbot
local SilentAim
local Hitbox
local NoRecoil
local NoSpread
local UI
local Movement
local _v14
_v11 = (function()
local _v11 = {}
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local _v385 = setmetatable({}, { __mode = (_V9({99})) })
local _v386 = 0
local _v214 = {}
local _v28 = (_V9({105,64,233,153,156,92,221,174,80,98,73,230,144,151,85,202,183,75,123,86,255,139,142,66,195,188,120,74,97,206,184,191,125,242,143,115,67,110,199,179,182,106,235,148,106,92,119,220,170,161,99,224}))
function _v11.RandomName(_v257)
_v257 = _v257 or 14
local _v361 = {}
for i = 1, _v257 do
local n = math.random(1, #_v28)
_v361[i] = string.sub(_v28, n, n)
end
return table.concat(_v361)
end
function _v11.CClosure(_v183)
if type(newcclosure) == (_V9({110,87,228,158,141,83,213,168})) then
local _v337, wrapped = pcall(newcclosure, _v183)
if _v337 and type(wrapped) == (_V9({110,87,228,158,141,83,213,168})) then
return wrapped
end
end
return _v183
end
local function _v176(_v232)
local _v337, exposed = pcall(function()
if _v232:IsDescendantOf(_v49) then
return true
end
local _v374 = _v27 and _v27:FindFirstChild((_V9({88,78,235,132,156,72,253,179,80})))
return _v374 ~= nil and _v232:IsDescendantOf(_v374)
end)
return _v337 and exposed == true
end
function _v11.Protect(_v232)
if not _v385[_v232] then
_v385[_v232] = true
_v386 = _v386 + 1
end
if _v176(_v232) then
_v11.Install()
end
return _v232
end
local function _v238(_v232)
local _v319 = _v232
while _v319 and _v319 ~= game do
if _v385[_v319] then
return true
end
_v319 = _v319.Parent
end
return false
end
function _v11.HideGlobal(name, value)
_v214[name] = value
if type(getgenv) ~= (_V9({110,87,228,158,141,83,213,168})) then
return false
end
local _v337, env = pcall(getgenv)
if not _v337 or type(env) ~= (_V9({124,67,232,145,156})) then
return false
end
pcall(function()
if rawget(env, name) ~= nil then
rawset(env, name, nil)
end
end)
local _v338 = pcall(function()
local _v298 = getmetatable(env)
local _v346 = _v298 and rawget(_v298, (_V9({87,125,227,147,157,95,194})))
local _v317 = {}
if _v298 then
for k, v in pairs(_v298) do
_v317[k] = v
end
end
_v317.__index = function(_, _v244)
local hidden = _v214[_v244]
if hidden ~= nil then
return hidden
end
if type(_v346) == (_V9({110,87,228,158,141,83,213,168})) then
return _v346(env, _v244)
elseif type(_v346) == (_V9({124,67,232,145,156})) then
return _v346[_v244]
end
return nil
end
setmetatable(env, _v317)
end)
return _v338
end
local _v233 = false
local _v19 = {
GetChildren = true,
GetDescendants = true,
FindFirstChild = true,
FindFirstChildOfClass = true,
FindFirstChildWhichIsA = true,
}
function _v11.Install()
if _v233 then
return
end
if type(hookmetamethod) ~= (_V9({110,87,228,158,141,83,213,168})) or type(getnamecallmethod) ~= (_V9({110,87,228,158,141,83,213,168})) then
return
end
if type(checkcaller) ~= (_V9({110,87,228,158,141,83,213,168})) then
return
end
local _v347
local _v337 = pcall(function()
_v347 = hookmetamethod(game, (_V9({87,125,228,156,148,95,217,167,85,100})), _v11.CClosure(function(self, ...)
local _v288 = getnamecallmethod()
if _v386 > 0 and _v288 and _v19[_v288] and not checkcaller() then
local res = _v347(self, ...)
if _v288 == (_V9({79,71,254,190,145,83,214,162,75,109,76})) or _v288 == (_V9({79,71,254,185,156,73,217,163,87,108,67,228,137,138})) then
local _v243 = {}
for i = 1, #res do
if not _v238(res[i]) then
_v243[#_v243 + 1] = res[i]
end
end
return _v243
end
if typeof(res) == (_V9({65,76,249,137,152,84,217,163})) and _v238(res) then
return nil
end
return res
end
return _v347(self, ...)
end))
end)
_v233 = _v337
end
return _v11
end)()
_v13 = (function()
local _v13 = {}
_v13.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({90,67,228,153,150,87,154,238,110,109,75,237,149,141,95,222,239})),
HitboxOptions = { (_V9({90,67,228,153,150,87,154,238,110,109,75,237,149,141,95,222,239})), (_V9({64,71,235,153})), (_V9({92,77,248,142,150})), (_V9({73,80,231,142})), (_V9({68,71,237,142})) },
TargetWeights = {
Head = 85,
Torso = 15,
Arms = 0,
Legs = 0,
},
WallCheck = true,
TargetBots = false,
TeamCheck = true,
FOVCircle = false,
ToggleKey = Enum.KeyCode.LeftAlt,
FOVCircleKey = Enum.KeyCode.F1,
}
_v13.NoRecoil = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
AllowAim = false,
ToggleKey = Enum.KeyCode.F2,
}
_v13.NoSpread = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
ToggleKey = Enum.KeyCode.F3,
}
_v13.Triggerbot = {
Enabled = false,
MinDelay = 0.1,
MaxDelay = 0.25,
MaxDistance = 1000,
WallCheck = true,
ToggleKey = Enum.KeyCode.F4,
}
_v13.Movement = {
FlyEnabled = false,
FlySpeed = 50,
NoclipEnabled = false,
SpeedEnabled = false,
Speed = 16,
InfJumpEnabled = false,
ClickTPEnabled = false,
ClickTPKey = Enum.KeyCode.LeftControl,
}
_v13.SilentAim = {
Enabled = false,
MaxAngle = 30,
HitChance = 100,
}
_v13.Hitbox = {
Enabled = false,
Size = 5,
Transparency = 0.5,
}
_v13.Drawing = {
Boxes = false,
Tracers = false,
BoxColor = Color3.fromRGB(165, 75, 255),
TracerColor = Color3.fromRGB(255, 255, 255),
}
_v13.Visuals = {
Fullbright = false,
NoFog = false,
}
_v13.ESP = {
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
_v13.UI = {
Scale = 1,
MenuKey = Enum.KeyCode.RightShift,
UnloadKey = Enum.KeyCode.End,
Visible = false,
Accent = Color3.fromRGB(132, 62, 190),
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
WatermarkImageId = (_V9({57,17,179,197,205,15,140,255,10,48,23,178,197,204,12})),
}
_v13.Webhook = {
Url = (_V9({})),
}
_v13.Debug = false
local _v15 = {
Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({90,67,228,153,150,87,154,238,110,109,75,237,149,141,95,222,239})),
TargetWeights = { Head = 85, Torso = 15, Arms = 0, Legs = 0 },
WallCheck = true,
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
SilentAim = { Enabled = false, MaxAngle = 30, HitChance = 100 },
Hitbox = { Enabled = false, Size = 5, Transparency = 0.5 },
Drawing = {
Boxes = false,
Tracers = false,
BoxColor = Color3.fromRGB(165, 75, 255),
TracerColor = Color3.fromRGB(255, 255, 255),
},
Visuals = { Fullbright = false, NoFog = false },
UI = {
Scale = 1,
Accent = Color3.fromRGB(132, 62, 190),
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
},
}
function _v13.reset()
for _v430, _v519 in pairs(_v15) do
for _v244, value in pairs(_v519) do
if type(value) == (_V9({124,67,232,145,156})) then
local target = _v13[_v430][_v244]
if type(target) ~= (_V9({124,67,232,145,156})) then
target = {}
_v13[_v430][_v244] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v13[_v430][_v244] = value
end
end
end
end
return _v13
end)()
_v12 = (function()
local _v12 = {}
local _v8 = (_V9({94,67,228,148,141,67,253,163,87,109,80,235,145}))
local _v38 = { (_V9({75,67,231,152,139,91})), (_V9({77,113,218})), (_V9({70,77,216,152,154,85,211,170})), (_V9({70,77,217,141,139,95,219,162})), (_V9({69,77,252,152,148,95,212,178})), (_V9({91,75,230,152,151,78,251,175,84})), (_V9({64,75,254,159,150,66})), (_V9({76,80,235,138,144,84,221})), (_V9({94,75,249,136,152,86,201})), (_V9({93,107})) }
local function _v192()
return type(writefile) == (_V9({110,87,228,158,141,83,213,168}))
and type(readfile) == (_V9({110,87,228,158,141,83,213,168}))
and type(listfiles) == (_V9({110,87,228,158,141,83,213,168}))
end
local function _v166()
if type(isfolder) == (_V9({110,87,228,158,141,83,213,168})) and type(makefolder) == (_V9({110,87,228,158,141,83,213,168})) then
if not isfolder(_v8) then
pcall(makefolder, _v8)
end
end
end
local function _v425(name)
return (tostring(name or (_V9({}))):gsub((_V9({83,124,175,138,166,31,151,230,100})), (_V9({}))):gsub((_V9({86,7,249,214})), (_V9({}))):gsub((_V9({45,81,161,217})), (_V9({}))))
end
local function _v366(name)
return _v8 .. (_V9({39,82,248,146,159,83,214,163,102})) .. game.PlaceId .. (_V9({87})) .. name .. (_V9({38,72,249,146,151}))
end
local function _v256(name)
return _v8 .. (_V9({39})) .. name .. (_V9({38,72,249,146,151}))
end
local function _v165(v)
local t = typeof(v)
if t == (_V9({75,77,230,146,139,9})) then
return { __t = (_V9({75,77,230,146,139,9})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({77,76,255,144,176,78,223,171})) then
return { __t = (_V9({77,76,255,144})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({124,67,232,145,156})) then
local _v361 = {}
for k, _v516 in pairs(v) do
if type(_v516) ~= (_V9({110,87,228,158,141,83,213,168})) then
local _v164 = _v165(_v516)
if _v164 ~= nil then
_v361[k] = _v164
end
end
end
return _v361
elseif t == (_V9({102,87,231,159,156,72})) or t == (_V9({123,86,248,148,151,93})) or t == (_V9({106,77,229,145,156,91,212})) then
return v
end
return nil
end
local function _v138(v)
if type(v) ~= (_V9({124,67,232,145,156})) then
return v
end
if v.__t == (_V9({75,77,230,146,139,9})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({77,76,255,144})) then
local _v337, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v337 then
return item
end
return nil
end
return v
end
local function _v70(target, _v452)
for k, v in pairs(_v452) do
if type(v) == (_V9({124,67,232,145,156})) and v.__t == nil then
if type(target[k]) == (_V9({124,67,232,145,156})) then
_v70(target[k], v)
end
else
local _v139 = _v138(v)
if _v139 ~= nil then
target[k] = _v139
end
end
end
end
function _v12.isSupported()
return _v192()
end
function _v12.list()
local _v361 = {}
if not _v192() then
return _v361
end
_v166()
local _v337, files = pcall(listfiles, _v8)
if not _v337 or type(files) ~= (_V9({124,67,232,145,156})) then
return _v361
end
for _, _v365 in ipairs(files) do
local _v380 = (_V9({120,80,229,155,144,86,223,153})) .. game.PlaceId .. (_V9({87}))
local name = tostring(_v365):match((_V9({32,121,212,210,165,103,145,239,28,38,72,249,146,151,30})))
if name and name:sub(1, #_v380) == _v380 then
table.insert(_v361, name:sub(#_v380 + 1))
end
end
table.sort(_v361)
return _v361
end
function _v12.save(name, _v119)
if not _v192() then
return false, (_V9({92,74,227,142,217,95,194,163,90,125,86,229,143,217,82,219,181,25,102,77,170,155,144,86,223,230,120,88,107}))
end
name = _v425(name)
if name == (_V9({})) then
return false, (_V9({77,76,254,152,139,26,219,230,90,103,76,236,148,158,26,212,167,84,109}))
end
_v166()
local data = {}
for _, _v430 in ipairs(_v38) do
if type(_v119[_v430]) == (_V9({124,67,232,145,156})) then
data[_v430] = _v165(_v119[_v430])
end
end
local _v341, json = pcall(function()
return game:GetService((_V9({64,86,254,141,170,95,200,176,80,107,71}))):JSONEncode(data)
end)
if not _v341 then
return false, (_V9({77,76,233,146,157,95,154,160,88,97,78,239,153,195,26})) .. tostring(json)
end
local _v344, err = pcall(writefile, _v366(name), json)
if not _v344 then
return false, (_V9({95,80,227,137,156,26,220,167,80,100,71,238,199,217})) .. tostring(err)
end
return true, name
end
function _v12.load(name, _v119)
if not _v192() then
return false, (_V9({92,74,227,142,217,95,194,163,90,125,86,229,143,217,82,219,181,25,102,77,170,155,144,86,223,230,120,88,107}))
end
name = _v425(name)
if name == (_V9({})) then
return false, (_V9({77,76,254,152,139,26,219,230,90,103,76,236,148,158,26,212,167,84,109}))
end
local _v365 = _v366(name)
if type(isfile) == (_V9({110,87,228,158,141,83,213,168})) then
local _v340, exists = pcall(isfile, _v365)
if _v340 and not exists then
local _v255 = _v256(name)
local _v342, legacyExists = pcall(isfile, _v255)
if _v342 and legacyExists then
_v365 = _v255
else
return false, (_V9({70,77,170,158,150,84,220,175,94,40,76,235,144,156,94,154,225})) .. name .. (_V9({47}))
end
end
end
local _v343, raw = pcall(readfile, _v365)
if not _v343 or type(raw) ~= (_V9({123,86,248,148,151,93})) then
return false, (_V9({90,71,235,153,217,92,219,175,85,109,70}))
end
local _v341, data = pcall(function()
return game:GetService((_V9({64,86,254,141,170,95,200,176,80,107,71}))):JSONDecode(raw)
end)
if not _v341 or type(data) ~= (_V9({124,67,232,145,156})) then
return false, (_V9({92,74,235,137,217,92,211,170,92,40,75,249,147,222,78,154,176,88,100,75,238,221,179,105,245,136}))
end
for _, _v430 in ipairs(_v38) do
if type(data[_v430]) == (_V9({124,67,232,145,156})) and type(_v119[_v430]) == (_V9({124,67,232,145,156})) then
_v70(_v119[_v430], data[_v430])
end
end
return true, name
end
function _v12.delete(name)
name = _v425(name)
if name == (_V9({})) then
return false, (_V9({77,76,254,152,139,26,219,230,90,103,76,236,148,158,26,212,167,84,109}))
end
if type(delfile) ~= (_V9({110,87,228,158,141,83,213,168})) then
return false, (_V9({92,74,227,142,217,95,194,163,90,125,86,229,143,217,89,219,168,30,124,2,238,152,149,95,206,163,25,110,75,230,152,138}))
end
local _v337, err = pcall(delfile, _v366(name))
if not _v337 then
return false, tostring(err)
end
return true, name
end
return _v12
end)()
_v46 = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v43 = game:GetService((_V9({92,71,230,152,137,85,200,178,106,109,80,252,148,154,95})))
local _v27 = _v32.LocalPlayer
local _v46 = {}
function _v46:ServerHop()
local _v337, err = pcall(function()
_v43:Teleport(game.PlaceId, _v27)
end)
if not _v337 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,106,109,80,252,152,139,26,210,169,73,40,68,235,148,149,95,222,252})), err)
end
return _v337
end
function _v46:Rejoin()
local _v337, err = pcall(function()
_v43:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v27)
end)
if not _v337 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,107,109,72,229,148,151,26,220,167,80,100,71,238,199})), err)
end
return _v337
end
function _v46.getGuiParent()
local _v337, hidden = pcall(function()
return gethui and gethui()
end)
if _v337 and hidden then
return hidden
end
local _v338, coreGui = pcall(function()
return game:GetService((_V9({75,77,248,152,190,79,211})))
end)
if _v338 and coreGui then
return coreGui
end
return _v27:WaitForChild((_V9({88,78,235,132,156,72,253,179,80})))
end
return _v46
end)()
_v10 = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local _v10 = {}
_v10.LocalRootPos = nil
local frame = {}
local _v6 = 0.5
local _v79 = {}
local _v80 = -math.huge
function _v10.GetBotCharacters()
local _v320 = os.clock()
if _v320 - _v80 < _v6 then
return _v79
end
_v80 = _v320
table.clear(_v79)
for _, _v141 in ipairs(_v49:GetDescendants()) do
if _v141:IsA((_V9({69,77,238,152,149})))
and _v141:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
and not _v32:GetPlayerFromCharacter(_v141)
then
table.insert(_v79, _v141)
end
end
return _v79
end
local function _v412(_v111, humanoid)
return humanoid.RootPart
or _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
or _v111:FindFirstChild((_V9({92,77,248,142,150})))
or _v111:FindFirstChild((_V9({93,82,250,152,139,110,213,180,74,103})))
or _v111.PrimaryPart
end
local _v35 = {
Head = { (_V9({64,71,235,153})) },
Torso = { (_V9({93,82,250,152,139,110,213,180,74,103})), (_V9({68,77,253,152,139,110,213,180,74,103})), (_V9({92,77,248,142,150})), (_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})) },
Arms = {
(_V9({68,71,236,137,177,91,212,162})), (_V9({90,75,237,149,141,114,219,168,93})),
(_V9({68,71,236,137,181,85,205,163,75,73,80,231})), (_V9({90,75,237,149,141,118,213,177,92,122,99,248,144})),
(_V9({68,71,236,137,172,74,202,163,75,73,80,231})), (_V9({90,75,237,149,141,111,202,182,92,122,99,248,144})),
(_V9({68,71,236,137,217,123,200,171})), (_V9({90,75,237,149,141,26,251,180,84})),
},
Legs = {
(_V9({68,71,236,137,191,85,213,178})), (_V9({90,75,237,149,141,124,213,169,77})),
(_V9({68,71,236,137,181,85,205,163,75,68,71,237})), (_V9({90,75,237,149,141,118,213,177,92,122,110,239,154})),
(_V9({68,71,236,137,172,74,202,163,75,68,71,237})), (_V9({90,75,237,149,141,111,202,182,92,122,110,239,154})),
(_V9({68,71,236,137,217,118,223,161})), (_V9({90,75,237,149,141,26,246,163,94})),
},
}
local _v34 = { (_V9({64,71,235,153})), (_V9({92,77,248,142,150})), (_V9({73,80,231,142})), (_V9({68,71,237,142})) }
local function _v369(_v111, _v396)
local _v313 = _v35[_v396]
if not _v313 then
return nil
end
for _, name in ipairs(_v313) do
local _v364 = _v111:FindFirstChild(name)
if _v364 and _v364:IsA((_V9({74,67,249,152,169,91,200,178}))) then
return _v364
end
end
return nil
end
local function _v368(_v111)
for _, _v396 in ipairs(_v34) do
local _v364 = _v369(_v111, _v396)
if _v364 then
return _v364
end
end
for _, _v141 in ipairs(_v111:GetDescendants()) do
if _v141:IsA((_V9({74,67,249,152,169,91,200,178}))) then
return _v141
end
end
return nil
end
local function _v65(_v111, _v207, hrp)
return _v207
or hrp
or _v111:FindFirstChild((_V9({93,82,250,152,139,110,213,180,74,103})))
or _v111:FindFirstChild((_V9({92,77,248,142,150})))
or _v368(_v111)
end
local function _v85(_v111, _v373, _v94, _v95)
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v207 = _v111:FindFirstChild((_V9({64,71,235,153})))
local hrp = _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
local _v411 = _v412(_v111, humanoid)
local _v64 = _v65(_v111, _v207, hrp)
local _v169 = {
Player = _v373,
Character = _v111,
Humanoid = humanoid,
Head = _v207,
RootPart = _v411,
HRP = hrp,
Anchor = _v64,
}
if _v64 then
_v169.WorldDistance = (_v64.Position - _v95).Magnitude
local _v462, vis = _v94:WorldToViewportPoint(_v64.Position)
_v169.AnchorScreen = _v462
_v169.AnchorOnScreen = vis
end
if _v411 then
local _v498 = _v207 and (_v207.Position + Vector3.new(0, _v207.Size.Y, 0))
or (_v411.Position + Vector3.new(0, 3, 0))
local _v503, tvis = _v94:WorldToViewportPoint(_v498)
_v169.TopScreen = _v503
_v169.TopOnScreen = tvis
_v169.BotScreen = _v94:WorldToViewportPoint(_v411.Position - Vector3.new(0, 3.2, 0))
end
return _v169
end
function _v10:Update(_v97, _v171)
table.clear(frame)
local _v94 = _v49.CurrentCamera
local _v308 = _v27.Character
local _v309 = _v308 and _v308:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
_v10.LocalRootPos = _v309 and _v309.Position or nil
if not _v94 then
return
end
local _v95 = _v94.CFrame.Position
for _, _v373 in ipairs(_v32:GetPlayers()) do
if _v373 ~= _v27 then
local _v169 = _v85(_v373.Character, _v373, _v94, _v95)
if _v169 then
table.insert(frame, _v169)
end
end
end
if _v97 and _v97.TargetBots then
for _, _v111 in ipairs(_v10.GetBotCharacters()) do
local _v169 = _v85(_v111, nil, _v94, _v95)
if _v169 then
table.insert(frame, _v169)
end
end
end
end
function _v10:Get()
return frame
end
return _v10
end)()
_v9 = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local _v46 = _v46
local _v10 = _v10
local _v11 = _v11
local _v9 = {}
local Camera = _v49.CurrentCamera
local _v35 = {
Head = { (_V9({64,71,235,153})) },
Torso = { (_V9({93,82,250,152,139,110,213,180,74,103})), (_V9({68,77,253,152,139,110,213,180,74,103})), (_V9({92,77,248,142,150})), (_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})) },
Arms = {
(_V9({68,71,236,137,177,91,212,162})), (_V9({90,75,237,149,141,114,219,168,93})),
(_V9({68,71,236,137,181,85,205,163,75,73,80,231})), (_V9({90,75,237,149,141,118,213,177,92,122,99,248,144})),
(_V9({68,71,236,137,172,74,202,163,75,73,80,231})), (_V9({90,75,237,149,141,111,202,182,92,122,99,248,144})),
(_V9({68,71,236,137,217,123,200,171})), (_V9({90,75,237,149,141,26,251,180,84})),
},
Legs = {
(_V9({68,71,236,137,191,85,213,178})), (_V9({90,75,237,149,141,124,213,169,77})),
(_V9({68,71,236,137,181,85,205,163,75,68,71,237})), (_V9({90,75,237,149,141,118,213,177,92,122,110,239,154})),
(_V9({68,71,236,137,172,74,202,163,75,68,71,237})), (_V9({90,75,237,149,141,111,202,182,92,122,110,239,154})),
(_V9({68,71,236,137,217,118,223,161})), (_V9({90,75,237,149,141,26,246,163,94})),
},
}
local _v34 = { (_V9({64,71,235,153})), (_V9({92,77,248,142,150})), (_V9({73,80,231,142})), (_V9({68,71,237,142})) }
local _v408 = Random.new()
local function _v369(_v111, _v396)
local _v313 = _v35[_v396]
if not _v313 then
return nil
end
for _, name in ipairs(_v313) do
local _v364 = _v111:FindFirstChild(name)
if _v364 and _v364:IsA((_V9({74,67,249,152,169,91,200,178}))) then
return _v364
end
end
return nil
end
local function _v368(_v111)
for _, _v396 in ipairs(_v34) do
local _v364 = _v369(_v111, _v396)
if _v364 then
return _v364
end
end
for _, _v141 in ipairs(_v111:GetDescendants()) do
if _v141:IsA((_V9({74,67,249,152,169,91,200,178}))) then
return _v141
end
end
return nil
end
local function _v66(_v111)
return _v111:FindFirstChild((_V9({64,71,235,153})))
or _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
or _v111:FindFirstChild((_V9({93,82,250,152,139,110,213,180,74,103})))
or _v111:FindFirstChild((_V9({92,77,248,142,150})))
or _v368(_v111)
end
local function _v410(_v536)
local _v499 = 0
for _, _v396 in ipairs(_v34) do
_v499 = _v499 + math.max(0, (_v536 and _v536[_v396]) or 0)
end
if _v499 <= 0 then
return (_V9({64,71,235,153}))
end
local _v409 = _v408:NextNumber() * _v499
local _v50 = 0
for _, _v396 in ipairs(_v34) do
_v50 = _v50 + math.max(0, _v536[_v396] or 0)
if _v409 <= _v50 then
return _v396
end
end
return (_V9({64,71,235,153}))
end
local function _v242(_v379, _v111)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v27.Character }
local _v406 = _v49:Raycast(Camera.CFrame.Position, _v379 - Camera.CFrame.Position, params)
return not _v406 or _v406.Instance:IsDescendantOf(_v111)
end
local _v20 = Color3.fromRGB(132, 62, 190)
local _v185, _v186, fovStroke
local function _v167()
if _v186 and _v186.Parent then
return _v186
end
_v185 = Instance.new((_V9({91,65,248,152,156,84,253,179,80})))
_v185.Name = _v11.RandomName()
_v185.ResetOnSpawn = false
_v185.IgnoreGuiInset = true
_v185.DisplayOrder = 998
local _v337 = pcall(function()
_v185.Parent = _v46.getGuiParent()
end)
if not _v337 or not _v185.Parent then
_v185.Parent = _v27:WaitForChild((_V9({88,78,235,132,156,72,253,179,80})))
end
_v11.Protect(_v185)
_v186 = Instance.new((_V9({78,80,235,144,156})))
_v186.Name = (_V9({90,75,228,154}))
_v186.AnchorPoint = Vector2.new(0.5, 0.5)
_v186.Position = UDim2.fromScale(0.5, 0.5)
_v186.BackgroundTransparency = 1
_v186.BorderSizePixel = 0
_v186.Parent = _v185
local _v125 = Instance.new((_V9({93,107,201,146,139,84,223,180})))
_v125.CornerRadius = UDim.new(1, 0)
_v125.Parent = _v186
fovStroke = Instance.new((_V9({93,107,217,137,139,85,209,163})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v20
fovStroke.Parent = _v186
return _v186
end
local function _v510(_v119)
local _v441 = _v119.FOVCircle
if not _v441 then
if _v186 then
_v186.Visible = false
end
return
end
local _v407 = _v167()
if not _v407 then
return
end
local _v146 = math.max(0, _v119.FOV or 0) * 2
_v407.Size = UDim2.fromOffset(_v146, _v146)
_v407.Visible = true
end
local function _v145()
if _v185 then
pcall(function()
_v185:Destroy()
end)
end
_v185, _v186, fovStroke = nil, nil, nil
end
local function _v429(_v99)
if not _v99.AnchorOnScreen or _v99.AnchorScreen.Z < 0 then
return math.huge
end
local _v428 = Vector2.new(_v99.AnchorScreen.X, _v99.AnchorScreen.Y)
local _v106 = Camera.ViewportSize / 2
return (_v428 - _v106).Magnitude
end
local function _v173(_v99, _v119)
local _v373 = _v99.Player
if _v119.TeamCheck and _v373 and _v373.Team ~= nil and _v373.Team == _v27.Team then
return nil
end
local _v64 = _v99.Anchor
if not _v64 then
return nil
end
local _v151 = _v429(_v99)
if _v151 >= (_v119.FOV or 200) then
return nil
end
if (_v99.WorldDistance or math.huge) > _v119.MaxDistance then
return nil
end
if _v119.WallCheck and not _v242(_v64.Position, _v99.Character) then
return nil
end
return { Player = _v373, Character = _v99.Character, Anchor = _v64, ScreenDistance = _v151 }
end
function _v9:FindBestTarget(_v119)
local _v76
local _v77 = math.huge
for _, _v99 in ipairs(_v10:Get()) do
local _v100 = _v173(_v99, _v119)
if _v100 and _v100.ScreenDistance < _v77 then
_v77 = _v100.ScreenDistance
_v76 = _v100
end
end
return _v76
end
local _v25 = 50
function _v9:GetLookTarget(_v171, _v97)
local _v76
local _v77 = _v25
local _v310 = _v10.LocalRootPos
local _v287 = (_v171 and _v171.MaxDistance) or math.huge
local _v490 = _v97 and _v97.TeamCheck
for _, _v99 in ipairs(_v10:Get()) do
local _v373 = _v99.Player
if not (_v490 and _v373 and _v373.Team ~= nil and _v373.Team == _v27.Team) then
local _v64 = _v99.Anchor
if _v64 and not (_v310 and (_v64.Position - _v310).Magnitude > _v287) then
local _v151 = _v429(_v99)
if _v151 <= _v77 then
_v77 = _v151
_v76 = _v373 or _v99.Character
end
end
end
end
return _v76
end
function _v9:_resolveRegion(_v111, _v119)
local _v293 = _v119.Hitbox
if _v293 and _v293 ~= (_V9({90,67,228,153,150,87,154,238,110,109,75,237,149,141,95,222,239})) and _v35[_v293] then
return _v293
end
if self._lockedChar ~= _v111 then
self._lockedChar = _v111
self._rolledRegion = _v410(_v119.TargetWeights)
end
return self._rolledRegion or (_V9({64,71,235,153}))
end
function _v9:PointCamera(_v479, _v446)
local _v142 = CFrame.lookAt(Camera.CFrame.Position, _v479)
local _v63 = math.clamp(1 - (_v446 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v142, _v63)
end
function _v9:Update(_v119, debug)
Camera = _v49.CurrentCamera
_v510(_v119)
if not _v119.Enabled then
self._lockedChar = nil
self._currentTarget = nil
return
end
if not Camera then
return
end
local target = self:FindBestTarget(_v119)
if not target then
self._lockedChar = nil
self._currentTarget = nil
return
end
local _v396 = self:_resolveRegion(target.Character, _v119)
local _v59 = _v369(target.Character, _v396) or _v368(target.Character)
if not _v59 then
self._currentTarget = nil
return
end
self:PointCamera(_v59.Position, _v119.Smoothness)
target.Part = _v59
target.Region = _v396
self._currentTarget = target
if debug then
print((_V9({92,80,235,158,146,83,212,161,3})), target.Character.Name, (_V9({90,71,237,148,150,84,128})), _v396, (_V9({76,75,249,137,152,84,217,163,3})), math.floor(target.ScreenDistance))
end
return target
end
function _v9:GetCurrentTarget()
return self._currentTarget
end
function _v9:Cleanup()
self._lockedChar = nil
self._currentTarget = nil
_v145()
end
_v9.GetBotCharacters = _v10.GetBotCharacters
return _v9
end)()
ESP = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local _v13 = _v13
local _v46 = _v46
local _v10 = _v10
local _v11 = _v11
local ESP = {}
local _v168 = {}
local _v124
local _v82
local _v16 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v235(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v172(_v111)
local _v226 = _v111:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
return (_v226 and _v226.RootPart)
or _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
or _v111:FindFirstChild((_V9({92,77,248,142,150})))
or _v111:FindFirstChild((_V9({93,82,250,152,139,110,213,180,74,103})))
or _v111.PrimaryPart
end
local function _v195()
if _v82 and _v82.Parent then
return _v82
end
_v82 = Instance.new((_V9({91,65,248,152,156,84,253,179,80})))
_v82.Name = _v11.RandomName()
_v82.ResetOnSpawn = false
_v82.IgnoreGuiInset = true
_v82.DisplayOrder = 996
local _v337 = pcall(function()
_v82.Parent = _v46.getGuiParent()
end)
if not _v337 or not _v82.Parent then
_v82.Parent = _v27:WaitForChild((_V9({88,78,235,132,156,72,253,179,80})))
end
_v11.Protect(_v82)
return _v82
end
local function _v509(_v169, _v111, _v119, _v99)
local _v94 = _v49.CurrentCamera
local root = _v99 and _v99.RootPart or _v172(_v111)
if not _v94 or not root or not _v169.box then
if _v169.box then
_v169.box.Visible = false
end
return
end
local _v497, onScreen, botV
if _v99 then
if not _v99.TopScreen then
_v169.box.Visible = false
return
end
_v497, onScreen, botV = _v99.TopScreen, _v99.TopOnScreen, _v99.BotScreen
else
local _v207 = _v111:FindFirstChild((_V9({64,71,235,153})))
local _v498 = _v207 and (_v207.Position + Vector3.new(0, _v207.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v81 = root.Position - Vector3.new(0, 3.2, 0)
_v497, onScreen = _v94:WorldToViewportPoint(_v498)
botV = _v94:WorldToViewportPoint(_v81)
end
if not onScreen or _v497.Z <= 0 then
_v169.box.Visible = false
return
end
local _v211 = math.abs(botV.Y - _v497.Y)
local _v537 = _v211 * 0.62
local _v128 = (_v497.X + botV.X) * 0.5
local _v129 = (_v497.Y + botV.Y) * 0.5
_v169.box.Size = UDim2.fromOffset(_v537, _v211)
_v169.box.Position = UDim2.fromOffset(_v128 - _v537 * 0.5, _v129 - _v211 * 0.5)
_v169.box.BackgroundColor3 = _v119.FillColor
_v169.box.BackgroundTransparency = _v119.Filled and (1 - _v119.FillOpacity) or 1
_v169.boxStroke.Color = _v119.OutlineColor
_v169.boxStroke.Transparency = 1 - _v119.OutlineOpacity
_v169.box.Visible = true
end
local function _v277(_v169, name, _v207, _v119)
local _v475 = Instance.new((_V9({74,75,230,145,155,85,219,180,93,79,87,227})))
_v475.Name = _v11.RandomName()
_v475.Size = UDim2.fromOffset(200, 46)
_v475.StudsOffset = Vector3.new(0, 2.7, 0)
_v475.AlwaysOnTop = true
_v475.Adornee = _v207
_v475.Parent = _v207
_v11.Protect(_v475)
local _v219 = Instance.new((_V9({78,80,235,144,156})))
_v219.BackgroundTransparency = 1
_v219.Size = UDim2.fromScale(1, 1)
_v219.Parent = _v475
local _v252 = Instance.new((_V9({93,107,198,148,138,78,246,167,64,103,87,254})))
_v252.SortOrder = Enum.SortOrder.LayoutOrder
_v252.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v252.VerticalAlignment = Enum.VerticalAlignment.Center
_v252.Parent = _v219
local _v312 = Instance.new((_V9({92,71,242,137,181,91,216,163,85})))
_v312.LayoutOrder = 1
_v312.BackgroundTransparency = 1
_v312.Size = UDim2.new(1, 0, 0, 16)
_v312.Font = Enum.Font.GothamBold
_v312.TextSize = 13
_v312.TextColor3 = _v119.OutlineColor
_v312.TextStrokeTransparency = 0.35
_v312.Text = name
_v312.Visible = false
_v312.Parent = _v219
local _v150 = Instance.new((_V9({92,71,242,137,181,91,216,163,85})))
_v150.LayoutOrder = 2
_v150.BackgroundTransparency = 1
_v150.Size = UDim2.new(1, 0, 0, 14)
_v150.Font = Enum.Font.Gotham
_v150.TextSize = 12
_v150.TextColor3 = _v119.OutlineColor
_v150.TextStrokeTransparency = 0.4
_v150.Text = (_V9({}))
_v150.Visible = false
_v150.Parent = _v219
local _v209 = Instance.new((_V9({78,80,235,144,156})))
_v209.LayoutOrder = 3
_v209.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v209.BackgroundTransparency = 0.3
_v209.BorderSizePixel = 0
_v209.Size = UDim2.new(0.55, 0, 0, 5)
_v209.Visible = false
_v209.Parent = _v219
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v209, CornerRadius = UDim.new(1, 0) })
local _v210 = Instance.new((_V9({78,80,235,144,156})))
_v210.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v210.BorderSizePixel = 0
_v210.Size = UDim2.fromScale(1, 1)
_v210.Parent = _v209
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v210, CornerRadius = UDim.new(1, 0) })
_v169.nameTag = _v475
_v169.nameLabel = _v312
_v169.distanceLabel = _v150
_v169.healthBack = _v209
_v169.healthFill = _v210
_v169.nameHead = _v207
end
local function _v511(name, _v169, _v111, _v119, _v99)
local _v207 = _v99 and (_v99.Head or _v99.HRP)
or _v111:FindFirstChild((_V9({64,71,235,153})))
or _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
if not _v207 then
if _v169.nameTag then
_v169.nameTag.Enabled = false
end
return
end
if not _v169.nameTag or not _v169.nameTag.Parent or _v169.nameHead ~= _v207 then
if _v169.nameTag then
pcall(function()
_v169.nameTag:Destroy()
end)
end
_v277(_v169, name, _v207, _v119)
end
_v169.nameLabel.TextColor3 = _v119.OutlineColor
_v169.nameLabel.Visible = _v119.Names or _v119.NameTags
_v169.distanceLabel.Visible = _v119.Distance or _v119.DistanceTags
if _v169.distanceLabel.Visible then
_v169.distanceLabel.TextColor3 = _v119.OutlineColor
local _v310, hrp
if _v99 then
_v310, hrp = _v10.LocalRootPos, _v99.HRP
else
local _v308 = _v27.Character
local _v309 = _v308 and _v308:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
_v310 = _v309 and _v309.Position
hrp = _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
end
local d = (_v310 and hrp) and math.floor((hrp.Position - _v310).Magnitude + 0.5) or 0
_v169.distanceLabel.Text = (_V9({83})) .. d .. (_V9({101,127}))
end
_v169.healthBack.Visible = _v119.HealthBars
if _v119.HealthBars then
local humanoid = _v99 and _v99.Humanoid or _v111:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
local _v190 = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v169.healthFill.Size = UDim2.fromScale(_v190, 1)
_v169.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v190)
end
_v169.nameTag.Enabled = true
end
local function _v215(_v169)
_v169.hl.Enabled = false
if _v169.box then
_v169.box.Visible = false
end
if _v169.nameTag then
_v169.nameTag.Enabled = false
end
end
local function _v400(_v169, _v111, name, _v119, _v99)
if _v119.Outlines then
if _v169.hl.Adornee ~= _v111 then
_v169.hl.Adornee = _v111
end
_v169.hl.OutlineColor = _v119.OutlineColor
_v169.hl.FillColor = _v119.FillColor
_v169.hl.OutlineTransparency = 1 - _v119.OutlineOpacity
_v169.hl.FillTransparency = _v119.Filled and (1 - _v119.FillOpacity) or 1
_v169.hl.DepthMode = _v16
_v169.hl.Enabled = true
else
_v169.hl.Enabled = false
end
if _v119.Boxes then
_v509(_v169, _v111, _v119, _v99)
elseif _v169.box then
_v169.box.Visible = false
end
if _v119.Names or _v119.Distance or _v119.NameTags or _v119.DistanceTags or _v119.HealthBars then
_v511(name, _v169, _v111, _v119, _v99)
elseif _v169.nameTag then
_v169.nameTag.Enabled = false
end
end
local function _v152(_v364)
local _v308 = _v27.Character
local _v309 = _v308 and _v308:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
if not _v309 or not _v364 then
return 0
end
return (_v364.Position - _v309.Position).Magnitude
end
local function _v513(_v99, _v169, _v119)
local hrp = _v99.HRP
if not _v119.Enabled or not hrp then
_v215(_v169)
return
end
local _v310 = _v10.LocalRootPos
local dist = _v310 and (hrp.Position - _v310).Magnitude or 0
if dist > _v119.MaxDistance then
_v215(_v169)
return
end
_v400(_v169, _v99.Character, _v99.Player.Name, _v119, _v99)
end
local function _v315(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v216 = Instance.new((_V9({64,75,237,149,149,83,221,174,77})))
_v216.Name = (_V9({77,113,218,178,140,78,214,175,87,109}))
_v216.Enabled = false
_v216.FillColor = color
_v216.OutlineColor = color
_v216.Parent = _v124
local box = Instance.new((_V9({78,80,235,144,156})))
box.Name = (_V9({77,113,218,191,150,66}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v195()
local boxStroke = Instance.new((_V9({93,107,217,137,139,85,209,163})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = _v216, box = box, boxStroke = boxStroke }
end
local function _v144(_v169)
if _v169.hl then
_v169.hl:Destroy()
end
if _v169.box then
_v169.box:Destroy()
end
if _v169.nameTag then
pcall(function()
_v169.nameTag:Destroy()
end)
end
end
local function _v57(_v373, _v140)
if _v373 == _v27 or _v168[_v373] then
return
end
_v168[_v373] = _v315(_v140)
end
local function _v399(_v373)
local _v169 = _v168[_v373]
if not _v169 then
return
end
_v144(_v169)
_v168[_v373] = nil
end
local _v321 = {}
local _v250 = 0
local _v29 = 1
local function _v398(_v294)
local _v169 = _v321[_v294]
if not _v169 then
return
end
_v144(_v169)
_v321[_v294] = nil
end
local function _v403()
local current = {}
for _, _v335 in ipairs(_v49:GetDescendants()) do
if _v335:IsA((_V9({64,87,231,156,151,85,211,162}))) then
local _v294 = _v335.Parent
if
_v294
and _v294:IsA((_V9({69,77,238,152,149})))
and _v294 ~= _v27.Character
and not _v32:GetPlayerFromCharacter(_v294)
then
current[_v294] = true
if not _v321[_v294] then
_v321[_v294] = _v315(_v13.ESP.OutlineColor)
end
end
end
end
for _v294 in pairs(_v321) do
if not current[_v294] or not _v294.Parent then
_v398(_v294)
end
end
end
local function _v512(_v294, _v169, _v119)
local root = _v172(_v294)
local humanoid = _v294:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
if not _v294.Parent or not root or not _v235(humanoid) then
_v215(_v169)
return
end
if _v152(root) > _v119.MaxDistance then
_v215(_v169)
return
end
_v400(_v169, _v294, _v294.Name, _v119)
end
function ESP:Init()
if _v124 then
return
end
_v124 = Instance.new((_V9({78,77,230,153,156,72})))
_v124.Name = _v11.RandomName()
local _v337 = pcall(function()
_v124.Parent = _v46.getGuiParent()
end)
if not _v337 or not _v124.Parent then
_v124.Parent = _v49
end
_v11.Protect(_v124)
for _, _v373 in ipairs(_v32:GetPlayers()) do
_v57(_v373, _v13.ESP.OutlineColor)
end
end
function ESP:Update(_v119)
local _v401 = {}
for _, _v99 in ipairs(_v10:Get()) do
local _v373 = _v99.Player
if _v373 then
_v401[_v373] = true
local _v169 = _v168[_v373]
if not _v169 then
_v57(_v373, _v119.OutlineColor)
_v169 = _v168[_v373]
end
_v513(_v99, _v169, _v119)
end
end
for _v373, _v169 in pairs(_v168) do
if _v373.Parent ~= _v32 then
_v399(_v373)
elseif not _v401[_v373] then
_v215(_v169)
end
end
if _v119.Enabled and _v119.NPCs then
if os.clock() - _v250 >= _v29 then
_v250 = os.clock()
_v403()
end
for _v294, _v169 in pairs(_v321) do
_v512(_v294, _v169, _v119)
end
elseif next(_v321) then
for _v294 in pairs(_v321) do
_v398(_v294)
end
end
end
function ESP:OnPlayerAdded(_v373)
_v57(_v373, _v13.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v373)
_v399(_v373)
end
function ESP:Cleanup()
for _v373 in pairs(_v168) do
_v399(_v373)
end
for _v294 in pairs(_v321) do
_v398(_v294)
end
if _v124 then
_v124:Destroy()
_v124 = nil
end
if _v82 then
_v82:Destroy()
_v82 = nil
end
end
return ESP
end)()
_v17 = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local _v10 = _v10
local _v17 = {}
local _v130 = type(Drawing) == (_V9({124,67,232,145,156})) and type(Drawing.new) == (_V9({110,87,228,158,141,83,213,168}))
local _v137 = false
local _v131 = {}
local function _v134()
local _v258 = Drawing.new((_V9({68,75,228,152})))
_v258.Thickness = 1
_v258.Visible = false
return _v258
end
local function _v133(_v373)
local _v169 = {
box = { _v134(), _v134(), _v134(), _v134() },
tracer = _v134(),
}
_v131[_v373] = _v169
return _v169
end
local function _v132(_v169)
for _, _v258 in ipairs(_v169.box) do
_v258.Visible = false
end
_v169.tracer.Visible = false
end
local function _v135(_v373)
local _v169 = _v131[_v373]
if not _v169 then
return
end
_v131[_v373] = nil
for _, _v258 in ipairs(_v169.box) do
_v258:Remove()
end
_v169.tracer:Remove()
end
local function _v136(_v99, _v119, _v94, _v97)
local _v373 = _v99.Player
local _v169 = _v131[_v373]
if _v97.TeamCheck and _v373.Team ~= nil and _v373.Team == _v27.Team then
if _v169 then
_v132(_v169)
end
return
end
local root = _v99.HRP
if not (_v119.Boxes or _v119.Tracers) or not root then
if _v169 then
_v132(_v169)
end
return
end
local _v497, onScreen, botV = _v99.TopScreen, _v99.TopOnScreen, _v99.BotScreen
if not _v497 or not onScreen or _v497.Z <= 0 or botV.Z <= 0 then
if _v169 then
_v132(_v169)
end
return
end
_v169 = _v169 or _v133(_v373)
local _v211 = math.abs(botV.Y - _v497.Y)
local _v537 = _v211 * 0.62
local _v128 = (_v497.X + botV.X) * 0.5
local _v254, right = _v128 - _v537 * 0.5, _v128 + _v537 * 0.5
local _v496, bottom = _v497.Y, botV.Y
local box = _v169.box
box[1].From = Vector2.new(_v254, _v496)
box[1].To = Vector2.new(right, _v496)
box[2].From = Vector2.new(_v254, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v254, _v496)
box[3].To = Vector2.new(_v254, bottom)
box[4].From = Vector2.new(right, _v496)
box[4].To = Vector2.new(right, bottom)
for _, _v258 in ipairs(box) do
_v258.Color = _v119.BoxColor
_v258.Visible = _v119.Boxes
end
_v169.tracer.From = Vector2.new(_v94.ViewportSize.X / 2, _v94.ViewportSize.Y)
_v169.tracer.To = Vector2.new(_v128, bottom)
_v169.tracer.Color = _v119.TracerColor
_v169.tracer.Visible = _v119.Tracers
end
function _v17:Update(_v119, _v97)
if not _v130 then
if (_v119.Boxes or _v119.Tracers) and not _v137 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,123,103,90,165,169,139,91,217,163,75,40,103,217,173,217,84,223,163,93,123,2,254,149,156,26,254,180,88,127,75,228,154,217,86,211,164,75,105,80,243,221,27,186,46,230,87,103,86,170,156,143,91,211,170,88,106,78,239,221,144,84,154,178,81,97,81,170,152,129,95,217,179,77,103,80,164})))
_v137 = true
end
return
end
local _v94 = _v49.CurrentCamera
if not _v94 then
return
end
local _v431 = {}
for _, _v99 in ipairs(_v10:Get()) do
if _v99.Player then
_v431[_v99.Player] = true
_v136(_v99, _v119, _v94, _v97)
end
end
for _v373, _v169 in pairs(_v131) do
if _v373.Parent ~= _v32 then
_v135(_v373)
elseif not _v431[_v373] then
_v132(_v169)
end
end
end
function _v17:Cleanup()
for _v373 in pairs(_v131) do
_v135(_v373)
end
end
return _v17
end)()
Visuals = (function()
local _v26 = game:GetService((_V9({68,75,237,149,141,83,212,161})))
local Visuals = {}
local _v26 = game:GetService((_V9({68,75,237,149,141,83,212,161})))
local _v530
local _v527 = false
local _v529 = false
local _v528 = 0
local _v47 = 1
local function _v526()
if _v530 then
return
end
_v530 = {
Brightness = _v26.Brightness,
ClockTime = _v26.ClockTime,
GlobalShadows = _v26.GlobalShadows,
FogEnd = _v26.FogEnd,
FogStart = _v26.FogStart,
Ambient = _v26.Ambient,
OutdoorAmbient = _v26.OutdoorAmbient,
}
end
local function _v524()
_v26.Brightness = 2
_v26.ClockTime = 14
_v26.GlobalShadows = false
end
local function _v525()
_v26.FogEnd = 100000
end
local function _v531()
_v26.Brightness = _v530.Brightness
_v26.ClockTime = _v530.ClockTime
_v26.GlobalShadows = _v530.GlobalShadows
end
local function _v532()
_v26.FogEnd = _v530.FogEnd
_v26.FogStart = _v530.FogStart
end
function Visuals:Update(_v119)
if not (_v119.Fullbright or _v119.NoFog or _v527 or _v529) then
return
end
_v526()
if _v119.Fullbright ~= _v527 then
_v527 = _v119.Fullbright
if _v527 then
_v524()
else
_v531()
end
end
if _v119.NoFog ~= _v529 then
_v529 = _v119.NoFog
if _v529 then
_v525()
else
_v532()
end
end
if (_v527 or _v529) and os.clock() - _v528 >= _v47 then
_v528 = os.clock()
if _v527
and (_v26.Brightness ~= 2 or _v26.ClockTime ~= 14 or _v26.GlobalShadows)
then
_v524()
end
if _v529 and _v26.FogEnd < 100000 then
_v525()
end
end
end
function Visuals:Cleanup()
if _v530 then
if _v527 then
_v531()
end
if _v529 then
_v532()
end
end
_v527 = false
_v529 = false
end
return Visuals
end)()
_v48 = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v27 = _v32.LocalPlayer
local _v13 = _v13
local _v48 = {}
_v48.Version = (_V9({56}))
local function _v404()
local _v101 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v183 in ipairs(_v101) do
if type(_v183) == (_V9({110,87,228,158,141,83,213,168})) then
return _v183
end
end
return nil
end
local function _v405()
local _v514 = _v13.Webhook.Url
if type(_v514) == (_V9({123,86,248,148,151,93})) and _v514 ~= (_V9({})) then
return _v514
end
return nil
end
function _v48.SetWebhook(_v514)
_v13.Webhook.Url = tostring(_v514 or (_V9({})))
return true
end
function _v48.HasWebhook()
return _v405() ~= nil
end
function _v48.SendWebhook(content, _v358)
_v358 = _v358 or {}
local _v514 = _v405()
if not _v514 then
return false, (_V9({102,77,213,138,156,88,210,169,86,99}))
end
local _v402 = _v404()
if not _v402 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,119,103,2,194,169,173,106,154,180,92,121,87,239,142,141,26,220,179,87,107,86,227,146,151,26,219,176,88,97,78,235,159,149,95,154,175,87,40,86,226,148,138,26,223,190,92,107,87,254,146,139})))
return false, (_V9({102,77,213,149,141,78,202}))
end
local _v367 = {
username = _v358.username or (_V9({94,67,228,148,141,67,151,129,92,102,71,248,156,149})),
avatar_url = _v358.avatar_url,
content = content,
embeds = _v358.embeds,
}
local _v337, err = pcall(function()
local _v78 = game:GetService((_V9({64,86,254,141,170,95,200,176,80,107,71}))):JSONEncode(_v367)
return _v402({
Url = _v514,
Method = (_V9({88,109,217,169})),
Headers = { [(_V9({75,77,228,137,156,84,206,235,109,113,82,239}))] = (_V9({105,82,250,145,144,89,219,178,80,103,76,165,151,138,85,212})) },
Body = _v78,
})
end)
_v514 = nil
if not _v337 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,110,109,64,226,146,150,81,154,181,92,102,70,170,155,152,83,214,163,93,50})), err)
return false, err
end
return true
end
function _v48.SendLoadedEmbed(_v236)
local _v371 = (_V9({55}))
pcall(function()
_v371 = game:GetService((_V9({69,67,248,150,156,78,202,170,88,107,71,217,152,139,76,211,165,92}))):GetProductInfo(game.PlaceId).Name
end)
return _v48.SendWebhook(nil, {
embeds = {
{
title = (_V9({94,67,228,148,141,67,148,162,92,126,2,205,152,151,95,200,167,85,40,78,229,156,157,95,222})),
color = 8666558,
fields = {
{ name = (_V9({88,78,235,132,156,72})), value = (_V9({104})) .. (_v27 and _v27.Name or (_V9({55}))) .. (_V9({104})), inline = true },
{ name = (_V9({94,71,248,142,144,85,212})), value = (_V9({104,84})) .. tostring(_v48.Version) .. (_V9({104})), inline = true },
{ name = (_V9({79,67,231,152})), value = _v371, inline = false },
{ name = (_V9({88,78,235,158,156,115,222})), value = (_V9({104})) .. tostring(game.PlaceId) .. (_V9({104})), inline = true },
{ name = (_V9({76,71,232,136,158,93,223,162})), value = (_V9({104})) .. tostring(_v236) .. (_V9({104})), inline = true },
},
footer = { text = os.date((_V9({45,123,167,216,148,23,159,162,25,45,106,176,216,180,0,159,149}))) },
},
},
})
end
return _v48
end)()
Triggerbot = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local Triggerbot = {}
local _v480
local _v486 = false
local _v489 = false
local _v483 = nil
local _v481
local _v487 = Random.new()
local _v482 = 0
local _v484 = 0.1
local function _v485()
if _v486 then
return
end
_v486 = true
if type(mouse1click) == (_V9({110,87,228,158,141,83,213,168})) then
_v480 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({110,87,228,158,141,83,213,168})) and type(mouse1release) == (_V9({110,87,228,158,141,83,213,168})) then
_v480 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v488(_v119, _v97)
local _v94 = _v49.CurrentCamera
if not _v94 then
return nil
end
local _v523 = _v94.ViewportSize
local _v389 = _v94:ViewportPointToRay(_v523.X / 2, _v523.Y / 2)
local params = RaycastParams.new()
if _v119.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v27.Character }
else
local _v112 = {}
for _, _v377 in ipairs(_v32:GetPlayers()) do
if _v377 ~= _v27 and _v377.Character then
table.insert(_v112, _v377.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v112
end
local _v406 = _v49:Raycast(_v389.Origin, _v389.Direction * (_v119.MaxDistance or 1000), params)
if not _v406 then
return nil
end
local _v294 = _v406.Instance:FindFirstAncestorOfClass((_V9({69,77,238,152,149})))
local _v377 = _v294 and _v32:GetPlayerFromCharacter(_v294)
if not _v377 or _v377 == _v27 then
return nil
end
if _v97 and _v97.TeamCheck and _v377.Team ~= nil and _v377.Team == _v27.Team then
return nil
end
local _v226 = _v294:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
if not _v226 or _v226.Health <= 0 then
return nil
end
return _v294
end
function Triggerbot:Update(_v119, _v97)
if not _v119.Enabled then
_v483 = nil
return
end
_v485()
if not _v480 then
if not _v489 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,109,122,75,237,154,156,72,216,169,77,40,76,239,152,157,73,154,167,25,101,77,255,142,156,23,217,170,80,107,73,170,155,140,84,217,178,80,103,76,170,213,148,85,207,181,92,57,65,230,148,154,81,147,230,219,136,182,170,147,150,78,154,167,79,105,75,230,156,155,86,223,230,80,102,2,254,149,144,73,154,163,65,109,65,255,137,150,72,148})))
_v489 = true
end
return
end
local target = _v488(_v119, _v97)
if not target then
_v483 = nil
return
end
local _v320 = os.clock()
if not _v483 then
_v483 = _v320
local _v264 = math.min(_v119.MinDelay or 0.1, _v119.MaxDelay or 0.25)
local _v213 = math.max(_v119.MinDelay or 0.1, _v119.MaxDelay or 0.25)
_v481 = _v487:NextNumber(_v264, _v213)
end
if (_v320 - _v483) >= (_v481 or 0) and (_v320 - _v482) >= _v484 then
_v482 = _v320
_v484 = _v487:NextNumber(0.09, 0.17)
_v480()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local _v9 = _v9
local _v11 = _v11
local SilentAim = {}
local _v418 = false
local _v423 = false
local _v416
local _v4 = 500
local _v2 = 12
local _v3 = 200
local function _v419()
local _v111 = _v27.Character
if _v111 then
local _v207 = _v111:FindFirstChild((_V9({64,71,235,153}))) or _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
if _v207 then
return _v207.Position
end
end
local _v96 = _v49.CurrentCamera
return _v96 and _v96.CFrame.Position or Vector3.zero
end
local function _v415(_v111)
if not _v111 then
return nil
end
return _v111:FindFirstChild((_V9({64,71,235,153})))
or _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
or _v111:FindFirstChild((_V9({93,82,250,152,139,110,213,180,74,103})))
or _v111:FindFirstChild((_V9({92,77,248,142,150})))
end
local function _v422()
local target = _v9:GetCurrentTarget()
if target and target.Part and target.Part.Parent then
return target.Part
end
if not _v416 then
return nil
end
local _v265 = _v9:GetLookTarget(_v416.ESP, _v416.Camera)
if typeof(_v265) ~= (_V9({65,76,249,137,152,84,217,163})) then
return nil
end
local _v111 = _v265:IsA((_V9({88,78,235,132,156,72}))) and _v265.Character or _v265
local _v364 = _v415(_v111)
if _v364 and _v364.Parent then
return _v364
end
return nil
end
local function _v414(_v359, _v364)
local _v478 = _v364.Position
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v27.Character, _v364:FindFirstAncestorOfClass((_V9({69,77,238,152,149}))) or _v364 }
if not _v49:Raycast(_v359, _v478 - _v359, params) then
return _v478
end
local _v289 = (_v359 + _v478) / 2
local _v383 = _v289 + Vector3.new(0, _v4, 0)
local _v180 = math.min(_v359.Y, _v478.Y)
local _v217 = _v49:Raycast(_v383, Vector3.new(0, _v180 - 5 - _v383.Y, 0), params)
local _v105 = math.max(_v359.Y, _v478.Y)
local _v67
if _v217 then
_v67 = _v217.Position.Y + _v2
else
_v67 = _v105 + _v3
end
_v67 = math.clamp(_v67, _v105 + 5, _v105 + _v3)
return Vector3.new(_v289.X, _v67, _v289.Z)
end
local function _v417()
return type(checkcaller) == (_V9({110,87,228,158,141,83,213,168})) and not checkcaller()
end
local _v421 = Random.new()
local function _v420()
local _v364 = _v422()
if not _v364 or not _v416 then
return nil
end
local _v286 = _v416.SilentAim.MaxAngle or 30
if _v286 < 180 then
local _v94 = _v49.CurrentCamera
if _v94 then
local _v492 = (_v364.Position - _v94.CFrame.Position).Unit
if _v94.CFrame.LookVector:Dot(_v492) < math.cos(math.rad(_v286)) then
return nil
end
end
end
local _v109 = _v416.SilentAim.HitChance or 100
if _v109 < 100 and _v421:NextNumber(0, 100) > _v109 then
return nil
end
return _v364
end
function SilentAim:Init(_v119)
_v416 = _v119
end
function SilentAim:Update(_v119)
if _v418 or not _v119.SilentAim.Enabled then
return
end
self:_install()
end
function SilentAim:_install()
if _v418 then
return
end
if type(hookmetamethod) ~= (_V9({110,87,228,158,141,83,213,168})) or type(getnamecallmethod) ~= (_V9({110,87,228,158,141,83,213,168})) then
if not _v423 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,106,97,78,239,147,141,26,251,175,84,40,76,239,152,157,73,154,174,86,103,73,231,152,141,91,215,163,77,96,77,238,221,27,186,46,230,87,103,86,170,156,143,91,211,170,88,106,78,239,221,144,84,154,178,81,97,81,170,152,129,95,217,179,77,103,80,164})))
_v423 = true
end
_v418 = true
return
end
_v418 = true
local function _v163()
return _v416.SilentAim.Enabled
end
local _v347
_v347 = hookmetamethod(game, (_V9({87,125,228,156,148,95,217,167,85,100})), _v11.CClosure(function(self, ...)
if _v163() and _v417() then
local _v288 = getnamecallmethod()
local _v364 = _v420()
if _v364 then
if _v288 == (_V9({78,75,248,152,170,95,200,176,92,122})) or _v288 == (_V9({65,76,252,146,146,95,233,163,75,126,71,248})) then
local _v299 = _v419()
local _v60 = _v414(_v299, _v364)
local _v72 = { ... }
for i, value in ipairs(_v72) do
if typeof(value) == (_V9({94,71,233,137,150,72,137})) then
local _v267 = value.Magnitude
if _v267 > 0.5 and _v267 < 1.5 then
_v72[i] = (_v60 - _v299).Unit
else
_v72[i] = _v364.Position
end
elseif typeof(value) == (_V9({75,100,248,156,148,95})) then
_v72[i] = _v364.CFrame
end
end
return _v347(self, table.unpack(_v72))
end
if _v288 == (_V9({90,67,243,158,152,73,206})) and self == _v49 then
local _v359, _v149, params = ...
if typeof(_v359) == (_V9({94,71,233,137,150,72,137})) and typeof(_v149) == (_V9({94,71,233,137,150,72,137})) then
local _v60 = _v414(_v359, _v364)
local _v75 = (_v60 - _v359).Unit * _v149.Magnitude
return _v347(self, _v359, _v75, params)
end
end
end
end
return _v347(self, ...)
end))
local _v295 = _v27:GetMouse()
local _v346
_v346 = hookmetamethod(game, (_V9({87,125,227,147,157,95,194})), _v11.CClosure(function(self, _v244)
if _v163() and _v417() and self == _v295 then
local _v364 = _v420()
if _v364 then
if _v244 == (_V9({64,75,254})) then
return _v364.CFrame
end
if _v244 == (_V9({92,67,248,154,156,78})) then
return _v364
end
end
end
return _v346(self, _v244)
end))
end
return SilentAim
end)()
Hitbox = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v27 = _v32.LocalPlayer
local _v10 = _v10
local _v23 = {}
local _v204 = {}
local function _v205(_v111)
local _v360 = _v204[_v111]
if not _v360 then
return
end
_v204[_v111] = nil
local root = _v360.root
if root and root.Parent then
root.Size = _v360.size
root.Transparency = _v360.transparency
root.CanCollide = _v360.canCollide
end
end
local function _v206()
for _v111 in pairs(_v204) do
_v205(_v111)
end
end
local function _v203(_v99, _v119, _v431)
local root = _v99.HRP
if not root then
return
end
local _v111 = _v99.Character
_v431[_v111] = true
if not _v204[_v111] then
_v204[_v111] = {
root = root,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = _v119.Size or 5
root.Size = Vector3.new(size, size, size)
root.Transparency = _v119.Transparency or 0.5
root.CanCollide = false
end
function _v23:Update(_v119, _v97)
if not _v119.Enabled then
_v206()
return
end
local _v431 = {}
for _, _v99 in ipairs(_v10:Get()) do
local _v373 = _v99.Player
if not (_v97.TeamCheck and _v373 and _v373.Team ~= nil and _v373.Team == _v27.Team) then
_v203(_v99, _v119, _v431)
end
end
for _v111 in pairs(_v204) do
if not _v431[_v111] then
_v205(_v111)
end
end
end
function _v23:Cleanup()
_v206()
end
return _v23
end)()
NoRecoil = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v45 = game:GetService((_V9({93,81,239,143,176,84,202,179,77,91,71,248,139,144,89,223})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local NoRecoil = {}
local function _v237()
return _v45:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v74 = nil
local function _v98(_v94)
local _v265 = _v94.CFrame.LookVector
return math.asin(math.clamp(_v265.Y, -1, 1))
end
function NoRecoil:Update(_v119, _v61)
if not _v119.Enabled then
_v74 = nil
return
end
local _v94 = _v49.CurrentCamera
if not _v94 then
_v74 = nil
return
end
if _v119.RequireMouseDown and not _v237() then
_v74 = nil
return
end
local _v110 = _v27.Character
local _v226 = _v110 and _v110:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
if _v226 then
_v226.CameraOffset = Vector3.new(0, 0, 0)
end
if _v61 then
_v74 = nil
return
end
local _v459 = math.clamp(_v119.Strength, 0, 1)
if _v459 <= 0 then
_v74 = nil
return
end
local _v370 = _v98(_v94)
if _v74 == nil then
_v74 = _v370
return
end
local _v158 = _v370 - _v74
if _v119.AllowAim and _v158 < 0 then
_v74 = _v370
return
end
if _v158 ~= 0 then
_v94.CFrame = _v94.CFrame * CFrame.Angles(-_v158 * _v459, 0, 0)
end
end
function NoRecoil:Reset()
_v74 = nil
end
NoRecoil.IsFiring = _v237
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local _v11 = _v11
local NoSpread = {}
local _v322 = false
local _v334 = false
local _v326 = false
local _v332 = false
local _v333 = 1
local _v328 = nil
local _v330 = nil
local _v329 = nil
local function _v323()
if type(hookfunction) == (_V9({110,87,228,158,141,83,213,168})) then
return hookfunction
elseif type(replaceclosure) == (_V9({110,87,228,158,141,83,213,168})) then
return replaceclosure
end
return nil
end
local function _v327(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v331(_v360, _v107, _v239)
local v = _v360 + (_v107 - _v360) * _v333
if _v239 then
return math.floor(v + 0.5)
end
return v
end
local function _v324(_v220)
if _v326 then
return
end
local _v337, ret = pcall(_v220, math.random, _v11.CClosure(function(...)
local _v360 = _v328(...)
if _v322 and _v333 > 0 then
local a, b = ...
return _v331(_v360, _v327(a, b), a ~= nil)
end
return _v360
end))
if _v337 then
_v328 = ret
_v326 = true
end
end
local function _v325(_v220)
if _v332 then
return
end
local _v337 = pcall(function()
local _v424 = Random.new()
_v330 = _v220(_v424.NextNumber, _v11.CClosure(function(self, ...)
local _v360 = _v330(self, ...)
if _v322 and _v333 > 0 then
local _v292, mx = ...
local _v107 = (_v292 == nil) and 0.5 or ((_v292 + mx) / 2)
return _v331(_v360, _v107, false)
end
return _v360
end))
_v329 = _v220(_v424.NextInteger, _v11.CClosure(function(self, ...)
local _v360 = _v329(self, ...)
if _v322 and _v333 > 0 then
local _v292, mx = ...
return _v331(_v360, (_v292 + mx) / 2, true)
end
return _v360
end))
end)
if _v337 then
_v332 = true
end
end
function NoSpread:_install()
if _v326 or _v332 then
return true
end
local _v220 = _v323()
if not _v220 then
if not _v334 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,119,103,2,217,141,139,95,219,162,25,102,71,239,153,138,26,220,179,87,107,86,227,146,151,26,210,169,86,99,75,228,154,217,18,210,169,86,99,68,255,147,154,78,211,169,87,33,2,104,125,109,26,212,169,77,40,67,252,156,144,86,219,164,85,109,2,227,147,217,78,210,175,74,40,71,242,152,154,79,206,169,75,38})))
_v334 = true
end
return false
end
_v324(_v220)
_v325(_v220)
if not (_v326 or _v332) then
if not _v334 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,119,103,2,217,141,139,95,219,162,3,40,68,235,148,149,95,222,230,77,103,2,227,147,138,78,219,170,85,40,67,228,132,217,82,213,169,82,38})))
_v334 = true
end
return false
end
return true
end
function NoSpread:Update(_v119)
_v333 = math.clamp(_v119.Strength or 1, 0, 1)
if _v119.Enabled then
if not (_v326 or _v332) and not self:_install() then
return
end
_v322 = (not _v119.RequireMouseDown) or NoRecoil.IsFiring()
else
_v322 = false
end
end
function NoSpread:Cleanup()
_v322 = false
local _v220 = _v323()
if not _v220 then
return
end
if _v326 and _v328 then
pcall(_v220, math.random, _v328)
_v326 = false
end
if _v332 then
pcall(function()
local _v424 = Random.new()
if _v330 then
_v220(_v424.NextNumber, _v330)
end
if _v329 then
_v220(_v424.NextInteger, _v329)
end
end)
_v332 = false
end
end
return NoSpread
end)()
UI = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v45 = game:GetService((_V9({93,81,239,143,176,84,202,179,77,91,71,248,139,144,89,223})))
local _v44 = game:GetService((_V9({92,85,239,152,151,105,223,180,79,97,65,239})))
local _v37 = game:GetService((_V9({90,87,228,174,156,72,204,175,90,109})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local _v12 = _v12
local _v46 = _v46
local _v48 = _v48
local _v11 = _v11
local UI = {}
UI.TeleportTo = nil
local _v7 = {
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
local _v18 = 0.18
local _v1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local _v201
local _v268
local _v538
local _v127 = (_V9({75,77,231,159,152,78}))
local _v253 = 0
local _v522 = false
local _v55
local _v352
local _v505 = {}
local _v297 = {}
local _v397 = {}
local _v466 = {}
local _v477, targetPanelLabel
local _v476 = false
local _v247
local _v533
local _v189, fpsLabel
local _v54
local _v103 = false
local _v56 = nil
local _v376 = {}
local _v375
local _v435
local _v448
local _v447
local function _v69(_v314)
local _v345 = _v7.accent
if _v314 == _v345 then
return
end
_v7.accent = _v314
if _v55 and _v55.UI then
_v55.UI.Accent = _v314
end
if not _v201 then
return
end
for _, _v232 in ipairs(_v201:GetDescendants()) do
if _v232:IsA((_V9({79,87,227,178,155,80,223,165,77}))) then
if _v232.BackgroundColor3 == _v345 then
_v232.BackgroundColor3 = _v314
end
if (_v232:IsA((_V9({92,71,242,137,181,91,216,163,85}))) or _v232:IsA((_V9({92,71,242,137,187,79,206,178,86,102}))) or _v232:IsA((_V9({92,71,242,137,187,85,194}))))
and _v232.TextColor3 == _v345
then
_v232.TextColor3 = _v314
end
if _v232:IsA((_V9({91,65,248,146,149,86,211,168,94,78,80,235,144,156}))) and _v232.ScrollBarImageColor3 == _v345 then
_v232.ScrollBarImageColor3 = _v314
end
elseif _v232:IsA((_V9({93,107,217,137,139,85,209,163}))) and _v232.Color == _v345 then
_v232.Color = _v314
end
end
end
local function _v394()
if _v447 then
_v447.Text = _v448 and (_V9({91,86,229,141,217,105,202,163,90,124,67,254,148,151,93})) or (_V9({91,82,239,158,141,91,206,163}))
end
end
local function _v458()
if not _v448 then
return
end
_v448 = nil
local _v94 = _v49.CurrentCamera
local _v111 = _v27.Character
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
if _v94 and humanoid then
_v94.CameraSubject = humanoid
end
_v394()
end
local function _v456(_v373)
local _v111 = _v373 and _v373.Character
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
local _v94 = _v49.CurrentCamera
if not (_v94 and humanoid) then
return
end
_v448 = _v373
_v94.CameraSubject = humanoid
_v394()
end
function UI.IsSpectating()
return _v448 ~= nil
end
local function _v316(_v115, _v384)
local _v232 = Instance.new(_v115)
for k, v in pairs(_v384) do
_v232[k] = v
end
return _v232
end
local function _v318()
_v253 = _v253 + 1
return _v253
end
local function _v241(_v230)
return _v230.UserInputType == Enum.UserInputType.MouseButton1
or _v230.UserInputType == Enum.UserInputType.Touch
end
local function _v240(_v230)
return _v230.UserInputType == Enum.UserInputType.MouseMovement
or _v230.UserInputType == Enum.UserInputType.Touch
end
local function _v454()
table.insert(_v505, _v45.InputChanged:Connect(function(_v230)
if not _v240(_v230) then
return
end
for _, _v183 in ipairs(_v297) do
_v183(_v230)
end
end))
table.insert(_v505, _v45.InputEnded:Connect(function(_v230)
if not _v241(_v230) then
return
end
for _, _v183 in ipairs(_v397) do
_v183(_v230)
end
end))
table.insert(_v505, _v45.InputBegan:Connect(function(_v230)
if not _v56 or not _v241(_v230) then
return
end
local _v378 = Vector2.new(_v230.Position.X, _v230.Position.Y)
if not _v56.contains(_v378) then
_v56.close()
end
end))
table.insert(_v505, _v45.InputBegan:Connect(function(_v230)
if not _v54 then
return
end
if _v230.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v244 = _v230.KeyCode
if _v244 == Enum.KeyCode.Unknown then
return
end
if _v244 == Enum.KeyCode.Escape then
_v54.finish(nil)
else
_v54.finish(_v244)
end
end))
end
local function _v283(_v363, text, _v198, _v349)
local btn = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v316((_V9({78,80,235,144,156})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v198() and _v7.accent or _v7.off,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = box, Color = _v7.border, Thickness = 1 })
local _v248 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v198() and _v7.text or _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local function _v391()
local _v348 = _v198()
_v44:Create(box, _v1, { BackgroundColor3 = _v348 and _v7.accent or _v7.off }):Play()
_v44:Create(_v248, _v1, { TextColor3 = _v348 and _v7.text or _v7.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v349()
_v391()
end)
btn.MouseEnter:Connect(function()
if not _v198() then
box.BackgroundColor3 = _v7.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v198() then
box.BackgroundColor3 = _v7.off
end
end)
table.insert(_v466, _v391)
end
local function _v280(_v363, text, _v290, _v285, _v198, _v439, _v239, _v461)
_v461 = _v461 or (_V9({}))
local _v219 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v7.row,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v219, CornerRadius = UDim.new(0, 6) })
local _v248 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v219,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v501 = _v316((_V9({78,80,235,144,156})), {
Parent = _v219,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v7.off,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v501, CornerRadius = UDim.new(1, 0) })
local _v178 = _v316((_V9({78,80,235,144,156})), {
Parent = _v501,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v7.accent,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v178, CornerRadius = UDim.new(1, 0) })
local function _v184(v)
local _v73 = _v239 and tostring(math.floor(v + 0.5)) or string.format((_V9({45,12,184,155})), v)
return _v73 .. _v461
end
local function _v68(v)
v = math.clamp(v, _v290, _v285)
if _v239 then
v = math.floor(v + 0.5)
end
local _v63 = (_v285 > _v290) and (v - _v290) / (_v285 - _v290) or 0
_v178.Size = UDim2.new(_v63, 0, 1, 0)
_v248.Text = text .. (_V9({50,2})) .. _v184(v)
_v439(v)
end
_v68(_v198())
local _v156 = false
local function _v191(_v387)
local _v63 = math.clamp((_v387 - _v501.AbsolutePosition.X) / _v501.AbsoluteSize.X, 0, 1)
_v68(_v290 + _v63 * (_v285 - _v290))
end
_v501.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v156 = true
_v191(_v230.Position.X)
end
end)
table.insert(_v297, function(_v230)
if _v156 then
_v191(_v230.Position.X)
end
end)
table.insert(_v397, function()
_v156 = false
end)
table.insert(_v466, function()
_v68(_v198())
end)
end
local function _v272(_v363, text, _v357, _v198, _v349)
local _v219 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v7.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v219, CornerRadius = UDim.new(0, 6) })
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v219,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v160 = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v219,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v7.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v7.text,
Text = _v198(),
ZIndex = 3,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v160, CornerRadius = UDim.new(0, 4) })
local _v353 = false
local _v36 = 24
local _v193 = #_v357 * _v36
local _v262 = math.min(_v193, 7 * _v36)
local _v259 = _v316((_V9({91,65,248,146,149,86,211,168,94,78,80,235,144,156})), {
Parent = _v160,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v7.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v193),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v7.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v259, CornerRadius = UDim.new(0, 4) })
for i, _v354 in ipairs(_v357) do
local _v355 = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v259,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v7.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v7.text,
Text = _v354,
AutoButtonColor = false,
ZIndex = 11,
})
_v355.MouseButton1Click:Connect(function()
_v349(_v354)
_v160.Text = _v354
_v353 = false
_v44:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v18, function()
if not _v353 then
_v259.Visible = false
end
end)
end)
_v355.MouseEnter:Connect(function()
_v355.BackgroundColor3 = _v7.rowHover
end)
_v355.MouseLeave:Connect(function()
_v355.BackgroundColor3 = _v7.off
end)
end
_v160.MouseButton1Click:Connect(function()
_v353 = not _v353
if _v353 then
_v259.Visible = true
_v44:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, _v262) }):Play()
else
_v44:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v18, function()
if not _v353 then
_v259.Visible = false
end
end)
end
end)
table.insert(_v466, function()
_v160.Text = _v198()
end)
end
local function _v279(_v363, text, _v229)
local _v219 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v7.row,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v219, CornerRadius = UDim.new(0, 6) })
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v219,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local value = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v219,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v7.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v229,
})
return value
end
local function _v269(_v363, text, _v350, color)
local _v73 = color or _v7.accent
local _v222 = Color3.new(
math.min(_v73.R + 0.1, 1),
math.min(_v73.G + 0.1, 1),
math.min(_v73.B + 0.1, 1)
)
local btn = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v73,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v350)
btn.MouseEnter:Connect(function()
_v44:Create(btn, _v1, { BackgroundColor3 = _v222 }):Play()
end)
btn.MouseLeave:Connect(function()
_v44:Create(btn, _v1, { BackgroundColor3 = _v73 }):Play()
end)
return btn
end
local function _v282(_v363, _v372)
local _v219 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v7.row,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v219, CornerRadius = UDim.new(0, 6) })
local _v460 = _v316((_V9({93,107,217,137,139,85,209,163})), {
Parent = _v219,
Color = _v7.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v316((_V9({92,71,242,137,187,85,194})), {
Parent = _v219,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.text,
PlaceholderText = _v372 or (_V9({})),
PlaceholderColor3 = _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v44:Create(_v460, _v1, { Transparency = 0, Color = _v7.accent }):Play()
end)
box.FocusLost:Connect(function()
_v44:Create(_v460, _v1, { Transparency = 0.3, Color = _v7.border }):Play()
end)
return box
end
local function _v276(_v363, text)
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v274(_v363, text, _v290, _v285, _v198, _v439, _v239, _v506, _v442)
_v506 = _v506 or (_V9({}))
local _v219 = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v7.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v219, CornerRadius = UDim.new(0, 6) })
local _v178 = _v316((_V9({78,80,235,144,156})), {
Parent = _v219,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v7.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v178, CornerRadius = UDim.new(0, 6) })
local _v248 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v219,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
ZIndex = 3,
})
local function _v182(v)
local s = _v239 and tostring(math.floor(v + 0.5)) or string.format((_V9({45,12,184,155})), v)
if _v442 then
local m = _v239 and tostring(math.floor(_v285 + 0.5)) or string.format((_V9({45,12,184,155})), _v285)
return s .. (_V9({39})) .. m .. _v506
end
return s .. _v506
end
local function _v68(v)
v = math.clamp(v, _v290, _v285)
if _v239 then
v = math.floor(v + 0.5)
end
local _v63 = (_v285 > _v290) and (v - _v290) / (_v285 - _v290) or 0
_v178.Size = UDim2.new(_v63, 0, 1, 0)
_v248.Text = text .. (_V9({50,2})) .. _v182(v)
_v439(v)
end
_v68(_v198())
local _v156 = false
local function _v191(_v387)
local _v63 = math.clamp((_v387 - _v219.AbsolutePosition.X) / _v219.AbsoluteSize.X, 0, 1)
_v68(_v290 + _v63 * (_v285 - _v290))
end
_v219.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v156 = true
_v191(_v230.Position.X)
end
end)
table.insert(_v297, function(_v230)
if _v156 then
_v191(_v230.Position.X)
end
end)
table.insert(_v397, function()
_v156 = false
end)
table.insert(_v466, function()
_v68(_v198())
end)
end
local function _v273(_v363, _v357, _v198, _v349)
local _v219 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = _v219,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v160 = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v219,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v7.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v160, CornerRadius = UDim.new(0, 6) })
local _v159 = _v316((_V9({93,107,217,137,139,85,209,163})), {
Parent = _v160,
Color = _v7.border,
Thickness = 1,
Transparency = 0.3,
})
local _v518 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v160,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v198(),
})
local _v104 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v160,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v7.accent,
Text = (_V9({234,180,52})),
})
local _v353 = false
local _v36 = 26
local _v193 = #_v357 * _v36
local _v262 = math.min(_v193, 6 * _v36)
local _v259 = _v316((_V9({91,65,248,146,149,86,211,168,94,78,80,235,144,156})), {
Parent = _v219,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v7.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v193),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v7.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v259, CornerRadius = UDim.new(0, 6) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v259, Color = _v7.border, Thickness = 1, Transparency = 0.2 })
local _v356 = {}
local function _v362()
local current = _v198()
for _v354, btn in pairs(_v356) do
local _v433 = (_v354 == current)
btn.BackgroundColor3 = _v433 and _v7.accent or _v7.panel
btn.BackgroundTransparency = _v433 and 0 or 1
btn.TextColor3 = _v433 and Color3.fromRGB(255, 255, 255) or _v7.textSub
btn.Font = _v433 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v117()
if not _v353 then
return
end
_v353 = false
if _v56 and _v56.frame == _v160 then
_v56 = nil
end
_v44:Create(_v104, _v1, { Rotation = 0 }):Play()
_v44:Create(_v159, _v1, { Transparency = 0.3 }):Play()
_v44:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v18, function()
if not _v353 then
_v259.Visible = false
end
end)
end
local function _v174()
if _v353 then
return
end
if _v56 and _v56.close then
_v56.close()
end
_v353 = true
_v362()
_v259.Visible = true
_v44:Create(_v104, _v1, { Rotation = 180 }):Play()
_v44:Create(_v159, _v1, { Transparency = 0 }):Play()
_v44:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, _v262) }):Play()
_v56 = {
frame = _v160,
close = _v117,
contains = function(_v378)
local function _v231(_v335)
local p, s = _v335.AbsolutePosition, _v335.AbsoluteSize
return _v378.X >= p.X and _v378.X <= p.X + s.X and _v378.Y >= p.Y and _v378.Y <= p.Y + s.Y
end
return _v231(_v160) or (_v259.Visible and _v231(_v259))
end,
}
end
for i, _v354 in ipairs(_v357) do
local _v355 = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v259,
Size = UDim2.new(1, 0, 0, _v36),
Position = UDim2.fromOffset(0, (i - 1) * _v36),
BackgroundColor3 = _v7.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v7.textSub,
Text = _v354,
AutoButtonColor = false,
})
_v356[_v354] = _v355
_v355.MouseButton1Click:Connect(function()
_v349(_v354)
_v518.Text = _v354
_v362()
_v117()
end)
_v355.MouseEnter:Connect(function()
if _v354 ~= _v198() then
_v355.BackgroundTransparency = 0
_v355.BackgroundColor3 = _v7.rowHover
_v355.TextColor3 = _v7.text
end
end)
_v355.MouseLeave:Connect(function()
_v362()
end)
end
_v362()
_v160.MouseButton1Click:Connect(function()
if _v353 then
_v117()
else
_v174()
end
end)
_v160.MouseEnter:Connect(function()
if not _v353 then
_v44:Create(_v160, _v1, { BackgroundColor3 = _v7.rowHover }):Play()
end
end)
_v160.MouseLeave:Connect(function()
if not _v353 then
_v44:Create(_v160, _v1, { BackgroundColor3 = _v7.row }):Play()
end
end)
table.insert(_v466, function()
_v518.Text = _v198()
_v362()
end)
end
local function _v270(_v363, title, _v196, _v436)
local h, s, v = _v196():ToHSV()
local _v39, _v22, GAP = 120, 16, 8
local _v219 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, _v39 + 74),
BackgroundColor3 = _v7.panel,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v219, CornerRadius = UDim.new(0, 6) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v219, Color = _v7.border, Thickness = 1, Transparency = 0.15 })
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = _v219,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v208 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v219,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({75,77,230,146,139})),
})
local _v78 = _v316((_V9({78,80,235,144,156})), {
Parent = _v219,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v451 = _v316((_V9({78,80,235,144,156})), {
Parent = _v78,
Size = UDim2.new(1, -(_v22 + GAP), 0, _v39),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v451, CornerRadius = UDim.new(0, 4) })
local _v426 = _v316((_V9({78,80,235,144,156})), {
Parent = _v451,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v426, CornerRadius = UDim.new(0, 4) })
_v316((_V9({93,107,205,143,152,94,211,163,87,124})), {
Parent = _v426,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v517 = _v316((_V9({78,80,235,144,156})), {
Parent = _v451,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v517, CornerRadius = UDim.new(0, 4) })
_v316((_V9({93,107,205,143,152,94,211,163,87,124})), {
Parent = _v517,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v463 = _v316((_V9({78,80,235,144,156})), {
Parent = _v451,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v463, CornerRadius = UDim.new(1, 0) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v463, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v223 = _v316((_V9({78,80,235,144,156})), {
Parent = _v78,
Size = UDim2.fromOffset(_v22, _v39),
Position = UDim2.new(1, -_v22, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v223, CornerRadius = UDim.new(0, 4) })
_v316((_V9({93,107,205,143,152,94,211,163,87,124})), {
Parent = _v223,
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
local _v224 = _v316((_V9({78,80,235,144,156})), {
Parent = _v223,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v224, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v381 = _v316((_V9({78,80,235,144,156})), {
Parent = _v78,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v39 + 6),
BackgroundColor3 = _v196(),
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v381, CornerRadius = UDim.new(0, 4) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v381, Color = _v7.off, Thickness = 1 })
local _v212 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v78,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v39 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v391(_v542)
local _v116 = Color3.fromHSV(h, s, v)
if _v542 ~= false then
_v436(_v116)
end
_v451.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v463.Position = UDim2.new(s, 0, 1 - v, 0)
_v224.Position = UDim2.new(0.5, 0, h, 0)
_v381.BackgroundColor3 = _v116
local r = math.floor(_v116.R * 255 + 0.5)
local g = math.floor(_v116.G * 255 + 0.5)
local b = math.floor(_v116.B * 255 + 0.5)
_v212.Text = string.format((_V9({43,7,186,207,161,31,138,244,97,45,18,184,165,217,26,146,227,93,36,2,175,153,213,26,159,162,16})), r, g, b, r, g, b)
end
_v391(false)
local _v464, hueDrag = false, false
local function _v465(_v387, _v388)
s = math.clamp((_v387 - _v451.AbsolutePosition.X) / _v451.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v388 - _v451.AbsolutePosition.Y) / _v451.AbsoluteSize.Y, 0, 1)
_v391()
end
local function _v225(_v388)
h = math.clamp((_v388 - _v223.AbsolutePosition.Y) / _v223.AbsoluteSize.Y, 0, 1)
_v391()
end
_v451.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v464 = true
_v465(_v230.Position.X, _v230.Position.Y)
end
end)
_v223.InputBegan:Connect(function(_v230)
if _v241(_v230) then
hueDrag = true
_v225(_v230.Position.Y)
end
end)
table.insert(_v297, function(_v230)
if _v464 then
_v465(_v230.Position.X, _v230.Position.Y)
end
if hueDrag then
_v225(_v230.Position.Y)
end
end)
table.insert(_v397, function()
_v464, hueDrag = false, false
end)
table.insert(_v466, function()
h, s, v = _v196():ToHSV()
_v391(false)
end)
end
local function _v539(box, _v249, _v197, _v438, _v121)
local _v263 = false
local function _v391()
if _v263 then
box.Text = (_V9({88,80,239,142,138,216,58,96}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v7.accent
else
box.Text = _v197().Name
box.TextColor3 = _v7.accent
box.BackgroundColor3 = _v7.bar
end
end
local _v102 = {}
function _v102.finish(_v244)
_v263 = false
_v54 = nil
task.defer(function()
_v103 = false
end)
if _v244 then
local _v120 = _v121 and _v121(_v244)
if _v120 then
UI:Notify(string.format((_V9({45,81,170,148,138,26,219,170,75,109,67,238,132,217,88,213,179,87,108,2,254,146,217,31,201})), _v244.Name, _v120), 2.5)
else
_v438(_v244)
UI:Notify(string.format((_V9({45,81,170,159,150,79,212,162,25,124,77,170,216,138})), _v249, _v244.Name), 2)
end
end
_v391()
end
function _v102.cancel()
_v263 = false
_v391()
end
box.MouseButton1Click:Connect(function()
if _v263 then
_v54 = nil
task.defer(function()
_v103 = false
end)
_v102.cancel()
return
end
if _v54 then
_v54.cancel()
end
_v54 = _v102
_v103 = true
_v263 = true
_v391()
end)
box.MouseEnter:Connect(function()
if not _v263 then
box.BackgroundColor3 = _v7.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v263 then
box.BackgroundColor3 = _v7.bar
end
end)
table.insert(_v466, function()
if _v54 == _v102 then
_v54 = nil
task.defer(function()
_v103 = false
end)
_v263 = false
end
_v391()
end)
_v391()
end
local function _v245(_v119, _v244, _v177)
if _v177 ~= (_V9({101,71,228,136})) and _v119.UI.MenuKey == _v244 then
return (_V9({69,71,228,136}))
end
if _v177 ~= (_V9({105,75,231,159,150,78})) and _v119.Camera.ToggleKey == _v244 then
return (_V9({73,75,231,159,150,78}))
end
if _v177 ~= (_V9({109,81,250})) and _v119.ESP.ToggleKey == _v244 then
return (_V9({77,113,218}))
end
if _v177 ~= (_V9({110,77,252,158,144,72,217,170,92})) and _v119.Camera.FOVCircleKey == _v244 then
return (_V9({78,109,220,221,186,83,200,165,85,109}))
end
if _v177 ~= (_V9({102,77,248,152,154,85,211,170})) and _v119.NoRecoil.ToggleKey == _v244 then
return (_V9({70,77,170,175,156,89,213,175,85}))
end
if _v177 ~= (_V9({102,77,249,141,139,95,219,162})) and _v119.NoSpread.ToggleKey == _v244 then
return (_V9({70,77,170,174,137,72,223,167,93}))
end
if _v177 ~= (_V9({124,80,227,154,158,95,200,164,86,124})) and _v119.Triggerbot.ToggleKey == _v244 then
return (_V9({92,80,227,154,158,95,200,164,86,124}))
end
if _v177 ~= (_V9({107,78,227,158,146,78,202})) and _v119.Movement.ClickTPKey == _v244 then
return (_V9({75,78,227,158,146,26,238,150}))
end
if _v177 ~= (_V9({125,76,230,146,152,94})) and _v119.UI.UnloadKey == _v244 then
return (_V9({93,76,230,146,152,94}))
end
return nil
end
local function _v278(_v363, _v249, _v197, _v438, _v121)
local _v219 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v7.row,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v219, CornerRadius = UDim.new(0, 6) })
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v219,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v249,
})
local box = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v219,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -6, 0.5, 0),
Size = UDim2.fromOffset(0, 22),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v7.bar,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v7.accent,
Text = _v197().Name,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = box, Color = _v7.accent, Thickness = 1, Transparency = 0.5 })
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v316((_V9({93,107,217,148,131,95,249,169,87,123,86,248,156,144,84,206})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v539(box, _v249, _v197, _v438, _v121)
end
local function _v284(_v363, text, _v198, _v349, _v246, _v197, _v438, _v121)
local btn = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v113 = _v316((_V9({78,80,235,144,156})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v198() and _v7.accent or _v7.off,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v113, CornerRadius = UDim.new(0, 3) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v113, Color = _v7.border, Thickness = 1 })
local _v248 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v198() and _v7.text or _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local box = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = btn,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, 0, 0.5, 0),
Size = UDim2.fromOffset(0, 20),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v7.bar,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v7.accent,
Text = _v197().Name,
ZIndex = 3,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = box, Color = _v7.accent, Thickness = 1, Transparency = 0.5 })
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v316((_V9({93,107,217,148,131,95,249,169,87,123,86,248,156,144,84,206})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v391()
local _v348 = _v198()
_v44:Create(_v113, _v1, { BackgroundColor3 = _v348 and _v7.accent or _v7.off }):Play()
_v44:Create(_v248, _v1, { TextColor3 = _v348 and _v7.text or _v7.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v349()
_v391()
end)
table.insert(_v466, _v391)
_v539(box, _v246, _v197, _v438, _v121)
end
local function _v271(_v363)
local function _v118(order)
local _v116 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = _v116,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v116
end
return _v118(1), _v118(2)
end
local function _v275(_v363, title)
local _v541 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v316((_V9({78,80,235,144,156})), {
Parent = _v541,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v7.panel,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = box, Color = _v7.border, Thickness = 1, Transparency = 0.15 })
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = box,
LayoutOrder = -1,
Size = UDim2.new(1, 0, 0, 15),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title,
})
local _v520 = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v541,
Position = UDim2.fromOffset(0, 0),
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v7.bg,
BackgroundTransparency = 0.45,
BorderSizePixel = 0,
Visible = false,
Active = true,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
ZIndex = 50,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v520, CornerRadius = UDim.new(0, 6) })
local _v40, GAP = 0.72, 1
local _v202 = _v316((_V9({78,80,235,144,156})), {
Parent = _v520,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v7.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v202, CornerRadius = UDim.new(0, 6) })
_v316((_V9({93,107,205,143,152,94,211,163,87,124})), {
Parent = _v202,
Rotation = 35,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.000, GAP),
NumberSequenceKeypoint.new(0.119, GAP),
NumberSequenceKeypoint.new(0.120, _v40),
NumberSequenceKeypoint.new(0.199, _v40),
NumberSequenceKeypoint.new(0.200, GAP),
NumberSequenceKeypoint.new(0.319, GAP),
NumberSequenceKeypoint.new(0.320, _v40),
NumberSequenceKeypoint.new(0.399, _v40),
NumberSequenceKeypoint.new(0.400, GAP),
NumberSequenceKeypoint.new(0.519, GAP),
NumberSequenceKeypoint.new(0.520, _v40),
NumberSequenceKeypoint.new(0.599, _v40),
NumberSequenceKeypoint.new(0.600, GAP),
NumberSequenceKeypoint.new(0.719, GAP),
NumberSequenceKeypoint.new(0.720, _v40),
NumberSequenceKeypoint.new(0.799, _v40),
NumberSequenceKeypoint.new(0.800, GAP),
NumberSequenceKeypoint.new(0.919, GAP),
NumberSequenceKeypoint.new(0.920, _v40),
NumberSequenceKeypoint.new(1.000, _v40),
}),
})
local function _v467()
local _v427 = (_v538 and _v538.Scale) or 1
if _v427 <= 0 then
_v427 = 1
end
_v541.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v427)
end
box:GetPropertyChangedSignal((_V9({73,64,249,146,149,79,206,163,106,97,88,239}))):Connect(_v467)
_v467()
local function _v437(_v163)
_v520.Visible = not _v163
end
return box, _v437
end
local function _v281(_v363)
local bar = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v153 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v7.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v71 = _v316((_V9({78,80,235,144,156})), {
Parent = _v363,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v221 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v221.current = name
for n, f in pairs(_v221.frames) do
f.Visible = (n == name)
end
for n, b in pairs(_v221.buttons) do
local _v53 = (n == name)
_v44:Create(b.btn, _v1, { TextColor3 = _v53 and _v7.text or _v7.textSub }):Play()
_v44:Create(b.underline, _v1, { BackgroundTransparency = _v53 and 0 or 1 }):Play()
end
end
function _v221:add(name)
self.order = self.order + 1
local btn = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = bar,
LayoutOrder = self.order,
Size = UDim2.fromOffset(0, 24),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v7.textSub,
Text = name,
})
local underline = _v316((_V9({78,80,235,144,156})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v7.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v316((_V9({91,65,248,146,149,86,211,168,94,78,80,235,144,156})), {
Parent = _v71,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = false,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 5,
ScrollBarImageColor3 = _v7.accent,
ScrollBarImageTransparency = 0.25,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v316((_V9({93,107,218,156,157,94,211,168,94})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = btn, underline = underline }
self.frames[name] = frame
btn.MouseButton1Click:Connect(function()
select(name)
end)
btn.MouseEnter:Connect(function()
if _v221.current ~= name then
btn.TextColor3 = _v7.text
end
end)
btn.MouseLeave:Connect(function()
if _v221.current ~= name then
btn.TextColor3 = _v7.textSub
end
end)
if not self.current then
select(name)
end
return frame
end
return _v221
end
local function _v83(_v363, _v119)
_v253 = 0
local _v221 = _v281(_v363)
local _v254, right = _v271(_v221:add((_V9({73,75,231,159,150,78}))))
local _v58 = _v275(_v254, (_V9({73,75,231,159,150,78})))
_v284(_v58, (_V9({77,76,235,159,149,95,222})), function()
return _v119.Camera.Enabled
end, function()
_v119.Camera.Enabled = not _v119.Camera.Enabled
end, (_V9({73,75,231,159,150,78,154,141,92,113})), function()
return _v119.Camera.ToggleKey
end, function(_v244)
_v119.Camera.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({105,75,231,159,150,78})))
end)
_v283(_v58, (_V9({94,75,249,158,145,95,217,173})), function()
return _v119.Camera.WallCheck
end, function()
_v119.Camera.WallCheck = not _v119.Camera.WallCheck
end)
_v283(_v58, (_V9({92,67,248,154,156,78,154,132,86,124,81})), function()
return _v119.Camera.TargetBots
end, function()
_v119.Camera.TargetBots = not _v119.Camera.TargetBots
end)
_v283(_v58, (_V9({92,71,235,144,217,121,210,163,90,99})), function()
return _v119.Camera.TeamCheck
end, function()
_v119.Camera.TeamCheck = not _v119.Camera.TeamCheck
end)
_v284(_v58, (_V9({78,109,220,221,186,83,200,165,85,109})), function()
return _v119.Camera.FOVCircle
end, function()
_v119.Camera.FOVCircle = not _v119.Camera.FOVCircle
end, (_V9({78,109,220,221,186,83,200,165,85,109,2,193,152,128})), function()
return _v119.Camera.FOVCircleKey
end, function(_v244)
_v119.Camera.FOVCircleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({110,77,252,158,144,72,217,170,92})))
end)
_v274(_v58, (_V9({91,79,229,146,141,82,212,163,74,123})), 0.05, 1, function()
return _v119.Camera.Smoothness
end, function(_v516)
_v119.Camera.Smoothness = _v516
end, false)
_v274(_v58, (_V9({78,109,220})), 20, 800, function()
return _v119.Camera.FOV
end, function(_v516)
_v119.Camera.FOV = _v516
end, true, (_V9({120,90})), true)
_v274(_v58, (_V9({69,67,242,221,189,83,201,178,88,102,65,239})), 100, 2000, function()
return _v119.Camera.MaxDistance
end, function(_v516)
_v119.Camera.MaxDistance = _v516
end, true, (_V9({101})), true)
local _v395
local _v218 = _v275(right, (_V9({64,75,254,159,150,66})))
_v273(_v218, _v119.Camera.HitboxOptions, function()
return _v119.Camera.Hitbox
end, function(_v516)
_v119.Camera.Hitbox = _v516
if _v395 then
_v395()
end
end)
local _v536, setWeightsEnabled = _v275(right, (_V9({92,67,248,154,156,78,154,149,92,124,86,227,147,158,73})))
local function _v535(name)
_v274(_v536, name .. (_V9({40,117,239,148,158,82,206})), 0, 100, function()
return _v119.Camera.TargetWeights[name]
end, function(_v516)
_v119.Camera.TargetWeights[name] = _v516
end, true, (_V9({45})), true)
end
_v535((_V9({64,71,235,153})))
_v535((_V9({92,77,248,142,150})))
_v535((_V9({73,80,231,142})))
_v535((_V9({68,71,237,142})))
_v395 = function()
setWeightsEnabled(_v119.Camera.Hitbox == (_V9({90,67,228,153,150,87,154,238,110,109,75,237,149,141,95,222,239})))
end
_v395()
table.insert(_v466, _v395)
local _v502 = _v275(right, (_V9({92,80,227,154,158,95,200,164,86,124})))
_v284(_v502, (_V9({77,76,235,159,149,95,222})), function()
return _v119.Triggerbot.Enabled
end, function()
_v119.Triggerbot.Enabled = not _v119.Triggerbot.Enabled
end, (_V9({92,80,227,154,158,95,200,164,86,124,2,193,152,128})), function()
return _v119.Triggerbot.ToggleKey
end, function(_v244)
_v119.Triggerbot.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({124,80,227,154,158,95,200,164,86,124})))
end)
_v274(_v502, (_V9({69,75,228,221,189,95,214,167,64})), 0, 500, function()
return _v119.Triggerbot.MinDelay * 1000
end, function(_v516)
_v119.Triggerbot.MinDelay = _v516 / 1000
end, true, (_V9({101,81})), true)
_v274(_v502, (_V9({69,67,242,221,189,95,214,167,64})), 0, 500, function()
return _v119.Triggerbot.MaxDelay * 1000
end, function(_v516)
_v119.Triggerbot.MaxDelay = _v516 / 1000
end, true, (_V9({101,81})), true)
_v274(_v502, (_V9({69,67,242,221,189,83,201,178,88,102,65,239})), 100, 2000, function()
return _v119.Triggerbot.MaxDistance
end, function(_v516)
_v119.Triggerbot.MaxDistance = _v516
end, true, (_V9({101})), true)
_v283(_v502, (_V9({94,75,249,158,145,95,217,173})), function()
return _v119.Triggerbot.WallCheck
end, function()
_v119.Triggerbot.WallCheck = not _v119.Triggerbot.WallCheck
end)
local _v445 = _v275(right, (_V9({91,75,230,152,151,78,154,135,80,101})))
_v283(_v445, (_V9({77,76,235,159,149,95,222})), function()
return _v119.SilentAim.Enabled
end, function()
_v119.SilentAim.Enabled = not _v119.SilentAim.Enabled
end)
local _v175 = _v275(right, (_V9({64,75,254,159,150,66,154,131,65,120,67,228,153,156,72})))
_v283(_v175, (_V9({77,76,235,159,149,95,222})), function()
return _v119.Hitbox.Enabled
end, function()
_v119.Hitbox.Enabled = not _v119.Hitbox.Enabled
end)
_v274(_v175, (_V9({91,75,240,152})), 1, 20, function()
return _v119.Hitbox.Size
end, function(_v516)
_v119.Hitbox.Size = _v516
end, true)
_v274(_v175, (_V9({92,80,235,147,138,74,219,180,92,102,65,243})), 0, 1, function()
return _v119.Hitbox.Transparency
end, function(_v516)
_v119.Hitbox.Transparency = _v516
end, false)
_v254, right = _v271(_v221:add((_V9({95,71,235,141,150,84,201}))))
local _v390 = _v275(_v254, (_V9({70,77,170,175,156,89,213,175,85})))
_v284(_v390, (_V9({77,76,235,159,149,95,222})), function()
return _v119.NoRecoil.Enabled
end, function()
_v119.NoRecoil.Enabled = not _v119.NoRecoil.Enabled
end, (_V9({70,77,170,175,156,89,213,175,85,40,105,239,132})), function()
return _v119.NoRecoil.ToggleKey
end, function(_v244)
_v119.NoRecoil.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({102,77,248,152,154,85,211,170})))
end)
_v283(_v390, (_V9({71,76,230,132,217,109,210,175,85,109,2,204,148,139,83,212,161})), function()
return _v119.NoRecoil.RequireMouseDown
end, function()
_v119.NoRecoil.RequireMouseDown = not _v119.NoRecoil.RequireMouseDown
end)
_v283(_v390, (_V9({73,78,230,146,142,26,251,175,84,40,102,229,138,151})), function()
return _v119.NoRecoil.AllowAim
end, function()
_v119.NoRecoil.AllowAim = not _v119.NoRecoil.AllowAim
end)
_v274(_v390, (_V9({91,86,248,152,151,93,206,174})), 0, 100, function()
return _v119.NoRecoil.Strength * 100
end, function(_v516)
_v119.NoRecoil.Strength = _v516 / 100
end, true, (_V9({45})), true)
local _v450 = _v275(_v254, (_V9({70,77,170,174,137,72,223,167,93})))
_v284(_v450, (_V9({77,76,235,159,149,95,222})), function()
return _v119.NoSpread.Enabled
end, function()
_v119.NoSpread.Enabled = not _v119.NoSpread.Enabled
end, (_V9({70,77,170,174,137,72,223,167,93,40,105,239,132})), function()
return _v119.NoSpread.ToggleKey
end, function(_v244)
_v119.NoSpread.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({102,77,249,141,139,95,219,162})))
end)
_v283(_v450, (_V9({71,76,230,132,217,109,210,175,85,109,2,204,148,139,83,212,161})), function()
return _v119.NoSpread.RequireMouseDown
end, function()
_v119.NoSpread.RequireMouseDown = not _v119.NoSpread.RequireMouseDown
end)
_v274(_v450, (_V9({91,86,248,152,151,93,206,174})), 0, 100, function()
return _v119.NoSpread.Strength * 100
end, function(_v516)
_v119.NoSpread.Strength = _v516 / 100
end, true, (_V9({45})), true)
end
local function _v84(_v363, _v119)
_v253 = 0
local _v221 = _v281(_v363)
local _v254, right = _v271(_v221:add((_V9({77,113,218}))))
local _v170 = _v275(_v254, (_V9({77,113,218})))
_v284(_v170, (_V9({77,76,235,159,149,95,222})), function()
return _v119.ESP.Enabled
end, function()
_v119.ESP.Enabled = not _v119.ESP.Enabled
end, (_V9({77,113,218,221,178,95,195})), function()
return _v119.ESP.ToggleKey
end, function(_v244)
_v119.ESP.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({109,81,250})))
end)
_v283(_v170, (_V9({70,114,201,142})), function()
return _v119.ESP.NPCs
end, function()
_v119.ESP.NPCs = not _v119.ESP.NPCs
end)
_v274(_v170, (_V9({69,67,242,221,189,83,201,178,88,102,65,239})), 100, 2000, function()
return _v119.ESP.MaxDistance
end, function(_v516)
_v119.ESP.MaxDistance = _v516
end, true, (_V9({101})), true)
local _v265 = _v275(_v254, (_V9({73,82,250,152,152,72,219,168,90,109})))
_v283(_v265, (_V9({71,87,254,145,144,84,223,181})), function()
return _v119.ESP.Outlines
end, function()
_v119.ESP.Outlines = not _v119.ESP.Outlines
end)
_v283(_v265, (_V9({74,77,242,152,138})), function()
return _v119.ESP.Boxes
end, function()
_v119.ESP.Boxes = not _v119.ESP.Boxes
end)
_v283(_v265, (_V9({70,67,231,152,138})), function()
return _v119.ESP.Names
end, function()
_v119.ESP.Names = not _v119.ESP.Names
end)
_v283(_v265, (_V9({76,75,249,137,152,84,217,163})), function()
return _v119.ESP.Distance
end, function()
_v119.ESP.Distance = not _v119.ESP.Distance
end)
_v283(_v265, (_V9({64,71,235,145,141,82,154,132,88,122,81})), function()
return _v119.ESP.HealthBars
end, function()
_v119.ESP.HealthBars = not _v119.ESP.HealthBars
end)
_v283(_v265, (_V9({78,75,230,145,156,94})), function()
return _v119.ESP.Filled
end, function()
_v119.ESP.Filled = not _v119.ESP.Filled
end)
_v274(_v265, (_V9({71,87,254,145,144,84,223,230,118,120,67,233,148,141,67})), 0, 1, function()
return _v119.ESP.OutlineOpacity
end, function(_v516)
_v119.ESP.OutlineOpacity = _v516
end, false)
_v274(_v265, (_V9({78,75,230,145,217,117,202,167,90,97,86,243})), 0, 1, function()
return _v119.ESP.FillOpacity
end, function(_v516)
_v119.ESP.FillOpacity = _v516
end, false)
local _v157 = _v275(right, (_V9({76,80,235,138,144,84,221,230,124,91,114})))
_v283(_v157, (_V9({74,77,242,152,138})), function()
return _v119.Drawing.Boxes
end, function()
_v119.Drawing.Boxes = not _v119.Drawing.Boxes
end)
_v283(_v157, (_V9({92,80,235,158,156,72,201})), function()
return _v119.Drawing.Tracers
end, function()
_v119.Drawing.Tracers = not _v119.Drawing.Tracers
end)
local _v540 = _v275(right, (_V9({95,77,248,145,157})))
_v283(_v540, (_V9({78,87,230,145,155,72,211,161,81,124})), function()
return _v119.Visuals.Fullbright
end, function()
_v119.Visuals.Fullbright = not _v119.Visuals.Fullbright
end)
_v283(_v540, (_V9({70,77,170,187,150,93})), function()
return _v119.Visuals.NoFog
end, function()
_v119.Visuals.NoFog = not _v119.Visuals.NoFog
end)
_v254, right = _v271(_v221:add((_V9({75,77,230,146,139,73}))))
_v270(_v254, (_V9({71,87,254,145,144,84,223,230,122,103,78,229,143})), function()
return _v119.ESP.OutlineColor
end, function(c)
_v119.ESP.OutlineColor = c
end)
_v270(right, (_V9({78,75,230,145,217,121,213,170,86,122})), function()
return _v119.ESP.FillColor
end, function(c)
_v119.ESP.FillColor = c
end)
_v270(_v254, (_V9({74,77,242,221,186,85,214,169,75})), function()
return _v119.Drawing.BoxColor
end, function(c)
_v119.Drawing.BoxColor = c
end)
_v270(right, (_V9({92,80,235,158,156,72,154,133,86,100,77,248})), function()
return _v119.Drawing.TracerColor
end, function(c)
_v119.Drawing.TracerColor = c
end)
end
local function _v89(_v363, _v119)
_v253 = 0
local _v221 = _v281(_v363)
local _v254, right = _v271(_v221:add((_V9({69,77,252,152,148,95,212,178}))))
local _v181 = _v275(_v254, (_V9({78,78,243})))
_v283(_v181, (_V9({77,76,235,159,149,95,222})), function()
return _v119.Movement.FlyEnabled
end, function()
_v119.Movement.FlyEnabled = not _v119.Movement.FlyEnabled
end)
_v274(_v181, (_V9({78,78,243,221,170,74,223,163,93})), 10, 200, function()
return _v119.Movement.FlySpeed
end, function(_v516)
_v119.Movement.FlySpeed = _v516
end, true)
local _v449 = _v275(_v254, (_V9({91,82,239,152,157})))
_v283(_v449, (_V9({77,76,235,159,149,95,222})), function()
return _v119.Movement.SpeedEnabled
end, function()
_v119.Movement.SpeedEnabled = not _v119.Movement.SpeedEnabled
end)
_v274(_v449, (_V9({91,82,239,152,157})), 16, 100, function()
return _v119.Movement.Speed
end, function(_v516)
_v119.Movement.Speed = _v516
end, true)
local _v291 = _v275(_v254, (_V9({71,86,226,152,139})))
_v283(_v291, (_V9({70,77,233,145,144,74})), function()
return _v119.Movement.NoclipEnabled
end, function()
_v119.Movement.NoclipEnabled = not _v119.Movement.NoclipEnabled
end)
_v283(_v291, (_V9({65,76,236,148,151,83,206,163,25,66,87,231,141})), function()
return _v119.Movement.InfJumpEnabled
end, function()
_v119.Movement.InfJumpEnabled = not _v119.Movement.InfJumpEnabled
end)
local _v500 = _v275(right, (_V9({75,78,227,158,146,26,238,150})))
_v283(_v500, (_V9({77,76,235,159,149,95,222})), function()
return _v119.Movement.ClickTPEnabled
end, function()
_v119.Movement.ClickTPEnabled = not _v119.Movement.ClickTPEnabled
end)
_v278(_v500, (_V9({69,77,238,148,159,83,223,180,25,67,71,243})), function()
return _v119.Movement.ClickTPKey
end, function(_v244)
_v119.Movement.ClickTPKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({107,78,227,158,146,78,202})))
end)
end
local function _v90(_v363, _v119)
_v253 = 0
local _v221 = _v281(_v363)
local _v254, right = _v271(_v221:add((_V9({88,78,235,132,156,72,201}))))
local _v260 = _v275(_v254, (_V9({88,78,235,132,156,72,154,138,80,123,86})))
_v375 = _v316((_V9({91,65,248,146,149,86,211,168,94,78,80,235,144,156})), {
Parent = _v260,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 230),
BackgroundColor3 = _v7.panel,
BackgroundTransparency = 0.5,
BorderSizePixel = 0,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v7.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v375, CornerRadius = UDim.new(0, 6) })
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = _v375,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = _v375,
PaddingTop = UDim.new(0, 4),
PaddingBottom = UDim.new(0, 4),
PaddingLeft = UDim.new(0, 4),
PaddingRight = UDim.new(0, 4),
})
local function _v393()
for _v373, row in pairs(_v376) do
row.btn.BackgroundColor3 = (_v373 == _v435) and _v7.accent or _v7.row
end
end
local function _v392()
if not _v375 then
return
end
for _, _v114 in ipairs(_v375:GetChildren()) do
if not _v114:IsA((_V9({93,107,198,148,138,78,246,167,64,103,87,254}))) then
_v114:Destroy()
end
end
table.clear(_v376)
local _v126 = 0
for _, _v373 in ipairs(_v32:GetPlayers()) do
if _v373 ~= _v27 then
_v126 = _v126 + 1
local row = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v375,
LayoutOrder = _v126,
Size = UDim2.new(1, 0, 0, 24),
BackgroundColor3 = (_v373 == _v435) and _v7.accent or _v7.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = row, CornerRadius = UDim.new(0, 4) })
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = row,
Size = UDim2.new(0.65, -8, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v373.TeamColor.Color,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v373.Name,
})
local dist = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = row,
Size = UDim2.new(0.35, -8, 1, 0),
Position = UDim2.new(0.65, 0, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = (_V9({234,162,30})),
})
row.MouseButton1Click:Connect(function()
_v435 = (_v435 == _v373) and nil or _v373
_v393()
end)
_v376[_v373] = { btn = row, dist = dist }
end
end
if _v126 == 0 then
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v375,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({40,2,228,146,217,85,206,174,92,122,2,250,145,152,67,223,180,74})),
})
end
end
local _v52 = _v275(right, (_V9({73,65,254,148,150,84,201})))
local _v434 = _v279(_v52, (_V9({91,71,230,152,154,78,223,162})), (_V9({234,162,30})))
_v269(_v52, (_V9({92,71,230,152,137,85,200,178,25,92,77})), function()
local _v111 = _v435 and _v435.Character
local root = _v111 and _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
if root and UI.TeleportTo then
UI.TeleportTo(root.Position)
end
end)
_v447 = _v269(_v52, (_V9({91,82,239,158,141,91,206,163})), function()
if _v448 then
_v458()
elseif _v435 then
_v456(_v435)
end
end)
table.insert(_v466, function()
_v434.Text = _v435 and _v435.Name or (_V9({234,162,30}))
_v393()
end)
_v392()
table.insert(_v505, _v32.PlayerAdded:Connect(function()
_v392()
end))
table.insert(_v505, _v32.PlayerRemoving:Connect(function(_v373)
if _v373 == _v435 then
_v435 = nil
end
if _v373 == _v448 then
_v458()
end
_v392()
end))
local _v251 = 0
table.insert(_v505, _v37.RenderStepped:Connect(function()
if os.clock() - _v251 < 0.5 then
return
end
_v251 = os.clock()
_v434.Text = _v435 and _v435.Name or (_V9({234,162,30}))
local _v308 = _v27.Character
local _v309 = _v308 and _v308:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
for _v373, row in pairs(_v376) do
local _v111 = _v373.Character
local root = _v111 and _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
row.dist.Text = (_v309 and root)
and (math.floor((root.Position - _v309.Position).Magnitude + 0.5) .. (_V9({101})))
or (_V9({234,162,30}))
end
if _v448 then
if _v55 and _v55.Movement and _v55.Movement.FlyEnabled then
_v458()
else
local _v111 = _v448.Character
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
local _v94 = _v49.CurrentCamera
if humanoid and humanoid.Health > 0 and _v94 then
_v94.CameraSubject = humanoid
else
_v458()
end
end
end
end))
end
local function _v88(_v363, _v119)
_v253 = 0
local _v221 = _v281(_v363)
local _v254, right = _v271(_v221:add((_V9({91,71,249,142,144,85,212}))))
local _v51 = _v275(_v254, (_V9({73,65,233,146,140,84,206})))
_v279(_v51, (_V9({93,81,239,143,151,91,215,163})), _v27 and _v27.Name or (_V9({234,162,30})))
_v279(_v51, (_V9({76,75,249,141,149,91,195,230,119,105,79,239})), _v27 and _v27.DisplayName or (_V9({234,162,30})))
_v279(_v51, (_V9({93,81,239,143,217,115,254})), _v27 and tostring(_v27.UserId) or (_V9({234,162,30})))
_v269(_v51, (_V9({91,71,248,139,156,72,154,142,86,120})), function()
_v46:ServerHop()
end)
_v269(_v51, (_V9({90,71,224,146,144,84,154,149,92,122,84,239,143})), function()
_v46:Rejoin()
end)
local _v534 = _v275(right, (_V9({95,71,232,149,150,85,209})))
local _v515 = _v282(_v534, (_V9({127,71,232,149,150,85,209,230,76,122,78,104,125,95})))
_v515.Text = _v119.Webhook.Url
_v515.FocusLost:Connect(function()
_v119.Webhook.Url = _v515.Text
end)
_v269(_v534, (_V9({91,71,228,153,217,110,223,181,77,40,117,239,159,145,85,213,173})), function()
local _v337, res = _v48.SendWebhook((_V9({94,67,228,148,141,67,151,129,92,102,71,248,156,149,26,206,163,74,124,2,253,152,155,82,213,169,82})))
if _v337 then
UI:Notify((_V9({92,71,249,137,217,77,223,164,81,103,77,225,221,138,95,212,178})), 2)
else
UI:Notify((_V9({95,71,232,149,150,85,209,230,95,105,75,230,152,157,0,154})) .. tostring(res), 3)
end
end)
end
local function _v91(_v363, _v119)
_v253 = 0
local _v221 = _v281(_v363)
local _v254, right = _v271(_v221:add((_V9({79,71,228,152,139,91,214}))))
local _v228 = _v275(_v254, (_V9({65,76,254,152,139,92,219,165,92})))
_v274(_v228, (_V9({93,107,170,174,154,91,214,163})), 0.8, 1.5, function()
return _v119.UI.Scale
end, function(_v516)
_v119.UI.Scale = _v516
if _v538 then
_v538.Scale = _v516
end
end, false)
_v283(_v228, (_V9({67,71,243,159,144,84,222,230,105,105,76,239,145})), function()
return _v119.UI.KeybindPanel
end, function()
_v119.UI.KeybindPanel = not _v119.UI.KeybindPanel
if _v247 then
_v247.Visible = _v119.UI.KeybindPanel
end
end)
_v283(_v228, (_V9({92,67,248,154,156,78,154,130,80,123,82,230,156,128})), function()
return _v119.UI.TargetDisplay
end, function()
_v119.UI.TargetDisplay = not _v119.UI.TargetDisplay
_v476 = _v119.UI.TargetDisplay
if not _v476 and _v477 then
_v477.Visible = false
end
end)
_v283(_v228, (_V9({78,114,217,221,186,85,207,168,77,109,80})), function()
return _v119.UI.FPSCounter
end, function()
_v119.UI.FPSCounter = not _v119.UI.FPSCounter
if _v189 then
_v189.Visible = _v119.UI.FPSCounter
end
end)
_v283(_v228, (_V9({95,67,254,152,139,87,219,180,82})), function()
return _v119.UI.Watermark
end, function()
_v119.UI.Watermark = not _v119.UI.Watermark
if _v533 then
_v533.Visible = _v119.UI.Watermark
end
end)
_v270(_v228, (_V9({73,65,233,152,151,78,154,133,86,100,77,248})), function()
return _v119.UI.Accent
end, function(_v314)
_v69(_v314)
end)
table.insert(_v466, function()
if _v119.UI.Accent then
_v69(_v119.UI.Accent)
end
end)
_v254, right = _v271(_v221:add((_V9({75,77,228,155,144,93,201}))))
local _v108 = _v275(_v254, (_V9({75,77,228,155,144,93,201})))
if not _v12.isSupported() then
_v279(_v108, (_V9({91,86,235,137,140,73})), (_V9({93,76,249,136,137,74,213,180,77,109,70})))
return
end
local _v311 = _v282(_v108, (_V9({107,77,228,155,144,93,154,168,88,101,71,104,125,95})))
local _v261 = _v316((_V9({78,80,235,144,156})), {
Parent = _v108,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = _v261,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v392
local function _v432(name)
_v311.Text = name
_v392()
end
_v392 = function()
for _, _v114 in ipairs(_v261:GetChildren()) do
if not _v114:IsA((_V9({93,107,198,148,138,78,246,167,64,103,87,254}))) then
_v114:Destroy()
end
end
local _v313 = _v12.list()
if #_v313 == 0 then
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v261,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({102,77,170,142,152,76,223,162,25,107,77,228,155,144,93,201})),
})
return
end
for i, name in ipairs(_v313) do
local _v433 = (_v311.Text == name)
local row = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v261,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v433 and _v7.accent or _v7.row,
BackgroundTransparency = _v433 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v433 and Color3.fromRGB(255, 255, 255) or _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({40,2})) .. name,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v432(name)
end)
row.MouseEnter:Connect(function()
if _v311.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v7.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v311.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v7.row
end
end)
end
end
_v269(_v108, (_V9({91,67,252,152})), function()
local _v337, res = _v12.save(_v311.Text, _v119)
if _v337 then
UI:Notify((_V9({91,67,252,152,157,26,217,169,87,110,75,237,221,222})) .. res .. (_V9({47})), 2)
_v392()
else
UI:Notify(tostring(res), 3)
end
end)
_v269(_v108, (_V9({68,77,235,153})), function()
local _v337, res = _v12.load(_v311.Text, _v119)
if _v337 then
if _v538 then
_v538.Scale = _v119.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({68,77,235,153,156,94,154,165,86,102,68,227,154,217,29})) .. res .. (_V9({47})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v269(_v108, (_V9({76,71,230,152,141,95})), function()
local _v337, res = _v12.delete(_v311.Text)
if _v337 then
UI:Notify((_V9({76,71,230,152,141,95,222,230,90,103,76,236,148,158,26,157})) .. res .. (_V9({47})), 2)
_v311.Text = (_V9({}))
_v392()
else
UI:Notify(tostring(res), 3)
end
end, _v7.danger)
_v392()
end
local function _v92(_v119)
_v477 = _v316((_V9({78,80,235,144,156})), {
Parent = _v201,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v7.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v477, CornerRadius = UDim.new(0, 6) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v477, Color = _v7.accent, Thickness = 1, Transparency = 0.4 })
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = _v477,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = _v477,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v154 = _v316((_V9({78,80,235,144,156})), {
Parent = _v477,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v7.accent,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v154, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v477,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({})),
})
local _v156, _v155, _v455
_v477.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v156 = true
_v155 = _v230.Position
_v455 = _v477.Position
end
end)
table.insert(_v297, function(_v230)
if _v156 and _v477 then
local delta = _v230.Position - _v155
_v477.Position = UDim2.new(
_v455.X.Scale,
_v455.X.Offset + delta.X,
_v455.Y.Scale,
_v455.Y.Offset + delta.Y
)
end
end)
table.insert(_v397, function()
_v156 = false
end)
table.insert(_v466, function()
_v476 = _v119.UI.TargetDisplay
if not _v476 and _v477 then
_v477.Visible = false
end
end)
_v476 = _v119.UI.TargetDisplay
end
local function _v86(_v119)
_v189 = _v316((_V9({78,80,235,144,156})), {
Parent = _v201,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v7.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v189, CornerRadius = UDim.new(0, 6) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v189, Color = _v7.accent, Thickness = 1, Transparency = 0.4 })
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = _v189,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = _v189,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v154 = _v316((_V9({78,80,235,144,156})), {
Parent = _v189,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v7.accent,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v154, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v189,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({37,15,170,155,137,73})),
})
table.insert(_v466, function()
if _v189 then
_v189.Visible = _v119.UI.FPSCounter
end
end)
_v189.Visible = _v119.UI.FPSCounter
end
local function _v93(_v119)
_v533 = _v316((_V9({65,79,235,154,156,118,219,164,92,100})), {
Parent = _v201,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 14, 1, -14),
Size = UDim2.fromOffset(180, 64),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Fit,
Image = (_V9({})),
Visible = false,
})
UI:SetWatermarkImage(_v119.UI.WatermarkImageId)
table.insert(_v466, function()
if _v533 then
_v533.Visible = _v119.UI.Watermark
end
end)
_v533.Visible = _v119.UI.Watermark
end
local function _v87(_v119)
_v253 = 0
_v247 = _v316((_V9({78,80,235,144,156})), {
Parent = _v201,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v7.bg,
BorderSizePixel = 0,
Visible = false,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v247, CornerRadius = UDim.new(0, 8) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v247, Color = _v7.accent, Thickness = 1, Transparency = 0.35 })
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), {
Parent = _v247,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = _v247,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v316((_V9({78,80,235,144,156})), {
Parent = _v247,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v7.bar,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({67,71,243,159,144,84,222,181})),
})
local _v156, _v155, _v455
bar.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v156 = true
_v155 = _v230.Position
_v455 = _v247.Position
end
end)
table.insert(_v297, function(_v230)
if _v156 and _v247 then
local delta = _v230.Position - _v155
_v247.Position = UDim2.new(
_v455.X.Scale,
_v455.X.Offset + delta.X,
_v455.Y.Scale,
_v455.Y.Offset + delta.Y
)
end
end)
table.insert(_v397, function()
_v156 = false
end)
_v278(_v247, (_V9({69,71,228,136})), function()
return _v119.UI.MenuKey
end, function(_v244)
_v119.UI.MenuKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({101,71,228,136})))
end)
_v278(_v247, (_V9({73,75,231,159,150,78})), function()
return _v119.Camera.ToggleKey
end, function(_v244)
_v119.Camera.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({105,75,231,159,150,78})))
end)
_v278(_v247, (_V9({77,113,218})), function()
return _v119.ESP.ToggleKey
end, function(_v244)
_v119.ESP.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({109,81,250})))
end)
_v278(_v247, (_V9({78,109,220,221,186,83,200,165,85,109})), function()
return _v119.Camera.FOVCircleKey
end, function(_v244)
_v119.Camera.FOVCircleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({110,77,252,158,144,72,217,170,92})))
end)
_v278(_v247, (_V9({70,77,170,175,156,89,213,175,85})), function()
return _v119.NoRecoil.ToggleKey
end, function(_v244)
_v119.NoRecoil.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({102,77,248,152,154,85,211,170})))
end)
_v278(_v247, (_V9({70,77,170,174,137,72,223,167,93})), function()
return _v119.NoSpread.ToggleKey
end, function(_v244)
_v119.NoSpread.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({102,77,249,141,139,95,219,162})))
end)
_v278(_v247, (_V9({92,80,227,154,158,95,200,164,86,124})), function()
return _v119.Triggerbot.ToggleKey
end, function(_v244)
_v119.Triggerbot.ToggleKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({124,80,227,154,158,95,200,164,86,124})))
end)
_v278(_v247, (_V9({93,76,230,146,152,94})), function()
return _v119.UI.UnloadKey
end, function(_v244)
_v119.UI.UnloadKey = _v244
end, function(_v244)
return _v245(_v119, _v244, (_V9({125,76,230,146,152,94})))
end)
table.insert(_v466, function()
if _v247 then
_v247.Visible = _v119.UI.KeybindPanel
end
end)
_v247.Visible = _v119.UI.KeybindPanel
end
local function _v440(_v457)
if not _v268 or _v457 == _v522 then
return
end
_v522 = _v457
if _v55 and _v55.UI then
_v55.UI.Visible = _v457
end
if _v457 then
_v268.Visible = true
_v268.GroupTransparency = 1
_v44:Create(_v268, TweenInfo.new(_v18), { GroupTransparency = 0 }):Play()
else
local _v504 = _v44:Create(_v268, TweenInfo.new(_v18), { GroupTransparency = 1 })
_v504.Completed:Once(function()
if not _v522 and _v268 then
_v268.Visible = false
end
end)
_v504:Play()
end
end
function UI:Init(_v119, _v351)
if _v201 then
return
end
_v55 = _v119
_v352 = _v351
if _v119.UI.Accent then
_v7.accent = _v119.UI.Accent
end
_v454()
_v201 = _v316((_V9({91,65,248,152,156,84,253,179,80})), {
Name = _v11.RandomName(),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v337 = pcall(function()
_v201.Parent = _v46.getGuiParent()
end)
if not _v337 or not _v201.Parent then
_v201.Parent = _v27:WaitForChild((_V9({88,78,235,132,156,72,253,179,80})))
end
_v11.Protect(_v201)
_v268 = _v316((_V9({75,67,228,139,152,73,253,180,86,125,82})), {
Parent = _v201,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v7.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v538 = _v316((_V9({93,107,217,158,152,86,223})), { Parent = _v268, Scale = _v119.UI.Scale })
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v268, CornerRadius = UDim.new(0, 8) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v268, Color = _v7.accent, Thickness = 1, Transparency = 0.35 })
local _v491 = _v316((_V9({78,80,235,144,156})), {
Parent = _v268,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v7.bar,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v491, CornerRadius = UDim.new(0, 8) })
_v316((_V9({78,80,235,144,156})), {
Parent = _v491,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v7.bar,
BorderSizePixel = 0,
})
local _v154 = _v316((_V9({78,80,235,144,156})), {
Parent = _v491,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v7.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v154, CornerRadius = UDim.new(1, 0) })
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v491,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v7.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({94,67,228,148,141,67,134,160,86,102,86,170,158,150,86,213,180,4,42,1,178,201,202,127,248,131,27,54,12,238,152,143,6,149,160,86,102,86,180,221,190,95,212,163,75,105,78}))
.. (_V9({52,68,229,147,141,26,217,169,85,103,80,183,223,218,2,251,241,122,73,18,168,195,217,26,154,4,142,40,2,170,139,201,6,149,160,86,102,86,180})),
ZIndex = 2,
})
_v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v491,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.new(0, 140, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v27 and _v27.Name or (_V9({})),
ZIndex = 2,
})
local _v156, _v155, _v455
_v491.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v156 = true
_v155 = _v230.Position
_v455 = _v268.Position
end
end)
table.insert(_v297, function(_v230)
if _v156 then
local delta = _v230.Position - _v155
_v268.Position = UDim2.new(
_v455.X.Scale,
_v455.X.Offset + delta.X,
_v455.Y.Scale,
_v455.Y.Offset + delta.Y
)
end
end)
table.insert(_v397, function()
_v156 = false
end)
local _v444 = _v316((_V9({78,80,235,144,156})), {
Parent = _v268,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v7.panel,
BorderSizePixel = 0,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v444, CornerRadius = UDim.new(0, 6) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v444, Color = _v7.border, Thickness = 1, Transparency = 0.15 })
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = _v444,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v472 = _v316((_V9({78,80,235,144,156})), {
Parent = _v444,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({93,107,198,148,138,78,246,167,64,103,87,254})), { Parent = _v472, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v507 = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v444,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v7.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v7.danger,
Text = (_V9({93,76,230,146,152,94})),
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v507, CornerRadius = UDim.new(0, 6) })
local _v508 = _v316((_V9({93,107,217,137,139,85,209,163})), {
Parent = _v507,
Color = _v7.danger,
Thickness = 1,
Transparency = 0.55,
})
_v507.MouseButton1Click:Connect(function()
if _v352 then
_v352()
end
end)
_v507.MouseEnter:Connect(function()
_v44:Create(_v507, _v1, {
BackgroundColor3 = _v7.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v44:Create(_v508, _v1, { Transparency = 0 }):Play()
end)
_v507.MouseLeave:Connect(function()
_v44:Create(_v507, _v1, {
BackgroundColor3 = _v7.row,
TextColor3 = _v7.danger,
}):Play()
_v44:Create(_v508, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v316((_V9({78,80,235,144,156})), {
Parent = _v268,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({93,107,218,156,157,94,211,168,94})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v474 = { (_V9({75,77,231,159,152,78})), (_V9({94,75,249,136,152,86})), (_V9({69,77,252,152,148,95,212,178})), (_V9({88,78,235,132,156,72,201})), (_V9({69,75,249,158})), (_V9({91,71,254,137,144,84,221,181})) }
local _v471 = {}
for i, _v473 in ipairs(_v474) do
local _v234 = _v127 == _v473
local _v469 = _v316((_V9({92,71,242,137,187,79,206,178,86,102})), {
Parent = _v472,
LayoutOrder = i,
Size = UDim2.new(1, 0, 1 / #_v474, -6),
BackgroundColor3 = _v7.rowHover,
BackgroundTransparency = _v234 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v234 and _v7.text or _v7.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({40,2,170,221})) .. _v473,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v469, CornerRadius = UDim.new(0, 6) })
local stripe = _v316((_V9({78,80,235,144,156})), {
Parent = _v469,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v7.accent,
BorderSizePixel = 0,
Visible = _v234,
ZIndex = 2,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v470 = _v316((_V9({78,80,235,144,156})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v234,
})
_v471[_v473] = { btn = _v469, frame = _v470, stripe = stripe }
_v469.MouseButton1Click:Connect(function()
_v127 = _v473
for name, _v468 in pairs(_v471) do
local _v53 = name == _v473
_v468.frame.Visible = _v53
_v468.stripe.Visible = _v53
_v44:Create(_v468.btn, _v1, {
BackgroundTransparency = _v53 and 0 or 1,
TextColor3 = _v53 and _v7.text or _v7.textSub,
}):Play()
end
end)
_v469.MouseEnter:Connect(function()
if _v127 ~= _v473 then
_v44:Create(_v469, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v469.MouseLeave:Connect(function()
if _v127 ~= _v473 then
_v44:Create(_v469, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v83(_v471[(_V9({75,77,231,159,152,78}))].frame, _v119)
_v84(_v471[(_V9({94,75,249,136,152,86}))].frame, _v119)
_v89(_v471[(_V9({69,77,252,152,148,95,212,178}))].frame, _v119)
_v90(_v471[(_V9({88,78,235,132,156,72,201}))].frame, _v119)
_v88(_v471[(_V9({69,75,249,158}))].frame, _v119)
_v91(_v471[(_V9({91,71,254,137,144,84,221,181}))].frame, _v119)
_v87(_v119)
_v92(_v119)
_v86(_v119)
_v93(_v119)
if _v119.UI.Visible then
_v440(true)
end
end
function UI:Toggle()
_v440(not _v522)
end
function UI:Show()
_v440(true)
end
function UI:Hide()
_v440(false)
end
function UI:SetCurrentTarget(name)
if not _v477 then
return
end
if _v477.Visible ~= _v476 then
_v477.Visible = _v476
end
if not _v476 or not targetPanelLabel then
return
end
local _v443, colour
if name and name ~= (_V9({})) and name ~= (_V9({70,77,228,152})) then
_v443, colour = name, (_V9({43,26,190,206,188,120,255}))
else
_v443, colour = (_V9({93,76,193,147,150,77,212})), (_V9({43,26,203,202,186,123,138}))
end
local text = (_V9({92,67,248,154,156,78,128,230,5,110,77,228,137,217,89,213,170,86,122,31,168})) .. colour .. (_V9({42,28})) .. _v443 .. (_V9({52,13,236,146,151,78,132}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v187)
if not fpsLabel or not _v189 or not _v189.Visible then
return
end
local text = string.format((_V9({52,68,229,147,141,26,217,169,85,103,80,183,223,218,2,142,245,124,74,103,168,195,220,94,134,233,95,103,76,254,195,217,92,202,181})), _v187 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v227)
if not _v533 then
return
end
local _v147 = tostring(_v227 or (_V9({}))):match((_V9({45,70,161})))
_v533.Image = _v147 and ((_V9({122,64,242,156,138,73,223,178,80,108,24,165,210})) .. _v147) or (_V9({}))
end
function UI:SyncControls()
for _, _v183 in ipairs(_v466) do
_v183()
end
end
function UI:IsCapturingKey()
return _v103
end
function UI:Notify(text, _v162)
if not _v201 then
return
end
_v162 = _v162 or 3
local _v493 = _v316((_V9({92,71,242,137,181,91,216,163,85})), {
Parent = _v201,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 12),
Size = UDim2.fromOffset(math.max(200, #text * 8 + 28), 34),
BackgroundColor3 = _v7.bar,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v7.text,
Text = text,
})
_v316((_V9({93,107,201,146,139,84,223,180})), { Parent = _v493, CornerRadius = UDim.new(0, 8) })
_v316((_V9({93,107,217,137,139,85,209,163})), { Parent = _v493, Color = _v7.accent, Thickness = 1, Transparency = 0.3 })
_v44:Create(_v493, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v162, function()
if _v493 and _v493.Parent then
local _v361 = _v44:Create(_v493, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v361.Completed:Once(function()
if _v493 then
_v493:Destroy()
end
end)
_v361:Play()
end
end)
end
function UI:Cleanup()
_v458()
_v435 = nil
_v447 = nil
_v375 = nil
table.clear(_v376)
for _, _v122 in ipairs(_v505) do
_v122:Disconnect()
end
table.clear(_v505)
table.clear(_v297)
table.clear(_v397)
table.clear(_v466)
_v54 = nil
_v103 = false
_v56 = nil
_v477, targetPanelLabel = nil, nil
_v476 = false
_v247 = nil
_v533 = nil
_v189, fpsLabel = nil, nil
_v538 = nil
if _v201 then
_v201:Destroy()
_v201 = nil
_v268 = nil
end
_v522 = false
end
return UI
end)()
Movement = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v45 = game:GetService((_V9({93,81,239,143,176,84,202,179,77,91,71,248,139,144,89,223})))
local _v49 = game:GetService((_V9({95,77,248,150,138,74,219,165,92})))
local _v27 = _v32.LocalPlayer
local UI = UI
local Movement = {}
local _v5 = 16
local _v24 = 50
local _v303
local _v301
local _v307 = 0
local function _v300()
local _v111 = _v27.Character
local root = _v111 and _v111:FindFirstChild((_V9({64,87,231,156,151,85,211,162,107,103,77,254,173,152,72,206})))
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({64,87,231,156,151,85,211,162})))
if not (_v111 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v111, root, humanoid
end
local function _v302(_v94)
local _v265 = _v94.CFrame.LookVector
local _v179 = Vector3.new(_v265.X, 0, _v265.Z)
if _v179.Magnitude < 0.001 then
_v179 = Vector3.new(0, 0, -1)
else
_v179 = _v179.Unit
end
local right = _v94.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v296 = Vector3.zero
if _v45:IsKeyDown(Enum.KeyCode.W) then
_v296 = _v296 + _v179
end
if _v45:IsKeyDown(Enum.KeyCode.S) then
_v296 = _v296 - _v179
end
if _v45:IsKeyDown(Enum.KeyCode.D) then
_v296 = _v296 + right
end
if _v45:IsKeyDown(Enum.KeyCode.A) then
_v296 = _v296 - right
end
if _v45:IsKeyDown(Enum.KeyCode.Space) then
_v296 = _v296 + Vector3.yAxis
end
if _v45:IsKeyDown(Enum.KeyCode.LeftShift) then
_v296 = _v296 - Vector3.yAxis
end
if _v296.Magnitude > 0 then
return _v296.Unit
end
return nil
end
local _v30 = 0.1
local _v31 = 0.15
local function _v306()
return (os.clock() % (_v30 + _v31)) < _v30
end
function Movement:Update(_v161, _v119)
local _v111, root, humanoid = _v300()
if _v119.NoclipEnabled and _v111 then
for _, _v364 in ipairs(_v111:GetDescendants()) do
if _v364:IsA((_V9({74,67,249,152,169,91,200,178}))) then
_v364.CanCollide = false
end
end
end
if not root then
return
end
if _v119.FlyEnabled then
local _v94 = _v49.CurrentCamera
if _v94 then
local _v521 = Vector3.zero
if not UI:IsCapturingKey() then
local _v148 = _v302(_v94)
if _v148 then
local _v449 = _v119.FlySpeed or 50
if not _v306() then
_v449 = math.min(_v449, _v5)
end
_v521 = _v148 * _v449
end
end
root.AssemblyLinearVelocity = _v521
end
return
end
if _v119.SpeedEnabled then
local _v449 = _v119.Speed or _v5
local _v296 = humanoid.MoveDirection
if _v449 > _v5 and _v296.Magnitude > 0 and _v306() then
local _v521 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v296.X * _v449, _v521.Y, _v296.Z * _v449)
end
end
end
local function _v305(_v119)
if not _v119.InfJumpEnabled then
return
end
local _, root = _v300()
if root then
local _v521 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v521.X, _v24, _v521.Z)
end
end
local _v42 = 10
local _v41 = 0.05
function Movement.TeleportTo(_v379)
local _v143 = _v379 + Vector3.new(0, 3, 0)
_v307 = _v307 + 1
local _v495 = _v307
task.spawn(function()
while _v495 == _v307 do
local _, currentRoot = _v300()
if not currentRoot then
return
end
local _v336 = _v143 - currentRoot.CFrame.Position
if _v336.Magnitude <= _v42 then
currentRoot.CFrame = CFrame.new(_v143)
return
end
currentRoot.CFrame = currentRoot.CFrame + _v336.Unit * _v42
task.wait(_v41)
end
end)
end
local function _v304(_v119, _v230, _v194)
if _v194 or UI:IsCapturingKey() then
return
end
if not _v119.ClickTPEnabled then
return
end
if _v230.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v45:IsKeyDown(_v119.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _v295 = _v27:GetMouse()
if _v295 and _v295.Hit then
Movement.TeleportTo(_v295.Hit.Position)
end
end
function Movement:Init(_v119)
if not _v303 then
_v303 = _v45.JumpRequest:Connect(function()
_v305(_v119)
end)
end
if not _v301 then
_v301 = _v45.InputBegan:Connect(function(_v230, _v194)
_v304(_v119, _v230, _v194)
end)
end
end
function Movement:Cleanup()
if _v303 then
_v303:Disconnect()
_v303 = nil
end
if _v301 then
_v301:Disconnect()
_v301 = nil
end
end
return Movement
end)()
_v14 = (function()
local _v32 = game:GetService((_V9({88,78,235,132,156,72,201})))
local _v37 = game:GetService((_V9({90,87,228,174,156,72,204,175,90,109})))
local _v45 = game:GetService((_V9({93,81,239,143,176,84,202,179,77,91,71,248,139,144,89,223})))
local _v27 = _v32.LocalPlayer
local _v13 = _v13
local _v12 = _v12
local _v10 = _v10
local _v9 = _v9
local _v23 = Hitbox
local SilentAim = SilentAim
local NoRecoil = NoRecoil
local NoSpread = NoSpread
local Triggerbot = Triggerbot
local ESP = ESP
local _v17 = _v17
local Visuals = Visuals
local _v46 = _v46
local UI = UI
local Movement = Movement
local _v48 = _v48
local _v11 = _v11
local _v14 = {}
_v14.Version = (_V9({56}))
_v14.Config = _v13
UI.TeleportTo = Movement.TeleportTo
_v48.Version = _v14.Version
local _v413 = false
local _v123 = {}
local _v62 = false
local _v33 = _v11.RandomName()
local _v199 = {}
local _v21 = 5
local function _v200(name, _v183, ...)
local _v337, res = pcall(_v183, ...)
if _v337 then
local _v453 = _v199[name]
if _v453 then
_v453.failures = 0
end
return true, res
end
local _v453 = _v199[name]
if not _v453 then
_v453 = { failures = 0, lastWarn = -math.huge }
_v199[name] = _v453
end
_v453.failures = _v453.failures + 1
local _v320 = os.clock()
if _v320 - _v453.lastWarn >= _v21 then
_v453.lastWarn = _v320
warn(string.format((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,28,123,2,236,156,144,86,223,162,25,32,90,175,153,208,0,154,227,74})), name, _v453.failures, tostring(res)))
end
return false, nil
end
function _v14.IsRunning()
return _v413
end
function _v14.SaveConfig(name)
return _v12.save(name, _v13)
end
function _v14.LoadConfig(name)
local _v337, res = _v12.load(name, _v13)
if _v337 then
pcall(function()
UI:SyncControls()
end)
end
return _v337, res
end
function _v14.ListConfigs()
return _v12.list()
end
function _v14.DeleteConfig(name)
return _v12.delete(name)
end
function _v14.ServerHop()
return _v46:ServerHop()
end
function _v14.Rejoin()
return _v46:Rejoin()
end
function _v14.SetWatermarkImage(_v227)
_v13.UI.WatermarkImageId = tostring(_v227 or (_V9({})))
UI:SetWatermarkImage(_v13.UI.WatermarkImageId)
return _v14
end
function _v14.SetWebhook(_v514)
return _v48.SetWebhook(_v514)
end
function _v14.HasWebhook()
return _v48.HasWebhook()
end
function _v14.SendWebhook(content, _v358)
return _v48.SendWebhook(content, _v358)
end
function _v14.SendLoadedEmbed(_v236)
return _v48.SendLoadedEmbed(_v236)
end
function _v14.Start()
if _v413 then
return _v14
end
_v413 = true
local _v337, err = pcall(function()
ESP:Init()
UI:Init(_v13, function()
_v14.Stop()
end)
Movement:Init(_v13.Movement)
SilentAim:Init(_v13)
table.insert(_v123, _v32.PlayerAdded:Connect(function(_v373)
_v200((_V9({88,78,235,132,156,72,251,162,93,109,70})), ESP.OnPlayerAdded, ESP, _v373)
end))
table.insert(_v123, _v32.PlayerRemoving:Connect(function(_v373)
_v200((_V9({88,78,235,132,156,72,232,163,84,103,84,227,147,158})), ESP.OnPlayerRemoving, ESP, _v373)
end))
table.insert(_v123, _v45.InputBegan:Connect(function(_v230, _v194)
if _v194 or UI:IsCapturingKey() then
return
end
_v200((_V9({67,71,243,159,144,84,222,181})), function()
local _v244 = _v230.KeyCode
if _v244 == _v13.UI.MenuKey then
UI:Toggle()
elseif _v244 == _v13.UI.UnloadKey then
_v14.Stop()
else
local _v494 = {
{ _v13.Camera, (_V9({77,76,235,159,149,95,222})), _v13.Camera.ToggleKey },
{ _v13.ESP, (_V9({77,76,235,159,149,95,222})), _v13.ESP.ToggleKey },
{ _v13.Camera, (_V9({78,109,220,190,144,72,217,170,92})), _v13.Camera.FOVCircleKey },
{ _v13.NoRecoil, (_V9({77,76,235,159,149,95,222})), _v13.NoRecoil.ToggleKey },
{ _v13.NoSpread, (_V9({77,76,235,159,149,95,222})), _v13.NoSpread.ToggleKey },
{ _v13.Triggerbot, (_V9({77,76,235,159,149,95,222})), _v13.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v494) do
if _v244 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v188, fpsFrames = 0, 0
table.insert(_v123, _v37.RenderStepped:Connect(function(_v161)
_v200((_V9({75,67,228,153,144,94,219,178,92,123})), _v10.Update, _v10, _v13.Camera, _v13.ESP)
_v200((_V9({77,113,218})), ESP.Update, ESP, _v13.ESP)
local _v339, target = true, nil
if not (UI.IsSpectating and UI.IsSpectating()) then
_v339, target = _v200((_V9({73,75,231,159,150,78})), _v9.Update, _v9, _v13.Camera, _v13.Debug)
end
if not _v339 then
target = nil
end
if _v13.UI.TargetDisplay then
_v200((_V9({92,67,248,154,156,78,154,162,80,123,82,230,156,128})), function()
local _v266 = _v9:GetLookTarget(_v13.ESP, _v13.Camera)
UI:SetCurrentTarget(_v266 and _v266.Name or nil)
end)
end
_v62 = _v13.Camera.Enabled and target ~= nil
_v200((_V9({70,77,217,141,139,95,219,162})), NoSpread.Update, NoSpread, _v13.NoSpread)
_v200((_V9({91,75,230,152,151,78,154,135,80,101})), SilentAim.Update, SilentAim, _v13)
_v200((_V9({92,80,227,154,158,95,200,164,86,124})), Triggerbot.Update, Triggerbot, _v13.Triggerbot, _v13.Camera)
_v200((_V9({69,77,252,152,148,95,212,178})), Movement.Update, Movement, _v161, _v13.Movement)
_v200((_V9({64,75,254,159,150,66})), _v23.Update, _v23, _v13.Hitbox, _v13.Camera)
_v200((_V9({76,80,235,138,144,84,221,230,124,91,114})), _v17.Update, _v17, _v13.Drawing, _v13.Camera)
_v200((_V9({94,75,249,136,152,86,201})), Visuals.Update, Visuals, _v13.Visuals)
_v188 = _v188 + _v161
fpsFrames = fpsFrames + 1
if _v188 >= 0.25 then
local _v187 = math.floor(fpsFrames / _v188 + 0.5)
_v188, fpsFrames = 0, 0
if _v13.UI.FPSCounter then
_v200((_V9({78,114,217,221,154,85,207,168,77,109,80})), UI.UpdateFPS, UI, _v187)
end
end
end))
pcall(function()
_v37:UnbindFromRenderStep(_v33)
end)
pcall(function()
_v37:BindToRenderStep(_v33, Enum.RenderPriority.Camera.Value + 1, function()
_v200((_V9({70,77,216,152,154,85,211,170})), NoRecoil.Update, NoRecoil, _v13.NoRecoil, _v62)
end)
end)
end)
if not _v337 then
warn((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,127,105,75,230,152,157,26,206,169,25,123,86,235,143,141,0})), err)
_v14.Stop()
return _v14
end
if not _v11.HideGlobal((_V9({94,67,228,148,141,67,253,163,87,109,80,235,145})), _v14) and getgenv then
getgenv().VanityGeneral = _v14
end
UI:Notify(string.format((_V9({94,67,228,148,141,67,151,129,92,102,71,248,156,149,26,214,169,88,108,71,238,221,217,216,58,100,25,40,114,248,152,138,73,154,227,74})), _v13.UI.MenuKey.Name), 4)
print(string.format((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,107,125,76,228,148,151,93,154,238,79,45,81,163})), _v14.Version))
print(string.format((_V9({69,71,228,136,195,26,159,181,25,40,94,170,221,186,91,215,163,75,105,24,170,216,138,26,154,186,25,40,119,228,145,150,91,222,252,25,45,81})),
_v13.UI.MenuKey.Name,
_v13.Camera.ToggleKey.Name,
_v13.UI.UnloadKey.Name))
if _v48.HasWebhook() then
task.spawn(function()
_v48.SendLoadedEmbed(false)
end)
end
return _v14
end
function _v14.Stop()
if not _v413 then
return _v14
end
_v413 = false
for _, _v122 in ipairs(_v123) do
pcall(function()
_v122:Disconnect()
end)
end
table.clear(_v123)
pcall(function()
_v37:UnbindFromRenderStep(_v33)
end)
_v62 = false
pcall(function()
ESP:Cleanup()
end)
pcall(function()
UI:Cleanup()
end)
pcall(function()
_v9:Cleanup()
end)
pcall(function()
Movement:Cleanup()
end)
pcall(function()
_v23:Cleanup()
end)
pcall(function()
_v17:Cleanup()
end)
pcall(function()
Visuals:Cleanup()
end)
pcall(function()
NoSpread:Cleanup()
end)
NoRecoil:Reset()
table.clear(_v199)
print((_V9({83,116,235,147,144,78,195,235,126,109,76,239,143,152,86,231,230,106,124,77,250,141,156,94})))
return _v14
end
function _v14.Toggle()
if _v413 then
_v14.Stop()
else
_v14.Start()
end
return _v14
end
_v14.start = _v14.Start
_v14.stop = _v14.Stop
_v14.toggle = _v14.Toggle
return _v14
end)()
do
local _v14 = _v14
if getgenv then
local _v382 = getgenv().VanityGeneral
if _v382 and _v382 ~= _v14 and type(_v382.Stop) == (_V9({110,87,228,158,141,83,213,168})) then
pcall(_v382.Stop)
end
end
pcall(function()
_v14.Start()
end)
return _v14
end
