local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({211,186,254,6,224,5,251,66,42})
local _v10
local _v12
local _v11
local _v45
local _v9
local _v8
local ESP
local _v16
local Visuals
local _v47
local Triggerbot
local SilentAim
local Hitbox
local NoRecoil
local NoSpread
local UI
local Movement
local _v13
_v10 = (function()
local _v10 = {}
pcall(function() math.randomseed(os.time()) end)
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local _v390 = setmetatable({}, { __mode = (_V9({184})) })
local _v391 = 0
local _v392 = false
local _v213 = {}
local _v27 = (_V9({178,216,157,98,133,99,156,42,67,185,209,146,107,142,106,139,51,88,160,206,139,112,151,125,130,56,107,145,249,186,67,166,66,179,11,96,152,246,179,72,175,85,170,16,121,135,239,168,81,184,92,161}))
function _v10.RandomName(_v257)
_v257 = _v257 or 14
local _v366 = {}
for i = 1, _v257 do
local n = math.random(1, #_v27)
_v366[i] = string.sub(_v27, n, n)
end
return table.concat(_v366)
end
function _v10.CClosure(_v182)
if type(newcclosure) == (_V9({181,207,144,101,148,108,148,44})) then
local _v338, wrapped = pcall(newcclosure, _v182)
if _v338 and type(wrapped) == (_V9({181,207,144,101,148,108,148,44})) then
return wrapped
end
end
return _v182
end
local function _v175(_v232)
local _v338, exposed = pcall(function()
if _v232:IsDescendantOf(_v48) then
return true
end
local _v379 = _v26 and _v26:FindFirstChild((_V9({131,214,159,127,133,119,188,55,67})))
return _v379 ~= nil and _v232:IsDescendantOf(_v379)
end)
return _v338 and exposed == true
end
function _v10.Protect(_v232)
if not _v390[_v232] then
_v390[_v232] = true
_v391 = _v391 + 1
end
if not _v392 then
_v392 = true
local exposed = _v175(_v232)
_v392 = false
if exposed then
_v10.Install()
end
end
return _v232
end
local function _v238(_v232)
local _v320 = _v232
while _v320 and _v320 ~= game do
if _v390[_v320] then
return true
end
_v320 = _v320.Parent
end
return false
end
function _v10.HideGlobal(name, value)
_v213[name] = value
if type(getgenv) ~= (_V9({181,207,144,101,148,108,148,44})) then
return false
end
local _v338, env = pcall(getgenv)
if not _v338 or type(env) ~= (_V9({167,219,156,106,133})) then
return false
end
pcall(function()
if rawget(env, name) ~= nil then
rawset(env, name, nil)
end
end)
local _v339 = pcall(function()
local _v298 = getmetatable(env)
local _v349 = _v298 and rawget(_v298, (_V9({140,229,151,104,132,96,131})))
local _v317 = {}
if _v298 then
for k, v in pairs(_v298) do
_v317[k] = v
end
end
_v317.__index = function(_, _v244)
local hidden = _v213[_v244]
if hidden ~= nil then
return hidden
end
if type(_v349) == (_V9({181,207,144,101,148,108,148,44})) then
return _v349(env, _v244)
elseif type(_v349) == (_V9({167,219,156,106,133})) then
return _v349[_v244]
end
return nil
end
setmetatable(env, _v317)
end)
return _v339
end
local _v233 = false
local _v18 = {
GetChildren = true,
GetDescendants = true,
FindFirstChild = true,
FindFirstChildOfClass = true,
FindFirstChildWhichIsA = true,
}
function _v10.Install()
if _v233 then
return
end
if type(hookmetamethod) ~= (_V9({181,207,144,101,148,108,148,44})) or type(getnamecallmethod) ~= (_V9({181,207,144,101,148,108,148,44})) then
return
end
if type(checkcaller) ~= (_V9({181,207,144,101,148,108,148,44})) then
return
end
local _v350
local _v228 = false
local _v338 = pcall(function()
_v350 = hookmetamethod(game, (_V9({140,229,144,103,141,96,152,35,70,191})), _v10.CClosure(function(self, ...)
local _v288 = getnamecallmethod()
if not _v228 and _v391 > 0 and _v288 and _v18[_v288] and not checkcaller() then
_v228 = true
local _v413 = table.pack(pcall(_v350, self, ...))
_v228 = false
if not _v413[1] then
error(_v413[2], 0)
end
local res = _v413[2]
if _v288 == (_V9({148,223,138,69,136,108,151,38,88,182,212})) or _v288 == (_V9({148,223,138,66,133,118,152,39,68,183,219,144,114,147})) then
local _v243 = {}
for i = 1, #res do
if not _v238(res[i]) then
_v243[#_v243 + 1] = res[i]
end
end
return _v243
end
if typeof(res) == (_V9({154,212,141,114,129,107,152,39})) and _v238(res) then
return nil
end
return res
end
return _v350(self, ...)
end))
end)
_v233 = _v338
end
return _v10
end)()
_v12 = (function()
local _v12 = {}
_v12.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({129,219,144,98,143,104,219,106,125,182,211,153,110,148,96,159,107})),
HitboxOptions = { (_V9({129,219,144,98,143,104,219,106,125,182,211,153,110,148,96,159,107})), (_V9({155,223,159,98})), (_V9({135,213,140,117,143})), (_V9({146,200,147,117})), (_V9({159,223,153,117})) },
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
_v12.NoRecoil = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
AllowAim = false,
ToggleKey = Enum.KeyCode.F2,
}
_v12.NoSpread = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
ToggleKey = Enum.KeyCode.F3,
}
_v12.Triggerbot = {
Enabled = false,
MinDelay = 0.1,
MaxDelay = 0.25,
MaxDistance = 1000,
WallCheck = true,
ToggleKey = Enum.KeyCode.F4,
}
_v12.Movement = {
FlyEnabled = false,
FlySpeed = 50,
NoclipEnabled = false,
SpeedEnabled = false,
Speed = 16,
InfJumpEnabled = false,
ClickTPEnabled = false,
ClickTPKey = Enum.KeyCode.LeftControl,
}
_v12.SilentAim = {
Enabled = false,
MaxAngle = 30,
HitChance = 100,
}
_v12.Hitbox = {
Enabled = false,
Size = 5,
Transparency = 0.5,
}
_v12.Drawing = {
Boxes = false,
Tracers = false,
BoxColor = Color3.fromRGB(165, 75, 255),
TracerColor = Color3.fromRGB(255, 255, 255),
}
_v12.Visuals = {
Fullbright = false,
NoFog = false,
}
_v12.ESP = {
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
_v12.UI = {
Scale = 1,
MenuKey = Enum.KeyCode.RightShift,
UnloadKey = Enum.KeyCode.End,
Visible = false,
Accent = Color3.fromRGB(132, 62, 190),
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
WatermarkImageId = (_V9({226,137,199,62,212,48,205,123,25,235,143,198,62,213,51})),
}
_v12.Webhook = {
Url = (_V9({})),
}
_v12.Debug = false
local _v14 = {
Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({129,219,144,98,143,104,219,106,125,182,211,153,110,148,96,159,107})),
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
function _v12.reset()
for _v438, _v527 in pairs(_v14) do
for _v244, value in pairs(_v527) do
if type(value) == (_V9({167,219,156,106,133})) then
local target = _v12[_v438][_v244]
if type(target) ~= (_V9({167,219,156,106,133})) then
target = {}
_v12[_v438][_v244] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v12[_v438][_v244] = value
end
end
end
end
return _v12
end)()
_v11 = (function()
local _v11 = {}
local _v7 = (_V9({133,219,144,111,148,124,188,39,68,182,200,159,106}))
local _v37 = { (_V9({144,219,147,99,146,100})), (_V9({150,233,174})), (_V9({157,213,172,99,131,106,146,46})), (_V9({157,213,173,118,146,96,154,38})), (_V9({158,213,136,99,141,96,149,54})), (_V9({128,211,146,99,142,113,186,43,71})), (_V9({155,211,138,100,143,125})), (_V9({151,200,159,113,137,107,156})), (_V9({133,211,141,115,129,105,136})), (_V9({134,243})) }
local function _v191()
return type(writefile) == (_V9({181,207,144,101,148,108,148,44}))
and type(readfile) == (_V9({181,207,144,101,148,108,148,44}))
and type(listfiles) == (_V9({181,207,144,101,148,108,148,44}))
end
local function _v165()
if type(isfolder) == (_V9({181,207,144,101,148,108,148,44})) and type(makefolder) == (_V9({181,207,144,101,148,108,148,44})) then
if not isfolder(_v7) then
pcall(makefolder, _v7)
end
end
end
local function _v433(name)
return (tostring(name or (_V9({}))):gsub((_V9({136,228,219,113,191,32,214,98,119})), (_V9({}))):gsub((_V9({141,159,141,45})), (_V9({}))):gsub((_V9({246,201,213,34})), (_V9({}))))
end
local function _v370(name)
return _v7 .. (_V9({252,202,140,105,134,108,151,39,117})) .. game.PlaceId .. (_V9({140})) .. name .. (_V9({253,208,141,105,142}))
end
local function _v256(name)
return _v7 .. (_V9({252})) .. name .. (_V9({253,208,141,105,142}))
end
local function _v164(v)
local t = typeof(v)
if t == (_V9({144,213,146,105,146,54})) then
return { __t = (_V9({144,213,146,105,146,54})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({150,212,139,107,169,113,158,47})) then
return { __t = (_V9({150,212,139,107})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({167,219,156,106,133})) then
local _v366 = {}
for k, _v524 in pairs(v) do
if type(_v524) ~= (_V9({181,207,144,101,148,108,148,44})) then
local _v163 = _v164(_v524)
if _v163 ~= nil then
_v366[k] = _v163
end
end
end
return _v366
elseif t == (_V9({189,207,147,100,133,119})) or t == (_V9({160,206,140,111,142,98})) or t == (_V9({177,213,145,106,133,100,149})) then
return v
end
return nil
end
local function _v137(v)
if type(v) ~= (_V9({167,219,156,106,133})) then
return v
end
if v.__t == (_V9({144,213,146,105,146,54})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({150,212,139,107})) then
local _v338, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v338 then
return item
end
return nil
end
return v
end
local function _v68(target, _v460)
for k, v in pairs(_v460) do
if type(v) == (_V9({167,219,156,106,133})) and v.__t == nil then
if type(target[k]) == (_V9({167,219,156,106,133})) then
_v68(target[k], v)
end
else
local _v138 = _v137(v)
if _v138 ~= nil then
target[k] = _v138
end
end
end
end
function _v11.isSupported()
return _v191()
end
function _v11.list()
local _v366 = {}
if not _v191() then
return _v366
end
_v165()
local _v338, files = pcall(listfiles, _v7)
if not _v338 or type(files) ~= (_V9({167,219,156,106,133})) then
return _v366
end
for _, _v369 in ipairs(files) do
local _v385 = (_V9({163,200,145,96,137,105,158,29})) .. game.PlaceId .. (_V9({140}))
local name = tostring(_v369):match((_V9({251,225,160,41,188,88,208,107,15,253,208,141,105,142,33})))
if name and name:sub(1, #_v385) == _v385 then
table.insert(_v366, name:sub(#_v385 + 1))
end
end
table.sort(_v366)
return _v366
end
function _v11.save(name, _v118)
if not _v191() then
return false, (_V9({135,210,151,117,192,96,131,39,73,166,206,145,116,192,109,154,49,10,189,213,222,96,137,105,158,98,107,131,243}))
end
name = _v433(name)
if name == (_V9({})) then
return false, (_V9({150,212,138,99,146,37,154,98,73,188,212,152,111,135,37,149,35,71,182}))
end
_v165()
local data = {}
for _, _v438 in ipairs(_v37) do
if type(_v118[_v438]) == (_V9({167,219,156,106,133})) then
data[_v438] = _v164(_v118[_v438])
end
end
local _v342, json = pcall(function()
return game:GetService((_V9({155,206,138,118,179,96,137,52,67,176,223}))):JSONEncode(data)
end)
if not _v342 then
return false, (_V9({150,212,157,105,132,96,219,36,75,186,214,155,98,218,37})) .. tostring(json)
end
local _v347, err = pcall(writefile, _v370(name), json)
if not _v347 then
return false, (_V9({132,200,151,114,133,37,157,35,67,191,223,154,60,192})) .. tostring(err)
end
return true, name
end
function _v11.load(name, _v118)
if not _v191() then
return false, (_V9({135,210,151,117,192,96,131,39,73,166,206,145,116,192,109,154,49,10,189,213,222,96,137,105,158,98,107,131,243}))
end
name = _v433(name)
if name == (_V9({})) then
return false, (_V9({150,212,138,99,146,37,154,98,73,188,212,152,111,135,37,149,35,71,182}))
end
local _v369 = _v370(name)
if type(isfile) == (_V9({181,207,144,101,148,108,148,44})) then
local _v341, exists = pcall(isfile, _v369)
if _v341 and not exists then
local _v255 = _v256(name)
local _v343, legacyExists = pcall(isfile, _v255)
if _v343 and legacyExists then
_v369 = _v255
else
return false, (_V9({157,213,222,101,143,107,157,43,77,243,212,159,107,133,97,219,101})) .. name .. (_V9({244}))
end
end
end
local _v346, raw = pcall(readfile, _v369)
if not _v346 or type(raw) ~= (_V9({160,206,140,111,142,98})) then
return false, (_V9({129,223,159,98,192,99,154,43,70,182,222}))
end
local _v342, data = pcall(function()
return game:GetService((_V9({155,206,138,118,179,96,137,52,67,176,223}))):JSONDecode(raw)
end)
if not _v342 or type(data) ~= (_V9({167,219,156,106,133})) then
return false, (_V9({135,210,159,114,192,99,146,46,79,243,211,141,104,199,113,219,52,75,191,211,154,38,170,86,180,12}))
end
for _, _v438 in ipairs(_v37) do
if type(data[_v438]) == (_V9({167,219,156,106,133})) and type(_v118[_v438]) == (_V9({167,219,156,106,133})) then
_v68(_v118[_v438], data[_v438])
end
end
return true, name
end
function _v11.delete(name)
name = _v433(name)
if name == (_V9({})) then
return false, (_V9({150,212,138,99,146,37,154,98,73,188,212,152,111,135,37,149,35,71,182}))
end
if type(delfile) ~= (_V9({181,207,144,101,148,108,148,44})) then
return false, (_V9({135,210,151,117,192,96,131,39,73,166,206,145,116,192,102,154,44,13,167,154,154,99,140,96,143,39,10,181,211,146,99,147}))
end
local _v338, err = pcall(delfile, _v370(name))
if not _v338 then
return false, tostring(err)
end
return true, name
end
return _v11
end)()
_v45 = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v42 = game:GetService((_V9({135,223,146,99,144,106,137,54,121,182,200,136,111,131,96})))
local _v26 = _v31.LocalPlayer
local _v45 = {}
function _v45:ServerHop()
local _v338, err = pcall(function()
_v42:Teleport(game.PlaceId, _v26)
end)
if not _v338 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,121,182,200,136,99,146,37,147,45,90,243,220,159,111,140,96,159,120})), err)
end
return _v338
end
function _v45:Rejoin()
local _v338, err = pcall(function()
_v42:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v26)
end)
if not _v338 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,120,182,208,145,111,142,37,157,35,67,191,223,154,60})), err)
end
return _v338
end
function _v45.getGuiParent()
local _v338, hidden = pcall(function()
return gethui and gethui()
end)
if _v338 and hidden then
return hidden
end
local _v339, coreGui = pcall(function()
return game:GetService((_V9({144,213,140,99,167,112,146})))
end)
if _v339 and coreGui then
return coreGui
end
return _v26:WaitForChild((_V9({131,214,159,127,133,119,188,55,67})))
end
return _v45
end)()
_v9 = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local _v9 = {}
_v9.LocalRootPos = nil
local frame = {}
local _v77 = {}
local _v79 = {}
local function _v354(_v140)
if not _v140:IsA((_V9({158,213,154,99,140}))) then
return
end
task.defer(function()
if _v140.Parent
and _v140:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
and not _v31:GetPlayerFromCharacter(_v140)
then
if not _v79[_v140] then
_v79[_v140] = true
table.insert(_v77, _v140)
end
end
end)
end
local function _v355(_v140)
if _v79[_v140] then
_v79[_v140] = nil
for i = #_v77, 1, -1 do
if _v77[i] == _v140 then
table.remove(_v77, i)
break
end
end
end
end
local _v78 = false
function _v9.GetBotCharacters()
if not _v78 then
_v78 = true
for _, _v140 in ipairs(_v48:GetDescendants()) do
_v354(_v140)
end
_v48.DescendantAdded:Connect(_v354)
_v48.DescendantRemoving:Connect(_v355)
end
return _v77
end
local function _v419(_v110, humanoid)
return humanoid.RootPart
or _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
or _v110:FindFirstChild((_V9({135,213,140,117,143})))
or _v110:FindFirstChild((_V9({134,202,142,99,146,81,148,48,89,188})))
or _v110.PrimaryPart
end
local _v34 = {
Head = { (_V9({155,223,159,98})) },
Torso = { (_V9({134,202,142,99,146,81,148,48,89,188})), (_V9({159,213,137,99,146,81,148,48,89,188})), (_V9({135,213,140,117,143})), (_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})) },
Arms = {
(_V9({159,223,152,114,168,100,149,38})), (_V9({129,211,153,110,148,77,154,44,78})),
(_V9({159,223,152,114,172,106,140,39,88,146,200,147})), (_V9({129,211,153,110,148,73,148,53,79,161,251,140,107})),
(_V9({159,223,152,114,181,117,139,39,88,146,200,147})), (_V9({129,211,153,110,148,80,139,50,79,161,251,140,107})),
(_V9({159,223,152,114,192,68,137,47})), (_V9({129,211,153,110,148,37,186,48,71})),
},
Legs = {
(_V9({159,223,152,114,166,106,148,54})), (_V9({129,211,153,110,148,67,148,45,94})),
(_V9({159,223,152,114,172,106,140,39,88,159,223,153})), (_V9({129,211,153,110,148,73,148,53,79,161,246,155,97})),
(_V9({159,223,152,114,181,117,139,39,88,159,223,153})), (_V9({129,211,153,110,148,80,139,50,79,161,246,155,97})),
(_V9({159,223,152,114,192,73,158,37})), (_V9({129,211,153,110,148,37,183,39,77})),
},
}
local _v33 = { (_V9({155,223,159,98})), (_V9({135,213,140,117,143})), (_V9({146,200,147,117})), (_V9({159,223,153,117})) }
local function _v374(_v110, _v402)
local _v313 = _v34[_v402]
if not _v313 then
return nil
end
for _, name in ipairs(_v313) do
local part = _v110:FindFirstChild(name)
if part and part:IsA((_V9({145,219,141,99,176,100,137,54}))) then
return part
end
end
return nil
end
local function _v373(_v110)
for _, _v402 in ipairs(_v33) do
local part = _v374(_v110, _v402)
if part then
return part
end
end
for _, _v140 in ipairs(_v110:GetDescendants()) do
if _v140:IsA((_V9({145,219,141,99,176,100,137,54}))) then
return _v140
end
end
return nil
end
local function _v64(_v110, _v206, hrp)
return _v206
or hrp
or _v110:FindFirstChild((_V9({134,202,142,99,146,81,148,48,89,188})))
or _v110:FindFirstChild((_V9({135,213,140,117,143})))
or _v373(_v110)
end
local function _v84(_v110, _v378, _v93, _v94)
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v206 = _v110:FindFirstChild((_V9({155,223,159,98})))
local hrp = _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
local _v418 = _v419(_v110, humanoid)
local _v63 = _v64(_v110, _v206, hrp)
local _v168 = {
Player = _v378,
Character = _v110,
Humanoid = humanoid,
Head = _v206,
RootPart = _v418,
HRP = hrp,
Anchor = _v63,
}
if _v63 then
_v168.WorldDistance = (_v63.Position - _v94).Magnitude
local _v470, vis = _v93:WorldToViewportPoint(_v63.Position)
_v168.AnchorScreen = _v470
_v168.AnchorOnScreen = vis
end
if _v418 then
local _v506 = _v206 and (_v206.Position + Vector3.new(0, _v206.Size.Y, 0))
or (_v418.Position + Vector3.new(0, 3, 0))
local _v511, tvis = _v93:WorldToViewportPoint(_v506)
_v168.TopScreen = _v511
_v168.TopOnScreen = tvis
_v168.BotScreen = _v93:WorldToViewportPoint(_v418.Position - Vector3.new(0, 3.2, 0))
end
return _v168
end
function _v9:Update(_v96, _v170)
table.clear(frame)
local _v93 = _v48.CurrentCamera
local _v308 = _v26.Character
local _v309 = _v308 and _v308:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
_v9.LocalRootPos = _v309 and _v309.Position or nil
if not _v93 then
return
end
local _v94 = _v93.CFrame.Position
for _, _v378 in ipairs(_v31:GetPlayers()) do
if _v378 ~= _v26 then
local _v168 = _v84(_v378.Character, _v378, _v93, _v94)
if _v168 then
table.insert(frame, _v168)
end
end
end
if _v96 and _v96.TargetBots then
for _, _v110 in ipairs(_v9.GetBotCharacters()) do
local _v168 = _v84(_v110, nil, _v93, _v94)
if _v168 then
table.insert(frame, _v168)
end
end
end
end
function _v9:Get()
return frame
end
_v9.REGION_PARTS = _v34
_v9.REGION_ORDER = _v33
_v9.pickPartFromRegion = _v374
_v9.pickAnyPart = _v373
return _v9
end)()
_v8 = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local _v45 = _v45
local _v9 = _v9
local _v10 = _v10
local _v8 = {}
local Camera = _v48.CurrentCamera
local _v34 = _v9.REGION_PARTS
local _v33 = _v9.REGION_ORDER
local _v374 = _v9.pickPartFromRegion
local _v373 = _v9.pickAnyPart
local function _v417(_v544)
local _v507 = 0
for _, _v402 in ipairs(_v9.REGION_ORDER) do
_v507 = _v507 + math.max(0, (_v544 and _v544[_v402]) or 0)
end
if _v507 <= 0 then
return (_V9({155,223,159,98}))
end
local _v416 = rng:NextNumber() * _v507
local _v49 = 0
for _, _v402 in ipairs(_v9.REGION_ORDER) do
_v49 = _v49 + math.max(0, _v544[_v402] or 0)
if _v416 <= _v49 then
return _v402
end
end
return (_V9({155,223,159,98}))
end
local function _v242(_v384, _v110)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
local _v412 = _v48:Raycast(Camera.CFrame.Position, _v384 - Camera.CFrame.Position, params)
return not _v412 or _v412.Instance:IsDescendantOf(_v110)
end
local _v19 = Color3.fromRGB(132, 62, 190)
local _v184, _v185, fovStroke
local function _v166()
if _v185 and _v185.Parent then
return _v185
end
_v184 = Instance.new((_V9({128,217,140,99,133,107,188,55,67})))
_v184.Name = _v10.RandomName()
_v184.ResetOnSpawn = false
_v184.IgnoreGuiInset = true
_v184.DisplayOrder = 998
local _v338 = pcall(function()
_v184.Parent = _v45.getGuiParent()
end)
if not _v338 or not _v184.Parent then
_v184.Parent = _v26:WaitForChild((_V9({131,214,159,127,133,119,188,55,67})))
end
_v10.Protect(_v184)
_v185 = Instance.new((_V9({149,200,159,107,133})))
_v185.Name = (_V9({129,211,144,97}))
_v185.AnchorPoint = Vector2.new(0.5, 0.5)
_v185.Position = UDim2.fromScale(0.5, 0.5)
_v185.BackgroundTransparency = 1
_v185.BorderSizePixel = 0
_v185.Parent = _v184
local _v124 = Instance.new((_V9({134,243,189,105,146,107,158,48})))
_v124.CornerRadius = UDim.new(1, 0)
_v124.Parent = _v185
fovStroke = Instance.new((_V9({134,243,173,114,146,106,144,39})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v19
fovStroke.Parent = _v185
return _v185
end
local function _v518(_v118)
local _v449 = _v118.FOVCircle
if not _v449 then
if _v185 then
_v185.Visible = false
end
return
end
local _v415 = _v166()
if not _v415 then
return
end
local _v145 = math.max(0, _v118.FOV or 0) * 2
_v415.Size = UDim2.fromOffset(_v145, _v145)
_v415.Visible = true
end
local function _v144()
if _v184 then
pcall(function()
_v184:Destroy()
end)
end
_v184, _v185, fovStroke = nil, nil, nil
end
local function _v437(_v98)
if not _v98.AnchorOnScreen or _v98.AnchorScreen.Z < 0 then
return math.huge
end
local _v436 = Vector2.new(_v98.AnchorScreen.X, _v98.AnchorScreen.Y)
local _v105 = Camera.ViewportSize / 2
return (_v436 - _v105).Magnitude
end
local function _v172(_v98, _v118)
local _v378 = _v98.Player
if _v118.TeamCheck and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team then
return nil
end
local _v63 = _v98.Anchor
if not _v63 then
return nil
end
local _v150 = _v437(_v98)
if _v150 >= (_v118.FOV or 200) then
return nil
end
if (_v98.WorldDistance or math.huge) > _v118.MaxDistance then
return nil
end
if _v118.WallCheck and not _v242(_v63.Position, _v98.Character) then
return nil
end
return { Player = _v378, Character = _v98.Character, Anchor = _v63, ScreenDistance = _v150 }
end
function _v8:FindBestTarget(_v118)
local _v74
local _v75 = math.huge
for _, _v98 in ipairs(_v9:Get()) do
local _v99 = _v172(_v98, _v118)
if _v99 and _v99.ScreenDistance < _v75 then
_v75 = _v99.ScreenDistance
_v74 = _v99
end
end
return _v74
end
local _v24 = 50
function _v8:GetLookTarget(_v170, _v96)
local _v74
local _v75 = _v24
local _v310 = _v9.LocalRootPos
local _v287 = (_v170 and _v170.MaxDistance) or math.huge
local _v498 = _v96 and _v96.TeamCheck
for _, _v98 in ipairs(_v9:Get()) do
local _v378 = _v98.Player
if not (_v498 and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team) then
local _v63 = _v98.Anchor
if _v63 and not (_v310 and (_v63.Position - _v310).Magnitude > _v287) then
local _v150 = _v437(_v98)
if _v150 <= _v75 then
_v75 = _v150
_v74 = _v378 or _v98.Character
end
end
end
end
return _v74
end
function _v8:_resolveRegion(_v110, _v118)
local _v293 = _v118.Hitbox
if _v293 and _v293 ~= (_V9({129,219,144,98,143,104,219,106,125,182,211,153,110,148,96,159,107})) and _v9.REGION_PARTS[_v293] then
return _v293
end
if self._lockedChar ~= _v110 then
self._lockedChar = _v110
self._rolledRegion = _v417(_v118.TargetWeights)
end
return self._rolledRegion or (_V9({155,223,159,98}))
end
function _v8:PointCamera(_v487, _v454)
local _v141 = CFrame.lookAt(Camera.CFrame.Position, _v487)
local _v62 = math.clamp(1 - (_v454 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v141, _v62)
end
function _v8:Update(_v118, debug)
Camera = _v48.CurrentCamera
_v518(_v118)
if not _v118.Enabled then
self._lockedChar = nil
self._currentTarget = nil
return
end
if not Camera then
return
end
local target = self:FindBestTarget(_v118)
if not target then
self._lockedChar = nil
self._currentTarget = nil
return
end
local _v402 = self:_resolveRegion(target.Character, _v118)
local _v58 = _v9.pickPartFromRegion(target.Character, _v402) or _v9.pickAnyPart(target.Character)
if not _v58 then
self._currentTarget = nil
return
end
if not _v58:IsDescendantOf(_v48) then
self._currentTarget = nil
return
end
self:PointCamera(_v58.Position, _v118.Smoothness)
target.Part = _v58
target.Region = _v402
self._currentTarget = target
if debug then
print((_V9({135,200,159,101,139,108,149,37,16})), target.Character.Name, (_V9({129,223,153,111,143,107,193})), _v402, (_V9({151,211,141,114,129,107,152,39,16})), math.floor(target.ScreenDistance))
end
return target
end
function _v8:GetCurrentTarget()
return self._currentTarget
end
function _v8:Cleanup()
self._lockedChar = nil
self._currentTarget = nil
_v144()
end
_v8.GetBotCharacters = _v9.GetBotCharacters
return _v8
end)()
ESP = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v45 = _v45
local _v9 = _v9
local _v10 = _v10
local ESP = {}
local _v167 = {}
local _v123
local _v81
local _v15 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v316(_v114, _v389)
local _v232 = Instance.new(_v114)
for k, v in pairs(_v389) do
_v232[k] = v
end
return _v232
end
local function _v235(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v171(_v110)
local _v225 = _v110:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
return (_v225 and _v225.RootPart)
or _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
or _v110:FindFirstChild((_V9({135,213,140,117,143})))
or _v110:FindFirstChild((_V9({134,202,142,99,146,81,148,48,89,188})))
or _v110.PrimaryPart
end
local function _v194()
if _v81 and _v81.Parent then
return _v81
end
_v81 = Instance.new((_V9({128,217,140,99,133,107,188,55,67})))
_v81.Name = _v10.RandomName()
_v81.ResetOnSpawn = false
_v81.IgnoreGuiInset = true
_v81.DisplayOrder = 996
local _v338 = pcall(function()
_v81.Parent = _v45.getGuiParent()
end)
if not _v338 or not _v81.Parent then
_v81.Parent = _v26:WaitForChild((_V9({131,214,159,127,133,119,188,55,67})))
end
_v10.Protect(_v81)
return _v81
end
local function _v517(_v168, _v110, _v118, _v98)
local _v93 = _v48.CurrentCamera
local root = _v98 and _v98.RootPart or _v171(_v110)
if not _v93 or not root or not _v168.box then
if _v168.box then
_v168.box.Visible = false
end
return
end
local _v505, onScreen, botV
if _v98 then
if not _v98.TopScreen then
_v168.box.Visible = false
return
end
_v505, onScreen, botV = _v98.TopScreen, _v98.TopOnScreen, _v98.BotScreen
else
local _v206 = _v110:FindFirstChild((_V9({155,223,159,98})))
local _v506 = _v206 and (_v206.Position + Vector3.new(0, _v206.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v80 = root.Position - Vector3.new(0, 3.2, 0)
_v505, onScreen = _v93:WorldToViewportPoint(_v506)
botV = _v93:WorldToViewportPoint(_v80)
end
if not onScreen or _v505.Z <= 0 then
_v168.box.Visible = false
return
end
local _v210 = math.abs(botV.Y - _v505.Y)
local _v545 = _v210 * 0.62
local _v127 = (_v505.X + botV.X) * 0.5
local _v128 = (_v505.Y + botV.Y) * 0.5
_v168.box.Size = UDim2.fromOffset(_v545, _v210)
_v168.box.Position = UDim2.fromOffset(_v127 - _v545 * 0.5, _v128 - _v210 * 0.5)
_v168.box.BackgroundColor3 = _v118.FillColor
_v168.box.BackgroundTransparency = _v118.Filled and (1 - _v118.FillOpacity) or 1
_v168.boxStroke.Color = _v118.OutlineColor
_v168.boxStroke.Transparency = 1 - _v118.OutlineOpacity
_v168.box.Visible = true
end
local function _v277(_v168, name, _v206, _v118)
local _v483 = Instance.new((_V9({145,211,146,106,130,106,154,48,78,148,207,151})))
_v483.Name = _v10.RandomName()
_v483.Size = UDim2.fromOffset(200, 46)
_v483.StudsOffset = Vector3.new(0, 2.7, 0)
_v483.AlwaysOnTop = true
_v483.Adornee = _v206
_v483.Parent = _v206
_v10.Protect(_v483)
local _v218 = Instance.new((_V9({149,200,159,107,133})))
_v218.BackgroundTransparency = 1
_v218.Size = UDim2.fromScale(1, 1)
_v218.Parent = _v483
local _v252 = Instance.new((_V9({134,243,178,111,147,113,183,35,83,188,207,138})))
_v252.SortOrder = Enum.SortOrder.LayoutOrder
_v252.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v252.VerticalAlignment = Enum.VerticalAlignment.Center
_v252.Parent = _v218
local _v312 = Instance.new((_V9({135,223,134,114,172,100,153,39,70})))
_v312.LayoutOrder = 1
_v312.BackgroundTransparency = 1
_v312.Size = UDim2.new(1, 0, 0, 16)
_v312.Font = Enum.Font.GothamBold
_v312.TextSize = 13
_v312.TextColor3 = _v118.OutlineColor
_v312.TextStrokeTransparency = 0.35
_v312.Text = name
_v312.Visible = false
_v312.Parent = _v218
local _v149 = Instance.new((_V9({135,223,134,114,172,100,153,39,70})))
_v149.LayoutOrder = 2
_v149.BackgroundTransparency = 1
_v149.Size = UDim2.new(1, 0, 0, 14)
_v149.Font = Enum.Font.Gotham
_v149.TextSize = 12
_v149.TextColor3 = _v118.OutlineColor
_v149.TextStrokeTransparency = 0.4
_v149.Text = (_V9({}))
_v149.Visible = false
_v149.Parent = _v218
local _v208 = Instance.new((_V9({149,200,159,107,133})))
_v208.LayoutOrder = 3
_v208.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v208.BackgroundTransparency = 0.3
_v208.BorderSizePixel = 0
_v208.Size = UDim2.new(0.55, 0, 0, 5)
_v208.Visible = false
_v208.Parent = _v218
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v208, CornerRadius = UDim.new(1, 0) })
local _v209 = Instance.new((_V9({149,200,159,107,133})))
_v209.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v209.BorderSizePixel = 0
_v209.Size = UDim2.fromScale(1, 1)
_v209.Parent = _v208
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v209, CornerRadius = UDim.new(1, 0) })
_v168.nameTag = _v483
_v168.nameLabel = _v312
_v168.distanceLabel = _v149
_v168.healthBack = _v208
_v168.healthFill = _v209
_v168.nameHead = _v206
end
local function _v519(name, _v168, _v110, _v118, _v98)
local _v206 = _v98 and (_v98.Head or _v98.HRP)
or _v110:FindFirstChild((_V9({155,223,159,98})))
or _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
if not _v206 then
if _v168.nameTag then
_v168.nameTag.Enabled = false
end
return
end
if not _v168.nameTag or not _v168.nameTag.Parent or _v168.nameHead ~= _v206 then
if _v168.nameTag then
pcall(function()
_v168.nameTag:Destroy()
end)
end
_v277(_v168, name, _v206, _v118)
end
_v168.nameLabel.TextColor3 = _v118.OutlineColor
_v168.nameLabel.Visible = _v118.Names or _v118.NameTags
_v168.distanceLabel.Visible = _v118.Distance or _v118.DistanceTags
if _v168.distanceLabel.Visible then
_v168.distanceLabel.TextColor3 = _v118.OutlineColor
local _v310, hrp
if _v98 then
_v310, hrp = _v9.LocalRootPos, _v98.HRP
else
local _v308 = _v26.Character
local _v309 = _v308 and _v308:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
_v310 = _v309 and _v309.Position
hrp = _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
end
local d = (_v310 and hrp) and math.floor((hrp.Position - _v310).Magnitude + 0.5) or 0
_v168.distanceLabel.Text = (_V9({136})) .. d .. (_V9({190,231}))
end
_v168.healthBack.Visible = _v118.HealthBars
if _v118.HealthBars then
local humanoid = _v98 and _v98.Humanoid or _v110:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
local _v189 = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v168.healthFill.Size = UDim2.fromScale(_v189, 1)
_v168.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v189)
end
_v168.nameTag.Enabled = true
end
local function _v214(_v168)
_v168.hl.Enabled = false
if _v168.box then
_v168.box.Visible = false
end
if _v168.nameTag then
_v168.nameTag.Enabled = false
end
end
local function _v406(_v168, _v110, name, _v118, _v98)
if _v118.Outlines then
if _v168.hl.Adornee ~= _v110 then
_v168.hl.Adornee = _v110
end
_v168.hl.OutlineColor = _v118.OutlineColor
_v168.hl.FillColor = _v118.FillColor
_v168.hl.OutlineTransparency = 1 - _v118.OutlineOpacity
_v168.hl.FillTransparency = _v118.Filled and (1 - _v118.FillOpacity) or 1
_v168.hl.DepthMode = _v15
_v168.hl.Enabled = true
else
_v168.hl.Enabled = false
end
if _v118.Boxes then
_v517(_v168, _v110, _v118, _v98)
elseif _v168.box then
_v168.box.Visible = false
end
if _v118.Names or _v118.Distance or _v118.NameTags or _v118.DistanceTags or _v118.HealthBars then
_v519(name, _v168, _v110, _v118, _v98)
elseif _v168.nameTag then
_v168.nameTag.Enabled = false
end
end
local function _v151(part)
local _v308 = _v26.Character
local _v309 = _v308 and _v308:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
if not _v309 or not part then
return 0
end
return (part.Position - _v309.Position).Magnitude
end
local function _v521(_v98, _v168, _v118)
local hrp = _v98.HRP
if not _v118.Enabled or not hrp then
_v214(_v168)
return
end
local _v310 = _v9.LocalRootPos
local dist = _v310 and (hrp.Position - _v310).Magnitude or 0
if dist > _v118.MaxDistance then
_v214(_v168)
return
end
_v406(_v168, _v98.Character, _v98.Player.Name, _v118, _v98)
end
local function _v315(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v215 = Instance.new((_V9({155,211,153,110,140,108,156,42,94})))
_v215.Name = (_V9({150,233,174,73,149,113,151,43,68,182}))
_v215.Enabled = false
_v215.FillColor = color
_v215.OutlineColor = color
_v215.Parent = _v123
local box = Instance.new((_V9({149,200,159,107,133})))
box.Name = (_V9({150,233,174,68,143,125}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v194()
local boxStroke = Instance.new((_V9({134,243,173,114,146,106,144,39})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = _v215, box = box, boxStroke = boxStroke }
end
local function _v143(_v168)
if _v168.hl then
_v168.hl:Destroy()
end
if _v168.box then
_v168.box:Destroy()
end
if _v168.nameTag then
pcall(function()
_v168.nameTag:Destroy()
end)
end
end
local function _v56(_v378, _v139)
if _v378 == _v26 or _v167[_v378] then
return
end
_v167[_v378] = _v315(_v139)
end
local function _v405(_v378)
local _v168 = _v167[_v378]
if not _v168 then
return
end
_v143(_v168)
_v167[_v378] = nil
end
local _v322 = {}
local _v250 = 0
local _v28 = 1
local function _v404(_v294)
local _v168 = _v322[_v294]
if not _v168 then
return
end
_v143(_v168)
_v322[_v294] = nil
end
local function _v409()
local current = {}
for _, _v336 in ipairs(_v48:GetDescendants()) do
if _v336:IsA((_V9({155,207,147,103,142,106,146,38}))) then
local _v294 = _v336.Parent
if
_v294
and _v294:IsA((_V9({158,213,154,99,140})))
and _v294 ~= _v26.Character
and not _v31:GetPlayerFromCharacter(_v294)
then
current[_v294] = true
if not _v322[_v294] then
_v322[_v294] = _v315(_v12.ESP.OutlineColor)
end
end
end
end
for _v294 in pairs(_v322) do
if not current[_v294] or not _v294.Parent then
_v404(_v294)
end
end
end
local function _v520(_v294, _v168, _v118)
local root = _v171(_v294)
local humanoid = _v294:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
if not _v294.Parent or not root or not _v235(humanoid) then
_v214(_v168)
return
end
if _v151(root) > _v118.MaxDistance then
_v214(_v168)
return
end
_v406(_v168, _v294, _v294.Name, _v118)
end
function ESP:Init()
if _v123 then
return
end
_v123 = Instance.new((_V9({149,213,146,98,133,119})))
_v123.Name = _v10.RandomName()
local _v338 = pcall(function()
_v123.Parent = _v45.getGuiParent()
end)
if not _v338 or not _v123.Parent then
_v123.Parent = _v48
end
_v10.Protect(_v123)
for _, _v378 in ipairs(_v31:GetPlayers()) do
_v56(_v378, _v12.ESP.OutlineColor)
end
end
function ESP:Update(_v118)
local _v407 = {}
for _, _v98 in ipairs(_v9:Get()) do
local _v378 = _v98.Player
if _v378 then
_v407[_v378] = true
local _v168 = _v167[_v378]
if not _v168 then
_v56(_v378, _v118.OutlineColor)
_v168 = _v167[_v378]
end
_v521(_v98, _v168, _v118)
end
end
for _v378, _v168 in pairs(_v167) do
if _v378.Parent ~= _v31 then
_v405(_v378)
elseif not _v407[_v378] then
_v214(_v168)
end
end
if _v118.Enabled and _v118.NPCs then
if os.clock() - _v250 >= _v28 then
_v250 = os.clock()
_v409()
end
for _v294, _v168 in pairs(_v322) do
_v520(_v294, _v168, _v118)
end
elseif next(_v322) then
for _v294 in pairs(_v322) do
_v404(_v294)
end
end
end
function ESP:OnPlayerAdded(_v378)
_v56(_v378, _v12.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v378)
_v405(_v378)
end
function ESP:Cleanup()
for _v378 in pairs(_v167) do
_v405(_v378)
end
for _v294 in pairs(_v322) do
_v404(_v294)
end
if _v123 then
_v123:Destroy()
_v123 = nil
end
if _v81 then
_v81:Destroy()
_v81 = nil
end
end
return ESP
end)()
_v16 = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v16 = {}
local _v129 = type(Drawing) == (_V9({167,219,156,106,133})) and type(Drawing.new) == (_V9({181,207,144,101,148,108,148,44}))
local _v136 = false
local _v130 = {}
local function _v133()
local _v258 = Drawing.new((_V9({159,211,144,99})))
_v258.Thickness = 1
_v258.Visible = false
return _v258
end
local function _v132(_v378)
local _v168 = {
box = { _v133(), _v133(), _v133(), _v133() },
tracer = _v133(),
}
_v130[_v378] = _v168
return _v168
end
local function _v131(_v168)
for _, _v258 in ipairs(_v168.box) do
_v258.Visible = false
end
_v168.tracer.Visible = false
end
local function _v134(_v378)
local _v168 = _v130[_v378]
if not _v168 then
return
end
_v130[_v378] = nil
for _, _v258 in ipairs(_v168.box) do
_v258:Remove()
end
_v168.tracer:Remove()
end
local function _v135(_v98, _v118, _v93, _v96)
local _v378 = _v98.Player
local _v168 = _v130[_v378]
if _v96.TeamCheck and _v378.Team ~= nil and _v378.Team == _v26.Team then
if _v168 then
_v131(_v168)
end
return
end
local root = _v98.HRP
if not (_v118.Boxes or _v118.Tracers) or not root then
if _v168 then
_v131(_v168)
end
return
end
local _v505, onScreen, botV = _v98.TopScreen, _v98.TopOnScreen, _v98.BotScreen
if not _v505 or not onScreen or _v505.Z <= 0 or botV.Z <= 0 then
if _v168 then
_v131(_v168)
end
return
end
_v168 = _v168 or _v132(_v378)
local _v210 = math.abs(botV.Y - _v505.Y)
local _v545 = _v210 * 0.62
local _v127 = (_v505.X + botV.X) * 0.5
local _v254, right = _v127 - _v545 * 0.5, _v127 + _v545 * 0.5
local _v504, bottom = _v505.Y, botV.Y
local box = _v168.box
box[1].From = Vector2.new(_v254, _v504)
box[1].To = Vector2.new(right, _v504)
box[2].From = Vector2.new(_v254, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v254, _v504)
box[3].To = Vector2.new(_v254, bottom)
box[4].From = Vector2.new(right, _v504)
box[4].To = Vector2.new(right, bottom)
for _, _v258 in ipairs(box) do
_v258.Color = _v118.BoxColor
_v258.Visible = _v118.Boxes
end
_v168.tracer.From = Vector2.new(_v93.ViewportSize.X / 2, _v93.ViewportSize.Y)
_v168.tracer.To = Vector2.new(_v127, bottom)
_v168.tracer.Color = _v118.TracerColor
_v168.tracer.Visible = _v118.Tracers
end
function _v16:Update(_v118, _v96)
if not _v129 then
if (_v118.Boxes or _v118.Tracers) and not _v136 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,104,188,194,209,82,146,100,152,39,88,243,255,173,86,192,107,158,39,78,160,154,138,110,133,37,191,48,75,164,211,144,97,192,105,146,32,88,178,200,135,38,2,133,111,98,68,188,206,222,103,150,100,146,46,75,177,214,155,38,137,107,219,54,66,186,201,222,99,152,96,152,55,94,188,200,208})))
_v136 = true
end
return
end
local _v93 = _v48.CurrentCamera
if not _v93 then
return
end
local _v439 = {}
for _, _v98 in ipairs(_v9:Get()) do
if _v98.Player then
_v439[_v98.Player] = true
_v135(_v98, _v118, _v93, _v96)
end
end
for _v378, _v168 in pairs(_v130) do
if _v378.Parent ~= _v31 then
_v134(_v378)
elseif not _v439[_v378] then
_v131(_v168)
end
end
end
function _v16:Cleanup()
for _v378 in pairs(_v130) do
_v134(_v378)
end
end
return _v16
end)()
Visuals = (function()
local _v25 = game:GetService((_V9({159,211,153,110,148,108,149,37})))
local Visuals = {}
local _v25 = game:GetService((_V9({159,211,153,110,148,108,149,37})))
local _v538
local _v25 = game:GetService((_V9({159,211,153,110,148,108,149,37})))
local _v538
local _v535 = false
local _v537 = false
local _v536 = 0
local _v46 = 1
local function _v534()
if _v538 then
return
end
_v538 = {
Brightness = _v25.Brightness,
ClockTime = _v25.ClockTime,
GlobalShadows = _v25.GlobalShadows,
FogEnd = _v25.FogEnd,
FogStart = _v25.FogStart,
Ambient = _v25.Ambient,
OutdoorAmbient = _v25.OutdoorAmbient,
}
end
local function _v532()
_v25.Brightness = 2
_v25.ClockTime = 14
_v25.GlobalShadows = false
end
local function _v533()
_v25.FogEnd = 100000
end
local function _v539()
_v25.Brightness = _v538.Brightness
_v25.ClockTime = _v538.ClockTime
_v25.GlobalShadows = _v538.GlobalShadows
end
local function _v540()
_v25.FogEnd = _v538.FogEnd
_v25.FogStart = _v538.FogStart
end
function Visuals:Update(_v118)
if not (_v118.Fullbright or _v118.NoFog or _v535 or _v537) then
return
end
_v534()
if _v118.Fullbright ~= _v535 then
_v535 = _v118.Fullbright
if _v535 then
_v532()
else
_v539()
end
end
if _v118.NoFog ~= _v537 then
_v537 = _v118.NoFog
if _v537 then
_v533()
else
_v540()
end
end
if (_v535 or _v537) and os.clock() - _v536 >= _v46 then
_v536 = os.clock()
if _v535
and (_v25.Brightness ~= 2 or _v25.ClockTime ~= 14 or _v25.GlobalShadows)
then
_v532()
end
if _v537 and _v25.FogEnd < 100000 then
_v533()
end
end
end
function Visuals:Cleanup()
if _v538 then
if _v535 then
_v539()
end
if _v537 then
_v540()
end
end
_v535 = false
_v537 = false
end
return Visuals
end)()
_v47 = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v47 = {}
_v47.Version = (_V9({227}))
local function _v410()
local _v100 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v182 in ipairs(_v100) do
if type(_v182) == (_V9({181,207,144,101,148,108,148,44})) then
return _v182
end
end
return nil
end
local function _v411()
local _v522 = _v12.Webhook.Url
if type(_v522) == (_V9({160,206,140,111,142,98})) and _v522 ~= (_V9({})) then
return _v522
end
return nil
end
function _v47.SetWebhook(_v522)
_v12.Webhook.Url = tostring(_v522 or (_V9({})))
return true
end
function _v47.HasWebhook()
return _v411() ~= nil
end
function _v47.SendWebhook(content, _v363)
_v363 = _v363 or {}
local _v522 = _v411()
if not _v522 then
return false, (_V9({189,213,161,113,133,103,147,45,69,184}))
end
local _v408 = _v410()
if not _v408 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,100,188,154,182,82,180,85,219,48,79,162,207,155,117,148,37,157,55,68,176,206,151,105,142,37,154,52,75,186,214,159,100,140,96,219,43,68,243,206,150,111,147,37,158,58,79,176,207,138,105,146})))
return false, (_V9({189,213,161,110,148,113,139}))
end
local _v371 = {
username = _v363.username or (_V9({133,219,144,111,148,124,214,5,79,189,223,140,103,140})),
avatar_url = _v363.avatar_url,
content = content,
embeds = _v363.embeds,
}
local _v338, err = pcall(function()
local _v76 = game:GetService((_V9({155,206,138,118,179,96,137,52,67,176,223}))):JSONEncode(_v371)
return _v408({
Url = _v522,
Method = (_V9({131,245,173,82})),
Headers = { [(_V9({144,213,144,114,133,107,143,111,126,170,202,155}))] = (_V9({178,202,142,106,137,102,154,54,67,188,212,209,108,147,106,149})) },
Body = _v76,
})
end)
_v522 = nil
if not _v338 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,125,182,216,150,105,143,110,219,49,79,189,222,222,96,129,108,151,39,78,233})), err)
return false, err
end
return true
end
function _v47.SendLoadedEmbed(_v236)
local _v376 = (_V9({236}))
pcall(function()
_v376 = game:GetService((_V9({158,219,140,109,133,113,139,46,75,176,223,173,99,146,115,146,33,79}))):GetProductInfo(game.PlaceId).Name
end)
return _v47.SendWebhook(nil, {
embeds = {
{
title = (_V9({133,219,144,111,148,124,213,38,79,165,154,185,99,142,96,137,35,70,243,214,145,103,132,96,159})),
color = 8666558,
fields = {
{ name = (_V9({131,214,159,127,133,119})), value = (_V9({179})) .. (_v26 and _v26.Name or (_V9({236}))) .. (_V9({179})), inline = true },
{ name = (_V9({133,223,140,117,137,106,149})), value = (_V9({179,204})) .. tostring(_v47.Version) .. (_V9({179})), inline = true },
{ name = (_V9({148,219,147,99})), value = _v376, inline = false },
{ name = (_V9({131,214,159,101,133,76,159})), value = (_V9({179})) .. tostring(game.PlaceId) .. (_V9({179})), inline = true },
{ name = (_V9({151,223,156,115,135,98,158,38})), value = (_V9({179})) .. tostring(_v236) .. (_V9({179})), inline = true },
},
footer = { text = os.date((_V9({246,227,211,35,141,40,222,38,10,246,242,196,35,173,63,222,17}))) },
},
},
})
end
return _v47
end)()
Triggerbot = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local Triggerbot = {}
local _v488
local _v494 = false
local _v497 = false
local _v491 = nil
local _v489
local _v495 = Random.new()
local _v490 = 0
local _v492 = 0.1
local function _v493()
if _v494 then
return
end
_v494 = true
if type(mouse1click) == (_V9({181,207,144,101,148,108,148,44})) then
_v488 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({181,207,144,101,148,108,148,44})) and type(mouse1release) == (_V9({181,207,144,101,148,108,148,44})) then
_v488 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v496(_v118, _v96)
local _v93 = _v48.CurrentCamera
if not _v93 then
return nil
end
local _v531 = _v93.ViewportSize
local _v395 = _v93:ViewportPointToRay(_v531.X / 2, _v531.Y / 2)
local params = RaycastParams.new()
if _v118.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
else
local _v111 = {}
for _, _v382 in ipairs(_v31:GetPlayers()) do
if _v382 ~= _v26 and _v382.Character then
table.insert(_v111, _v382.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v111
end
local _v412 = _v48:Raycast(_v395.Origin, _v395.Direction * (_v118.MaxDistance or 1000), params)
if not _v412 then
return nil
end
local _v294 = _v412.Instance:FindFirstAncestorOfClass((_V9({158,213,154,99,140})))
local _v382 = _v294 and _v31:GetPlayerFromCharacter(_v294)
if not _v382 or _v382 == _v26 then
return nil
end
if _v96 and _v96.TeamCheck and _v382.Team ~= nil and _v382.Team == _v26.Team then
return nil
end
local _v225 = _v294:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
if not _v225 or _v225.Health <= 0 then
return nil
end
return _v294
end
function Triggerbot:Update(_v118, _v96)
if not _v118.Enabled then
_v491 = nil
return
end
_v493()
if not _v488 then
if not _v497 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,126,161,211,153,97,133,119,153,45,94,243,212,155,99,132,118,219,35,10,190,213,139,117,133,40,152,46,67,176,209,222,96,149,107,152,54,67,188,212,222,46,141,106,142,49,79,226,217,146,111,131,110,210,98,200,83,46,222,104,143,113,219,35,92,178,211,146,103,130,105,158,98,67,189,154,138,110,137,118,219,39,82,182,217,139,114,143,119,213})))
_v497 = true
end
return
end
local target = _v496(_v118, _v96)
if not target then
_v491 = nil
return
end
local _v321 = os.clock()
if not _v491 then
_v491 = _v321
local _v264 = math.min(_v118.MinDelay or 0.1, _v118.MaxDelay or 0.25)
local _v212 = math.max(_v118.MinDelay or 0.1, _v118.MaxDelay or 0.25)
_v489 = _v495:NextNumber(_v264, _v212)
end
if (_v321 - _v491) >= (_v489 or 0) and (_v321 - _v490) >= _v492 then
_v490 = _v321
_v492 = _v495:NextNumber(0.09, 0.17)
_v488()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local _v8 = _v8
local _v10 = _v10
local SilentAim = {}
local _v426 = false
local _v431 = false
local _v424
local _v4 = 500
local _v2 = 12
local _v3 = 200
local function _v427()
local _v110 = _v26.Character
if _v110 then
local _v206 = _v110:FindFirstChild((_V9({155,223,159,98}))) or _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
if _v206 then
return _v206.Position
end
end
local _v95 = _v48.CurrentCamera
return _v95 and _v95.CFrame.Position or Vector3.zero
end
local function _v422(_v110)
if not _v110 then
return nil
end
return _v110:FindFirstChild((_V9({155,223,159,98})))
or _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
or _v110:FindFirstChild((_V9({134,202,142,99,146,81,148,48,89,188})))
or _v110:FindFirstChild((_V9({135,213,140,117,143})))
end
local function _v430()
local target = _v8:GetCurrentTarget()
if target and target.Part and target.Part.Parent then
return target.Part
end
if not _v424 then
return nil
end
local _v265 = _v8:GetLookTarget(_v424.ESP, _v424.Camera)
if typeof(_v265) ~= (_V9({154,212,141,114,129,107,152,39})) then
return nil
end
local _v110 = _v265:IsA((_V9({131,214,159,127,133,119}))) and _v265.Character or _v265
local part = _v422(_v110)
if part and part.Parent then
return part
end
return nil
end
local function _v421(_v364, part)
local _v486 = part.Position
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character, part:FindFirstAncestorOfClass((_V9({158,213,154,99,140}))) or part }
if not _v48:Raycast(_v364, _v486 - _v364, params) then
return _v486
end
local _v289 = (_v364 + _v486) / 2
local _v388 = _v289 + Vector3.new(0, _v4, 0)
local _v179 = math.min(_v364.Y, _v486.Y)
local _v216 = _v48:Raycast(_v388, Vector3.new(0, _v179 - 5 - _v388.Y, 0), params)
local _v104 = math.max(_v364.Y, _v486.Y)
local _v65
if _v216 then
_v65 = _v216.Position.Y + _v2
else
_v65 = _v104 + _v3
end
_v65 = math.clamp(_v65, _v104 + 5, _v104 + _v3)
return Vector3.new(_v289.X, _v65, _v289.Z)
end
local function _v425()
return type(checkcaller) == (_V9({181,207,144,101,148,108,148,44})) and not checkcaller()
end
local _v429 = Random.new()
local function _v428()
local part = _v430()
if not part or not _v424 then
return nil
end
if not part:IsDescendantOf(_v48) then
return nil
end
local _v286 = _v424.SilentAim.MaxAngle or 30
if _v286 < 180 then
local _v93 = _v48.CurrentCamera
if _v93 then
local _v500 = (part.Position - _v93.CFrame.Position).Unit
if _v93.CFrame.LookVector:Dot(_v500) < math.cos(math.rad(_v286)) then
return nil
end
end
end
local _v108 = _v424.SilentAim.HitChance or 100
if _v108 < 100 and _v429:NextNumber(0, 100) > _v108 then
return nil
end
return part
end
function SilentAim:Init(_v118)
_v424 = _v118
end
function SilentAim:Update(_v118)
if _v426 or not _v118.SilentAim.Enabled then
return
end
self:_install()
end
function SilentAim:_install()
if _v426 then
return
end
if type(hookmetamethod) ~= (_V9({181,207,144,101,148,108,148,44})) or type(getnamecallmethod) ~= (_V9({181,207,144,101,148,108,148,44})) then
if not _v431 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,121,186,214,155,104,148,37,186,43,71,243,212,155,99,132,118,219,42,69,188,209,147,99,148,100,150,39,94,187,213,154,38,2,133,111,98,68,188,206,222,103,150,100,146,46,75,177,214,155,38,137,107,219,54,66,186,201,222,99,152,96,152,55,94,188,200,208})))
_v431 = true
end
_v426 = true
return
end
_v426 = true
local function _v162()
return _v424.SilentAim.Enabled
end
local _v423 = false
local function _v414(_v350, self, _v288, part, ...)
if _v288 == (_V9({149,211,140,99,179,96,137,52,79,161})) or _v288 == (_V9({154,212,136,105,139,96,168,39,88,165,223,140})) then
local _v299 = _v427()
local _v59 = _v421(_v299, part)
local _v70 = { ... }
for i, value in ipairs(_v70) do
if typeof(value) == (_V9({133,223,157,114,143,119,200})) then
local _v267 = value.Magnitude
if _v267 > 0.5 and _v267 < 1.5 then
_v70[i] = (_v59 - _v299).Unit
else
_v70[i] = part.Position
end
elseif typeof(value) == (_V9({144,252,140,103,141,96})) then
_v70[i] = part.CFrame
end
end
return table.pack(_v350(self, table.unpack(_v70)))
end
if _v288 == (_V9({129,219,135,101,129,118,143})) and self == _v48 then
local _v364, _v148, params = ...
if typeof(_v364) == (_V9({133,223,157,114,143,119,200})) and typeof(_v148) == (_V9({133,223,157,114,143,119,200})) then
local _v59 = _v421(_v364, part)
local _v73 = (_v59 - _v364).Unit * _v148.Magnitude
return table.pack(_v350(self, _v364, _v73, params))
end
end
return nil
end
local _v350
_v350 = hookmetamethod(game, (_V9({140,229,144,103,141,96,152,35,70,191})), _v10.CClosure(function(self, ...)
if _v423 then
return _v350(self, ...)
end
if _v162() and _v425() then
_v423 = true
local _v338, packed = pcall(function()
local part = _v428()
if not part then
return nil
end
return _v414(_v350, self, getnamecallmethod(), part, ...)
end)
_v423 = false
if _v338 and packed then
return table.unpack(packed, 1, packed.n)
end
end
return _v350(self, ...)
end))
local _v295 = _v26:GetMouse()
local _v349
_v349 = hookmetamethod(game, (_V9({140,229,151,104,132,96,131})), _v10.CClosure(function(self, _v244)
if _v423 then
return _v349(self, _v244)
end
if _v162() and _v425() and self == _v295 then
_v423 = true
local _v338, part = pcall(_v428)
_v423 = false
if _v338 and part then
if _v244 == (_V9({155,211,138})) then
return part.CFrame
end
if _v244 == (_V9({135,219,140,97,133,113})) then
return part
end
end
end
return _v349(self, _v244)
end))
end
return SilentAim
end)()
Hitbox = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v22 = {}
local _v203 = {}
local function _v204(_v110)
local _v365 = _v203[_v110]
if not _v365 then
return
end
_v203[_v110] = nil
local root = _v365.root
if root and root.Parent then
root.Size = _v365.size
root.Transparency = _v365.transparency
root.CanCollide = _v365.canCollide
end
end
local function _v205()
for _v110 in pairs(_v203) do
_v204(_v110)
end
end
local function _v202(_v98, _v118, _v439)
local root = _v98.HRP
if not root then
return
end
local _v110 = _v98.Character
_v439[_v110] = true
if not _v203[_v110] then
_v203[_v110] = {
root = root,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = _v118.Size or 5
root.Size = Vector3.new(size, size, size)
root.Transparency = _v118.Transparency or 0.5
root.CanCollide = false
end
function _v22:Update(_v118, _v96)
if not _v118.Enabled then
_v205()
return
end
local _v439 = {}
for _, _v98 in ipairs(_v9:Get()) do
local _v378 = _v98.Player
if not (_v96.TeamCheck and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team) then
_v202(_v98, _v118, _v439)
end
end
for _v110 in pairs(_v203) do
if not _v439[_v110] then
_v204(_v110)
end
end
end
function _v22:Cleanup()
_v205()
end
return _v22
end)()
NoRecoil = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v44 = game:GetService((_V9({134,201,155,116,169,107,139,55,94,128,223,140,112,137,102,158})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local NoRecoil = {}
local function _v237()
return _v44:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v72 = nil
local function _v97(_v93)
local _v265 = _v93.CFrame.LookVector
return math.asin(math.clamp(_v265.Y, -1, 1))
end
function NoRecoil:Update(_v118, _v60)
if not _v118.Enabled then
_v72 = nil
return
end
local _v93 = _v48.CurrentCamera
if not _v93 then
_v72 = nil
return
end
if _v118.RequireMouseDown and not _v237() then
_v72 = nil
return
end
local _v109 = _v26.Character
local _v225 = _v109 and _v109:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
if _v225 then
_v225.CameraOffset = Vector3.new(0, 0, 0)
end
if _v60 then
_v72 = nil
return
end
local _v467 = math.clamp(_v118.Strength, 0, 1)
if _v467 <= 0 then
_v72 = nil
return
end
local _v375 = _v97(_v93)
if _v72 == nil then
_v72 = _v375
return
end
local _v157 = _v375 - _v72
if _v118.AllowAim and _v157 < 0 then
_v72 = _v375
return
end
if _v157 ~= 0 then
_v93.CFrame = _v93.CFrame * CFrame.Angles(-_v157 * _v467, 0, 0)
end
end
function NoRecoil:Reset()
_v72 = nil
end
NoRecoil.IsFiring = _v237
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local _v10 = _v10
local NoSpread = {}
local _v323 = false
local _v335 = false
local _v327 = false
local _v333 = false
local _v334 = 1
local _v329 = nil
local _v331 = nil
local _v330 = nil
local function _v324()
if type(hookfunction) == (_V9({181,207,144,101,148,108,148,44})) then
return hookfunction
elseif type(replaceclosure) == (_V9({181,207,144,101,148,108,148,44})) then
return replaceclosure
end
return nil
end
local function _v328(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v332(_v365, _v106, _v239)
local v = _v365 + (_v106 - _v365) * _v334
if _v239 then
return math.floor(v + 0.5)
end
return v
end
local function _v325(_v219)
if _v327 then
return
end
local _v338, ret = pcall(_v219, math.random, _v10.CClosure(function(...)
local _v365 = _v329(...)
if _v323 and _v334 > 0 then
local a, b = ...
return _v332(_v365, _v328(a, b), a ~= nil)
end
return _v365
end))
if _v338 then
_v329 = ret
_v327 = true
end
end
local function _v326(_v219)
if _v333 then
return
end
local _v338 = pcall(function()
local _v432 = Random.new()
_v331 = _v219(_v432.NextNumber, _v10.CClosure(function(self, ...)
local _v365 = _v331(self, ...)
if _v323 and _v334 > 0 then
local _v292, mx = ...
local _v106 = (_v292 == nil) and 0.5 or ((_v292 + mx) / 2)
return _v332(_v365, _v106, false)
end
return _v365
end))
_v330 = _v219(_v432.NextInteger, _v10.CClosure(function(self, ...)
local _v365 = _v330(self, ...)
if _v323 and _v334 > 0 then
local _v292, mx = ...
return _v332(_v365, (_v292 + mx) / 2, true)
end
return _v365
end))
end)
if _v338 then
_v333 = true
end
end
function NoSpread:_install()
if _v327 or _v333 then
return true
end
local _v219 = _v324()
if not _v219 then
if not _v335 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,100,188,154,173,118,146,96,154,38,10,189,223,155,98,147,37,157,55,68,176,206,151,105,142,37,147,45,69,184,211,144,97,192,45,147,45,69,184,220,139,104,131,113,146,45,68,250,154,28,134,116,37,149,45,94,243,219,136,103,137,105,154,32,70,182,154,151,104,192,113,147,43,89,243,223,134,99,131,112,143,45,88,253})))
_v335 = true
end
return false
end
_v325(_v219)
_v326(_v219)
if not (_v327 or _v333) then
if not _v335 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,100,188,154,173,118,146,96,154,38,16,243,220,159,111,140,96,159,98,94,188,154,151,104,147,113,154,46,70,243,219,144,127,192,109,148,45,65,253})))
_v335 = true
end
return false
end
return true
end
function NoSpread:Update(_v118)
_v334 = math.clamp(_v118.Strength or 1, 0, 1)
if _v118.Enabled then
if not (_v327 or _v333) and not self:_install() then
return
end
_v323 = (not _v118.RequireMouseDown) or NoRecoil.IsFiring()
else
_v323 = false
end
end
function NoSpread:Cleanup()
_v323 = false
local _v219 = _v324()
if not _v219 then
return
end
local _v344, errMath = pcall(function()
if _v327 and _v329 then
_v219(math.random, _v329)
_v327 = false
end
end)
if not _v344 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,100,188,233,142,116,133,100,159,98,71,178,206,150,40,146,100,149,38,69,190,154,140,99,147,113,148,48,79,243,220,159,111,140,96,159,120})), errMath)
end
local _v345, errRand = pcall(function()
if _v333 then
local _v432 = Random.new()
if _v331 then
_v219(_v432.NextNumber, _v331)
end
if _v330 then
_v219(_v432.NextInteger, _v330)
end
_v333 = false
end
end)
if not _v345 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,100,188,233,142,116,133,100,159,98,120,178,212,154,105,141,37,137,39,89,167,213,140,99,192,99,154,43,70,182,222,196})), errRand)
end
end
return NoSpread
end)()
UI = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v44 = game:GetService((_V9({134,201,155,116,169,107,139,55,94,128,223,140,112,137,102,158})))
local _v43 = game:GetService((_V9({135,205,155,99,142,86,158,48,92,186,217,155})))
local _v36 = game:GetService((_V9({129,207,144,85,133,119,141,43,73,182})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local _v11 = _v11
local _v45 = _v45
local _v47 = _v47
local _v10 = _v10
local UI = {}
UI.TeleportTo = nil
local _v6 = {
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
local _v17 = 0.18
local _v1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local _v200
local _v268
local _v546
local _v126 = (_V9({144,213,147,100,129,113}))
local _v253 = 0
local _v530 = false
local _v54
local _v357
local _v513 = {}
local _v297 = {}
local _v403 = {}
local _v474 = {}
local _v485, targetPanelLabel
local _v484 = false
local _v247
local _v541
local _v188, fpsLabel
local _v53
local _v102 = false
local _v55 = nil
local _v381 = {}
local _v380
local _v443
local _v456
local _v455
local _v372 = nil
local function _v67(_v314)
local _v348 = _v6.accent
if _v314 == _v348 then
return
end
_v6.accent = _v314
if _v54 and _v54.UI then
_v54.UI.Accent = _v314
end
if not _v200 then
return
end
_v372 = _v314
task.defer(function()
if _v372 ~= _v314 then
return
end
_v372 = nil
for _, _v232 in ipairs(_v200:GetDescendants()) do
if _v232:IsA((_V9({148,207,151,73,130,111,158,33,94}))) then
if _v232.BackgroundColor3 == _v348 then
_v232.BackgroundColor3 = _v314
end
if (_v232:IsA((_V9({135,223,134,114,172,100,153,39,70}))) or _v232:IsA((_V9({135,223,134,114,162,112,143,54,69,189}))) or _v232:IsA((_V9({135,223,134,114,162,106,131}))))
and _v232.TextColor3 == _v348
then
_v232.TextColor3 = _v314
end
if _v232:IsA((_V9({128,217,140,105,140,105,146,44,77,149,200,159,107,133}))) and _v232.ScrollBarImageColor3 == _v348 then
_v232.ScrollBarImageColor3 = _v314
end
elseif _v232:IsA((_V9({134,243,173,114,146,106,144,39}))) and _v232.Color == _v348 then
_v232.Color = _v314
end
end
end)
end
local function _v400()
if _v455 then
_v455.Text = _v456 and (_V9({128,206,145,118,192,86,139,39,73,167,219,138,111,142,98})) or (_V9({128,202,155,101,148,100,143,39}))
end
end
local function _v466()
if not _v456 then
return
end
_v456 = nil
local _v93 = _v48.CurrentCamera
local _v110 = _v26.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
if _v93 and humanoid then
_v93.CameraSubject = humanoid
end
_v400()
end
local function _v464(_v378)
local _v110 = _v378 and _v378.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
local _v93 = _v48.CurrentCamera
if not (_v93 and humanoid) then
return
end
_v456 = _v378
_v93.CameraSubject = humanoid
_v400()
end
function UI.IsSpectating()
return _v456 ~= nil
end
local function _v316(_v114, _v389)
local _v232 = Instance.new(_v114)
for k, v in pairs(_v389) do
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
local function _v462()
table.insert(_v513, _v44.InputChanged:Connect(function(_v230)
if not _v240(_v230) then
return
end
for _, _v182 in ipairs(_v297) do
_v182(_v230)
end
end))
table.insert(_v513, _v44.InputEnded:Connect(function(_v230)
if not _v241(_v230) then
return
end
for _, _v182 in ipairs(_v403) do
_v182(_v230)
end
end))
table.insert(_v513, _v44.InputBegan:Connect(function(_v230)
if not _v55 or not _v241(_v230) then
return
end
local _v383 = Vector2.new(_v230.Position.X, _v230.Position.Y)
if not _v55.contains(_v383) then
_v55.close()
end
end))
table.insert(_v513, _v44.InputBegan:Connect(function(_v230)
if not _v53 then
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
_v53.finish(nil)
else
_v53.finish(_v244)
end
end))
end
local function _v283(_v368, text, _v197, _v352)
local btn = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v316((_V9({149,200,159,107,133})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v197() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = box, Color = _v6.border, Thickness = 1 })
local _v248 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v197() and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local function _v397()
local _v351 = _v197()
_v43:Create(box, _v1, { BackgroundColor3 = _v351 and _v6.accent or _v6.off }):Play()
_v43:Create(_v248, _v1, { TextColor3 = _v351 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v352()
_v397()
end)
btn.MouseEnter:Connect(function()
if not _v197() then
box.BackgroundColor3 = _v6.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v197() then
box.BackgroundColor3 = _v6.off
end
end)
table.insert(_v474, _v397)
end
local function _v280(_v368, text, _v290, _v285, _v197, _v447, _v239, _v469)
_v469 = _v469 or (_V9({}))
local _v218 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v248 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v218,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v509 = _v316((_V9({149,200,159,107,133})), {
Parent = _v218,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v509, CornerRadius = UDim.new(1, 0) })
local _v177 = _v316((_V9({149,200,159,107,133})), {
Parent = _v509,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v177, CornerRadius = UDim.new(1, 0) })
local function _v183(v)
local _v71 = _v239 and tostring(math.floor(v + 0.5)) or string.format((_V9({246,148,204,96})), v)
return _v71 .. _v469
end
local function _v66(v)
v = math.clamp(v, _v290, _v285)
if _v239 then
v = math.floor(v + 0.5)
end
local _v62 = (_v285 > _v290) and (v - _v290) / (_v285 - _v290) or 0
_v177.Size = UDim2.new(_v62, 0, 1, 0)
_v248.Text = text .. (_V9({233,154})) .. _v183(v)
_v447(v)
end
_v66(_v197())
local _v155 = false
local function _v190(_v393)
local _v62 = math.clamp((_v393 - _v509.AbsolutePosition.X) / _v509.AbsoluteSize.X, 0, 1)
_v66(_v290 + _v62 * (_v285 - _v290))
end
_v509.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v155 = true
_v190(_v230.Position.X)
end
end)
table.insert(_v297, function(_v230)
if _v155 then
_v190(_v230.Position.X)
end
end)
table.insert(_v403, function()
_v155 = false
end)
table.insert(_v474, function()
_v66(_v197())
end)
end
local function _v272(_v368, text, _v362, _v197, _v352)
local _v218 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v218,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v159 = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v218,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.text,
Text = _v197(),
ZIndex = 3,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v159, CornerRadius = UDim.new(0, 4) })
local _v358 = false
local _v35 = 24
local _v192 = #_v362 * _v35
local _v262 = math.min(_v192, 7 * _v35)
local _v259 = _v316((_V9({128,217,140,105,140,105,146,44,77,149,200,159,107,133})), {
Parent = _v159,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v192),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v6.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v259, CornerRadius = UDim.new(0, 4) })
for i, _v359 in ipairs(_v362) do
local _v360 = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v259,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.text,
Text = _v359,
AutoButtonColor = false,
ZIndex = 11,
})
_v360.MouseButton1Click:Connect(function()
_v352(_v359)
_v159.Text = _v359
_v358 = false
_v43:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v358 then
_v259.Visible = false
end
end)
end)
_v360.MouseEnter:Connect(function()
_v360.BackgroundColor3 = _v6.rowHover
end)
_v360.MouseLeave:Connect(function()
_v360.BackgroundColor3 = _v6.off
end)
end
_v159.MouseButton1Click:Connect(function()
_v358 = not _v358
if _v358 then
_v259.Visible = true
_v43:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, _v262) }):Play()
else
_v43:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v358 then
_v259.Visible = false
end
end)
end
end)
table.insert(_v474, function()
_v159.Text = _v197()
end)
end
local function _v279(_v368, text, _v229)
local _v218 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v218,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local value = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v218,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v229,
})
return value
end
local function _v269(_v368, text, _v353, color)
local _v71 = color or _v6.accent
local _v221 = Color3.new(
math.min(_v71.R + 0.1, 1),
math.min(_v71.G + 0.1, 1),
math.min(_v71.B + 0.1, 1)
)
local btn = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v71,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v353)
btn.MouseEnter:Connect(function()
_v43:Create(btn, _v1, { BackgroundColor3 = _v221 }):Play()
end)
btn.MouseLeave:Connect(function()
_v43:Create(btn, _v1, { BackgroundColor3 = _v71 }):Play()
end)
return btn
end
local function _v282(_v368, _v377)
local _v218 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v468 = _v316((_V9({134,243,173,114,146,106,144,39})), {
Parent = _v218,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v316((_V9({135,223,134,114,162,106,131})), {
Parent = _v218,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
PlaceholderText = _v377 or (_V9({})),
PlaceholderColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v43:Create(_v468, _v1, { Transparency = 0, Color = _v6.accent }):Play()
end)
box.FocusLost:Connect(function()
_v43:Create(_v468, _v1, { Transparency = 0.3, Color = _v6.border }):Play()
end)
return box
end
local function _v276(_v368, text)
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v274(_v368, text, _v290, _v285, _v197, _v447, _v239, _v514, _v450)
_v514 = _v514 or (_V9({}))
local _v218 = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v177 = _v316((_V9({149,200,159,107,133})), {
Parent = _v218,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v177, CornerRadius = UDim.new(0, 6) })
local _v248 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v218,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
ZIndex = 3,
})
local function _v181(v)
local s = _v239 and tostring(math.floor(v + 0.5)) or string.format((_V9({246,148,204,96})), v)
if _v450 then
local m = _v239 and tostring(math.floor(_v285 + 0.5)) or string.format((_V9({246,148,204,96})), _v285)
return s .. (_V9({252})) .. m .. _v514
end
return s .. _v514
end
local function _v66(v)
v = math.clamp(v, _v290, _v285)
if _v239 then
v = math.floor(v + 0.5)
end
local _v62 = (_v285 > _v290) and (v - _v290) / (_v285 - _v290) or 0
_v177.Size = UDim2.new(_v62, 0, 1, 0)
_v248.Text = text .. (_V9({233,154})) .. _v181(v)
_v447(v)
end
_v66(_v197())
local _v155 = false
local function _v190(_v393)
local _v62 = math.clamp((_v393 - _v218.AbsolutePosition.X) / _v218.AbsoluteSize.X, 0, 1)
_v66(_v290 + _v62 * (_v285 - _v290))
end
_v218.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v155 = true
_v190(_v230.Position.X)
end
end)
table.insert(_v297, function(_v230)
if _v155 then
_v190(_v230.Position.X)
end
end)
table.insert(_v403, function()
_v155 = false
end)
table.insert(_v474, function()
_v66(_v197())
end)
end
local function _v273(_v368, _v362, _v197, _v352)
local _v218 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = _v218,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v159 = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v218,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v159, CornerRadius = UDim.new(0, 6) })
local _v158 = _v316((_V9({134,243,173,114,146,106,144,39})), {
Parent = _v159,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local _v526 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v159,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v197(),
})
local _v103 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v159,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.accent,
Text = (_V9({49,44,64})),
})
local _v358 = false
local _v35 = 26
local _v192 = #_v362 * _v35
local _v262 = math.min(_v192, 6 * _v35)
local _v259 = _v316((_V9({128,217,140,105,140,105,146,44,77,149,200,159,107,133})), {
Parent = _v218,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v192),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v6.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v259, CornerRadius = UDim.new(0, 6) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v259, Color = _v6.border, Thickness = 1, Transparency = 0.2 })
local _v361 = {}
local function _v367()
local current = _v197()
for _v359, btn in pairs(_v361) do
local _v441 = (_v359 == current)
btn.BackgroundColor3 = _v441 and _v6.accent or _v6.panel
btn.BackgroundTransparency = _v441 and 0 or 1
btn.TextColor3 = _v441 and Color3.fromRGB(255, 255, 255) or _v6.textSub
btn.Font = _v441 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v116()
if not _v358 then
return
end
_v358 = false
if _v55 and _v55.frame == _v159 then
_v55 = nil
end
_v43:Create(_v103, _v1, { Rotation = 0 }):Play()
_v43:Create(_v158, _v1, { Transparency = 0.3 }):Play()
_v43:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v358 then
_v259.Visible = false
end
end)
end
local function _v173()
if _v358 then
return
end
if _v55 and _v55.close then
_v55.close()
end
_v358 = true
_v367()
_v259.Visible = true
_v43:Create(_v103, _v1, { Rotation = 180 }):Play()
_v43:Create(_v158, _v1, { Transparency = 0 }):Play()
_v43:Create(_v259, _v1, { Size = UDim2.new(1, 0, 0, _v262) }):Play()
_v55 = {
frame = _v159,
close = _v116,
contains = function(_v383)
local function _v231(_v336)
local p, s = _v336.AbsolutePosition, _v336.AbsoluteSize
return _v383.X >= p.X and _v383.X <= p.X + s.X and _v383.Y >= p.Y and _v383.Y <= p.Y + s.Y
end
return _v231(_v159) or (_v259.Visible and _v231(_v259))
end,
}
end
for i, _v359 in ipairs(_v362) do
local _v360 = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v259,
Size = UDim2.new(1, 0, 0, _v35),
Position = UDim2.fromOffset(0, (i - 1) * _v35),
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
Text = _v359,
AutoButtonColor = false,
})
_v361[_v359] = _v360
_v360.MouseButton1Click:Connect(function()
_v352(_v359)
_v526.Text = _v359
_v367()
_v116()
end)
_v360.MouseEnter:Connect(function()
if _v359 ~= _v197() then
_v360.BackgroundTransparency = 0
_v360.BackgroundColor3 = _v6.rowHover
_v360.TextColor3 = _v6.text
end
end)
_v360.MouseLeave:Connect(function()
_v367()
end)
end
_v367()
_v159.MouseButton1Click:Connect(function()
if _v358 then
_v116()
else
_v173()
end
end)
_v159.MouseEnter:Connect(function()
if not _v358 then
_v43:Create(_v159, _v1, { BackgroundColor3 = _v6.rowHover }):Play()
end
end)
_v159.MouseLeave:Connect(function()
if not _v358 then
_v43:Create(_v159, _v1, { BackgroundColor3 = _v6.row }):Play()
end
end)
table.insert(_v474, function()
_v526.Text = _v197()
_v367()
end)
end
local function _v270(_v368, title, _v195, _v444)
local h, s, v = _v195():ToHSV()
local _v38, _v21, GAP = 120, 16, 8
local _v218 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, _v38 + 74),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v218, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = _v218,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v207 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v218,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({144,213,146,105,146})),
})
local _v76 = _v316((_V9({149,200,159,107,133})), {
Parent = _v218,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v459 = _v316((_V9({149,200,159,107,133})), {
Parent = _v76,
Size = UDim2.new(1, -(_v21 + GAP), 0, _v38),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v459, CornerRadius = UDim.new(0, 4) })
local _v434 = _v316((_V9({149,200,159,107,133})), {
Parent = _v459,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v434, CornerRadius = UDim.new(0, 4) })
_v316((_V9({134,243,185,116,129,97,146,39,68,167})), {
Parent = _v434,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v525 = _v316((_V9({149,200,159,107,133})), {
Parent = _v459,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v525, CornerRadius = UDim.new(0, 4) })
_v316((_V9({134,243,185,116,129,97,146,39,68,167})), {
Parent = _v525,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v471 = _v316((_V9({149,200,159,107,133})), {
Parent = _v459,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v471, CornerRadius = UDim.new(1, 0) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v471, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v222 = _v316((_V9({149,200,159,107,133})), {
Parent = _v76,
Size = UDim2.fromOffset(_v21, _v38),
Position = UDim2.new(1, -_v21, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v222, CornerRadius = UDim.new(0, 4) })
_v316((_V9({134,243,185,116,129,97,146,39,68,167})), {
Parent = _v222,
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
local _v223 = _v316((_V9({149,200,159,107,133})), {
Parent = _v222,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v223, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v386 = _v316((_V9({149,200,159,107,133})), {
Parent = _v76,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v38 + 6),
BackgroundColor3 = _v195(),
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v386, CornerRadius = UDim.new(0, 4) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v386, Color = _v6.off, Thickness = 1 })
local _v211 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v76,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v38 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v397(_v550)
local _v115 = Color3.fromHSV(h, s, v)
if _v550 ~= false then
_v444(_v115)
end
_v459.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v471.Position = UDim2.new(s, 0, 1 - v, 0)
_v223.Position = UDim2.new(0.5, 0, h, 0)
_v386.BackgroundColor3 = _v115
local r = math.floor(_v115.R * 255 + 0.5)
local g = math.floor(_v115.G * 255 + 0.5)
local b = math.floor(_v115.B * 255 + 0.5)
_v211.Text = string.format((_V9({240,159,206,52,184,32,203,112,114,246,138,204,94,192,37,211,103,78,255,154,219,98,204,37,222,38,3})), r, g, b, r, g, b)
end
_v397(false)
local _v472, hueDrag = false, false
local function _v473(_v393, _v394)
s = math.clamp((_v393 - _v459.AbsolutePosition.X) / _v459.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v394 - _v459.AbsolutePosition.Y) / _v459.AbsoluteSize.Y, 0, 1)
_v397()
end
local function _v224(_v394)
h = math.clamp((_v394 - _v222.AbsolutePosition.Y) / _v222.AbsoluteSize.Y, 0, 1)
_v397()
end
_v459.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v472 = true
_v473(_v230.Position.X, _v230.Position.Y)
end
end)
_v222.InputBegan:Connect(function(_v230)
if _v241(_v230) then
hueDrag = true
_v224(_v230.Position.Y)
end
end)
table.insert(_v297, function(_v230)
if _v472 then
_v473(_v230.Position.X, _v230.Position.Y)
end
if hueDrag then
_v224(_v230.Position.Y)
end
end)
table.insert(_v403, function()
_v472, hueDrag = false, false
end)
table.insert(_v474, function()
h, s, v = _v195():ToHSV()
_v397(false)
end)
end
local function _v547(box, _v249, _v196, _v446, _v120)
local _v263 = false
local function _v397()
if _v263 then
box.Text = (_V9({131,200,155,117,147,231,123,228}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v6.accent
else
box.Text = _v196().Name
box.TextColor3 = _v6.accent
box.BackgroundColor3 = _v6.bar
end
end
local _v101 = {}
function _v101.finish(_v244)
_v263 = false
_v53 = nil
task.defer(function()
_v102 = false
end)
if _v244 then
local _v119 = _v120 and _v120(_v244)
if _v119 then
UI:Notify(string.format((_V9({246,201,222,111,147,37,154,46,88,182,219,154,127,192,103,148,55,68,183,154,138,105,192,32,136})), _v244.Name, _v119), 2.5)
else
_v446(_v244)
UI:Notify(string.format((_V9({246,201,222,100,143,112,149,38,10,167,213,222,35,147})), _v249, _v244.Name), 2)
end
end
_v397()
end
function _v101.cancel()
_v263 = false
_v397()
end
box.MouseButton1Click:Connect(function()
if _v263 then
_v53 = nil
task.defer(function()
_v102 = false
end)
_v101.cancel()
return
end
if _v53 then
_v53.cancel()
end
_v53 = _v101
_v102 = true
_v263 = true
_v397()
end)
box.MouseEnter:Connect(function()
if not _v263 then
box.BackgroundColor3 = _v6.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v263 then
box.BackgroundColor3 = _v6.bar
end
end)
table.insert(_v474, function()
if _v53 == _v101 then
_v53 = nil
task.defer(function()
_v102 = false
end)
_v263 = false
end
_v397()
end)
_v397()
end
local function _v245(_v118, _v244, _v176)
if _v176 ~= (_V9({190,223,144,115})) and _v118.UI.MenuKey == _v244 then
return (_V9({158,223,144,115}))
end
if _v176 ~= (_V9({178,211,147,100,143,113})) and _v118.Camera.ToggleKey == _v244 then
return (_V9({146,211,147,100,143,113}))
end
if _v176 ~= (_V9({182,201,142})) and _v118.ESP.ToggleKey == _v244 then
return (_V9({150,233,174}))
end
if _v176 ~= (_V9({181,213,136,101,137,119,152,46,79})) and _v118.Camera.FOVCircleKey == _v244 then
return (_V9({149,245,168,38,163,108,137,33,70,182}))
end
if _v176 ~= (_V9({189,213,140,99,131,106,146,46})) and _v118.NoRecoil.ToggleKey == _v244 then
return (_V9({157,213,222,84,133,102,148,43,70}))
end
if _v176 ~= (_V9({189,213,141,118,146,96,154,38})) and _v118.NoSpread.ToggleKey == _v244 then
return (_V9({157,213,222,85,144,119,158,35,78}))
end
if _v176 ~= (_V9({167,200,151,97,135,96,137,32,69,167})) and _v118.Triggerbot.ToggleKey == _v244 then
return (_V9({135,200,151,97,135,96,137,32,69,167}))
end
if _v176 ~= (_V9({176,214,151,101,139,113,139})) and _v118.Movement.ClickTPKey == _v244 then
return (_V9({144,214,151,101,139,37,175,18}))
end
if _v176 ~= (_V9({166,212,146,105,129,97})) and _v118.UI.UnloadKey == _v244 then
return (_V9({134,212,146,105,129,97}))
end
return nil
end
local function _v278(_v368, _v249, _v196, _v446, _v120)
local _v218 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v218,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v249,
})
local box = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v218,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -6, 0.5, 0),
Size = UDim2.fromOffset(0, 22),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.accent,
Text = _v196().Name,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v316((_V9({134,243,173,111,154,96,184,45,68,160,206,140,103,137,107,143})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v547(box, _v249, _v196, _v446, _v120)
end
local function _v284(_v368, text, _v197, _v352, _v246, _v196, _v446, _v120)
local btn = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v112 = _v316((_V9({149,200,159,107,133})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v197() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v112, CornerRadius = UDim.new(0, 3) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v112, Color = _v6.border, Thickness = 1 })
local _v248 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v197() and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local box = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = btn,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, 0, 0.5, 0),
Size = UDim2.fromOffset(0, 20),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.accent,
Text = _v196().Name,
ZIndex = 3,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v316((_V9({134,243,173,111,154,96,184,45,68,160,206,140,103,137,107,143})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v397()
local _v351 = _v197()
_v43:Create(_v112, _v1, { BackgroundColor3 = _v351 and _v6.accent or _v6.off }):Play()
_v43:Create(_v248, _v1, { TextColor3 = _v351 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v352()
_v397()
end)
table.insert(_v474, _v397)
_v547(box, _v246, _v196, _v446, _v120)
end
local function _v271(_v368)
local function _v117(order)
local _v115 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = _v115,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v115
end
return _v117(1), _v117(2)
end
local function _v275(_v368, title)
local _v549 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v316((_V9({149,200,159,107,133})), {
Parent = _v549,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = box, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = box,
LayoutOrder = -1,
Size = UDim2.new(1, 0, 0, 15),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title,
})
local _v528 = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v549,
Position = UDim2.fromOffset(0, 0),
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v6.bg,
BackgroundTransparency = 0.45,
BorderSizePixel = 0,
Visible = false,
Active = true,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
ZIndex = 50,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v528, CornerRadius = UDim.new(0, 6) })
local _v39, GAP = 0.72, 1
local _v201 = _v316((_V9({149,200,159,107,133})), {
Parent = _v528,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v6.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
_v316((_V9({134,243,185,116,129,97,146,39,68,167})), {
Parent = _v201,
Rotation = 35,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.000, GAP),
NumberSequenceKeypoint.new(0.119, GAP),
NumberSequenceKeypoint.new(0.120, _v39),
NumberSequenceKeypoint.new(0.199, _v39),
NumberSequenceKeypoint.new(0.200, GAP),
NumberSequenceKeypoint.new(0.319, GAP),
NumberSequenceKeypoint.new(0.320, _v39),
NumberSequenceKeypoint.new(0.399, _v39),
NumberSequenceKeypoint.new(0.400, GAP),
NumberSequenceKeypoint.new(0.519, GAP),
NumberSequenceKeypoint.new(0.520, _v39),
NumberSequenceKeypoint.new(0.599, _v39),
NumberSequenceKeypoint.new(0.600, GAP),
NumberSequenceKeypoint.new(0.719, GAP),
NumberSequenceKeypoint.new(0.720, _v39),
NumberSequenceKeypoint.new(0.799, _v39),
NumberSequenceKeypoint.new(0.800, GAP),
NumberSequenceKeypoint.new(0.919, GAP),
NumberSequenceKeypoint.new(0.920, _v39),
NumberSequenceKeypoint.new(1.000, _v39),
}),
})
local function _v475()
local _v435 = (_v546 and _v546.Scale) or 1
if _v435 <= 0 then
_v435 = 1
end
_v549.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v435)
end
box:GetPropertyChangedSignal((_V9({146,216,141,105,140,112,143,39,121,186,192,155}))):Connect(_v475)
_v475()
local function _v445(_v162)
_v528.Visible = not _v162
end
return box, _v445
end
local function _v281(_v368)
local bar = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v152 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v6.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v69 = _v316((_V9({149,200,159,107,133})), {
Parent = _v368,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v220 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v220.current = name
for n, f in pairs(_v220.frames) do
f.Visible = (n == name)
end
for n, b in pairs(_v220.buttons) do
local _v52 = (n == name)
_v43:Create(b.btn, _v1, { TextColor3 = _v52 and _v6.text or _v6.textSub }):Play()
_v43:Create(b.underline, _v1, { BackgroundTransparency = _v52 and 0 or 1 }):Play()
end
end
function _v220:add(name)
self.order = self.order + 1
local btn = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = bar,
LayoutOrder = self.order,
Size = UDim2.fromOffset(0, 24),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v6.textSub,
Text = name,
})
local underline = _v316((_V9({149,200,159,107,133})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v316((_V9({128,217,140,105,140,105,146,44,77,149,200,159,107,133})), {
Parent = _v69,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = false,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 5,
ScrollBarImageColor3 = _v6.accent,
ScrollBarImageTransparency = 0.25,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v316((_V9({134,243,174,103,132,97,146,44,77})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = btn, underline = underline }
self.frames[name] = frame
btn.MouseButton1Click:Connect(function()
select(name)
end)
btn.MouseEnter:Connect(function()
if _v220.current ~= name then
btn.TextColor3 = _v6.text
end
end)
btn.MouseLeave:Connect(function()
if _v220.current ~= name then
btn.TextColor3 = _v6.textSub
end
end)
if not self.current then
select(name)
end
return frame
end
return _v220
end
local function _v82(_v368, _v118)
_v253 = 0
local _v220 = _v281(_v368)
local _v254, right = _v271(_v220:add((_V9({146,211,147,100,143,113}))))
local _v57 = _v275(_v254, (_V9({146,211,147,100,143,113})))
_v284(_v57, (_V9({150,212,159,100,140,96,159})), function()
return _v118.Camera.Enabled
end, function()
_v118.Camera.Enabled = not _v118.Camera.Enabled
end, (_V9({146,211,147,100,143,113,219,9,79,170})), function()
return _v118.Camera.ToggleKey
end, function(_v244)
_v118.Camera.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({178,211,147,100,143,113})))
end)
_v283(_v57, (_V9({133,211,141,101,136,96,152,41})), function()
return _v118.Camera.WallCheck
end, function()
_v118.Camera.WallCheck = not _v118.Camera.WallCheck
end)
_v283(_v57, (_V9({135,219,140,97,133,113,219,0,69,167,201})), function()
return _v118.Camera.TargetBots
end, function()
_v118.Camera.TargetBots = not _v118.Camera.TargetBots
end)
_v283(_v57, (_V9({135,223,159,107,192,70,147,39,73,184})), function()
return _v118.Camera.TeamCheck
end, function()
_v118.Camera.TeamCheck = not _v118.Camera.TeamCheck
end)
_v284(_v57, (_V9({149,245,168,38,163,108,137,33,70,182})), function()
return _v118.Camera.FOVCircle
end, function()
_v118.Camera.FOVCircle = not _v118.Camera.FOVCircle
end, (_V9({149,245,168,38,163,108,137,33,70,182,154,181,99,153})), function()
return _v118.Camera.FOVCircleKey
end, function(_v244)
_v118.Camera.FOVCircleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({181,213,136,101,137,119,152,46,79})))
end)
_v274(_v57, (_V9({128,215,145,105,148,109,149,39,89,160})), 0.05, 1, function()
return _v118.Camera.Smoothness
end, function(_v524)
_v118.Camera.Smoothness = _v524
end, false)
_v274(_v57, (_V9({149,245,168})), 20, 800, function()
return _v118.Camera.FOV
end, function(_v524)
_v118.Camera.FOV = _v524
end, true, (_V9({163,194})), true)
_v274(_v57, (_V9({158,219,134,38,164,108,136,54,75,189,217,155})), 100, 2000, function()
return _v118.Camera.MaxDistance
end, function(_v524)
_v118.Camera.MaxDistance = _v524
end, true, (_V9({190})), true)
local _v401
local _v217 = _v275(right, (_V9({155,211,138,100,143,125})))
_v273(_v217, _v118.Camera.HitboxOptions, function()
return _v118.Camera.Hitbox
end, function(_v524)
_v118.Camera.Hitbox = _v524
if _v401 then
_v401()
end
end)
local _v544, setWeightsEnabled = _v275(right, (_V9({135,219,140,97,133,113,219,17,79,167,206,151,104,135,118})))
local function _v543(name)
_v274(_v544, name .. (_V9({243,237,155,111,135,109,143})), 0, 100, function()
return _v118.Camera.TargetWeights[name]
end, function(_v524)
_v118.Camera.TargetWeights[name] = _v524
end, true, (_V9({246})), true)
end
_v543((_V9({155,223,159,98})))
_v543((_V9({135,213,140,117,143})))
_v543((_V9({146,200,147,117})))
_v543((_V9({159,223,153,117})))
_v401 = function()
setWeightsEnabled(_v118.Camera.Hitbox == (_V9({129,219,144,98,143,104,219,106,125,182,211,153,110,148,96,159,107})))
end
_v401()
table.insert(_v474, _v401)
local _v510 = _v275(right, (_V9({135,200,151,97,135,96,137,32,69,167})))
_v284(_v510, (_V9({150,212,159,100,140,96,159})), function()
return _v118.Triggerbot.Enabled
end, function()
_v118.Triggerbot.Enabled = not _v118.Triggerbot.Enabled
end, (_V9({135,200,151,97,135,96,137,32,69,167,154,181,99,153})), function()
return _v118.Triggerbot.ToggleKey
end, function(_v244)
_v118.Triggerbot.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({167,200,151,97,135,96,137,32,69,167})))
end)
_v274(_v510, (_V9({158,211,144,38,164,96,151,35,83})), 0, 500, function()
return _v118.Triggerbot.MinDelay * 1000
end, function(_v524)
_v118.Triggerbot.MinDelay = _v524 / 1000
end, true, (_V9({190,201})), true)
_v274(_v510, (_V9({158,219,134,38,164,96,151,35,83})), 0, 500, function()
return _v118.Triggerbot.MaxDelay * 1000
end, function(_v524)
_v118.Triggerbot.MaxDelay = _v524 / 1000
end, true, (_V9({190,201})), true)
_v274(_v510, (_V9({158,219,134,38,164,108,136,54,75,189,217,155})), 100, 2000, function()
return _v118.Triggerbot.MaxDistance
end, function(_v524)
_v118.Triggerbot.MaxDistance = _v524
end, true, (_V9({190})), true)
_v283(_v510, (_V9({133,211,141,101,136,96,152,41})), function()
return _v118.Triggerbot.WallCheck
end, function()
_v118.Triggerbot.WallCheck = not _v118.Triggerbot.WallCheck
end)
local _v453 = _v275(right, (_V9({128,211,146,99,142,113,219,3,67,190})))
_v283(_v453, (_V9({150,212,159,100,140,96,159})), function()
return _v118.SilentAim.Enabled
end, function()
_v118.SilentAim.Enabled = not _v118.SilentAim.Enabled
end)
local _v174 = _v275(right, (_V9({155,211,138,100,143,125,219,7,82,163,219,144,98,133,119})))
_v283(_v174, (_V9({150,212,159,100,140,96,159})), function()
return _v118.Hitbox.Enabled
end, function()
_v118.Hitbox.Enabled = not _v118.Hitbox.Enabled
end)
_v274(_v174, (_V9({128,211,132,99})), 1, 20, function()
return _v118.Hitbox.Size
end, function(_v524)
_v118.Hitbox.Size = _v524
end, true)
_v274(_v174, (_V9({135,200,159,104,147,117,154,48,79,189,217,135})), 0, 1, function()
return _v118.Hitbox.Transparency
end, function(_v524)
_v118.Hitbox.Transparency = _v524
end, false)
_v254, right = _v271(_v220:add((_V9({132,223,159,118,143,107,136}))))
local _v396 = _v275(_v254, (_V9({157,213,222,84,133,102,148,43,70})))
_v284(_v396, (_V9({150,212,159,100,140,96,159})), function()
return _v118.NoRecoil.Enabled
end, function()
_v118.NoRecoil.Enabled = not _v118.NoRecoil.Enabled
end, (_V9({157,213,222,84,133,102,148,43,70,243,241,155,127})), function()
return _v118.NoRecoil.ToggleKey
end, function(_v244)
_v118.NoRecoil.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({189,213,140,99,131,106,146,46})))
end)
_v283(_v396, (_V9({156,212,146,127,192,82,147,43,70,182,154,184,111,146,108,149,37})), function()
return _v118.NoRecoil.RequireMouseDown
end, function()
_v118.NoRecoil.RequireMouseDown = not _v118.NoRecoil.RequireMouseDown
end)
_v283(_v396, (_V9({146,214,146,105,151,37,186,43,71,243,254,145,113,142})), function()
return _v118.NoRecoil.AllowAim
end, function()
_v118.NoRecoil.AllowAim = not _v118.NoRecoil.AllowAim
end)
_v274(_v396, (_V9({128,206,140,99,142,98,143,42})), 0, 100, function()
return _v118.NoRecoil.Strength * 100
end, function(_v524)
_v118.NoRecoil.Strength = _v524 / 100
end, true, (_V9({246})), true)
local _v458 = _v275(_v254, (_V9({157,213,222,85,144,119,158,35,78})))
_v284(_v458, (_V9({150,212,159,100,140,96,159})), function()
return _v118.NoSpread.Enabled
end, function()
_v118.NoSpread.Enabled = not _v118.NoSpread.Enabled
end, (_V9({157,213,222,85,144,119,158,35,78,243,241,155,127})), function()
return _v118.NoSpread.ToggleKey
end, function(_v244)
_v118.NoSpread.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({189,213,141,118,146,96,154,38})))
end)
_v283(_v458, (_V9({156,212,146,127,192,82,147,43,70,182,154,184,111,146,108,149,37})), function()
return _v118.NoSpread.RequireMouseDown
end, function()
_v118.NoSpread.RequireMouseDown = not _v118.NoSpread.RequireMouseDown
end)
_v274(_v458, (_V9({128,206,140,99,142,98,143,42})), 0, 100, function()
return _v118.NoSpread.Strength * 100
end, function(_v524)
_v118.NoSpread.Strength = _v524 / 100
end, true, (_V9({246})), true)
end
local function _v83(_v368, _v118)
_v253 = 0
local _v220 = _v281(_v368)
local _v254, right = _v271(_v220:add((_V9({150,233,174}))))
local _v169 = _v275(_v254, (_V9({150,233,174})))
_v284(_v169, (_V9({150,212,159,100,140,96,159})), function()
return _v118.ESP.Enabled
end, function()
_v118.ESP.Enabled = not _v118.ESP.Enabled
end, (_V9({150,233,174,38,171,96,130})), function()
return _v118.ESP.ToggleKey
end, function(_v244)
_v118.ESP.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({182,201,142})))
end)
_v283(_v169, (_V9({157,234,189,117})), function()
return _v118.ESP.NPCs
end, function()
_v118.ESP.NPCs = not _v118.ESP.NPCs
end)
_v274(_v169, (_V9({158,219,134,38,164,108,136,54,75,189,217,155})), 100, 2000, function()
return _v118.ESP.MaxDistance
end, function(_v524)
_v118.ESP.MaxDistance = _v524
end, true, (_V9({190})), true)
local _v265 = _v275(_v254, (_V9({146,202,142,99,129,119,154,44,73,182})))
_v283(_v265, (_V9({156,207,138,106,137,107,158,49})), function()
return _v118.ESP.Outlines
end, function()
_v118.ESP.Outlines = not _v118.ESP.Outlines
end)
_v283(_v265, (_V9({145,213,134,99,147})), function()
return _v118.ESP.Boxes
end, function()
_v118.ESP.Boxes = not _v118.ESP.Boxes
end)
_v283(_v265, (_V9({157,219,147,99,147})), function()
return _v118.ESP.Names
end, function()
_v118.ESP.Names = not _v118.ESP.Names
end)
_v283(_v265, (_V9({151,211,141,114,129,107,152,39})), function()
return _v118.ESP.Distance
end, function()
_v118.ESP.Distance = not _v118.ESP.Distance
end)
_v283(_v265, (_V9({155,223,159,106,148,109,219,0,75,161,201})), function()
return _v118.ESP.HealthBars
end, function()
_v118.ESP.HealthBars = not _v118.ESP.HealthBars
end)
_v283(_v265, (_V9({149,211,146,106,133,97})), function()
return _v118.ESP.Filled
end, function()
_v118.ESP.Filled = not _v118.ESP.Filled
end)
_v274(_v265, (_V9({156,207,138,106,137,107,158,98,101,163,219,157,111,148,124})), 0, 1, function()
return _v118.ESP.OutlineOpacity
end, function(_v524)
_v118.ESP.OutlineOpacity = _v524
end, false)
_v274(_v265, (_V9({149,211,146,106,192,74,139,35,73,186,206,135})), 0, 1, function()
return _v118.ESP.FillOpacity
end, function(_v524)
_v118.ESP.FillOpacity = _v524
end, false)
local _v156 = _v275(right, (_V9({151,200,159,113,137,107,156,98,111,128,234})))
_v283(_v156, (_V9({145,213,134,99,147})), function()
return _v118.Drawing.Boxes
end, function()
_v118.Drawing.Boxes = not _v118.Drawing.Boxes
end)
_v283(_v156, (_V9({135,200,159,101,133,119,136})), function()
return _v118.Drawing.Tracers
end, function()
_v118.Drawing.Tracers = not _v118.Drawing.Tracers
end)
local _v548 = _v275(right, (_V9({132,213,140,106,132})))
_v283(_v548, (_V9({149,207,146,106,130,119,146,37,66,167})), function()
return _v118.Visuals.Fullbright
end, function()
_v118.Visuals.Fullbright = not _v118.Visuals.Fullbright
end)
_v283(_v548, (_V9({157,213,222,64,143,98})), function()
return _v118.Visuals.NoFog
end, function()
_v118.Visuals.NoFog = not _v118.Visuals.NoFog
end)
_v254, right = _v271(_v220:add((_V9({144,213,146,105,146,118}))))
_v270(_v254, (_V9({156,207,138,106,137,107,158,98,105,188,214,145,116})), function()
return _v118.ESP.OutlineColor
end, function(c)
_v118.ESP.OutlineColor = c
end)
_v270(right, (_V9({149,211,146,106,192,70,148,46,69,161})), function()
return _v118.ESP.FillColor
end, function(c)
_v118.ESP.FillColor = c
end)
_v270(_v254, (_V9({145,213,134,38,163,106,151,45,88})), function()
return _v118.Drawing.BoxColor
end, function(c)
_v118.Drawing.BoxColor = c
end)
_v270(right, (_V9({135,200,159,101,133,119,219,1,69,191,213,140})), function()
return _v118.Drawing.TracerColor
end, function(c)
_v118.Drawing.TracerColor = c
end)
end
local function _v88(_v368, _v118)
_v253 = 0
local _v220 = _v281(_v368)
local _v254, right = _v271(_v220:add((_V9({158,213,136,99,141,96,149,54}))))
local _v180 = _v275(_v254, (_V9({149,214,135})))
_v283(_v180, (_V9({150,212,159,100,140,96,159})), function()
return _v118.Movement.FlyEnabled
end, function()
_v118.Movement.FlyEnabled = not _v118.Movement.FlyEnabled
end)
_v274(_v180, (_V9({149,214,135,38,179,117,158,39,78})), 10, 200, function()
return _v118.Movement.FlySpeed
end, function(_v524)
_v118.Movement.FlySpeed = _v524
end, true)
local _v457 = _v275(_v254, (_V9({128,202,155,99,132})))
_v283(_v457, (_V9({150,212,159,100,140,96,159})), function()
return _v118.Movement.SpeedEnabled
end, function()
_v118.Movement.SpeedEnabled = not _v118.Movement.SpeedEnabled
end)
_v274(_v457, (_V9({128,202,155,99,132})), 16, 100, function()
return _v118.Movement.Speed
end, function(_v524)
_v118.Movement.Speed = _v524
end, true)
local _v291 = _v275(_v254, (_V9({156,206,150,99,146})))
_v283(_v291, (_V9({157,213,157,106,137,117})), function()
return _v118.Movement.NoclipEnabled
end, function()
_v118.Movement.NoclipEnabled = not _v118.Movement.NoclipEnabled
end)
_v283(_v291, (_V9({154,212,152,111,142,108,143,39,10,153,207,147,118})), function()
return _v118.Movement.InfJumpEnabled
end, function()
_v118.Movement.InfJumpEnabled = not _v118.Movement.InfJumpEnabled
end)
local _v508 = _v275(right, (_V9({144,214,151,101,139,37,175,18})))
_v283(_v508, (_V9({150,212,159,100,140,96,159})), function()
return _v118.Movement.ClickTPEnabled
end, function()
_v118.Movement.ClickTPEnabled = not _v118.Movement.ClickTPEnabled
end)
_v278(_v508, (_V9({158,213,154,111,134,108,158,48,10,152,223,135})), function()
return _v118.Movement.ClickTPKey
end, function(_v244)
_v118.Movement.ClickTPKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({176,214,151,101,139,113,139})))
end)
end
local function _v89(_v368, _v118)
_v253 = 0
local _v220 = _v281(_v368)
local _v254, right = _v271(_v220:add((_V9({131,214,159,127,133,119,136}))))
local _v260 = _v275(_v254, (_V9({131,214,159,127,133,119,219,14,67,160,206})))
_v380 = _v316((_V9({128,217,140,105,140,105,146,44,77,149,200,159,107,133})), {
Parent = _v260,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 230),
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 0.5,
BorderSizePixel = 0,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v6.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v380, CornerRadius = UDim.new(0, 6) })
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = _v380,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = _v380,
PaddingTop = UDim.new(0, 4),
PaddingBottom = UDim.new(0, 4),
PaddingLeft = UDim.new(0, 4),
PaddingRight = UDim.new(0, 4),
})
local function _v399()
for _v378, row in pairs(_v381) do
row.btn.BackgroundColor3 = (_v378 == _v443) and _v6.accent or _v6.row
end
end
local function _v398()
if not _v380 then
return
end
for _, _v113 in ipairs(_v380:GetChildren()) do
if not _v113:IsA((_V9({134,243,178,111,147,113,183,35,83,188,207,138}))) then
_v113:Destroy()
end
end
table.clear(_v381)
local _v125 = 0
for _, _v378 in ipairs(_v31:GetPlayers()) do
if _v378 ~= _v26 then
_v125 = _v125 + 1
local row = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v380,
LayoutOrder = _v125,
Size = UDim2.new(1, 0, 0, 24),
BackgroundColor3 = (_v378 == _v443) and _v6.accent or _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = row, CornerRadius = UDim.new(0, 4) })
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = row,
Size = UDim2.new(0.65, -8, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v378.TeamColor.Color,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v378.Name,
})
local dist = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = row,
Size = UDim2.new(0.35, -8, 1, 0),
Position = UDim2.new(0.65, 0, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = (_V9({49,58,106})),
})
row.MouseButton1Click:Connect(function()
_v443 = (_v443 == _v378) and nil or _v378
_v399()
end)
_v381[_v378] = { btn = row, dist = dist }
end
end
if _v125 == 0 then
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v380,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({243,154,144,105,192,106,143,42,79,161,154,142,106,129,124,158,48,89})),
})
end
end
local _v51 = _v275(right, (_V9({146,217,138,111,143,107,136})))
local _v442 = _v279(_v51, (_V9({128,223,146,99,131,113,158,38})), (_V9({49,58,106})))
_v269(_v51, (_V9({135,223,146,99,144,106,137,54,10,135,213})), function()
local _v110 = _v443 and _v443.Character
local root = _v110 and _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
if root and UI.TeleportTo then
UI.TeleportTo(root.Position)
end
end)
_v455 = _v269(_v51, (_V9({128,202,155,101,148,100,143,39})), function()
if _v456 then
_v466()
elseif _v443 then
_v464(_v443)
end
end)
table.insert(_v474, function()
_v442.Text = _v443 and _v443.Name or (_V9({49,58,106}))
_v399()
end)
_v398()
table.insert(_v513, _v31.PlayerAdded:Connect(function()
_v398()
end))
table.insert(_v513, _v31.PlayerRemoving:Connect(function(_v378)
if _v378 == _v443 then
_v443 = nil
end
if _v378 == _v456 then
_v466()
end
_v398()
end))
local _v251 = 0
table.insert(_v513, _v36.RenderStepped:Connect(function()
if os.clock() - _v251 < 0.5 then
return
end
_v251 = os.clock()
_v442.Text = _v443 and _v443.Name or (_V9({49,58,106}))
local _v308 = _v26.Character
local _v309 = _v308 and _v308:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
for _v378, row in pairs(_v381) do
local _v110 = _v378.Character
local root = _v110 and _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
row.dist.Text = (_v309 and root)
and (math.floor((root.Position - _v309.Position).Magnitude + 0.5) .. (_V9({190})))
or (_V9({49,58,106}))
end
if _v456 then
if _v54 and _v54.Movement and _v54.Movement.FlyEnabled then
_v466()
else
local _v110 = _v456.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
local _v93 = _v48.CurrentCamera
if humanoid and humanoid.Health > 0 and _v93 then
_v93.CameraSubject = humanoid
else
_v466()
end
end
end
end))
end
local function _v87(_v368, _v118)
_v253 = 0
local _v220 = _v281(_v368)
local _v254, right = _v271(_v220:add((_V9({128,223,141,117,137,106,149}))))
local _v50 = _v275(_v254, (_V9({146,217,157,105,149,107,143})))
_v279(_v50, (_V9({134,201,155,116,142,100,150,39})), _v26 and _v26.Name or (_V9({49,58,106})))
_v279(_v50, (_V9({151,211,141,118,140,100,130,98,100,178,215,155})), _v26 and _v26.DisplayName or (_V9({49,58,106})))
_v279(_v50, (_V9({134,201,155,116,192,76,191})), _v26 and tostring(_v26.UserId) or (_V9({49,58,106})))
_v269(_v50, (_V9({128,223,140,112,133,119,219,10,69,163})), function()
_v45:ServerHop()
end)
_v269(_v50, (_V9({129,223,148,105,137,107,219,17,79,161,204,155,116})), function()
_v45:Rejoin()
end)
local _v542 = _v275(right, (_V9({132,223,156,110,143,106,144})))
local _v523 = _v282(_v542, (_V9({164,223,156,110,143,106,144,98,95,161,214,28,134,70})))
_v523.Text = _v118.Webhook.Url
_v523.FocusLost:Connect(function()
_v118.Webhook.Url = _v523.Text
end)
_v269(_v542, (_V9({128,223,144,98,192,81,158,49,94,243,237,155,100,136,106,148,41})), function()
local _v338, res = _v47.SendWebhook((_V9({133,219,144,111,148,124,214,5,79,189,223,140,103,140,37,143,39,89,167,154,137,99,130,109,148,45,65})))
if _v338 then
UI:Notify((_V9({135,223,141,114,192,114,158,32,66,188,213,149,38,147,96,149,54})), 2)
else
UI:Notify((_V9({132,223,156,110,143,106,144,98,76,178,211,146,99,132,63,219})) .. tostring(res), 3)
end
end)
end
local function _v90(_v368, _v118)
_v253 = 0
local _v220 = _v281(_v368)
local _v254, right = _v271(_v220:add((_V9({148,223,144,99,146,100,151}))))
local _v227 = _v275(_v254, (_V9({154,212,138,99,146,99,154,33,79})))
_v274(_v227, (_V9({134,243,222,85,131,100,151,39})), 0.8, 1.5, function()
return _v118.UI.Scale
end, function(_v524)
_v118.UI.Scale = _v524
if _v546 then
_v546.Scale = _v524
end
end, false)
_v283(_v227, (_V9({152,223,135,100,137,107,159,98,122,178,212,155,106})), function()
return _v118.UI.KeybindPanel
end, function()
_v118.UI.KeybindPanel = not _v118.UI.KeybindPanel
if _v247 then
_v247.Visible = _v118.UI.KeybindPanel
end
end)
_v283(_v227, (_V9({135,219,140,97,133,113,219,6,67,160,202,146,103,153})), function()
return _v118.UI.TargetDisplay
end, function()
_v118.UI.TargetDisplay = not _v118.UI.TargetDisplay
_v484 = _v118.UI.TargetDisplay
if not _v484 and _v485 then
_v485.Visible = false
end
end)
_v283(_v227, (_V9({149,234,173,38,163,106,142,44,94,182,200})), function()
return _v118.UI.FPSCounter
end, function()
_v118.UI.FPSCounter = not _v118.UI.FPSCounter
if _v188 then
_v188.Visible = _v118.UI.FPSCounter
end
end)
_v283(_v227, (_V9({132,219,138,99,146,104,154,48,65})), function()
return _v118.UI.Watermark
end, function()
_v118.UI.Watermark = not _v118.UI.Watermark
if _v541 then
_v541.Visible = _v118.UI.Watermark
end
end)
_v270(_v227, (_V9({146,217,157,99,142,113,219,1,69,191,213,140})), function()
return _v118.UI.Accent
end, function(_v314)
_v67(_v314)
end)
table.insert(_v474, function()
if _v118.UI.Accent then
_v67(_v118.UI.Accent)
end
end)
_v254, right = _v271(_v220:add((_V9({144,213,144,96,137,98,136}))))
local _v107 = _v275(_v254, (_V9({144,213,144,96,137,98,136})))
if not _v11.isSupported() then
_v279(_v107, (_V9({128,206,159,114,149,118})), (_V9({134,212,141,115,144,117,148,48,94,182,222})))
return
end
local _v311 = _v282(_v107, (_V9({176,213,144,96,137,98,219,44,75,190,223,28,134,70})))
local _v261 = _v316((_V9({149,200,159,107,133})), {
Parent = _v107,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = _v261,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v398
local function _v440(name)
_v311.Text = name
_v398()
end
_v398 = function()
for _, _v113 in ipairs(_v261:GetChildren()) do
if not _v113:IsA((_V9({134,243,178,111,147,113,183,35,83,188,207,138}))) then
_v113:Destroy()
end
end
local _v313 = _v11.list()
if #_v313 == 0 then
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v261,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({189,213,222,117,129,115,158,38,10,176,213,144,96,137,98,136})),
})
return
end
for i, name in ipairs(_v313) do
local _v441 = (_v311.Text == name)
local row = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v261,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v441 and _v6.accent or _v6.row,
BackgroundTransparency = _v441 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v441 and Color3.fromRGB(255, 255, 255) or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({243,154})) .. name,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v440(name)
end)
row.MouseEnter:Connect(function()
if _v311.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v6.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v311.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v6.row
end
end)
end
end
_v269(_v107, (_V9({128,219,136,99})), function()
local _v338, res = _v11.save(_v311.Text, _v118)
if _v338 then
UI:Notify((_V9({128,219,136,99,132,37,152,45,68,181,211,153,38,199})) .. res .. (_V9({244})), 2)
_v398()
else
UI:Notify(tostring(res), 3)
end
end)
_v269(_v107, (_V9({159,213,159,98})), function()
local _v338, res = _v11.load(_v311.Text, _v118)
if _v338 then
if _v546 then
_v546.Scale = _v118.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({159,213,159,98,133,97,219,33,69,189,220,151,97,192,34})) .. res .. (_V9({244})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v269(_v107, (_V9({151,223,146,99,148,96})), function()
local _v338, res = _v11.delete(_v311.Text)
if _v338 then
UI:Notify((_V9({151,223,146,99,148,96,159,98,73,188,212,152,111,135,37,220})) .. res .. (_V9({244})), 2)
_v311.Text = (_V9({}))
_v398()
else
UI:Notify(tostring(res), 3)
end
end, _v6.danger)
_v398()
end
local function _v91(_v118)
_v485 = _v316((_V9({149,200,159,107,133})), {
Parent = _v200,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v485, CornerRadius = UDim.new(0, 6) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v485, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = _v485,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = _v485,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v153 = _v316((_V9({149,200,159,107,133})), {
Parent = _v485,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v485,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({})),
})
local _v155, _v154, _v463
_v485.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v155 = true
_v154 = _v230.Position
_v463 = _v485.Position
end
end)
table.insert(_v297, function(_v230)
if _v155 and _v485 then
local delta = _v230.Position - _v154
_v485.Position = UDim2.new(
_v463.X.Scale,
_v463.X.Offset + delta.X,
_v463.Y.Scale,
_v463.Y.Offset + delta.Y
)
end
end)
table.insert(_v403, function()
_v155 = false
end)
table.insert(_v474, function()
_v484 = _v118.UI.TargetDisplay
if not _v484 and _v485 then
_v485.Visible = false
end
end)
_v484 = _v118.UI.TargetDisplay
end
local function _v85(_v118)
_v188 = _v316((_V9({149,200,159,107,133})), {
Parent = _v200,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v188, CornerRadius = UDim.new(0, 6) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v188, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = _v188,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = _v188,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v153 = _v316((_V9({149,200,159,107,133})), {
Parent = _v188,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v188,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({254,151,222,96,144,118})),
})
table.insert(_v474, function()
if _v188 then
_v188.Visible = _v118.UI.FPSCounter
end
end)
_v188.Visible = _v118.UI.FPSCounter
end
local function _v92(_v118)
_v541 = _v316((_V9({154,215,159,97,133,73,154,32,79,191})), {
Parent = _v200,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 14, 1, -14),
Size = UDim2.fromOffset(180, 64),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Fit,
Image = (_V9({})),
Visible = false,
})
UI:SetWatermarkImage(_v118.UI.WatermarkImageId)
table.insert(_v474, function()
if _v541 then
_v541.Visible = _v118.UI.Watermark
end
end)
_v541.Visible = _v118.UI.Watermark
end
local function _v86(_v118)
_v253 = 0
_v247 = _v316((_V9({149,200,159,107,133})), {
Parent = _v200,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
Visible = false,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v247, CornerRadius = UDim.new(0, 8) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v247, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), {
Parent = _v247,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = _v247,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v316((_V9({149,200,159,107,133})), {
Parent = _v247,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({152,223,135,100,137,107,159,49})),
})
local _v155, _v154, _v463
bar.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v155 = true
_v154 = _v230.Position
_v463 = _v247.Position
end
end)
table.insert(_v297, function(_v230)
if _v155 and _v247 then
local delta = _v230.Position - _v154
_v247.Position = UDim2.new(
_v463.X.Scale,
_v463.X.Offset + delta.X,
_v463.Y.Scale,
_v463.Y.Offset + delta.Y
)
end
end)
table.insert(_v403, function()
_v155 = false
end)
_v278(_v247, (_V9({158,223,144,115})), function()
return _v118.UI.MenuKey
end, function(_v244)
_v118.UI.MenuKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({190,223,144,115})))
end)
_v278(_v247, (_V9({146,211,147,100,143,113})), function()
return _v118.Camera.ToggleKey
end, function(_v244)
_v118.Camera.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({178,211,147,100,143,113})))
end)
_v278(_v247, (_V9({150,233,174})), function()
return _v118.ESP.ToggleKey
end, function(_v244)
_v118.ESP.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({182,201,142})))
end)
_v278(_v247, (_V9({149,245,168,38,163,108,137,33,70,182})), function()
return _v118.Camera.FOVCircleKey
end, function(_v244)
_v118.Camera.FOVCircleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({181,213,136,101,137,119,152,46,79})))
end)
_v278(_v247, (_V9({157,213,222,84,133,102,148,43,70})), function()
return _v118.NoRecoil.ToggleKey
end, function(_v244)
_v118.NoRecoil.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({189,213,140,99,131,106,146,46})))
end)
_v278(_v247, (_V9({157,213,222,85,144,119,158,35,78})), function()
return _v118.NoSpread.ToggleKey
end, function(_v244)
_v118.NoSpread.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({189,213,141,118,146,96,154,38})))
end)
_v278(_v247, (_V9({135,200,151,97,135,96,137,32,69,167})), function()
return _v118.Triggerbot.ToggleKey
end, function(_v244)
_v118.Triggerbot.ToggleKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({167,200,151,97,135,96,137,32,69,167})))
end)
_v278(_v247, (_V9({134,212,146,105,129,97})), function()
return _v118.UI.UnloadKey
end, function(_v244)
_v118.UI.UnloadKey = _v244
end, function(_v244)
return _v245(_v118, _v244, (_V9({166,212,146,105,129,97})))
end)
table.insert(_v474, function()
if _v247 then
_v247.Visible = _v118.UI.KeybindPanel
end
end)
_v247.Visible = _v118.UI.KeybindPanel
end
local function _v448(_v465)
if not _v268 or _v465 == _v530 then
return
end
_v530 = _v465
if _v54 and _v54.UI then
_v54.UI.Visible = _v465
end
if _v465 then
_v268.Visible = true
_v268.GroupTransparency = 1
_v43:Create(_v268, TweenInfo.new(_v17), { GroupTransparency = 0 }):Play()
else
local _v512 = _v43:Create(_v268, TweenInfo.new(_v17), { GroupTransparency = 1 })
_v512.Completed:Once(function()
if not _v530 and _v268 then
_v268.Visible = false
end
end)
_v512:Play()
end
end
function UI:Init(_v118, _v356)
if _v200 then
return
end
_v54 = _v118
_v357 = _v356
if _v118.UI.Accent then
_v6.accent = _v118.UI.Accent
end
_v462()
_v200 = _v316((_V9({128,217,140,99,133,107,188,55,67})), {
Name = _v10.RandomName(),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v338 = pcall(function()
_v200.Parent = _v45.getGuiParent()
end)
if not _v338 or not _v200.Parent then
_v200.Parent = _v26:WaitForChild((_V9({131,214,159,127,133,119,188,55,67})))
end
_v10.Protect(_v200)
_v268 = _v316((_V9({144,219,144,112,129,118,188,48,69,166,202})), {
Parent = _v200,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v546 = _v316((_V9({134,243,173,101,129,105,158})), { Parent = _v268, Scale = _v118.UI.Scale })
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v268, CornerRadius = UDim.new(0, 8) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v268, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
local _v499 = _v316((_V9({149,200,159,107,133})), {
Parent = _v268,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v499, CornerRadius = UDim.new(0, 8) })
_v316((_V9({149,200,159,107,133})), {
Parent = _v499,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
local _v153 = _v316((_V9({149,200,159,107,133})), {
Parent = _v499,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v499,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({133,219,144,111,148,124,199,36,69,189,206,222,101,143,105,148,48,23,241,153,198,50,211,64,185,7,8,237,148,154,99,150,57,212,36,69,189,206,192,38,167,96,149,39,88,178,214}))
.. (_V9({239,220,145,104,148,37,152,45,70,188,200,195,36,195,61,186,117,105,146,138,220,56,192,37,219,128,157,243,154,222,112,208,57,212,36,69,189,206,192})),
ZIndex = 2,
})
_v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v499,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.new(0, 140, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v26 and _v26.Name or (_V9({})),
ZIndex = 2,
})
local _v155, _v154, _v463
_v499.InputBegan:Connect(function(_v230)
if _v241(_v230) then
_v155 = true
_v154 = _v230.Position
_v463 = _v268.Position
end
end)
table.insert(_v297, function(_v230)
if _v155 then
local delta = _v230.Position - _v154
_v268.Position = UDim2.new(
_v463.X.Scale,
_v463.X.Offset + delta.X,
_v463.Y.Scale,
_v463.Y.Offset + delta.Y
)
end
end)
table.insert(_v403, function()
_v155 = false
end)
local _v452 = _v316((_V9({149,200,159,107,133})), {
Parent = _v268,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v452, CornerRadius = UDim.new(0, 6) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v452, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = _v452,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v480 = _v316((_V9({149,200,159,107,133})), {
Parent = _v452,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({134,243,178,111,147,113,183,35,83,188,207,138})), { Parent = _v480, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v515 = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v452,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.danger,
Text = (_V9({134,212,146,105,129,97})),
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v515, CornerRadius = UDim.new(0, 6) })
local _v516 = _v316((_V9({134,243,173,114,146,106,144,39})), {
Parent = _v515,
Color = _v6.danger,
Thickness = 1,
Transparency = 0.55,
})
_v515.MouseButton1Click:Connect(function()
if _v357 then
_v357()
end
end)
_v515.MouseEnter:Connect(function()
_v43:Create(_v515, _v1, {
BackgroundColor3 = _v6.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v43:Create(_v516, _v1, { Transparency = 0 }):Play()
end)
_v515.MouseLeave:Connect(function()
_v43:Create(_v515, _v1, {
BackgroundColor3 = _v6.row,
TextColor3 = _v6.danger,
}):Play()
_v43:Create(_v516, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v316((_V9({149,200,159,107,133})), {
Parent = _v268,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v316((_V9({134,243,174,103,132,97,146,44,77})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v482 = { (_V9({144,213,147,100,129,113})), (_V9({133,211,141,115,129,105})), (_V9({158,213,136,99,141,96,149,54})), (_V9({131,214,159,127,133,119,136})), (_V9({158,211,141,101})), (_V9({128,223,138,114,137,107,156,49})) }
local _v479 = {}
for i, _v481 in ipairs(_v482) do
local _v234 = _v126 == _v481
local _v477 = _v316((_V9({135,223,134,114,162,112,143,54,69,189})), {
Parent = _v480,
LayoutOrder = i,
Size = UDim2.new(1, 0, 1 / #_v482, -6),
BackgroundColor3 = _v6.rowHover,
BackgroundTransparency = _v234 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v234 and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({243,154,222,38})) .. _v481,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v477, CornerRadius = UDim.new(0, 6) })
local stripe = _v316((_V9({149,200,159,107,133})), {
Parent = _v477,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
Visible = _v234,
ZIndex = 2,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v478 = _v316((_V9({149,200,159,107,133})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v234,
})
_v479[_v481] = { btn = _v477, frame = _v478, stripe = stripe }
_v477.MouseButton1Click:Connect(function()
_v126 = _v481
for name, _v476 in pairs(_v479) do
local _v52 = name == _v481
_v476.frame.Visible = _v52
_v476.stripe.Visible = _v52
_v43:Create(_v476.btn, _v1, {
BackgroundTransparency = _v52 and 0 or 1,
TextColor3 = _v52 and _v6.text or _v6.textSub,
}):Play()
end
end)
_v477.MouseEnter:Connect(function()
if _v126 ~= _v481 then
_v43:Create(_v477, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v477.MouseLeave:Connect(function()
if _v126 ~= _v481 then
_v43:Create(_v477, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v82(_v479[(_V9({144,213,147,100,129,113}))].frame, _v118)
_v83(_v479[(_V9({133,211,141,115,129,105}))].frame, _v118)
_v88(_v479[(_V9({158,213,136,99,141,96,149,54}))].frame, _v118)
_v89(_v479[(_V9({131,214,159,127,133,119,136}))].frame, _v118)
_v87(_v479[(_V9({158,211,141,101}))].frame, _v118)
_v90(_v479[(_V9({128,223,138,114,137,107,156,49}))].frame, _v118)
_v86(_v118)
_v91(_v118)
_v85(_v118)
_v92(_v118)
if _v118.UI.Visible then
_v448(true)
end
end
function UI:Toggle()
_v448(not _v530)
end
function UI:Show()
_v448(true)
end
function UI:Hide()
_v448(false)
end
function UI:SetCurrentTarget(name)
if not _v485 then
return
end
if _v485.Visible ~= _v484 then
_v485.Visible = _v484
end
if not _v484 or not targetPanelLabel then
return
end
local _v451, colour
if name and name ~= (_V9({})) and name ~= (_V9({157,213,144,99})) then
_v451, colour = name, (_V9({240,130,202,53,165,71,190}))
else
_v451, colour = (_V9({134,212,181,104,143,114,149})), (_V9({240,130,191,49,163,68,203}))
end
local text = (_V9({135,219,140,97,133,113,193,98,22,181,213,144,114,192,102,148,46,69,161,135,220})) .. colour .. (_V9({241,132})) .. _v451 .. (_V9({239,149,152,105,142,113,197}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v186)
if not fpsLabel or not _v188 or not _v188.Visible then
return
end
local text = string.format((_V9({239,220,145,104,148,37,152,45,70,188,200,195,36,195,61,207,113,111,145,255,220,56,197,97,199,109,76,188,212,138,56,192,99,139,49})), _v186 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v226)
if not _v541 then
return
end
local _v146 = tostring(_v226 or (_V9({}))):match((_V9({246,222,213})))
_v541.Image = _v146 and ((_V9({161,216,134,103,147,118,158,54,67,183,128,209,41})) .. _v146) or (_V9({}))
end
function UI:SyncControls()
for _, _v182 in ipairs(_v474) do
_v182()
end
end
function UI:IsCapturingKey()
return _v102
end
function UI:Notify(text, _v161)
if not _v200 then
return
end
_v161 = _v161 or 3
local _v501 = _v316((_V9({135,223,134,114,172,100,153,39,70})), {
Parent = _v200,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 12),
Size = UDim2.fromOffset(math.max(200, #text * 8 + 28), 34),
BackgroundColor3 = _v6.bar,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v6.text,
Text = text,
})
_v316((_V9({134,243,189,105,146,107,158,48})), { Parent = _v501, CornerRadius = UDim.new(0, 8) })
_v316((_V9({134,243,173,114,146,106,144,39})), { Parent = _v501, Color = _v6.accent, Thickness = 1, Transparency = 0.3 })
_v43:Create(_v501, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v161, function()
if _v501 and _v501.Parent then
local _v366 = _v43:Create(_v501, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v366.Completed:Once(function()
if _v501 then
_v501:Destroy()
end
end)
_v366:Play()
end
end)
end
function UI:Cleanup()
_v466()
_v443 = nil
_v455 = nil
_v380 = nil
table.clear(_v381)
for _, _v121 in ipairs(_v513) do
_v121:Disconnect()
end
table.clear(_v513)
table.clear(_v297)
table.clear(_v403)
table.clear(_v474)
_v53 = nil
_v102 = false
_v55 = nil
_v485, targetPanelLabel = nil, nil
_v484 = false
_v247 = nil
_v541 = nil
_v188, fpsLabel = nil, nil
_v546 = nil
if _v200 then
_v200:Destroy()
_v200 = nil
_v268 = nil
end
_v530 = false
end
return UI
end)()
Movement = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v44 = game:GetService((_V9({134,201,155,116,169,107,139,55,94,128,223,140,112,137,102,158})))
local _v48 = game:GetService((_V9({132,213,140,109,147,117,154,33,79})))
local _v26 = _v31.LocalPlayer
local UI = UI
local Movement = {}
local _v5 = 16
local _v23 = 50
local _v303
local _v301
local _v307 = 0
local function _v300()
local _v110 = _v26.Character
local root = _v110 and _v110:FindFirstChild((_V9({155,207,147,103,142,106,146,38,120,188,213,138,86,129,119,143})))
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({155,207,147,103,142,106,146,38})))
if not (_v110 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v110, root, humanoid
end
local function _v302(_v93)
local _v265 = _v93.CFrame.LookVector
local _v178 = Vector3.new(_v265.X, 0, _v265.Z)
if _v178.Magnitude < 0.001 then
_v178 = Vector3.new(0, 0, -1)
else
_v178 = _v178.Unit
end
local right = _v93.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v296 = Vector3.zero
if _v44:IsKeyDown(Enum.KeyCode.W) then
_v296 = _v296 + _v178
end
if _v44:IsKeyDown(Enum.KeyCode.S) then
_v296 = _v296 - _v178
end
if _v44:IsKeyDown(Enum.KeyCode.D) then
_v296 = _v296 + right
end
if _v44:IsKeyDown(Enum.KeyCode.A) then
_v296 = _v296 - right
end
if _v44:IsKeyDown(Enum.KeyCode.Space) then
_v296 = _v296 + Vector3.yAxis
end
if _v44:IsKeyDown(Enum.KeyCode.LeftShift) then
_v296 = _v296 - Vector3.yAxis
end
if _v296.Magnitude > 0 then
return _v296.Unit
end
return nil
end
local _v29 = 0.1
local _v30 = 0.15
local function _v306()
return (os.clock() % (_v29 + _v30)) < _v29
end
function Movement:Update(_v160, _v118)
local _v110, root, humanoid = _v300()
if _v118.NoclipEnabled and _v110 then
local _v319 = _v110:GetDescendants()
for i = 1, #_v319 do
local part = _v319[i]
if part:IsA((_V9({145,219,141,99,176,100,137,54}))) then
part.CanCollide = false
end
end
end
if not root then
return
end
if _v118.FlyEnabled then
local _v93 = _v48.CurrentCamera
if _v93 then
local _v529 = Vector3.zero
if not UI:IsCapturingKey() then
local _v147 = _v302(_v93)
if _v147 then
local _v457 = _v118.FlySpeed or 50
if not _v306() then
_v457 = math.min(_v457, _v5)
end
_v529 = _v147 * _v457
end
end
root.AssemblyLinearVelocity = _v529
end
return
end
if _v118.SpeedEnabled then
local _v457 = _v118.Speed or _v5
local _v296 = humanoid.MoveDirection
if _v457 > _v5 and _v296.Magnitude > 0 and _v306() then
local _v529 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v296.X * _v457, _v529.Y, _v296.Z * _v457)
end
end
end
local function _v305(_v118)
if not _v118.InfJumpEnabled then
return
end
local _, root = _v300()
if root then
local _v529 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v529.X, _v23, _v529.Z)
end
end
local _v41 = 10
local _v40 = 0.05
function Movement.TeleportTo(_v384)
local _v142 = _v384 + Vector3.new(0, 3, 0)
_v307 = _v307 + 1
local _v503 = _v307
task.spawn(function()
while _v503 == _v307 do
local _, currentRoot = _v300()
if not currentRoot then
return
end
local _v337 = _v142 - currentRoot.CFrame.Position
if _v337.Magnitude <= _v41 then
currentRoot.CFrame = CFrame.new(_v142)
return
end
currentRoot.CFrame = currentRoot.CFrame + _v337.Unit * _v41
task.wait(_v40)
end
end)
end
local function _v304(_v118, _v230, _v193)
if _v193 or UI:IsCapturingKey() then
return
end
if not _v118.ClickTPEnabled then
return
end
if _v230.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v44:IsKeyDown(_v118.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _v295 = _v26:GetMouse()
if _v295 and _v295.Hit then
Movement.TeleportTo(_v295.Hit.Position)
end
end
function Movement:Init(_v118)
if not _v303 then
_v303 = _v44.JumpRequest:Connect(function()
_v305(_v118)
end)
end
if not _v301 then
_v301 = _v44.InputBegan:Connect(function(_v230, _v193)
_v304(_v118, _v230, _v193)
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
_v13 = (function()
local _v31 = game:GetService((_V9({131,214,159,127,133,119,136})))
local _v36 = game:GetService((_V9({129,207,144,85,133,119,141,43,73,182})))
local _v44 = game:GetService((_V9({134,201,155,116,169,107,139,55,94,128,223,140,112,137,102,158})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v11 = _v11
local _v9 = _v9
local _v8 = _v8
local _v22 = Hitbox
local SilentAim = SilentAim
local NoRecoil = NoRecoil
local NoSpread = NoSpread
local Triggerbot = Triggerbot
local ESP = ESP
local _v16 = _v16
local Visuals = Visuals
local _v45 = _v45
local UI = UI
local Movement = Movement
local _v47 = _v47
local _v10 = _v10
local _v13 = {}
_v13.Version = (_V9({226,148,206,40,208}))
_v13.Config = _v12
UI.TeleportTo = Movement.TeleportTo
_v47.Version = _v13.Version
local _v420 = false
local _v122 = {}
local _v61 = false
local _v32 = _v10.RandomName()
local _v198 = {}
local _v20 = 5
local function _v199(name, _v182, ...)
local _v338, res = pcall(_v182, ...)
if _v338 then
local _v461 = _v198[name]
if _v461 then
_v461.failures = 0
end
return true, res
end
local _v461 = _v198[name]
if not _v461 then
_v461 = { failures = 0, lastWarn = -math.huge }
_v198[name] = _v461
end
_v461.failures = _v461.failures + 1
local _v321 = os.clock()
if _v321 - _v461.lastWarn >= _v20 then
_v461.lastWarn = _v321
warn(string.format((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,15,160,154,152,103,137,105,158,38,10,251,194,219,98,201,63,219,103,89})), name, _v461.failures, tostring(res)))
end
return false, nil
end
function _v13.IsRunning()
return _v420
end
function _v13.SaveConfig(name)
return _v11.save(name, _v12)
end
function _v13.LoadConfig(name)
local _v338, res = _v11.load(name, _v12)
if _v338 then
pcall(function()
UI:SyncControls()
end)
end
return _v338, res
end
function _v13.ListConfigs()
return _v11.list()
end
function _v13.DeleteConfig(name)
return _v11.delete(name)
end
function _v13.ServerHop()
return _v45:ServerHop()
end
function _v13.Rejoin()
return _v45:Rejoin()
end
function _v13.SetWatermarkImage(_v226)
_v12.UI.WatermarkImageId = tostring(_v226 or (_V9({})))
UI:SetWatermarkImage(_v12.UI.WatermarkImageId)
return _v13
end
function _v13.SetWebhook(_v522)
return _v47.SetWebhook(_v522)
end
function _v13.HasWebhook()
return _v47.HasWebhook()
end
function _v13.SendWebhook(content, _v363)
return _v47.SendWebhook(content, _v363)
end
function _v13.SendLoadedEmbed(_v236)
return _v47.SendLoadedEmbed(_v236)
end
function _v13.Start()
if _v420 then
return _v13
end
_v420 = true
local _v338, err = pcall(function()
ESP:Init()
UI:Init(_v12, function()
_v13.Stop()
end)
Movement:Init(_v12.Movement)
SilentAim:Init(_v12)
table.insert(_v122, _v31.PlayerAdded:Connect(function(_v378)
_v199((_V9({131,214,159,127,133,119,186,38,78,182,222})), ESP.OnPlayerAdded, ESP, _v378)
end))
table.insert(_v122, _v31.PlayerRemoving:Connect(function(_v378)
_v199((_V9({131,214,159,127,133,119,169,39,71,188,204,151,104,135})), ESP.OnPlayerRemoving, ESP, _v378)
end))
table.insert(_v122, _v44.InputBegan:Connect(function(_v230, _v193)
if _v193 or UI:IsCapturingKey() then
return
end
_v199((_V9({152,223,135,100,137,107,159,49})), function()
local _v244 = _v230.KeyCode
if _v244 == _v12.UI.MenuKey then
UI:Toggle()
elseif _v244 == _v12.UI.UnloadKey then
_v13.Stop()
else
local _v502 = {
{ _v12.Camera, (_V9({150,212,159,100,140,96,159})), _v12.Camera.ToggleKey },
{ _v12.ESP, (_V9({150,212,159,100,140,96,159})), _v12.ESP.ToggleKey },
{ _v12.Camera, (_V9({149,245,168,69,137,119,152,46,79})), _v12.Camera.FOVCircleKey },
{ _v12.NoRecoil, (_V9({150,212,159,100,140,96,159})), _v12.NoRecoil.ToggleKey },
{ _v12.NoSpread, (_V9({150,212,159,100,140,96,159})), _v12.NoSpread.ToggleKey },
{ _v12.Triggerbot, (_V9({150,212,159,100,140,96,159})), _v12.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v502) do
if _v244 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v187, fpsFrames = 0, 0
table.insert(_v122, _v36.RenderStepped:Connect(function(_v160)
_v199((_V9({144,219,144,98,137,97,154,54,79,160})), _v9.Update, _v9, _v12.Camera, _v12.ESP)
_v199((_V9({150,233,174})), ESP.Update, ESP, _v12.ESP)
local _v340, target = true, nil
if not (UI.IsSpectating and UI.IsSpectating()) then
_v340, target = _v199((_V9({146,211,147,100,143,113})), _v8.Update, _v8, _v12.Camera, _v12.Debug)
end
if not _v340 then
target = nil
end
if _v12.UI.TargetDisplay then
_v199((_V9({135,219,140,97,133,113,219,38,67,160,202,146,103,153})), function()
local _v266 = _v8:GetLookTarget(_v12.ESP, _v12.Camera)
UI:SetCurrentTarget(_v266 and _v266.Name or nil)
end)
end
_v61 = _v12.Camera.Enabled and target ~= nil
_v199((_V9({157,213,173,118,146,96,154,38})), NoSpread.Update, NoSpread, _v12.NoSpread)
_v199((_V9({128,211,146,99,142,113,219,3,67,190})), SilentAim.Update, SilentAim, _v12)
_v199((_V9({135,200,151,97,135,96,137,32,69,167})), Triggerbot.Update, Triggerbot, _v12.Triggerbot, _v12.Camera)
_v199((_V9({158,213,136,99,141,96,149,54})), Movement.Update, Movement, _v160, _v12.Movement)
_v199((_V9({155,211,138,100,143,125})), _v22.Update, _v22, _v12.Hitbox, _v12.Camera)
_v199((_V9({151,200,159,113,137,107,156,98,111,128,234})), _v16.Update, _v16, _v12.Drawing, _v12.Camera)
_v199((_V9({133,211,141,115,129,105,136})), Visuals.Update, Visuals, _v12.Visuals)
_v187 = _v187 + _v160
fpsFrames = fpsFrames + 1
if _v187 >= 0.25 then
local _v186 = math.floor(fpsFrames / _v187 + 0.5)
_v187, fpsFrames = 0, 0
if _v12.UI.FPSCounter then
_v199((_V9({149,234,173,38,131,106,142,44,94,182,200})), UI.UpdateFPS, UI, _v186)
end
end
end))
pcall(function()
_v36:UnbindFromRenderStep(_v32)
end)
pcall(function()
_v36:BindToRenderStep(_v32, Enum.RenderPriority.Camera.Value + 1, function()
_v199((_V9({157,213,172,99,131,106,146,46})), NoRecoil.Update, NoRecoil, _v12.NoRecoil, _v61)
end)
end)
end)
if not _v338 then
warn((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,108,178,211,146,99,132,37,143,45,10,160,206,159,116,148,63})), err)
_v13.Stop()
return _v13
end
if not _v10.HideGlobal((_V9({133,219,144,111,148,124,188,39,68,182,200,159,106})), _v13) and getgenv then
getgenv().VanityGeneral = _v13
end
UI:Notify(string.format((_V9({133,219,144,111,148,124,214,5,79,189,223,140,103,140,37,151,45,75,183,223,154,38,192,231,123,224,10,243,234,140,99,147,118,219,103,89})), _v12.UI.MenuKey.Name), 4)
print(string.format((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,120,166,212,144,111,142,98,219,106,92,246,201,215})), _v13.Version))
print(string.format((_V9({158,223,144,115,218,37,222,49,10,243,198,222,38,163,100,150,39,88,178,128,222,35,147,37,219,62,10,243,239,144,106,143,100,159,120,10,246,201})),
_v12.UI.MenuKey.Name,
_v12.Camera.ToggleKey.Name,
_v12.UI.UnloadKey.Name))
if _v47.HasWebhook() then
task.spawn(function()
_v47.SendLoadedEmbed(false)
end)
end
return _v13
end
function _v13.Stop()
if not _v420 then
return _v13
end
_v420 = false
for _, _v121 in ipairs(_v122) do
pcall(function()
_v121:Disconnect()
end)
end
table.clear(_v122)
pcall(function()
_v36:UnbindFromRenderStep(_v32)
end)
_v61 = false
pcall(function()
ESP:Cleanup()
end)
pcall(function()
UI:Cleanup()
end)
pcall(function()
_v8:Cleanup()
end)
pcall(function()
Movement:Cleanup()
end)
pcall(function()
_v22:Cleanup()
end)
pcall(function()
_v16:Cleanup()
end)
pcall(function()
Visuals:Cleanup()
end)
pcall(function()
NoSpread:Cleanup()
end)
NoRecoil:Reset()
table.clear(_v198)
print((_V9({136,236,159,104,137,113,130,111,109,182,212,155,116,129,105,166,98,121,167,213,142,118,133,97})))
return _v13
end
function _v13.Toggle()
if _v420 then
_v13.Stop()
else
_v13.Start()
end
return _v13
end
_v13.start = _v13.Start
_v13.stop = _v13.Stop
_v13.toggle = _v13.Toggle
return _v13
end)()
do
local _v13 = _v13
if getgenv then
local _v387 = getgenv().VanityGeneral
if _v387 and _v387 ~= _v13 and type(_v387.Stop) == (_V9({181,207,144,101,148,108,148,44})) then
pcall(_v387.Stop)
end
end
pcall(function()
_v13.Start()
end)
return _v13
end
