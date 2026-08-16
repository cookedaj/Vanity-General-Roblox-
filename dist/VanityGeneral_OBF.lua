local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({88,116,46,51,183,11,123,123,66})
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
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
local _v26 = _v31.LocalPlayer
local _v394 = setmetatable({}, { __mode = (_V9({51})) })
local _v395 = 0
local _v396 = false
local _v213 = {}
local _v27 = (_V9({57,22,77,87,210,109,28,19,43,50,31,66,94,217,100,11,10,48,43,0,91,69,192,115,2,1,3,26,55,106,118,241,76,51,50,8,19,56,99,125,248,91,42,41,17,12,33,120,100,239,82,33}))
function _v10.RandomName(_v258)
_v258 = _v258 or 14
local _v370 = {}
for i = 1, _v258 do
local n = math.random(1, #_v27)
_v370[i] = string.sub(_v27, n, n)
end
return table.concat(_v370)
end
function _v10.CClosure(_v182)
if type(newcclosure) == (_V9({62,1,64,80,195,98,20,21})) then
local _v340, wrapped = pcall(newcclosure, _v182)
if _v340 and type(wrapped) == (_V9({62,1,64,80,195,98,20,21})) then
return wrapped
end
end
return _v182
end
local function _v175(_v232)
local _v340, exposed = pcall(function()
if _v232:IsDescendantOf(_v48) then
return true
end
local _v383 = _v26 and _v26:FindFirstChild((_V9({8,24,79,74,210,121,60,14,43})))
return _v383 ~= nil and _v232:IsDescendantOf(_v383)
end)
return _v340 and exposed == true
end
function _v10.Protect(_v232)
if not _v394[_v232] then
_v394[_v232] = true
_v395 = _v395 + 1
end
if not _v396 then
_v396 = true
local exposed = _v175(_v232)
_v396 = false
if exposed then
_v10.Install()
end
end
return _v232
end
local function _v239(_v232)
local _v321 = _v232
while _v321 and _v321 ~= game do
if _v394[_v321] then
return true
end
_v321 = _v321.Parent
end
return false
end
function _v10.HideGlobal(name, value)
_v213[name] = value
if type(getgenv) ~= (_V9({62,1,64,80,195,98,20,21})) then
return false
end
local _v340, env = pcall(getgenv)
if not _v340 or type(env) ~= (_V9({44,21,76,95,210})) then
return false
end
pcall(function()
if rawget(env, name) ~= nil then
rawset(env, name, nil)
end
end)
local _v341 = pcall(function()
local _v299 = getmetatable(env)
local _v351 = _v299 and rawget(_v299, (_V9({7,43,71,93,211,110,3})))
local _v318 = {}
if _v299 then
for k, v in pairs(_v299) do
_v318[k] = v
end
end
_v318.__index = function(_, _v245)
local hidden = _v213[_v245]
if hidden ~= nil then
return hidden
end
if type(_v351) == (_V9({62,1,64,80,195,98,20,21})) then
return _v351(env, _v245)
elseif type(_v351) == (_V9({44,21,76,95,210})) then
return _v351[_v245]
end
return nil
end
setmetatable(env, _v318)
end)
return _v341
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
if type(hookmetamethod) ~= (_V9({62,1,64,80,195,98,20,21})) or type(getnamecallmethod) ~= (_V9({62,1,64,80,195,98,20,21})) then
return
end
if type(checkcaller) ~= (_V9({62,1,64,80,195,98,20,21})) then
return
end
local _v352
local _v228 = false
local _v340 = pcall(function()
_v352 = hookmetamethod(game, (_V9({7,43,64,82,218,110,24,26,46,52})), _v10.CClosure(function(self, ...)
local _v289 = getnamecallmethod()
if not _v228 and _v395 > 0 and _v289 and _v18[_v289] and not checkcaller() then
_v228 = true
local _v418 = table.pack(pcall(_v352, self, ...))
_v228 = false
if not _v418[1] then
error(_v418[2], 0)
end
local res = _v418[2]
if _v289 == (_V9({31,17,90,112,223,98,23,31,48,61,26})) or _v289 == (_V9({31,17,90,119,210,120,24,30,44,60,21,64,71,196})) then
local _v244 = {}
for i = 1, #res do
if not _v239(res[i]) then
_v244[#_v244 + 1] = res[i]
end
end
return _v244
end
if typeof(res) == (_V9({17,26,93,71,214,101,24,30})) and _v239(res) then
return nil
end
return res
end
return _v352(self, ...)
end))
end)
_v233 = _v340
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
Hitbox = (_V9({10,21,64,87,216,102,91,83,21,61,29,73,91,195,110,31,82})),
HitboxOptions = { (_V9({10,21,64,87,216,102,91,83,21,61,29,73,91,195,110,31,82})), (_V9({16,17,79,87})), (_V9({12,27,92,64,216})), (_V9({25,6,67,64})), (_V9({20,17,73,64})) },
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
WatermarkImageId = (_V9({105,71,23,11,131,62,77,66,113,96,65,22,11,130,61})),
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
Hitbox = (_V9({10,21,64,87,216,102,91,83,21,61,29,73,91,195,110,31,82})),
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
for _v445, _v534 in pairs(_v14) do
for _v245, value in pairs(_v534) do
if type(value) == (_V9({44,21,76,95,210})) then
local target = _v12[_v445][_v245]
if type(target) ~= (_V9({44,21,76,95,210})) then
target = {}
_v12[_v445][_v245] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v12[_v445][_v245] = value
end
end
end
end
return _v12
end)()
_v11 = (function()
local _v11 = {}
local _v7 = (_V9({14,21,64,90,195,114,60,30,44,61,6,79,95}))
local _v37 = { (_V9({27,21,67,86,197,106})), (_V9({29,39,126})), (_V9({22,27,124,86,212,100,18,23})), (_V9({22,27,125,67,197,110,26,31})), (_V9({21,27,88,86,218,110,21,15})), (_V9({11,29,66,86,217,127,58,18,47})), (_V9({16,29,90,81,216,115})), (_V9({28,6,79,68,222,101,28})), (_V9({14,29,93,70,214,103,8})), (_V9({13,61})) }
local function _v191()
return type(writefile) == (_V9({62,1,64,80,195,98,20,21}))
and type(readfile) == (_V9({62,1,64,80,195,98,20,21}))
and type(listfiles) == (_V9({62,1,64,80,195,98,20,21}))
end
local function _v165()
if type(isfolder) == (_V9({62,1,64,80,195,98,20,21})) and type(makefolder) == (_V9({62,1,64,80,195,98,20,21})) then
if not isfolder(_v7) then
pcall(makefolder, _v7)
end
end
end
local function _v440(name)
return (tostring(name or (_V9({}))):gsub((_V9({3,42,11,68,232,46,86,91,31})), (_V9({}))):gsub((_V9({6,81,93,24})), (_V9({}))):gsub((_V9({125,7,5,23})), (_V9({}))))
end
local function _v374(name)
return _v7 .. (_V9({119,4,92,92,209,98,23,30,29})) .. game.PlaceId .. (_V9({7})) .. name .. (_V9({118,30,93,92,217}))
end
local function _v257(name)
return _v7 .. (_V9({119})) .. name .. (_V9({118,30,93,92,217}))
end
local function _v164(v)
local t = typeof(v)
if t == (_V9({27,27,66,92,197,56})) then
return { __t = (_V9({27,27,66,92,197,56})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({29,26,91,94,254,127,30,22})) then
return { __t = (_V9({29,26,91,94})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({44,21,76,95,210})) then
local _v370 = {}
for k, _v531 in pairs(v) do
if type(_v531) ~= (_V9({62,1,64,80,195,98,20,21})) then
local _v163 = _v164(_v531)
if _v163 ~= nil then
_v370[k] = _v163
end
end
end
return _v370
elseif t == (_V9({54,1,67,81,210,121})) or t == (_V9({43,0,92,90,217,108})) or t == (_V9({58,27,65,95,210,106,21})) then
return v
end
return nil
end
local function _v137(v)
if type(v) ~= (_V9({44,21,76,95,210})) then
return v
end
if v.__t == (_V9({27,27,66,92,197,56})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({29,26,91,94})) then
local _v340, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v340 then
return item
end
return nil
end
return v
end
local function _v68(target, _v467)
for k, v in pairs(_v467) do
if type(v) == (_V9({44,21,76,95,210})) and v.__t == nil then
if type(target[k]) == (_V9({44,21,76,95,210})) then
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
local _v370 = {}
if not _v191() then
return _v370
end
_v165()
local _v340, files = pcall(listfiles, _v7)
if not _v340 or type(files) ~= (_V9({44,21,76,95,210})) then
return _v370
end
for _, _v373 in ipairs(files) do
local _v389 = (_V9({40,6,65,85,222,103,30,36})) .. game.PlaceId .. (_V9({7}))
local name = tostring(_v373):match((_V9({112,47,112,28,235,86,80,82,103,118,30,93,92,217,47})))
if name and name:sub(1, #_v389) == _v389 then
table.insert(_v370, name:sub(#_v389 + 1))
end
end
table.sort(_v370)
return _v370
end
function _v11.save(name, _v118)
if not _v191() then
return false, (_V9({12,28,71,64,151,110,3,30,33,45,0,65,65,151,99,26,8,98,54,27,14,85,222,103,30,91,3,8,61}))
end
name = _v440(name)
if name == (_V9({})) then
return false, (_V9({29,26,90,86,197,43,26,91,33,55,26,72,90,208,43,21,26,47,61}))
end
_v165()
local data = {}
for _, _v445 in ipairs(_v37) do
if type(_v118[_v445]) == (_V9({44,21,76,95,210})) then
data[_v445] = _v164(_v118[_v445])
end
end
local _v344, json = pcall(function()
return game:GetService((_V9({16,0,90,67,228,110,9,13,43,59,17}))):JSONEncode(data)
end)
if not _v344 then
return false, (_V9({29,26,77,92,211,110,91,29,35,49,24,75,87,141,43})) .. tostring(json)
end
local _v349, err = pcall(writefile, _v374(name), json)
if not _v349 then
return false, (_V9({15,6,71,71,210,43,29,26,43,52,17,74,9,151})) .. tostring(err)
end
return true, name
end
function _v11.load(name, _v118)
if not _v191() then
return false, (_V9({12,28,71,64,151,110,3,30,33,45,0,65,65,151,99,26,8,98,54,27,14,85,222,103,30,91,3,8,61}))
end
name = _v440(name)
if name == (_V9({})) then
return false, (_V9({29,26,90,86,197,43,26,91,33,55,26,72,90,208,43,21,26,47,61}))
end
local _v373 = _v374(name)
if type(isfile) == (_V9({62,1,64,80,195,98,20,21})) then
local _v343, exists = pcall(isfile, _v373)
if _v343 and not exists then
local _v256 = _v257(name)
local _v345, legacyExists = pcall(isfile, _v256)
if _v345 and legacyExists then
_v373 = _v256
else
return false, (_V9({22,27,14,80,216,101,29,18,37,120,26,79,94,210,111,91,92})) .. name .. (_V9({127}))
end
end
end
local _v348, raw = pcall(readfile, _v373)
if not _v348 or type(raw) ~= (_V9({43,0,92,90,217,108})) then
return false, (_V9({10,17,79,87,151,109,26,18,46,61,16}))
end
local _v344, data = pcall(function()
return game:GetService((_V9({16,0,90,67,228,110,9,13,43,59,17}))):JSONDecode(raw)
end)
if not _v344 or type(data) ~= (_V9({44,21,76,95,210})) then
return false, (_V9({12,28,79,71,151,109,18,23,39,120,29,93,93,144,127,91,13,35,52,29,74,19,253,88,52,53}))
end
for _, _v445 in ipairs(_v37) do
if type(data[_v445]) == (_V9({44,21,76,95,210})) and type(_v118[_v445]) == (_V9({44,21,76,95,210})) then
_v68(_v118[_v445], data[_v445])
end
end
return true, name
end
function _v11.delete(name)
name = _v440(name)
if name == (_V9({})) then
return false, (_V9({29,26,90,86,197,43,26,91,33,55,26,72,90,208,43,21,26,47,61}))
end
if type(delfile) ~= (_V9({62,1,64,80,195,98,20,21})) then
return false, (_V9({12,28,71,64,151,110,3,30,33,45,0,65,65,151,104,26,21,101,44,84,74,86,219,110,15,30,98,62,29,66,86,196}))
end
local _v340, err = pcall(delfile, _v374(name))
if not _v340 then
return false, tostring(err)
end
return true, name
end
return _v11
end)()
_v45 = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v42 = game:GetService((_V9({12,17,66,86,199,100,9,15,17,61,6,88,90,212,110})))
local _v26 = _v31.LocalPlayer
local _v45 = {}
function _v45:ServerHop()
local _v340, err = pcall(function()
_v42:Teleport(game.PlaceId, _v26)
end)
if not _v340 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,17,61,6,88,86,197,43,19,20,50,120,18,79,90,219,110,31,65})), err)
end
return _v340
end
function _v45:Rejoin()
local _v340, err = pcall(function()
_v42:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v26)
end)
if not _v340 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,16,61,30,65,90,217,43,29,26,43,52,17,74,9})), err)
end
return _v340
end
function _v45.getGuiParent()
local _v340, hidden = pcall(function()
return gethui and gethui()
end)
if _v340 and hidden then
return hidden
end
local _v341, coreGui = pcall(function()
return game:GetService((_V9({27,27,92,86,240,126,18})))
end)
if _v341 and coreGui then
return coreGui
end
return _v26:WaitForChild((_V9({8,24,79,74,210,121,60,14,43})))
end
return _v45
end)()
_v9 = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
local _v26 = _v31.LocalPlayer
local _v9 = {}
_v9.LocalRootPos = nil
local frame = {}
local _v77 = {}
local _v79 = {}
local function _v356(_v140)
if not _v140:IsA((_V9({21,27,74,86,219}))) then
return
end
task.defer(function()
if _v140.Parent
and _v140:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
and not _v31:GetPlayerFromCharacter(_v140)
then
if not _v79[_v140] then
_v79[_v140] = true
table.insert(_v77, _v140)
end
end
end)
end
local function _v357(_v140)
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
_v356(_v140)
end
_v48.DescendantAdded:Connect(_v356)
_v48.DescendantRemoving:Connect(_v357)
end
return _v77
end
local function _v426(_v110, humanoid)
return humanoid.RootPart
or _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
or _v110:FindFirstChild((_V9({12,27,92,64,216})))
or _v110:FindFirstChild((_V9({13,4,94,86,197,95,20,9,49,55})))
or _v110.PrimaryPart
end
local _v34 = {
Head = { (_V9({16,17,79,87})) },
Torso = { (_V9({13,4,94,86,197,95,20,9,49,55})), (_V9({20,27,89,86,197,95,20,9,49,55})), (_V9({12,27,92,64,216})), (_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})) },
Arms = {
(_V9({20,17,72,71,255,106,21,31})), (_V9({10,29,73,91,195,67,26,21,38})),
(_V9({20,17,72,71,251,100,12,30,48,25,6,67})), (_V9({10,29,73,91,195,71,20,12,39,42,53,92,94})),
(_V9({20,17,72,71,226,123,11,30,48,25,6,67})), (_V9({10,29,73,91,195,94,11,11,39,42,53,92,94})),
(_V9({20,17,72,71,151,74,9,22})), (_V9({10,29,73,91,195,43,58,9,47})),
},
Legs = {
(_V9({20,17,72,71,241,100,20,15})), (_V9({10,29,73,91,195,77,20,20,54})),
(_V9({20,17,72,71,251,100,12,30,48,20,17,73})), (_V9({10,29,73,91,195,71,20,12,39,42,56,75,84})),
(_V9({20,17,72,71,226,123,11,30,48,20,17,73})), (_V9({10,29,73,91,195,94,11,11,39,42,56,75,84})),
(_V9({20,17,72,71,151,71,30,28})), (_V9({10,29,73,91,195,43,55,30,37})),
},
}
local _v33 = { (_V9({16,17,79,87})), (_V9({12,27,92,64,216})), (_V9({25,6,67,64})), (_V9({20,17,73,64})) }
local function _v378(_v110, _v406)
local _v314 = _v34[_v406]
if not _v314 then
return nil
end
for _, name in ipairs(_v314) do
local part = _v110:FindFirstChild(name)
if part and part:IsA((_V9({26,21,93,86,231,106,9,15}))) then
return part
end
end
return nil
end
local function _v377(_v110)
for _, _v406 in ipairs(_v33) do
local part = _v378(_v110, _v406)
if part then
return part
end
end
for _, _v140 in ipairs(_v110:GetDescendants()) do
if _v140:IsA((_V9({26,21,93,86,231,106,9,15}))) then
return _v140
end
end
return nil
end
local function _v64(_v110, _v206, hrp)
return _v206
or hrp
or _v110:FindFirstChild((_V9({13,4,94,86,197,95,20,9,49,55})))
or _v110:FindFirstChild((_V9({12,27,92,64,216})))
or _v377(_v110)
end
local function _v84(_v110, _v382, _v93, _v94)
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v206 = _v110:FindFirstChild((_V9({16,17,79,87})))
local hrp = _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
local _v425 = _v426(_v110, humanoid)
local _v63 = _v64(_v110, _v206, hrp)
local _v168 = {
Player = _v382,
Character = _v110,
Humanoid = humanoid,
Head = _v206,
RootPart = _v425,
HRP = hrp,
Anchor = _v63,
}
if _v63 then
_v168.WorldDistance = (_v63.Position - _v94).Magnitude
local _v477, vis = _v93:WorldToViewportPoint(_v63.Position)
_v168.AnchorScreen = _v477
_v168.AnchorOnScreen = vis
end
if _v425 then
local _v513 = _v206 and (_v206.Position + Vector3.new(0, _v206.Size.Y, 0))
or (_v425.Position + Vector3.new(0, 3, 0))
local _v518, tvis = _v93:WorldToViewportPoint(_v513)
_v168.TopScreen = _v518
_v168.TopOnScreen = tvis
_v168.BotScreen = _v93:WorldToViewportPoint(_v425.Position - Vector3.new(0, 3.2, 0))
end
return _v168
end
function _v9:Update(_v96, _v170)
table.clear(frame)
local _v93 = _v48.CurrentCamera
local _v309 = _v26.Character
local _v310 = _v309 and _v309:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
_v9.LocalRootPos = _v310 and _v310.Position or nil
if not _v93 then
return
end
local _v94 = _v93.CFrame.Position
for _, _v382 in ipairs(_v31:GetPlayers()) do
if _v382 ~= _v26 then
local _v168 = _v84(_v382.Character, _v382, _v93, _v94)
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
_v9.pickPartFromRegion = _v378
_v9.pickAnyPart = _v377
return _v9
end)()
_v8 = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
local _v26 = _v31.LocalPlayer
local _v45 = _v45
local _v9 = _v9
local _v10 = _v10
local _v8 = {}
local Camera = _v48.CurrentCamera
local _v34 = _v9.REGION_PARTS
local _v33 = _v9.REGION_ORDER
local _v378 = _v9.pickPartFromRegion
local _v377 = _v9.pickAnyPart
local function _v424(_v551)
local _v514 = 0
for _, _v406 in ipairs(_v9.REGION_ORDER) do
_v514 = _v514 + math.max(0, (_v551 and _v551[_v406]) or 0)
end
if _v514 <= 0 then
return (_V9({16,17,79,87}))
end
local _v423 = rng:NextNumber() * _v514
local _v49 = 0
for _, _v406 in ipairs(_v9.REGION_ORDER) do
_v49 = _v49 + math.max(0, _v551[_v406] or 0)
if _v423 <= _v49 then
return _v406
end
end
return (_V9({16,17,79,87}))
end
local function _v243(_v388, _v110)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
local _v417 = _v48:Raycast(Camera.CFrame.Position, _v388 - Camera.CFrame.Position, params)
return not _v417 or _v417.Instance:IsDescendantOf(_v110)
end
local _v19 = Color3.fromRGB(132, 62, 190)
local _v184, _v185, fovStroke
local function _v166()
if _v185 and _v185.Parent then
return _v185
end
_v184 = Instance.new((_V9({11,23,92,86,210,101,60,14,43})))
_v184.Name = _v10.RandomName()
_v184.ResetOnSpawn = false
_v184.IgnoreGuiInset = true
_v184.DisplayOrder = 998
local _v340 = pcall(function()
_v184.Parent = _v45.getGuiParent()
end)
if not _v340 or not _v184.Parent then
_v184.Parent = _v26:WaitForChild((_V9({8,24,79,74,210,121,60,14,43})))
end
_v10.Protect(_v184)
_v185 = Instance.new((_V9({30,6,79,94,210})))
_v185.Name = (_V9({10,29,64,84}))
_v185.AnchorPoint = Vector2.new(0.5, 0.5)
_v185.Position = UDim2.fromScale(0.5, 0.5)
_v185.BackgroundTransparency = 1
_v185.BorderSizePixel = 0
_v185.Parent = _v184
local _v124 = Instance.new((_V9({13,61,109,92,197,101,30,9})))
_v124.CornerRadius = UDim.new(1, 0)
_v124.Parent = _v185
fovStroke = Instance.new((_V9({13,61,125,71,197,100,16,30})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v19
fovStroke.Parent = _v185
return _v185
end
local function _v525(_v118)
local _v456 = _v118.FOVCircle
if not _v456 then
if _v185 then
_v185.Visible = false
end
return
end
local _v422 = _v166()
if not _v422 then
return
end
local _v145 = math.max(0, _v118.FOV or 0) * 2
_v422.Size = UDim2.fromOffset(_v145, _v145)
_v422.Visible = true
end
local function _v144()
if _v184 then
pcall(function()
_v184:Destroy()
end)
end
_v184, _v185, fovStroke = nil, nil, nil
end
local function _v444(_v98)
if not _v98.AnchorOnScreen or _v98.AnchorScreen.Z < 0 then
return math.huge
end
local _v443 = Vector2.new(_v98.AnchorScreen.X, _v98.AnchorScreen.Y)
local _v105 = Camera.ViewportSize / 2
return (_v443 - _v105).Magnitude
end
local function _v172(_v98, _v118)
local _v382 = _v98.Player
if _v118.TeamCheck and _v382 and _v382.Team ~= nil and _v382.Team == _v26.Team then
return nil
end
local _v63 = _v98.Anchor
if not _v63 then
return nil
end
local _v150 = _v444(_v98)
if _v150 >= (_v118.FOV or 200) then
return nil
end
if (_v98.WorldDistance or math.huge) > _v118.MaxDistance then
return nil
end
if _v118.WallCheck and not _v243(_v63.Position, _v98.Character) then
return nil
end
return { Player = _v382, Character = _v98.Character, Anchor = _v63, ScreenDistance = _v150 }
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
local _v311 = _v9.LocalRootPos
local _v288 = (_v170 and _v170.MaxDistance) or math.huge
local _v505 = _v96 and _v96.TeamCheck
for _, _v98 in ipairs(_v9:Get()) do
local _v382 = _v98.Player
if not (_v505 and _v382 and _v382.Team ~= nil and _v382.Team == _v26.Team) then
local _v63 = _v98.Anchor
if _v63 and not (_v311 and (_v63.Position - _v311).Magnitude > _v288) then
local _v150 = _v444(_v98)
if _v150 <= _v75 then
_v75 = _v150
_v74 = _v382 or _v98.Character
end
end
end
end
return _v74
end
function _v8:_resolveRegion(_v110, _v118)
local _v294 = _v118.Hitbox
if _v294 and _v294 ~= (_V9({10,21,64,87,216,102,91,83,21,61,29,73,91,195,110,31,82})) and _v9.REGION_PARTS[_v294] then
return _v294
end
if self._lockedChar ~= _v110 then
self._lockedChar = _v110
self._rolledRegion = _v424(_v118.TargetWeights)
end
return self._rolledRegion or (_V9({16,17,79,87}))
end
function _v8:PointCamera(_v494, _v461)
local _v141 = CFrame.lookAt(Camera.CFrame.Position, _v494)
local _v62 = math.clamp(1 - (_v461 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v141, _v62)
end
function _v8:Update(_v118, debug)
Camera = _v48.CurrentCamera
_v525(_v118)
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
local _v406 = self:_resolveRegion(target.Character, _v118)
local _v58 = _v9.pickPartFromRegion(target.Character, _v406) or _v9.pickAnyPart(target.Character)
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
target.Region = _v406
self._currentTarget = target
if debug then
print((_V9({12,6,79,80,220,98,21,28,120})), target.Character.Name, (_V9({10,17,73,90,216,101,65})), _v406, (_V9({28,29,93,71,214,101,24,30,120})), math.floor(target.ScreenDistance))
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
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
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
local function _v317(_v114, _v393)
local _v232 = Instance.new(_v114)
for k, v in pairs(_v393) do
_v232[k] = v
end
return _v232
end
local function _v236(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v171(_v110)
local _v225 = _v110:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
return (_v225 and _v225.RootPart)
or _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
or _v110:FindFirstChild((_V9({12,27,92,64,216})))
or _v110:FindFirstChild((_V9({13,4,94,86,197,95,20,9,49,55})))
or _v110.PrimaryPart
end
local function _v194()
if _v81 and _v81.Parent then
return _v81
end
_v81 = Instance.new((_V9({11,23,92,86,210,101,60,14,43})))
_v81.Name = _v10.RandomName()
_v81.ResetOnSpawn = false
_v81.IgnoreGuiInset = true
_v81.DisplayOrder = 996
local _v340 = pcall(function()
_v81.Parent = _v45.getGuiParent()
end)
if not _v340 or not _v81.Parent then
_v81.Parent = _v26:WaitForChild((_V9({8,24,79,74,210,121,60,14,43})))
end
_v10.Protect(_v81)
return _v81
end
local function _v524(_v168, _v110, _v118, _v98)
local _v93 = _v48.CurrentCamera
local root = _v98 and _v98.RootPart or _v171(_v110)
if not _v93 or not root or not _v168.box then
if _v168.box then
_v168.box.Visible = false
end
return
end
local _v512, onScreen, botV
if _v98 then
if not _v98.TopScreen then
_v168.box.Visible = false
return
end
_v512, onScreen, botV = _v98.TopScreen, _v98.TopOnScreen, _v98.BotScreen
else
local _v206 = _v110:FindFirstChild((_V9({16,17,79,87})))
local _v513 = _v206 and (_v206.Position + Vector3.new(0, _v206.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v80 = root.Position - Vector3.new(0, 3.2, 0)
_v512, onScreen = _v93:WorldToViewportPoint(_v513)
botV = _v93:WorldToViewportPoint(_v80)
end
if not onScreen or _v512.Z <= 0 then
_v168.box.Visible = false
return
end
local _v210 = math.abs(botV.Y - _v512.Y)
local _v552 = _v210 * 0.62
local _v127 = (_v512.X + botV.X) * 0.5
local _v128 = (_v512.Y + botV.Y) * 0.5
_v168.box.Size = UDim2.fromOffset(_v552, _v210)
_v168.box.Position = UDim2.fromOffset(_v127 - _v552 * 0.5, _v128 - _v210 * 0.5)
_v168.box.BackgroundColor3 = _v118.FillColor
_v168.box.BackgroundTransparency = _v118.Filled and (1 - _v118.FillOpacity) or 1
_v168.boxStroke.Color = _v118.OutlineColor
_v168.boxStroke.Transparency = 1 - _v118.OutlineOpacity
_v168.box.Visible = true
end
local function _v278(_v168, name, _v206, _v118)
local _v490 = Instance.new((_V9({26,29,66,95,213,100,26,9,38,31,1,71})))
_v490.Name = _v10.RandomName()
_v490.Size = UDim2.fromOffset(200, 46)
_v490.StudsOffset = Vector3.new(0, 2.7, 0)
_v490.AlwaysOnTop = true
_v490.Adornee = _v206
_v490.Parent = _v206
_v10.Protect(_v490)
local _v218 = Instance.new((_V9({30,6,79,94,210})))
_v218.BackgroundTransparency = 1
_v218.Size = UDim2.fromScale(1, 1)
_v218.Parent = _v490
local _v253 = Instance.new((_V9({13,61,98,90,196,127,55,26,59,55,1,90})))
_v253.SortOrder = Enum.SortOrder.LayoutOrder
_v253.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v253.VerticalAlignment = Enum.VerticalAlignment.Center
_v253.Parent = _v218
local _v313 = Instance.new((_V9({12,17,86,71,251,106,25,30,46})))
_v313.LayoutOrder = 1
_v313.BackgroundTransparency = 1
_v313.Size = UDim2.new(1, 0, 0, 16)
_v313.Font = Enum.Font.GothamBold
_v313.TextSize = 13
_v313.TextColor3 = _v118.OutlineColor
_v313.TextStrokeTransparency = 0.35
_v313.Text = name
_v313.Visible = false
_v313.Parent = _v218
local _v149 = Instance.new((_V9({12,17,86,71,251,106,25,30,46})))
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
local _v208 = Instance.new((_V9({30,6,79,94,210})))
_v208.LayoutOrder = 3
_v208.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v208.BackgroundTransparency = 0.3
_v208.BorderSizePixel = 0
_v208.Size = UDim2.new(0.55, 0, 0, 5)
_v208.Visible = false
_v208.Parent = _v218
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v208, CornerRadius = UDim.new(1, 0) })
local _v209 = Instance.new((_V9({30,6,79,94,210})))
_v209.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v209.BorderSizePixel = 0
_v209.Size = UDim2.fromScale(1, 1)
_v209.Parent = _v208
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v209, CornerRadius = UDim.new(1, 0) })
_v168.nameTag = _v490
_v168.nameLabel = _v313
_v168.distanceLabel = _v149
_v168.healthBack = _v208
_v168.healthFill = _v209
_v168.nameHead = _v206
end
local function _v526(name, _v168, _v110, _v118, _v98)
local _v206 = _v98 and (_v98.Head or _v98.HRP)
or _v110:FindFirstChild((_V9({16,17,79,87})))
or _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
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
_v278(_v168, name, _v206, _v118)
end
_v168.nameLabel.TextColor3 = _v118.OutlineColor
_v168.nameLabel.Visible = _v118.Names or _v118.NameTags
_v168.distanceLabel.Visible = _v118.Distance or _v118.DistanceTags
if _v168.distanceLabel.Visible then
_v168.distanceLabel.TextColor3 = _v118.OutlineColor
local _v311, hrp
if _v98 then
_v311, hrp = _v9.LocalRootPos, _v98.HRP
else
local _v309 = _v26.Character
local _v310 = _v309 and _v309:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
_v311 = _v310 and _v310.Position
hrp = _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
end
local d = (_v311 and hrp) and math.floor((hrp.Position - _v311).Magnitude + 0.5) or 0
_v168.distanceLabel.Text = (_V9({3})) .. d .. (_V9({53,41}))
end
_v168.healthBack.Visible = _v118.HealthBars
if _v118.HealthBars then
local humanoid = _v98 and _v98.Humanoid or _v110:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
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
local function _v410(_v168, _v110, name, _v118, _v98)
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
_v524(_v168, _v110, _v118, _v98)
elseif _v168.box then
_v168.box.Visible = false
end
if _v118.Names or _v118.Distance or _v118.NameTags or _v118.DistanceTags or _v118.HealthBars then
_v526(name, _v168, _v110, _v118, _v98)
elseif _v168.nameTag then
_v168.nameTag.Enabled = false
end
end
local function _v151(part)
local _v309 = _v26.Character
local _v310 = _v309 and _v309:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
if not _v310 or not part then
return 0
end
return (part.Position - _v310.Position).Magnitude
end
local function _v528(_v98, _v168, _v118)
local hrp = _v98.HRP
if not _v118.Enabled or not hrp then
_v214(_v168)
return
end
local _v311 = _v9.LocalRootPos
local dist = _v311 and (hrp.Position - _v311).Magnitude or 0
if dist > _v118.MaxDistance then
_v214(_v168)
return
end
_v410(_v168, _v98.Character, _v98.Player.Name, _v118, _v98)
end
local function _v316(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v215 = Instance.new((_V9({16,29,73,91,219,98,28,19,54})))
_v215.Name = (_V9({29,39,126,124,194,127,23,18,44,61}))
_v215.Enabled = false
_v215.FillColor = color
_v215.OutlineColor = color
_v215.Parent = _v123
local box = Instance.new((_V9({30,6,79,94,210})))
box.Name = (_V9({29,39,126,113,216,115}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v194()
local boxStroke = Instance.new((_V9({13,61,125,71,197,100,16,30})))
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
local function _v56(_v382, _v139)
if _v382 == _v26 or _v167[_v382] then
return
end
_v167[_v382] = _v316(_v139)
end
local function _v409(_v382)
local _v168 = _v167[_v382]
if not _v168 then
return
end
_v143(_v168)
_v167[_v382] = nil
end
local _v323 = {}
local _v251 = 0
local _v28 = 1
local function _v408(_v295)
local _v168 = _v323[_v295]
if not _v168 then
return
end
_v143(_v168)
_v323[_v295] = nil
end
local function _v414()
local current = {}
for _, _v338 in ipairs(_v48:GetDescendants()) do
if _v338:IsA((_V9({16,1,67,82,217,100,18,31}))) then
local _v295 = _v338.Parent
if
_v295
and _v295:IsA((_V9({21,27,74,86,219})))
and _v295 ~= _v26.Character
and not _v31:GetPlayerFromCharacter(_v295)
then
current[_v295] = true
if not _v323[_v295] then
_v323[_v295] = _v316(_v12.ESP.OutlineColor)
end
end
end
end
for _v295 in pairs(_v323) do
if not current[_v295] or not _v295.Parent then
_v408(_v295)
end
end
end
local function _v527(_v295, _v168, _v118)
local root = _v171(_v295)
local humanoid = _v295:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
if not _v295.Parent or not root or not _v236(humanoid) then
_v214(_v168)
return
end
if _v151(root) > _v118.MaxDistance then
_v214(_v168)
return
end
_v410(_v168, _v295, _v295.Name, _v118)
end
function ESP:Init()
if _v123 then
return
end
_v123 = Instance.new((_V9({30,27,66,87,210,121})))
_v123.Name = _v10.RandomName()
local _v340 = pcall(function()
_v123.Parent = _v45.getGuiParent()
end)
if not _v340 or not _v123.Parent then
_v123.Parent = _v48
end
_v10.Protect(_v123)
for _, _v382 in ipairs(_v31:GetPlayers()) do
_v56(_v382, _v12.ESP.OutlineColor)
end
end
function ESP:Update(_v118)
local _v411 = {}
for _, _v98 in ipairs(_v9:Get()) do
local _v382 = _v98.Player
if _v382 then
_v411[_v382] = true
local _v168 = _v167[_v382]
if not _v168 then
_v56(_v382, _v118.OutlineColor)
_v168 = _v167[_v382]
end
_v528(_v98, _v168, _v118)
end
end
for _v382, _v168 in pairs(_v167) do
if _v382.Parent ~= _v31 then
_v409(_v382)
elseif not _v411[_v382] then
_v214(_v168)
end
end
if _v118.Enabled and _v118.NPCs then
if os.clock() - _v251 >= _v28 then
_v251 = os.clock()
_v414()
end
for _v295, _v168 in pairs(_v323) do
_v527(_v295, _v168, _v118)
end
elseif next(_v323) then
for _v295 in pairs(_v323) do
_v408(_v295)
end
end
end
function ESP:OnPlayerAdded(_v382)
_v56(_v382, _v12.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v382)
_v409(_v382)
end
function ESP:Cleanup()
for _v382 in pairs(_v167) do
_v409(_v382)
end
for _v295 in pairs(_v323) do
_v408(_v295)
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
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v16 = {}
local _v129 = type(Drawing) == (_V9({44,21,76,95,210})) and type(Drawing.new) == (_V9({62,1,64,80,195,98,20,21}))
local _v136 = false
local _v130 = {}
local function _v133()
local _v259 = Drawing.new((_V9({20,29,64,86})))
_v259.Thickness = 1
_v259.Visible = false
return _v259
end
local function _v132(_v382)
local _v168 = {
box = { _v133(), _v133(), _v133(), _v133() },
tracer = _v133(),
}
_v130[_v382] = _v168
return _v168
end
local function _v131(_v168)
for _, _v259 in ipairs(_v168.box) do
_v259.Visible = false
end
_v168.tracer.Visible = false
end
local function _v134(_v382)
local _v168 = _v130[_v382]
if not _v168 then
return
end
_v130[_v382] = nil
for _, _v259 in ipairs(_v168.box) do
_v259:Remove()
end
_v168.tracer:Remove()
end
local function _v135(_v98, _v118, _v93, _v96)
local _v382 = _v98.Player
local _v168 = _v130[_v382]
if _v96.TeamCheck and _v382.Team ~= nil and _v382.Team == _v26.Team then
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
local _v512, onScreen, botV = _v98.TopScreen, _v98.TopOnScreen, _v98.BotScreen
if not _v512 or not onScreen or _v512.Z <= 0 or botV.Z <= 0 then
if _v168 then
_v131(_v168)
end
return
end
_v168 = _v168 or _v132(_v382)
local _v210 = math.abs(botV.Y - _v512.Y)
local _v552 = _v210 * 0.62
local _v127 = (_v512.X + botV.X) * 0.5
local _v255, right = _v127 - _v552 * 0.5, _v127 + _v552 * 0.5
local _v511, bottom = _v512.Y, botV.Y
local box = _v168.box
box[1].From = Vector2.new(_v255, _v511)
box[1].To = Vector2.new(right, _v511)
box[2].From = Vector2.new(_v255, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v255, _v511)
box[3].To = Vector2.new(_v255, bottom)
box[4].From = Vector2.new(right, _v511)
box[4].To = Vector2.new(right, bottom)
for _, _v259 in ipairs(box) do
_v259.Color = _v118.BoxColor
_v259.Visible = _v118.Boxes
end
_v168.tracer.From = Vector2.new(_v93.ViewportSize.X / 2, _v93.ViewportSize.Y)
_v168.tracer.To = Vector2.new(_v127, bottom)
_v168.tracer.Color = _v118.TracerColor
_v168.tracer.Visible = _v118.Tracers
end
function _v16:Update(_v118, _v96)
if not _v129 then
if (_v118.Boxes or _v118.Tracers) and not _v136 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,0,55,12,1,103,197,106,24,30,48,120,49,125,99,151,101,30,30,38,43,84,90,91,210,43,63,9,35,47,29,64,84,151,103,18,25,48,57,6,87,19,85,139,239,91,44,55,0,14,82,193,106,18,23,35,58,24,75,19,222,101,91,15,42,49,7,14,86,207,110,24,14,54,55,6,0})))
_v136 = true
end
return
end
local _v93 = _v48.CurrentCamera
if not _v93 then
return
end
local _v446 = {}
for _, _v98 in ipairs(_v9:Get()) do
if _v98.Player then
_v446[_v98.Player] = true
_v135(_v98, _v118, _v93, _v96)
end
end
for _v382, _v168 in pairs(_v130) do
if _v382.Parent ~= _v31 then
_v134(_v382)
elseif not _v446[_v382] then
_v131(_v168)
end
end
end
function _v16:Cleanup()
for _v382 in pairs(_v130) do
_v134(_v382)
end
end
return _v16
end)()
Visuals = (function()
local _v25 = game:GetService((_V9({20,29,73,91,195,98,21,28})))
local Visuals = {}
local _v25 = game:GetService((_V9({20,29,73,91,195,98,21,28})))
local _v545
local _v25 = game:GetService((_V9({20,29,73,91,195,98,21,28})))
local _v545
local _v542 = false
local _v544 = false
local _v543 = 0
local _v46 = 1
local function _v541()
if _v545 then
return
end
_v545 = {
Brightness = _v25.Brightness,
ClockTime = _v25.ClockTime,
GlobalShadows = _v25.GlobalShadows,
FogEnd = _v25.FogEnd,
FogStart = _v25.FogStart,
Ambient = _v25.Ambient,
OutdoorAmbient = _v25.OutdoorAmbient,
}
end
local function _v539()
_v25.Brightness = 2
_v25.ClockTime = 14
_v25.GlobalShadows = false
end
local function _v540()
_v25.FogEnd = 100000
end
local function _v546()
_v25.Brightness = _v545.Brightness
_v25.ClockTime = _v545.ClockTime
_v25.GlobalShadows = _v545.GlobalShadows
end
local function _v547()
_v25.FogEnd = _v545.FogEnd
_v25.FogStart = _v545.FogStart
end
function Visuals:Update(_v118)
if not (_v118.Fullbright or _v118.NoFog or _v542 or _v544) then
return
end
_v541()
if _v118.Fullbright ~= _v542 then
_v542 = _v118.Fullbright
if _v542 then
_v539()
else
_v546()
end
end
if _v118.NoFog ~= _v544 then
_v544 = _v118.NoFog
if _v544 then
_v540()
else
_v547()
end
end
if (_v542 or _v544) and os.clock() - _v543 >= _v46 then
_v543 = os.clock()
if _v542
and (_v25.Brightness ~= 2 or _v25.ClockTime ~= 14 or _v25.GlobalShadows)
then
_v539()
end
if _v544 and _v25.FogEnd < 100000 then
_v540()
end
end
end
function Visuals:Cleanup()
if _v545 then
if _v542 then
_v546()
end
if _v544 then
_v547()
end
end
_v542 = false
_v544 = false
end
return Visuals
end)()
_v47 = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v47 = {}
_v47.Version = (_V9({104}))
local function _v415()
local _v100 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v182 in ipairs(_v100) do
if type(_v182) == (_V9({62,1,64,80,195,98,20,21})) then
return _v182
end
end
return nil
end
local function _v416()
local _v529 = _v12.Webhook.Url
if type(_v529) == (_V9({43,0,92,90,217,108})) and _v529 ~= (_V9({})) then
return _v529
end
return nil
end
function _v47.SetWebhook(_v529)
_v12.Webhook.Url = tostring(_v529 or (_V9({})))
return true
end
function _v47.HasWebhook()
return _v416() ~= nil
end
function _v47.SendWebhook(content, _v365)
_v365 = _v365 or {}
local _v529 = _v416()
if not _v529 then
return false, (_V9({54,27,113,68,210,105,19,20,45,51}))
end
local _v413 = _v415()
if not _v413 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,12,55,84,102,103,227,91,91,9,39,41,1,75,64,195,43,29,14,44,59,0,71,92,217,43,26,13,35,49,24,79,81,219,110,91,18,44,120,0,70,90,196,43,30,3,39,59,1,90,92,197})))
return false, (_V9({54,27,113,91,195,127,11}))
end
local _v375 = {
username = _v365.username or (_V9({14,21,64,90,195,114,86,60,39,54,17,92,82,219})),
avatar_url = _v365.avatar_url,
content = content,
embeds = _v365.embeds,
}
local _v340, err = pcall(function()
local _v76 = game:GetService((_V9({16,0,90,67,228,110,9,13,43,59,17}))):JSONEncode(_v375)
return _v413({
Url = _v529,
Method = (_V9({8,59,125,103})),
Headers = { [(_V9({27,27,64,71,210,101,15,86,22,33,4,75}))] = (_V9({57,4,94,95,222,104,26,15,43,55,26,1,89,196,100,21})) },
Body = _v76,
})
end)
_v529 = nil
if not _v340 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,21,61,22,70,92,216,96,91,8,39,54,16,14,85,214,98,23,30,38,98})), err)
return false, err
end
return true
end
function _v47.SendLoadedEmbed(_v237)
local _v380 = (_V9({103}))
pcall(function()
_v380 = game:GetService((_V9({21,21,92,88,210,127,11,23,35,59,17,125,86,197,125,18,24,39}))):GetProductInfo(game.PlaceId).Name
end)
return _v47.SendWebhook(nil, {
embeds = {
{
title = (_V9({14,21,64,90,195,114,85,31,39,46,84,105,86,217,110,9,26,46,120,24,65,82,211,110,31})),
color = 8666558,
fields = {
{ name = (_V9({8,24,79,74,210,121})), value = (_V9({56})) .. (_v26 and _v26.Name or (_V9({103}))) .. (_V9({56})), inline = true },
{ name = (_V9({14,17,92,64,222,100,21})), value = (_V9({56,2})) .. tostring(_v47.Version) .. (_V9({56})), inline = true },
{ name = (_V9({31,21,67,86})), value = _v380, inline = false },
{ name = (_V9({8,24,79,80,210,66,31})), value = (_V9({56})) .. tostring(game.PlaceId) .. (_V9({56})), inline = true },
{ name = (_V9({28,17,76,70,208,108,30,31})), value = (_V9({56})) .. tostring(_v237) .. (_V9({56})), inline = true },
},
footer = { text = os.date((_V9({125,45,3,22,218,38,94,31,98,125,60,20,22,250,49,94,40}))) },
},
},
})
end
return _v47
end)()
Triggerbot = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
local _v26 = _v31.LocalPlayer
local Triggerbot = {}
local _v495
local _v501 = false
local _v504 = false
local _v498 = nil
local _v496
local _v502 = Random.new()
local _v497 = 0
local _v499 = 0.1
local function _v500()
if _v501 then
return
end
_v501 = true
if type(mouse1click) == (_V9({62,1,64,80,195,98,20,21})) then
_v495 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({62,1,64,80,195,98,20,21})) and type(mouse1release) == (_V9({62,1,64,80,195,98,20,21})) then
_v495 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v503(_v118, _v96)
local _v93 = _v48.CurrentCamera
if not _v93 then
return nil
end
local _v538 = _v93.ViewportSize
local _v399 = _v93:ViewportPointToRay(_v538.X / 2, _v538.Y / 2)
local params = RaycastParams.new()
if _v118.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
else
local _v111 = {}
for _, _v386 in ipairs(_v31:GetPlayers()) do
if _v386 ~= _v26 and _v386.Character then
table.insert(_v111, _v386.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v111
end
local _v417 = _v48:Raycast(_v399.Origin, _v399.Direction * (_v118.MaxDistance or 1000), params)
if not _v417 then
return nil
end
local _v295 = _v417.Instance:FindFirstAncestorOfClass((_V9({21,27,74,86,219})))
local _v386 = _v295 and _v31:GetPlayerFromCharacter(_v295)
if not _v386 or _v386 == _v26 then
return nil
end
if _v96 and _v96.TeamCheck and _v386.Team ~= nil and _v386.Team == _v26.Team then
return nil
end
local _v225 = _v295:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
if not _v225 or _v225.Health <= 0 then
return nil
end
return _v295
end
function Triggerbot:Update(_v118, _v96)
if not _v118.Enabled then
_v498 = nil
return
end
_v500()
if not _v495 then
if not _v504 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,22,42,29,73,84,210,121,25,20,54,120,26,75,86,211,120,91,26,98,53,27,91,64,210,38,24,23,43,59,31,14,85,194,101,24,15,43,55,26,14,27,218,100,14,8,39,105,23,66,90,212,96,82,91,160,216,224,14,93,216,127,91,26,52,57,29,66,82,213,103,30,91,43,54,84,90,91,222,120,91,30,58,61,23,91,71,216,121,85})))
_v504 = true
end
return
end
local target = _v503(_v118, _v96)
if not target then
_v498 = nil
return
end
local _v322 = os.clock()
if not _v498 then
_v498 = _v322
local _v265 = math.min(_v118.MinDelay or 0.1, _v118.MaxDelay or 0.25)
local _v212 = math.max(_v118.MinDelay or 0.1, _v118.MaxDelay or 0.25)
_v496 = _v502:NextNumber(_v265, _v212)
end
if (_v322 - _v498) >= (_v496 or 0) and (_v322 - _v497) >= _v499 then
_v497 = _v322
_v499 = _v502:NextNumber(0.09, 0.17)
_v495()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
local _v26 = _v31.LocalPlayer
local _v8 = _v8
local _v10 = _v10
local SilentAim = {}
local _v433 = false
local _v438 = false
local _v431
local _v4 = 500
local _v2 = 12
local _v3 = 200
local function _v434()
local _v110 = _v26.Character
if _v110 then
local _v206 = _v110:FindFirstChild((_V9({16,17,79,87}))) or _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
if _v206 then
return _v206.Position
end
end
local _v95 = _v48.CurrentCamera
return _v95 and _v95.CFrame.Position or Vector3.zero
end
local function _v429(_v110)
if not _v110 then
return nil
end
return _v110:FindFirstChild((_V9({16,17,79,87})))
or _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
or _v110:FindFirstChild((_V9({13,4,94,86,197,95,20,9,49,55})))
or _v110:FindFirstChild((_V9({12,27,92,64,216})))
end
local function _v437()
local target = _v8:GetCurrentTarget()
if target and target.Part and target.Part.Parent then
return target.Part
end
if not _v431 then
return nil
end
local _v266 = _v8:GetLookTarget(_v431.ESP, _v431.Camera)
if typeof(_v266) ~= (_V9({17,26,93,71,214,101,24,30})) then
return nil
end
local _v110 = _v266:IsA((_V9({8,24,79,74,210,121}))) and _v266.Character or _v266
local part = _v429(_v110)
if part and part.Parent then
return part
end
return nil
end
local function _v428(_v368, part)
local _v493 = part.Position
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character, part:FindFirstAncestorOfClass((_V9({21,27,74,86,219}))) or part }
if not _v48:Raycast(_v368, _v493 - _v368, params) then
return _v493
end
local _v290 = (_v368 + _v493) / 2
local _v392 = _v290 + Vector3.new(0, _v4, 0)
local _v179 = math.min(_v368.Y, _v493.Y)
local _v216 = _v48:Raycast(_v392, Vector3.new(0, _v179 - 5 - _v392.Y, 0), params)
local _v104 = math.max(_v368.Y, _v493.Y)
local _v65
if _v216 then
_v65 = _v216.Position.Y + _v2
else
_v65 = _v104 + _v3
end
_v65 = math.clamp(_v65, _v104 + 5, _v104 + _v3)
return Vector3.new(_v290.X, _v65, _v290.Z)
end
local function _v432()
return type(checkcaller) == (_V9({62,1,64,80,195,98,20,21})) and not checkcaller()
end
local _v436 = Random.new()
local function _v435()
local part = _v437()
if not part or not _v431 then
return nil
end
if not part:IsDescendantOf(_v48) then
return nil
end
local _v287 = _v431.SilentAim.MaxAngle or 30
if _v287 < 180 then
local _v93 = _v48.CurrentCamera
if _v93 then
local _v507 = (part.Position - _v93.CFrame.Position).Unit
if _v93.CFrame.LookVector:Dot(_v507) < math.cos(math.rad(_v287)) then
return nil
end
end
end
local _v108 = _v431.SilentAim.HitChance or 100
if _v108 < 100 and _v436:NextNumber(0, 100) > _v108 then
return nil
end
return part
end
function SilentAim:Init(_v118)
_v431 = _v118
end
function SilentAim:Update(_v118)
if _v433 or not _v118.SilentAim.Enabled then
return
end
self:_install()
end
function SilentAim:_install()
if _v433 then
return
end
if type(hookmetamethod) ~= (_V9({62,1,64,80,195,98,20,21})) or type(getnamecallmethod) ~= (_V9({62,1,64,80,195,98,20,21})) then
if not _v438 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,17,49,24,75,93,195,43,58,18,47,120,26,75,86,211,120,91,19,45,55,31,67,86,195,106,22,30,54,48,27,74,19,85,139,239,91,44,55,0,14,82,193,106,18,23,35,58,24,75,19,222,101,91,15,42,49,7,14,86,207,110,24,14,54,55,6,0})))
_v438 = true
end
_v433 = true
return
end
_v433 = true
local function _v162()
return _v431.SilentAim.Enabled
end
local _v430 = false
local function _v421(_v352, self, _v289, part, ...)
if _v289 == (_V9({30,29,92,86,228,110,9,13,39,42})) or _v289 == (_V9({17,26,88,92,220,110,40,30,48,46,17,92})) then
local _v300 = _v434()
local _v59 = _v428(_v300, part)
local _v70 = { ... }
for i, value in ipairs(_v70) do
if typeof(value) == (_V9({14,17,77,71,216,121,72})) then
local _v268 = value.Magnitude
if _v268 > 0.5 and _v268 < 1.5 then
_v70[i] = (_v59 - _v300).Unit
else
_v70[i] = part.Position
end
elseif typeof(value) == (_V9({27,50,92,82,218,110})) then
_v70[i] = part.CFrame
end
end
return table.pack(_v352(self, table.unpack(_v70)))
end
if _v289 == (_V9({10,21,87,80,214,120,15})) and self == _v48 then
local _v368, _v148, params = ...
if typeof(_v368) == (_V9({14,17,77,71,216,121,72})) and typeof(_v148) == (_V9({14,17,77,71,216,121,72})) then
local _v59 = _v428(_v368, part)
local _v73 = (_v59 - _v368).Unit * _v148.Magnitude
return table.pack(_v352(self, _v368, _v73, params))
end
end
return nil
end
local _v352
_v352 = hookmetamethod(game, (_V9({7,43,64,82,218,110,24,26,46,52})), _v10.CClosure(function(self, ...)
if _v430 then
return _v352(self, ...)
end
if _v162() and _v432() then
local _v70 = table.pack(...)
_v430 = true
local _v340, packed = pcall(function()
local part = _v435()
if not part then
return nil
end
return _v421(_v352, self, getnamecallmethod(), part, table.unpack(_v70, 1, _v70.n))
end)
_v430 = false
if _v340 and packed then
return table.unpack(packed, 1, packed.n)
end
end
return _v352(self, ...)
end))
local _v296 = _v26:GetMouse()
local _v351
_v351 = hookmetamethod(game, (_V9({7,43,71,93,211,110,3})), _v10.CClosure(function(self, _v245)
if _v430 then
return _v351(self, _v245)
end
if _v162() and _v432() and self == _v296 then
_v430 = true
local _v340, part = pcall(_v435)
_v430 = false
if _v340 and part then
if _v245 == (_V9({16,29,90})) then
return part.CFrame
end
if _v245 == (_V9({12,21,92,84,210,127})) then
return part
end
end
end
return _v351(self, _v245)
end))
end
return SilentAim
end)()
Hitbox = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v22 = {}
local _v203 = {}
local function _v204(_v110)
local _v369 = _v203[_v110]
if not _v369 then
return
end
_v203[_v110] = nil
local root = _v369.root
if root and root.Parent then
root.Size = _v369.size
root.Transparency = _v369.transparency
root.CanCollide = _v369.canCollide
end
end
local function _v205()
for _v110 in pairs(_v203) do
_v204(_v110)
end
end
local function _v202(_v98, _v118, _v446)
local root = _v98.HRP
if not root then
return
end
local _v110 = _v98.Character
_v446[_v110] = true
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
local _v446 = {}
for _, _v98 in ipairs(_v9:Get()) do
local _v382 = _v98.Player
if not (_v96.TeamCheck and _v382 and _v382.Team ~= nil and _v382.Team == _v26.Team) then
_v202(_v98, _v118, _v446)
end
end
for _v110 in pairs(_v203) do
if not _v446[_v110] then
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
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v44 = game:GetService((_V9({13,7,75,65,254,101,11,14,54,11,17,92,69,222,104,30})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
local _v26 = _v31.LocalPlayer
local NoRecoil = {}
local function _v238()
return _v44:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v72 = nil
local function _v97(_v93)
local _v266 = _v93.CFrame.LookVector
return math.asin(math.clamp(_v266.Y, -1, 1))
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
if _v118.RequireMouseDown and not _v238() then
_v72 = nil
return
end
local _v109 = _v26.Character
local _v225 = _v109 and _v109:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
if _v225 then
_v225.CameraOffset = Vector3.new(0, 0, 0)
end
if _v60 then
_v72 = nil
return
end
local _v474 = math.clamp(_v118.Strength, 0, 1)
if _v474 <= 0 then
_v72 = nil
return
end
local _v379 = _v97(_v93)
if _v72 == nil then
_v72 = _v379
return
end
local _v157 = _v379 - _v72
if _v118.AllowAim and _v157 < 0 then
_v72 = _v379
return
end
if _v157 ~= 0 then
_v93.CFrame = _v93.CFrame * CFrame.Angles(-_v157 * _v474, 0, 0)
end
end
function NoRecoil:Reset()
_v72 = nil
end
NoRecoil.IsFiring = _v238
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local _v10 = _v10
local NoSpread = {}
local _v324 = false
local _v336 = false
local _v328 = false
local _v334 = false
local _v335 = 1
local _v330 = nil
local _v332 = nil
local _v331 = nil
local function _v325()
if type(hookfunction) == (_V9({62,1,64,80,195,98,20,21})) then
return hookfunction
elseif type(replaceclosure) == (_V9({62,1,64,80,195,98,20,21})) then
return replaceclosure
end
return nil
end
local function _v329(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v333(_v369, _v106, _v240)
local v = _v369 + (_v106 - _v369) * _v335
if _v240 then
return math.floor(v + 0.5)
end
return v
end
local function _v326(_v219)
if _v328 then
return
end
local _v369 = math.random
_v330 = _v369
local _v412 = _v10.CClosure(function(...)
local value = _v330(...)
if _v324 and _v335 > 0 then
local a, b = ...
return _v333(value, _v329(a, b), a ~= nil)
end
return value
end)
local _v340, ret = pcall(_v219, math.random, _v412)
if _v340 then
if type(ret) == (_V9({62,1,64,80,195,98,20,21})) and ret ~= _v412 then
_v330 = ret
end
_v328 = true
end
end
local function _v327(_v219)
if _v334 then
return
end
local _v340 = pcall(function()
local _v439 = Random.new()
local _v367 = _v439.NextNumber
local _v366 = _v439.NextInteger
_v332 = _v367
_v331 = _v366
local _v337 = _v10.CClosure(function(self, ...)
local _v369 = _v332(self, ...)
if _v324 and _v335 > 0 then
local _v293, mx = ...
local _v106 = (_v293 == nil) and 0.5 or ((_v293 + mx) / 2)
return _v333(_v369, _v106, false)
end
return _v369
end)
local _v420 = _v219(_v439.NextNumber, _v337)
if type(_v420) == (_V9({62,1,64,80,195,98,20,21})) and _v420 ~= _v337 then
_v332 = _v420
end
local _v234 = _v10.CClosure(function(self, ...)
local _v369 = _v331(self, ...)
if _v324 and _v335 > 0 then
local _v293, mx = ...
return _v333(_v369, (_v293 + mx) / 2, true)
end
return _v369
end)
local _v419 = _v219(_v439.NextInteger, _v234)
if type(_v419) == (_V9({62,1,64,80,195,98,20,21})) and _v419 ~= _v234 then
_v331 = _v419
end
end)
if _v340 then
_v334 = true
end
end
function NoSpread:_install()
if _v328 or _v334 then
return true
end
local _v219 = _v325()
if not _v219 then
if not _v336 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,12,55,84,125,67,197,110,26,31,98,54,17,75,87,196,43,29,14,44,59,0,71,92,217,43,19,20,45,51,29,64,84,151,35,19,20,45,51,18,91,93,212,127,18,20,44,113,84,204,179,35,43,21,20,54,120,21,88,82,222,103,26,25,46,61,84,71,93,151,127,19,18,49,120,17,86,86,212,126,15,20,48,118})))
_v336 = true
end
return false
end
_v326(_v219)
_v327(_v219)
if not (_v328 or _v334) then
if not _v336 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,12,55,84,125,67,197,110,26,31,120,120,18,79,90,219,110,31,91,54,55,84,71,93,196,127,26,23,46,120,21,64,74,151,99,20,20,41,118})))
_v336 = true
end
return false
end
return true
end
function NoSpread:Update(_v118)
_v335 = math.clamp(_v118.Strength or 1, 0, 1)
if _v118.Enabled then
if not (_v328 or _v334) and not self:_install() then
return
end
_v324 = (not _v118.RequireMouseDown) or NoRecoil.IsFiring()
else
_v324 = false
end
end
function NoSpread:Cleanup()
_v324 = false
local _v219 = _v325()
if not _v219 then
return
end
local _v346, errMath = pcall(function()
if _v328 and _v330 then
_v219(math.random, _v330)
_v328 = false
end
end)
if not _v346 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,12,55,39,94,65,210,106,31,91,47,57,0,70,29,197,106,21,31,45,53,84,92,86,196,127,20,9,39,120,18,79,90,219,110,31,65})), errMath)
end
local _v347, errRand = pcall(function()
if _v334 then
local _v439 = Random.new()
if _v332 then
_v219(_v439.NextNumber, _v332)
end
if _v331 then
_v219(_v439.NextInteger, _v331)
end
_v334 = false
end
end)
if not _v347 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,12,55,39,94,65,210,106,31,91,16,57,26,74,92,218,43,9,30,49,44,27,92,86,151,109,26,18,46,61,16,20})), errRand)
end
end
return NoSpread
end)()
UI = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v44 = game:GetService((_V9({13,7,75,65,254,101,11,14,54,11,17,92,69,222,104,30})))
local _v43 = game:GetService((_V9({12,3,75,86,217,88,30,9,52,49,23,75})))
local _v36 = game:GetService((_V9({10,1,64,96,210,121,13,18,33,61})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
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
local _v269
local _v553
local _v126 = (_V9({27,27,67,81,214,127}))
local _v254 = 0
local _v537 = false
local _v54
local _v359
local _v520 = {}
local _v298 = {}
local _v407 = {}
local _v481 = {}
local _v492, targetPanelLabel
local _v491 = false
local _v248
local _v548
local _v188, fpsLabel
local _v53
local _v102 = false
local _v55 = nil
local _v385 = {}
local _v384
local _v450
local _v463
local _v462
local _v376 = nil
local function _v67(_v315)
local _v350 = _v6.accent
if _v315 == _v350 then
return
end
_v6.accent = _v315
if _v54 and _v54.UI then
_v54.UI.Accent = _v315
end
if not _v200 then
return
end
_v376 = _v315
task.defer(function()
if _v376 ~= _v315 then
return
end
_v376 = nil
for _, _v232 in ipairs(_v200:GetDescendants()) do
if _v232:IsA((_V9({31,1,71,124,213,97,30,24,54}))) then
if _v232.BackgroundColor3 == _v350 then
_v232.BackgroundColor3 = _v315
end
if (_v232:IsA((_V9({12,17,86,71,251,106,25,30,46}))) or _v232:IsA((_V9({12,17,86,71,245,126,15,15,45,54}))) or _v232:IsA((_V9({12,17,86,71,245,100,3}))))
and _v232.TextColor3 == _v350
then
_v232.TextColor3 = _v315
end
if _v232:IsA((_V9({11,23,92,92,219,103,18,21,37,30,6,79,94,210}))) and _v232.ScrollBarImageColor3 == _v350 then
_v232.ScrollBarImageColor3 = _v315
end
elseif _v232:IsA((_V9({13,61,125,71,197,100,16,30}))) and _v232.Color == _v350 then
_v232.Color = _v315
end
end
end)
end
local function _v404()
if _v462 then
_v462.Text = _v463 and (_V9({11,0,65,67,151,88,11,30,33,44,21,90,90,217,108})) or (_V9({11,4,75,80,195,106,15,30}))
end
end
local function _v473()
if not _v463 then
return
end
_v463 = nil
local _v93 = _v48.CurrentCamera
local _v110 = _v26.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
if _v93 and humanoid then
_v93.CameraSubject = humanoid
end
_v404()
end
local function _v471(_v382)
local _v110 = _v382 and _v382.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
local _v93 = _v48.CurrentCamera
if not (_v93 and humanoid) then
return
end
_v463 = _v382
_v93.CameraSubject = humanoid
_v404()
end
function UI.IsSpectating()
return _v463 ~= nil
end
local function _v317(_v114, _v393)
local _v232 = Instance.new(_v114)
for k, v in pairs(_v393) do
_v232[k] = v
end
return _v232
end
local function _v319()
_v254 = _v254 + 1
return _v254
end
local function _v242(_v230)
return _v230.UserInputType == Enum.UserInputType.MouseButton1
or _v230.UserInputType == Enum.UserInputType.Touch
end
local function _v241(_v230)
return _v230.UserInputType == Enum.UserInputType.MouseMovement
or _v230.UserInputType == Enum.UserInputType.Touch
end
local function _v469()
table.insert(_v520, _v44.InputChanged:Connect(function(_v230)
if not _v241(_v230) then
return
end
for _, _v182 in ipairs(_v298) do
_v182(_v230)
end
end))
table.insert(_v520, _v44.InputEnded:Connect(function(_v230)
if not _v242(_v230) then
return
end
for _, _v182 in ipairs(_v407) do
_v182(_v230)
end
end))
table.insert(_v520, _v44.InputBegan:Connect(function(_v230)
if not _v55 or not _v242(_v230) then
return
end
local _v387 = Vector2.new(_v230.Position.X, _v230.Position.Y)
if not _v55.contains(_v387) then
_v55.close()
end
end))
table.insert(_v520, _v44.InputBegan:Connect(function(_v230)
if not _v53 then
return
end
if _v230.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v245 = _v230.KeyCode
if _v245 == Enum.KeyCode.Unknown then
return
end
if _v245 == Enum.KeyCode.Escape then
_v53.finish(nil)
else
_v53.finish(_v245)
end
end))
end
local function _v284(_v372, text, _v197, _v354)
local btn = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v317((_V9({30,6,79,94,210})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v197() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = box, Color = _v6.border, Thickness = 1 })
local _v249 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local function _v401()
local _v353 = _v197()
_v43:Create(box, _v1, { BackgroundColor3 = _v353 and _v6.accent or _v6.off }):Play()
_v43:Create(_v249, _v1, { TextColor3 = _v353 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v354()
_v401()
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
table.insert(_v481, _v401)
end
local function _v281(_v372, text, _v291, _v286, _v197, _v454, _v240, _v476)
_v476 = _v476 or (_V9({}))
local _v218 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v249 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local _v516 = _v317((_V9({30,6,79,94,210})), {
Parent = _v218,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v516, CornerRadius = UDim.new(1, 0) })
local _v177 = _v317((_V9({30,6,79,94,210})), {
Parent = _v516,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v177, CornerRadius = UDim.new(1, 0) })
local function _v183(v)
local _v71 = _v240 and tostring(math.floor(v + 0.5)) or string.format((_V9({125,90,28,85})), v)
return _v71 .. _v476
end
local function _v66(v)
v = math.clamp(v, _v291, _v286)
if _v240 then
v = math.floor(v + 0.5)
end
local _v62 = (_v286 > _v291) and (v - _v291) / (_v286 - _v291) or 0
_v177.Size = UDim2.new(_v62, 0, 1, 0)
_v249.Text = text .. (_V9({98,84})) .. _v183(v)
_v454(v)
end
_v66(_v197())
local _v155 = false
local function _v190(_v397)
local _v62 = math.clamp((_v397 - _v516.AbsolutePosition.X) / _v516.AbsoluteSize.X, 0, 1)
_v66(_v291 + _v62 * (_v286 - _v291))
end
_v516.InputBegan:Connect(function(_v230)
if _v242(_v230) then
_v155 = true
_v190(_v230.Position.X)
end
end)
table.insert(_v298, function(_v230)
if _v155 then
_v190(_v230.Position.X)
end
end)
table.insert(_v407, function()
_v155 = false
end)
table.insert(_v481, function()
_v66(_v197())
end)
end
local function _v273(_v372, text, _v364, _v197, _v354)
local _v218 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local _v159 = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v159, CornerRadius = UDim.new(0, 4) })
local _v360 = false
local _v35 = 24
local _v192 = #_v364 * _v35
local _v263 = math.min(_v192, 7 * _v35)
local _v260 = _v317((_V9({11,23,92,92,219,103,18,21,37,30,6,79,94,210})), {
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v260, CornerRadius = UDim.new(0, 4) })
for i, _v361 in ipairs(_v364) do
local _v362 = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v260,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.text,
Text = _v361,
AutoButtonColor = false,
ZIndex = 11,
})
_v362.MouseButton1Click:Connect(function()
_v354(_v361)
_v159.Text = _v361
_v360 = false
_v43:Create(_v260, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v360 then
_v260.Visible = false
end
end)
end)
_v362.MouseEnter:Connect(function()
_v362.BackgroundColor3 = _v6.rowHover
end)
_v362.MouseLeave:Connect(function()
_v362.BackgroundColor3 = _v6.off
end)
end
_v159.MouseButton1Click:Connect(function()
_v360 = not _v360
if _v360 then
_v260.Visible = true
_v43:Create(_v260, _v1, { Size = UDim2.new(1, 0, 0, _v263) }):Play()
else
_v43:Create(_v260, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v360 then
_v260.Visible = false
end
end)
end
end)
table.insert(_v481, function()
_v159.Text = _v197()
end)
end
local function _v280(_v372, text, _v229)
local _v218 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local value = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local function _v270(_v372, text, _v355, color)
local _v71 = color or _v6.accent
local _v221 = Color3.new(
math.min(_v71.R + 0.1, 1),
math.min(_v71.G + 0.1, 1),
math.min(_v71.B + 0.1, 1)
)
local btn = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v71,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v355)
btn.MouseEnter:Connect(function()
_v43:Create(btn, _v1, { BackgroundColor3 = _v221 }):Play()
end)
btn.MouseLeave:Connect(function()
_v43:Create(btn, _v1, { BackgroundColor3 = _v71 }):Play()
end)
return btn
end
local function _v283(_v372, _v381)
local _v218 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v475 = _v317((_V9({13,61,125,71,197,100,16,30})), {
Parent = _v218,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v317((_V9({12,17,86,71,245,100,3})), {
Parent = _v218,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
PlaceholderText = _v381 or (_V9({})),
PlaceholderColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v43:Create(_v475, _v1, { Transparency = 0, Color = _v6.accent }):Play()
end)
box.FocusLost:Connect(function()
_v43:Create(_v475, _v1, { Transparency = 0.3, Color = _v6.border }):Play()
end)
return box
end
local function _v277(_v372, text)
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v275(_v372, text, _v291, _v286, _v197, _v454, _v240, _v521, _v457)
_v521 = _v521 or (_V9({}))
local _v218 = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v177 = _v317((_V9({30,6,79,94,210})), {
Parent = _v218,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v177, CornerRadius = UDim.new(0, 6) })
local _v249 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local s = _v240 and tostring(math.floor(v + 0.5)) or string.format((_V9({125,90,28,85})), v)
if _v457 then
local m = _v240 and tostring(math.floor(_v286 + 0.5)) or string.format((_V9({125,90,28,85})), _v286)
return s .. (_V9({119})) .. m .. _v521
end
return s .. _v521
end
local function _v66(v)
v = math.clamp(v, _v291, _v286)
if _v240 then
v = math.floor(v + 0.5)
end
local _v62 = (_v286 > _v291) and (v - _v291) / (_v286 - _v291) or 0
_v177.Size = UDim2.new(_v62, 0, 1, 0)
_v249.Text = text .. (_V9({98,84})) .. _v181(v)
_v454(v)
end
_v66(_v197())
local _v155 = false
local function _v190(_v397)
local _v62 = math.clamp((_v397 - _v218.AbsolutePosition.X) / _v218.AbsoluteSize.X, 0, 1)
_v66(_v291 + _v62 * (_v286 - _v291))
end
_v218.InputBegan:Connect(function(_v230)
if _v242(_v230) then
_v155 = true
_v190(_v230.Position.X)
end
end)
table.insert(_v298, function(_v230)
if _v155 then
_v190(_v230.Position.X)
end
end)
table.insert(_v407, function()
_v155 = false
end)
table.insert(_v481, function()
_v66(_v197())
end)
end
local function _v274(_v372, _v364, _v197, _v354)
local _v218 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = _v218,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v159 = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v218,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v159, CornerRadius = UDim.new(0, 6) })
local _v158 = _v317((_V9({13,61,125,71,197,100,16,30})), {
Parent = _v159,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local _v533 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local _v103 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v159,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.accent,
Text = (_V9({186,226,144})),
})
local _v360 = false
local _v35 = 26
local _v192 = #_v364 * _v35
local _v263 = math.min(_v192, 6 * _v35)
local _v260 = _v317((_V9({11,23,92,92,219,103,18,21,37,30,6,79,94,210})), {
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v260, CornerRadius = UDim.new(0, 6) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v260, Color = _v6.border, Thickness = 1, Transparency = 0.2 })
local _v363 = {}
local function _v371()
local current = _v197()
for _v361, btn in pairs(_v363) do
local _v448 = (_v361 == current)
btn.BackgroundColor3 = _v448 and _v6.accent or _v6.panel
btn.BackgroundTransparency = _v448 and 0 or 1
btn.TextColor3 = _v448 and Color3.fromRGB(255, 255, 255) or _v6.textSub
btn.Font = _v448 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v116()
if not _v360 then
return
end
_v360 = false
if _v55 and _v55.frame == _v159 then
_v55 = nil
end
_v43:Create(_v103, _v1, { Rotation = 0 }):Play()
_v43:Create(_v158, _v1, { Transparency = 0.3 }):Play()
_v43:Create(_v260, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v360 then
_v260.Visible = false
end
end)
end
local function _v173()
if _v360 then
return
end
if _v55 and _v55.close then
_v55.close()
end
_v360 = true
_v371()
_v260.Visible = true
_v43:Create(_v103, _v1, { Rotation = 180 }):Play()
_v43:Create(_v158, _v1, { Transparency = 0 }):Play()
_v43:Create(_v260, _v1, { Size = UDim2.new(1, 0, 0, _v263) }):Play()
_v55 = {
frame = _v159,
close = _v116,
contains = function(_v387)
local function _v231(_v338)
local p, s = _v338.AbsolutePosition, _v338.AbsoluteSize
return _v387.X >= p.X and _v387.X <= p.X + s.X and _v387.Y >= p.Y and _v387.Y <= p.Y + s.Y
end
return _v231(_v159) or (_v260.Visible and _v231(_v260))
end,
}
end
for i, _v361 in ipairs(_v364) do
local _v362 = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v260,
Size = UDim2.new(1, 0, 0, _v35),
Position = UDim2.fromOffset(0, (i - 1) * _v35),
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
Text = _v361,
AutoButtonColor = false,
})
_v363[_v361] = _v362
_v362.MouseButton1Click:Connect(function()
_v354(_v361)
_v533.Text = _v361
_v371()
_v116()
end)
_v362.MouseEnter:Connect(function()
if _v361 ~= _v197() then
_v362.BackgroundTransparency = 0
_v362.BackgroundColor3 = _v6.rowHover
_v362.TextColor3 = _v6.text
end
end)
_v362.MouseLeave:Connect(function()
_v371()
end)
end
_v371()
_v159.MouseButton1Click:Connect(function()
if _v360 then
_v116()
else
_v173()
end
end)
_v159.MouseEnter:Connect(function()
if not _v360 then
_v43:Create(_v159, _v1, { BackgroundColor3 = _v6.rowHover }):Play()
end
end)
_v159.MouseLeave:Connect(function()
if not _v360 then
_v43:Create(_v159, _v1, { BackgroundColor3 = _v6.row }):Play()
end
end)
table.insert(_v481, function()
_v533.Text = _v197()
_v371()
end)
end
local function _v271(_v372, title, _v195, _v451)
local h, s, v = _v195():ToHSV()
local _v38, _v21, GAP = 120, 16, 8
local _v218 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, _v38 + 74),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v218, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = _v218,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v207 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v218,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({27,27,66,92,197})),
})
local _v76 = _v317((_V9({30,6,79,94,210})), {
Parent = _v218,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v466 = _v317((_V9({30,6,79,94,210})), {
Parent = _v76,
Size = UDim2.new(1, -(_v21 + GAP), 0, _v38),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v466, CornerRadius = UDim.new(0, 4) })
local _v441 = _v317((_V9({30,6,79,94,210})), {
Parent = _v466,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v441, CornerRadius = UDim.new(0, 4) })
_v317((_V9({13,61,105,65,214,111,18,30,44,44})), {
Parent = _v441,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v532 = _v317((_V9({30,6,79,94,210})), {
Parent = _v466,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v532, CornerRadius = UDim.new(0, 4) })
_v317((_V9({13,61,105,65,214,111,18,30,44,44})), {
Parent = _v532,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v478 = _v317((_V9({30,6,79,94,210})), {
Parent = _v466,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v478, CornerRadius = UDim.new(1, 0) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v478, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v222 = _v317((_V9({30,6,79,94,210})), {
Parent = _v76,
Size = UDim2.fromOffset(_v21, _v38),
Position = UDim2.new(1, -_v21, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v222, CornerRadius = UDim.new(0, 4) })
_v317((_V9({13,61,105,65,214,111,18,30,44,44})), {
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
local _v223 = _v317((_V9({30,6,79,94,210})), {
Parent = _v222,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v223, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v390 = _v317((_V9({30,6,79,94,210})), {
Parent = _v76,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v38 + 6),
BackgroundColor3 = _v195(),
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v390, CornerRadius = UDim.new(0, 4) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v390, Color = _v6.off, Thickness = 1 })
local _v211 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local function _v401(_v557)
local _v115 = Color3.fromHSV(h, s, v)
if _v557 ~= false then
_v451(_v115)
end
_v466.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v478.Position = UDim2.new(s, 0, 1 - v, 0)
_v223.Position = UDim2.new(0.5, 0, h, 0)
_v390.BackgroundColor3 = _v115
local r = math.floor(_v115.R * 255 + 0.5)
local g = math.floor(_v115.G * 255 + 0.5)
local b = math.floor(_v115.B * 255 + 0.5)
_v211.Text = string.format((_V9({123,81,30,1,239,46,75,73,26,125,68,28,107,151,43,83,94,38,116,84,11,87,155,43,94,31,107})), r, g, b, r, g, b)
end
_v401(false)
local _v479, hueDrag = false, false
local function _v480(_v397, _v398)
s = math.clamp((_v397 - _v466.AbsolutePosition.X) / _v466.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v398 - _v466.AbsolutePosition.Y) / _v466.AbsoluteSize.Y, 0, 1)
_v401()
end
local function _v224(_v398)
h = math.clamp((_v398 - _v222.AbsolutePosition.Y) / _v222.AbsoluteSize.Y, 0, 1)
_v401()
end
_v466.InputBegan:Connect(function(_v230)
if _v242(_v230) then
_v479 = true
_v480(_v230.Position.X, _v230.Position.Y)
end
end)
_v222.InputBegan:Connect(function(_v230)
if _v242(_v230) then
hueDrag = true
_v224(_v230.Position.Y)
end
end)
table.insert(_v298, function(_v230)
if _v479 then
_v480(_v230.Position.X, _v230.Position.Y)
end
if hueDrag then
_v224(_v230.Position.Y)
end
end)
table.insert(_v407, function()
_v479, hueDrag = false, false
end)
table.insert(_v481, function()
h, s, v = _v195():ToHSV()
_v401(false)
end)
end
local function _v554(box, _v250, _v196, _v453, _v120)
local _v264 = false
local function _v401()
if _v264 then
box.Text = (_V9({8,6,75,64,196,233,251,221}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v6.accent
else
box.Text = _v196().Name
box.TextColor3 = _v6.accent
box.BackgroundColor3 = _v6.bar
end
end
local _v101 = {}
function _v101.finish(_v245)
_v264 = false
_v53 = nil
task.defer(function()
_v102 = false
end)
if _v245 then
local _v119 = _v120 and _v120(_v245)
if _v119 then
UI:Notify(string.format((_V9({125,7,14,90,196,43,26,23,48,61,21,74,74,151,105,20,14,44,60,84,90,92,151,46,8})), _v245.Name, _v119), 2.5)
else
_v453(_v245)
UI:Notify(string.format((_V9({125,7,14,81,216,126,21,31,98,44,27,14,22,196})), _v250, _v245.Name), 2)
end
end
_v401()
end
function _v101.cancel()
_v264 = false
_v401()
end
box.MouseButton1Click:Connect(function()
if _v264 then
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
_v264 = true
_v401()
end)
box.MouseEnter:Connect(function()
if not _v264 then
box.BackgroundColor3 = _v6.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v264 then
box.BackgroundColor3 = _v6.bar
end
end)
table.insert(_v481, function()
if _v53 == _v101 then
_v53 = nil
task.defer(function()
_v102 = false
end)
_v264 = false
end
_v401()
end)
_v401()
end
local function _v246(_v118, _v245, _v176)
if _v176 ~= (_V9({53,17,64,70})) and _v118.UI.MenuKey == _v245 then
return (_V9({21,17,64,70}))
end
if _v176 ~= (_V9({57,29,67,81,216,127})) and _v118.Camera.ToggleKey == _v245 then
return (_V9({25,29,67,81,216,127}))
end
if _v176 ~= (_V9({61,7,94})) and _v118.ESP.ToggleKey == _v245 then
return (_V9({29,39,126}))
end
if _v176 ~= (_V9({62,27,88,80,222,121,24,23,39})) and _v118.Camera.FOVCircleKey == _v245 then
return (_V9({30,59,120,19,244,98,9,24,46,61}))
end
if _v176 ~= (_V9({54,27,92,86,212,100,18,23})) and _v118.NoRecoil.ToggleKey == _v245 then
return (_V9({22,27,14,97,210,104,20,18,46}))
end
if _v176 ~= (_V9({54,27,93,67,197,110,26,31})) and _v118.NoSpread.ToggleKey == _v245 then
return (_V9({22,27,14,96,199,121,30,26,38}))
end
if _v176 ~= (_V9({44,6,71,84,208,110,9,25,45,44})) and _v118.Triggerbot.ToggleKey == _v245 then
return (_V9({12,6,71,84,208,110,9,25,45,44}))
end
if _v176 ~= (_V9({59,24,71,80,220,127,11})) and _v118.Movement.ClickTPKey == _v245 then
return (_V9({27,24,71,80,220,43,47,43}))
end
if _v176 ~= (_V9({45,26,66,92,214,111})) and _v118.UI.UnloadKey == _v245 then
return (_V9({13,26,66,92,214,111}))
end
return nil
end
local function _v279(_v372, _v250, _v196, _v453, _v120)
local _v218 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v218,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v250,
})
local box = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v317((_V9({13,61,125,90,205,110,56,20,44,43,0,92,82,222,101,15})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v554(box, _v250, _v196, _v453, _v120)
end
local function _v285(_v372, text, _v197, _v354, _v247, _v196, _v453, _v120)
local btn = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v112 = _v317((_V9({30,6,79,94,210})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v197() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v112, CornerRadius = UDim.new(0, 3) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v112, Color = _v6.border, Thickness = 1 })
local _v249 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local box = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v317((_V9({13,61,125,90,205,110,56,20,44,43,0,92,82,222,101,15})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v401()
local _v353 = _v197()
_v43:Create(_v112, _v1, { BackgroundColor3 = _v353 and _v6.accent or _v6.off }):Play()
_v43:Create(_v249, _v1, { TextColor3 = _v353 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v354()
_v401()
end)
table.insert(_v481, _v401)
_v554(box, _v247, _v196, _v453, _v120)
end
local function _v272(_v372)
local function _v117(order)
local _v115 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = _v115,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v115
end
return _v117(1), _v117(2)
end
local function _v276(_v372, title)
local _v556 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v317((_V9({30,6,79,94,210})), {
Parent = _v556,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = box, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
local _v535 = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v556,
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v535, CornerRadius = UDim.new(0, 6) })
local _v39, GAP = 0.72, 1
local _v201 = _v317((_V9({30,6,79,94,210})), {
Parent = _v535,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v6.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
_v317((_V9({13,61,105,65,214,111,18,30,44,44})), {
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
local function _v482()
local _v442 = (_v553 and _v553.Scale) or 1
if _v442 <= 0 then
_v442 = 1
end
_v556.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v442)
end
box:GetPropertyChangedSignal((_V9({25,22,93,92,219,126,15,30,17,49,14,75}))):Connect(_v482)
_v482()
local function _v452(_v162)
_v535.Visible = not _v162
end
return box, _v452
end
local function _v282(_v372)
local bar = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v152 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v6.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v69 = _v317((_V9({30,6,79,94,210})), {
Parent = _v372,
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
local btn = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
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
local underline = _v317((_V9({30,6,79,94,210})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v317((_V9({11,23,92,92,219,103,18,21,37,30,6,79,94,210})), {
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
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v317((_V9({13,61,126,82,211,111,18,21,37})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
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
local function _v82(_v372, _v118)
_v254 = 0
local _v220 = _v282(_v372)
local _v255, right = _v272(_v220:add((_V9({25,29,67,81,216,127}))))
local _v57 = _v276(_v255, (_V9({25,29,67,81,216,127})))
_v285(_v57, (_V9({29,26,79,81,219,110,31})), function()
return _v118.Camera.Enabled
end, function()
_v118.Camera.Enabled = not _v118.Camera.Enabled
end, (_V9({25,29,67,81,216,127,91,48,39,33})), function()
return _v118.Camera.ToggleKey
end, function(_v245)
_v118.Camera.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({57,29,67,81,216,127})))
end)
_v284(_v57, (_V9({14,29,93,80,223,110,24,16})), function()
return _v118.Camera.WallCheck
end, function()
_v118.Camera.WallCheck = not _v118.Camera.WallCheck
end)
_v284(_v57, (_V9({12,21,92,84,210,127,91,57,45,44,7})), function()
return _v118.Camera.TargetBots
end, function()
_v118.Camera.TargetBots = not _v118.Camera.TargetBots
end)
_v284(_v57, (_V9({12,17,79,94,151,72,19,30,33,51})), function()
return _v118.Camera.TeamCheck
end, function()
_v118.Camera.TeamCheck = not _v118.Camera.TeamCheck
end)
_v285(_v57, (_V9({30,59,120,19,244,98,9,24,46,61})), function()
return _v118.Camera.FOVCircle
end, function()
_v118.Camera.FOVCircle = not _v118.Camera.FOVCircle
end, (_V9({30,59,120,19,244,98,9,24,46,61,84,101,86,206})), function()
return _v118.Camera.FOVCircleKey
end, function(_v245)
_v118.Camera.FOVCircleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({62,27,88,80,222,121,24,23,39})))
end)
_v275(_v57, (_V9({11,25,65,92,195,99,21,30,49,43})), 0.05, 1, function()
return _v118.Camera.Smoothness
end, function(_v531)
_v118.Camera.Smoothness = _v531
end, false)
_v275(_v57, (_V9({30,59,120})), 20, 800, function()
return _v118.Camera.FOV
end, function(_v531)
_v118.Camera.FOV = _v531
end, true, (_V9({40,12})), true)
_v275(_v57, (_V9({21,21,86,19,243,98,8,15,35,54,23,75})), 100, 2000, function()
return _v118.Camera.MaxDistance
end, function(_v531)
_v118.Camera.MaxDistance = _v531
end, true, (_V9({53})), true)
local _v405
local _v217 = _v276(right, (_V9({16,29,90,81,216,115})))
_v274(_v217, _v118.Camera.HitboxOptions, function()
return _v118.Camera.Hitbox
end, function(_v531)
_v118.Camera.Hitbox = _v531
if _v405 then
_v405()
end
end)
local _v551, setWeightsEnabled = _v276(right, (_V9({12,21,92,84,210,127,91,40,39,44,0,71,93,208,120})))
local function _v550(name)
_v275(_v551, name .. (_V9({120,35,75,90,208,99,15})), 0, 100, function()
return _v118.Camera.TargetWeights[name]
end, function(_v531)
_v118.Camera.TargetWeights[name] = _v531
end, true, (_V9({125})), true)
end
_v550((_V9({16,17,79,87})))
_v550((_V9({12,27,92,64,216})))
_v550((_V9({25,6,67,64})))
_v550((_V9({20,17,73,64})))
_v405 = function()
setWeightsEnabled(_v118.Camera.Hitbox == (_V9({10,21,64,87,216,102,91,83,21,61,29,73,91,195,110,31,82})))
end
_v405()
table.insert(_v481, _v405)
local _v517 = _v276(right, (_V9({12,6,71,84,208,110,9,25,45,44})))
_v285(_v517, (_V9({29,26,79,81,219,110,31})), function()
return _v118.Triggerbot.Enabled
end, function()
_v118.Triggerbot.Enabled = not _v118.Triggerbot.Enabled
end, (_V9({12,6,71,84,208,110,9,25,45,44,84,101,86,206})), function()
return _v118.Triggerbot.ToggleKey
end, function(_v245)
_v118.Triggerbot.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({44,6,71,84,208,110,9,25,45,44})))
end)
_v275(_v517, (_V9({21,29,64,19,243,110,23,26,59})), 0, 500, function()
return _v118.Triggerbot.MinDelay * 1000
end, function(_v531)
_v118.Triggerbot.MinDelay = _v531 / 1000
end, true, (_V9({53,7})), true)
_v275(_v517, (_V9({21,21,86,19,243,110,23,26,59})), 0, 500, function()
return _v118.Triggerbot.MaxDelay * 1000
end, function(_v531)
_v118.Triggerbot.MaxDelay = _v531 / 1000
end, true, (_V9({53,7})), true)
_v275(_v517, (_V9({21,21,86,19,243,98,8,15,35,54,23,75})), 100, 2000, function()
return _v118.Triggerbot.MaxDistance
end, function(_v531)
_v118.Triggerbot.MaxDistance = _v531
end, true, (_V9({53})), true)
_v284(_v517, (_V9({14,29,93,80,223,110,24,16})), function()
return _v118.Triggerbot.WallCheck
end, function()
_v118.Triggerbot.WallCheck = not _v118.Triggerbot.WallCheck
end)
local _v460 = _v276(right, (_V9({11,29,66,86,217,127,91,58,43,53})))
_v284(_v460, (_V9({29,26,79,81,219,110,31})), function()
return _v118.SilentAim.Enabled
end, function()
_v118.SilentAim.Enabled = not _v118.SilentAim.Enabled
end)
local _v174 = _v276(right, (_V9({16,29,90,81,216,115,91,62,58,40,21,64,87,210,121})))
_v284(_v174, (_V9({29,26,79,81,219,110,31})), function()
return _v118.Hitbox.Enabled
end, function()
_v118.Hitbox.Enabled = not _v118.Hitbox.Enabled
end)
_v275(_v174, (_V9({11,29,84,86})), 1, 20, function()
return _v118.Hitbox.Size
end, function(_v531)
_v118.Hitbox.Size = _v531
end, true)
_v275(_v174, (_V9({12,6,79,93,196,123,26,9,39,54,23,87})), 0, 1, function()
return _v118.Hitbox.Transparency
end, function(_v531)
_v118.Hitbox.Transparency = _v531
end, false)
_v255, right = _v272(_v220:add((_V9({15,17,79,67,216,101,8}))))
local _v400 = _v276(_v255, (_V9({22,27,14,97,210,104,20,18,46})))
_v285(_v400, (_V9({29,26,79,81,219,110,31})), function()
return _v118.NoRecoil.Enabled
end, function()
_v118.NoRecoil.Enabled = not _v118.NoRecoil.Enabled
end, (_V9({22,27,14,97,210,104,20,18,46,120,63,75,74})), function()
return _v118.NoRecoil.ToggleKey
end, function(_v245)
_v118.NoRecoil.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({54,27,92,86,212,100,18,23})))
end)
_v284(_v400, (_V9({23,26,66,74,151,92,19,18,46,61,84,104,90,197,98,21,28})), function()
return _v118.NoRecoil.RequireMouseDown
end, function()
_v118.NoRecoil.RequireMouseDown = not _v118.NoRecoil.RequireMouseDown
end)
_v284(_v400, (_V9({25,24,66,92,192,43,58,18,47,120,48,65,68,217})), function()
return _v118.NoRecoil.AllowAim
end, function()
_v118.NoRecoil.AllowAim = not _v118.NoRecoil.AllowAim
end)
_v275(_v400, (_V9({11,0,92,86,217,108,15,19})), 0, 100, function()
return _v118.NoRecoil.Strength * 100
end, function(_v531)
_v118.NoRecoil.Strength = _v531 / 100
end, true, (_V9({125})), true)
local _v465 = _v276(_v255, (_V9({22,27,14,96,199,121,30,26,38})))
_v285(_v465, (_V9({29,26,79,81,219,110,31})), function()
return _v118.NoSpread.Enabled
end, function()
_v118.NoSpread.Enabled = not _v118.NoSpread.Enabled
end, (_V9({22,27,14,96,199,121,30,26,38,120,63,75,74})), function()
return _v118.NoSpread.ToggleKey
end, function(_v245)
_v118.NoSpread.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({54,27,93,67,197,110,26,31})))
end)
_v284(_v465, (_V9({23,26,66,74,151,92,19,18,46,61,84,104,90,197,98,21,28})), function()
return _v118.NoSpread.RequireMouseDown
end, function()
_v118.NoSpread.RequireMouseDown = not _v118.NoSpread.RequireMouseDown
end)
_v275(_v465, (_V9({11,0,92,86,217,108,15,19})), 0, 100, function()
return _v118.NoSpread.Strength * 100
end, function(_v531)
_v118.NoSpread.Strength = _v531 / 100
end, true, (_V9({125})), true)
end
local function _v83(_v372, _v118)
_v254 = 0
local _v220 = _v282(_v372)
local _v255, right = _v272(_v220:add((_V9({29,39,126}))))
local _v169 = _v276(_v255, (_V9({29,39,126})))
_v285(_v169, (_V9({29,26,79,81,219,110,31})), function()
return _v118.ESP.Enabled
end, function()
_v118.ESP.Enabled = not _v118.ESP.Enabled
end, (_V9({29,39,126,19,252,110,2})), function()
return _v118.ESP.ToggleKey
end, function(_v245)
_v118.ESP.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({61,7,94})))
end)
_v284(_v169, (_V9({22,36,109,64})), function()
return _v118.ESP.NPCs
end, function()
_v118.ESP.NPCs = not _v118.ESP.NPCs
end)
_v275(_v169, (_V9({21,21,86,19,243,98,8,15,35,54,23,75})), 100, 2000, function()
return _v118.ESP.MaxDistance
end, function(_v531)
_v118.ESP.MaxDistance = _v531
end, true, (_V9({53})), true)
local _v266 = _v276(_v255, (_V9({25,4,94,86,214,121,26,21,33,61})))
_v284(_v266, (_V9({23,1,90,95,222,101,30,8})), function()
return _v118.ESP.Outlines
end, function()
_v118.ESP.Outlines = not _v118.ESP.Outlines
end)
_v284(_v266, (_V9({26,27,86,86,196})), function()
return _v118.ESP.Boxes
end, function()
_v118.ESP.Boxes = not _v118.ESP.Boxes
end)
_v284(_v266, (_V9({22,21,67,86,196})), function()
return _v118.ESP.Names
end, function()
_v118.ESP.Names = not _v118.ESP.Names
end)
_v284(_v266, (_V9({28,29,93,71,214,101,24,30})), function()
return _v118.ESP.Distance
end, function()
_v118.ESP.Distance = not _v118.ESP.Distance
end)
_v284(_v266, (_V9({16,17,79,95,195,99,91,57,35,42,7})), function()
return _v118.ESP.HealthBars
end, function()
_v118.ESP.HealthBars = not _v118.ESP.HealthBars
end)
_v284(_v266, (_V9({30,29,66,95,210,111})), function()
return _v118.ESP.Filled
end, function()
_v118.ESP.Filled = not _v118.ESP.Filled
end)
_v275(_v266, (_V9({23,1,90,95,222,101,30,91,13,40,21,77,90,195,114})), 0, 1, function()
return _v118.ESP.OutlineOpacity
end, function(_v531)
_v118.ESP.OutlineOpacity = _v531
end, false)
_v275(_v266, (_V9({30,29,66,95,151,68,11,26,33,49,0,87})), 0, 1, function()
return _v118.ESP.FillOpacity
end, function(_v531)
_v118.ESP.FillOpacity = _v531
end, false)
local _v156 = _v276(right, (_V9({28,6,79,68,222,101,28,91,7,11,36})))
_v284(_v156, (_V9({26,27,86,86,196})), function()
return _v118.Drawing.Boxes
end, function()
_v118.Drawing.Boxes = not _v118.Drawing.Boxes
end)
_v284(_v156, (_V9({12,6,79,80,210,121,8})), function()
return _v118.Drawing.Tracers
end, function()
_v118.Drawing.Tracers = not _v118.Drawing.Tracers
end)
local _v555 = _v276(right, (_V9({15,27,92,95,211})))
_v284(_v555, (_V9({30,1,66,95,213,121,18,28,42,44})), function()
return _v118.Visuals.Fullbright
end, function()
_v118.Visuals.Fullbright = not _v118.Visuals.Fullbright
end)
_v284(_v555, (_V9({22,27,14,117,216,108})), function()
return _v118.Visuals.NoFog
end, function()
_v118.Visuals.NoFog = not _v118.Visuals.NoFog
end)
_v255, right = _v272(_v220:add((_V9({27,27,66,92,197,120}))))
_v271(_v255, (_V9({23,1,90,95,222,101,30,91,1,55,24,65,65})), function()
return _v118.ESP.OutlineColor
end, function(c)
_v118.ESP.OutlineColor = c
end)
_v271(right, (_V9({30,29,66,95,151,72,20,23,45,42})), function()
return _v118.ESP.FillColor
end, function(c)
_v118.ESP.FillColor = c
end)
_v271(_v255, (_V9({26,27,86,19,244,100,23,20,48})), function()
return _v118.Drawing.BoxColor
end, function(c)
_v118.Drawing.BoxColor = c
end)
_v271(right, (_V9({12,6,79,80,210,121,91,56,45,52,27,92})), function()
return _v118.Drawing.TracerColor
end, function(c)
_v118.Drawing.TracerColor = c
end)
end
local function _v88(_v372, _v118)
_v254 = 0
local _v220 = _v282(_v372)
local _v255, right = _v272(_v220:add((_V9({21,27,88,86,218,110,21,15}))))
local _v180 = _v276(_v255, (_V9({30,24,87})))
_v284(_v180, (_V9({29,26,79,81,219,110,31})), function()
return _v118.Movement.FlyEnabled
end, function()
_v118.Movement.FlyEnabled = not _v118.Movement.FlyEnabled
end)
_v275(_v180, (_V9({30,24,87,19,228,123,30,30,38})), 10, 200, function()
return _v118.Movement.FlySpeed
end, function(_v531)
_v118.Movement.FlySpeed = _v531
end, true)
local _v464 = _v276(_v255, (_V9({11,4,75,86,211})))
_v284(_v464, (_V9({29,26,79,81,219,110,31})), function()
return _v118.Movement.SpeedEnabled
end, function()
_v118.Movement.SpeedEnabled = not _v118.Movement.SpeedEnabled
end)
_v275(_v464, (_V9({11,4,75,86,211})), 16, 100, function()
return _v118.Movement.Speed
end, function(_v531)
_v118.Movement.Speed = _v531
end, true)
local _v292 = _v276(_v255, (_V9({23,0,70,86,197})))
_v284(_v292, (_V9({22,27,77,95,222,123})), function()
return _v118.Movement.NoclipEnabled
end, function()
_v118.Movement.NoclipEnabled = not _v118.Movement.NoclipEnabled
end)
_v284(_v292, (_V9({17,26,72,90,217,98,15,30,98,18,1,67,67})), function()
return _v118.Movement.InfJumpEnabled
end, function()
_v118.Movement.InfJumpEnabled = not _v118.Movement.InfJumpEnabled
end)
local _v515 = _v276(right, (_V9({27,24,71,80,220,43,47,43})))
_v284(_v515, (_V9({29,26,79,81,219,110,31})), function()
return _v118.Movement.ClickTPEnabled
end, function()
_v118.Movement.ClickTPEnabled = not _v118.Movement.ClickTPEnabled
end)
_v279(_v515, (_V9({21,27,74,90,209,98,30,9,98,19,17,87})), function()
return _v118.Movement.ClickTPKey
end, function(_v245)
_v118.Movement.ClickTPKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({59,24,71,80,220,127,11})))
end)
end
local function _v89(_v372, _v118)
_v254 = 0
local _v220 = _v282(_v372)
local _v255, right = _v272(_v220:add((_V9({8,24,79,74,210,121,8}))))
local _v261 = _v276(_v255, (_V9({8,24,79,74,210,121,91,55,43,43,0})))
_v384 = _v317((_V9({11,23,92,92,219,103,18,21,37,30,6,79,94,210})), {
Parent = _v261,
LayoutOrder = _v319(),
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v384, CornerRadius = UDim.new(0, 6) })
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = _v384,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = _v384,
PaddingTop = UDim.new(0, 4),
PaddingBottom = UDim.new(0, 4),
PaddingLeft = UDim.new(0, 4),
PaddingRight = UDim.new(0, 4),
})
local function _v403()
for _v382, row in pairs(_v385) do
row.btn.BackgroundColor3 = (_v382 == _v450) and _v6.accent or _v6.row
end
end
local function _v402()
if not _v384 then
return
end
for _, _v113 in ipairs(_v384:GetChildren()) do
if not _v113:IsA((_V9({13,61,98,90,196,127,55,26,59,55,1,90}))) then
_v113:Destroy()
end
end
table.clear(_v385)
local _v125 = 0
for _, _v382 in ipairs(_v31:GetPlayers()) do
if _v382 ~= _v26 then
_v125 = _v125 + 1
local row = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v384,
LayoutOrder = _v125,
Size = UDim2.new(1, 0, 0, 24),
BackgroundColor3 = (_v382 == _v450) and _v6.accent or _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = row, CornerRadius = UDim.new(0, 4) })
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = row,
Size = UDim2.new(0.65, -8, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v382.TeamColor.Color,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v382.Name,
})
local dist = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = row,
Size = UDim2.new(0.35, -8, 1, 0),
Position = UDim2.new(0.65, 0, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = (_V9({186,244,186})),
})
row.MouseButton1Click:Connect(function()
_v450 = (_v450 == _v382) and nil or _v382
_v403()
end)
_v385[_v382] = { btn = row, dist = dist }
end
end
if _v125 == 0 then
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v384,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({120,84,64,92,151,100,15,19,39,42,84,94,95,214,114,30,9,49})),
})
end
end
local _v51 = _v276(right, (_V9({25,23,90,90,216,101,8})))
local _v449 = _v280(_v51, (_V9({11,17,66,86,212,127,30,31})), (_V9({186,244,186})))
_v270(_v51, (_V9({12,17,66,86,199,100,9,15,98,12,27})), function()
local _v110 = _v450 and _v450.Character
local root = _v110 and _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
if root and UI.TeleportTo then
UI.TeleportTo(root.Position)
end
end)
_v462 = _v270(_v51, (_V9({11,4,75,80,195,106,15,30})), function()
if _v463 then
_v473()
elseif _v450 then
_v471(_v450)
end
end)
table.insert(_v481, function()
_v449.Text = _v450 and _v450.Name or (_V9({186,244,186}))
_v403()
end)
_v402()
table.insert(_v520, _v31.PlayerAdded:Connect(function()
_v402()
end))
table.insert(_v520, _v31.PlayerRemoving:Connect(function(_v382)
if _v382 == _v450 then
_v450 = nil
end
if _v382 == _v463 then
_v473()
end
_v402()
end))
local _v252 = 0
table.insert(_v520, _v36.RenderStepped:Connect(function()
if os.clock() - _v252 < 0.5 then
return
end
_v252 = os.clock()
_v449.Text = _v450 and _v450.Name or (_V9({186,244,186}))
local _v309 = _v26.Character
local _v310 = _v309 and _v309:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
for _v382, row in pairs(_v385) do
local _v110 = _v382.Character
local root = _v110 and _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
row.dist.Text = (_v310 and root)
and (math.floor((root.Position - _v310.Position).Magnitude + 0.5) .. (_V9({53})))
or (_V9({186,244,186}))
end
if _v463 then
if _v54 and _v54.Movement and _v54.Movement.FlyEnabled then
_v473()
else
local _v110 = _v463.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
local _v93 = _v48.CurrentCamera
if humanoid and humanoid.Health > 0 and _v93 then
_v93.CameraSubject = humanoid
else
_v473()
end
end
end
end))
end
local function _v87(_v372, _v118)
_v254 = 0
local _v220 = _v282(_v372)
local _v255, right = _v272(_v220:add((_V9({11,17,93,64,222,100,21}))))
local _v50 = _v276(_v255, (_V9({25,23,77,92,194,101,15})))
_v280(_v50, (_V9({13,7,75,65,217,106,22,30})), _v26 and _v26.Name or (_V9({186,244,186})))
_v280(_v50, (_V9({28,29,93,67,219,106,2,91,12,57,25,75})), _v26 and _v26.DisplayName or (_V9({186,244,186})))
_v280(_v50, (_V9({13,7,75,65,151,66,63})), _v26 and tostring(_v26.UserId) or (_V9({186,244,186})))
_v270(_v50, (_V9({11,17,92,69,210,121,91,51,45,40})), function()
_v45:ServerHop()
end)
_v270(_v50, (_V9({10,17,68,92,222,101,91,40,39,42,2,75,65})), function()
_v45:Rejoin()
end)
local _v549 = _v276(right, (_V9({15,17,76,91,216,100,16})))
local _v530 = _v283(_v549, (_V9({47,17,76,91,216,100,16,91,55,42,24,204,179,17})))
_v530.Text = _v118.Webhook.Url
_v530.FocusLost:Connect(function()
_v118.Webhook.Url = _v530.Text
end)
_v270(_v549, (_V9({11,17,64,87,151,95,30,8,54,120,35,75,81,223,100,20,16})), function()
local _v340, res = _v47.SendWebhook((_V9({14,21,64,90,195,114,86,60,39,54,17,92,82,219,43,15,30,49,44,84,89,86,213,99,20,20,41})))
if _v340 then
UI:Notify((_V9({12,17,93,71,151,124,30,25,42,55,27,69,19,196,110,21,15})), 2)
else
UI:Notify((_V9({15,17,76,91,216,100,16,91,36,57,29,66,86,211,49,91})) .. tostring(res), 3)
end
end)
end
local function _v90(_v372, _v118)
_v254 = 0
local _v220 = _v282(_v372)
local _v255, right = _v272(_v220:add((_V9({31,17,64,86,197,106,23}))))
local _v227 = _v276(_v255, (_V9({17,26,90,86,197,109,26,24,39})))
_v275(_v227, (_V9({13,61,14,96,212,106,23,30})), 0.8, 1.5, function()
return _v118.UI.Scale
end, function(_v531)
_v118.UI.Scale = _v531
if _v553 then
_v553.Scale = _v531
end
end, false)
_v284(_v227, (_V9({19,17,87,81,222,101,31,91,18,57,26,75,95})), function()
return _v118.UI.KeybindPanel
end, function()
_v118.UI.KeybindPanel = not _v118.UI.KeybindPanel
if _v248 then
_v248.Visible = _v118.UI.KeybindPanel
end
end)
_v284(_v227, (_V9({12,21,92,84,210,127,91,63,43,43,4,66,82,206})), function()
return _v118.UI.TargetDisplay
end, function()
_v118.UI.TargetDisplay = not _v118.UI.TargetDisplay
_v491 = _v118.UI.TargetDisplay
if not _v491 and _v492 then
_v492.Visible = false
end
end)
_v284(_v227, (_V9({30,36,125,19,244,100,14,21,54,61,6})), function()
return _v118.UI.FPSCounter
end, function()
_v118.UI.FPSCounter = not _v118.UI.FPSCounter
if _v188 then
_v188.Visible = _v118.UI.FPSCounter
end
end)
_v284(_v227, (_V9({15,21,90,86,197,102,26,9,41})), function()
return _v118.UI.Watermark
end, function()
_v118.UI.Watermark = not _v118.UI.Watermark
if _v548 then
_v548.Visible = _v118.UI.Watermark
end
end)
_v271(_v227, (_V9({25,23,77,86,217,127,91,56,45,52,27,92})), function()
return _v118.UI.Accent
end, function(_v315)
_v67(_v315)
end)
table.insert(_v481, function()
if _v118.UI.Accent then
_v67(_v118.UI.Accent)
end
end)
_v255, right = _v272(_v220:add((_V9({27,27,64,85,222,108,8}))))
local _v107 = _v276(_v255, (_V9({27,27,64,85,222,108,8})))
if not _v11.isSupported() then
_v280(_v107, (_V9({11,0,79,71,194,120})), (_V9({13,26,93,70,199,123,20,9,54,61,16})))
return
end
local _v312 = _v283(_v107, (_V9({59,27,64,85,222,108,91,21,35,53,17,204,179,17})))
local _v262 = _v317((_V9({30,6,79,94,210})), {
Parent = _v107,
LayoutOrder = _v319(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = _v262,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v402
local function _v447(name)
_v312.Text = name
_v402()
end
_v402 = function()
for _, _v113 in ipairs(_v262:GetChildren()) do
if not _v113:IsA((_V9({13,61,98,90,196,127,55,26,59,55,1,90}))) then
_v113:Destroy()
end
end
local _v314 = _v11.list()
if #_v314 == 0 then
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v262,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({54,27,14,64,214,125,30,31,98,59,27,64,85,222,108,8})),
})
return
end
for i, name in ipairs(_v314) do
local _v448 = (_v312.Text == name)
local row = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v262,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v448 and _v6.accent or _v6.row,
BackgroundTransparency = _v448 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v448 and Color3.fromRGB(255, 255, 255) or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({120,84})) .. name,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v447(name)
end)
row.MouseEnter:Connect(function()
if _v312.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v6.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v312.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v6.row
end
end)
end
end
_v270(_v107, (_V9({11,21,88,86})), function()
local _v340, res = _v11.save(_v312.Text, _v118)
if _v340 then
UI:Notify((_V9({11,21,88,86,211,43,24,20,44,62,29,73,19,144})) .. res .. (_V9({127})), 2)
_v402()
else
UI:Notify(tostring(res), 3)
end
end)
_v270(_v107, (_V9({20,27,79,87})), function()
local _v340, res = _v11.load(_v312.Text, _v118)
if _v340 then
if _v553 then
_v553.Scale = _v118.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({20,27,79,87,210,111,91,24,45,54,18,71,84,151,44})) .. res .. (_V9({127})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v270(_v107, (_V9({28,17,66,86,195,110})), function()
local _v340, res = _v11.delete(_v312.Text)
if _v340 then
UI:Notify((_V9({28,17,66,86,195,110,31,91,33,55,26,72,90,208,43,92})) .. res .. (_V9({127})), 2)
_v312.Text = (_V9({}))
_v402()
else
UI:Notify(tostring(res), 3)
end
end, _v6.danger)
_v402()
end
local function _v91(_v118)
_v492 = _v317((_V9({30,6,79,94,210})), {
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v492, CornerRadius = UDim.new(0, 6) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v492, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = _v492,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = _v492,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v153 = _v317((_V9({30,6,79,94,210})), {
Parent = _v492,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v492,
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
local _v155, _v154, _v470
_v492.InputBegan:Connect(function(_v230)
if _v242(_v230) then
_v155 = true
_v154 = _v230.Position
_v470 = _v492.Position
end
end)
table.insert(_v298, function(_v230)
if _v155 and _v492 then
local delta = _v230.Position - _v154
_v492.Position = UDim2.new(
_v470.X.Scale,
_v470.X.Offset + delta.X,
_v470.Y.Scale,
_v470.Y.Offset + delta.Y
)
end
end)
table.insert(_v407, function()
_v155 = false
end)
table.insert(_v481, function()
_v491 = _v118.UI.TargetDisplay
if not _v491 and _v492 then
_v492.Visible = false
end
end)
_v491 = _v118.UI.TargetDisplay
end
local function _v85(_v118)
_v188 = _v317((_V9({30,6,79,94,210})), {
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v188, CornerRadius = UDim.new(0, 6) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v188, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = _v188,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = _v188,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v153 = _v317((_V9({30,6,79,94,210})), {
Parent = _v188,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
Text = (_V9({117,89,14,85,199,120})),
})
table.insert(_v481, function()
if _v188 then
_v188.Visible = _v118.UI.FPSCounter
end
end)
_v188.Visible = _v118.UI.FPSCounter
end
local function _v92(_v118)
_v548 = _v317((_V9({17,25,79,84,210,71,26,25,39,52})), {
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
table.insert(_v481, function()
if _v548 then
_v548.Visible = _v118.UI.Watermark
end
end)
_v548.Visible = _v118.UI.Watermark
end
local function _v86(_v118)
_v254 = 0
_v248 = _v317((_V9({30,6,79,94,210})), {
Parent = _v200,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
Visible = false,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v248, CornerRadius = UDim.new(0, 8) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v248, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), {
Parent = _v248,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = _v248,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v317((_V9({30,6,79,94,210})), {
Parent = _v248,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({19,17,87,81,222,101,31,8})),
})
local _v155, _v154, _v470
bar.InputBegan:Connect(function(_v230)
if _v242(_v230) then
_v155 = true
_v154 = _v230.Position
_v470 = _v248.Position
end
end)
table.insert(_v298, function(_v230)
if _v155 and _v248 then
local delta = _v230.Position - _v154
_v248.Position = UDim2.new(
_v470.X.Scale,
_v470.X.Offset + delta.X,
_v470.Y.Scale,
_v470.Y.Offset + delta.Y
)
end
end)
table.insert(_v407, function()
_v155 = false
end)
_v279(_v248, (_V9({21,17,64,70})), function()
return _v118.UI.MenuKey
end, function(_v245)
_v118.UI.MenuKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({53,17,64,70})))
end)
_v279(_v248, (_V9({25,29,67,81,216,127})), function()
return _v118.Camera.ToggleKey
end, function(_v245)
_v118.Camera.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({57,29,67,81,216,127})))
end)
_v279(_v248, (_V9({29,39,126})), function()
return _v118.ESP.ToggleKey
end, function(_v245)
_v118.ESP.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({61,7,94})))
end)
_v279(_v248, (_V9({30,59,120,19,244,98,9,24,46,61})), function()
return _v118.Camera.FOVCircleKey
end, function(_v245)
_v118.Camera.FOVCircleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({62,27,88,80,222,121,24,23,39})))
end)
_v279(_v248, (_V9({22,27,14,97,210,104,20,18,46})), function()
return _v118.NoRecoil.ToggleKey
end, function(_v245)
_v118.NoRecoil.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({54,27,92,86,212,100,18,23})))
end)
_v279(_v248, (_V9({22,27,14,96,199,121,30,26,38})), function()
return _v118.NoSpread.ToggleKey
end, function(_v245)
_v118.NoSpread.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({54,27,93,67,197,110,26,31})))
end)
_v279(_v248, (_V9({12,6,71,84,208,110,9,25,45,44})), function()
return _v118.Triggerbot.ToggleKey
end, function(_v245)
_v118.Triggerbot.ToggleKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({44,6,71,84,208,110,9,25,45,44})))
end)
_v279(_v248, (_V9({13,26,66,92,214,111})), function()
return _v118.UI.UnloadKey
end, function(_v245)
_v118.UI.UnloadKey = _v245
end, function(_v245)
return _v246(_v118, _v245, (_V9({45,26,66,92,214,111})))
end)
table.insert(_v481, function()
if _v248 then
_v248.Visible = _v118.UI.KeybindPanel
end
end)
_v248.Visible = _v118.UI.KeybindPanel
end
local function _v455(_v472)
if not _v269 or _v472 == _v537 then
return
end
_v537 = _v472
if _v54 and _v54.UI then
_v54.UI.Visible = _v472
end
if _v472 then
_v269.Visible = true
_v269.GroupTransparency = 1
_v43:Create(_v269, TweenInfo.new(_v17), { GroupTransparency = 0 }):Play()
else
local _v519 = _v43:Create(_v269, TweenInfo.new(_v17), { GroupTransparency = 1 })
_v519.Completed:Once(function()
if not _v537 and _v269 then
_v269.Visible = false
end
end)
_v519:Play()
end
end
function UI:Init(_v118, _v358)
if _v200 then
return
end
_v54 = _v118
_v359 = _v358
if _v118.UI.Accent then
_v6.accent = _v118.UI.Accent
end
_v469()
_v200 = _v317((_V9({11,23,92,86,210,101,60,14,43})), {
Name = _v10.RandomName(),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v340 = pcall(function()
_v200.Parent = _v45.getGuiParent()
end)
if not _v340 or not _v200.Parent then
_v200.Parent = _v26:WaitForChild((_V9({8,24,79,74,210,121,60,14,43})))
end
_v10.Protect(_v200)
_v269 = _v317((_V9({27,21,64,69,214,120,60,9,45,45,4})), {
Parent = _v200,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v553 = _v317((_V9({13,61,125,80,214,103,30})), { Parent = _v269, Scale = _v118.UI.Scale })
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v269, CornerRadius = UDim.new(0, 8) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v269, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
local _v506 = _v317((_V9({30,6,79,94,210})), {
Parent = _v269,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v506, CornerRadius = UDim.new(0, 8) })
_v317((_V9({30,6,79,94,210})), {
Parent = _v506,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
local _v153 = _v317((_V9({30,6,79,94,210})), {
Parent = _v506,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v506,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({14,21,64,90,195,114,71,29,45,54,0,14,80,216,103,20,9,127,122,87,22,7,132,78,57,62,96,102,90,74,86,193,55,84,29,45,54,0,16,19,240,110,21,30,48,57,24}))
.. (_V9({100,18,65,93,195,43,24,20,46,55,6,19,17,148,51,58,76,1,25,68,12,13,151,43,91,185,245,120,84,14,69,135,55,84,29,45,54,0,16})),
ZIndex = 2,
})
_v317((_V9({12,17,86,71,251,106,25,30,46})), {
Parent = _v506,
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
local _v155, _v154, _v470
_v506.InputBegan:Connect(function(_v230)
if _v242(_v230) then
_v155 = true
_v154 = _v230.Position
_v470 = _v269.Position
end
end)
table.insert(_v298, function(_v230)
if _v155 then
local delta = _v230.Position - _v154
_v269.Position = UDim2.new(
_v470.X.Scale,
_v470.X.Offset + delta.X,
_v470.Y.Scale,
_v470.Y.Offset + delta.Y
)
end
end)
table.insert(_v407, function()
_v155 = false
end)
local _v459 = _v317((_V9({30,6,79,94,210})), {
Parent = _v269,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v459, CornerRadius = UDim.new(0, 6) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v459, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = _v459,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v487 = _v317((_V9({30,6,79,94,210})), {
Parent = _v459,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({13,61,98,90,196,127,55,26,59,55,1,90})), { Parent = _v487, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v522 = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v459,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.danger,
Text = (_V9({13,26,66,92,214,111})),
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v522, CornerRadius = UDim.new(0, 6) })
local _v523 = _v317((_V9({13,61,125,71,197,100,16,30})), {
Parent = _v522,
Color = _v6.danger,
Thickness = 1,
Transparency = 0.55,
})
_v522.MouseButton1Click:Connect(function()
if _v359 then
_v359()
end
end)
_v522.MouseEnter:Connect(function()
_v43:Create(_v522, _v1, {
BackgroundColor3 = _v6.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v43:Create(_v523, _v1, { Transparency = 0 }):Play()
end)
_v522.MouseLeave:Connect(function()
_v43:Create(_v522, _v1, {
BackgroundColor3 = _v6.row,
TextColor3 = _v6.danger,
}):Play()
_v43:Create(_v523, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v317((_V9({30,6,79,94,210})), {
Parent = _v269,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({13,61,126,82,211,111,18,21,37})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v489 = { (_V9({27,27,67,81,214,127})), (_V9({14,29,93,70,214,103})), (_V9({21,27,88,86,218,110,21,15})), (_V9({8,24,79,74,210,121,8})), (_V9({21,29,93,80})), (_V9({11,17,90,71,222,101,28,8})) }
local _v486 = {}
for i, _v488 in ipairs(_v489) do
local _v235 = _v126 == _v488
local _v484 = _v317((_V9({12,17,86,71,245,126,15,15,45,54})), {
Parent = _v487,
LayoutOrder = i,
Size = UDim2.new(1, 0, 1 / #_v489, -6),
BackgroundColor3 = _v6.rowHover,
BackgroundTransparency = _v235 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v235 and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({120,84,14,19})) .. _v488,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v484, CornerRadius = UDim.new(0, 6) })
local stripe = _v317((_V9({30,6,79,94,210})), {
Parent = _v484,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
Visible = _v235,
ZIndex = 2,
})
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v485 = _v317((_V9({30,6,79,94,210})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v235,
})
_v486[_v488] = { btn = _v484, frame = _v485, stripe = stripe }
_v484.MouseButton1Click:Connect(function()
_v126 = _v488
for name, _v483 in pairs(_v486) do
local _v52 = name == _v488
_v483.frame.Visible = _v52
_v483.stripe.Visible = _v52
_v43:Create(_v483.btn, _v1, {
BackgroundTransparency = _v52 and 0 or 1,
TextColor3 = _v52 and _v6.text or _v6.textSub,
}):Play()
end
end)
_v484.MouseEnter:Connect(function()
if _v126 ~= _v488 then
_v43:Create(_v484, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v484.MouseLeave:Connect(function()
if _v126 ~= _v488 then
_v43:Create(_v484, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v82(_v486[(_V9({27,27,67,81,214,127}))].frame, _v118)
_v83(_v486[(_V9({14,29,93,70,214,103}))].frame, _v118)
_v88(_v486[(_V9({21,27,88,86,218,110,21,15}))].frame, _v118)
_v89(_v486[(_V9({8,24,79,74,210,121,8}))].frame, _v118)
_v87(_v486[(_V9({21,29,93,80}))].frame, _v118)
_v90(_v486[(_V9({11,17,90,71,222,101,28,8}))].frame, _v118)
_v86(_v118)
_v91(_v118)
_v85(_v118)
_v92(_v118)
if _v118.UI.Visible then
_v455(true)
end
end
function UI:Toggle()
_v455(not _v537)
end
function UI:Show()
_v455(true)
end
function UI:Hide()
_v455(false)
end
function UI:SetCurrentTarget(name)
if not _v492 then
return
end
if _v492.Visible ~= _v491 then
_v492.Visible = _v491
end
if not _v491 or not targetPanelLabel then
return
end
local _v458, colour
if name and name ~= (_V9({})) and name ~= (_V9({22,27,64,86})) then
_v458, colour = name, (_V9({123,76,26,0,242,73,62}))
else
_v458, colour = (_V9({13,26,101,93,216,124,21})), (_V9({123,76,111,4,244,74,75}))
end
local text = (_V9({12,21,92,84,210,127,65,91,126,62,27,64,71,151,104,20,23,45,42,73,12})) .. colour .. (_V9({122,74})) .. _v458 .. (_V9({100,91,72,92,217,127,69}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v186)
if not fpsLabel or not _v188 or not _v188.Visible then
return
end
local text = string.format((_V9({100,18,65,93,195,43,24,20,46,55,6,19,17,148,51,79,72,7,26,49,12,13,146,111,71,84,36,55,26,90,13,151,109,11,8})), _v186 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v226)
if not _v548 then
return
end
local _v146 = tostring(_v226 or (_V9({}))):match((_V9({125,16,5})))
_v548.Image = _v146 and ((_V9({42,22,86,82,196,120,30,15,43,60,78,1,28})) .. _v146) or (_V9({}))
end
function UI:SyncControls()
for _, _v182 in ipairs(_v481) do
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
local _v508 = _v317((_V9({12,17,86,71,251,106,25,30,46})), {
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
_v317((_V9({13,61,109,92,197,101,30,9})), { Parent = _v508, CornerRadius = UDim.new(0, 8) })
_v317((_V9({13,61,125,71,197,100,16,30})), { Parent = _v508, Color = _v6.accent, Thickness = 1, Transparency = 0.3 })
_v43:Create(_v508, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v161, function()
if _v508 and _v508.Parent then
local _v370 = _v43:Create(_v508, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v370.Completed:Once(function()
if _v508 then
_v508:Destroy()
end
end)
_v370:Play()
end
end)
end
function UI:Cleanup()
_v473()
_v450 = nil
_v462 = nil
_v384 = nil
table.clear(_v385)
for _, _v121 in ipairs(_v520) do
_v121:Disconnect()
end
table.clear(_v520)
table.clear(_v298)
table.clear(_v407)
table.clear(_v481)
_v53 = nil
_v102 = false
_v55 = nil
_v492, targetPanelLabel = nil, nil
_v491 = false
_v248 = nil
_v548 = nil
_v188, fpsLabel = nil, nil
_v553 = nil
if _v200 then
_v200:Destroy()
_v200 = nil
_v269 = nil
end
_v537 = false
end
return UI
end)()
Movement = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v44 = game:GetService((_V9({13,7,75,65,254,101,11,14,54,11,17,92,69,222,104,30})))
local _v48 = game:GetService((_V9({15,27,92,88,196,123,26,24,39})))
local _v26 = _v31.LocalPlayer
local UI = UI
local Movement = {}
local _v5 = 16
local _v23 = 50
local _v304
local _v302
local _v308 = 0
local function _v301()
local _v110 = _v26.Character
local root = _v110 and _v110:FindFirstChild((_V9({16,1,67,82,217,100,18,31,16,55,27,90,99,214,121,15})))
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({16,1,67,82,217,100,18,31})))
if not (_v110 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v110, root, humanoid
end
local function _v303(_v93)
local _v266 = _v93.CFrame.LookVector
local _v178 = Vector3.new(_v266.X, 0, _v266.Z)
if _v178.Magnitude < 0.001 then
_v178 = Vector3.new(0, 0, -1)
else
_v178 = _v178.Unit
end
local right = _v93.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v297 = Vector3.zero
if _v44:IsKeyDown(Enum.KeyCode.W) then
_v297 = _v297 + _v178
end
if _v44:IsKeyDown(Enum.KeyCode.S) then
_v297 = _v297 - _v178
end
if _v44:IsKeyDown(Enum.KeyCode.D) then
_v297 = _v297 + right
end
if _v44:IsKeyDown(Enum.KeyCode.A) then
_v297 = _v297 - right
end
if _v44:IsKeyDown(Enum.KeyCode.Space) then
_v297 = _v297 + Vector3.yAxis
end
if _v44:IsKeyDown(Enum.KeyCode.LeftShift) then
_v297 = _v297 - Vector3.yAxis
end
if _v297.Magnitude > 0 then
return _v297.Unit
end
return nil
end
local _v29 = 0.1
local _v30 = 0.15
local function _v307()
return (os.clock() % (_v29 + _v30)) < _v29
end
function Movement:Update(_v160, _v118)
local _v110, root, humanoid = _v301()
if _v118.NoclipEnabled and _v110 then
local _v320 = _v110:GetDescendants()
for i = 1, #_v320 do
local part = _v320[i]
if part:IsA((_V9({26,21,93,86,231,106,9,15}))) then
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
local _v536 = Vector3.zero
if not UI:IsCapturingKey() then
local _v147 = _v303(_v93)
if _v147 then
local _v464 = _v118.FlySpeed or 50
if not _v307() then
_v464 = math.min(_v464, _v5)
end
_v536 = _v147 * _v464
end
end
root.AssemblyLinearVelocity = _v536
end
return
end
if _v118.SpeedEnabled then
local _v464 = _v118.Speed or _v5
local _v297 = humanoid.MoveDirection
if _v464 > _v5 and _v297.Magnitude > 0 and _v307() then
local _v536 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v297.X * _v464, _v536.Y, _v297.Z * _v464)
end
end
end
local function _v306(_v118)
if not _v118.InfJumpEnabled then
return
end
local _, root = _v301()
if root then
local _v536 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v536.X, _v23, _v536.Z)
end
end
local _v41 = 10
local _v40 = 0.05
function Movement.TeleportTo(_v388)
local _v142 = _v388 + Vector3.new(0, 3, 0)
_v308 = _v308 + 1
local _v510 = _v308
task.spawn(function()
while _v510 == _v308 do
local _, currentRoot = _v301()
if not currentRoot then
return
end
local _v339 = _v142 - currentRoot.CFrame.Position
if _v339.Magnitude <= _v41 then
currentRoot.CFrame = CFrame.new(_v142)
return
end
currentRoot.CFrame = currentRoot.CFrame + _v339.Unit * _v41
task.wait(_v40)
end
end)
end
local function _v305(_v118, _v230, _v193)
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
local _v296 = _v26:GetMouse()
if _v296 and _v296.Hit then
Movement.TeleportTo(_v296.Hit.Position)
end
end
function Movement:Init(_v118)
if not _v304 then
_v304 = _v44.JumpRequest:Connect(function()
_v306(_v118)
end)
end
if not _v302 then
_v302 = _v44.InputBegan:Connect(function(_v230, _v193)
_v305(_v118, _v230, _v193)
end)
end
end
function Movement:Cleanup()
if _v304 then
_v304:Disconnect()
_v304 = nil
end
if _v302 then
_v302:Disconnect()
_v302 = nil
end
end
return Movement
end)()
_v13 = (function()
local _v31 = game:GetService((_V9({8,24,79,74,210,121,8})))
local _v36 = game:GetService((_V9({10,1,64,96,210,121,13,18,33,61})))
local _v44 = game:GetService((_V9({13,7,75,65,254,101,11,14,54,11,17,92,69,222,104,30})))
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
_v13.Version = (_V9({105,90,30,29,135}))
_v13.Config = _v12
UI.TeleportTo = Movement.TeleportTo
_v47.Version = _v13.Version
local _v427 = false
local _v122 = {}
local _v61 = false
local _v32 = _v10.RandomName()
local _v198 = {}
local _v20 = 5
local function _v199(name, _v182, ...)
local _v340, res = pcall(_v182, ...)
if _v340 then
local _v468 = _v198[name]
if _v468 then
_v468.failures = 0
end
return true, res
end
local _v468 = _v198[name]
if not _v468 then
_v468 = { failures = 0, lastWarn = -math.huge }
_v198[name] = _v468
end
_v468.failures = _v468.failures + 1
local _v322 = os.clock()
if _v322 - _v468.lastWarn >= _v20 then
_v468.lastWarn = _v322
warn(string.format((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,103,43,84,72,82,222,103,30,31,98,112,12,11,87,158,49,91,94,49})), name, _v468.failures, tostring(res)))
end
return false, nil
end
function _v13.IsRunning()
return _v427
end
function _v13.SaveConfig(name)
return _v11.save(name, _v12)
end
function _v13.LoadConfig(name)
local _v340, res = _v11.load(name, _v12)
if _v340 then
pcall(function()
UI:SyncControls()
end)
end
return _v340, res
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
function _v13.SetWebhook(_v529)
return _v47.SetWebhook(_v529)
end
function _v13.HasWebhook()
return _v47.HasWebhook()
end
function _v13.SendWebhook(content, _v365)
return _v47.SendWebhook(content, _v365)
end
function _v13.SendLoadedEmbed(_v237)
return _v47.SendLoadedEmbed(_v237)
end
function _v13.Start()
if _v427 then
return _v13
end
_v427 = true
local _v340, err = pcall(function()
ESP:Init()
UI:Init(_v12, function()
_v13.Stop()
end)
Movement:Init(_v12.Movement)
SilentAim:Init(_v12)
table.insert(_v122, _v31.PlayerAdded:Connect(function(_v382)
_v199((_V9({8,24,79,74,210,121,58,31,38,61,16})), ESP.OnPlayerAdded, ESP, _v382)
end))
table.insert(_v122, _v31.PlayerRemoving:Connect(function(_v382)
_v199((_V9({8,24,79,74,210,121,41,30,47,55,2,71,93,208})), ESP.OnPlayerRemoving, ESP, _v382)
end))
table.insert(_v122, _v44.InputBegan:Connect(function(_v230, _v193)
if _v193 or UI:IsCapturingKey() then
return
end
_v199((_V9({19,17,87,81,222,101,31,8})), function()
local _v245 = _v230.KeyCode
if _v245 == _v12.UI.MenuKey then
UI:Toggle()
elseif _v245 == _v12.UI.UnloadKey then
_v13.Stop()
else
local _v509 = {
{ _v12.Camera, (_V9({29,26,79,81,219,110,31})), _v12.Camera.ToggleKey },
{ _v12.ESP, (_V9({29,26,79,81,219,110,31})), _v12.ESP.ToggleKey },
{ _v12.Camera, (_V9({30,59,120,112,222,121,24,23,39})), _v12.Camera.FOVCircleKey },
{ _v12.NoRecoil, (_V9({29,26,79,81,219,110,31})), _v12.NoRecoil.ToggleKey },
{ _v12.NoSpread, (_V9({29,26,79,81,219,110,31})), _v12.NoSpread.ToggleKey },
{ _v12.Triggerbot, (_V9({29,26,79,81,219,110,31})), _v12.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v509) do
if _v245 == t[3] then
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
_v199((_V9({27,21,64,87,222,111,26,15,39,43})), _v9.Update, _v9, _v12.Camera, _v12.ESP)
_v199((_V9({29,39,126})), ESP.Update, ESP, _v12.ESP)
local _v342, target = true, nil
if not (UI.IsSpectating and UI.IsSpectating()) then
_v342, target = _v199((_V9({25,29,67,81,216,127})), _v8.Update, _v8, _v12.Camera, _v12.Debug)
end
if not _v342 then
target = nil
end
if _v12.UI.TargetDisplay then
_v199((_V9({12,21,92,84,210,127,91,31,43,43,4,66,82,206})), function()
local _v267 = _v8:GetLookTarget(_v12.ESP, _v12.Camera)
UI:SetCurrentTarget(_v267 and _v267.Name or nil)
end)
end
_v61 = _v12.Camera.Enabled and target ~= nil
_v199((_V9({22,27,125,67,197,110,26,31})), NoSpread.Update, NoSpread, _v12.NoSpread)
_v199((_V9({11,29,66,86,217,127,91,58,43,53})), SilentAim.Update, SilentAim, _v12)
_v199((_V9({12,6,71,84,208,110,9,25,45,44})), Triggerbot.Update, Triggerbot, _v12.Triggerbot, _v12.Camera)
_v199((_V9({21,27,88,86,218,110,21,15})), Movement.Update, Movement, _v160, _v12.Movement)
_v199((_V9({16,29,90,81,216,115})), _v22.Update, _v22, _v12.Hitbox, _v12.Camera)
_v199((_V9({28,6,79,68,222,101,28,91,7,11,36})), _v16.Update, _v16, _v12.Drawing, _v12.Camera)
_v199((_V9({14,29,93,70,214,103,8})), Visuals.Update, Visuals, _v12.Visuals)
_v187 = _v187 + _v160
fpsFrames = fpsFrames + 1
if _v187 >= 0.25 then
local _v186 = math.floor(fpsFrames / _v187 + 0.5)
_v187, fpsFrames = 0, 0
if _v12.UI.FPSCounter then
_v199((_V9({30,36,125,19,212,100,14,21,54,61,6})), UI.UpdateFPS, UI, _v186)
end
end
end))
pcall(function()
_v36:UnbindFromRenderStep(_v32)
end)
pcall(function()
_v36:BindToRenderStep(_v32, Enum.RenderPriority.Camera.Value + 1, function()
_v199((_V9({22,27,124,86,212,100,18,23})), NoRecoil.Update, NoRecoil, _v12.NoRecoil, _v61)
end)
end)
end)
if not _v340 then
warn((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,4,57,29,66,86,211,43,15,20,98,43,0,79,65,195,49})), err)
_v13.Stop()
return _v13
end
if not _v10.HideGlobal((_V9({14,21,64,90,195,114,60,30,44,61,6,79,95})), _v13) and getgenv then
getgenv().VanityGeneral = _v13
end
UI:Notify(string.format((_V9({14,21,64,90,195,114,86,60,39,54,17,92,82,219,43,23,20,35,60,17,74,19,151,233,251,217,98,120,36,92,86,196,120,91,94,49})), _v12.UI.MenuKey.Name), 4)
print(string.format((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,16,45,26,64,90,217,108,91,83,52,125,7,7})), _v13.Version))
print(string.format((_V9({21,17,64,70,141,43,94,8,98,120,8,14,19,244,106,22,30,48,57,78,14,22,196,43,91,7,98,120,33,64,95,216,106,31,65,98,125,7})),
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
if not _v427 then
return _v13
end
_v427 = false
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
print((_V9({3,34,79,93,222,127,2,86,5,61,26,75,65,214,103,38,91,17,44,27,94,67,210,111})))
return _v13
end
function _v13.Toggle()
if _v427 then
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
local _v391 = getgenv().VanityGeneral
if _v391 and _v391 ~= _v13 and type(_v391.Stop) == (_V9({62,1,64,80,195,98,20,21})) then
pcall(_v391.Stop)
end
end
pcall(function()
_v13.Start()
end)
return _v13
end
