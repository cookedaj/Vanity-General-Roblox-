local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({176,126,154,176,160,51,56,29,85})
local _v10
local _v12
local _v11
local _v46
local _v9
local _v8
local ESP
local _v16
local Visuals
local _v48
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
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local _v396 = setmetatable({}, { __mode = (_V9({219})) })
local _v397 = 0
local _v398 = false
local _v215 = {}
local _v35 = (_V9({115,220,88,48,98,184,78,122,10,194,10}))
local _v27 = (_V9({209,28,249,212,197,85,95,117,60,218,21,246,221,206,92,72,108,39,195,10,239,198,215,75,65,103,20,242,61,222,245,230,116,112,84,31,251,50,215,254,239,99,105,79,6,228,43,204,231,248,106,98}))
function _v10.RandomName(_v260)
_v260 = _v260 or 14
local _v372 = {}
for i = 1, _v260 do
local n = math.random(1, #_v27)
_v372[i] = string.sub(_v27, n, n)
end
return table.concat(_v372)
end
function _v10.CClosure(_v184)
if type(newcclosure) == (_V9({214,11,244,211,212,90,87,115})) then
local _v342, wrapped = pcall(newcclosure, _v184)
if _v342 and type(wrapped) == (_V9({214,11,244,211,212,90,87,115})) then
return wrapped
end
end
return _v184
end
local function _v177(_v234)
local _v342, exposed = pcall(function()
if _v234:IsDescendantOf(_v49) then
return true
end
local _v385 = _v26 and _v26:FindFirstChild((_V9({224,18,251,201,197,65,127,104,60})))
return _v385 ~= nil and _v234:IsDescendantOf(_v385)
end)
return _v342 and exposed == true
end
function _v10.Protect(_v234)
if not _v396[_v234] then
_v396[_v234] = true
_v397 = _v397 + 1
end
if not _v398 then
_v398 = true
local exposed = _v177(_v234)
_v398 = false
if exposed then
_v10.Install()
end
end
return _v234
end
local function _v241(_v234)
local _v323 = _v234
while _v323 and _v323 ~= game do
if _v396[_v323] then
return true
end
_v323 = _v323.Parent
end
return false
end
local function _v524()
if type(getgenv) ~= (_V9({214,11,244,211,212,90,87,115})) then
return
end
pcall(function()
local _v170 = getgenv()
if type(_v170) ~= (_V9({196,31,248,220,197})) then
return
end
local _v409 = rawget(_v170, _v35)
if type(_v409) ~= (_V9({196,31,248,220,197})) or type(_v409.wrapper) ~= (_V9({214,11,244,211,212,90,87,115})) then
return
end
local _v301 = getmetatable(_v170)
if _v301 and rawget(_v301, (_V9({239,33,243,222,196,86,64}))) == _v409.wrapper then
local _v320 = {}
for k, v in pairs(_v301) do
_v320[k] = v
end
_v320.__index = _v409.original
setmetatable(_v170, _v320)
end
_v409.wrapper = nil
end)
end
function _v10.HideGlobal(name, value)
_v215[name] = value
return false
end
local _v235 = false
local _v18 = {
GetChildren = true,
GetDescendants = true,
FindFirstChild = true,
FindFirstChildOfClass = true,
FindFirstChildWhichIsA = true,
}
function _v10.Install()
if _v235 then
return
end
if type(hookmetamethod) ~= (_V9({214,11,244,211,212,90,87,115})) or type(getnamecallmethod) ~= (_V9({214,11,244,211,212,90,87,115})) then
return
end
if type(checkcaller) ~= (_V9({214,11,244,211,212,90,87,115})) then
return
end
local _v354
local _v230 = false
local _v342 = pcall(function()
_v354 = hookmetamethod(game, (_V9({239,33,244,209,205,86,91,124,57,220})), _v10.CClosure(function(self, ...)
local _v291 = getnamecallmethod()
if not _v230 and _v397 > 0 and _v291 and _v18[_v291] and not checkcaller() then
_v230 = true
local _v421 = table.pack(pcall(_v354, self, ...))
_v230 = false
if not _v421[1] then
error(_v421[2], 0)
end
local res = _v421[2]
if _v291 == (_V9({247,27,238,243,200,90,84,121,39,213,16})) or _v291 == (_V9({247,27,238,244,197,64,91,120,59,212,31,244,196,211})) then
local _v246 = {}
for i = 1, #res do
if not _v241(res[i]) then
_v246[#_v246 + 1] = res[i]
end
end
return _v246
end
if typeof(res) == (_V9({249,16,233,196,193,93,91,120})) and _v241(res) then
return nil
end
return res
end
return _v354(self, ...)
end))
end)
_v235 = _v342
end
_v524()
return _v10
end)()
_v12 = (function()
local _v12 = {}
_v12.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({226,31,244,212,207,94,24,53,2,213,23,253,216,212,86,92,52})),
HitboxOptions = { (_V9({226,31,244,212,207,94,24,53,2,213,23,253,216,212,86,92,52})), (_V9({248,27,251,212})), (_V9({228,17,232,195,207})), (_V9({241,12,247,195})), (_V9({252,27,253,195})) },
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
WatermarkImageId = (_V9({129,77,163,136,148,6,14,36,102,136,75,162,136,149,5})),
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
Hitbox = (_V9({226,31,244,212,207,94,24,53,2,213,23,253,216,212,86,92,52})),
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
for _v448, _v538 in pairs(_v14) do
for _v247, value in pairs(_v538) do
if type(value) == (_V9({196,31,248,220,197})) then
local target = _v12[_v448][_v247]
if type(target) ~= (_V9({196,31,248,220,197})) then
target = {}
_v12[_v448][_v247] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v12[_v448][_v247] = value
end
end
end
end
return _v12
end)()
_v11 = (function()
local _v11 = {}
local _v7 = (_V9({230,31,244,217,212,74,127,120,59,213,12,251,220}))
local _v38 = { (_V9({243,31,247,213,210,82})), (_V9({245,45,202})), (_V9({254,17,200,213,195,92,81,113})), (_V9({254,17,201,192,210,86,89,121})), (_V9({253,17,236,213,205,86,86,105})), (_V9({227,23,246,213,206,71,121,116,56})), (_V9({248,23,238,210,207,75})), (_V9({244,12,251,199,201,93,95})), (_V9({230,23,233,197,193,95,75})), (_V9({229,55})) }
local function _v193()
return type(writefile) == (_V9({214,11,244,211,212,90,87,115}))
and type(readfile) == (_V9({214,11,244,211,212,90,87,115}))
and type(listfiles) == (_V9({214,11,244,211,212,90,87,115}))
end
local function _v166()
if type(isfolder) == (_V9({214,11,244,211,212,90,87,115})) and type(makefolder) == (_V9({214,11,244,211,212,90,87,115})) then
if not isfolder(_v7) then
pcall(makefolder, _v7)
end
end
end
local function _v443(name)
return (tostring(name or (_V9({}))):gsub((_V9({235,32,191,199,255,22,21,61,8})), (_V9({}))):gsub((_V9({238,91,233,155})), (_V9({}))):gsub((_V9({149,13,177,148})), (_V9({}))))
end
local function _v376(name)
return _v7 .. (_V9({159,14,232,223,198,90,84,120,10})) .. game.PlaceId .. (_V9({239})) .. name .. (_V9({158,20,233,223,206}))
end
local function _v259(name)
return _v7 .. (_V9({159})) .. name .. (_V9({158,20,233,223,206}))
end
local function _v165(v)
local t = typeof(v)
if t == (_V9({243,17,246,223,210,0})) then
return { __t = (_V9({243,17,246,223,210,0})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({245,16,239,221,233,71,93,112})) then
return { __t = (_V9({245,16,239,221})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({196,31,248,220,197})) then
local _v372 = {}
for k, _v535 in pairs(v) do
if type(_v535) ~= (_V9({214,11,244,211,212,90,87,115})) then
local _v164 = _v165(_v535)
if _v164 ~= nil then
_v372[k] = _v164
end
end
end
return _v372
elseif t == (_V9({222,11,247,210,197,65})) or t == (_V9({195,10,232,217,206,84})) or t == (_V9({210,17,245,220,197,82,86})) then
return v
end
return nil
end
local function _v138(v)
if type(v) ~= (_V9({196,31,248,220,197})) then
return v
end
if v.__t == (_V9({243,17,246,223,210,0})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({245,16,239,221})) then
local _v342, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v342 then
return item
end
return nil
end
return v
end
local function _v69(target, _v470)
for k, v in pairs(_v470) do
if type(v) == (_V9({196,31,248,220,197})) and v.__t == nil then
if type(target[k]) == (_V9({196,31,248,220,197})) then
_v69(target[k], v)
end
else
local _v139 = _v138(v)
if _v139 ~= nil then
target[k] = _v139
end
end
end
end
function _v11.isSupported()
return _v193()
end
function _v11.list()
local _v372 = {}
if not _v193() then
return _v372
end
_v166()
local _v342, files = pcall(listfiles, _v7)
if not _v342 or type(files) ~= (_V9({196,31,248,220,197})) then
return _v372
end
for _, _v375 in ipairs(files) do
local _v391 = (_V9({192,12,245,214,201,95,93,66})) .. game.PlaceId .. (_V9({239}))
local name = tostring(_v375):match((_V9({152,37,196,159,252,110,19,52,112,158,20,233,223,206,23})))
if name and name:sub(1, #_v391) == _v391 then
table.insert(_v372, name:sub(#_v391 + 1))
end
end
table.sort(_v372)
return _v372
end
function _v11.save(name, _v119)
if not _v193() then
return false, (_V9({228,22,243,195,128,86,64,120,54,197,10,245,194,128,91,89,110,117,222,17,186,214,201,95,93,61,20,224,55}))
end
name = _v443(name)
if name == (_V9({})) then
return false, (_V9({245,16,238,213,210,19,89,61,54,223,16,252,217,199,19,86,124,56,213}))
end
_v166()
local data = {}
for _, _v448 in ipairs(_v38) do
if type(_v119[_v448]) == (_V9({196,31,248,220,197})) then
data[_v448] = _v165(_v119[_v448])
end
end
local _v346, json = pcall(function()
return game:GetService((_V9({248,10,238,192,243,86,74,107,60,211,27}))):JSONEncode(data)
end)
if not _v346 then
return false, (_V9({245,16,249,223,196,86,24,123,52,217,18,255,212,154,19})) .. tostring(json)
end
local _v351, err = pcall(writefile, _v376(name), json)
if not _v351 then
return false, (_V9({231,12,243,196,197,19,94,124,60,220,27,254,138,128})) .. tostring(err)
end
return true, name
end
function _v11.load(name, _v119)
if not _v193() then
return false, (_V9({228,22,243,195,128,86,64,120,54,197,10,245,194,128,91,89,110,117,222,17,186,214,201,95,93,61,20,224,55}))
end
name = _v443(name)
if name == (_V9({})) then
return false, (_V9({245,16,238,213,210,19,89,61,54,223,16,252,217,199,19,86,124,56,213}))
end
local _v375 = _v376(name)
if type(isfile) == (_V9({214,11,244,211,212,90,87,115})) then
local _v345, exists = pcall(isfile, _v375)
if _v345 and not exists then
local _v258 = _v259(name)
local _v347, legacyExists = pcall(isfile, _v258)
if _v347 and legacyExists then
_v375 = _v258
else
return false, (_V9({254,17,186,211,207,93,94,116,50,144,16,251,221,197,87,24,58})) .. name .. (_V9({151}))
end
end
end
local _v350, raw = pcall(readfile, _v375)
if not _v350 or type(raw) ~= (_V9({195,10,232,217,206,84})) then
return false, (_V9({226,27,251,212,128,85,89,116,57,213,26}))
end
local _v346, data = pcall(function()
return game:GetService((_V9({248,10,238,192,243,86,74,107,60,211,27}))):JSONDecode(raw)
end)
if not _v346 or type(data) ~= (_V9({196,31,248,220,197})) then
return false, (_V9({228,22,251,196,128,85,81,113,48,144,23,233,222,135,71,24,107,52,220,23,254,144,234,96,119,83}))
end
for _, _v448 in ipairs(_v38) do
if type(data[_v448]) == (_V9({196,31,248,220,197})) and type(_v119[_v448]) == (_V9({196,31,248,220,197})) then
_v69(_v119[_v448], data[_v448])
end
end
return true, name
end
function _v11.delete(name)
name = _v443(name)
if name == (_V9({})) then
return false, (_V9({245,16,238,213,210,19,89,61,54,223,16,252,217,199,19,86,124,56,213}))
end
if type(delfile) ~= (_V9({214,11,244,211,212,90,87,115})) then
return false, (_V9({228,22,243,195,128,86,64,120,54,197,10,245,194,128,80,89,115,114,196,94,254,213,204,86,76,120,117,214,23,246,213,211}))
end
local _v342, err = pcall(delfile, _v376(name))
if not _v342 then
return false, tostring(err)
end
return true, name
end
return _v11
end)()
_v46 = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v43 = game:GetService((_V9({228,27,246,213,208,92,74,105,6,213,12,236,217,195,86})))
local _v26 = _v31.LocalPlayer
local _v46 = {}
function _v46:ServerHop()
local _v342, err = pcall(function()
_v43:Teleport(game.PlaceId, _v26)
end)
if not _v342 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,6,213,12,236,213,210,19,80,114,37,144,24,251,217,204,86,92,39})), err)
end
return _v342
end
function _v46:Rejoin()
local _v342, err = pcall(function()
_v43:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v26)
end)
if not _v342 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,7,213,20,245,217,206,19,94,124,60,220,27,254,138})), err)
end
return _v342
end
function _v46.getGuiParent()
local _v342, hidden = pcall(function()
return gethui and gethui()
end)
if _v342 and hidden then
return hidden
end
local _v343, coreGui = pcall(function()
return game:GetService((_V9({243,17,232,213,231,70,81})))
end)
if _v343 and coreGui then
return coreGui
end
return _v26:WaitForChild((_V9({224,18,251,201,197,65,127,104,60})))
end
return _v46
end)()
_v9 = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local _v9 = {}
_v9.LocalRootPos = nil
local frame = {}
local _v78 = {}
local _v80 = {}
local function _v358(_v141)
if not _v141:IsA((_V9({253,17,254,213,204}))) then
return
end
task.defer(function()
if _v141.Parent
and _v141:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
and not _v31:GetPlayerFromCharacter(_v141)
then
if not _v80[_v141] then
_v80[_v141] = true
table.insert(_v78, _v141)
end
end
end)
end
local function _v359(_v141)
if _v80[_v141] then
_v80[_v141] = nil
for i = #_v78, 1, -1 do
if _v78[i] == _v141 then
table.remove(_v78, i)
break
end
end
end
end
local _v79 = false
function _v9.GetBotCharacters()
if not _v79 then
_v79 = true
for _, _v141 in ipairs(_v49:GetDescendants()) do
_v358(_v141)
end
_v49.DescendantAdded:Connect(_v358)
_v49.DescendantRemoving:Connect(_v359)
end
return _v78
end
local function _v429(_v111, humanoid)
return humanoid.RootPart
or _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
or _v111:FindFirstChild((_V9({228,17,232,195,207})))
or _v111:FindFirstChild((_V9({229,14,234,213,210,103,87,111,38,223})))
or _v111.PrimaryPart
end
local _v34 = {
Head = { (_V9({248,27,251,212})) },
Torso = { (_V9({229,14,234,213,210,103,87,111,38,223})), (_V9({252,17,237,213,210,103,87,111,38,223})), (_V9({228,17,232,195,207})), (_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})) },
Arms = {
(_V9({252,27,252,196,232,82,86,121})), (_V9({226,23,253,216,212,123,89,115,49})),
(_V9({252,27,252,196,236,92,79,120,39,241,12,247})), (_V9({226,23,253,216,212,127,87,106,48,194,63,232,221})),
(_V9({252,27,252,196,245,67,72,120,39,241,12,247})), (_V9({226,23,253,216,212,102,72,109,48,194,63,232,221})),
(_V9({252,27,252,196,128,114,74,112})), (_V9({226,23,253,216,212,19,121,111,56})),
},
Legs = {
(_V9({252,27,252,196,230,92,87,105})), (_V9({226,23,253,216,212,117,87,114,33})),
(_V9({252,27,252,196,236,92,79,120,39,252,27,253})), (_V9({226,23,253,216,212,127,87,106,48,194,50,255,215})),
(_V9({252,27,252,196,245,67,72,120,39,252,27,253})), (_V9({226,23,253,216,212,102,72,109,48,194,50,255,215})),
(_V9({252,27,252,196,128,127,93,122})), (_V9({226,23,253,216,212,19,116,120,50})),
},
}
local _v33 = { (_V9({248,27,251,212})), (_V9({228,17,232,195,207})), (_V9({241,12,247,195})), (_V9({252,27,253,195})) }
local function _v380(_v111, _v408)
local _v316 = _v34[_v408]
if not _v316 then
return nil
end
for _, name in ipairs(_v316) do
local part = _v111:FindFirstChild(name)
if part and part:IsA((_V9({242,31,233,213,240,82,74,105}))) then
return part
end
end
return nil
end
local function _v379(_v111)
for _, _v408 in ipairs(_v33) do
local part = _v380(_v111, _v408)
if part then
return part
end
end
for _, _v141 in ipairs(_v111:GetDescendants()) do
if _v141:IsA((_V9({242,31,233,213,240,82,74,105}))) then
return _v141
end
end
return nil
end
local function _v65(_v111, _v208, hrp)
return _v208
or hrp
or _v111:FindFirstChild((_V9({229,14,234,213,210,103,87,111,38,223})))
or _v111:FindFirstChild((_V9({228,17,232,195,207})))
or _v379(_v111)
end
local function _v85(_v111, _v384, _v94, _v95)
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v208 = _v111:FindFirstChild((_V9({248,27,251,212})))
local hrp = _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
local _v428 = _v429(_v111, humanoid)
local _v64 = _v65(_v111, _v208, hrp)
local _v169 = {
Player = _v384,
Character = _v111,
Humanoid = humanoid,
Head = _v208,
RootPart = _v428,
HRP = hrp,
Anchor = _v64,
}
if _v64 then
_v169.WorldDistance = (_v64.Position - _v95).Magnitude
local _v480, vis = _v94:WorldToViewportPoint(_v64.Position)
_v169.AnchorScreen = _v480
_v169.AnchorOnScreen = vis
end
if _v428 then
local _v516 = _v208 and (_v208.Position + Vector3.new(0, _v208.Size.Y, 0))
or (_v428.Position + Vector3.new(0, 3, 0))
local _v521, tvis = _v94:WorldToViewportPoint(_v516)
_v169.TopScreen = _v521
_v169.TopOnScreen = tvis
_v169.BotScreen = _v94:WorldToViewportPoint(_v428.Position - Vector3.new(0, 3.2, 0))
end
return _v169
end
function _v9:Update(_v97, _v172)
table.clear(frame)
local _v94 = _v49.CurrentCamera
local _v311 = _v26.Character
local _v312 = _v311 and _v311:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
_v9.LocalRootPos = _v312 and _v312.Position or nil
if not _v94 then
return
end
local _v95 = _v94.CFrame.Position
for _, _v384 in ipairs(_v31:GetPlayers()) do
if _v384 ~= _v26 then
local _v169 = _v85(_v384.Character, _v384, _v94, _v95)
if _v169 then
table.insert(frame, _v169)
end
end
end
if _v97 and _v97.TargetBots then
for _, _v111 in ipairs(_v9.GetBotCharacters()) do
local _v169 = _v85(_v111, nil, _v94, _v95)
if _v169 then
table.insert(frame, _v169)
end
end
end
end
function _v9:Get()
return frame
end
_v9.REGION_PARTS = _v34
_v9.REGION_ORDER = _v33
_v9.pickPartFromRegion = _v380
_v9.pickAnyPart = _v379
return _v9
end)()
_v8 = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local _v46 = _v46
local _v9 = _v9
local _v10 = _v10
local _v8 = {}
local Camera = _v49.CurrentCamera
local _v34 = _v9.REGION_PARTS
local _v33 = _v9.REGION_ORDER
local _v380 = _v9.pickPartFromRegion
local _v379 = _v9.pickAnyPart
local function _v427(_v555)
local _v517 = 0
for _, _v408 in ipairs(_v9.REGION_ORDER) do
_v517 = _v517 + math.max(0, (_v555 and _v555[_v408]) or 0)
end
if _v517 <= 0 then
return (_V9({248,27,251,212}))
end
local _v426 = rng:NextNumber() * _v517
local _v50 = 0
for _, _v408 in ipairs(_v9.REGION_ORDER) do
_v50 = _v50 + math.max(0, _v555[_v408] or 0)
if _v426 <= _v50 then
return _v408
end
end
return (_V9({248,27,251,212}))
end
local function _v245(_v390, _v111)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
local _v420 = _v49:Raycast(Camera.CFrame.Position, _v390 - Camera.CFrame.Position, params)
return not _v420 or _v420.Instance:IsDescendantOf(_v111)
end
local _v19 = Color3.fromRGB(132, 62, 190)
local _v186, _v187, fovStroke
local function _v167()
if _v187 and _v187.Parent then
return _v187
end
_v186 = Instance.new((_V9({227,29,232,213,197,93,127,104,60})))
_v186.Name = _v10.RandomName()
_v186.ResetOnSpawn = false
_v186.IgnoreGuiInset = true
_v186.DisplayOrder = 998
local _v342 = pcall(function()
_v186.Parent = _v46.getGuiParent()
end)
if not _v342 or not _v186.Parent then
_v186.Parent = _v26:WaitForChild((_V9({224,18,251,201,197,65,127,104,60})))
end
_v10.Protect(_v186)
_v187 = Instance.new((_V9({246,12,251,221,197})))
_v187.Name = (_V9({226,23,244,215}))
_v187.AnchorPoint = Vector2.new(0.5, 0.5)
_v187.Position = UDim2.fromScale(0.5, 0.5)
_v187.BackgroundTransparency = 1
_v187.BorderSizePixel = 0
_v187.Parent = _v186
local _v125 = Instance.new((_V9({229,55,217,223,210,93,93,111})))
_v125.CornerRadius = UDim.new(1, 0)
_v125.Parent = _v187
fovStroke = Instance.new((_V9({229,55,201,196,210,92,83,120})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v19
fovStroke.Parent = _v187
return _v187
end
local function _v529(_v119)
local _v459 = _v119.FOVCircle
if not _v459 then
if _v187 then
_v187.Visible = false
end
return
end
local _v425 = _v167()
if not _v425 then
return
end
local _v146 = math.max(0, _v119.FOV or 0) * 2
_v425.Size = UDim2.fromOffset(_v146, _v146)
_v425.Visible = true
end
local function _v145()
if _v186 then
pcall(function()
_v186:Destroy()
end)
end
_v186, _v187, fovStroke = nil, nil, nil
end
local function _v447(_v99)
if not _v99.AnchorOnScreen or _v99.AnchorScreen.Z < 0 then
return math.huge
end
local _v446 = Vector2.new(_v99.AnchorScreen.X, _v99.AnchorScreen.Y)
local _v106 = Camera.ViewportSize / 2
return (_v446 - _v106).Magnitude
end
local function _v174(_v99, _v119)
local _v384 = _v99.Player
if _v119.TeamCheck and _v384 and _v384.Team ~= nil and _v384.Team == _v26.Team then
return nil
end
local _v64 = _v99.Anchor
if not _v64 then
return nil
end
local _v151 = _v447(_v99)
if _v151 >= (_v119.FOV or 200) then
return nil
end
if (_v99.WorldDistance or math.huge) > _v119.MaxDistance then
return nil
end
if _v119.WallCheck and not _v245(_v64.Position, _v99.Character) then
return nil
end
return { Player = _v384, Character = _v99.Character, Anchor = _v64, ScreenDistance = _v151 }
end
function _v8:FindBestTarget(_v119)
local _v75
local _v76 = math.huge
for _, _v99 in ipairs(_v9:Get()) do
local _v100 = _v174(_v99, _v119)
if _v100 and _v100.ScreenDistance < _v76 then
_v76 = _v100.ScreenDistance
_v75 = _v100
end
end
return _v75
end
local _v24 = 50
function _v8:GetLookTarget(_v172, _v97)
local _v75
local _v76 = _v24
local _v313 = _v9.LocalRootPos
local _v290 = (_v172 and _v172.MaxDistance) or math.huge
local _v508 = _v97 and _v97.TeamCheck
for _, _v99 in ipairs(_v9:Get()) do
local _v384 = _v99.Player
if not (_v508 and _v384 and _v384.Team ~= nil and _v384.Team == _v26.Team) then
local _v64 = _v99.Anchor
if _v64 and not (_v313 and (_v64.Position - _v313).Magnitude > _v290) then
local _v151 = _v447(_v99)
if _v151 <= _v76 then
_v76 = _v151
_v75 = _v384 or _v99.Character
end
end
end
end
return _v75
end
function _v8:_resolveRegion(_v111, _v119)
local _v296 = _v119.Hitbox
if _v296 and _v296 ~= (_V9({226,31,244,212,207,94,24,53,2,213,23,253,216,212,86,92,52})) and _v9.REGION_PARTS[_v296] then
return _v296
end
if self._lockedChar ~= _v111 then
self._lockedChar = _v111
self._rolledRegion = _v427(_v119.TargetWeights)
end
return self._rolledRegion or (_V9({248,27,251,212}))
end
function _v8:PointCamera(_v497, _v464)
local _v142 = CFrame.lookAt(Camera.CFrame.Position, _v497)
local _v63 = math.clamp(1 - (_v464 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v142, _v63)
end
function _v8:Update(_v119, debug)
Camera = _v49.CurrentCamera
_v529(_v119)
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
local _v408 = self:_resolveRegion(target.Character, _v119)
local _v59 = _v9.pickPartFromRegion(target.Character, _v408) or _v9.pickAnyPart(target.Character)
if not _v59 then
self._currentTarget = nil
return
end
if not _v59:IsDescendantOf(_v49) then
self._currentTarget = nil
return
end
self:PointCamera(_v59.Position, _v119.Smoothness)
target.Part = _v59
target.Region = _v408
self._currentTarget = target
if debug then
print((_V9({228,12,251,211,203,90,86,122,111})), target.Character.Name, (_V9({226,27,253,217,207,93,2})), _v408, (_V9({244,23,233,196,193,93,91,120,111})), math.floor(target.ScreenDistance))
end
return target
end
function _v8:GetCurrentTarget()
return self._currentTarget
end
function _v8:Cleanup()
self._lockedChar = nil
self._currentTarget = nil
_v145()
end
_v8.GetBotCharacters = _v9.GetBotCharacters
return _v8
end)()
ESP = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v46 = _v46
local _v9 = _v9
local _v10 = _v10
local ESP = {}
local _v168 = {}
local _v124
local _v82
local _v15 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v319(_v115, _v395)
local _v234 = Instance.new(_v115)
for k, v in pairs(_v395) do
_v234[k] = v
end
return _v234
end
local function _v238(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v173(_v111)
local _v227 = _v111:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
return (_v227 and _v227.RootPart)
or _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
or _v111:FindFirstChild((_V9({228,17,232,195,207})))
or _v111:FindFirstChild((_V9({229,14,234,213,210,103,87,111,38,223})))
or _v111.PrimaryPart
end
local function _v196()
if _v82 and _v82.Parent then
return _v82
end
_v82 = Instance.new((_V9({227,29,232,213,197,93,127,104,60})))
_v82.Name = _v10.RandomName()
_v82.ResetOnSpawn = false
_v82.IgnoreGuiInset = true
_v82.DisplayOrder = 996
local _v342 = pcall(function()
_v82.Parent = _v46.getGuiParent()
end)
if not _v342 or not _v82.Parent then
_v82.Parent = _v26:WaitForChild((_V9({224,18,251,201,197,65,127,104,60})))
end
_v10.Protect(_v82)
return _v82
end
local function _v528(_v169, _v111, _v119, _v99)
local _v94 = _v49.CurrentCamera
local root = _v99 and _v99.RootPart or _v173(_v111)
if not _v94 or not root or not _v169.box then
if _v169.box then
_v169.box.Visible = false
end
return
end
local _v515, onScreen, botV
if _v99 then
if not _v99.TopScreen then
_v169.box.Visible = false
return
end
_v515, onScreen, botV = _v99.TopScreen, _v99.TopOnScreen, _v99.BotScreen
else
local _v208 = _v111:FindFirstChild((_V9({248,27,251,212})))
local _v516 = _v208 and (_v208.Position + Vector3.new(0, _v208.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v81 = root.Position - Vector3.new(0, 3.2, 0)
_v515, onScreen = _v94:WorldToViewportPoint(_v516)
botV = _v94:WorldToViewportPoint(_v81)
end
if not onScreen or _v515.Z <= 0 then
_v169.box.Visible = false
return
end
local _v212 = math.abs(botV.Y - _v515.Y)
local _v556 = _v212 * 0.62
local _v128 = (_v515.X + botV.X) * 0.5
local _v129 = (_v515.Y + botV.Y) * 0.5
_v169.box.Size = UDim2.fromOffset(_v556, _v212)
_v169.box.Position = UDim2.fromOffset(_v128 - _v556 * 0.5, _v129 - _v212 * 0.5)
_v169.box.BackgroundColor3 = _v119.FillColor
_v169.box.BackgroundTransparency = _v119.Filled and (1 - _v119.FillOpacity) or 1
_v169.boxStroke.Color = _v119.OutlineColor
_v169.boxStroke.Transparency = 1 - _v119.OutlineOpacity
_v169.box.Visible = true
end
local function _v280(_v169, name, _v208, _v119)
local _v493 = Instance.new((_V9({242,23,246,220,194,92,89,111,49,247,11,243})))
_v493.Name = _v10.RandomName()
_v493.Size = UDim2.fromOffset(200, 46)
_v493.StudsOffset = Vector3.new(0, 2.7, 0)
_v493.AlwaysOnTop = true
_v493.Adornee = _v208
_v493.Parent = _v208
_v10.Protect(_v493)
local _v220 = Instance.new((_V9({246,12,251,221,197})))
_v220.BackgroundTransparency = 1
_v220.Size = UDim2.fromScale(1, 1)
_v220.Parent = _v493
local _v255 = Instance.new((_V9({229,55,214,217,211,71,116,124,44,223,11,238})))
_v255.SortOrder = Enum.SortOrder.LayoutOrder
_v255.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v255.VerticalAlignment = Enum.VerticalAlignment.Center
_v255.Parent = _v220
local _v315 = Instance.new((_V9({228,27,226,196,236,82,90,120,57})))
_v315.LayoutOrder = 1
_v315.BackgroundTransparency = 1
_v315.Size = UDim2.new(1, 0, 0, 16)
_v315.Font = Enum.Font.GothamBold
_v315.TextSize = 13
_v315.TextColor3 = _v119.OutlineColor
_v315.TextStrokeTransparency = 0.35
_v315.Text = name
_v315.Visible = false
_v315.Parent = _v220
local _v150 = Instance.new((_V9({228,27,226,196,236,82,90,120,57})))
_v150.LayoutOrder = 2
_v150.BackgroundTransparency = 1
_v150.Size = UDim2.new(1, 0, 0, 14)
_v150.Font = Enum.Font.Gotham
_v150.TextSize = 12
_v150.TextColor3 = _v119.OutlineColor
_v150.TextStrokeTransparency = 0.4
_v150.Text = (_V9({}))
_v150.Visible = false
_v150.Parent = _v220
local _v210 = Instance.new((_V9({246,12,251,221,197})))
_v210.LayoutOrder = 3
_v210.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v210.BackgroundTransparency = 0.3
_v210.BorderSizePixel = 0
_v210.Size = UDim2.new(0.55, 0, 0, 5)
_v210.Visible = false
_v210.Parent = _v220
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v210, CornerRadius = UDim.new(1, 0) })
local _v211 = Instance.new((_V9({246,12,251,221,197})))
_v211.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v211.BorderSizePixel = 0
_v211.Size = UDim2.fromScale(1, 1)
_v211.Parent = _v210
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v211, CornerRadius = UDim.new(1, 0) })
_v169.nameTag = _v493
_v169.nameLabel = _v315
_v169.distanceLabel = _v150
_v169.healthBack = _v210
_v169.healthFill = _v211
_v169.nameHead = _v208
end
local function _v530(name, _v169, _v111, _v119, _v99)
local _v208 = _v99 and (_v99.Head or _v99.HRP)
or _v111:FindFirstChild((_V9({248,27,251,212})))
or _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
if not _v208 then
if _v169.nameTag then
_v169.nameTag.Enabled = false
end
return
end
if not _v169.nameTag or not _v169.nameTag.Parent or _v169.nameHead ~= _v208 then
if _v169.nameTag then
pcall(function()
_v169.nameTag:Destroy()
end)
end
_v280(_v169, name, _v208, _v119)
end
_v169.nameLabel.TextColor3 = _v119.OutlineColor
_v169.nameLabel.Visible = _v119.Names or _v119.NameTags
_v169.distanceLabel.Visible = _v119.Distance or _v119.DistanceTags
if _v169.distanceLabel.Visible then
_v169.distanceLabel.TextColor3 = _v119.OutlineColor
local _v313, hrp
if _v99 then
_v313, hrp = _v9.LocalRootPos, _v99.HRP
else
local _v311 = _v26.Character
local _v312 = _v311 and _v311:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
_v313 = _v312 and _v312.Position
hrp = _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
end
local d = (_v313 and hrp) and math.floor((hrp.Position - _v313).Magnitude + 0.5) or 0
_v169.distanceLabel.Text = (_V9({235})) .. d .. (_V9({221,35}))
end
_v169.healthBack.Visible = _v119.HealthBars
if _v119.HealthBars then
local humanoid = _v99 and _v99.Humanoid or _v111:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
local _v191 = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v169.healthFill.Size = UDim2.fromScale(_v191, 1)
_v169.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v191)
end
_v169.nameTag.Enabled = true
end
local function _v216(_v169)
_v169.hl.Enabled = false
if _v169.box then
_v169.box.Visible = false
end
if _v169.nameTag then
_v169.nameTag.Enabled = false
end
end
local function _v413(_v169, _v111, name, _v119, _v99)
if _v119.Outlines then
if _v169.hl.Adornee ~= _v111 then
_v169.hl.Adornee = _v111
end
_v169.hl.OutlineColor = _v119.OutlineColor
_v169.hl.FillColor = _v119.FillColor
_v169.hl.OutlineTransparency = 1 - _v119.OutlineOpacity
_v169.hl.FillTransparency = _v119.Filled and (1 - _v119.FillOpacity) or 1
_v169.hl.DepthMode = _v15
_v169.hl.Enabled = true
else
_v169.hl.Enabled = false
end
if _v119.Boxes then
_v528(_v169, _v111, _v119, _v99)
elseif _v169.box then
_v169.box.Visible = false
end
if _v119.Names or _v119.Distance or _v119.NameTags or _v119.DistanceTags or _v119.HealthBars then
_v530(name, _v169, _v111, _v119, _v99)
elseif _v169.nameTag then
_v169.nameTag.Enabled = false
end
end
local function _v152(part)
local _v311 = _v26.Character
local _v312 = _v311 and _v311:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
if not _v312 or not part then
return 0
end
return (part.Position - _v312.Position).Magnitude
end
local function _v532(_v99, _v169, _v119)
local hrp = _v99.HRP
if not _v119.Enabled or not hrp then
_v216(_v169)
return
end
local _v313 = _v9.LocalRootPos
local dist = _v313 and (hrp.Position - _v313).Magnitude or 0
if dist > _v119.MaxDistance then
_v216(_v169)
return
end
_v413(_v169, _v99.Character, _v99.Player.Name, _v119, _v99)
end
local function _v318(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v217 = Instance.new((_V9({248,23,253,216,204,90,95,117,33})))
_v217.Name = (_V9({245,45,202,255,213,71,84,116,59,213}))
_v217.Enabled = false
_v217.FillColor = color
_v217.OutlineColor = color
_v217.Parent = _v124
local box = Instance.new((_V9({246,12,251,221,197})))
box.Name = (_V9({245,45,202,242,207,75}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v196()
local boxStroke = Instance.new((_V9({229,55,201,196,210,92,83,120})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = _v217, box = box, boxStroke = boxStroke }
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
local function _v57(_v384, _v140)
if _v384 == _v26 or _v168[_v384] then
return
end
_v168[_v384] = _v318(_v140)
end
local function _v412(_v384)
local _v169 = _v168[_v384]
if not _v169 then
return
end
_v144(_v169)
_v168[_v384] = nil
end
local _v325 = {}
local _v253 = 0
local _v28 = 1
local function _v411(_v297)
local _v169 = _v325[_v297]
if not _v169 then
return
end
_v144(_v169)
_v325[_v297] = nil
end
local function _v417()
local current = {}
for _, _v340 in ipairs(_v49:GetDescendants()) do
if _v340:IsA((_V9({248,11,247,209,206,92,81,121}))) then
local _v297 = _v340.Parent
if
_v297
and _v297:IsA((_V9({253,17,254,213,204})))
and _v297 ~= _v26.Character
and not _v31:GetPlayerFromCharacter(_v297)
then
current[_v297] = true
if not _v325[_v297] then
_v325[_v297] = _v318(_v12.ESP.OutlineColor)
end
end
end
end
for _v297 in pairs(_v325) do
if not current[_v297] or not _v297.Parent then
_v411(_v297)
end
end
end
local function _v531(_v297, _v169, _v119)
local root = _v173(_v297)
local humanoid = _v297:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
if not _v297.Parent or not root or not _v238(humanoid) then
_v216(_v169)
return
end
if _v152(root) > _v119.MaxDistance then
_v216(_v169)
return
end
_v413(_v169, _v297, _v297.Name, _v119)
end
function ESP:Init()
if _v124 then
return
end
_v124 = Instance.new((_V9({246,17,246,212,197,65})))
_v124.Name = _v10.RandomName()
local _v342 = pcall(function()
_v124.Parent = _v46.getGuiParent()
end)
if not _v342 or not _v124.Parent then
_v124.Parent = _v49
end
_v10.Protect(_v124)
for _, _v384 in ipairs(_v31:GetPlayers()) do
_v57(_v384, _v12.ESP.OutlineColor)
end
end
function ESP:Update(_v119)
local _v414 = {}
for _, _v99 in ipairs(_v9:Get()) do
local _v384 = _v99.Player
if _v384 then
_v414[_v384] = true
local _v169 = _v168[_v384]
if not _v169 then
_v57(_v384, _v119.OutlineColor)
_v169 = _v168[_v384]
end
_v532(_v99, _v169, _v119)
end
end
for _v384, _v169 in pairs(_v168) do
if _v384.Parent ~= _v31 then
_v412(_v384)
elseif not _v414[_v384] then
_v216(_v169)
end
end
if _v119.Enabled and _v119.NPCs then
if os.clock() - _v253 >= _v28 then
_v253 = os.clock()
_v417()
end
for _v297, _v169 in pairs(_v325) do
_v531(_v297, _v169, _v119)
end
elseif next(_v325) then
for _v297 in pairs(_v325) do
_v411(_v297)
end
end
end
function ESP:OnPlayerAdded(_v384)
_v57(_v384, _v12.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v384)
_v412(_v384)
end
function ESP:Cleanup()
for _v384 in pairs(_v168) do
_v412(_v384)
end
for _v297 in pairs(_v325) do
_v411(_v297)
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
_v16 = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v16 = {}
local _v130 = type(Drawing) == (_V9({196,31,248,220,197})) and type(Drawing.new) == (_V9({214,11,244,211,212,90,87,115}))
local _v137 = false
local _v131 = {}
local function _v134()
local _v261 = Drawing.new((_V9({252,23,244,213})))
_v261.Thickness = 1
_v261.Visible = false
return _v261
end
local function _v133(_v384)
local _v169 = {
box = { _v134(), _v134(), _v134(), _v134() },
tracer = _v134(),
}
_v131[_v384] = _v169
return _v169
end
local function _v132(_v169)
for _, _v261 in ipairs(_v169.box) do
_v261.Visible = false
end
_v169.tracer.Visible = false
end
local function _v135(_v384)
local _v169 = _v131[_v384]
if not _v169 then
return
end
_v131[_v384] = nil
for _, _v261 in ipairs(_v169.box) do
_v261:Remove()
end
_v169.tracer:Remove()
end
local function _v136(_v99, _v119, _v94, _v97)
local _v384 = _v99.Player
local _v169 = _v131[_v384]
if _v97.TeamCheck and _v384.Team ~= nil and _v384.Team == _v26.Team then
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
local _v515, onScreen, botV = _v99.TopScreen, _v99.TopOnScreen, _v99.BotScreen
if not _v515 or not onScreen or _v515.Z <= 0 or botV.Z <= 0 then
if _v169 then
_v132(_v169)
end
return
end
_v169 = _v169 or _v133(_v384)
local _v212 = math.abs(botV.Y - _v515.Y)
local _v556 = _v212 * 0.62
local _v128 = (_v515.X + botV.X) * 0.5
local _v257, right = _v128 - _v556 * 0.5, _v128 + _v556 * 0.5
local _v514, bottom = _v515.Y, botV.Y
local box = _v169.box
box[1].From = Vector2.new(_v257, _v514)
box[1].To = Vector2.new(right, _v514)
box[2].From = Vector2.new(_v257, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v257, _v514)
box[3].To = Vector2.new(_v257, bottom)
box[4].From = Vector2.new(right, _v514)
box[4].To = Vector2.new(right, bottom)
for _, _v261 in ipairs(box) do
_v261.Color = _v119.BoxColor
_v261.Visible = _v119.Boxes
end
_v169.tracer.From = Vector2.new(_v94.ViewportSize.X / 2, _v94.ViewportSize.Y)
_v169.tracer.To = Vector2.new(_v128, bottom)
_v169.tracer.Color = _v119.TracerColor
_v169.tracer.Visible = _v119.Tracers
end
function _v16:Update(_v119, _v97)
if not _v130 then
if (_v119.Boxes or _v119.Tracers) and not _v137 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,23,223,6,181,228,210,82,91,120,39,144,59,201,224,128,93,93,120,49,195,94,238,216,197,19,124,111,52,199,23,244,215,128,95,81,127,39,209,12,227,144,66,179,172,61,59,223,10,186,209,214,82,81,113,52,210,18,255,144,201,93,24,105,61,217,13,186,213,216,86,91,104,33,223,12,180})))
_v137 = true
end
return
end
local _v94 = _v49.CurrentCamera
if not _v94 then
return
end
local _v449 = {}
for _, _v99 in ipairs(_v9:Get()) do
if _v99.Player then
_v449[_v99.Player] = true
_v136(_v99, _v119, _v94, _v97)
end
end
for _v384, _v169 in pairs(_v131) do
if _v384.Parent ~= _v31 then
_v135(_v384)
elseif not _v449[_v384] then
_v132(_v169)
end
end
end
function _v16:Cleanup()
for _v384 in pairs(_v131) do
_v135(_v384)
end
end
return _v16
end)()
Visuals = (function()
local _v25 = game:GetService((_V9({252,23,253,216,212,90,86,122})))
local Visuals = {}
local _v25 = game:GetService((_V9({252,23,253,216,212,90,86,122})))
local _v549
local _v25 = game:GetService((_V9({252,23,253,216,212,90,86,122})))
local _v549
local _v546 = false
local _v548 = false
local _v547 = 0
local _v47 = 1
local function _v545()
if _v549 then
return
end
_v549 = {
Brightness = _v25.Brightness,
ClockTime = _v25.ClockTime,
GlobalShadows = _v25.GlobalShadows,
FogEnd = _v25.FogEnd,
FogStart = _v25.FogStart,
Ambient = _v25.Ambient,
OutdoorAmbient = _v25.OutdoorAmbient,
}
end
local function _v543()
_v25.Brightness = 2
_v25.ClockTime = 14
_v25.GlobalShadows = false
end
local function _v544()
_v25.FogEnd = 100000
end
local function _v550()
_v25.Brightness = _v549.Brightness
_v25.ClockTime = _v549.ClockTime
_v25.GlobalShadows = _v549.GlobalShadows
end
local function _v551()
_v25.FogEnd = _v549.FogEnd
_v25.FogStart = _v549.FogStart
end
function Visuals:Update(_v119)
if not (_v119.Fullbright or _v119.NoFog or _v546 or _v548) then
return
end
_v545()
if _v119.Fullbright ~= _v546 then
_v546 = _v119.Fullbright
if _v546 then
_v543()
else
_v550()
end
end
if _v119.NoFog ~= _v548 then
_v548 = _v119.NoFog
if _v548 then
_v544()
else
_v551()
end
end
if (_v546 or _v548) and os.clock() - _v547 >= _v47 then
_v547 = os.clock()
if _v546
and (_v25.Brightness ~= 2 or _v25.ClockTime ~= 14 or _v25.GlobalShadows)
then
_v543()
end
if _v548 and _v25.FogEnd < 100000 then
_v544()
end
end
end
function Visuals:Cleanup()
if _v549 then
if _v546 then
_v550()
end
if _v548 then
_v551()
end
end
_v546 = false
_v548 = false
end
return Visuals
end)()
_v48 = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v48 = {}
_v48.Version = (_V9({128}))
local function _v418()
local _v101 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v184 in ipairs(_v101) do
if type(_v184) == (_V9({214,11,244,211,212,90,87,115})) then
return _v184
end
end
return nil
end
local function _v419()
local _v533 = _v12.Webhook.Url
if type(_v533) == (_V9({195,10,232,217,206,84})) and _v533 ~= (_V9({})) then
return _v533
end
return nil
end
function _v48.SetWebhook(_v533)
_v12.Webhook.Url = tostring(_v533 or (_V9({})))
return true
end
function _v48.HasWebhook()
return _v419() ~= nil
end
function _v48.SendWebhook(content, _v367)
_v367 = _v367 or {}
local _v533 = _v419()
if not _v533 then
return false, (_V9({222,17,197,199,197,81,80,114,58,219}))
end
local _v416 = _v418()
if not _v416 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,27,223,94,210,228,244,99,24,111,48,193,11,255,195,212,19,94,104,59,211,10,243,223,206,19,89,107,52,217,18,251,210,204,86,24,116,59,144,10,242,217,211,19,93,101,48,211,11,238,223,210})))
return false, (_V9({222,17,197,216,212,71,72}))
end
local _v377 = {
username = _v367.username or (_V9({230,31,244,217,212,74,21,90,48,222,27,232,209,204})),
avatar_url = _v367.avatar_url,
content = content,
embeds = _v367.embeds,
}
local _v342, err = pcall(function()
local _v77 = game:GetService((_V9({248,10,238,192,243,86,74,107,60,211,27}))):JSONEncode(_v377)
return _v416({
Url = _v533,
Method = (_V9({224,49,201,228})),
Headers = { [(_V9({243,17,244,196,197,93,76,48,1,201,14,255}))] = (_V9({209,14,234,220,201,80,89,105,60,223,16,181,218,211,92,86})) },
Body = _v77,
})
end)
_v533 = nil
if not _v342 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,2,213,28,242,223,207,88,24,110,48,222,26,186,214,193,90,84,120,49,138})), err)
return false, err
end
return true
end
function _v48.SendLoadedEmbed(_v239)
local _v382 = (_V9({143}))
pcall(function()
_v382 = game:GetService((_V9({253,31,232,219,197,71,72,113,52,211,27,201,213,210,69,81,126,48}))):GetProductInfo(game.PlaceId).Name
end)
return _v48.SendWebhook(nil, {
embeds = {
{
title = (_V9({230,31,244,217,212,74,22,121,48,198,94,221,213,206,86,74,124,57,144,18,245,209,196,86,92})),
color = 8666558,
fields = {
{ name = (_V9({224,18,251,201,197,65})), value = (_V9({208})) .. (_v26 and _v26.Name or (_V9({143}))) .. (_V9({208})), inline = true },
{ name = (_V9({230,27,232,195,201,92,86})), value = (_V9({208,8})) .. tostring(_v48.Version) .. (_V9({208})), inline = true },
{ name = (_V9({247,31,247,213})), value = _v382, inline = false },
{ name = (_V9({224,18,251,211,197,122,92})), value = (_V9({208})) .. tostring(game.PlaceId) .. (_V9({208})), inline = true },
{ name = (_V9({244,27,248,197,199,84,93,121})), value = (_V9({208})) .. tostring(_v239) .. (_V9({208})), inline = true },
},
footer = { text = os.date((_V9({149,39,183,149,205,30,29,121,117,149,54,160,149,237,9,29,78}))) },
},
},
})
end
return _v48
end)()
Triggerbot = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local Triggerbot = {}
local _v498
local _v504 = false
local _v507 = false
local _v501 = nil
local _v499
local _v505 = Random.new()
local _v500 = 0
local _v502 = 0.1
local function _v503()
if _v504 then
return
end
_v504 = true
if type(mouse1click) == (_V9({214,11,244,211,212,90,87,115})) then
_v498 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({214,11,244,211,212,90,87,115})) and type(mouse1release) == (_V9({214,11,244,211,212,90,87,115})) then
_v498 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v506(_v119, _v97)
local _v94 = _v49.CurrentCamera
if not _v94 then
return nil
end
local _v542 = _v94.ViewportSize
local _v401 = _v94:ViewportPointToRay(_v542.X / 2, _v542.Y / 2)
local params = RaycastParams.new()
if _v119.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
else
local _v112 = {}
for _, _v388 in ipairs(_v31:GetPlayers()) do
if _v388 ~= _v26 and _v388.Character then
table.insert(_v112, _v388.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v112
end
local _v420 = _v49:Raycast(_v401.Origin, _v401.Direction * (_v119.MaxDistance or 1000), params)
if not _v420 then
return nil
end
local _v297 = _v420.Instance:FindFirstAncestorOfClass((_V9({253,17,254,213,204})))
local _v388 = _v297 and _v31:GetPlayerFromCharacter(_v297)
if not _v388 or _v388 == _v26 then
return nil
end
if _v97 and _v97.TeamCheck and _v388.Team ~= nil and _v388.Team == _v26.Team then
return nil
end
local _v227 = _v297:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
if not _v227 or _v227.Health <= 0 then
return nil
end
return _v297
end
function Triggerbot:Update(_v119, _v97)
if not _v119.Enabled then
_v501 = nil
return
end
_v503()
if not _v498 then
if not _v507 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,1,194,23,253,215,197,65,90,114,33,144,16,255,213,196,64,24,124,117,221,17,239,195,197,30,91,113,60,211,21,186,214,213,93,91,105,60,223,16,186,152,205,92,77,110,48,129,29,246,217,195,88,17,61,183,48,234,186,222,207,71,24,124,35,209,23,246,209,194,95,93,61,60,222,94,238,216,201,64,24,120,45,213,29,239,196,207,65,22})))
_v507 = true
end
return
end
local target = _v506(_v119, _v97)
if not target then
_v501 = nil
return
end
local _v324 = os.clock()
if not _v501 then
_v501 = _v324
local _v267 = math.min(_v119.MinDelay or 0.1, _v119.MaxDelay or 0.25)
local _v214 = math.max(_v119.MinDelay or 0.1, _v119.MaxDelay or 0.25)
_v499 = _v505:NextNumber(_v267, _v214)
end
if (_v324 - _v501) >= (_v499 or 0) and (_v324 - _v500) >= _v502 then
_v500 = _v324
_v502 = _v505:NextNumber(0.09, 0.17)
_v498()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local _v8 = _v8
local _v10 = _v10
local SilentAim = {}
local _v436 = false
local _v441 = false
local _v434
local _v4 = 500
local _v2 = 12
local _v3 = 200
local function _v437()
local _v111 = _v26.Character
if _v111 then
local _v208 = _v111:FindFirstChild((_V9({248,27,251,212}))) or _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
if _v208 then
return _v208.Position
end
end
local _v96 = _v49.CurrentCamera
return _v96 and _v96.CFrame.Position or Vector3.zero
end
local function _v432(_v111)
if not _v111 then
return nil
end
return _v111:FindFirstChild((_V9({248,27,251,212})))
or _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
or _v111:FindFirstChild((_V9({229,14,234,213,210,103,87,111,38,223})))
or _v111:FindFirstChild((_V9({228,17,232,195,207})))
end
local function _v440()
local target = _v8:GetCurrentTarget()
if target and target.Part and target.Part.Parent then
return target.Part
end
if not _v434 then
return nil
end
local _v268 = _v8:GetLookTarget(_v434.ESP, _v434.Camera)
if typeof(_v268) ~= (_V9({249,16,233,196,193,93,91,120})) then
return nil
end
local _v111 = _v268:IsA((_V9({224,18,251,201,197,65}))) and _v268.Character or _v268
local part = _v432(_v111)
if part and part.Parent then
return part
end
return nil
end
local function _v431(_v370, part)
local _v496 = part.Position
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character, part:FindFirstAncestorOfClass((_V9({253,17,254,213,204}))) or part }
if not _v49:Raycast(_v370, _v496 - _v370, params) then
return _v496
end
local _v292 = (_v370 + _v496) / 2
local _v394 = _v292 + Vector3.new(0, _v4, 0)
local _v181 = math.min(_v370.Y, _v496.Y)
local _v218 = _v49:Raycast(_v394, Vector3.new(0, _v181 - 5 - _v394.Y, 0), params)
local _v105 = math.max(_v370.Y, _v496.Y)
local _v66
if _v218 then
_v66 = _v218.Position.Y + _v2
else
_v66 = _v105 + _v3
end
_v66 = math.clamp(_v66, _v105 + 5, _v105 + _v3)
return Vector3.new(_v292.X, _v66, _v292.Z)
end
local function _v435()
return type(checkcaller) == (_V9({214,11,244,211,212,90,87,115})) and not checkcaller()
end
local _v439 = Random.new()
local function _v438()
local part = _v440()
if not part or not _v434 then
return nil
end
if not part:IsDescendantOf(_v49) then
return nil
end
local _v289 = _v434.SilentAim.MaxAngle or 30
if _v289 < 180 then
local _v94 = _v49.CurrentCamera
if _v94 then
local _v510 = (part.Position - _v94.CFrame.Position).Unit
if _v94.CFrame.LookVector:Dot(_v510) < math.cos(math.rad(_v289)) then
return nil
end
end
end
local _v109 = _v434.SilentAim.HitChance or 100
if _v109 < 100 and _v439:NextNumber(0, 100) > _v109 then
return nil
end
return part
end
function SilentAim:Init(_v119)
_v434 = _v119
end
function SilentAim:Update(_v119)
if _v436 or not _v119.SilentAim.Enabled then
return
end
self:_install()
end
function SilentAim:_install()
if _v436 then
return
end
if type(hookmetamethod) ~= (_V9({214,11,244,211,212,90,87,115})) or type(getnamecallmethod) ~= (_V9({214,11,244,211,212,90,87,115})) then
if not _v441 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,6,217,18,255,222,212,19,121,116,56,144,16,255,213,196,64,24,117,58,223,21,247,213,212,82,85,120,33,216,17,254,144,66,179,172,61,59,223,10,186,209,214,82,81,113,52,210,18,255,144,201,93,24,105,61,217,13,186,213,216,86,91,104,33,223,12,180})))
_v441 = true
end
_v436 = true
return
end
_v436 = true
local function _v163()
return _v434.SilentAim.Enabled
end
local _v433 = false
local function _v424(_v354, self, _v291, part, ...)
if _v291 == (_V9({246,23,232,213,243,86,74,107,48,194})) or _v291 == (_V9({249,16,236,223,203,86,107,120,39,198,27,232})) then
local _v302 = _v437()
local _v60 = _v431(_v302, part)
local _v71 = { ... }
for i, value in ipairs(_v71) do
if typeof(value) == (_V9({230,27,249,196,207,65,11})) then
local _v270 = value.Magnitude
if _v270 > 0.5 and _v270 < 1.5 then
_v71[i] = (_v60 - _v302).Unit
else
_v71[i] = part.Position
end
elseif typeof(value) == (_V9({243,56,232,209,205,86})) then
_v71[i] = part.CFrame
end
end
return table.pack(_v354(self, table.unpack(_v71)))
end
if _v291 == (_V9({226,31,227,211,193,64,76})) and self == _v49 then
local _v370, _v149, params = ...
if typeof(_v370) == (_V9({230,27,249,196,207,65,11})) and typeof(_v149) == (_V9({230,27,249,196,207,65,11})) then
local _v60 = _v431(_v370, part)
local _v74 = (_v60 - _v370).Unit * _v149.Magnitude
return table.pack(_v354(self, _v370, _v74, params))
end
end
return nil
end
local _v354
_v354 = hookmetamethod(game, (_V9({239,33,244,209,205,86,91,124,57,220})), _v10.CClosure(function(self, ...)
if _v433 then
return _v354(self, ...)
end
if _v163() and _v435() then
local _v71 = table.pack(...)
_v433 = true
local _v342, packed = pcall(function()
local part = _v438()
if not part then
return nil
end
return _v424(_v354, self, getnamecallmethod(), part, table.unpack(_v71, 1, _v71.n))
end)
_v433 = false
if _v342 and packed then
return table.unpack(packed, 1, packed.n)
end
end
return _v354(self, ...)
end))
local _v298 = _v26:GetMouse()
local _v353
_v353 = hookmetamethod(game, (_V9({239,33,243,222,196,86,64})), _v10.CClosure(function(self, _v247)
if _v433 then
return _v353(self, _v247)
end
if _v163() and _v435() and self == _v298 then
_v433 = true
local _v342, part = pcall(_v438)
_v433 = false
if _v342 and part then
if _v247 == (_V9({248,23,238})) then
return part.CFrame
end
if _v247 == (_V9({228,31,232,215,197,71})) then
return part
end
end
end
return _v353(self, _v247)
end))
end
return SilentAim
end)()
Hitbox = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v22 = {}
local _v205 = {}
local function _v206(_v111)
local _v371 = _v205[_v111]
if not _v371 then
return
end
_v205[_v111] = nil
local root = _v371.root
if root and root.Parent then
root.Size = _v371.size
root.Transparency = _v371.transparency
root.CanCollide = _v371.canCollide
end
end
local function _v207()
for _v111 in pairs(_v205) do
_v206(_v111)
end
end
local function _v204(_v99, _v119, _v449)
local root = _v99.HRP
if not root then
return
end
local _v111 = _v99.Character
_v449[_v111] = true
if not _v205[_v111] then
_v205[_v111] = {
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
function _v22:Update(_v119, _v97)
if not _v119.Enabled then
_v207()
return
end
local _v449 = {}
for _, _v99 in ipairs(_v9:Get()) do
local _v384 = _v99.Player
if not (_v97.TeamCheck and _v384 and _v384.Team ~= nil and _v384.Team == _v26.Team) then
_v204(_v99, _v119, _v449)
end
end
for _v111 in pairs(_v205) do
if not _v449[_v111] then
_v206(_v111)
end
end
end
function _v22:Cleanup()
_v207()
end
return _v22
end)()
NoRecoil = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v45 = game:GetService((_V9({229,13,255,194,233,93,72,104,33,227,27,232,198,201,80,93})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local NoRecoil = {}
local function _v240()
return _v45:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v73 = nil
local function _v98(_v94)
local _v268 = _v94.CFrame.LookVector
return math.asin(math.clamp(_v268.Y, -1, 1))
end
function NoRecoil:Update(_v119, _v61)
if not _v119.Enabled then
_v73 = nil
return
end
local _v94 = _v49.CurrentCamera
if not _v94 then
_v73 = nil
return
end
if _v119.RequireMouseDown and not _v240() then
_v73 = nil
return
end
local _v110 = _v26.Character
local _v227 = _v110 and _v110:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
if _v227 then
_v227.CameraOffset = Vector3.new(0, 0, 0)
end
if _v61 then
_v73 = nil
return
end
local _v477 = math.clamp(_v119.Strength, 0, 1)
if _v477 <= 0 then
_v73 = nil
return
end
local _v381 = _v98(_v94)
if _v73 == nil then
_v73 = _v381
return
end
local _v158 = _v381 - _v73
if _v119.AllowAim and _v158 < 0 then
_v73 = _v381
return
end
if _v158 ~= 0 then
_v94.CFrame = _v94.CFrame * CFrame.Angles(-_v158 * _v477, 0, 0)
end
end
function NoRecoil:Reset()
_v73 = nil
end
NoRecoil.IsFiring = _v240
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local _v10 = _v10
local NoSpread = {}
local _v326 = false
local _v338 = false
local _v330 = false
local _v336 = false
local _v337 = 1
local _v332 = nil
local _v334 = nil
local _v333 = nil
local function _v327()
if type(hookfunction) == (_V9({214,11,244,211,212,90,87,115})) then
return hookfunction
elseif type(replaceclosure) == (_V9({214,11,244,211,212,90,87,115})) then
return replaceclosure
end
return nil
end
local function _v331(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v335(_v371, _v107, _v242)
local v = _v371 + (_v107 - _v371) * _v337
if _v242 then
return math.floor(v + 0.5)
end
return v
end
local function _v328(_v221)
if _v330 then
return
end
local _v371 = math.random
_v332 = _v371
local _v415 = _v10.CClosure(function(...)
local value = _v332(...)
if _v326 and _v337 > 0 then
local a, b = ...
return _v335(value, _v331(a, b), a ~= nil)
end
return value
end)
local _v342, ret = pcall(_v221, math.random, _v415)
if _v342 then
if type(ret) == (_V9({214,11,244,211,212,90,87,115})) and ret ~= _v415 then
_v332 = ret
end
_v330 = true
end
end
local function _v329(_v221)
if _v336 then
return
end
local _v342 = pcall(function()
local _v442 = Random.new()
local _v369 = _v442.NextNumber
local _v368 = _v442.NextInteger
_v334 = _v369
_v333 = _v368
local _v339 = _v10.CClosure(function(self, ...)
local _v371 = _v334(self, ...)
if _v326 and _v337 > 0 then
local _v295, mx = ...
local _v107 = (_v295 == nil) and 0.5 or ((_v295 + mx) / 2)
return _v335(_v371, _v107, false)
end
return _v371
end)
local _v423 = _v221(_v442.NextNumber, _v339)
if type(_v423) == (_V9({214,11,244,211,212,90,87,115})) and _v423 ~= _v339 then
_v334 = _v423
end
local _v236 = _v10.CClosure(function(self, ...)
local _v371 = _v333(self, ...)
if _v326 and _v337 > 0 then
local _v295, mx = ...
return _v335(_v371, (_v295 + mx) / 2, true)
end
return _v371
end)
local _v422 = _v221(_v442.NextInteger, _v236)
if type(_v422) == (_V9({214,11,244,211,212,90,87,115})) and _v422 ~= _v236 then
_v333 = _v422
end
end)
if _v342 then
_v336 = true
end
end
function NoSpread:_install()
if _v330 or _v336 then
return true
end
local _v221 = _v327()
if not _v221 then
if not _v338 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,27,223,94,201,192,210,86,89,121,117,222,27,255,212,211,19,94,104,59,211,10,243,223,206,19,80,114,58,219,23,244,215,128,27,80,114,58,219,24,239,222,195,71,81,114,59,153,94,120,48,52,19,86,114,33,144,31,236,209,201,95,89,127,57,213,94,243,222,128,71,80,116,38,144,27,226,213,195,70,76,114,39,158})))
_v338 = true
end
return false
end
_v328(_v221)
_v329(_v221)
if not (_v330 or _v336) then
if not _v338 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,27,223,94,201,192,210,86,89,121,111,144,24,251,217,204,86,92,61,33,223,94,243,222,211,71,89,113,57,144,31,244,201,128,91,87,114,62,158})))
_v338 = true
end
return false
end
return true
end
function NoSpread:Update(_v119)
_v337 = math.clamp(_v119.Strength or 1, 0, 1)
if _v119.Enabled then
if not (_v330 or _v336) and not self:_install() then
return
end
_v326 = (not _v119.RequireMouseDown) or NoRecoil.IsFiring()
else
_v326 = false
end
end
function NoSpread:Cleanup()
_v326 = false
local _v221 = _v327()
if not _v221 then
return
end
local _v348, errMath = pcall(function()
if _v330 and _v332 then
_v221(math.random, _v332)
_v330 = false
end
end)
if not _v348 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,27,223,45,234,194,197,82,92,61,56,209,10,242,158,210,82,86,121,58,221,94,232,213,211,71,87,111,48,144,24,251,217,204,86,92,39})), errMath)
end
local _v349, errRand = pcall(function()
if _v336 then
local _v442 = Random.new()
if _v334 then
_v221(_v442.NextNumber, _v334)
end
if _v333 then
_v221(_v442.NextInteger, _v333)
end
_v336 = false
end
end)
if not _v349 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,27,223,45,234,194,197,82,92,61,7,209,16,254,223,205,19,74,120,38,196,17,232,213,128,85,89,116,57,213,26,160})), errRand)
end
end
return NoSpread
end)()
UI = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v45 = game:GetService((_V9({229,13,255,194,233,93,72,104,33,227,27,232,198,201,80,93})))
local _v44 = game:GetService((_V9({228,9,255,213,206,96,93,111,35,217,29,255})))
local _v37 = game:GetService((_V9({226,11,244,227,197,65,78,116,54,213})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local _v11 = _v11
local _v46 = _v46
local _v48 = _v48
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
local _v202
local _v271
local _v557
local _v127 = (_V9({243,17,247,210,193,71}))
local _v256 = 0
local _v541 = false
local _v55
local _v361
local _v523 = {}
local _v300 = {}
local _v410 = {}
local _v484 = {}
local _v495, targetPanelLabel
local _v494 = false
local _v250
local _v552
local _v190, fpsLabel
local _v54
local _v103 = false
local _v56 = nil
local _v387 = {}
local _v386
local _v453
local _v466
local _v465
local _v378 = nil
local function _v68(_v317)
local _v352 = _v6.accent
if _v317 == _v352 then
return
end
_v6.accent = _v317
if _v55 and _v55.UI then
_v55.UI.Accent = _v317
end
if not _v202 then
return
end
_v378 = _v317
task.defer(function()
if _v378 ~= _v317 then
return
end
_v378 = nil
for _, _v234 in ipairs(_v202:GetDescendants()) do
if _v234:IsA((_V9({247,11,243,255,194,89,93,126,33}))) then
if _v234.BackgroundColor3 == _v352 then
_v234.BackgroundColor3 = _v317
end
if (_v234:IsA((_V9({228,27,226,196,236,82,90,120,57}))) or _v234:IsA((_V9({228,27,226,196,226,70,76,105,58,222}))) or _v234:IsA((_V9({228,27,226,196,226,92,64}))))
and _v234.TextColor3 == _v352
then
_v234.TextColor3 = _v317
end
if _v234:IsA((_V9({227,29,232,223,204,95,81,115,50,246,12,251,221,197}))) and _v234.ScrollBarImageColor3 == _v352 then
_v234.ScrollBarImageColor3 = _v317
end
elseif _v234:IsA((_V9({229,55,201,196,210,92,83,120}))) and _v234.Color == _v352 then
_v234.Color = _v317
end
end
end)
end
local function _v406()
if _v465 then
_v465.Text = _v466 and (_V9({227,10,245,192,128,96,72,120,54,196,31,238,217,206,84})) or (_V9({227,14,255,211,212,82,76,120}))
end
end
local function _v476()
if not _v466 then
return
end
_v466 = nil
local _v94 = _v49.CurrentCamera
local _v111 = _v26.Character
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
if _v94 and humanoid then
_v94.CameraSubject = humanoid
end
_v406()
end
local function _v474(_v384)
local _v111 = _v384 and _v384.Character
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
local _v94 = _v49.CurrentCamera
if not (_v94 and humanoid) then
return
end
_v466 = _v384
_v94.CameraSubject = humanoid
_v406()
end
function UI.IsSpectating()
return _v466 ~= nil
end
local function _v319(_v115, _v395)
local _v234 = Instance.new(_v115)
for k, v in pairs(_v395) do
_v234[k] = v
end
return _v234
end
local function _v321()
_v256 = _v256 + 1
return _v256
end
local function _v244(_v232)
return _v232.UserInputType == Enum.UserInputType.MouseButton1
or _v232.UserInputType == Enum.UserInputType.Touch
end
local function _v243(_v232)
return _v232.UserInputType == Enum.UserInputType.MouseMovement
or _v232.UserInputType == Enum.UserInputType.Touch
end
local function _v472()
table.insert(_v523, _v45.InputChanged:Connect(function(_v232)
if not _v243(_v232) then
return
end
for _, _v184 in ipairs(_v300) do
_v184(_v232)
end
end))
table.insert(_v523, _v45.InputEnded:Connect(function(_v232)
if not _v244(_v232) then
return
end
for _, _v184 in ipairs(_v410) do
_v184(_v232)
end
end))
table.insert(_v523, _v45.InputBegan:Connect(function(_v232)
if not _v56 or not _v244(_v232) then
return
end
local _v389 = Vector2.new(_v232.Position.X, _v232.Position.Y)
if not _v56.contains(_v389) then
_v56.close()
end
end))
table.insert(_v523, _v45.InputBegan:Connect(function(_v232)
if not _v54 then
return
end
if _v232.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v247 = _v232.KeyCode
if _v247 == Enum.KeyCode.Unknown then
return
end
if _v247 == Enum.KeyCode.Escape then
_v54.finish(nil)
else
_v54.finish(_v247)
end
end))
end
local function _v286(_v374, text, _v199, _v356)
local btn = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v319((_V9({246,12,251,221,197})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v199() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = box, Color = _v6.border, Thickness = 1 })
local _v251 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v199() and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local function _v403()
local _v355 = _v199()
_v44:Create(box, _v1, { BackgroundColor3 = _v355 and _v6.accent or _v6.off }):Play()
_v44:Create(_v251, _v1, { TextColor3 = _v355 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v356()
_v403()
end)
btn.MouseEnter:Connect(function()
if not _v199() then
box.BackgroundColor3 = _v6.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v199() then
box.BackgroundColor3 = _v6.off
end
end)
table.insert(_v484, _v403)
end
local function _v283(_v374, text, _v293, _v288, _v199, _v457, _v242, _v479)
_v479 = _v479 or (_V9({}))
local _v220 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
local _v251 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v220,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v519 = _v319((_V9({246,12,251,221,197})), {
Parent = _v220,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v519, CornerRadius = UDim.new(1, 0) })
local _v179 = _v319((_V9({246,12,251,221,197})), {
Parent = _v519,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v179, CornerRadius = UDim.new(1, 0) })
local function _v185(v)
local _v72 = _v242 and tostring(math.floor(v + 0.5)) or string.format((_V9({149,80,168,214})), v)
return _v72 .. _v479
end
local function _v67(v)
v = math.clamp(v, _v293, _v288)
if _v242 then
v = math.floor(v + 0.5)
end
local _v63 = (_v288 > _v293) and (v - _v293) / (_v288 - _v293) or 0
_v179.Size = UDim2.new(_v63, 0, 1, 0)
_v251.Text = text .. (_V9({138,94})) .. _v185(v)
_v457(v)
end
_v67(_v199())
local _v156 = false
local function _v192(_v399)
local _v63 = math.clamp((_v399 - _v519.AbsolutePosition.X) / _v519.AbsoluteSize.X, 0, 1)
_v67(_v293 + _v63 * (_v288 - _v293))
end
_v519.InputBegan:Connect(function(_v232)
if _v244(_v232) then
_v156 = true
_v192(_v232.Position.X)
end
end)
table.insert(_v300, function(_v232)
if _v156 then
_v192(_v232.Position.X)
end
end)
table.insert(_v410, function()
_v156 = false
end)
table.insert(_v484, function()
_v67(_v199())
end)
end
local function _v275(_v374, text, _v366, _v199, _v356)
local _v220 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v220,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v160 = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v220,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.text,
Text = _v199(),
ZIndex = 3,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v160, CornerRadius = UDim.new(0, 4) })
local _v362 = false
local _v36 = 24
local _v194 = #_v366 * _v36
local _v265 = math.min(_v194, 7 * _v36)
local _v262 = _v319((_V9({227,29,232,223,204,95,81,115,50,246,12,251,221,197})), {
Parent = _v160,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v194),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v6.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v262, CornerRadius = UDim.new(0, 4) })
for i, _v363 in ipairs(_v366) do
local _v364 = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v262,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.text,
Text = _v363,
AutoButtonColor = false,
ZIndex = 11,
})
_v364.MouseButton1Click:Connect(function()
_v356(_v363)
_v160.Text = _v363
_v362 = false
_v44:Create(_v262, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v362 then
_v262.Visible = false
end
end)
end)
_v364.MouseEnter:Connect(function()
_v364.BackgroundColor3 = _v6.rowHover
end)
_v364.MouseLeave:Connect(function()
_v364.BackgroundColor3 = _v6.off
end)
end
_v160.MouseButton1Click:Connect(function()
_v362 = not _v362
if _v362 then
_v262.Visible = true
_v44:Create(_v262, _v1, { Size = UDim2.new(1, 0, 0, _v265) }):Play()
else
_v44:Create(_v262, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v362 then
_v262.Visible = false
end
end)
end
end)
table.insert(_v484, function()
_v160.Text = _v199()
end)
end
local function _v282(_v374, text, _v231)
local _v220 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v220,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local value = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v220,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v231,
})
return value
end
local function _v272(_v374, text, _v357, color)
local _v72 = color or _v6.accent
local _v223 = Color3.new(
math.min(_v72.R + 0.1, 1),
math.min(_v72.G + 0.1, 1),
math.min(_v72.B + 0.1, 1)
)
local btn = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v72,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v357)
btn.MouseEnter:Connect(function()
_v44:Create(btn, _v1, { BackgroundColor3 = _v223 }):Play()
end)
btn.MouseLeave:Connect(function()
_v44:Create(btn, _v1, { BackgroundColor3 = _v72 }):Play()
end)
return btn
end
local function _v285(_v374, _v383)
local _v220 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
local _v478 = _v319((_V9({229,55,201,196,210,92,83,120})), {
Parent = _v220,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v319((_V9({228,27,226,196,226,92,64})), {
Parent = _v220,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
PlaceholderText = _v383 or (_V9({})),
PlaceholderColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v44:Create(_v478, _v1, { Transparency = 0, Color = _v6.accent }):Play()
end)
box.FocusLost:Connect(function()
_v44:Create(_v478, _v1, { Transparency = 0.3, Color = _v6.border }):Play()
end)
return box
end
local function _v279(_v374, text)
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v277(_v374, text, _v293, _v288, _v199, _v457, _v242, _v525, _v460)
_v525 = _v525 or (_V9({}))
local _v220 = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
local _v179 = _v319((_V9({246,12,251,221,197})), {
Parent = _v220,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v179, CornerRadius = UDim.new(0, 6) })
local _v251 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v220,
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
local function _v183(v)
local s = _v242 and tostring(math.floor(v + 0.5)) or string.format((_V9({149,80,168,214})), v)
if _v460 then
local m = _v242 and tostring(math.floor(_v288 + 0.5)) or string.format((_V9({149,80,168,214})), _v288)
return s .. (_V9({159})) .. m .. _v525
end
return s .. _v525
end
local function _v67(v)
v = math.clamp(v, _v293, _v288)
if _v242 then
v = math.floor(v + 0.5)
end
local _v63 = (_v288 > _v293) and (v - _v293) / (_v288 - _v293) or 0
_v179.Size = UDim2.new(_v63, 0, 1, 0)
_v251.Text = text .. (_V9({138,94})) .. _v183(v)
_v457(v)
end
_v67(_v199())
local _v156 = false
local function _v192(_v399)
local _v63 = math.clamp((_v399 - _v220.AbsolutePosition.X) / _v220.AbsoluteSize.X, 0, 1)
_v67(_v293 + _v63 * (_v288 - _v293))
end
_v220.InputBegan:Connect(function(_v232)
if _v244(_v232) then
_v156 = true
_v192(_v232.Position.X)
end
end)
table.insert(_v300, function(_v232)
if _v156 then
_v192(_v232.Position.X)
end
end)
table.insert(_v410, function()
_v156 = false
end)
table.insert(_v484, function()
_v67(_v199())
end)
end
local function _v276(_v374, _v366, _v199, _v356)
local _v220 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = _v220,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v160 = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v220,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v160, CornerRadius = UDim.new(0, 6) })
local _v159 = _v319((_V9({229,55,201,196,210,92,83,120})), {
Parent = _v160,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local _v537 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v160,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v199(),
})
local _v104 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v160,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.accent,
Text = (_V9({82,232,36})),
})
local _v362 = false
local _v36 = 26
local _v194 = #_v366 * _v36
local _v265 = math.min(_v194, 6 * _v36)
local _v262 = _v319((_V9({227,29,232,223,204,95,81,115,50,246,12,251,221,197})), {
Parent = _v220,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v194),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v6.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v262, CornerRadius = UDim.new(0, 6) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v262, Color = _v6.border, Thickness = 1, Transparency = 0.2 })
local _v365 = {}
local function _v373()
local current = _v199()
for _v363, btn in pairs(_v365) do
local _v451 = (_v363 == current)
btn.BackgroundColor3 = _v451 and _v6.accent or _v6.panel
btn.BackgroundTransparency = _v451 and 0 or 1
btn.TextColor3 = _v451 and Color3.fromRGB(255, 255, 255) or _v6.textSub
btn.Font = _v451 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v117()
if not _v362 then
return
end
_v362 = false
if _v56 and _v56.frame == _v160 then
_v56 = nil
end
_v44:Create(_v104, _v1, { Rotation = 0 }):Play()
_v44:Create(_v159, _v1, { Transparency = 0.3 }):Play()
_v44:Create(_v262, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v362 then
_v262.Visible = false
end
end)
end
local function _v175()
if _v362 then
return
end
if _v56 and _v56.close then
_v56.close()
end
_v362 = true
_v373()
_v262.Visible = true
_v44:Create(_v104, _v1, { Rotation = 180 }):Play()
_v44:Create(_v159, _v1, { Transparency = 0 }):Play()
_v44:Create(_v262, _v1, { Size = UDim2.new(1, 0, 0, _v265) }):Play()
_v56 = {
frame = _v160,
close = _v117,
contains = function(_v389)
local function _v233(_v340)
local p, s = _v340.AbsolutePosition, _v340.AbsoluteSize
return _v389.X >= p.X and _v389.X <= p.X + s.X and _v389.Y >= p.Y and _v389.Y <= p.Y + s.Y
end
return _v233(_v160) or (_v262.Visible and _v233(_v262))
end,
}
end
for i, _v363 in ipairs(_v366) do
local _v364 = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v262,
Size = UDim2.new(1, 0, 0, _v36),
Position = UDim2.fromOffset(0, (i - 1) * _v36),
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
Text = _v363,
AutoButtonColor = false,
})
_v365[_v363] = _v364
_v364.MouseButton1Click:Connect(function()
_v356(_v363)
_v537.Text = _v363
_v373()
_v117()
end)
_v364.MouseEnter:Connect(function()
if _v363 ~= _v199() then
_v364.BackgroundTransparency = 0
_v364.BackgroundColor3 = _v6.rowHover
_v364.TextColor3 = _v6.text
end
end)
_v364.MouseLeave:Connect(function()
_v373()
end)
end
_v373()
_v160.MouseButton1Click:Connect(function()
if _v362 then
_v117()
else
_v175()
end
end)
_v160.MouseEnter:Connect(function()
if not _v362 then
_v44:Create(_v160, _v1, { BackgroundColor3 = _v6.rowHover }):Play()
end
end)
_v160.MouseLeave:Connect(function()
if not _v362 then
_v44:Create(_v160, _v1, { BackgroundColor3 = _v6.row }):Play()
end
end)
table.insert(_v484, function()
_v537.Text = _v199()
_v373()
end)
end
local function _v273(_v374, title, _v197, _v454)
local h, s, v = _v197():ToHSV()
local _v39, _v21, GAP = 120, 16, 8
local _v220 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, _v39 + 74),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v220, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = _v220,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v209 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v220,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({243,17,246,223,210})),
})
local _v77 = _v319((_V9({246,12,251,221,197})), {
Parent = _v220,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v469 = _v319((_V9({246,12,251,221,197})), {
Parent = _v77,
Size = UDim2.new(1, -(_v21 + GAP), 0, _v39),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v469, CornerRadius = UDim.new(0, 4) })
local _v444 = _v319((_V9({246,12,251,221,197})), {
Parent = _v469,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v444, CornerRadius = UDim.new(0, 4) })
_v319((_V9({229,55,221,194,193,87,81,120,59,196})), {
Parent = _v444,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v536 = _v319((_V9({246,12,251,221,197})), {
Parent = _v469,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v536, CornerRadius = UDim.new(0, 4) })
_v319((_V9({229,55,221,194,193,87,81,120,59,196})), {
Parent = _v536,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v481 = _v319((_V9({246,12,251,221,197})), {
Parent = _v469,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v481, CornerRadius = UDim.new(1, 0) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v481, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v224 = _v319((_V9({246,12,251,221,197})), {
Parent = _v77,
Size = UDim2.fromOffset(_v21, _v39),
Position = UDim2.new(1, -_v21, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v224, CornerRadius = UDim.new(0, 4) })
_v319((_V9({229,55,221,194,193,87,81,120,59,196})), {
Parent = _v224,
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
local _v225 = _v319((_V9({246,12,251,221,197})), {
Parent = _v224,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v225, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v392 = _v319((_V9({246,12,251,221,197})), {
Parent = _v77,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v39 + 6),
BackgroundColor3 = _v197(),
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v392, CornerRadius = UDim.new(0, 4) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v392, Color = _v6.off, Thickness = 1 })
local _v213 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v77,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v39 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v403(_v561)
local _v116 = Color3.fromHSV(h, s, v)
if _v561 ~= false then
_v454(_v116)
end
_v469.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v481.Position = UDim2.new(s, 0, 1 - v, 0)
_v225.Position = UDim2.new(0.5, 0, h, 0)
_v392.BackgroundColor3 = _v116
local r = math.floor(_v116.R * 255 + 0.5)
local g = math.floor(_v116.G * 255 + 0.5)
local b = math.floor(_v116.B * 255 + 0.5)
_v213.Text = string.format((_V9({147,91,170,130,248,22,8,47,13,149,78,168,232,128,19,16,56,49,156,94,191,212,140,19,29,121,124})), r, g, b, r, g, b)
end
_v403(false)
local _v482, hueDrag = false, false
local function _v483(_v399, _v400)
s = math.clamp((_v399 - _v469.AbsolutePosition.X) / _v469.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v400 - _v469.AbsolutePosition.Y) / _v469.AbsoluteSize.Y, 0, 1)
_v403()
end
local function _v226(_v400)
h = math.clamp((_v400 - _v224.AbsolutePosition.Y) / _v224.AbsoluteSize.Y, 0, 1)
_v403()
end
_v469.InputBegan:Connect(function(_v232)
if _v244(_v232) then
_v482 = true
_v483(_v232.Position.X, _v232.Position.Y)
end
end)
_v224.InputBegan:Connect(function(_v232)
if _v244(_v232) then
hueDrag = true
_v226(_v232.Position.Y)
end
end)
table.insert(_v300, function(_v232)
if _v482 then
_v483(_v232.Position.X, _v232.Position.Y)
end
if hueDrag then
_v226(_v232.Position.Y)
end
end)
table.insert(_v410, function()
_v482, hueDrag = false, false
end)
table.insert(_v484, function()
h, s, v = _v197():ToHSV()
_v403(false)
end)
end
local function _v558(box, _v252, _v198, _v456, _v121)
local _v266 = false
local function _v403()
if _v266 then
box.Text = (_V9({224,12,255,195,211,209,184,187}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v6.accent
else
box.Text = _v198().Name
box.TextColor3 = _v6.accent
box.BackgroundColor3 = _v6.bar
end
end
local _v102 = {}
function _v102.finish(_v247)
_v266 = false
_v54 = nil
task.defer(function()
_v103 = false
end)
if _v247 then
local _v120 = _v121 and _v121(_v247)
if _v120 then
UI:Notify(string.format((_V9({149,13,186,217,211,19,89,113,39,213,31,254,201,128,81,87,104,59,212,94,238,223,128,22,75})), _v247.Name, _v120), 2.5)
else
_v456(_v247)
UI:Notify(string.format((_V9({149,13,186,210,207,70,86,121,117,196,17,186,149,211})), _v252, _v247.Name), 2)
end
end
_v403()
end
function _v102.cancel()
_v266 = false
_v403()
end
box.MouseButton1Click:Connect(function()
if _v266 then
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
_v266 = true
_v403()
end)
box.MouseEnter:Connect(function()
if not _v266 then
box.BackgroundColor3 = _v6.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v266 then
box.BackgroundColor3 = _v6.bar
end
end)
table.insert(_v484, function()
if _v54 == _v102 then
_v54 = nil
task.defer(function()
_v103 = false
end)
_v266 = false
end
_v403()
end)
_v403()
end
local function _v248(_v119, _v247, _v178)
if _v178 ~= (_V9({221,27,244,197})) and _v119.UI.MenuKey == _v247 then
return (_V9({253,27,244,197}))
end
if _v178 ~= (_V9({209,23,247,210,207,71})) and _v119.Camera.ToggleKey == _v247 then
return (_V9({241,23,247,210,207,71}))
end
if _v178 ~= (_V9({213,13,234})) and _v119.ESP.ToggleKey == _v247 then
return (_V9({245,45,202}))
end
if _v178 ~= (_V9({214,17,236,211,201,65,91,113,48})) and _v119.Camera.FOVCircleKey == _v247 then
return (_V9({246,49,204,144,227,90,74,126,57,213}))
end
if _v178 ~= (_V9({222,17,232,213,195,92,81,113})) and _v119.NoRecoil.ToggleKey == _v247 then
return (_V9({254,17,186,226,197,80,87,116,57}))
end
if _v178 ~= (_V9({222,17,233,192,210,86,89,121})) and _v119.NoSpread.ToggleKey == _v247 then
return (_V9({254,17,186,227,208,65,93,124,49}))
end
if _v178 ~= (_V9({196,12,243,215,199,86,74,127,58,196})) and _v119.Triggerbot.ToggleKey == _v247 then
return (_V9({228,12,243,215,199,86,74,127,58,196}))
end
if _v178 ~= (_V9({211,18,243,211,203,71,72})) and _v119.Movement.ClickTPKey == _v247 then
return (_V9({243,18,243,211,203,19,108,77}))
end
if _v178 ~= (_V9({197,16,246,223,193,87})) and _v119.UI.UnloadKey == _v247 then
return (_V9({229,16,246,223,193,87}))
end
return nil
end
local function _v281(_v374, _v252, _v198, _v456, _v121)
local _v220 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v220,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v252,
})
local box = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v220,
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
Text = _v198().Name,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v319((_V9({229,55,201,217,218,86,123,114,59,195,10,232,209,201,93,76})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v558(box, _v252, _v198, _v456, _v121)
end
local function _v287(_v374, text, _v199, _v356, _v249, _v198, _v456, _v121)
local btn = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v113 = _v319((_V9({246,12,251,221,197})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v199() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v113, CornerRadius = UDim.new(0, 3) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v113, Color = _v6.border, Thickness = 1 })
local _v251 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v199() and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local box = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
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
Text = _v198().Name,
ZIndex = 3,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v319((_V9({229,55,201,217,218,86,123,114,59,195,10,232,209,201,93,76})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v403()
local _v355 = _v199()
_v44:Create(_v113, _v1, { BackgroundColor3 = _v355 and _v6.accent or _v6.off }):Play()
_v44:Create(_v251, _v1, { TextColor3 = _v355 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v356()
_v403()
end)
table.insert(_v484, _v403)
_v558(box, _v249, _v198, _v456, _v121)
end
local function _v274(_v374)
local function _v118(order)
local _v116 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = _v116,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v116
end
return _v118(1), _v118(2)
end
local function _v278(_v374, title)
local _v560 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v319((_V9({246,12,251,221,197})), {
Parent = _v560,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = box, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
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
local _v539 = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v560,
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
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v539, CornerRadius = UDim.new(0, 6) })
local _v40, GAP = 0.72, 1
local _v203 = _v319((_V9({246,12,251,221,197})), {
Parent = _v539,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v6.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v203, CornerRadius = UDim.new(0, 6) })
_v319((_V9({229,55,221,194,193,87,81,120,59,196})), {
Parent = _v203,
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
local function _v485()
local _v445 = (_v557 and _v557.Scale) or 1
if _v445 <= 0 then
_v445 = 1
end
_v560.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v445)
end
box:GetPropertyChangedSignal((_V9({241,28,233,223,204,70,76,120,6,217,4,255}))):Connect(_v485)
_v485()
local function _v455(_v163)
_v539.Visible = not _v163
end
return box, _v455
end
local function _v284(_v374)
local bar = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v153 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v6.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v70 = _v319((_V9({246,12,251,221,197})), {
Parent = _v374,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v222 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v222.current = name
for n, f in pairs(_v222.frames) do
f.Visible = (n == name)
end
for n, b in pairs(_v222.buttons) do
local _v53 = (n == name)
_v44:Create(b.btn, _v1, { TextColor3 = _v53 and _v6.text or _v6.textSub }):Play()
_v44:Create(b.underline, _v1, { BackgroundTransparency = _v53 and 0 or 1 }):Play()
end
end
function _v222:add(name)
self.order = self.order + 1
local btn = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
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
local underline = _v319((_V9({246,12,251,221,197})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v319((_V9({227,29,232,223,204,95,81,115,50,246,12,251,221,197})), {
Parent = _v70,
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
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v319((_V9({229,55,202,209,196,87,81,115,50})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = btn, underline = underline }
self.frames[name] = frame
btn.MouseButton1Click:Connect(function()
select(name)
end)
btn.MouseEnter:Connect(function()
if _v222.current ~= name then
btn.TextColor3 = _v6.text
end
end)
btn.MouseLeave:Connect(function()
if _v222.current ~= name then
btn.TextColor3 = _v6.textSub
end
end)
if not self.current then
select(name)
end
return frame
end
return _v222
end
local function _v83(_v374, _v119)
_v256 = 0
local _v222 = _v284(_v374)
local _v257, right = _v274(_v222:add((_V9({241,23,247,210,207,71}))))
local _v58 = _v278(_v257, (_V9({241,23,247,210,207,71})))
_v287(_v58, (_V9({245,16,251,210,204,86,92})), function()
return _v119.Camera.Enabled
end, function()
_v119.Camera.Enabled = not _v119.Camera.Enabled
end, (_V9({241,23,247,210,207,71,24,86,48,201})), function()
return _v119.Camera.ToggleKey
end, function(_v247)
_v119.Camera.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({209,23,247,210,207,71})))
end)
_v286(_v58, (_V9({230,23,233,211,200,86,91,118})), function()
return _v119.Camera.WallCheck
end, function()
_v119.Camera.WallCheck = not _v119.Camera.WallCheck
end)
_v286(_v58, (_V9({228,31,232,215,197,71,24,95,58,196,13})), function()
return _v119.Camera.TargetBots
end, function()
_v119.Camera.TargetBots = not _v119.Camera.TargetBots
end)
_v286(_v58, (_V9({228,27,251,221,128,112,80,120,54,219})), function()
return _v119.Camera.TeamCheck
end, function()
_v119.Camera.TeamCheck = not _v119.Camera.TeamCheck
end)
_v287(_v58, (_V9({246,49,204,144,227,90,74,126,57,213})), function()
return _v119.Camera.FOVCircle
end, function()
_v119.Camera.FOVCircle = not _v119.Camera.FOVCircle
end, (_V9({246,49,204,144,227,90,74,126,57,213,94,209,213,217})), function()
return _v119.Camera.FOVCircleKey
end, function(_v247)
_v119.Camera.FOVCircleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({214,17,236,211,201,65,91,113,48})))
end)
_v277(_v58, (_V9({227,19,245,223,212,91,86,120,38,195})), 0.05, 1, function()
return _v119.Camera.Smoothness
end, function(_v535)
_v119.Camera.Smoothness = _v535
end, false)
_v277(_v58, (_V9({246,49,204})), 20, 800, function()
return _v119.Camera.FOV
end, function(_v535)
_v119.Camera.FOV = _v535
end, true, (_V9({192,6})), true)
_v277(_v58, (_V9({253,31,226,144,228,90,75,105,52,222,29,255})), 100, 2000, function()
return _v119.Camera.MaxDistance
end, function(_v535)
_v119.Camera.MaxDistance = _v535
end, true, (_V9({221})), true)
local _v407
local _v219 = _v278(right, (_V9({248,23,238,210,207,75})))
_v276(_v219, _v119.Camera.HitboxOptions, function()
return _v119.Camera.Hitbox
end, function(_v535)
_v119.Camera.Hitbox = _v535
if _v407 then
_v407()
end
end)
local _v555, setWeightsEnabled = _v278(right, (_V9({228,31,232,215,197,71,24,78,48,196,10,243,222,199,64})))
local function _v554(name)
_v277(_v555, name .. (_V9({144,41,255,217,199,91,76})), 0, 100, function()
return _v119.Camera.TargetWeights[name]
end, function(_v535)
_v119.Camera.TargetWeights[name] = _v535
end, true, (_V9({149})), true)
end
_v554((_V9({248,27,251,212})))
_v554((_V9({228,17,232,195,207})))
_v554((_V9({241,12,247,195})))
_v554((_V9({252,27,253,195})))
_v407 = function()
setWeightsEnabled(_v119.Camera.Hitbox == (_V9({226,31,244,212,207,94,24,53,2,213,23,253,216,212,86,92,52})))
end
_v407()
table.insert(_v484, _v407)
local _v520 = _v278(right, (_V9({228,12,243,215,199,86,74,127,58,196})))
_v287(_v520, (_V9({245,16,251,210,204,86,92})), function()
return _v119.Triggerbot.Enabled
end, function()
_v119.Triggerbot.Enabled = not _v119.Triggerbot.Enabled
end, (_V9({228,12,243,215,199,86,74,127,58,196,94,209,213,217})), function()
return _v119.Triggerbot.ToggleKey
end, function(_v247)
_v119.Triggerbot.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({196,12,243,215,199,86,74,127,58,196})))
end)
_v277(_v520, (_V9({253,23,244,144,228,86,84,124,44})), 0, 500, function()
return _v119.Triggerbot.MinDelay * 1000
end, function(_v535)
_v119.Triggerbot.MinDelay = _v535 / 1000
end, true, (_V9({221,13})), true)
_v277(_v520, (_V9({253,31,226,144,228,86,84,124,44})), 0, 500, function()
return _v119.Triggerbot.MaxDelay * 1000
end, function(_v535)
_v119.Triggerbot.MaxDelay = _v535 / 1000
end, true, (_V9({221,13})), true)
_v277(_v520, (_V9({253,31,226,144,228,90,75,105,52,222,29,255})), 100, 2000, function()
return _v119.Triggerbot.MaxDistance
end, function(_v535)
_v119.Triggerbot.MaxDistance = _v535
end, true, (_V9({221})), true)
_v286(_v520, (_V9({230,23,233,211,200,86,91,118})), function()
return _v119.Triggerbot.WallCheck
end, function()
_v119.Triggerbot.WallCheck = not _v119.Triggerbot.WallCheck
end)
local _v463 = _v278(right, (_V9({227,23,246,213,206,71,24,92,60,221})))
_v286(_v463, (_V9({245,16,251,210,204,86,92})), function()
return _v119.SilentAim.Enabled
end, function()
_v119.SilentAim.Enabled = not _v119.SilentAim.Enabled
end)
local _v176 = _v278(right, (_V9({248,23,238,210,207,75,24,88,45,192,31,244,212,197,65})))
_v286(_v176, (_V9({245,16,251,210,204,86,92})), function()
return _v119.Hitbox.Enabled
end, function()
_v119.Hitbox.Enabled = not _v119.Hitbox.Enabled
end)
_v277(_v176, (_V9({227,23,224,213})), 1, 20, function()
return _v119.Hitbox.Size
end, function(_v535)
_v119.Hitbox.Size = _v535
end, true)
_v277(_v176, (_V9({228,12,251,222,211,67,89,111,48,222,29,227})), 0, 1, function()
return _v119.Hitbox.Transparency
end, function(_v535)
_v119.Hitbox.Transparency = _v535
end, false)
_v257, right = _v274(_v222:add((_V9({231,27,251,192,207,93,75}))))
local _v402 = _v278(_v257, (_V9({254,17,186,226,197,80,87,116,57})))
_v287(_v402, (_V9({245,16,251,210,204,86,92})), function()
return _v119.NoRecoil.Enabled
end, function()
_v119.NoRecoil.Enabled = not _v119.NoRecoil.Enabled
end, (_V9({254,17,186,226,197,80,87,116,57,144,53,255,201})), function()
return _v119.NoRecoil.ToggleKey
end, function(_v247)
_v119.NoRecoil.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({222,17,232,213,195,92,81,113})))
end)
_v286(_v402, (_V9({255,16,246,201,128,100,80,116,57,213,94,220,217,210,90,86,122})), function()
return _v119.NoRecoil.RequireMouseDown
end, function()
_v119.NoRecoil.RequireMouseDown = not _v119.NoRecoil.RequireMouseDown
end)
_v286(_v402, (_V9({241,18,246,223,215,19,121,116,56,144,58,245,199,206})), function()
return _v119.NoRecoil.AllowAim
end, function()
_v119.NoRecoil.AllowAim = not _v119.NoRecoil.AllowAim
end)
_v277(_v402, (_V9({227,10,232,213,206,84,76,117})), 0, 100, function()
return _v119.NoRecoil.Strength * 100
end, function(_v535)
_v119.NoRecoil.Strength = _v535 / 100
end, true, (_V9({149})), true)
local _v468 = _v278(_v257, (_V9({254,17,186,227,208,65,93,124,49})))
_v287(_v468, (_V9({245,16,251,210,204,86,92})), function()
return _v119.NoSpread.Enabled
end, function()
_v119.NoSpread.Enabled = not _v119.NoSpread.Enabled
end, (_V9({254,17,186,227,208,65,93,124,49,144,53,255,201})), function()
return _v119.NoSpread.ToggleKey
end, function(_v247)
_v119.NoSpread.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({222,17,233,192,210,86,89,121})))
end)
_v286(_v468, (_V9({255,16,246,201,128,100,80,116,57,213,94,220,217,210,90,86,122})), function()
return _v119.NoSpread.RequireMouseDown
end, function()
_v119.NoSpread.RequireMouseDown = not _v119.NoSpread.RequireMouseDown
end)
_v277(_v468, (_V9({227,10,232,213,206,84,76,117})), 0, 100, function()
return _v119.NoSpread.Strength * 100
end, function(_v535)
_v119.NoSpread.Strength = _v535 / 100
end, true, (_V9({149})), true)
end
local function _v84(_v374, _v119)
_v256 = 0
local _v222 = _v284(_v374)
local _v257, right = _v274(_v222:add((_V9({245,45,202}))))
local _v171 = _v278(_v257, (_V9({245,45,202})))
_v287(_v171, (_V9({245,16,251,210,204,86,92})), function()
return _v119.ESP.Enabled
end, function()
_v119.ESP.Enabled = not _v119.ESP.Enabled
end, (_V9({245,45,202,144,235,86,65})), function()
return _v119.ESP.ToggleKey
end, function(_v247)
_v119.ESP.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({213,13,234})))
end)
_v286(_v171, (_V9({254,46,217,195})), function()
return _v119.ESP.NPCs
end, function()
_v119.ESP.NPCs = not _v119.ESP.NPCs
end)
_v277(_v171, (_V9({253,31,226,144,228,90,75,105,52,222,29,255})), 100, 2000, function()
return _v119.ESP.MaxDistance
end, function(_v535)
_v119.ESP.MaxDistance = _v535
end, true, (_V9({221})), true)
local _v268 = _v278(_v257, (_V9({241,14,234,213,193,65,89,115,54,213})))
_v286(_v268, (_V9({255,11,238,220,201,93,93,110})), function()
return _v119.ESP.Outlines
end, function()
_v119.ESP.Outlines = not _v119.ESP.Outlines
end)
_v286(_v268, (_V9({242,17,226,213,211})), function()
return _v119.ESP.Boxes
end, function()
_v119.ESP.Boxes = not _v119.ESP.Boxes
end)
_v286(_v268, (_V9({254,31,247,213,211})), function()
return _v119.ESP.Names
end, function()
_v119.ESP.Names = not _v119.ESP.Names
end)
_v286(_v268, (_V9({244,23,233,196,193,93,91,120})), function()
return _v119.ESP.Distance
end, function()
_v119.ESP.Distance = not _v119.ESP.Distance
end)
_v286(_v268, (_V9({248,27,251,220,212,91,24,95,52,194,13})), function()
return _v119.ESP.HealthBars
end, function()
_v119.ESP.HealthBars = not _v119.ESP.HealthBars
end)
_v286(_v268, (_V9({246,23,246,220,197,87})), function()
return _v119.ESP.Filled
end, function()
_v119.ESP.Filled = not _v119.ESP.Filled
end)
_v277(_v268, (_V9({255,11,238,220,201,93,93,61,26,192,31,249,217,212,74})), 0, 1, function()
return _v119.ESP.OutlineOpacity
end, function(_v535)
_v119.ESP.OutlineOpacity = _v535
end, false)
_v277(_v268, (_V9({246,23,246,220,128,124,72,124,54,217,10,227})), 0, 1, function()
return _v119.ESP.FillOpacity
end, function(_v535)
_v119.ESP.FillOpacity = _v535
end, false)
local _v157 = _v278(right, (_V9({244,12,251,199,201,93,95,61,16,227,46})))
_v286(_v157, (_V9({242,17,226,213,211})), function()
return _v119.Drawing.Boxes
end, function()
_v119.Drawing.Boxes = not _v119.Drawing.Boxes
end)
_v286(_v157, (_V9({228,12,251,211,197,65,75})), function()
return _v119.Drawing.Tracers
end, function()
_v119.Drawing.Tracers = not _v119.Drawing.Tracers
end)
local _v559 = _v278(right, (_V9({231,17,232,220,196})))
_v286(_v559, (_V9({246,11,246,220,194,65,81,122,61,196})), function()
return _v119.Visuals.Fullbright
end, function()
_v119.Visuals.Fullbright = not _v119.Visuals.Fullbright
end)
_v286(_v559, (_V9({254,17,186,246,207,84})), function()
return _v119.Visuals.NoFog
end, function()
_v119.Visuals.NoFog = not _v119.Visuals.NoFog
end)
_v257, right = _v274(_v222:add((_V9({243,17,246,223,210,64}))))
_v273(_v257, (_V9({255,11,238,220,201,93,93,61,22,223,18,245,194})), function()
return _v119.ESP.OutlineColor
end, function(c)
_v119.ESP.OutlineColor = c
end)
_v273(right, (_V9({246,23,246,220,128,112,87,113,58,194})), function()
return _v119.ESP.FillColor
end, function(c)
_v119.ESP.FillColor = c
end)
_v273(_v257, (_V9({242,17,226,144,227,92,84,114,39})), function()
return _v119.Drawing.BoxColor
end, function(c)
_v119.Drawing.BoxColor = c
end)
_v273(right, (_V9({228,12,251,211,197,65,24,94,58,220,17,232})), function()
return _v119.Drawing.TracerColor
end, function(c)
_v119.Drawing.TracerColor = c
end)
end
local function _v89(_v374, _v119)
_v256 = 0
local _v222 = _v284(_v374)
local _v257, right = _v274(_v222:add((_V9({253,17,236,213,205,86,86,105}))))
local _v182 = _v278(_v257, (_V9({246,18,227})))
_v286(_v182, (_V9({245,16,251,210,204,86,92})), function()
return _v119.Movement.FlyEnabled
end, function()
_v119.Movement.FlyEnabled = not _v119.Movement.FlyEnabled
end)
_v277(_v182, (_V9({246,18,227,144,243,67,93,120,49})), 10, 200, function()
return _v119.Movement.FlySpeed
end, function(_v535)
_v119.Movement.FlySpeed = _v535
end, true)
local _v467 = _v278(_v257, (_V9({227,14,255,213,196})))
_v286(_v467, (_V9({245,16,251,210,204,86,92})), function()
return _v119.Movement.SpeedEnabled
end, function()
_v119.Movement.SpeedEnabled = not _v119.Movement.SpeedEnabled
end)
_v277(_v467, (_V9({227,14,255,213,196})), 16, 100, function()
return _v119.Movement.Speed
end, function(_v535)
_v119.Movement.Speed = _v535
end, true)
local _v294 = _v278(_v257, (_V9({255,10,242,213,210})))
_v286(_v294, (_V9({254,17,249,220,201,67})), function()
return _v119.Movement.NoclipEnabled
end, function()
_v119.Movement.NoclipEnabled = not _v119.Movement.NoclipEnabled
end)
_v286(_v294, (_V9({249,16,252,217,206,90,76,120,117,250,11,247,192})), function()
return _v119.Movement.InfJumpEnabled
end, function()
_v119.Movement.InfJumpEnabled = not _v119.Movement.InfJumpEnabled
end)
local _v518 = _v278(right, (_V9({243,18,243,211,203,19,108,77})))
_v286(_v518, (_V9({245,16,251,210,204,86,92})), function()
return _v119.Movement.ClickTPEnabled
end, function()
_v119.Movement.ClickTPEnabled = not _v119.Movement.ClickTPEnabled
end)
_v281(_v518, (_V9({253,17,254,217,198,90,93,111,117,251,27,227})), function()
return _v119.Movement.ClickTPKey
end, function(_v247)
_v119.Movement.ClickTPKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({211,18,243,211,203,71,72})))
end)
end
local function _v90(_v374, _v119)
_v256 = 0
local _v222 = _v284(_v374)
local _v257, right = _v274(_v222:add((_V9({224,18,251,201,197,65,75}))))
local _v263 = _v278(_v257, (_V9({224,18,251,201,197,65,24,81,60,195,10})))
_v386 = _v319((_V9({227,29,232,223,204,95,81,115,50,246,12,251,221,197})), {
Parent = _v263,
LayoutOrder = _v321(),
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
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v386, CornerRadius = UDim.new(0, 6) })
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = _v386,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = _v386,
PaddingTop = UDim.new(0, 4),
PaddingBottom = UDim.new(0, 4),
PaddingLeft = UDim.new(0, 4),
PaddingRight = UDim.new(0, 4),
})
local function _v405()
for _v384, row in pairs(_v387) do
row.btn.BackgroundColor3 = (_v384 == _v453) and _v6.accent or _v6.row
end
end
local function _v404()
if not _v386 then
return
end
for _, _v114 in ipairs(_v386:GetChildren()) do
if not _v114:IsA((_V9({229,55,214,217,211,71,116,124,44,223,11,238}))) then
_v114:Destroy()
end
end
table.clear(_v387)
local _v126 = 0
for _, _v384 in ipairs(_v31:GetPlayers()) do
if _v384 ~= _v26 then
_v126 = _v126 + 1
local row = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v386,
LayoutOrder = _v126,
Size = UDim2.new(1, 0, 0, 24),
BackgroundColor3 = (_v384 == _v453) and _v6.accent or _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = row, CornerRadius = UDim.new(0, 4) })
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = row,
Size = UDim2.new(0.65, -8, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v384.TeamColor.Color,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v384.Name,
})
local dist = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = row,
Size = UDim2.new(0.35, -8, 1, 0),
Position = UDim2.new(0.65, 0, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = (_V9({82,254,14})),
})
row.MouseButton1Click:Connect(function()
_v453 = (_v453 == _v384) and nil or _v384
_v405()
end)
_v387[_v384] = { btn = row, dist = dist }
end
end
if _v126 == 0 then
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v386,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({144,94,244,223,128,92,76,117,48,194,94,234,220,193,74,93,111,38})),
})
end
end
local _v52 = _v278(right, (_V9({241,29,238,217,207,93,75})))
local _v452 = _v282(_v52, (_V9({227,27,246,213,195,71,93,121})), (_V9({82,254,14})))
_v272(_v52, (_V9({228,27,246,213,208,92,74,105,117,228,17})), function()
local _v111 = _v453 and _v453.Character
local root = _v111 and _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
if root and UI.TeleportTo then
UI.TeleportTo(root.Position)
end
end)
_v465 = _v272(_v52, (_V9({227,14,255,211,212,82,76,120})), function()
if _v466 then
_v476()
elseif _v453 then
_v474(_v453)
end
end)
table.insert(_v484, function()
_v452.Text = _v453 and _v453.Name or (_V9({82,254,14}))
_v405()
end)
_v404()
table.insert(_v523, _v31.PlayerAdded:Connect(function()
_v404()
end))
table.insert(_v523, _v31.PlayerRemoving:Connect(function(_v384)
if _v384 == _v453 then
_v453 = nil
end
if _v384 == _v466 then
_v476()
end
_v404()
end))
local _v254 = 0
table.insert(_v523, _v37.RenderStepped:Connect(function()
if os.clock() - _v254 < 0.5 then
return
end
_v254 = os.clock()
_v452.Text = _v453 and _v453.Name or (_V9({82,254,14}))
local _v311 = _v26.Character
local _v312 = _v311 and _v311:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
for _v384, row in pairs(_v387) do
local _v111 = _v384.Character
local root = _v111 and _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
row.dist.Text = (_v312 and root)
and (math.floor((root.Position - _v312.Position).Magnitude + 0.5) .. (_V9({221})))
or (_V9({82,254,14}))
end
if _v466 then
if _v55 and _v55.Movement and _v55.Movement.FlyEnabled then
_v476()
else
local _v111 = _v466.Character
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
local _v94 = _v49.CurrentCamera
if humanoid and humanoid.Health > 0 and _v94 then
_v94.CameraSubject = humanoid
else
_v476()
end
end
end
end))
end
local function _v88(_v374, _v119)
_v256 = 0
local _v222 = _v284(_v374)
local _v257, right = _v274(_v222:add((_V9({227,27,233,195,201,92,86}))))
local _v51 = _v278(_v257, (_V9({241,29,249,223,213,93,76})))
_v282(_v51, (_V9({229,13,255,194,206,82,85,120})), _v26 and _v26.Name or (_V9({82,254,14})))
_v282(_v51, (_V9({244,23,233,192,204,82,65,61,27,209,19,255})), _v26 and _v26.DisplayName or (_V9({82,254,14})))
_v282(_v51, (_V9({229,13,255,194,128,122,124})), _v26 and tostring(_v26.UserId) or (_V9({82,254,14})))
_v272(_v51, (_V9({227,27,232,198,197,65,24,85,58,192})), function()
_v46:ServerHop()
end)
_v272(_v51, (_V9({226,27,240,223,201,93,24,78,48,194,8,255,194})), function()
_v46:Rejoin()
end)
local _v553 = _v278(right, (_V9({231,27,248,216,207,92,83})))
local _v534 = _v285(_v553, (_V9({199,27,248,216,207,92,83,61,32,194,18,120,48,6})))
_v534.Text = _v119.Webhook.Url
_v534.FocusLost:Connect(function()
_v119.Webhook.Url = _v534.Text
end)
_v272(_v553, (_V9({227,27,244,212,128,103,93,110,33,144,41,255,210,200,92,87,118})), function()
local _v342, res = _v48.SendWebhook((_V9({230,31,244,217,212,74,21,90,48,222,27,232,209,204,19,76,120,38,196,94,237,213,194,91,87,114,62})))
if _v342 then
UI:Notify((_V9({228,27,233,196,128,68,93,127,61,223,17,241,144,211,86,86,105})), 2)
else
UI:Notify((_V9({231,27,248,216,207,92,83,61,51,209,23,246,213,196,9,24})) .. tostring(res), 3)
end
end)
end
local function _v91(_v374, _v119)
_v256 = 0
local _v222 = _v284(_v374)
local _v257, right = _v274(_v222:add((_V9({247,27,244,213,210,82,84}))))
local _v229 = _v278(_v257, (_V9({249,16,238,213,210,85,89,126,48})))
_v277(_v229, (_V9({229,55,186,227,195,82,84,120})), 0.8, 1.5, function()
return _v119.UI.Scale
end, function(_v535)
_v119.UI.Scale = _v535
if _v557 then
_v557.Scale = _v535
end
end, false)
_v286(_v229, (_V9({251,27,227,210,201,93,92,61,5,209,16,255,220})), function()
return _v119.UI.KeybindPanel
end, function()
_v119.UI.KeybindPanel = not _v119.UI.KeybindPanel
if _v250 then
_v250.Visible = _v119.UI.KeybindPanel
end
end)
_v286(_v229, (_V9({228,31,232,215,197,71,24,89,60,195,14,246,209,217})), function()
return _v119.UI.TargetDisplay
end, function()
_v119.UI.TargetDisplay = not _v119.UI.TargetDisplay
_v494 = _v119.UI.TargetDisplay
if not _v494 and _v495 then
_v495.Visible = false
end
end)
_v286(_v229, (_V9({246,46,201,144,227,92,77,115,33,213,12})), function()
return _v119.UI.FPSCounter
end, function()
_v119.UI.FPSCounter = not _v119.UI.FPSCounter
if _v190 then
_v190.Visible = _v119.UI.FPSCounter
end
end)
_v286(_v229, (_V9({231,31,238,213,210,94,89,111,62})), function()
return _v119.UI.Watermark
end, function()
_v119.UI.Watermark = not _v119.UI.Watermark
if _v552 then
_v552.Visible = _v119.UI.Watermark
end
end)
_v273(_v229, (_V9({241,29,249,213,206,71,24,94,58,220,17,232})), function()
return _v119.UI.Accent
end, function(_v317)
_v68(_v317)
end)
table.insert(_v484, function()
if _v119.UI.Accent then
_v68(_v119.UI.Accent)
end
end)
_v257, right = _v274(_v222:add((_V9({243,17,244,214,201,84,75}))))
local _v108 = _v278(_v257, (_V9({243,17,244,214,201,84,75})))
if not _v11.isSupported() then
_v282(_v108, (_V9({227,10,251,196,213,64})), (_V9({229,16,233,197,208,67,87,111,33,213,26})))
return
end
local _v314 = _v285(_v108, (_V9({211,17,244,214,201,84,24,115,52,221,27,120,48,6})))
local _v264 = _v319((_V9({246,12,251,221,197})), {
Parent = _v108,
LayoutOrder = _v321(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = _v264,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v404
local function _v450(name)
_v314.Text = name
_v404()
end
_v404 = function()
for _, _v114 in ipairs(_v264:GetChildren()) do
if not _v114:IsA((_V9({229,55,214,217,211,71,116,124,44,223,11,238}))) then
_v114:Destroy()
end
end
local _v316 = _v11.list()
if #_v316 == 0 then
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v264,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({222,17,186,195,193,69,93,121,117,211,17,244,214,201,84,75})),
})
return
end
for i, name in ipairs(_v316) do
local _v451 = (_v314.Text == name)
local row = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v264,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v451 and _v6.accent or _v6.row,
BackgroundTransparency = _v451 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v451 and Color3.fromRGB(255, 255, 255) or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({144,94})) .. name,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v450(name)
end)
row.MouseEnter:Connect(function()
if _v314.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v6.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v314.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v6.row
end
end)
end
end
_v272(_v108, (_V9({227,31,236,213})), function()
local _v342, res = _v11.save(_v314.Text, _v119)
if _v342 then
UI:Notify((_V9({227,31,236,213,196,19,91,114,59,214,23,253,144,135})) .. res .. (_V9({151})), 2)
_v404()
else
UI:Notify(tostring(res), 3)
end
end)
_v272(_v108, (_V9({252,17,251,212})), function()
local _v342, res = _v11.load(_v314.Text, _v119)
if _v342 then
if _v557 then
_v557.Scale = _v119.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({252,17,251,212,197,87,24,126,58,222,24,243,215,128,20})) .. res .. (_V9({151})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v272(_v108, (_V9({244,27,246,213,212,86})), function()
local _v342, res = _v11.delete(_v314.Text)
if _v342 then
UI:Notify((_V9({244,27,246,213,212,86,92,61,54,223,16,252,217,199,19,31})) .. res .. (_V9({151})), 2)
_v314.Text = (_V9({}))
_v404()
else
UI:Notify(tostring(res), 3)
end
end, _v6.danger)
_v404()
end
local function _v92(_v119)
_v495 = _v319((_V9({246,12,251,221,197})), {
Parent = _v202,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v495, CornerRadius = UDim.new(0, 6) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v495, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = _v495,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = _v495,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v154 = _v319((_V9({246,12,251,221,197})), {
Parent = _v495,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v154, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v495,
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
local _v156, _v155, _v473
_v495.InputBegan:Connect(function(_v232)
if _v244(_v232) then
_v156 = true
_v155 = _v232.Position
_v473 = _v495.Position
end
end)
table.insert(_v300, function(_v232)
if _v156 and _v495 then
local delta = _v232.Position - _v155
_v495.Position = UDim2.new(
_v473.X.Scale,
_v473.X.Offset + delta.X,
_v473.Y.Scale,
_v473.Y.Offset + delta.Y
)
end
end)
table.insert(_v410, function()
_v156 = false
end)
table.insert(_v484, function()
_v494 = _v119.UI.TargetDisplay
if not _v494 and _v495 then
_v495.Visible = false
end
end)
_v494 = _v119.UI.TargetDisplay
end
local function _v86(_v119)
_v190 = _v319((_V9({246,12,251,221,197})), {
Parent = _v202,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v190, CornerRadius = UDim.new(0, 6) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v190, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = _v190,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = _v190,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v154 = _v319((_V9({246,12,251,221,197})), {
Parent = _v190,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v154, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v190,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({157,83,186,214,208,64})),
})
table.insert(_v484, function()
if _v190 then
_v190.Visible = _v119.UI.FPSCounter
end
end)
_v190.Visible = _v119.UI.FPSCounter
end
local function _v93(_v119)
_v552 = _v319((_V9({249,19,251,215,197,127,89,127,48,220})), {
Parent = _v202,
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
table.insert(_v484, function()
if _v552 then
_v552.Visible = _v119.UI.Watermark
end
end)
_v552.Visible = _v119.UI.Watermark
end
local function _v87(_v119)
_v256 = 0
_v250 = _v319((_V9({246,12,251,221,197})), {
Parent = _v202,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
Visible = false,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v250, CornerRadius = UDim.new(0, 8) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v250, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), {
Parent = _v250,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = _v250,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v319((_V9({246,12,251,221,197})), {
Parent = _v250,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({251,27,227,210,201,93,92,110})),
})
local _v156, _v155, _v473
bar.InputBegan:Connect(function(_v232)
if _v244(_v232) then
_v156 = true
_v155 = _v232.Position
_v473 = _v250.Position
end
end)
table.insert(_v300, function(_v232)
if _v156 and _v250 then
local delta = _v232.Position - _v155
_v250.Position = UDim2.new(
_v473.X.Scale,
_v473.X.Offset + delta.X,
_v473.Y.Scale,
_v473.Y.Offset + delta.Y
)
end
end)
table.insert(_v410, function()
_v156 = false
end)
_v281(_v250, (_V9({253,27,244,197})), function()
return _v119.UI.MenuKey
end, function(_v247)
_v119.UI.MenuKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({221,27,244,197})))
end)
_v281(_v250, (_V9({241,23,247,210,207,71})), function()
return _v119.Camera.ToggleKey
end, function(_v247)
_v119.Camera.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({209,23,247,210,207,71})))
end)
_v281(_v250, (_V9({245,45,202})), function()
return _v119.ESP.ToggleKey
end, function(_v247)
_v119.ESP.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({213,13,234})))
end)
_v281(_v250, (_V9({246,49,204,144,227,90,74,126,57,213})), function()
return _v119.Camera.FOVCircleKey
end, function(_v247)
_v119.Camera.FOVCircleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({214,17,236,211,201,65,91,113,48})))
end)
_v281(_v250, (_V9({254,17,186,226,197,80,87,116,57})), function()
return _v119.NoRecoil.ToggleKey
end, function(_v247)
_v119.NoRecoil.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({222,17,232,213,195,92,81,113})))
end)
_v281(_v250, (_V9({254,17,186,227,208,65,93,124,49})), function()
return _v119.NoSpread.ToggleKey
end, function(_v247)
_v119.NoSpread.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({222,17,233,192,210,86,89,121})))
end)
_v281(_v250, (_V9({228,12,243,215,199,86,74,127,58,196})), function()
return _v119.Triggerbot.ToggleKey
end, function(_v247)
_v119.Triggerbot.ToggleKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({196,12,243,215,199,86,74,127,58,196})))
end)
_v281(_v250, (_V9({229,16,246,223,193,87})), function()
return _v119.UI.UnloadKey
end, function(_v247)
_v119.UI.UnloadKey = _v247
end, function(_v247)
return _v248(_v119, _v247, (_V9({197,16,246,223,193,87})))
end)
table.insert(_v484, function()
if _v250 then
_v250.Visible = _v119.UI.KeybindPanel
end
end)
_v250.Visible = _v119.UI.KeybindPanel
end
local function _v458(_v475)
if not _v271 or _v475 == _v541 then
return
end
_v541 = _v475
if _v55 and _v55.UI then
_v55.UI.Visible = _v475
end
if _v475 then
_v271.Visible = true
_v271.GroupTransparency = 1
_v44:Create(_v271, TweenInfo.new(_v17), { GroupTransparency = 0 }):Play()
else
local _v522 = _v44:Create(_v271, TweenInfo.new(_v17), { GroupTransparency = 1 })
_v522.Completed:Once(function()
if not _v541 and _v271 then
_v271.Visible = false
end
end)
_v522:Play()
end
end
function UI:Init(_v119, _v360)
if _v202 then
return
end
_v55 = _v119
_v361 = _v360
if _v119.UI.Accent then
_v6.accent = _v119.UI.Accent
end
_v472()
_v202 = _v319((_V9({227,29,232,213,197,93,127,104,60})), {
Name = _v10.RandomName(),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v342 = pcall(function()
_v202.Parent = _v46.getGuiParent()
end)
if not _v342 or not _v202.Parent then
_v202.Parent = _v26:WaitForChild((_V9({224,18,251,201,197,65,127,104,60})))
end
_v10.Protect(_v202)
_v271 = _v319((_V9({243,31,244,198,193,64,127,111,58,197,14})), {
Parent = _v202,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v557 = _v319((_V9({229,55,201,211,193,95,93})), { Parent = _v271, Scale = _v119.UI.Scale })
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v271, CornerRadius = UDim.new(0, 8) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v271, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
local _v509 = _v319((_V9({246,12,251,221,197})), {
Parent = _v271,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v509, CornerRadius = UDim.new(0, 8) })
_v319((_V9({246,12,251,221,197})), {
Parent = _v509,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
local _v154 = _v319((_V9({246,12,251,221,197})), {
Parent = _v509,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v154, CornerRadius = UDim.new(1, 0) })
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v509,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({230,31,244,217,212,74,4,123,58,222,10,186,211,207,95,87,111,104,146,93,162,132,147,118,122,88,119,142,80,254,213,214,15,23,123,58,222,10,164,144,231,86,86,120,39,209,18}))
.. (_V9({140,24,245,222,212,19,91,114,57,223,12,167,146,131,11,121,42,22,241,78,184,142,128,19,24,223,226,144,94,186,198,144,15,23,123,58,222,10,164})),
ZIndex = 2,
})
_v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v509,
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
local _v156, _v155, _v473
_v509.InputBegan:Connect(function(_v232)
if _v244(_v232) then
_v156 = true
_v155 = _v232.Position
_v473 = _v271.Position
end
end)
table.insert(_v300, function(_v232)
if _v156 then
local delta = _v232.Position - _v155
_v271.Position = UDim2.new(
_v473.X.Scale,
_v473.X.Offset + delta.X,
_v473.Y.Scale,
_v473.Y.Offset + delta.Y
)
end
end)
table.insert(_v410, function()
_v156 = false
end)
local _v462 = _v319((_V9({246,12,251,221,197})), {
Parent = _v271,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v462, CornerRadius = UDim.new(0, 6) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v462, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = _v462,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v490 = _v319((_V9({246,12,251,221,197})), {
Parent = _v462,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v319((_V9({229,55,214,217,211,71,116,124,44,223,11,238})), { Parent = _v490, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v526 = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v462,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.danger,
Text = (_V9({229,16,246,223,193,87})),
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v526, CornerRadius = UDim.new(0, 6) })
local _v527 = _v319((_V9({229,55,201,196,210,92,83,120})), {
Parent = _v526,
Color = _v6.danger,
Thickness = 1,
Transparency = 0.55,
})
_v526.MouseButton1Click:Connect(function()
if _v361 then
_v361()
end
end)
_v526.MouseEnter:Connect(function()
_v44:Create(_v526, _v1, {
BackgroundColor3 = _v6.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v44:Create(_v527, _v1, { Transparency = 0 }):Play()
end)
_v526.MouseLeave:Connect(function()
_v44:Create(_v526, _v1, {
BackgroundColor3 = _v6.row,
TextColor3 = _v6.danger,
}):Play()
_v44:Create(_v527, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v319((_V9({246,12,251,221,197})), {
Parent = _v271,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v319((_V9({229,55,202,209,196,87,81,115,50})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v492 = { (_V9({243,17,247,210,193,71})), (_V9({230,23,233,197,193,95})), (_V9({253,17,236,213,205,86,86,105})), (_V9({224,18,251,201,197,65,75})), (_V9({253,23,233,211})), (_V9({227,27,238,196,201,93,95,110})) }
local _v489 = {}
for i, _v491 in ipairs(_v492) do
local _v237 = _v127 == _v491
local _v487 = _v319((_V9({228,27,226,196,226,70,76,105,58,222})), {
Parent = _v490,
LayoutOrder = i,
Size = UDim2.new(1, 0, 1 / #_v492, -6),
BackgroundColor3 = _v6.rowHover,
BackgroundTransparency = _v237 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v237 and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({144,94,186,144})) .. _v491,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v487, CornerRadius = UDim.new(0, 6) })
local stripe = _v319((_V9({246,12,251,221,197})), {
Parent = _v487,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
Visible = _v237,
ZIndex = 2,
})
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v488 = _v319((_V9({246,12,251,221,197})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v237,
})
_v489[_v491] = { btn = _v487, frame = _v488, stripe = stripe }
_v487.MouseButton1Click:Connect(function()
_v127 = _v491
for name, _v486 in pairs(_v489) do
local _v53 = name == _v491
_v486.frame.Visible = _v53
_v486.stripe.Visible = _v53
_v44:Create(_v486.btn, _v1, {
BackgroundTransparency = _v53 and 0 or 1,
TextColor3 = _v53 and _v6.text or _v6.textSub,
}):Play()
end
end)
_v487.MouseEnter:Connect(function()
if _v127 ~= _v491 then
_v44:Create(_v487, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v487.MouseLeave:Connect(function()
if _v127 ~= _v491 then
_v44:Create(_v487, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v83(_v489[(_V9({243,17,247,210,193,71}))].frame, _v119)
_v84(_v489[(_V9({230,23,233,197,193,95}))].frame, _v119)
_v89(_v489[(_V9({253,17,236,213,205,86,86,105}))].frame, _v119)
_v90(_v489[(_V9({224,18,251,201,197,65,75}))].frame, _v119)
_v88(_v489[(_V9({253,23,233,211}))].frame, _v119)
_v91(_v489[(_V9({227,27,238,196,201,93,95,110}))].frame, _v119)
_v87(_v119)
_v92(_v119)
_v86(_v119)
_v93(_v119)
if _v119.UI.Visible then
_v458(true)
end
end
function UI:Toggle()
_v458(not _v541)
end
function UI:Show()
_v458(true)
end
function UI:Hide()
_v458(false)
end
function UI:SetCurrentTarget(name)
if not _v495 then
return
end
if _v495.Visible ~= _v494 then
_v495.Visible = _v494
end
if not _v494 or not targetPanelLabel then
return
end
local _v461, colour
if name and name ~= (_V9({})) and name ~= (_V9({254,17,244,213})) then
_v461, colour = name, (_V9({147,70,174,131,229,113,125}))
else
_v461, colour = (_V9({229,16,209,222,207,68,86})), (_V9({147,70,219,135,227,114,8}))
end
local text = (_V9({228,31,232,215,197,71,2,61,105,214,17,244,196,128,80,87,113,58,194,67,184})) .. colour .. (_V9({146,64})) .. _v461 .. (_V9({140,81,252,223,206,71,6}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v188)
if not fpsLabel or not _v190 or not _v190.Visible then
return
end
local text = string.format((_V9({140,24,245,222,212,19,91,114,57,223,12,167,146,131,11,12,46,16,242,59,184,142,133,87,4,50,51,223,16,238,142,128,85,72,110})), _v188 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v228)
if not _v552 then
return
end
local _v147 = tostring(_v228 or (_V9({}))):match((_V9({149,26,177})))
_v552.Image = _v147 and ((_V9({194,28,226,209,211,64,93,105,60,212,68,181,159})) .. _v147) or (_V9({}))
end
function UI:SyncControls()
for _, _v184 in ipairs(_v484) do
_v184()
end
end
function UI:IsCapturingKey()
return _v103
end
function UI:Notify(text, _v162)
if not _v202 then
return
end
_v162 = _v162 or 3
local _v511 = _v319((_V9({228,27,226,196,236,82,90,120,57})), {
Parent = _v202,
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
_v319((_V9({229,55,217,223,210,93,93,111})), { Parent = _v511, CornerRadius = UDim.new(0, 8) })
_v319((_V9({229,55,201,196,210,92,83,120})), { Parent = _v511, Color = _v6.accent, Thickness = 1, Transparency = 0.3 })
_v44:Create(_v511, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v162, function()
if _v511 and _v511.Parent then
local _v372 = _v44:Create(_v511, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v372.Completed:Once(function()
if _v511 then
_v511:Destroy()
end
end)
_v372:Play()
end
end)
end
function UI:Cleanup()
_v476()
_v453 = nil
_v465 = nil
_v386 = nil
table.clear(_v387)
for _, _v122 in ipairs(_v523) do
_v122:Disconnect()
end
table.clear(_v523)
table.clear(_v300)
table.clear(_v410)
table.clear(_v484)
_v54 = nil
_v103 = false
_v56 = nil
_v495, targetPanelLabel = nil, nil
_v494 = false
_v250 = nil
_v552 = nil
_v190, fpsLabel = nil, nil
_v557 = nil
if _v202 then
_v202:Destroy()
_v202 = nil
_v271 = nil
end
_v541 = false
end
return UI
end)()
Movement = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v45 = game:GetService((_V9({229,13,255,194,233,93,72,104,33,227,27,232,198,201,80,93})))
local _v49 = game:GetService((_V9({231,17,232,219,211,67,89,126,48})))
local _v26 = _v31.LocalPlayer
local UI = UI
local Movement = {}
local _v5 = 16
local _v23 = 50
local _v306
local _v304
local _v310 = 0
local function _v303()
local _v111 = _v26.Character
local root = _v111 and _v111:FindFirstChild((_V9({248,11,247,209,206,92,81,121,7,223,17,238,224,193,65,76})))
local humanoid = _v111 and _v111:FindFirstChildOfClass((_V9({248,11,247,209,206,92,81,121})))
if not (_v111 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v111, root, humanoid
end
local function _v305(_v94)
local _v268 = _v94.CFrame.LookVector
local _v180 = Vector3.new(_v268.X, 0, _v268.Z)
if _v180.Magnitude < 0.001 then
_v180 = Vector3.new(0, 0, -1)
else
_v180 = _v180.Unit
end
local right = _v94.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v299 = Vector3.zero
if _v45:IsKeyDown(Enum.KeyCode.W) then
_v299 = _v299 + _v180
end
if _v45:IsKeyDown(Enum.KeyCode.S) then
_v299 = _v299 - _v180
end
if _v45:IsKeyDown(Enum.KeyCode.D) then
_v299 = _v299 + right
end
if _v45:IsKeyDown(Enum.KeyCode.A) then
_v299 = _v299 - right
end
if _v45:IsKeyDown(Enum.KeyCode.Space) then
_v299 = _v299 + Vector3.yAxis
end
if _v45:IsKeyDown(Enum.KeyCode.LeftShift) then
_v299 = _v299 - Vector3.yAxis
end
if _v299.Magnitude > 0 then
return _v299.Unit
end
return nil
end
local _v29 = 0.1
local _v30 = 0.15
local function _v309()
return (os.clock() % (_v29 + _v30)) < _v29
end
function Movement:Update(_v161, _v119)
local _v111, root, humanoid = _v303()
if _v119.NoclipEnabled and _v111 then
local _v322 = _v111:GetDescendants()
for i = 1, #_v322 do
local part = _v322[i]
if part:IsA((_V9({242,31,233,213,240,82,74,105}))) then
part.CanCollide = false
end
end
end
if not root then
return
end
if _v119.FlyEnabled then
local _v94 = _v49.CurrentCamera
if _v94 then
local _v540 = Vector3.zero
if not UI:IsCapturingKey() then
local _v148 = _v305(_v94)
if _v148 then
local _v467 = _v119.FlySpeed or 50
if not _v309() then
_v467 = math.min(_v467, _v5)
end
_v540 = _v148 * _v467
end
end
root.AssemblyLinearVelocity = _v540
end
return
end
if _v119.SpeedEnabled then
local _v467 = _v119.Speed or _v5
local _v299 = humanoid.MoveDirection
if _v467 > _v5 and _v299.Magnitude > 0 and _v309() then
local _v540 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v299.X * _v467, _v540.Y, _v299.Z * _v467)
end
end
end
local function _v308(_v119)
if not _v119.InfJumpEnabled then
return
end
local _, root = _v303()
if root then
local _v540 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v540.X, _v23, _v540.Z)
end
end
local _v42 = 10
local _v41 = 0.05
function Movement.TeleportTo(_v390)
local _v143 = _v390 + Vector3.new(0, 3, 0)
_v310 = _v310 + 1
local _v513 = _v310
task.spawn(function()
while _v513 == _v310 do
local _, currentRoot = _v303()
if not currentRoot then
return
end
local _v341 = _v143 - currentRoot.CFrame.Position
if _v341.Magnitude <= _v42 then
currentRoot.CFrame = CFrame.new(_v143)
return
end
currentRoot.CFrame = currentRoot.CFrame + _v341.Unit * _v42
task.wait(_v41)
end
end)
end
local function _v307(_v119, _v232, _v195)
if _v195 or UI:IsCapturingKey() then
return
end
if not _v119.ClickTPEnabled then
return
end
if _v232.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v45:IsKeyDown(_v119.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _v298 = _v26:GetMouse()
if _v298 and _v298.Hit then
Movement.TeleportTo(_v298.Hit.Position)
end
end
function Movement:Init(_v119)
if not _v306 then
_v306 = _v45.JumpRequest:Connect(function()
_v308(_v119)
end)
end
if not _v304 then
_v304 = _v45.InputBegan:Connect(function(_v232, _v195)
_v307(_v119, _v232, _v195)
end)
end
end
function Movement:Cleanup()
if _v306 then
_v306:Disconnect()
_v306 = nil
end
if _v304 then
_v304:Disconnect()
_v304 = nil
end
end
return Movement
end)()
_v13 = (function()
local _v31 = game:GetService((_V9({224,18,251,201,197,65,75})))
local _v37 = game:GetService((_V9({226,11,244,227,197,65,78,116,54,213})))
local _v45 = game:GetService((_V9({229,13,255,194,233,93,72,104,33,227,27,232,198,201,80,93})))
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
local _v46 = _v46
local UI = UI
local Movement = Movement
local _v48 = _v48
local _v10 = _v10
local _v13 = {}
_v13.Version = (_V9({129,80,170,158,144}))
_v13.Config = _v12
UI.TeleportTo = Movement.TeleportTo
_v48.Version = _v13.Version
local _v430 = false
local _v123 = {}
local _v62 = false
local _v32 = _v10.RandomName()
local _v200 = {}
local _v20 = 5
local function _v201(name, _v184, ...)
local _v342, res = pcall(_v184, ...)
if _v342 then
local _v471 = _v200[name]
if _v471 then
_v471.failures = 0
end
return true, res
end
local _v471 = _v200[name]
if not _v471 then
_v471 = { failures = 0, lastWarn = -math.huge }
_v200[name] = _v471
end
_v471.failures = _v471.failures + 1
local _v324 = os.clock()
if _v324 - _v471.lastWarn >= _v20 then
_v471.lastWarn = _v324
warn(string.format((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,112,195,94,252,209,201,95,93,121,117,152,6,191,212,137,9,24,56,38})), name, _v471.failures, tostring(res)))
end
return false, nil
end
function _v13.IsRunning()
return _v430
end
function _v13.SaveConfig(name)
return _v11.save(name, _v12)
end
function _v13.LoadConfig(name)
local _v342, res = _v11.load(name, _v12)
if _v342 then
pcall(function()
UI:SyncControls()
end)
end
return _v342, res
end
function _v13.ListConfigs()
return _v11.list()
end
function _v13.DeleteConfig(name)
return _v11.delete(name)
end
function _v13.ServerHop()
return _v46:ServerHop()
end
function _v13.Rejoin()
return _v46:Rejoin()
end
function _v13.SetWatermarkImage(_v228)
_v12.UI.WatermarkImageId = tostring(_v228 or (_V9({})))
UI:SetWatermarkImage(_v12.UI.WatermarkImageId)
return _v13
end
function _v13.SetWebhook(_v533)
return _v48.SetWebhook(_v533)
end
function _v13.HasWebhook()
return _v48.HasWebhook()
end
function _v13.SendWebhook(content, _v367)
return _v48.SendWebhook(content, _v367)
end
function _v13.SendLoadedEmbed(_v239)
return _v48.SendLoadedEmbed(_v239)
end
function _v13.Start()
if _v430 then
return _v13
end
_v430 = true
local _v342, err = pcall(function()
ESP:Init()
UI:Init(_v12, function()
_v13.Stop()
end)
Movement:Init(_v12.Movement)
SilentAim:Init(_v12)
table.insert(_v123, _v31.PlayerAdded:Connect(function(_v384)
_v201((_V9({224,18,251,201,197,65,121,121,49,213,26})), ESP.OnPlayerAdded, ESP, _v384)
end))
table.insert(_v123, _v31.PlayerRemoving:Connect(function(_v384)
_v201((_V9({224,18,251,201,197,65,106,120,56,223,8,243,222,199})), ESP.OnPlayerRemoving, ESP, _v384)
end))
table.insert(_v123, _v45.InputBegan:Connect(function(_v232, _v195)
if _v195 or UI:IsCapturingKey() then
return
end
_v201((_V9({251,27,227,210,201,93,92,110})), function()
local _v247 = _v232.KeyCode
if _v247 == _v12.UI.MenuKey then
UI:Toggle()
elseif _v247 == _v12.UI.UnloadKey then
_v13.Stop()
else
local _v512 = {
{ _v12.Camera, (_V9({245,16,251,210,204,86,92})), _v12.Camera.ToggleKey },
{ _v12.ESP, (_V9({245,16,251,210,204,86,92})), _v12.ESP.ToggleKey },
{ _v12.Camera, (_V9({246,49,204,243,201,65,91,113,48})), _v12.Camera.FOVCircleKey },
{ _v12.NoRecoil, (_V9({245,16,251,210,204,86,92})), _v12.NoRecoil.ToggleKey },
{ _v12.NoSpread, (_V9({245,16,251,210,204,86,92})), _v12.NoSpread.ToggleKey },
{ _v12.Triggerbot, (_V9({245,16,251,210,204,86,92})), _v12.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v512) do
if _v247 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v189, fpsFrames = 0, 0
table.insert(_v123, _v37.RenderStepped:Connect(function(_v161)
_v201((_V9({243,31,244,212,201,87,89,105,48,195})), _v9.Update, _v9, _v12.Camera, _v12.ESP)
_v201((_V9({245,45,202})), ESP.Update, ESP, _v12.ESP)
local _v344, target = true, nil
if not (UI.IsSpectating and UI.IsSpectating()) then
_v344, target = _v201((_V9({241,23,247,210,207,71})), _v8.Update, _v8, _v12.Camera, _v12.Debug)
end
if not _v344 then
target = nil
end
if _v12.UI.TargetDisplay then
_v201((_V9({228,31,232,215,197,71,24,121,60,195,14,246,209,217})), function()
local _v269 = _v8:GetLookTarget(_v12.ESP, _v12.Camera)
UI:SetCurrentTarget(_v269 and _v269.Name or nil)
end)
end
_v62 = _v12.Camera.Enabled and target ~= nil
_v201((_V9({254,17,201,192,210,86,89,121})), NoSpread.Update, NoSpread, _v12.NoSpread)
_v201((_V9({227,23,246,213,206,71,24,92,60,221})), SilentAim.Update, SilentAim, _v12)
_v201((_V9({228,12,243,215,199,86,74,127,58,196})), Triggerbot.Update, Triggerbot, _v12.Triggerbot, _v12.Camera)
_v201((_V9({253,17,236,213,205,86,86,105})), Movement.Update, Movement, _v161, _v12.Movement)
_v201((_V9({248,23,238,210,207,75})), _v22.Update, _v22, _v12.Hitbox, _v12.Camera)
_v201((_V9({244,12,251,199,201,93,95,61,16,227,46})), _v16.Update, _v16, _v12.Drawing, _v12.Camera)
_v201((_V9({230,23,233,197,193,95,75})), Visuals.Update, Visuals, _v12.Visuals)
_v189 = _v189 + _v161
fpsFrames = fpsFrames + 1
if _v189 >= 0.25 then
local _v188 = math.floor(fpsFrames / _v189 + 0.5)
_v189, fpsFrames = 0, 0
if _v12.UI.FPSCounter then
_v201((_V9({246,46,201,144,195,92,77,115,33,213,12})), UI.UpdateFPS, UI, _v188)
end
end
end))
pcall(function()
_v37:UnbindFromRenderStep(_v32)
end)
pcall(function()
_v37:BindToRenderStep(_v32, Enum.RenderPriority.Camera.Value + 1, function()
_v201((_V9({254,17,200,213,195,92,81,113})), NoRecoil.Update, NoRecoil, _v12.NoRecoil, _v62)
end)
end)
end)
if not _v342 then
warn((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,19,209,23,246,213,196,19,76,114,117,195,10,251,194,212,9})), err)
_v13.Stop()
return _v13
end
if not _v10.HideGlobal((_V9({230,31,244,217,212,74,127,120,59,213,12,251,220})), _v13) and getgenv then
getgenv().VanityGeneral = _v13
end
UI:Notify(string.format((_V9({230,31,244,217,212,74,21,90,48,222,27,232,209,204,19,84,114,52,212,27,254,144,128,209,184,191,117,144,46,232,213,211,64,24,56,38})), _v12.UI.MenuKey.Name), 4)
print(string.format((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,7,197,16,244,217,206,84,24,53,35,149,13,179})), _v13.Version))
print(string.format((_V9({253,27,244,197,154,19,29,110,117,144,2,186,144,227,82,85,120,39,209,68,186,149,211,19,24,97,117,144,43,244,220,207,82,92,39,117,149,13})),
_v12.UI.MenuKey.Name,
_v12.Camera.ToggleKey.Name,
_v12.UI.UnloadKey.Name))
if _v48.HasWebhook() then
task.spawn(function()
_v48.SendLoadedEmbed(false)
end)
end
return _v13
end
function _v13.Stop()
if not _v430 then
return _v13
end
_v430 = false
for _, _v122 in ipairs(_v123) do
pcall(function()
_v122:Disconnect()
end)
end
table.clear(_v123)
pcall(function()
_v37:UnbindFromRenderStep(_v32)
end)
_v62 = false
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
table.clear(_v200)
print((_V9({235,40,251,222,201,71,65,48,18,213,16,255,194,193,95,101,61,6,196,17,234,192,197,87})))
return _v13
end
function _v13.Toggle()
if _v430 then
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
local _v393 = getgenv().VanityGeneral
if _v393 and _v393 ~= _v13 and type(_v393.Stop) == (_V9({214,11,244,211,212,90,87,115})) then
pcall(_v393.Stop)
end
end
pcall(function()
_v13.Start()
end)
return _v13
end
