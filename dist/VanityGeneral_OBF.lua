local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({212,128,26,104,19,64,75,77,181})
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
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
local _v26 = _v31.LocalPlayer
local _v390 = setmetatable({}, { __mode = (_V9({191})) })
local _v391 = 0
local _v213 = {}
local _v27 = (_V9({181,226,121,12,118,38,44,37,220,190,235,118,5,125,47,59,60,199,167,244,111,30,100,56,50,55,244,150,195,94,45,85,7,3,4,255,159,204,87,38,92,16,26,31,230,128,213,76,63,75,25,17}))
function _v10.RandomName(_v256)
_v256 = _v256 or 14
local _v365 = {}
for i = 1, _v256 do
local n = math.random(1, #_v27)
_v365[i] = string.sub(_v27, n, n)
end
return table.concat(_v365)
end
function _v10.CClosure(_v182)
if type(newcclosure) == (_V9({178,245,116,11,103,41,36,35})) then
local _v337, wrapped = pcall(newcclosure, _v182)
if _v337 and type(wrapped) == (_V9({178,245,116,11,103,41,36,35})) then
return wrapped
end
end
return _v182
end
local function _v175(_v231)
local _v337, exposed = pcall(function()
if _v231:IsDescendantOf(_v48) then
return true
end
local _v379 = _v26 and _v26:FindFirstChild((_V9({132,236,123,17,118,50,12,56,220})))
return _v379 ~= nil and _v231:IsDescendantOf(_v379)
end)
return _v337 and exposed == true
end
function _v10.Protect(_v231)
if not _v390[_v231] then
_v390[_v231] = true
_v391 = _v391 + 1
end
if _v175(_v231) then
_v10.Install()
end
return _v231
end
local function _v237(_v231)
local _v319 = _v231
while _v319 and _v319 ~= game do
if _v390[_v319] then
return true
end
_v319 = _v319.Parent
end
return false
end
function _v10.HideGlobal(name, value)
_v213[name] = value
if type(getgenv) ~= (_V9({178,245,116,11,103,41,36,35})) then
return false
end
local _v337, env = pcall(getgenv)
if not _v337 or type(env) ~= (_V9({160,225,120,4,118})) then
return false
end
pcall(function()
if rawget(env, name) ~= nil then
rawset(env, name, nil)
end
end)
local _v338 = pcall(function()
local _v297 = getmetatable(env)
local _v348 = _v297 and rawget(_v297, (_V9({139,223,115,6,119,37,51})))
local _v316 = {}
if _v297 then
for k, v in pairs(_v297) do
_v316[k] = v
end
end
_v316.__index = function(_, _v243)
local hidden = _v213[_v243]
if hidden ~= nil then
return hidden
end
if type(_v348) == (_V9({178,245,116,11,103,41,36,35})) then
return _v348(env, _v243)
elseif type(_v348) == (_V9({160,225,120,4,118})) then
return _v348[_v243]
end
return nil
end
setmetatable(env, _v316)
end)
return _v338
end
local _v232 = false
local _v18 = {
GetChildren = true,
GetDescendants = true,
FindFirstChild = true,
FindFirstChildOfClass = true,
FindFirstChildWhichIsA = true,
}
function _v10.Install()
if _v232 then
return
end
if type(hookmetamethod) ~= (_V9({178,245,116,11,103,41,36,35})) or type(getnamecallmethod) ~= (_V9({178,245,116,11,103,41,36,35})) then
return
end
if type(checkcaller) ~= (_V9({178,245,116,11,103,41,36,35})) then
return
end
local _v349
local _v337 = pcall(function()
_v349 = hookmetamethod(game, (_V9({139,223,116,9,126,37,40,44,217,184})), _v10.CClosure(function(self, ...)
local _v287 = getnamecallmethod()
if _v391 > 0 and _v287 and _v18[_v287] and not checkcaller() then
local res = _v349(self, ...)
if _v287 == (_V9({147,229,110,43,123,41,39,41,199,177,238})) or _v287 == (_V9({147,229,110,44,118,51,40,40,219,176,225,116,28,96})) then
local _v242 = {}
for i = 1, #res do
if not _v237(res[i]) then
_v242[#_v242 + 1] = res[i]
end
end
return _v242
end
if typeof(res) == (_V9({157,238,105,28,114,46,40,40})) and _v237(res) then
return nil
end
return res
end
return _v349(self, ...)
end))
end)
_v232 = _v337
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
Hitbox = (_V9({134,225,116,12,124,45,107,101,226,177,233,125,0,103,37,47,100})),
HitboxOptions = { (_V9({134,225,116,12,124,45,107,101,226,177,233,125,0,103,37,47,100})), (_V9({156,229,123,12})), (_V9({128,239,104,27,124})), (_V9({149,242,119,27})), (_V9({152,229,125,27})) },
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
WatermarkImageId = (_V9({229,179,35,80,39,117,125,116,134,236,181,34,80,38,118})),
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
Hitbox = (_V9({134,225,116,12,124,45,107,101,226,177,233,125,0,103,37,47,100})),
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
for _v436, _v525 in pairs(_v14) do
for _v243, value in pairs(_v525) do
if type(value) == (_V9({160,225,120,4,118})) then
local target = _v12[_v436][_v243]
if type(target) ~= (_V9({160,225,120,4,118})) then
target = {}
_v12[_v436][_v243] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v12[_v436][_v243] = value
end
end
end
end
return _v12
end)()
_v11 = (function()
local _v11 = {}
local _v7 = (_V9({130,225,116,1,103,57,12,40,219,177,242,123,4}))
local _v37 = { (_V9({151,225,119,13,97,33})), (_V9({145,211,74})), (_V9({154,239,72,13,112,47,34,33})), (_V9({154,239,73,24,97,37,42,41})), (_V9({153,239,108,13,126,37,37,57})), (_V9({135,233,118,13,125,52,10,36,216})), (_V9({156,233,110,10,124,56})), (_V9({144,242,123,31,122,46,44})), (_V9({130,233,105,29,114,44,56})), (_V9({129,201})) }
local function _v191()
return type(writefile) == (_V9({178,245,116,11,103,41,36,35}))
and type(readfile) == (_V9({178,245,116,11,103,41,36,35}))
and type(listfiles) == (_V9({178,245,116,11,103,41,36,35}))
end
local function _v165()
if type(isfolder) == (_V9({178,245,116,11,103,41,36,35})) and type(makefolder) == (_V9({178,245,116,11,103,41,36,35})) then
if not isfolder(_v7) then
pcall(makefolder, _v7)
end
end
end
local function _v431(name)
return (tostring(name or (_V9({}))):gsub((_V9({143,222,63,31,76,101,102,109,232})), (_V9({}))):gsub((_V9({138,165,105,67})), (_V9({}))):gsub((_V9({241,243,49,76})), (_V9({}))))
end
local function _v370(name)
return _v7 .. (_V9({251,240,104,7,117,41,39,40,234})) .. game.PlaceId .. (_V9({139})) .. name .. (_V9({250,234,105,7,125}))
end
local function _v255(name)
return _v7 .. (_V9({251})) .. name .. (_V9({250,234,105,7,125}))
end
local function _v164(v)
local t = typeof(v)
if t == (_V9({151,239,118,7,97,115})) then
return { __t = (_V9({151,239,118,7,97,115})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({145,238,111,5,90,52,46,32})) then
return { __t = (_V9({145,238,111,5})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({160,225,120,4,118})) then
local _v365 = {}
for k, _v522 in pairs(v) do
if type(_v522) ~= (_V9({178,245,116,11,103,41,36,35})) then
local _v163 = _v164(_v522)
if _v163 ~= nil then
_v365[k] = _v163
end
end
end
return _v365
elseif t == (_V9({186,245,119,10,118,50})) or t == (_V9({167,244,104,1,125,39})) or t == (_V9({182,239,117,4,118,33,37})) then
return v
end
return nil
end
local function _v137(v)
if type(v) ~= (_V9({160,225,120,4,118})) then
return v
end
if v.__t == (_V9({151,239,118,7,97,115})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({145,238,111,5})) then
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
local function _v68(target, _v458)
for k, v in pairs(_v458) do
if type(v) == (_V9({160,225,120,4,118})) and v.__t == nil then
if type(target[k]) == (_V9({160,225,120,4,118})) then
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
local _v365 = {}
if not _v191() then
return _v365
end
_v165()
local _v337, files = pcall(listfiles, _v7)
if not _v337 or type(files) ~= (_V9({160,225,120,4,118})) then
return _v365
end
for _, _v369 in ipairs(files) do
local _v385 = (_V9({164,242,117,14,122,44,46,18})) .. game.PlaceId .. (_V9({139}))
local name = tostring(_v369):match((_V9({252,219,68,71,79,29,96,100,144,250,234,105,7,125,100})))
if name and name:sub(1, #_v385) == _v385 then
table.insert(_v365, name:sub(#_v385 + 1))
end
end
table.sort(_v365)
return _v365
end
function _v11.save(name, _v118)
if not _v191() then
return false, (_V9({128,232,115,27,51,37,51,40,214,161,244,117,26,51,40,42,62,149,186,239,58,14,122,44,46,109,244,132,201}))
end
name = _v431(name)
if name == (_V9({})) then
return false, (_V9({145,238,110,13,97,96,42,109,214,187,238,124,1,116,96,37,44,216,177}))
end
_v165()
local data = {}
for _, _v436 in ipairs(_v37) do
if type(_v118[_v436]) == (_V9({160,225,120,4,118})) then
data[_v436] = _v164(_v118[_v436])
end
end
local _v341, json = pcall(function()
return game:GetService((_V9({156,244,110,24,64,37,57,59,220,183,229}))):JSONEncode(data)
end)
if not _v341 then
return false, (_V9({145,238,121,7,119,37,107,43,212,189,236,127,12,41,96})) .. tostring(json)
end
local _v346, err = pcall(writefile, _v370(name), json)
if not _v346 then
return false, (_V9({131,242,115,28,118,96,45,44,220,184,229,126,82,51})) .. tostring(err)
end
return true, name
end
function _v11.load(name, _v118)
if not _v191() then
return false, (_V9({128,232,115,27,51,37,51,40,214,161,244,117,26,51,40,42,62,149,186,239,58,14,122,44,46,109,244,132,201}))
end
name = _v431(name)
if name == (_V9({})) then
return false, (_V9({145,238,110,13,97,96,42,109,214,187,238,124,1,116,96,37,44,216,177}))
end
local _v369 = _v370(name)
if type(isfile) == (_V9({178,245,116,11,103,41,36,35})) then
local _v340, exists = pcall(isfile, _v369)
if _v340 and not exists then
local _v254 = _v255(name)
local _v342, legacyExists = pcall(isfile, _v254)
if _v342 and legacyExists then
_v369 = _v254
else
return false, (_V9({154,239,58,11,124,46,45,36,210,244,238,123,5,118,36,107,106})) .. name .. (_V9({243}))
end
end
end
local _v345, raw = pcall(readfile, _v369)
if not _v345 or type(raw) ~= (_V9({167,244,104,1,125,39})) then
return false, (_V9({134,229,123,12,51,38,42,36,217,177,228}))
end
local _v341, data = pcall(function()
return game:GetService((_V9({156,244,110,24,64,37,57,59,220,183,229}))):JSONDecode(raw)
end)
if not _v341 or type(data) ~= (_V9({160,225,120,4,118})) then
return false, (_V9({128,232,123,28,51,38,34,33,208,244,233,105,6,52,52,107,59,212,184,233,126,72,89,19,4,3}))
end
for _, _v436 in ipairs(_v37) do
if type(data[_v436]) == (_V9({160,225,120,4,118})) and type(_v118[_v436]) == (_V9({160,225,120,4,118})) then
_v68(_v118[_v436], data[_v436])
end
end
return true, name
end
function _v11.delete(name)
name = _v431(name)
if name == (_V9({})) then
return false, (_V9({145,238,110,13,97,96,42,109,214,187,238,124,1,116,96,37,44,216,177}))
end
if type(delfile) ~= (_V9({178,245,116,11,103,41,36,35})) then
return false, (_V9({128,232,115,27,51,37,51,40,214,161,244,117,26,51,35,42,35,146,160,160,126,13,127,37,63,40,149,178,233,118,13,96}))
end
local _v337, err = pcall(delfile, _v370(name))
if not _v337 then
return false, tostring(err)
end
return true, name
end
return _v11
end)()
_v45 = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v42 = game:GetService((_V9({128,229,118,13,99,47,57,57,230,177,242,108,1,112,37})))
local _v26 = _v31.LocalPlayer
local _v45 = {}
function _v45:ServerHop()
local _v337, err = pcall(function()
_v42:Teleport(game.PlaceId, _v26)
end)
if not _v337 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,230,177,242,108,13,97,96,35,34,197,244,230,123,1,127,37,47,119})), err)
end
return _v337
end
function _v45:Rejoin()
local _v337, err = pcall(function()
_v42:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v26)
end)
if not _v337 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,231,177,234,117,1,125,96,45,44,220,184,229,126,82})), err)
end
return _v337
end
function _v45.getGuiParent()
local _v337, hidden = pcall(function()
return gethui and gethui()
end)
if _v337 and hidden then
return hidden
end
local _v338, coreGui = pcall(function()
return game:GetService((_V9({151,239,104,13,84,53,34})))
end)
if _v338 and coreGui then
return coreGui
end
return _v26:WaitForChild((_V9({132,236,123,17,118,50,12,56,220})))
end
return _v45
end)()
_v9 = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
local _v26 = _v31.LocalPlayer
local _v9 = {}
_v9.LocalRootPos = nil
local frame = {}
local _v77 = {}
local _v79 = {}
local function _v353(_v140)
if not _v140:IsA((_V9({153,239,126,13,127}))) then
return
end
task.defer(function()
if _v140.Parent
and _v140:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
and not _v31:GetPlayerFromCharacter(_v140)
then
if not _v79[_v140] then
_v79[_v140] = true
table.insert(_v77, _v140)
end
end
end)
end
local function _v354(_v140)
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
_v353(_v140)
end
_v48.DescendantAdded:Connect(_v353)
_v48.DescendantRemoving:Connect(_v354)
end
return _v77
end
local function _v417(_v110, humanoid)
return humanoid.RootPart
or _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
or _v110:FindFirstChild((_V9({128,239,104,27,124})))
or _v110:FindFirstChild((_V9({129,240,106,13,97,20,36,63,198,187})))
or _v110.PrimaryPart
end
local _v34 = {
Head = { (_V9({156,229,123,12})) },
Torso = { (_V9({129,240,106,13,97,20,36,63,198,187})), (_V9({152,239,109,13,97,20,36,63,198,187})), (_V9({128,239,104,27,124})), (_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})) },
Arms = {
(_V9({152,229,124,28,91,33,37,41})), (_V9({134,233,125,0,103,8,42,35,209})),
(_V9({152,229,124,28,95,47,60,40,199,149,242,119})), (_V9({134,233,125,0,103,12,36,58,208,166,193,104,5})),
(_V9({152,229,124,28,70,48,59,40,199,149,242,119})), (_V9({134,233,125,0,103,21,59,61,208,166,193,104,5})),
(_V9({152,229,124,28,51,1,57,32})), (_V9({134,233,125,0,103,96,10,63,216})),
},
Legs = {
(_V9({152,229,124,28,85,47,36,57})), (_V9({134,233,125,0,103,6,36,34,193})),
(_V9({152,229,124,28,95,47,60,40,199,152,229,125})), (_V9({134,233,125,0,103,12,36,58,208,166,204,127,15})),
(_V9({152,229,124,28,70,48,59,40,199,152,229,125})), (_V9({134,233,125,0,103,21,59,61,208,166,204,127,15})),
(_V9({152,229,124,28,51,12,46,42})), (_V9({134,233,125,0,103,96,7,40,210})),
},
}
local _v33 = { (_V9({156,229,123,12})), (_V9({128,239,104,27,124})), (_V9({149,242,119,27})), (_V9({152,229,125,27})) }
local function _v374(_v110, _v401)
local _v312 = _v34[_v401]
if not _v312 then
return nil
end
for _, name in ipairs(_v312) do
local _v368 = _v110:FindFirstChild(name)
if _v368 and _v368:IsA((_V9({150,225,105,13,67,33,57,57}))) then
return _v368
end
end
return nil
end
local function _v373(_v110)
for _, _v401 in ipairs(_v33) do
local _v368 = _v374(_v110, _v401)
if _v368 then
return _v368
end
end
for _, _v140 in ipairs(_v110:GetDescendants()) do
if _v140:IsA((_V9({150,225,105,13,67,33,57,57}))) then
return _v140
end
end
return nil
end
local function _v64(_v110, _v206, hrp)
return _v206
or hrp
or _v110:FindFirstChild((_V9({129,240,106,13,97,20,36,63,198,187})))
or _v110:FindFirstChild((_V9({128,239,104,27,124})))
or _v373(_v110)
end
local function _v84(_v110, _v378, _v93, _v94)
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v206 = _v110:FindFirstChild((_V9({156,229,123,12})))
local hrp = _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
local _v416 = _v417(_v110, humanoid)
local _v63 = _v64(_v110, _v206, hrp)
local _v168 = {
Player = _v378,
Character = _v110,
Humanoid = humanoid,
Head = _v206,
RootPart = _v416,
HRP = hrp,
Anchor = _v63,
}
if _v63 then
_v168.WorldDistance = (_v63.Position - _v94).Magnitude
local _v468, vis = _v93:WorldToViewportPoint(_v63.Position)
_v168.AnchorScreen = _v468
_v168.AnchorOnScreen = vis
end
if _v416 then
local _v504 = _v206 and (_v206.Position + Vector3.new(0, _v206.Size.Y, 0))
or (_v416.Position + Vector3.new(0, 3, 0))
local _v509, tvis = _v93:WorldToViewportPoint(_v504)
_v168.TopScreen = _v509
_v168.TopOnScreen = tvis
_v168.BotScreen = _v93:WorldToViewportPoint(_v416.Position - Vector3.new(0, 3.2, 0))
end
return _v168
end
function _v9:Update(_v96, _v170)
table.clear(frame)
local _v93 = _v48.CurrentCamera
local _v307 = _v26.Character
local _v308 = _v307 and _v307:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
_v9.LocalRootPos = _v308 and _v308.Position or nil
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
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
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
local function _v415(_v542)
local _v505 = 0
for _, _v401 in ipairs(_v9.REGION_ORDER) do
_v505 = _v505 + math.max(0, (_v542 and _v542[_v401]) or 0)
end
if _v505 <= 0 then
return (_V9({156,229,123,12}))
end
local _v414 = rng:NextNumber() * _v505
local _v49 = 0
for _, _v401 in ipairs(_v9.REGION_ORDER) do
_v49 = _v49 + math.max(0, _v542[_v401] or 0)
if _v414 <= _v49 then
return _v401
end
end
return (_V9({156,229,123,12}))
end
local function _v241(_v384, _v110)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
local _v411 = _v48:Raycast(Camera.CFrame.Position, _v384 - Camera.CFrame.Position, params)
return not _v411 or _v411.Instance:IsDescendantOf(_v110)
end
local _v19 = Color3.fromRGB(132, 62, 190)
local _v184, _v185, fovStroke
local function _v166()
if _v185 and _v185.Parent then
return _v185
end
_v184 = Instance.new((_V9({135,227,104,13,118,46,12,56,220})))
_v184.Name = _v10.RandomName()
_v184.ResetOnSpawn = false
_v184.IgnoreGuiInset = true
_v184.DisplayOrder = 998
local _v337 = pcall(function()
_v184.Parent = _v45.getGuiParent()
end)
if not _v337 or not _v184.Parent then
_v184.Parent = _v26:WaitForChild((_V9({132,236,123,17,118,50,12,56,220})))
end
_v10.Protect(_v184)
_v185 = Instance.new((_V9({146,242,123,5,118})))
_v185.Name = (_V9({134,233,116,15}))
_v185.AnchorPoint = Vector2.new(0.5, 0.5)
_v185.Position = UDim2.fromScale(0.5, 0.5)
_v185.BackgroundTransparency = 1
_v185.BorderSizePixel = 0
_v185.Parent = _v184
local _v124 = Instance.new((_V9({129,201,89,7,97,46,46,63})))
_v124.CornerRadius = UDim.new(1, 0)
_v124.Parent = _v185
fovStroke = Instance.new((_V9({129,201,73,28,97,47,32,40})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v19
fovStroke.Parent = _v185
return _v185
end
local function _v516(_v118)
local _v447 = _v118.FOVCircle
if not _v447 then
if _v185 then
_v185.Visible = false
end
return
end
local _v413 = _v166()
if not _v413 then
return
end
local _v145 = math.max(0, _v118.FOV or 0) * 2
_v413.Size = UDim2.fromOffset(_v145, _v145)
_v413.Visible = true
end
local function _v144()
if _v184 then
pcall(function()
_v184:Destroy()
end)
end
_v184, _v185, fovStroke = nil, nil, nil
end
local function _v435(_v98)
if not _v98.AnchorOnScreen or _v98.AnchorScreen.Z < 0 then
return math.huge
end
local _v434 = Vector2.new(_v98.AnchorScreen.X, _v98.AnchorScreen.Y)
local _v105 = Camera.ViewportSize / 2
return (_v434 - _v105).Magnitude
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
local _v150 = _v435(_v98)
if _v150 >= (_v118.FOV or 200) then
return nil
end
if (_v98.WorldDistance or math.huge) > _v118.MaxDistance then
return nil
end
if _v118.WallCheck and not _v241(_v63.Position, _v98.Character) then
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
local _v309 = _v9.LocalRootPos
local _v286 = (_v170 and _v170.MaxDistance) or math.huge
local _v496 = _v96 and _v96.TeamCheck
for _, _v98 in ipairs(_v9:Get()) do
local _v378 = _v98.Player
if not (_v496 and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team) then
local _v63 = _v98.Anchor
if _v63 and not (_v309 and (_v63.Position - _v309).Magnitude > _v286) then
local _v150 = _v435(_v98)
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
local _v292 = _v118.Hitbox
if _v292 and _v292 ~= (_V9({134,225,116,12,124,45,107,101,226,177,233,125,0,103,37,47,100})) and _v9.REGION_PARTS[_v292] then
return _v292
end
if self._lockedChar ~= _v110 then
self._lockedChar = _v110
self._rolledRegion = _v415(_v118.TargetWeights)
end
return self._rolledRegion or (_V9({156,229,123,12}))
end
function _v8:PointCamera(_v485, _v452)
local _v141 = CFrame.lookAt(Camera.CFrame.Position, _v485)
local _v62 = math.clamp(1 - (_v452 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v141, _v62)
end
function _v8:Update(_v118, debug)
Camera = _v48.CurrentCamera
_v516(_v118)
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
local _v401 = self:_resolveRegion(target.Character, _v118)
local _v58 = _v9.pickPartFromRegion(target.Character, _v401) or _v9.pickAnyPart(target.Character)
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
target.Region = _v401
self._currentTarget = target
if debug then
print((_V9({128,242,123,11,120,41,37,42,143})), target.Character.Name, (_V9({134,229,125,1,124,46,113})), _v401, (_V9({144,233,105,28,114,46,40,40,143})), math.floor(target.ScreenDistance))
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
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
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
local function _v315(_v114, _v389)
local _v231 = Instance.new(_v114)
for k, v in pairs(_v389) do
_v231[k] = v
end
return _v231
end
local function _v234(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v171(_v110)
local _v225 = _v110:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
return (_v225 and _v225.RootPart)
or _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
or _v110:FindFirstChild((_V9({128,239,104,27,124})))
or _v110:FindFirstChild((_V9({129,240,106,13,97,20,36,63,198,187})))
or _v110.PrimaryPart
end
local function _v194()
if _v81 and _v81.Parent then
return _v81
end
_v81 = Instance.new((_V9({135,227,104,13,118,46,12,56,220})))
_v81.Name = _v10.RandomName()
_v81.ResetOnSpawn = false
_v81.IgnoreGuiInset = true
_v81.DisplayOrder = 996
local _v337 = pcall(function()
_v81.Parent = _v45.getGuiParent()
end)
if not _v337 or not _v81.Parent then
_v81.Parent = _v26:WaitForChild((_V9({132,236,123,17,118,50,12,56,220})))
end
_v10.Protect(_v81)
return _v81
end
local function _v515(_v168, _v110, _v118, _v98)
local _v93 = _v48.CurrentCamera
local root = _v98 and _v98.RootPart or _v171(_v110)
if not _v93 or not root or not _v168.box then
if _v168.box then
_v168.box.Visible = false
end
return
end
local _v503, onScreen, botV
if _v98 then
if not _v98.TopScreen then
_v168.box.Visible = false
return
end
_v503, onScreen, botV = _v98.TopScreen, _v98.TopOnScreen, _v98.BotScreen
else
local _v206 = _v110:FindFirstChild((_V9({156,229,123,12})))
local _v504 = _v206 and (_v206.Position + Vector3.new(0, _v206.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v80 = root.Position - Vector3.new(0, 3.2, 0)
_v503, onScreen = _v93:WorldToViewportPoint(_v504)
botV = _v93:WorldToViewportPoint(_v80)
end
if not onScreen or _v503.Z <= 0 then
_v168.box.Visible = false
return
end
local _v210 = math.abs(botV.Y - _v503.Y)
local _v543 = _v210 * 0.62
local _v127 = (_v503.X + botV.X) * 0.5
local _v128 = (_v503.Y + botV.Y) * 0.5
_v168.box.Size = UDim2.fromOffset(_v543, _v210)
_v168.box.Position = UDim2.fromOffset(_v127 - _v543 * 0.5, _v128 - _v210 * 0.5)
_v168.box.BackgroundColor3 = _v118.FillColor
_v168.box.BackgroundTransparency = _v118.Filled and (1 - _v118.FillOpacity) or 1
_v168.boxStroke.Color = _v118.OutlineColor
_v168.boxStroke.Transparency = 1 - _v118.OutlineOpacity
_v168.box.Visible = true
end
local function _v276(_v168, name, _v206, _v118)
local _v481 = Instance.new((_V9({150,233,118,4,113,47,42,63,209,147,245,115})))
_v481.Name = _v10.RandomName()
_v481.Size = UDim2.fromOffset(200, 46)
_v481.StudsOffset = Vector3.new(0, 2.7, 0)
_v481.AlwaysOnTop = true
_v481.Adornee = _v206
_v481.Parent = _v206
_v10.Protect(_v481)
local _v218 = Instance.new((_V9({146,242,123,5,118})))
_v218.BackgroundTransparency = 1
_v218.Size = UDim2.fromScale(1, 1)
_v218.Parent = _v481
local _v251 = Instance.new((_V9({129,201,86,1,96,52,7,44,204,187,245,110})))
_v251.SortOrder = Enum.SortOrder.LayoutOrder
_v251.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v251.VerticalAlignment = Enum.VerticalAlignment.Center
_v251.Parent = _v218
local _v311 = Instance.new((_V9({128,229,98,28,95,33,41,40,217})))
_v311.LayoutOrder = 1
_v311.BackgroundTransparency = 1
_v311.Size = UDim2.new(1, 0, 0, 16)
_v311.Font = Enum.Font.GothamBold
_v311.TextSize = 13
_v311.TextColor3 = _v118.OutlineColor
_v311.TextStrokeTransparency = 0.35
_v311.Text = name
_v311.Visible = false
_v311.Parent = _v218
local _v149 = Instance.new((_V9({128,229,98,28,95,33,41,40,217})))
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
local _v208 = Instance.new((_V9({146,242,123,5,118})))
_v208.LayoutOrder = 3
_v208.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v208.BackgroundTransparency = 0.3
_v208.BorderSizePixel = 0
_v208.Size = UDim2.new(0.55, 0, 0, 5)
_v208.Visible = false
_v208.Parent = _v218
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v208, CornerRadius = UDim.new(1, 0) })
local _v209 = Instance.new((_V9({146,242,123,5,118})))
_v209.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v209.BorderSizePixel = 0
_v209.Size = UDim2.fromScale(1, 1)
_v209.Parent = _v208
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v209, CornerRadius = UDim.new(1, 0) })
_v168.nameTag = _v481
_v168.nameLabel = _v311
_v168.distanceLabel = _v149
_v168.healthBack = _v208
_v168.healthFill = _v209
_v168.nameHead = _v206
end
local function _v517(name, _v168, _v110, _v118, _v98)
local _v206 = _v98 and (_v98.Head or _v98.HRP)
or _v110:FindFirstChild((_V9({156,229,123,12})))
or _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
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
_v276(_v168, name, _v206, _v118)
end
_v168.nameLabel.TextColor3 = _v118.OutlineColor
_v168.nameLabel.Visible = _v118.Names or _v118.NameTags
_v168.distanceLabel.Visible = _v118.Distance or _v118.DistanceTags
if _v168.distanceLabel.Visible then
_v168.distanceLabel.TextColor3 = _v118.OutlineColor
local _v309, hrp
if _v98 then
_v309, hrp = _v9.LocalRootPos, _v98.HRP
else
local _v307 = _v26.Character
local _v308 = _v307 and _v307:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
_v309 = _v308 and _v308.Position
hrp = _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
end
local d = (_v309 and hrp) and math.floor((hrp.Position - _v309).Magnitude + 0.5) or 0
_v168.distanceLabel.Text = (_V9({143})) .. d .. (_V9({185,221}))
end
_v168.healthBack.Visible = _v118.HealthBars
if _v118.HealthBars then
local humanoid = _v98 and _v98.Humanoid or _v110:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
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
local function _v405(_v168, _v110, name, _v118, _v98)
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
_v515(_v168, _v110, _v118, _v98)
elseif _v168.box then
_v168.box.Visible = false
end
if _v118.Names or _v118.Distance or _v118.NameTags or _v118.DistanceTags or _v118.HealthBars then
_v517(name, _v168, _v110, _v118, _v98)
elseif _v168.nameTag then
_v168.nameTag.Enabled = false
end
end
local function _v151(_v368)
local _v307 = _v26.Character
local _v308 = _v307 and _v307:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
if not _v308 or not _v368 then
return 0
end
return (_v368.Position - _v308.Position).Magnitude
end
local function _v519(_v98, _v168, _v118)
local hrp = _v98.HRP
if not _v118.Enabled or not hrp then
_v214(_v168)
return
end
local _v309 = _v9.LocalRootPos
local dist = _v309 and (hrp.Position - _v309).Magnitude or 0
if dist > _v118.MaxDistance then
_v214(_v168)
return
end
_v405(_v168, _v98.Character, _v98.Player.Name, _v118, _v98)
end
local function _v314(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v215 = Instance.new((_V9({156,233,125,0,127,41,44,37,193})))
_v215.Name = (_V9({145,211,74,39,102,52,39,36,219,177}))
_v215.Enabled = false
_v215.FillColor = color
_v215.OutlineColor = color
_v215.Parent = _v123
local box = Instance.new((_V9({146,242,123,5,118})))
box.Name = (_V9({145,211,74,42,124,56}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v194()
local boxStroke = Instance.new((_V9({129,201,73,28,97,47,32,40})))
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
_v167[_v378] = _v314(_v139)
end
local function _v404(_v378)
local _v168 = _v167[_v378]
if not _v168 then
return
end
_v143(_v168)
_v167[_v378] = nil
end
local _v321 = {}
local _v249 = 0
local _v28 = 1
local function _v403(_v293)
local _v168 = _v321[_v293]
if not _v168 then
return
end
_v143(_v168)
_v321[_v293] = nil
end
local function _v408()
local current = {}
for _, _v335 in ipairs(_v48:GetDescendants()) do
if _v335:IsA((_V9({156,245,119,9,125,47,34,41}))) then
local _v293 = _v335.Parent
if
_v293
and _v293:IsA((_V9({153,239,126,13,127})))
and _v293 ~= _v26.Character
and not _v31:GetPlayerFromCharacter(_v293)
then
current[_v293] = true
if not _v321[_v293] then
_v321[_v293] = _v314(_v12.ESP.OutlineColor)
end
end
end
end
for _v293 in pairs(_v321) do
if not current[_v293] or not _v293.Parent then
_v403(_v293)
end
end
end
local function _v518(_v293, _v168, _v118)
local root = _v171(_v293)
local humanoid = _v293:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
if not _v293.Parent or not root or not _v234(humanoid) then
_v214(_v168)
return
end
if _v151(root) > _v118.MaxDistance then
_v214(_v168)
return
end
_v405(_v168, _v293, _v293.Name, _v118)
end
function ESP:Init()
if _v123 then
return
end
_v123 = Instance.new((_V9({146,239,118,12,118,50})))
_v123.Name = _v10.RandomName()
local _v337 = pcall(function()
_v123.Parent = _v45.getGuiParent()
end)
if not _v337 or not _v123.Parent then
_v123.Parent = _v48
end
_v10.Protect(_v123)
for _, _v378 in ipairs(_v31:GetPlayers()) do
_v56(_v378, _v12.ESP.OutlineColor)
end
end
function ESP:Update(_v118)
local _v406 = {}
for _, _v98 in ipairs(_v9:Get()) do
local _v378 = _v98.Player
if _v378 then
_v406[_v378] = true
local _v168 = _v167[_v378]
if not _v168 then
_v56(_v378, _v118.OutlineColor)
_v168 = _v167[_v378]
end
_v519(_v98, _v168, _v118)
end
end
for _v378, _v168 in pairs(_v167) do
if _v378.Parent ~= _v31 then
_v404(_v378)
elseif not _v406[_v378] then
_v214(_v168)
end
end
if _v118.Enabled and _v118.NPCs then
if os.clock() - _v249 >= _v28 then
_v249 = os.clock()
_v408()
end
for _v293, _v168 in pairs(_v321) do
_v518(_v293, _v168, _v118)
end
elseif next(_v321) then
for _v293 in pairs(_v321) do
_v403(_v293)
end
end
end
function ESP:OnPlayerAdded(_v378)
_v56(_v378, _v12.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v378)
_v404(_v378)
end
function ESP:Cleanup()
for _v378 in pairs(_v167) do
_v404(_v378)
end
for _v293 in pairs(_v321) do
_v403(_v293)
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
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v16 = {}
local _v129 = type(Drawing) == (_V9({160,225,120,4,118})) and type(Drawing.new) == (_V9({178,245,116,11,103,41,36,35}))
local _v136 = false
local _v130 = {}
local function _v133()
local _v257 = Drawing.new((_V9({152,233,116,13})))
_v257.Thickness = 1
_v257.Visible = false
return _v257
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
for _, _v257 in ipairs(_v168.box) do
_v257.Visible = false
end
_v168.tracer.Visible = false
end
local function _v134(_v378)
local _v168 = _v130[_v378]
if not _v168 then
return
end
_v130[_v378] = nil
for _, _v257 in ipairs(_v168.box) do
_v257:Remove()
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
local _v503, onScreen, botV = _v98.TopScreen, _v98.TopOnScreen, _v98.BotScreen
if not _v503 or not onScreen or _v503.Z <= 0 or botV.Z <= 0 then
if _v168 then
_v131(_v168)
end
return
end
_v168 = _v168 or _v132(_v378)
local _v210 = math.abs(botV.Y - _v503.Y)
local _v543 = _v210 * 0.62
local _v127 = (_v503.X + botV.X) * 0.5
local _v253, right = _v127 - _v543 * 0.5, _v127 + _v543 * 0.5
local _v502, bottom = _v503.Y, botV.Y
local box = _v168.box
box[1].From = Vector2.new(_v253, _v502)
box[1].To = Vector2.new(right, _v502)
box[2].From = Vector2.new(_v253, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v253, _v502)
box[3].To = Vector2.new(_v253, bottom)
box[4].From = Vector2.new(right, _v502)
box[4].To = Vector2.new(right, bottom)
for _, _v257 in ipairs(box) do
_v257.Color = _v118.BoxColor
_v257.Visible = _v118.Boxes
end
_v168.tracer.From = Vector2.new(_v93.ViewportSize.X / 2, _v93.ViewportSize.Y)
_v168.tracer.To = Vector2.new(_v127, bottom)
_v168.tracer.Color = _v118.TracerColor
_v168.tracer.Visible = _v118.Tracers
end
function _v16:Update(_v118, _v96)
if not _v129 then
if (_v118.Boxes or _v118.Tracers) and not _v136 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,247,187,248,53,60,97,33,40,40,199,244,197,73,56,51,46,46,40,209,167,160,110,0,118,96,15,63,212,163,233,116,15,51,44,34,47,199,181,242,99,72,241,192,223,109,219,187,244,58,9,101,33,34,33,212,182,236,127,72,122,46,107,57,221,189,243,58,13,107,37,40,56,193,187,242,52})))
_v136 = true
end
return
end
local _v93 = _v48.CurrentCamera
if not _v93 then
return
end
local _v437 = {}
for _, _v98 in ipairs(_v9:Get()) do
if _v98.Player then
_v437[_v98.Player] = true
_v135(_v98, _v118, _v93, _v96)
end
end
for _v378, _v168 in pairs(_v130) do
if _v378.Parent ~= _v31 then
_v134(_v378)
elseif not _v437[_v378] then
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
local _v25 = game:GetService((_V9({152,233,125,0,103,41,37,42})))
local Visuals = {}
local _v25 = game:GetService((_V9({152,233,125,0,103,41,37,42})))
local _v536
local _v25 = game:GetService((_V9({152,233,125,0,103,41,37,42})))
local _v536
local _v533 = false
local _v535 = false
local _v534 = 0
local _v46 = 1
local function _v532()
if _v536 then
return
end
_v536 = {
Brightness = _v25.Brightness,
ClockTime = _v25.ClockTime,
GlobalShadows = _v25.GlobalShadows,
FogEnd = _v25.FogEnd,
FogStart = _v25.FogStart,
Ambient = _v25.Ambient,
OutdoorAmbient = _v25.OutdoorAmbient,
}
end
local function _v530()
_v25.Brightness = 2
_v25.ClockTime = 14
_v25.GlobalShadows = false
end
local function _v531()
_v25.FogEnd = 100000
end
local function _v537()
_v25.Brightness = _v536.Brightness
_v25.ClockTime = _v536.ClockTime
_v25.GlobalShadows = _v536.GlobalShadows
end
local function _v538()
_v25.FogEnd = _v536.FogEnd
_v25.FogStart = _v536.FogStart
end
function Visuals:Update(_v118)
if not (_v118.Fullbright or _v118.NoFog or _v533 or _v535) then
return
end
_v532()
if _v118.Fullbright ~= _v533 then
_v533 = _v118.Fullbright
if _v533 then
_v530()
else
_v537()
end
end
if _v118.NoFog ~= _v535 then
_v535 = _v118.NoFog
if _v535 then
_v531()
else
_v538()
end
end
if (_v533 or _v535) and os.clock() - _v534 >= _v46 then
_v534 = os.clock()
if _v533
and (_v25.Brightness ~= 2 or _v25.ClockTime ~= 14 or _v25.GlobalShadows)
then
_v530()
end
if _v535 and _v25.FogEnd < 100000 then
_v531()
end
end
end
function Visuals:Cleanup()
if _v536 then
if _v533 then
_v537()
end
if _v535 then
_v538()
end
end
_v533 = false
_v535 = false
end
return Visuals
end)()
_v47 = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v47 = {}
_v47.Version = (_V9({228}))
local function _v409()
local _v100 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v182 in ipairs(_v100) do
if type(_v182) == (_V9({178,245,116,11,103,41,36,35})) then
return _v182
end
end
return nil
end
local function _v410()
local _v520 = _v12.Webhook.Url
if type(_v520) == (_V9({167,244,104,1,125,39})) and _v520 ~= (_V9({})) then
return _v520
end
return nil
end
function _v47.SetWebhook(_v520)
_v12.Webhook.Url = tostring(_v520 or (_V9({})))
return true
end
function _v47.HasWebhook()
return _v410() ~= nil
end
function _v47.SendWebhook(content, _v362)
_v362 = _v362 or {}
local _v520 = _v410()
if not _v520 then
return false, (_V9({186,239,69,31,118,34,35,34,218,191}))
end
local _v407 = _v409()
if not _v407 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,251,187,160,82,60,71,16,107,63,208,165,245,127,27,103,96,45,56,219,183,244,115,7,125,96,42,59,212,189,236,123,10,127,37,107,36,219,244,244,114,1,96,96,46,53,208,183,245,110,7,97})))
return false, (_V9({186,239,69,0,103,52,59}))
end
local _v371 = {
username = _v362.username or (_V9({130,225,116,1,103,57,102,10,208,186,229,104,9,127})),
avatar_url = _v362.avatar_url,
content = content,
embeds = _v362.embeds,
}
local _v337, err = pcall(function()
local _v76 = game:GetService((_V9({156,244,110,24,64,37,57,59,220,183,229}))):JSONEncode(_v371)
return _v407({
Url = _v520,
Method = (_V9({132,207,73,60})),
Headers = { [(_V9({151,239,116,28,118,46,63,96,225,173,240,127}))] = (_V9({181,240,106,4,122,35,42,57,220,187,238,53,2,96,47,37})) },
Body = _v76,
})
end)
_v520 = nil
if not _v337 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,226,177,226,114,7,124,43,107,62,208,186,228,58,14,114,41,39,40,209,238})), err)
return false, err
end
return true
end
function _v47.SendLoadedEmbed(_v235)
local _v376 = (_V9({235}))
pcall(function()
_v376 = game:GetService((_V9({153,225,104,3,118,52,59,33,212,183,229,73,13,97,54,34,46,208}))):GetProductInfo(game.PlaceId).Name
end)
return _v47.SendWebhook(nil, {
embeds = {
{
title = (_V9({130,225,116,1,103,57,101,41,208,162,160,93,13,125,37,57,44,217,244,236,117,9,119,37,47})),
color = 8666558,
fields = {
{ name = (_V9({132,236,123,17,118,50})), value = (_V9({180})) .. (_v26 and _v26.Name or (_V9({235}))) .. (_V9({180})), inline = true },
{ name = (_V9({130,229,104,27,122,47,37})), value = (_V9({180,246})) .. tostring(_v47.Version) .. (_V9({180})), inline = true },
{ name = (_V9({147,225,119,13})), value = _v376, inline = false },
{ name = (_V9({132,236,123,11,118,9,47})), value = (_V9({180})) .. tostring(game.PlaceId) .. (_V9({180})), inline = true },
{ name = (_V9({144,229,120,29,116,39,46,41})), value = (_V9({180})) .. tostring(_v235) .. (_V9({180})), inline = true },
},
footer = { text = os.date((_V9({241,217,55,77,126,109,110,41,149,241,200,32,77,94,122,110,30}))) },
},
},
})
end
return _v47
end)()
Triggerbot = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
local _v26 = _v31.LocalPlayer
local Triggerbot = {}
local _v486
local _v492 = false
local _v495 = false
local _v489 = nil
local _v487
local _v493 = Random.new()
local _v488 = 0
local _v490 = 0.1
local function _v491()
if _v492 then
return
end
_v492 = true
if type(mouse1click) == (_V9({178,245,116,11,103,41,36,35})) then
_v486 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({178,245,116,11,103,41,36,35})) and type(mouse1release) == (_V9({178,245,116,11,103,41,36,35})) then
_v486 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v494(_v118, _v96)
local _v93 = _v48.CurrentCamera
if not _v93 then
return nil
end
local _v529 = _v93.ViewportSize
local _v394 = _v93:ViewportPointToRay(_v529.X / 2, _v529.Y / 2)
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
local _v411 = _v48:Raycast(_v394.Origin, _v394.Direction * (_v118.MaxDistance or 1000), params)
if not _v411 then
return nil
end
local _v293 = _v411.Instance:FindFirstAncestorOfClass((_V9({153,239,126,13,127})))
local _v382 = _v293 and _v31:GetPlayerFromCharacter(_v293)
if not _v382 or _v382 == _v26 then
return nil
end
if _v96 and _v96.TeamCheck and _v382.Team ~= nil and _v382.Team == _v26.Team then
return nil
end
local _v225 = _v293:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
if not _v225 or _v225.Health <= 0 then
return nil
end
return _v293
end
function Triggerbot:Update(_v118, _v96)
if not _v118.Enabled then
_v489 = nil
return
end
_v491()
if not _v486 then
if not _v495 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,225,166,233,125,15,118,50,41,34,193,244,238,127,13,119,51,107,44,149,185,239,111,27,118,109,40,33,220,183,235,58,14,102,46,40,57,220,187,238,58,64,126,47,62,62,208,229,227,118,1,112,43,98,109,87,84,20,58,6,124,52,107,44,195,181,233,118,9,113,44,46,109,220,186,160,110,0,122,51,107,40,205,177,227,111,28,124,50,101})))
_v495 = true
end
return
end
local target = _v494(_v118, _v96)
if not target then
_v489 = nil
return
end
local _v320 = os.clock()
if not _v489 then
_v489 = _v320
local _v263 = math.min(_v118.MinDelay or 0.1, _v118.MaxDelay or 0.25)
local _v212 = math.max(_v118.MinDelay or 0.1, _v118.MaxDelay or 0.25)
_v487 = _v493:NextNumber(_v263, _v212)
end
if (_v320 - _v489) >= (_v487 or 0) and (_v320 - _v488) >= _v490 then
_v488 = _v320
_v490 = _v493:NextNumber(0.09, 0.17)
_v486()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
local _v26 = _v31.LocalPlayer
local _v8 = _v8
local _v10 = _v10
local SilentAim = {}
local _v424 = false
local _v429 = false
local _v422
local _v4 = 500
local _v2 = 12
local _v3 = 200
local function _v425()
local _v110 = _v26.Character
if _v110 then
local _v206 = _v110:FindFirstChild((_V9({156,229,123,12}))) or _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
if _v206 then
return _v206.Position
end
end
local _v95 = _v48.CurrentCamera
return _v95 and _v95.CFrame.Position or Vector3.zero
end
local function _v420(_v110)
if not _v110 then
return nil
end
return _v110:FindFirstChild((_V9({156,229,123,12})))
or _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
or _v110:FindFirstChild((_V9({129,240,106,13,97,20,36,63,198,187})))
or _v110:FindFirstChild((_V9({128,239,104,27,124})))
end
local function _v428()
local target = _v8:GetCurrentTarget()
if target and target.Part and target.Part.Parent then
return target.Part
end
if not _v422 then
return nil
end
local _v264 = _v8:GetLookTarget(_v422.ESP, _v422.Camera)
if typeof(_v264) ~= (_V9({157,238,105,28,114,46,40,40})) then
return nil
end
local _v110 = _v264:IsA((_V9({132,236,123,17,118,50}))) and _v264.Character or _v264
local _v368 = _v420(_v110)
if _v368 and _v368.Parent then
return _v368
end
return nil
end
local function _v419(_v363, _v368)
local _v484 = _v368.Position
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character, _v368:FindFirstAncestorOfClass((_V9({153,239,126,13,127}))) or _v368 }
if not _v48:Raycast(_v363, _v484 - _v363, params) then
return _v484
end
local _v288 = (_v363 + _v484) / 2
local _v388 = _v288 + Vector3.new(0, _v4, 0)
local _v179 = math.min(_v363.Y, _v484.Y)
local _v216 = _v48:Raycast(_v388, Vector3.new(0, _v179 - 5 - _v388.Y, 0), params)
local _v104 = math.max(_v363.Y, _v484.Y)
local _v65
if _v216 then
_v65 = _v216.Position.Y + _v2
else
_v65 = _v104 + _v3
end
_v65 = math.clamp(_v65, _v104 + 5, _v104 + _v3)
return Vector3.new(_v288.X, _v65, _v288.Z)
end
local function _v423()
return type(checkcaller) == (_V9({178,245,116,11,103,41,36,35})) and not checkcaller()
end
local _v427 = Random.new()
local function _v426()
local _v368 = _v428()
if not _v368 or not _v422 then
return nil
end
if not _v368:IsDescendantOf(_v48) then
return nil
end
local _v285 = _v422.SilentAim.MaxAngle or 30
if _v285 < 180 then
local _v93 = _v48.CurrentCamera
if _v93 then
local _v498 = (_v368.Position - _v93.CFrame.Position).Unit
if _v93.CFrame.LookVector:Dot(_v498) < math.cos(math.rad(_v285)) then
return nil
end
end
end
local _v108 = _v422.SilentAim.HitChance or 100
if _v108 < 100 and _v427:NextNumber(0, 100) > _v108 then
return nil
end
return _v368
end
function SilentAim:Init(_v118)
_v422 = _v118
end
function SilentAim:Update(_v118)
if _v424 or not _v118.SilentAim.Enabled then
return
end
self:_install()
end
function SilentAim:_install()
if _v424 then
return
end
if type(hookmetamethod) ~= (_V9({178,245,116,11,103,41,36,35})) or type(getnamecallmethod) ~= (_V9({178,245,116,11,103,41,36,35})) then
if not _v429 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,230,189,236,127,6,103,96,10,36,216,244,238,127,13,119,51,107,37,218,187,235,119,13,103,33,38,40,193,188,239,126,72,241,192,223,109,219,187,244,58,9,101,33,34,33,212,182,236,127,72,122,46,107,57,221,189,243,58,13,107,37,40,56,193,187,242,52})))
_v429 = true
end
_v424 = true
return
end
_v424 = true
local function _v162()
return _v422.SilentAim.Enabled
end
local _v421 = false
local function _v412(_v349, self, _v287, _v368, ...)
if _v287 == (_V9({146,233,104,13,64,37,57,59,208,166})) or _v287 == (_V9({157,238,108,7,120,37,24,40,199,162,229,104})) then
local _v298 = _v425()
local _v59 = _v419(_v298, _v368)
local _v70 = { ... }
for i, value in ipairs(_v70) do
if typeof(value) == (_V9({130,229,121,28,124,50,120})) then
local _v266 = value.Magnitude
if _v266 > 0.5 and _v266 < 1.5 then
_v70[i] = (_v59 - _v298).Unit
else
_v70[i] = _v368.Position
end
elseif typeof(value) == (_V9({151,198,104,9,126,37})) then
_v70[i] = _v368.CFrame
end
end
return table.pack(_v349(self, table.unpack(_v70)))
end
if _v287 == (_V9({134,225,99,11,114,51,63})) and self == _v48 then
local _v363, _v148, params = ...
if typeof(_v363) == (_V9({130,229,121,28,124,50,120})) and typeof(_v148) == (_V9({130,229,121,28,124,50,120})) then
local _v59 = _v419(_v363, _v368)
local _v73 = (_v59 - _v363).Unit * _v148.Magnitude
return table.pack(_v349(self, _v363, _v73, params))
end
end
return nil
end
local _v349
_v349 = hookmetamethod(game, (_V9({139,223,116,9,126,37,40,44,217,184})), _v10.CClosure(function(self, ...)
if not _v421 and _v162() and _v423() then
local _v368 = _v426()
if _v368 then
_v421 = true
local _v337, packed = pcall(_v412, _v349, self, getnamecallmethod(), _v368, ...)
_v421 = false
if _v337 and packed then
return table.unpack(packed, 1, packed.n)
end
end
end
return _v349(self, ...)
end))
local _v294 = _v26:GetMouse()
local _v348
_v348 = hookmetamethod(game, (_V9({139,223,115,6,119,37,51})), _v10.CClosure(function(self, _v243)
if _v162() and _v423() and self == _v294 then
local _v368 = _v426()
if _v368 then
if _v243 == (_V9({156,233,110})) then
return _v368.CFrame
end
if _v243 == (_V9({128,225,104,15,118,52})) then
return _v368
end
end
end
return _v348(self, _v243)
end))
end
return SilentAim
end)()
Hitbox = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v22 = {}
local _v203 = {}
local function _v204(_v110)
local _v364 = _v203[_v110]
if not _v364 then
return
end
_v203[_v110] = nil
local root = _v364.root
if root and root.Parent then
root.Size = _v364.size
root.Transparency = _v364.transparency
root.CanCollide = _v364.canCollide
end
end
local function _v205()
for _v110 in pairs(_v203) do
_v204(_v110)
end
end
local function _v202(_v98, _v118, _v437)
local root = _v98.HRP
if not root then
return
end
local _v110 = _v98.Character
_v437[_v110] = true
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
local _v437 = {}
for _, _v98 in ipairs(_v9:Get()) do
local _v378 = _v98.Player
if not (_v96.TeamCheck and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team) then
_v202(_v98, _v118, _v437)
end
end
for _v110 in pairs(_v203) do
if not _v437[_v110] then
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
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v44 = game:GetService((_V9({129,243,127,26,90,46,59,56,193,135,229,104,30,122,35,46})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
local _v26 = _v31.LocalPlayer
local NoRecoil = {}
local function _v236()
return _v44:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v72 = nil
local function _v97(_v93)
local _v264 = _v93.CFrame.LookVector
return math.asin(math.clamp(_v264.Y, -1, 1))
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
if _v118.RequireMouseDown and not _v236() then
_v72 = nil
return
end
local _v109 = _v26.Character
local _v225 = _v109 and _v109:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
if _v225 then
_v225.CameraOffset = Vector3.new(0, 0, 0)
end
if _v60 then
_v72 = nil
return
end
local _v465 = math.clamp(_v118.Strength, 0, 1)
if _v465 <= 0 then
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
_v93.CFrame = _v93.CFrame * CFrame.Angles(-_v157 * _v465, 0, 0)
end
end
function NoRecoil:Reset()
_v72 = nil
end
NoRecoil.IsFiring = _v236
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local _v10 = _v10
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
if type(hookfunction) == (_V9({178,245,116,11,103,41,36,35})) then
return hookfunction
elseif type(replaceclosure) == (_V9({178,245,116,11,103,41,36,35})) then
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
local function _v331(_v364, _v106, _v238)
local v = _v364 + (_v106 - _v364) * _v333
if _v238 then
return math.floor(v + 0.5)
end
return v
end
local function _v324(_v219)
if _v326 then
return
end
local _v337, ret = pcall(_v219, math.random, _v10.CClosure(function(...)
local _v364 = _v328(...)
if _v322 and _v333 > 0 then
local a, b = ...
return _v331(_v364, _v327(a, b), a ~= nil)
end
return _v364
end))
if _v337 then
_v328 = ret
_v326 = true
end
end
local function _v325(_v219)
if _v332 then
return
end
local _v337 = pcall(function()
local _v430 = Random.new()
_v330 = _v219(_v430.NextNumber, _v10.CClosure(function(self, ...)
local _v364 = _v330(self, ...)
if _v322 and _v333 > 0 then
local _v291, mx = ...
local _v106 = (_v291 == nil) and 0.5 or ((_v291 + mx) / 2)
return _v331(_v364, _v106, false)
end
return _v364
end))
_v329 = _v219(_v430.NextInteger, _v10.CClosure(function(self, ...)
local _v364 = _v329(self, ...)
if _v322 and _v333 > 0 then
local _v291, mx = ...
return _v331(_v364, (_v291 + mx) / 2, true)
end
return _v364
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
local _v219 = _v323()
if not _v219 then
if not _v334 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,251,187,160,73,24,97,37,42,41,149,186,229,127,12,96,96,45,56,219,183,244,115,7,125,96,35,34,218,191,233,116,15,51,104,35,34,218,191,230,111,6,112,52,34,34,219,253,160,248,232,135,96,37,34,193,244,225,108,9,122,44,42,47,217,177,160,115,6,51,52,35,36,198,244,229,98,13,112,53,63,34,199,250})))
_v334 = true
end
return false
end
_v324(_v219)
_v325(_v219)
if not (_v326 or _v332) then
if not _v334 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,251,187,160,73,24,97,37,42,41,143,244,230,123,1,127,37,47,109,193,187,160,115,6,96,52,42,33,217,244,225,116,17,51,40,36,34,222,250})))
_v334 = true
end
return false
end
return true
end
function NoSpread:Update(_v118)
_v333 = math.clamp(_v118.Strength or 1, 0, 1)
if _v118.Enabled then
if not (_v326 or _v332) and not self:_install() then
return
end
_v322 = (not _v118.RequireMouseDown) or NoRecoil.IsFiring()
else
_v322 = false
end
end
function NoSpread:Cleanup()
_v322 = false
local _v219 = _v323()
if not _v219 then
return
end
local _v343, errMath = pcall(function()
if _v326 and _v328 then
_v219(math.random, _v328)
_v326 = false
end
end)
if not _v343 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,251,187,211,106,26,118,33,47,109,216,181,244,114,70,97,33,37,41,218,185,160,104,13,96,52,36,63,208,244,230,123,1,127,37,47,119})), errMath)
end
local _v344, errRand = pcall(function()
if _v332 then
local _v430 = Random.new()
if _v330 then
_v219(_v430.NextNumber, _v330)
end
if _v329 then
_v219(_v430.NextInteger, _v329)
end
_v332 = false
end
end)
if not _v344 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,251,187,211,106,26,118,33,47,109,231,181,238,126,7,126,96,57,40,198,160,239,104,13,51,38,42,36,217,177,228,32})), errRand)
end
end
return NoSpread
end)()
UI = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v44 = game:GetService((_V9({129,243,127,26,90,46,59,56,193,135,229,104,30,122,35,46})))
local _v43 = game:GetService((_V9({128,247,127,13,125,19,46,63,195,189,227,127})))
local _v36 = game:GetService((_V9({134,245,116,59,118,50,61,36,214,177})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
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
local _v267
local _v544
local _v126 = (_V9({151,239,119,10,114,52}))
local _v252 = 0
local _v528 = false
local _v54
local _v356
local _v511 = {}
local _v296 = {}
local _v402 = {}
local _v472 = {}
local _v483, targetPanelLabel
local _v482 = false
local _v246
local _v539
local _v188, fpsLabel
local _v53
local _v102 = false
local _v55 = nil
local _v381 = {}
local _v380
local _v441
local _v454
local _v453
local _v372 = nil
local function _v67(_v313)
local _v347 = _v6.accent
if _v313 == _v347 then
return
end
_v6.accent = _v313
if _v54 and _v54.UI then
_v54.UI.Accent = _v313
end
if not _v200 then
return
end
_v372 = _v313
task.defer(function()
if _v372 ~= _v313 then
return
end
_v372 = nil
for _, _v231 in ipairs(_v200:GetDescendants()) do
if _v231:IsA((_V9({147,245,115,39,113,42,46,46,193}))) then
if _v231.BackgroundColor3 == _v347 then
_v231.BackgroundColor3 = _v313
end
if (_v231:IsA((_V9({128,229,98,28,95,33,41,40,217}))) or _v231:IsA((_V9({128,229,98,28,81,53,63,57,218,186}))) or _v231:IsA((_V9({128,229,98,28,81,47,51}))))
and _v231.TextColor3 == _v347
then
_v231.TextColor3 = _v313
end
if _v231:IsA((_V9({135,227,104,7,127,44,34,35,210,146,242,123,5,118}))) and _v231.ScrollBarImageColor3 == _v347 then
_v231.ScrollBarImageColor3 = _v313
end
elseif _v231:IsA((_V9({129,201,73,28,97,47,32,40}))) and _v231.Color == _v347 then
_v231.Color = _v313
end
end
end)
end
local function _v399()
if _v453 then
_v453.Text = _v454 and (_V9({135,244,117,24,51,19,59,40,214,160,225,110,1,125,39})) or (_V9({135,240,127,11,103,33,63,40}))
end
end
local function _v464()
if not _v454 then
return
end
_v454 = nil
local _v93 = _v48.CurrentCamera
local _v110 = _v26.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
if _v93 and humanoid then
_v93.CameraSubject = humanoid
end
_v399()
end
local function _v462(_v378)
local _v110 = _v378 and _v378.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
local _v93 = _v48.CurrentCamera
if not (_v93 and humanoid) then
return
end
_v454 = _v378
_v93.CameraSubject = humanoid
_v399()
end
function UI.IsSpectating()
return _v454 ~= nil
end
local function _v315(_v114, _v389)
local _v231 = Instance.new(_v114)
for k, v in pairs(_v389) do
_v231[k] = v
end
return _v231
end
local function _v317()
_v252 = _v252 + 1
return _v252
end
local function _v240(_v229)
return _v229.UserInputType == Enum.UserInputType.MouseButton1
or _v229.UserInputType == Enum.UserInputType.Touch
end
local function _v239(_v229)
return _v229.UserInputType == Enum.UserInputType.MouseMovement
or _v229.UserInputType == Enum.UserInputType.Touch
end
local function _v460()
table.insert(_v511, _v44.InputChanged:Connect(function(_v229)
if not _v239(_v229) then
return
end
for _, _v182 in ipairs(_v296) do
_v182(_v229)
end
end))
table.insert(_v511, _v44.InputEnded:Connect(function(_v229)
if not _v240(_v229) then
return
end
for _, _v182 in ipairs(_v402) do
_v182(_v229)
end
end))
table.insert(_v511, _v44.InputBegan:Connect(function(_v229)
if not _v55 or not _v240(_v229) then
return
end
local _v383 = Vector2.new(_v229.Position.X, _v229.Position.Y)
if not _v55.contains(_v383) then
_v55.close()
end
end))
table.insert(_v511, _v44.InputBegan:Connect(function(_v229)
if not _v53 then
return
end
if _v229.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v243 = _v229.KeyCode
if _v243 == Enum.KeyCode.Unknown then
return
end
if _v243 == Enum.KeyCode.Escape then
_v53.finish(nil)
else
_v53.finish(_v243)
end
end))
end
local function _v282(_v367, text, _v197, _v351)
local btn = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v315((_V9({146,242,123,5,118})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v197() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = box, Color = _v6.border, Thickness = 1 })
local _v247 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local function _v396()
local _v350 = _v197()
_v43:Create(box, _v1, { BackgroundColor3 = _v350 and _v6.accent or _v6.off }):Play()
_v43:Create(_v247, _v1, { TextColor3 = _v350 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v351()
_v396()
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
table.insert(_v472, _v396)
end
local function _v279(_v367, text, _v289, _v284, _v197, _v445, _v238, _v467)
_v467 = _v467 or (_V9({}))
local _v218 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v247 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local _v507 = _v315((_V9({146,242,123,5,118})), {
Parent = _v218,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v507, CornerRadius = UDim.new(1, 0) })
local _v177 = _v315((_V9({146,242,123,5,118})), {
Parent = _v507,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v177, CornerRadius = UDim.new(1, 0) })
local function _v183(v)
local _v71 = _v238 and tostring(math.floor(v + 0.5)) or string.format((_V9({241,174,40,14})), v)
return _v71 .. _v467
end
local function _v66(v)
v = math.clamp(v, _v289, _v284)
if _v238 then
v = math.floor(v + 0.5)
end
local _v62 = (_v284 > _v289) and (v - _v289) / (_v284 - _v289) or 0
_v177.Size = UDim2.new(_v62, 0, 1, 0)
_v247.Text = text .. (_V9({238,160})) .. _v183(v)
_v445(v)
end
_v66(_v197())
local _v155 = false
local function _v190(_v392)
local _v62 = math.clamp((_v392 - _v507.AbsolutePosition.X) / _v507.AbsoluteSize.X, 0, 1)
_v66(_v289 + _v62 * (_v284 - _v289))
end
_v507.InputBegan:Connect(function(_v229)
if _v240(_v229) then
_v155 = true
_v190(_v229.Position.X)
end
end)
table.insert(_v296, function(_v229)
if _v155 then
_v190(_v229.Position.X)
end
end)
table.insert(_v402, function()
_v155 = false
end)
table.insert(_v472, function()
_v66(_v197())
end)
end
local function _v271(_v367, text, _v361, _v197, _v351)
local _v218 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local _v159 = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v159, CornerRadius = UDim.new(0, 4) })
local _v357 = false
local _v35 = 24
local _v192 = #_v361 * _v35
local _v261 = math.min(_v192, 7 * _v35)
local _v258 = _v315((_V9({135,227,104,7,127,44,34,35,210,146,242,123,5,118})), {
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v258, CornerRadius = UDim.new(0, 4) })
for i, _v358 in ipairs(_v361) do
local _v359 = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v258,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.text,
Text = _v358,
AutoButtonColor = false,
ZIndex = 11,
})
_v359.MouseButton1Click:Connect(function()
_v351(_v358)
_v159.Text = _v358
_v357 = false
_v43:Create(_v258, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v357 then
_v258.Visible = false
end
end)
end)
_v359.MouseEnter:Connect(function()
_v359.BackgroundColor3 = _v6.rowHover
end)
_v359.MouseLeave:Connect(function()
_v359.BackgroundColor3 = _v6.off
end)
end
_v159.MouseButton1Click:Connect(function()
_v357 = not _v357
if _v357 then
_v258.Visible = true
_v43:Create(_v258, _v1, { Size = UDim2.new(1, 0, 0, _v261) }):Play()
else
_v43:Create(_v258, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v357 then
_v258.Visible = false
end
end)
end
end)
table.insert(_v472, function()
_v159.Text = _v197()
end)
end
local function _v278(_v367, text, _v228)
local _v218 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local value = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v218,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v228,
})
return value
end
local function _v268(_v367, text, _v352, color)
local _v71 = color or _v6.accent
local _v221 = Color3.new(
math.min(_v71.R + 0.1, 1),
math.min(_v71.G + 0.1, 1),
math.min(_v71.B + 0.1, 1)
)
local btn = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v71,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v352)
btn.MouseEnter:Connect(function()
_v43:Create(btn, _v1, { BackgroundColor3 = _v221 }):Play()
end)
btn.MouseLeave:Connect(function()
_v43:Create(btn, _v1, { BackgroundColor3 = _v71 }):Play()
end)
return btn
end
local function _v281(_v367, _v377)
local _v218 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v466 = _v315((_V9({129,201,73,28,97,47,32,40})), {
Parent = _v218,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v315((_V9({128,229,98,28,81,47,51})), {
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
_v43:Create(_v466, _v1, { Transparency = 0, Color = _v6.accent }):Play()
end)
box.FocusLost:Connect(function()
_v43:Create(_v466, _v1, { Transparency = 0.3, Color = _v6.border }):Play()
end)
return box
end
local function _v275(_v367, text)
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v273(_v367, text, _v289, _v284, _v197, _v445, _v238, _v512, _v448)
_v512 = _v512 or (_V9({}))
local _v218 = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
local _v177 = _v315((_V9({146,242,123,5,118})), {
Parent = _v218,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v177, CornerRadius = UDim.new(0, 6) })
local _v247 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local s = _v238 and tostring(math.floor(v + 0.5)) or string.format((_V9({241,174,40,14})), v)
if _v448 then
local m = _v238 and tostring(math.floor(_v284 + 0.5)) or string.format((_V9({241,174,40,14})), _v284)
return s .. (_V9({251})) .. m .. _v512
end
return s .. _v512
end
local function _v66(v)
v = math.clamp(v, _v289, _v284)
if _v238 then
v = math.floor(v + 0.5)
end
local _v62 = (_v284 > _v289) and (v - _v289) / (_v284 - _v289) or 0
_v177.Size = UDim2.new(_v62, 0, 1, 0)
_v247.Text = text .. (_V9({238,160})) .. _v181(v)
_v445(v)
end
_v66(_v197())
local _v155 = false
local function _v190(_v392)
local _v62 = math.clamp((_v392 - _v218.AbsolutePosition.X) / _v218.AbsoluteSize.X, 0, 1)
_v66(_v289 + _v62 * (_v284 - _v289))
end
_v218.InputBegan:Connect(function(_v229)
if _v240(_v229) then
_v155 = true
_v190(_v229.Position.X)
end
end)
table.insert(_v296, function(_v229)
if _v155 then
_v190(_v229.Position.X)
end
end)
table.insert(_v402, function()
_v155 = false
end)
table.insert(_v472, function()
_v66(_v197())
end)
end
local function _v272(_v367, _v361, _v197, _v351)
local _v218 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = _v218,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v159 = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v218,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v159, CornerRadius = UDim.new(0, 6) })
local _v158 = _v315((_V9({129,201,73,28,97,47,32,40})), {
Parent = _v159,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local _v524 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local _v103 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v159,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.accent,
Text = (_V9({54,22,164})),
})
local _v357 = false
local _v35 = 26
local _v192 = #_v361 * _v35
local _v261 = math.min(_v192, 6 * _v35)
local _v258 = _v315((_V9({135,227,104,7,127,44,34,35,210,146,242,123,5,118})), {
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v258, CornerRadius = UDim.new(0, 6) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v258, Color = _v6.border, Thickness = 1, Transparency = 0.2 })
local _v360 = {}
local function _v366()
local current = _v197()
for _v358, btn in pairs(_v360) do
local _v439 = (_v358 == current)
btn.BackgroundColor3 = _v439 and _v6.accent or _v6.panel
btn.BackgroundTransparency = _v439 and 0 or 1
btn.TextColor3 = _v439 and Color3.fromRGB(255, 255, 255) or _v6.textSub
btn.Font = _v439 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v116()
if not _v357 then
return
end
_v357 = false
if _v55 and _v55.frame == _v159 then
_v55 = nil
end
_v43:Create(_v103, _v1, { Rotation = 0 }):Play()
_v43:Create(_v158, _v1, { Transparency = 0.3 }):Play()
_v43:Create(_v258, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v357 then
_v258.Visible = false
end
end)
end
local function _v173()
if _v357 then
return
end
if _v55 and _v55.close then
_v55.close()
end
_v357 = true
_v366()
_v258.Visible = true
_v43:Create(_v103, _v1, { Rotation = 180 }):Play()
_v43:Create(_v158, _v1, { Transparency = 0 }):Play()
_v43:Create(_v258, _v1, { Size = UDim2.new(1, 0, 0, _v261) }):Play()
_v55 = {
frame = _v159,
close = _v116,
contains = function(_v383)
local function _v230(_v335)
local p, s = _v335.AbsolutePosition, _v335.AbsoluteSize
return _v383.X >= p.X and _v383.X <= p.X + s.X and _v383.Y >= p.Y and _v383.Y <= p.Y + s.Y
end
return _v230(_v159) or (_v258.Visible and _v230(_v258))
end,
}
end
for i, _v358 in ipairs(_v361) do
local _v359 = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v258,
Size = UDim2.new(1, 0, 0, _v35),
Position = UDim2.fromOffset(0, (i - 1) * _v35),
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
Text = _v358,
AutoButtonColor = false,
})
_v360[_v358] = _v359
_v359.MouseButton1Click:Connect(function()
_v351(_v358)
_v524.Text = _v358
_v366()
_v116()
end)
_v359.MouseEnter:Connect(function()
if _v358 ~= _v197() then
_v359.BackgroundTransparency = 0
_v359.BackgroundColor3 = _v6.rowHover
_v359.TextColor3 = _v6.text
end
end)
_v359.MouseLeave:Connect(function()
_v366()
end)
end
_v366()
_v159.MouseButton1Click:Connect(function()
if _v357 then
_v116()
else
_v173()
end
end)
_v159.MouseEnter:Connect(function()
if not _v357 then
_v43:Create(_v159, _v1, { BackgroundColor3 = _v6.rowHover }):Play()
end
end)
_v159.MouseLeave:Connect(function()
if not _v357 then
_v43:Create(_v159, _v1, { BackgroundColor3 = _v6.row }):Play()
end
end)
table.insert(_v472, function()
_v524.Text = _v197()
_v366()
end)
end
local function _v269(_v367, title, _v195, _v442)
local h, s, v = _v195():ToHSV()
local _v38, _v21, GAP = 120, 16, 8
local _v218 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, _v38 + 74),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v218, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = _v218,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v207 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v218,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({151,239,118,7,97})),
})
local _v76 = _v315((_V9({146,242,123,5,118})), {
Parent = _v218,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v457 = _v315((_V9({146,242,123,5,118})), {
Parent = _v76,
Size = UDim2.new(1, -(_v21 + GAP), 0, _v38),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v457, CornerRadius = UDim.new(0, 4) })
local _v432 = _v315((_V9({146,242,123,5,118})), {
Parent = _v457,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v432, CornerRadius = UDim.new(0, 4) })
_v315((_V9({129,201,93,26,114,36,34,40,219,160})), {
Parent = _v432,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v523 = _v315((_V9({146,242,123,5,118})), {
Parent = _v457,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v523, CornerRadius = UDim.new(0, 4) })
_v315((_V9({129,201,93,26,114,36,34,40,219,160})), {
Parent = _v523,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v469 = _v315((_V9({146,242,123,5,118})), {
Parent = _v457,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v469, CornerRadius = UDim.new(1, 0) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v469, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v222 = _v315((_V9({146,242,123,5,118})), {
Parent = _v76,
Size = UDim2.fromOffset(_v21, _v38),
Position = UDim2.new(1, -_v21, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v222, CornerRadius = UDim.new(0, 4) })
_v315((_V9({129,201,93,26,114,36,34,40,219,160})), {
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
local _v223 = _v315((_V9({146,242,123,5,118})), {
Parent = _v222,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v223, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v386 = _v315((_V9({146,242,123,5,118})), {
Parent = _v76,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v38 + 6),
BackgroundColor3 = _v195(),
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v386, CornerRadius = UDim.new(0, 4) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v386, Color = _v6.off, Thickness = 1 })
local _v211 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local function _v396(_v548)
local _v115 = Color3.fromHSV(h, s, v)
if _v548 ~= false then
_v442(_v115)
end
_v457.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v469.Position = UDim2.new(s, 0, 1 - v, 0)
_v223.Position = UDim2.new(0.5, 0, h, 0)
_v386.BackgroundColor3 = _v115
local r = math.floor(_v115.R * 255 + 0.5)
local g = math.floor(_v115.G * 255 + 0.5)
local b = math.floor(_v115.B * 255 + 0.5)
_v211.Text = string.format((_V9({247,165,42,90,75,101,123,127,237,241,176,40,48,51,96,99,104,209,248,160,63,12,63,96,110,41,156})), r, g, b, r, g, b)
end
_v396(false)
local _v470, hueDrag = false, false
local function _v471(_v392, _v393)
s = math.clamp((_v392 - _v457.AbsolutePosition.X) / _v457.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v393 - _v457.AbsolutePosition.Y) / _v457.AbsoluteSize.Y, 0, 1)
_v396()
end
local function _v224(_v393)
h = math.clamp((_v393 - _v222.AbsolutePosition.Y) / _v222.AbsoluteSize.Y, 0, 1)
_v396()
end
_v457.InputBegan:Connect(function(_v229)
if _v240(_v229) then
_v470 = true
_v471(_v229.Position.X, _v229.Position.Y)
end
end)
_v222.InputBegan:Connect(function(_v229)
if _v240(_v229) then
hueDrag = true
_v224(_v229.Position.Y)
end
end)
table.insert(_v296, function(_v229)
if _v470 then
_v471(_v229.Position.X, _v229.Position.Y)
end
if hueDrag then
_v224(_v229.Position.Y)
end
end)
table.insert(_v402, function()
_v470, hueDrag = false, false
end)
table.insert(_v472, function()
h, s, v = _v195():ToHSV()
_v396(false)
end)
end
local function _v545(box, _v248, _v196, _v444, _v120)
local _v262 = false
local function _v396()
if _v262 then
box.Text = (_V9({132,242,127,27,96,162,203,235}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v6.accent
else
box.Text = _v196().Name
box.TextColor3 = _v6.accent
box.BackgroundColor3 = _v6.bar
end
end
local _v101 = {}
function _v101.finish(_v243)
_v262 = false
_v53 = nil
task.defer(function()
_v102 = false
end)
if _v243 then
local _v119 = _v120 and _v120(_v243)
if _v119 then
UI:Notify(string.format((_V9({241,243,58,1,96,96,42,33,199,177,225,126,17,51,34,36,56,219,176,160,110,7,51,101,56})), _v243.Name, _v119), 2.5)
else
_v444(_v243)
UI:Notify(string.format((_V9({241,243,58,10,124,53,37,41,149,160,239,58,77,96})), _v248, _v243.Name), 2)
end
end
_v396()
end
function _v101.cancel()
_v262 = false
_v396()
end
box.MouseButton1Click:Connect(function()
if _v262 then
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
_v262 = true
_v396()
end)
box.MouseEnter:Connect(function()
if not _v262 then
box.BackgroundColor3 = _v6.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v262 then
box.BackgroundColor3 = _v6.bar
end
end)
table.insert(_v472, function()
if _v53 == _v101 then
_v53 = nil
task.defer(function()
_v102 = false
end)
_v262 = false
end
_v396()
end)
_v396()
end
local function _v244(_v118, _v243, _v176)
if _v176 ~= (_V9({185,229,116,29})) and _v118.UI.MenuKey == _v243 then
return (_V9({153,229,116,29}))
end
if _v176 ~= (_V9({181,233,119,10,124,52})) and _v118.Camera.ToggleKey == _v243 then
return (_V9({149,233,119,10,124,52}))
end
if _v176 ~= (_V9({177,243,106})) and _v118.ESP.ToggleKey == _v243 then
return (_V9({145,211,74}))
end
if _v176 ~= (_V9({178,239,108,11,122,50,40,33,208})) and _v118.Camera.FOVCircleKey == _v243 then
return (_V9({146,207,76,72,80,41,57,46,217,177}))
end
if _v176 ~= (_V9({186,239,104,13,112,47,34,33})) and _v118.NoRecoil.ToggleKey == _v243 then
return (_V9({154,239,58,58,118,35,36,36,217}))
end
if _v176 ~= (_V9({186,239,105,24,97,37,42,41})) and _v118.NoSpread.ToggleKey == _v243 then
return (_V9({154,239,58,59,99,50,46,44,209}))
end
if _v176 ~= (_V9({160,242,115,15,116,37,57,47,218,160})) and _v118.Triggerbot.ToggleKey == _v243 then
return (_V9({128,242,115,15,116,37,57,47,218,160}))
end
if _v176 ~= (_V9({183,236,115,11,120,52,59})) and _v118.Movement.ClickTPKey == _v243 then
return (_V9({151,236,115,11,120,96,31,29}))
end
if _v176 ~= (_V9({161,238,118,7,114,36})) and _v118.UI.UnloadKey == _v243 then
return (_V9({129,238,118,7,114,36}))
end
return nil
end
local function _v277(_v367, _v248, _v196, _v444, _v120)
local _v218 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v218, CornerRadius = UDim.new(0, 6) })
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v218,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v248,
})
local box = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v315((_V9({129,201,73,1,105,37,8,34,219,167,244,104,9,122,46,63})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v545(box, _v248, _v196, _v444, _v120)
end
local function _v283(_v367, text, _v197, _v351, _v245, _v196, _v444, _v120)
local btn = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v112 = _v315((_V9({146,242,123,5,118})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v197() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v112, CornerRadius = UDim.new(0, 3) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v112, Color = _v6.border, Thickness = 1 })
local _v247 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local box = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v315((_V9({129,201,73,1,105,37,8,34,219,167,244,104,9,122,46,63})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v396()
local _v350 = _v197()
_v43:Create(_v112, _v1, { BackgroundColor3 = _v350 and _v6.accent or _v6.off }):Play()
_v43:Create(_v247, _v1, { TextColor3 = _v350 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v351()
_v396()
end)
table.insert(_v472, _v396)
_v545(box, _v245, _v196, _v444, _v120)
end
local function _v270(_v367)
local function _v117(order)
local _v115 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = _v115,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v115
end
return _v117(1), _v117(2)
end
local function _v274(_v367, title)
local _v547 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v315((_V9({146,242,123,5,118})), {
Parent = _v547,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = box, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local _v526 = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v547,
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v526, CornerRadius = UDim.new(0, 6) })
local _v39, GAP = 0.72, 1
local _v201 = _v315((_V9({146,242,123,5,118})), {
Parent = _v526,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v6.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
_v315((_V9({129,201,93,26,114,36,34,40,219,160})), {
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
local function _v473()
local _v433 = (_v544 and _v544.Scale) or 1
if _v433 <= 0 then
_v433 = 1
end
_v547.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v433)
end
box:GetPropertyChangedSignal((_V9({149,226,105,7,127,53,63,40,230,189,250,127}))):Connect(_v473)
_v473()
local function _v443(_v162)
_v526.Visible = not _v162
end
return box, _v443
end
local function _v280(_v367)
local bar = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v152 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v6.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v69 = _v315((_V9({146,242,123,5,118})), {
Parent = _v367,
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
local btn = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
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
local underline = _v315((_V9({146,242,123,5,118})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v315((_V9({135,227,104,7,127,44,34,35,210,146,242,123,5,118})), {
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
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v315((_V9({129,201,74,9,119,36,34,35,210})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
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
local function _v82(_v367, _v118)
_v252 = 0
local _v220 = _v280(_v367)
local _v253, right = _v270(_v220:add((_V9({149,233,119,10,124,52}))))
local _v57 = _v274(_v253, (_V9({149,233,119,10,124,52})))
_v283(_v57, (_V9({145,238,123,10,127,37,47})), function()
return _v118.Camera.Enabled
end, function()
_v118.Camera.Enabled = not _v118.Camera.Enabled
end, (_V9({149,233,119,10,124,52,107,6,208,173})), function()
return _v118.Camera.ToggleKey
end, function(_v243)
_v118.Camera.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({181,233,119,10,124,52})))
end)
_v282(_v57, (_V9({130,233,105,11,123,37,40,38})), function()
return _v118.Camera.WallCheck
end, function()
_v118.Camera.WallCheck = not _v118.Camera.WallCheck
end)
_v282(_v57, (_V9({128,225,104,15,118,52,107,15,218,160,243})), function()
return _v118.Camera.TargetBots
end, function()
_v118.Camera.TargetBots = not _v118.Camera.TargetBots
end)
_v282(_v57, (_V9({128,229,123,5,51,3,35,40,214,191})), function()
return _v118.Camera.TeamCheck
end, function()
_v118.Camera.TeamCheck = not _v118.Camera.TeamCheck
end)
_v283(_v57, (_V9({146,207,76,72,80,41,57,46,217,177})), function()
return _v118.Camera.FOVCircle
end, function()
_v118.Camera.FOVCircle = not _v118.Camera.FOVCircle
end, (_V9({146,207,76,72,80,41,57,46,217,177,160,81,13,106})), function()
return _v118.Camera.FOVCircleKey
end, function(_v243)
_v118.Camera.FOVCircleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({178,239,108,11,122,50,40,33,208})))
end)
_v273(_v57, (_V9({135,237,117,7,103,40,37,40,198,167})), 0.05, 1, function()
return _v118.Camera.Smoothness
end, function(_v522)
_v118.Camera.Smoothness = _v522
end, false)
_v273(_v57, (_V9({146,207,76})), 20, 800, function()
return _v118.Camera.FOV
end, function(_v522)
_v118.Camera.FOV = _v522
end, true, (_V9({164,248})), true)
_v273(_v57, (_V9({153,225,98,72,87,41,56,57,212,186,227,127})), 100, 2000, function()
return _v118.Camera.MaxDistance
end, function(_v522)
_v118.Camera.MaxDistance = _v522
end, true, (_V9({185})), true)
local _v400
local _v217 = _v274(right, (_V9({156,233,110,10,124,56})))
_v272(_v217, _v118.Camera.HitboxOptions, function()
return _v118.Camera.Hitbox
end, function(_v522)
_v118.Camera.Hitbox = _v522
if _v400 then
_v400()
end
end)
local _v542, setWeightsEnabled = _v274(right, (_V9({128,225,104,15,118,52,107,30,208,160,244,115,6,116,51})))
local function _v541(name)
_v273(_v542, name .. (_V9({244,215,127,1,116,40,63})), 0, 100, function()
return _v118.Camera.TargetWeights[name]
end, function(_v522)
_v118.Camera.TargetWeights[name] = _v522
end, true, (_V9({241})), true)
end
_v541((_V9({156,229,123,12})))
_v541((_V9({128,239,104,27,124})))
_v541((_V9({149,242,119,27})))
_v541((_V9({152,229,125,27})))
_v400 = function()
setWeightsEnabled(_v118.Camera.Hitbox == (_V9({134,225,116,12,124,45,107,101,226,177,233,125,0,103,37,47,100})))
end
_v400()
table.insert(_v472, _v400)
local _v508 = _v274(right, (_V9({128,242,115,15,116,37,57,47,218,160})))
_v283(_v508, (_V9({145,238,123,10,127,37,47})), function()
return _v118.Triggerbot.Enabled
end, function()
_v118.Triggerbot.Enabled = not _v118.Triggerbot.Enabled
end, (_V9({128,242,115,15,116,37,57,47,218,160,160,81,13,106})), function()
return _v118.Triggerbot.ToggleKey
end, function(_v243)
_v118.Triggerbot.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({160,242,115,15,116,37,57,47,218,160})))
end)
_v273(_v508, (_V9({153,233,116,72,87,37,39,44,204})), 0, 500, function()
return _v118.Triggerbot.MinDelay * 1000
end, function(_v522)
_v118.Triggerbot.MinDelay = _v522 / 1000
end, true, (_V9({185,243})), true)
_v273(_v508, (_V9({153,225,98,72,87,37,39,44,204})), 0, 500, function()
return _v118.Triggerbot.MaxDelay * 1000
end, function(_v522)
_v118.Triggerbot.MaxDelay = _v522 / 1000
end, true, (_V9({185,243})), true)
_v273(_v508, (_V9({153,225,98,72,87,41,56,57,212,186,227,127})), 100, 2000, function()
return _v118.Triggerbot.MaxDistance
end, function(_v522)
_v118.Triggerbot.MaxDistance = _v522
end, true, (_V9({185})), true)
_v282(_v508, (_V9({130,233,105,11,123,37,40,38})), function()
return _v118.Triggerbot.WallCheck
end, function()
_v118.Triggerbot.WallCheck = not _v118.Triggerbot.WallCheck
end)
local _v451 = _v274(right, (_V9({135,233,118,13,125,52,107,12,220,185})))
_v282(_v451, (_V9({145,238,123,10,127,37,47})), function()
return _v118.SilentAim.Enabled
end, function()
_v118.SilentAim.Enabled = not _v118.SilentAim.Enabled
end)
local _v174 = _v274(right, (_V9({156,233,110,10,124,56,107,8,205,164,225,116,12,118,50})))
_v282(_v174, (_V9({145,238,123,10,127,37,47})), function()
return _v118.Hitbox.Enabled
end, function()
_v118.Hitbox.Enabled = not _v118.Hitbox.Enabled
end)
_v273(_v174, (_V9({135,233,96,13})), 1, 20, function()
return _v118.Hitbox.Size
end, function(_v522)
_v118.Hitbox.Size = _v522
end, true)
_v273(_v174, (_V9({128,242,123,6,96,48,42,63,208,186,227,99})), 0, 1, function()
return _v118.Hitbox.Transparency
end, function(_v522)
_v118.Hitbox.Transparency = _v522
end, false)
_v253, right = _v270(_v220:add((_V9({131,229,123,24,124,46,56}))))
local _v395 = _v274(_v253, (_V9({154,239,58,58,118,35,36,36,217})))
_v283(_v395, (_V9({145,238,123,10,127,37,47})), function()
return _v118.NoRecoil.Enabled
end, function()
_v118.NoRecoil.Enabled = not _v118.NoRecoil.Enabled
end, (_V9({154,239,58,58,118,35,36,36,217,244,203,127,17})), function()
return _v118.NoRecoil.ToggleKey
end, function(_v243)
_v118.NoRecoil.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({186,239,104,13,112,47,34,33})))
end)
_v282(_v395, (_V9({155,238,118,17,51,23,35,36,217,177,160,92,1,97,41,37,42})), function()
return _v118.NoRecoil.RequireMouseDown
end, function()
_v118.NoRecoil.RequireMouseDown = not _v118.NoRecoil.RequireMouseDown
end)
_v282(_v395, (_V9({149,236,118,7,100,96,10,36,216,244,196,117,31,125})), function()
return _v118.NoRecoil.AllowAim
end, function()
_v118.NoRecoil.AllowAim = not _v118.NoRecoil.AllowAim
end)
_v273(_v395, (_V9({135,244,104,13,125,39,63,37})), 0, 100, function()
return _v118.NoRecoil.Strength * 100
end, function(_v522)
_v118.NoRecoil.Strength = _v522 / 100
end, true, (_V9({241})), true)
local _v456 = _v274(_v253, (_V9({154,239,58,59,99,50,46,44,209})))
_v283(_v456, (_V9({145,238,123,10,127,37,47})), function()
return _v118.NoSpread.Enabled
end, function()
_v118.NoSpread.Enabled = not _v118.NoSpread.Enabled
end, (_V9({154,239,58,59,99,50,46,44,209,244,203,127,17})), function()
return _v118.NoSpread.ToggleKey
end, function(_v243)
_v118.NoSpread.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({186,239,105,24,97,37,42,41})))
end)
_v282(_v456, (_V9({155,238,118,17,51,23,35,36,217,177,160,92,1,97,41,37,42})), function()
return _v118.NoSpread.RequireMouseDown
end, function()
_v118.NoSpread.RequireMouseDown = not _v118.NoSpread.RequireMouseDown
end)
_v273(_v456, (_V9({135,244,104,13,125,39,63,37})), 0, 100, function()
return _v118.NoSpread.Strength * 100
end, function(_v522)
_v118.NoSpread.Strength = _v522 / 100
end, true, (_V9({241})), true)
end
local function _v83(_v367, _v118)
_v252 = 0
local _v220 = _v280(_v367)
local _v253, right = _v270(_v220:add((_V9({145,211,74}))))
local _v169 = _v274(_v253, (_V9({145,211,74})))
_v283(_v169, (_V9({145,238,123,10,127,37,47})), function()
return _v118.ESP.Enabled
end, function()
_v118.ESP.Enabled = not _v118.ESP.Enabled
end, (_V9({145,211,74,72,88,37,50})), function()
return _v118.ESP.ToggleKey
end, function(_v243)
_v118.ESP.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({177,243,106})))
end)
_v282(_v169, (_V9({154,208,89,27})), function()
return _v118.ESP.NPCs
end, function()
_v118.ESP.NPCs = not _v118.ESP.NPCs
end)
_v273(_v169, (_V9({153,225,98,72,87,41,56,57,212,186,227,127})), 100, 2000, function()
return _v118.ESP.MaxDistance
end, function(_v522)
_v118.ESP.MaxDistance = _v522
end, true, (_V9({185})), true)
local _v264 = _v274(_v253, (_V9({149,240,106,13,114,50,42,35,214,177})))
_v282(_v264, (_V9({155,245,110,4,122,46,46,62})), function()
return _v118.ESP.Outlines
end, function()
_v118.ESP.Outlines = not _v118.ESP.Outlines
end)
_v282(_v264, (_V9({150,239,98,13,96})), function()
return _v118.ESP.Boxes
end, function()
_v118.ESP.Boxes = not _v118.ESP.Boxes
end)
_v282(_v264, (_V9({154,225,119,13,96})), function()
return _v118.ESP.Names
end, function()
_v118.ESP.Names = not _v118.ESP.Names
end)
_v282(_v264, (_V9({144,233,105,28,114,46,40,40})), function()
return _v118.ESP.Distance
end, function()
_v118.ESP.Distance = not _v118.ESP.Distance
end)
_v282(_v264, (_V9({156,229,123,4,103,40,107,15,212,166,243})), function()
return _v118.ESP.HealthBars
end, function()
_v118.ESP.HealthBars = not _v118.ESP.HealthBars
end)
_v282(_v264, (_V9({146,233,118,4,118,36})), function()
return _v118.ESP.Filled
end, function()
_v118.ESP.Filled = not _v118.ESP.Filled
end)
_v273(_v264, (_V9({155,245,110,4,122,46,46,109,250,164,225,121,1,103,57})), 0, 1, function()
return _v118.ESP.OutlineOpacity
end, function(_v522)
_v118.ESP.OutlineOpacity = _v522
end, false)
_v273(_v264, (_V9({146,233,118,4,51,15,59,44,214,189,244,99})), 0, 1, function()
return _v118.ESP.FillOpacity
end, function(_v522)
_v118.ESP.FillOpacity = _v522
end, false)
local _v156 = _v274(right, (_V9({144,242,123,31,122,46,44,109,240,135,208})))
_v282(_v156, (_V9({150,239,98,13,96})), function()
return _v118.Drawing.Boxes
end, function()
_v118.Drawing.Boxes = not _v118.Drawing.Boxes
end)
_v282(_v156, (_V9({128,242,123,11,118,50,56})), function()
return _v118.Drawing.Tracers
end, function()
_v118.Drawing.Tracers = not _v118.Drawing.Tracers
end)
local _v546 = _v274(right, (_V9({131,239,104,4,119})))
_v282(_v546, (_V9({146,245,118,4,113,50,34,42,221,160})), function()
return _v118.Visuals.Fullbright
end, function()
_v118.Visuals.Fullbright = not _v118.Visuals.Fullbright
end)
_v282(_v546, (_V9({154,239,58,46,124,39})), function()
return _v118.Visuals.NoFog
end, function()
_v118.Visuals.NoFog = not _v118.Visuals.NoFog
end)
_v253, right = _v270(_v220:add((_V9({151,239,118,7,97,51}))))
_v269(_v253, (_V9({155,245,110,4,122,46,46,109,246,187,236,117,26})), function()
return _v118.ESP.OutlineColor
end, function(c)
_v118.ESP.OutlineColor = c
end)
_v269(right, (_V9({146,233,118,4,51,3,36,33,218,166})), function()
return _v118.ESP.FillColor
end, function(c)
_v118.ESP.FillColor = c
end)
_v269(_v253, (_V9({150,239,98,72,80,47,39,34,199})), function()
return _v118.Drawing.BoxColor
end, function(c)
_v118.Drawing.BoxColor = c
end)
_v269(right, (_V9({128,242,123,11,118,50,107,14,218,184,239,104})), function()
return _v118.Drawing.TracerColor
end, function(c)
_v118.Drawing.TracerColor = c
end)
end
local function _v88(_v367, _v118)
_v252 = 0
local _v220 = _v280(_v367)
local _v253, right = _v270(_v220:add((_V9({153,239,108,13,126,37,37,57}))))
local _v180 = _v274(_v253, (_V9({146,236,99})))
_v282(_v180, (_V9({145,238,123,10,127,37,47})), function()
return _v118.Movement.FlyEnabled
end, function()
_v118.Movement.FlyEnabled = not _v118.Movement.FlyEnabled
end)
_v273(_v180, (_V9({146,236,99,72,64,48,46,40,209})), 10, 200, function()
return _v118.Movement.FlySpeed
end, function(_v522)
_v118.Movement.FlySpeed = _v522
end, true)
local _v455 = _v274(_v253, (_V9({135,240,127,13,119})))
_v282(_v455, (_V9({145,238,123,10,127,37,47})), function()
return _v118.Movement.SpeedEnabled
end, function()
_v118.Movement.SpeedEnabled = not _v118.Movement.SpeedEnabled
end)
_v273(_v455, (_V9({135,240,127,13,119})), 16, 100, function()
return _v118.Movement.Speed
end, function(_v522)
_v118.Movement.Speed = _v522
end, true)
local _v290 = _v274(_v253, (_V9({155,244,114,13,97})))
_v282(_v290, (_V9({154,239,121,4,122,48})), function()
return _v118.Movement.NoclipEnabled
end, function()
_v118.Movement.NoclipEnabled = not _v118.Movement.NoclipEnabled
end)
_v282(_v290, (_V9({157,238,124,1,125,41,63,40,149,158,245,119,24})), function()
return _v118.Movement.InfJumpEnabled
end, function()
_v118.Movement.InfJumpEnabled = not _v118.Movement.InfJumpEnabled
end)
local _v506 = _v274(right, (_V9({151,236,115,11,120,96,31,29})))
_v282(_v506, (_V9({145,238,123,10,127,37,47})), function()
return _v118.Movement.ClickTPEnabled
end, function()
_v118.Movement.ClickTPEnabled = not _v118.Movement.ClickTPEnabled
end)
_v277(_v506, (_V9({153,239,126,1,117,41,46,63,149,159,229,99})), function()
return _v118.Movement.ClickTPKey
end, function(_v243)
_v118.Movement.ClickTPKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({183,236,115,11,120,52,59})))
end)
end
local function _v89(_v367, _v118)
_v252 = 0
local _v220 = _v280(_v367)
local _v253, right = _v270(_v220:add((_V9({132,236,123,17,118,50,56}))))
local _v259 = _v274(_v253, (_V9({132,236,123,17,118,50,107,1,220,167,244})))
_v380 = _v315((_V9({135,227,104,7,127,44,34,35,210,146,242,123,5,118})), {
Parent = _v259,
LayoutOrder = _v317(),
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v380, CornerRadius = UDim.new(0, 6) })
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = _v380,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = _v380,
PaddingTop = UDim.new(0, 4),
PaddingBottom = UDim.new(0, 4),
PaddingLeft = UDim.new(0, 4),
PaddingRight = UDim.new(0, 4),
})
local function _v398()
for _v378, row in pairs(_v381) do
row.btn.BackgroundColor3 = (_v378 == _v441) and _v6.accent or _v6.row
end
end
local function _v397()
if not _v380 then
return
end
for _, _v113 in ipairs(_v380:GetChildren()) do
if not _v113:IsA((_V9({129,201,86,1,96,52,7,44,204,187,245,110}))) then
_v113:Destroy()
end
end
table.clear(_v381)
local _v125 = 0
for _, _v378 in ipairs(_v31:GetPlayers()) do
if _v378 ~= _v26 then
_v125 = _v125 + 1
local row = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v380,
LayoutOrder = _v125,
Size = UDim2.new(1, 0, 0, 24),
BackgroundColor3 = (_v378 == _v441) and _v6.accent or _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = row, CornerRadius = UDim.new(0, 4) })
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
local dist = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = row,
Size = UDim2.new(0.35, -8, 1, 0),
Position = UDim2.new(0.65, 0, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = (_V9({54,0,142})),
})
row.MouseButton1Click:Connect(function()
_v441 = (_v441 == _v378) and nil or _v378
_v398()
end)
_v381[_v378] = { btn = row, dist = dist }
end
end
if _v125 == 0 then
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v380,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({244,160,116,7,51,47,63,37,208,166,160,106,4,114,57,46,63,198})),
})
end
end
local _v51 = _v274(right, (_V9({149,227,110,1,124,46,56})))
local _v440 = _v278(_v51, (_V9({135,229,118,13,112,52,46,41})), (_V9({54,0,142})))
_v268(_v51, (_V9({128,229,118,13,99,47,57,57,149,128,239})), function()
local _v110 = _v441 and _v441.Character
local root = _v110 and _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
if root and UI.TeleportTo then
UI.TeleportTo(root.Position)
end
end)
_v453 = _v268(_v51, (_V9({135,240,127,11,103,33,63,40})), function()
if _v454 then
_v464()
elseif _v441 then
_v462(_v441)
end
end)
table.insert(_v472, function()
_v440.Text = _v441 and _v441.Name or (_V9({54,0,142}))
_v398()
end)
_v397()
table.insert(_v511, _v31.PlayerAdded:Connect(function()
_v397()
end))
table.insert(_v511, _v31.PlayerRemoving:Connect(function(_v378)
if _v378 == _v441 then
_v441 = nil
end
if _v378 == _v454 then
_v464()
end
_v397()
end))
local _v250 = 0
table.insert(_v511, _v36.RenderStepped:Connect(function()
if os.clock() - _v250 < 0.5 then
return
end
_v250 = os.clock()
_v440.Text = _v441 and _v441.Name or (_V9({54,0,142}))
local _v307 = _v26.Character
local _v308 = _v307 and _v307:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
for _v378, row in pairs(_v381) do
local _v110 = _v378.Character
local root = _v110 and _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
row.dist.Text = (_v308 and root)
and (math.floor((root.Position - _v308.Position).Magnitude + 0.5) .. (_V9({185})))
or (_V9({54,0,142}))
end
if _v454 then
if _v54 and _v54.Movement and _v54.Movement.FlyEnabled then
_v464()
else
local _v110 = _v454.Character
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
local _v93 = _v48.CurrentCamera
if humanoid and humanoid.Health > 0 and _v93 then
_v93.CameraSubject = humanoid
else
_v464()
end
end
end
end))
end
local function _v87(_v367, _v118)
_v252 = 0
local _v220 = _v280(_v367)
local _v253, right = _v270(_v220:add((_V9({135,229,105,27,122,47,37}))))
local _v50 = _v274(_v253, (_V9({149,227,121,7,102,46,63})))
_v278(_v50, (_V9({129,243,127,26,125,33,38,40})), _v26 and _v26.Name or (_V9({54,0,142})))
_v278(_v50, (_V9({144,233,105,24,127,33,50,109,251,181,237,127})), _v26 and _v26.DisplayName or (_V9({54,0,142})))
_v278(_v50, (_V9({129,243,127,26,51,9,15})), _v26 and tostring(_v26.UserId) or (_V9({54,0,142})))
_v268(_v50, (_V9({135,229,104,30,118,50,107,5,218,164})), function()
_v45:ServerHop()
end)
_v268(_v50, (_V9({134,229,112,7,122,46,107,30,208,166,246,127,26})), function()
_v45:Rejoin()
end)
local _v540 = _v274(right, (_V9({131,229,120,0,124,47,32})))
local _v521 = _v281(_v540, (_V9({163,229,120,0,124,47,32,109,192,166,236,248,232,181})))
_v521.Text = _v118.Webhook.Url
_v521.FocusLost:Connect(function()
_v118.Webhook.Url = _v521.Text
end)
_v268(_v540, (_V9({135,229,116,12,51,20,46,62,193,244,215,127,10,123,47,36,38})), function()
local _v337, res = _v47.SendWebhook((_V9({130,225,116,1,103,57,102,10,208,186,229,104,9,127,96,63,40,198,160,160,109,13,113,40,36,34,222})))
if _v337 then
UI:Notify((_V9({128,229,105,28,51,55,46,47,221,187,239,113,72,96,37,37,57})), 2)
else
UI:Notify((_V9({131,229,120,0,124,47,32,109,211,181,233,118,13,119,122,107})) .. tostring(res), 3)
end
end)
end
local function _v90(_v367, _v118)
_v252 = 0
local _v220 = _v280(_v367)
local _v253, right = _v270(_v220:add((_V9({147,229,116,13,97,33,39}))))
local _v227 = _v274(_v253, (_V9({157,238,110,13,97,38,42,46,208})))
_v273(_v227, (_V9({129,201,58,59,112,33,39,40})), 0.8, 1.5, function()
return _v118.UI.Scale
end, function(_v522)
_v118.UI.Scale = _v522
if _v544 then
_v544.Scale = _v522
end
end, false)
_v282(_v227, (_V9({159,229,99,10,122,46,47,109,229,181,238,127,4})), function()
return _v118.UI.KeybindPanel
end, function()
_v118.UI.KeybindPanel = not _v118.UI.KeybindPanel
if _v246 then
_v246.Visible = _v118.UI.KeybindPanel
end
end)
_v282(_v227, (_V9({128,225,104,15,118,52,107,9,220,167,240,118,9,106})), function()
return _v118.UI.TargetDisplay
end, function()
_v118.UI.TargetDisplay = not _v118.UI.TargetDisplay
_v482 = _v118.UI.TargetDisplay
if not _v482 and _v483 then
_v483.Visible = false
end
end)
_v282(_v227, (_V9({146,208,73,72,80,47,62,35,193,177,242})), function()
return _v118.UI.FPSCounter
end, function()
_v118.UI.FPSCounter = not _v118.UI.FPSCounter
if _v188 then
_v188.Visible = _v118.UI.FPSCounter
end
end)
_v282(_v227, (_V9({131,225,110,13,97,45,42,63,222})), function()
return _v118.UI.Watermark
end, function()
_v118.UI.Watermark = not _v118.UI.Watermark
if _v539 then
_v539.Visible = _v118.UI.Watermark
end
end)
_v269(_v227, (_V9({149,227,121,13,125,52,107,14,218,184,239,104})), function()
return _v118.UI.Accent
end, function(_v313)
_v67(_v313)
end)
table.insert(_v472, function()
if _v118.UI.Accent then
_v67(_v118.UI.Accent)
end
end)
_v253, right = _v270(_v220:add((_V9({151,239,116,14,122,39,56}))))
local _v107 = _v274(_v253, (_V9({151,239,116,14,122,39,56})))
if not _v11.isSupported() then
_v278(_v107, (_V9({135,244,123,28,102,51})), (_V9({129,238,105,29,99,48,36,63,193,177,228})))
return
end
local _v310 = _v281(_v107, (_V9({183,239,116,14,122,39,107,35,212,185,229,248,232,181})))
local _v260 = _v315((_V9({146,242,123,5,118})), {
Parent = _v107,
LayoutOrder = _v317(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = _v260,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v397
local function _v438(name)
_v310.Text = name
_v397()
end
_v397 = function()
for _, _v113 in ipairs(_v260:GetChildren()) do
if not _v113:IsA((_V9({129,201,86,1,96,52,7,44,204,187,245,110}))) then
_v113:Destroy()
end
end
local _v312 = _v11.list()
if #_v312 == 0 then
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v260,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({186,239,58,27,114,54,46,41,149,183,239,116,14,122,39,56})),
})
return
end
for i, name in ipairs(_v312) do
local _v439 = (_v310.Text == name)
local row = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v260,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v439 and _v6.accent or _v6.row,
BackgroundTransparency = _v439 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v439 and Color3.fromRGB(255, 255, 255) or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({244,160})) .. name,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v438(name)
end)
row.MouseEnter:Connect(function()
if _v310.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v6.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v310.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v6.row
end
end)
end
end
_v268(_v107, (_V9({135,225,108,13})), function()
local _v337, res = _v11.save(_v310.Text, _v118)
if _v337 then
UI:Notify((_V9({135,225,108,13,119,96,40,34,219,178,233,125,72,52})) .. res .. (_V9({243})), 2)
_v397()
else
UI:Notify(tostring(res), 3)
end
end)
_v268(_v107, (_V9({152,239,123,12})), function()
local _v337, res = _v11.load(_v310.Text, _v118)
if _v337 then
if _v544 then
_v544.Scale = _v118.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({152,239,123,12,118,36,107,46,218,186,230,115,15,51,103})) .. res .. (_V9({243})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v268(_v107, (_V9({144,229,118,13,103,37})), function()
local _v337, res = _v11.delete(_v310.Text)
if _v337 then
UI:Notify((_V9({144,229,118,13,103,37,47,109,214,187,238,124,1,116,96,108})) .. res .. (_V9({243})), 2)
_v310.Text = (_V9({}))
_v397()
else
UI:Notify(tostring(res), 3)
end
end, _v6.danger)
_v397()
end
local function _v91(_v118)
_v483 = _v315((_V9({146,242,123,5,118})), {
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v483, CornerRadius = UDim.new(0, 6) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v483, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = _v483,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = _v483,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v153 = _v315((_V9({146,242,123,5,118})), {
Parent = _v483,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v483,
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
local _v155, _v154, _v461
_v483.InputBegan:Connect(function(_v229)
if _v240(_v229) then
_v155 = true
_v154 = _v229.Position
_v461 = _v483.Position
end
end)
table.insert(_v296, function(_v229)
if _v155 and _v483 then
local delta = _v229.Position - _v154
_v483.Position = UDim2.new(
_v461.X.Scale,
_v461.X.Offset + delta.X,
_v461.Y.Scale,
_v461.Y.Offset + delta.Y
)
end
end)
table.insert(_v402, function()
_v155 = false
end)
table.insert(_v472, function()
_v482 = _v118.UI.TargetDisplay
if not _v482 and _v483 then
_v483.Visible = false
end
end)
_v482 = _v118.UI.TargetDisplay
end
local function _v85(_v118)
_v188 = _v315((_V9({146,242,123,5,118})), {
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v188, CornerRadius = UDim.new(0, 6) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v188, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = _v188,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = _v188,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v153 = _v315((_V9({146,242,123,5,118})), {
Parent = _v188,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
Text = (_V9({249,173,58,14,99,51})),
})
table.insert(_v472, function()
if _v188 then
_v188.Visible = _v118.UI.FPSCounter
end
end)
_v188.Visible = _v118.UI.FPSCounter
end
local function _v92(_v118)
_v539 = _v315((_V9({157,237,123,15,118,12,42,47,208,184})), {
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
table.insert(_v472, function()
if _v539 then
_v539.Visible = _v118.UI.Watermark
end
end)
_v539.Visible = _v118.UI.Watermark
end
local function _v86(_v118)
_v252 = 0
_v246 = _v315((_V9({146,242,123,5,118})), {
Parent = _v200,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
Visible = false,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v246, CornerRadius = UDim.new(0, 8) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v246, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), {
Parent = _v246,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = _v246,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v315((_V9({146,242,123,5,118})), {
Parent = _v246,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({159,229,99,10,122,46,47,62})),
})
local _v155, _v154, _v461
bar.InputBegan:Connect(function(_v229)
if _v240(_v229) then
_v155 = true
_v154 = _v229.Position
_v461 = _v246.Position
end
end)
table.insert(_v296, function(_v229)
if _v155 and _v246 then
local delta = _v229.Position - _v154
_v246.Position = UDim2.new(
_v461.X.Scale,
_v461.X.Offset + delta.X,
_v461.Y.Scale,
_v461.Y.Offset + delta.Y
)
end
end)
table.insert(_v402, function()
_v155 = false
end)
_v277(_v246, (_V9({153,229,116,29})), function()
return _v118.UI.MenuKey
end, function(_v243)
_v118.UI.MenuKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({185,229,116,29})))
end)
_v277(_v246, (_V9({149,233,119,10,124,52})), function()
return _v118.Camera.ToggleKey
end, function(_v243)
_v118.Camera.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({181,233,119,10,124,52})))
end)
_v277(_v246, (_V9({145,211,74})), function()
return _v118.ESP.ToggleKey
end, function(_v243)
_v118.ESP.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({177,243,106})))
end)
_v277(_v246, (_V9({146,207,76,72,80,41,57,46,217,177})), function()
return _v118.Camera.FOVCircleKey
end, function(_v243)
_v118.Camera.FOVCircleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({178,239,108,11,122,50,40,33,208})))
end)
_v277(_v246, (_V9({154,239,58,58,118,35,36,36,217})), function()
return _v118.NoRecoil.ToggleKey
end, function(_v243)
_v118.NoRecoil.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({186,239,104,13,112,47,34,33})))
end)
_v277(_v246, (_V9({154,239,58,59,99,50,46,44,209})), function()
return _v118.NoSpread.ToggleKey
end, function(_v243)
_v118.NoSpread.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({186,239,105,24,97,37,42,41})))
end)
_v277(_v246, (_V9({128,242,115,15,116,37,57,47,218,160})), function()
return _v118.Triggerbot.ToggleKey
end, function(_v243)
_v118.Triggerbot.ToggleKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({160,242,115,15,116,37,57,47,218,160})))
end)
_v277(_v246, (_V9({129,238,118,7,114,36})), function()
return _v118.UI.UnloadKey
end, function(_v243)
_v118.UI.UnloadKey = _v243
end, function(_v243)
return _v244(_v118, _v243, (_V9({161,238,118,7,114,36})))
end)
table.insert(_v472, function()
if _v246 then
_v246.Visible = _v118.UI.KeybindPanel
end
end)
_v246.Visible = _v118.UI.KeybindPanel
end
local function _v446(_v463)
if not _v267 or _v463 == _v528 then
return
end
_v528 = _v463
if _v54 and _v54.UI then
_v54.UI.Visible = _v463
end
if _v463 then
_v267.Visible = true
_v267.GroupTransparency = 1
_v43:Create(_v267, TweenInfo.new(_v17), { GroupTransparency = 0 }):Play()
else
local _v510 = _v43:Create(_v267, TweenInfo.new(_v17), { GroupTransparency = 1 })
_v510.Completed:Once(function()
if not _v528 and _v267 then
_v267.Visible = false
end
end)
_v510:Play()
end
end
function UI:Init(_v118, _v355)
if _v200 then
return
end
_v54 = _v118
_v356 = _v355
if _v118.UI.Accent then
_v6.accent = _v118.UI.Accent
end
_v460()
_v200 = _v315((_V9({135,227,104,13,118,46,12,56,220})), {
Name = _v10.RandomName(),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v337 = pcall(function()
_v200.Parent = _v45.getGuiParent()
end)
if not _v337 or not _v200.Parent then
_v200.Parent = _v26:WaitForChild((_V9({132,236,123,17,118,50,12,56,220})))
end
_v10.Protect(_v200)
_v267 = _v315((_V9({151,225,116,30,114,51,12,63,218,161,240})), {
Parent = _v200,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v544 = _v315((_V9({129,201,73,11,114,44,46})), { Parent = _v267, Scale = _v118.UI.Scale })
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v267, CornerRadius = UDim.new(0, 8) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v267, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
local _v497 = _v315((_V9({146,242,123,5,118})), {
Parent = _v267,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v497, CornerRadius = UDim.new(0, 8) })
_v315((_V9({146,242,123,5,118})), {
Parent = _v497,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
local _v153 = _v315((_V9({146,242,123,5,118})), {
Parent = _v497,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v153, CornerRadius = UDim.new(1, 0) })
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v497,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({130,225,116,1,103,57,119,43,218,186,244,58,11,124,44,36,63,136,246,163,34,92,32,5,9,8,151,234,174,126,13,101,124,100,43,218,186,244,36,72,84,37,37,40,199,181,236}))
.. (_V9({232,230,117,6,103,96,40,34,217,187,242,39,74,48,120,10,122,246,149,176,56,86,51,96,107,143,2,244,160,58,30,35,124,100,43,218,186,244,36})),
ZIndex = 2,
})
_v315((_V9({128,229,98,28,95,33,41,40,217})), {
Parent = _v497,
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
local _v155, _v154, _v461
_v497.InputBegan:Connect(function(_v229)
if _v240(_v229) then
_v155 = true
_v154 = _v229.Position
_v461 = _v267.Position
end
end)
table.insert(_v296, function(_v229)
if _v155 then
local delta = _v229.Position - _v154
_v267.Position = UDim2.new(
_v461.X.Scale,
_v461.X.Offset + delta.X,
_v461.Y.Scale,
_v461.Y.Offset + delta.Y
)
end
end)
table.insert(_v402, function()
_v155 = false
end)
local _v450 = _v315((_V9({146,242,123,5,118})), {
Parent = _v267,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v450, CornerRadius = UDim.new(0, 6) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v450, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = _v450,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v478 = _v315((_V9({146,242,123,5,118})), {
Parent = _v450,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v315((_V9({129,201,86,1,96,52,7,44,204,187,245,110})), { Parent = _v478, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v513 = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v450,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.danger,
Text = (_V9({129,238,118,7,114,36})),
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v513, CornerRadius = UDim.new(0, 6) })
local _v514 = _v315((_V9({129,201,73,28,97,47,32,40})), {
Parent = _v513,
Color = _v6.danger,
Thickness = 1,
Transparency = 0.55,
})
_v513.MouseButton1Click:Connect(function()
if _v356 then
_v356()
end
end)
_v513.MouseEnter:Connect(function()
_v43:Create(_v513, _v1, {
BackgroundColor3 = _v6.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v43:Create(_v514, _v1, { Transparency = 0 }):Play()
end)
_v513.MouseLeave:Connect(function()
_v43:Create(_v513, _v1, {
BackgroundColor3 = _v6.row,
TextColor3 = _v6.danger,
}):Play()
_v43:Create(_v514, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v315((_V9({146,242,123,5,118})), {
Parent = _v267,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v315((_V9({129,201,74,9,119,36,34,35,210})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v480 = { (_V9({151,239,119,10,114,52})), (_V9({130,233,105,29,114,44})), (_V9({153,239,108,13,126,37,37,57})), (_V9({132,236,123,17,118,50,56})), (_V9({153,233,105,11})), (_V9({135,229,110,28,122,46,44,62})) }
local _v477 = {}
for i, _v479 in ipairs(_v480) do
local _v233 = _v126 == _v479
local _v475 = _v315((_V9({128,229,98,28,81,53,63,57,218,186})), {
Parent = _v478,
LayoutOrder = i,
Size = UDim2.new(1, 0, 1 / #_v480, -6),
BackgroundColor3 = _v6.rowHover,
BackgroundTransparency = _v233 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v233 and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({244,160,58,72})) .. _v479,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v475, CornerRadius = UDim.new(0, 6) })
local stripe = _v315((_V9({146,242,123,5,118})), {
Parent = _v475,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
Visible = _v233,
ZIndex = 2,
})
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v476 = _v315((_V9({146,242,123,5,118})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v233,
})
_v477[_v479] = { btn = _v475, frame = _v476, stripe = stripe }
_v475.MouseButton1Click:Connect(function()
_v126 = _v479
for name, _v474 in pairs(_v477) do
local _v52 = name == _v479
_v474.frame.Visible = _v52
_v474.stripe.Visible = _v52
_v43:Create(_v474.btn, _v1, {
BackgroundTransparency = _v52 and 0 or 1,
TextColor3 = _v52 and _v6.text or _v6.textSub,
}):Play()
end
end)
_v475.MouseEnter:Connect(function()
if _v126 ~= _v479 then
_v43:Create(_v475, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v475.MouseLeave:Connect(function()
if _v126 ~= _v479 then
_v43:Create(_v475, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v82(_v477[(_V9({151,239,119,10,114,52}))].frame, _v118)
_v83(_v477[(_V9({130,233,105,29,114,44}))].frame, _v118)
_v88(_v477[(_V9({153,239,108,13,126,37,37,57}))].frame, _v118)
_v89(_v477[(_V9({132,236,123,17,118,50,56}))].frame, _v118)
_v87(_v477[(_V9({153,233,105,11}))].frame, _v118)
_v90(_v477[(_V9({135,229,110,28,122,46,44,62}))].frame, _v118)
_v86(_v118)
_v91(_v118)
_v85(_v118)
_v92(_v118)
if _v118.UI.Visible then
_v446(true)
end
end
function UI:Toggle()
_v446(not _v528)
end
function UI:Show()
_v446(true)
end
function UI:Hide()
_v446(false)
end
function UI:SetCurrentTarget(name)
if not _v483 then
return
end
if _v483.Visible ~= _v482 then
_v483.Visible = _v482
end
if not _v482 or not targetPanelLabel then
return
end
local _v449, colour
if name and name ~= (_V9({})) and name ~= (_V9({154,239,116,13})) then
_v449, colour = name, (_V9({247,184,46,91,86,2,14}))
else
_v449, colour = (_V9({129,238,81,6,124,55,37})), (_V9({247,184,91,95,80,1,123}))
end
local text = (_V9({128,225,104,15,118,52,113,109,137,178,239,116,28,51,35,36,33,218,166,189,56})) .. colour .. (_V9({246,190})) .. _v449 .. (_V9({232,175,124,7,125,52,117}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v186)
if not fpsLabel or not _v188 or not _v188.Visible then
return
end
local text = string.format((_V9({232,230,117,6,103,96,40,34,217,187,242,39,74,48,120,127,126,240,150,197,56,86,54,36,119,98,211,187,238,110,86,51,38,59,62})), _v186 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v226)
if not _v539 then
return
end
local _v146 = tostring(_v226 or (_V9({}))):match((_V9({241,228,49})))
_v539.Image = _v146 and ((_V9({166,226,98,9,96,51,46,57,220,176,186,53,71})) .. _v146) or (_V9({}))
end
function UI:SyncControls()
for _, _v182 in ipairs(_v472) do
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
local _v499 = _v315((_V9({128,229,98,28,95,33,41,40,217})), {
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
_v315((_V9({129,201,89,7,97,46,46,63})), { Parent = _v499, CornerRadius = UDim.new(0, 8) })
_v315((_V9({129,201,73,28,97,47,32,40})), { Parent = _v499, Color = _v6.accent, Thickness = 1, Transparency = 0.3 })
_v43:Create(_v499, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v161, function()
if _v499 and _v499.Parent then
local _v365 = _v43:Create(_v499, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v365.Completed:Once(function()
if _v499 then
_v499:Destroy()
end
end)
_v365:Play()
end
end)
end
function UI:Cleanup()
_v464()
_v441 = nil
_v453 = nil
_v380 = nil
table.clear(_v381)
for _, _v121 in ipairs(_v511) do
_v121:Disconnect()
end
table.clear(_v511)
table.clear(_v296)
table.clear(_v402)
table.clear(_v472)
_v53 = nil
_v102 = false
_v55 = nil
_v483, targetPanelLabel = nil, nil
_v482 = false
_v246 = nil
_v539 = nil
_v188, fpsLabel = nil, nil
_v544 = nil
if _v200 then
_v200:Destroy()
_v200 = nil
_v267 = nil
end
_v528 = false
end
return UI
end)()
Movement = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v44 = game:GetService((_V9({129,243,127,26,90,46,59,56,193,135,229,104,30,122,35,46})))
local _v48 = game:GetService((_V9({131,239,104,3,96,48,42,46,208})))
local _v26 = _v31.LocalPlayer
local UI = UI
local Movement = {}
local _v5 = 16
local _v23 = 50
local _v302
local _v300
local _v306 = 0
local function _v299()
local _v110 = _v26.Character
local root = _v110 and _v110:FindFirstChild((_V9({156,245,119,9,125,47,34,41,231,187,239,110,56,114,50,63})))
local humanoid = _v110 and _v110:FindFirstChildOfClass((_V9({156,245,119,9,125,47,34,41})))
if not (_v110 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v110, root, humanoid
end
local function _v301(_v93)
local _v264 = _v93.CFrame.LookVector
local _v178 = Vector3.new(_v264.X, 0, _v264.Z)
if _v178.Magnitude < 0.001 then
_v178 = Vector3.new(0, 0, -1)
else
_v178 = _v178.Unit
end
local right = _v93.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v295 = Vector3.zero
if _v44:IsKeyDown(Enum.KeyCode.W) then
_v295 = _v295 + _v178
end
if _v44:IsKeyDown(Enum.KeyCode.S) then
_v295 = _v295 - _v178
end
if _v44:IsKeyDown(Enum.KeyCode.D) then
_v295 = _v295 + right
end
if _v44:IsKeyDown(Enum.KeyCode.A) then
_v295 = _v295 - right
end
if _v44:IsKeyDown(Enum.KeyCode.Space) then
_v295 = _v295 + Vector3.yAxis
end
if _v44:IsKeyDown(Enum.KeyCode.LeftShift) then
_v295 = _v295 - Vector3.yAxis
end
if _v295.Magnitude > 0 then
return _v295.Unit
end
return nil
end
local _v29 = 0.1
local _v30 = 0.15
local function _v305()
return (os.clock() % (_v29 + _v30)) < _v29
end
function Movement:Update(_v160, _v118)
local _v110, root, humanoid = _v299()
if _v118.NoclipEnabled and _v110 then
local _v318 = _v110:GetDescendants()
for i = 1, #_v318 do
local _v368 = _v318[i]
if _v368:IsA((_V9({150,225,105,13,67,33,57,57}))) then
_v368.CanCollide = false
end
end
end
if not root then
return
end
if _v118.FlyEnabled then
local _v93 = _v48.CurrentCamera
if _v93 then
local _v527 = Vector3.zero
if not UI:IsCapturingKey() then
local _v147 = _v301(_v93)
if _v147 then
local _v455 = _v118.FlySpeed or 50
if not _v305() then
_v455 = math.min(_v455, _v5)
end
_v527 = _v147 * _v455
end
end
root.AssemblyLinearVelocity = _v527
end
return
end
if _v118.SpeedEnabled then
local _v455 = _v118.Speed or _v5
local _v295 = humanoid.MoveDirection
if _v455 > _v5 and _v295.Magnitude > 0 and _v305() then
local _v527 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v295.X * _v455, _v527.Y, _v295.Z * _v455)
end
end
end
local function _v304(_v118)
if not _v118.InfJumpEnabled then
return
end
local _, root = _v299()
if root then
local _v527 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v527.X, _v23, _v527.Z)
end
end
local _v41 = 10
local _v40 = 0.05
function Movement.TeleportTo(_v384)
local _v142 = _v384 + Vector3.new(0, 3, 0)
_v306 = _v306 + 1
local _v501 = _v306
task.spawn(function()
while _v501 == _v306 do
local _, currentRoot = _v299()
if not currentRoot then
return
end
local _v336 = _v142 - currentRoot.CFrame.Position
if _v336.Magnitude <= _v41 then
currentRoot.CFrame = CFrame.new(_v142)
return
end
currentRoot.CFrame = currentRoot.CFrame + _v336.Unit * _v41
task.wait(_v40)
end
end)
end
local function _v303(_v118, _v229, _v193)
if _v193 or UI:IsCapturingKey() then
return
end
if not _v118.ClickTPEnabled then
return
end
if _v229.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v44:IsKeyDown(_v118.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _v294 = _v26:GetMouse()
if _v294 and _v294.Hit then
Movement.TeleportTo(_v294.Hit.Position)
end
end
function Movement:Init(_v118)
if not _v302 then
_v302 = _v44.JumpRequest:Connect(function()
_v304(_v118)
end)
end
if not _v300 then
_v300 = _v44.InputBegan:Connect(function(_v229, _v193)
_v303(_v118, _v229, _v193)
end)
end
end
function Movement:Cleanup()
if _v302 then
_v302:Disconnect()
_v302 = nil
end
if _v300 then
_v300:Disconnect()
_v300 = nil
end
end
return Movement
end)()
_v13 = (function()
local _v31 = game:GetService((_V9({132,236,123,17,118,50,56})))
local _v36 = game:GetService((_V9({134,245,116,59,118,50,61,36,214,177})))
local _v44 = game:GetService((_V9({129,243,127,26,90,46,59,56,193,135,229,104,30,122,35,46})))
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
_v13.Version = (_V9({229,174,42,70,35}))
_v13.Config = _v12
UI.TeleportTo = Movement.TeleportTo
_v47.Version = _v13.Version
local _v418 = false
local _v122 = {}
local _v61 = false
local _v32 = _v10.RandomName()
local _v198 = {}
local _v20 = 5
local function _v199(name, _v182, ...)
local _v337, res = pcall(_v182, ...)
if _v337 then
local _v459 = _v198[name]
if _v459 then
_v459.failures = 0
end
return true, res
end
local _v459 = _v198[name]
if not _v459 then
_v459 = { failures = 0, lastWarn = -math.huge }
_v198[name] = _v459
end
_v459.failures = _v459.failures + 1
local _v320 = os.clock()
if _v320 - _v459.lastWarn >= _v20 then
_v459.lastWarn = _v320
warn(string.format((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,144,167,160,124,9,122,44,46,41,149,252,248,63,12,58,122,107,104,198})), name, _v459.failures, tostring(res)))
end
return false, nil
end
function _v13.IsRunning()
return _v418
end
function _v13.SaveConfig(name)
return _v11.save(name, _v12)
end
function _v13.LoadConfig(name)
local _v337, res = _v11.load(name, _v12)
if _v337 then
pcall(function()
UI:SyncControls()
end)
end
return _v337, res
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
function _v13.SetWebhook(_v520)
return _v47.SetWebhook(_v520)
end
function _v13.HasWebhook()
return _v47.HasWebhook()
end
function _v13.SendWebhook(content, _v362)
return _v47.SendWebhook(content, _v362)
end
function _v13.SendLoadedEmbed(_v235)
return _v47.SendLoadedEmbed(_v235)
end
function _v13.Start()
if _v418 then
return _v13
end
_v418 = true
local _v337, err = pcall(function()
ESP:Init()
UI:Init(_v12, function()
_v13.Stop()
end)
Movement:Init(_v12.Movement)
SilentAim:Init(_v12)
table.insert(_v122, _v31.PlayerAdded:Connect(function(_v378)
_v199((_V9({132,236,123,17,118,50,10,41,209,177,228})), ESP.OnPlayerAdded, ESP, _v378)
end))
table.insert(_v122, _v31.PlayerRemoving:Connect(function(_v378)
_v199((_V9({132,236,123,17,118,50,25,40,216,187,246,115,6,116})), ESP.OnPlayerRemoving, ESP, _v378)
end))
table.insert(_v122, _v44.InputBegan:Connect(function(_v229, _v193)
if _v193 or UI:IsCapturingKey() then
return
end
_v199((_V9({159,229,99,10,122,46,47,62})), function()
local _v243 = _v229.KeyCode
if _v243 == _v12.UI.MenuKey then
UI:Toggle()
elseif _v243 == _v12.UI.UnloadKey then
_v13.Stop()
else
local _v500 = {
{ _v12.Camera, (_V9({145,238,123,10,127,37,47})), _v12.Camera.ToggleKey },
{ _v12.ESP, (_V9({145,238,123,10,127,37,47})), _v12.ESP.ToggleKey },
{ _v12.Camera, (_V9({146,207,76,43,122,50,40,33,208})), _v12.Camera.FOVCircleKey },
{ _v12.NoRecoil, (_V9({145,238,123,10,127,37,47})), _v12.NoRecoil.ToggleKey },
{ _v12.NoSpread, (_V9({145,238,123,10,127,37,47})), _v12.NoSpread.ToggleKey },
{ _v12.Triggerbot, (_V9({145,238,123,10,127,37,47})), _v12.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v500) do
if _v243 == t[3] then
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
_v199((_V9({151,225,116,12,122,36,42,57,208,167})), _v9.Update, _v9, _v12.Camera, _v12.ESP)
_v199((_V9({145,211,74})), ESP.Update, ESP, _v12.ESP)
local _v339, target = true, nil
if not (UI.IsSpectating and UI.IsSpectating()) then
_v339, target = _v199((_V9({149,233,119,10,124,52})), _v8.Update, _v8, _v12.Camera, _v12.Debug)
end
if not _v339 then
target = nil
end
if _v12.UI.TargetDisplay then
_v199((_V9({128,225,104,15,118,52,107,41,220,167,240,118,9,106})), function()
local _v265 = _v8:GetLookTarget(_v12.ESP, _v12.Camera)
UI:SetCurrentTarget(_v265 and _v265.Name or nil)
end)
end
_v61 = _v12.Camera.Enabled and target ~= nil
_v199((_V9({154,239,73,24,97,37,42,41})), NoSpread.Update, NoSpread, _v12.NoSpread)
_v199((_V9({135,233,118,13,125,52,107,12,220,185})), SilentAim.Update, SilentAim, _v12)
_v199((_V9({128,242,115,15,116,37,57,47,218,160})), Triggerbot.Update, Triggerbot, _v12.Triggerbot, _v12.Camera)
_v199((_V9({153,239,108,13,126,37,37,57})), Movement.Update, Movement, _v160, _v12.Movement)
_v199((_V9({156,233,110,10,124,56})), _v22.Update, _v22, _v12.Hitbox, _v12.Camera)
_v199((_V9({144,242,123,31,122,46,44,109,240,135,208})), _v16.Update, _v16, _v12.Drawing, _v12.Camera)
_v199((_V9({130,233,105,29,114,44,56})), Visuals.Update, Visuals, _v12.Visuals)
_v187 = _v187 + _v160
fpsFrames = fpsFrames + 1
if _v187 >= 0.25 then
local _v186 = math.floor(fpsFrames / _v187 + 0.5)
_v187, fpsFrames = 0, 0
if _v12.UI.FPSCounter then
_v199((_V9({146,208,73,72,112,47,62,35,193,177,242})), UI.UpdateFPS, UI, _v186)
end
end
end))
pcall(function()
_v36:UnbindFromRenderStep(_v32)
end)
pcall(function()
_v36:BindToRenderStep(_v32, Enum.RenderPriority.Camera.Value + 1, function()
_v199((_V9({154,239,72,13,112,47,34,33})), NoRecoil.Update, NoRecoil, _v12.NoRecoil, _v61)
end)
end)
end)
if not _v337 then
warn((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,243,181,233,118,13,119,96,63,34,149,167,244,123,26,103,122})), err)
_v13.Stop()
return _v13
end
if not _v10.HideGlobal((_V9({130,225,116,1,103,57,12,40,219,177,242,123,4})), _v13) and getgenv then
getgenv().VanityGeneral = _v13
end
UI:Notify(string.format((_V9({130,225,116,1,103,57,102,10,208,186,229,104,9,127,96,39,34,212,176,229,126,72,51,162,203,239,149,244,208,104,13,96,51,107,104,198})), _v12.UI.MenuKey.Name), 4)
print(string.format((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,231,161,238,116,1,125,39,107,101,195,241,243,51})), _v13.Version))
print(string.format((_V9({153,229,116,29,41,96,110,62,149,244,252,58,72,80,33,38,40,199,181,186,58,77,96,96,107,49,149,244,213,116,4,124,33,47,119,149,241,243})),
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
if not _v418 then
return _v13
end
_v418 = false
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
print((_V9({143,214,123,6,122,52,50,96,242,177,238,127,26,114,44,22,109,230,160,239,106,24,118,36})))
return _v13
end
function _v13.Toggle()
if _v418 then
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
if _v387 and _v387 ~= _v13 and type(_v387.Stop) == (_V9({178,245,116,11,103,41,36,35})) then
pcall(_v387.Stop)
end
end
pcall(function()
_v13.Start()
end)
return _v13
end
