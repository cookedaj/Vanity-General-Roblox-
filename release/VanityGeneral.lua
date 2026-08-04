local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({30,71,32,254,69,172,178,151,218})
local _v10
local _v9
local Utility
local _v8
local _v7
local ESP
local _v14
local Visuals
local _v50
local Triggerbot
local SilentAim
local Hitbox
local NoRecoil
local NoSpread
local UI
local Movement
local _v11
_v10 = (function()
local _v10 = {}
_v10.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Prediction = 0,
Humanize = true,
Hitbox = (_V9({76,38,78,154,42,193,146,191,141,123,46,71,150,49,201,214,190})),
HitboxOptions = { (_V9({76,38,78,154,42,193,146,191,141,123,46,71,150,49,201,214,190})), (_V9({86,34,65,154})), (_V9({74,40,82,141,42})), (_V9({95,53,77,141})), (_V9({82,34,71,141})) },
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
_v10.NoRecoil = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
AllowAim = false,
ToggleKey = Enum.KeyCode.F2,
}
_v10.NoSpread = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
ToggleKey = Enum.KeyCode.F3,
}
_v10.Triggerbot = {
Enabled = false,
MinDelay = 0.1,
MaxDelay = 0.25,
MaxDistance = 1000,
WallCheck = true,
ToggleKey = Enum.KeyCode.F4,
}
_v10.Movement = {
FlyEnabled = false,
FlySpeed = 50,
NoclipEnabled = false,
SpeedEnabled = false,
Speed = 16,
InfJumpEnabled = false,
ClickTPEnabled = false,
ClickTPKey = Enum.KeyCode.LeftControl,
}
_v10.SilentAim = {
Enabled = false,
}
_v10.Hitbox = {
Enabled = false,
Size = 5,
Transparency = 0.5,
}
_v10.Drawing = {
Boxes = false,
Tracers = false,
BoxColor = Color3.fromRGB(165, 75, 255),
TracerColor = Color3.fromRGB(255, 255, 255),
}
_v10.Visuals = {
Fullbright = false,
NoFog = false,
}
_v10.Utility = {
AntiAFK = true,
}
_v10.ESP = {
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
_v10.UI = {
Scale = 1,
MenuKey = Enum.KeyCode.RightShift,
UnloadKey = Enum.KeyCode.End,
Visible = false,
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
WatermarkImageId = (_V9({47,116,25,198,113,153,132,174,233,38,114,24,198,112,154})),
}
_v10.Webhook = {
Url = (_V9({})),
}
_v10.Debug = false
local _v12 = {
Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Prediction = 0,
Humanize = true,
Hitbox = (_V9({76,38,78,154,42,193,146,191,141,123,46,71,150,49,201,214,190})),
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
function _v10.reset()
for _v427, _v517 in pairs(_v12) do
for _v258, value in pairs(_v517) do
if type(_v515) == (_V9({106,38,66,146,32})) then
local target = _v10[_v427][_v258]
if type(_v471) ~= (_V9({106,38,66,146,32})) then
target = {}
_v10[_v427][_v258] = _v471
end
for k, v in pairs(_v515) do
target[k] = v
end
else
_v10[_v427][_v258] = _v515
end
end
end
end
return _v10
end)()
_v9 = (function()
local _v9 = {}
local _v5 = (_V9({72,38,78,151,49,213,245,242,180,123,53,65,146}))
local _v37 = { (_V9({93,38,77,155,55,205})), (_V9({91,20,112})), (_V9({80,40,114,155,38,195,219,251})), (_V9({80,40,115,142,55,201,211,243})), (_V9({83,40,86,155,40,201,220,227})), (_V9({77,46,76,155,43,216,243,254,183})), (_V9({86,46,84,156,42,212})), (_V9({90,53,65,137,44,194,213})), (_V9({72,46,83,139,36,192,193})), (_V9({75,51,73,146,44,216,203})), (_V9({75,14})) }
local function _v204()
return type(writefile) == (_V9({120,50,78,157,49,197,221,249}))
and type(readfile) == (_V9({120,50,78,157,49,197,221,249}))
and type(listfiles) == (_V9({120,50,78,157,49,197,221,249}))
end
local function _v172()
if type(isfolder) == (_V9({120,50,78,157,49,197,221,249})) and type(makefolder) == (_V9({120,50,78,157,49,197,221,249})) then
if not isfolder(_v5) then
pcall(makefolder, _v5)
end
end
end
local function _v422(name)
return (tostring(_v317 or (_V9({}))):gsub((_V9({69,25,5,137,26,137,159,183,135})), (_V9({}))):gsub((_V9({64,98,83,213})), (_V9({}))):gsub((_V9({59,52,11,218})), (_V9({}))))
end
local function _v371(name)
return _v5 .. (_V9({49,55,82,145,35,197,222,242,133})) .. game.PlaceId .. (_V9({65})) .. _v317 .. (_V9({48,45,83,145,43}))
end
local function _v270(name)
return _v5 .. (_V9({49})) .. _v317 .. (_V9({48,45,83,145,43}))
end
local function _v171(v)
local t = typeof(v)
if t == (_V9({93,40,76,145,55,159})) then
return { __t = (_V9({93,40,76,145,55,159})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({91,41,85,147,12,216,215,250})) then
return { __t = (_V9({91,41,85,147})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({106,38,66,146,32})) then
local _v365 = {}
for k, _v513 in pairs(v) do
if type(_v513) ~= (_V9({120,50,78,157,49,197,221,249})) then
local _v170 = _v171(_v513)
if _v170 ~= nil then
_v365[k] = _v170
end
end
end
return _v365
elseif t == (_V9({112,50,77,156,32,222})) or t == (_V9({109,51,82,151,43,203})) or t == (_V9({124,40,79,146,32,205,220})) then
return v
end
return nil
end
local function _v144(v)
if type(v) ~= (_V9({106,38,66,146,32})) then
return v
end
if v.__t == (_V9({93,40,76,145,55,159})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({91,41,85,147})) then
local _v340, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v340 then
return _v256
end
return nil
end
return v
end
local function _v69(target, _v447)
for k, v in pairs(_v447) do
if type(v) == (_V9({106,38,66,146,32})) and v.__t == nil then
if type(target[k]) == (_V9({106,38,66,146,32})) then
_v69(target[k], v)
end
else
local _v145 = _v144(v)
if _v145 ~= nil then
target[k] = _v145
end
end
end
end
function _v9.isSupported()
return _v204()
end
function _v9.list()
local _v365 = {}
if not _v204() then
return _v365
end
_v172()
local _v340, files = pcall(listfiles, _v5)
if not _v340 or type(_v186) ~= (_V9({106,38,66,146,32})) then
return _v365
end
for _, _v370 in ipairs(_v186) do
local _v382 = (_V9({110,53,79,152,44,192,215,200})) .. game.PlaceId .. (_V9({65}))
local name = tostring(_v370):match((_V9({54,28,126,209,25,241,153,190,255,48,45,83,145,43,136})))
if _v317 and name:sub(1, #_v382) == _v382 then
table.insert(_v365, name:sub(#_v382 + 1))
end
end
table.sort(_v365)
return _v365
end
function _v9.save(name, _v122)
if not _v204() then
return false, (_V9({74,47,73,141,101,201,202,242,185,107,51,79,140,101,196,211,228,250,112,40,0,152,44,192,215,183,155,78,14}))
end
name = _v422(_v317)
if _v317 == (_V9({})) then
return false, (_V9({91,41,84,155,55,140,211,183,185,113,41,70,151,34,140,220,246,183,123}))
end
_v172()
local data = {}
for _, _v427 in ipairs(_v37) do
if type(_v122[_v427]) == (_V9({106,38,66,146,32})) then
data[_v427] = _v171(_v122[_v427])
end
end
local _v344, json = pcall(function()
return game:GetService((_V9({86,51,84,142,22,201,192,225,179,125,34}))):JSONEncode(_v135)
end)
if not _v344 then
return false, (_V9({91,41,67,145,33,201,146,241,187,119,43,69,154,127,140})) .. tostring(_v257)
end
local _v347, err = pcall(writefile, _v371(_v317), _v257)
if not _v347 then
return false, (_V9({73,53,73,138,32,140,212,246,179,114,34,68,196,101})) .. tostring(_v176)
end
return true, _v317
end
function _v9.load(name, _v122)
if not _v204() then
return false, (_V9({74,47,73,141,101,201,202,242,185,107,51,79,140,101,196,211,228,250,112,40,0,152,44,192,215,183,155,78,14}))
end
name = _v422(_v317)
if _v317 == (_V9({})) then
return false, (_V9({91,41,84,155,55,140,211,183,185,113,41,70,151,34,140,220,246,183,123}))
end
local _v370 = _v371(_v317)
if type(isfile) == (_V9({120,50,78,157,49,197,221,249})) then
local _v343, exists = pcall(isfile, _v370)
if _v343 and not _v182 then
local _v268 = _v270(_v317)
local _v345, legacyExists = pcall(isfile, _v268)
if _v345 and _v269 then
_v370 = _v268
else
return false, (_V9({80,40,0,157,42,194,212,254,189,62,41,65,147,32,200,146,176})) .. _v317 .. (_V9({57}))
end
end
end
local _v346, raw = pcall(readfile, _v370)
if not _v346 or type(_v388) ~= (_V9({109,51,82,151,43,203})) then
return false, (_V9({76,34,65,154,101,202,211,254,182,123,35}))
end
local _v344, data = pcall(function()
return game:GetService((_V9({86,51,84,142,22,201,192,225,179,125,34}))):JSONDecode(_v388)
end)
if not _v344 or type(_v135) ~= (_V9({106,38,66,146,32})) then
return false, (_V9({74,47,65,138,101,202,219,251,191,62,46,83,144,98,216,146,225,187,114,46,68,222,15,255,253,217}))
end
for _, _v427 in ipairs(_v37) do
if type(data[_v427]) == (_V9({106,38,66,146,32})) and type(_v122[_v427]) == (_V9({106,38,66,146,32})) then
_v69(_v122[_v427], data[_v427])
end
end
return true, _v317
end
function _v9.delete(name)
name = _v422(_v317)
if _v317 == (_V9({})) then
return false, (_V9({91,41,84,155,55,140,211,183,185,113,41,70,151,34,140,220,246,183,123}))
end
if type(delfile) ~= (_V9({120,50,78,157,49,197,221,249})) then
return false, (_V9({74,47,73,141,101,201,202,242,185,107,51,79,140,101,207,211,249,253,106,103,68,155,41,201,198,242,250,120,46,76,155,54}))
end
local _v340, err = pcall(delfile, _v371(_v317))
if not _v340 then
return false, tostring(_v176)
end
return true, _v317
end
return _v9
end)()
Utility = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v42 = game:GetService((_V9({74,34,76,155,53,195,192,227,137,123,53,86,151,38,201})))
local _v26 = _v31.LocalPlayer
local Utility = {}
local _v42 = game:GetService((_V9({74,34,76,155,53,195,192,227,137,123,53,86,151,38,201})))
local _v512
function Utility:Init(_v122)
if _v512 then
return
end
local _v533 = (type(VirtualUser) ~= (_V9({112,46,76})) and VirtualUser) or nil
if not _v533 then
pcall(function()
_v533 = game:GetService((_V9({72,46,82,138,48,205,222,194,169,123,53})))
end)
end
if not _v533 then
return
end
_v512 = _v26.Idled:Connect(function()
if _v122.AntiAFK then
_v533:CaptureController()
_v533:ClickButton2(Vector2.new())
end
end)
end
function Utility:Cleanup()
if _v512 then
_v512:Disconnect()
_v512 = nil
end
end
function Utility:ServerHop()
local _v340, err = pcall(function()
_v42:Teleport(game.PlaceId, _v26)
end)
if not _v340 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,137,123,53,86,155,55,140,218,248,170,62,33,65,151,41,201,214,173})), _v176)
end
return _v340
end
function Utility:Rejoin()
local _v340, err = pcall(function()
_v42:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v26)
end)
if not _v340 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,136,123,45,79,151,43,140,212,246,179,114,34,68,196})), _v176)
end
return _v340
end
function Utility.getGuiParent()
local _v340, hidden = pcall(function()
return gethui and gethui()
end)
if _v340 and _v227 then
return _v227
end
local _v341, coreGui = pcall(function()
return game:GetService((_V9({93,40,82,155,2,217,219})))
end)
if _v341 and _v129 then
return _v129
end
return _v26:WaitForChild((_V9({78,43,65,135,32,222,245,226,179})))
end
return _v47
end)()
_v8 = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v51 = game:GetService((_V9({73,40,82,149,54,220,211,244,191})))
local _v26 = _v31.LocalPlayer
local _v8 = {}
_v8.LocalRootPos = nil
local frame = {}
local _v3 = 0.5
local _v79 = {}
local _v80 = -math.huge
function _v8.GetBotCharacters()
local _v324 = os.clock()
if _v324 - _v80 < _v3 then
return _v79
end
_v80 = _v324
table.clear(_v79)
for _, _v147 in ipairs(_v51:GetDescendants()) do
if _v147:IsA((_V9({83,40,68,155,41})))
and _v147:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
and not _v31:GetPlayerFromCharacter(_v147)
then
table.insert(_v79, _v147)
end
end
return _v79
end
local function _v414(_v112, humanoid)
return humanoid.RootPart
or _v112:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
or _v112:FindFirstChild((_V9({74,40,82,141,42})))
or _v112:FindFirstChild((_V9({75,55,80,155,55,248,221,229,169,113})))
or _v112.PrimaryPart
end
local _v34 = {
Head = { (_V9({86,34,65,154})) },
Torso = { (_V9({75,55,80,155,55,248,221,229,169,113})), (_V9({82,40,87,155,55,248,221,229,169,113})), (_V9({74,40,82,141,42})), (_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})) },
Arms = {
(_V9({82,34,70,138,13,205,220,243})), (_V9({76,46,71,150,49,228,211,249,190})),
(_V9({82,34,70,138,9,195,197,242,168,95,53,77})), (_V9({76,46,71,150,49,224,221,224,191,108,6,82,147})),
(_V9({82,34,70,138,16,220,194,242,168,95,53,77})), (_V9({76,46,71,150,49,249,194,231,191,108,6,82,147})),
(_V9({82,34,70,138,101,237,192,250})), (_V9({76,46,71,150,49,140,243,229,183})),
},
Legs = {
(_V9({82,34,70,138,3,195,221,227})), (_V9({76,46,71,150,49,234,221,248,174})),
(_V9({82,34,70,138,9,195,197,242,168,82,34,71})), (_V9({76,46,71,150,49,224,221,224,191,108,11,69,153})),
(_V9({82,34,70,138,16,220,194,242,168,82,34,71})), (_V9({76,46,71,150,49,249,194,231,191,108,11,69,153})),
(_V9({82,34,70,138,101,224,215,240})), (_V9({76,46,71,150,49,140,254,242,189})),
},
}
local _v33 = { (_V9({86,34,65,154})), (_V9({74,40,82,141,42})), (_V9({95,53,77,141})), (_V9({82,34,71,141})) }
local function _v374(_v112, _v394)
local _v320 = _v34[_v394]
if not _v320 then
return nil
end
for _, name in ipairs(_v320) do
local _v369 = _v112:FindFirstChild(_v317)
if _v369 and _v369:IsA((_V9({92,38,83,155,21,205,192,227}))) then
return _v369
end
end
return nil
end
local function _v373(_v112)
for _, _v394 in ipairs(_v33) do
local _v369 = _v374(_v112, _v394)
if _v369 then
return _v369
end
end
for _, _v147 in ipairs(_v112:GetDescendants()) do
if _v147:IsA((_V9({92,38,83,155,21,205,192,227}))) then
return _v147
end
end
return nil
end
local function _v66(_v112, _v220, hrp)
return _v220
or _v235
or _v112:FindFirstChild((_V9({75,55,80,155,55,248,221,229,169,113})))
or _v112:FindFirstChild((_V9({74,40,82,141,42})))
or _v373(_v112)
end
local function _v90(_v112, _v378, _v97, _v98)
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
if not _v241 or humanoid.Health <= 0 then
return nil
end
local _v220 = _v112:FindFirstChild((_V9({86,34,65,154})))
local hrp = _v112:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
local _v413 = _v414(_v112, _v241)
local _v65 = _v66(_v112, _v220, _v235)
local _v175 = {
Player = _v378,
Character = _v112,
Humanoid = _v241,
Head = _v220,
RootPart = _v413,
HRP = _v235,
Anchor = _v65,
}
if _v65 then
_v175.WorldDistance = (_v65.Position - _v98).Magnitude
local _v457, vis = _v97:WorldToViewportPoint(_v65.Position)
_v175.AnchorScreen = _v457
_v175.AnchorOnScreen = _v521
end
if _v413 then
local _v493 = _v220 and (_v220.Position + Vector3.new(0, _v220.Size.Y, 0))
or (_v413.Position + Vector3.new(0, 3, 0))
local _v498, tvis = _v97:WorldToViewportPoint(_v493)
_v175.TopScreen = _v498
_v175.TopOnScreen = _v499
_v175.BotScreen = _v97:WorldToViewportPoint(_v413.Position - Vector3.new(0, 3.2, 0))
end
return _v175
end
function _v8:Update(_v99, _v178)
table.clear(_v202)
local _v97 = _v51.CurrentCamera
local _v314 = _v26.Character
local _v315 = _v314 and _v314:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
_v8.LocalRootPos = _v315 and _v315.Position or nil
if not _v97 then
return
end
local _v98 = _v97.CFrame.Position
for _, _v378 in ipairs(_v31:GetPlayers()) do
if _v378 ~= _v26 then
local _v175 = _v90(_v378.Character, _v378, _v97, _v98)
if _v175 then
table.insert(_v202, _v175)
end
end
end
if _v99 and _v99.TargetBots then
for _, _v112 in ipairs(_v8.GetBotCharacters()) do
local _v175 = _v90(_v112, nil, _v97, _v98)
if _v175 then
table.insert(_v202, _v175)
end
end
end
end
function _v8:Get()
return _v202
end
return _v8
end)()
_v7 = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v51 = game:GetService((_V9({73,40,82,149,54,220,211,244,191})))
local _v26 = _v31.LocalPlayer
local Utility = _v47
local _v8 = _v8
local _v7 = {}
local Camera = _v51.CurrentCamera
local _v107 = Random.new()
local _v34 = {
Head = { (_V9({86,34,65,154})) },
Torso = { (_V9({75,55,80,155,55,248,221,229,169,113})), (_V9({82,40,87,155,55,248,221,229,169,113})), (_V9({74,40,82,141,42})), (_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})) },
Arms = {
(_V9({82,34,70,138,13,205,220,243})), (_V9({76,46,71,150,49,228,211,249,190})),
(_V9({82,34,70,138,9,195,197,242,168,95,53,77})), (_V9({76,46,71,150,49,224,221,224,191,108,6,82,147})),
(_V9({82,34,70,138,16,220,194,242,168,95,53,77})), (_V9({76,46,71,150,49,249,194,231,191,108,6,82,147})),
(_V9({82,34,70,138,101,237,192,250})), (_V9({76,46,71,150,49,140,243,229,183})),
},
Legs = {
(_V9({82,34,70,138,3,195,221,227})), (_V9({76,46,71,150,49,234,221,248,174})),
(_V9({82,34,70,138,9,195,197,242,168,82,34,71})), (_V9({76,46,71,150,49,224,221,224,191,108,11,69,153})),
(_V9({82,34,70,138,16,220,194,242,168,82,34,71})), (_V9({76,46,71,150,49,249,194,231,191,108,11,69,153})),
(_V9({82,34,70,138,101,224,215,240})), (_V9({76,46,71,150,49,140,254,242,189})),
},
}
local _v33 = { (_V9({86,34,65,154})), (_V9({74,40,82,141,42})), (_V9({95,53,77,141})), (_V9({82,34,71,141})) }
local _v409 = Random.new()
local function _v374(_v112, _v394)
local _v320 = _v34[_v394]
if not _v320 then
return nil
end
for _, name in ipairs(_v320) do
local _v369 = _v112:FindFirstChild(_v317)
if _v369 and _v369:IsA((_V9({92,38,83,155,21,205,192,227}))) then
return _v369
end
end
return nil
end
local function _v373(_v112)
for _, _v394 in ipairs(_v33) do
local _v369 = _v374(_v112, _v394)
if _v369 then
return _v369
end
end
for _, _v147 in ipairs(_v112:GetDescendants()) do
if _v147:IsA((_V9({92,38,83,155,21,205,192,227}))) then
return _v147
end
end
return nil
end
local function _v67(_v112)
return _v112:FindFirstChild((_V9({86,34,65,154})))
or _v112:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
or _v112:FindFirstChild((_V9({75,55,80,155,55,248,221,229,169,113})))
or _v112:FindFirstChild((_V9({74,40,82,141,42})))
or _v373(_v112)
end
local function _v411(_v536)
local _v494 = 0
for _, _v394 in ipairs(_v33) do
_v494 = _v494 + math.max(0, (_v536 and _v536[_v394]) or 0)
end
if _v494 <= 0 then
return (_V9({86,34,65,154}))
end
local _v410 = _v409:NextNumber() * _v494
local _v52 = 0
for _, _v394 in ipairs(_v33) do
_v52 = _v52 + math.max(0, _v536[_v394] or 0)
if _v410 <= _v52 then
return _v394
end
end
return (_V9({86,34,65,154}))
end
local function _v210(_v542)
local _v520, visible = Camera:WorldToViewportPoint(_v542)
if not _v522 or _v520.Z < 0 then
return math.huge
end
local _v425 = Vector2.new(_v520.X, _v520.Y)
local _v108 = Camera.ViewportSize / 2
return (_v425 - _v108).Magnitude
end
local function _v255(_v381, _v112)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
local _v405 = _v51:Raycast(Camera.CFrame.Position, _v381 - Camera.CFrame.Position, _v367)
return not _v405 or _v405.Instance:IsDescendantOf(_v112)
end
local _v17 = Color3.fromRGB(132, 62, 190)
local _v193, _v194, fovStroke
local function _v173()
if _v194 and _v194.Parent then
return _v194
end
_v193 = Instance.new((_V9({77,36,82,155,32,194,245,226,179})))
_v193.Name = (_V9({72,38,78,151,49,213,245,242,180,123,53,65,146,3,227,228}))
_v193.ResetOnSpawn = false
_v193.IgnoreGuiInset = true
_v193.DisplayOrder = 998
local _v340 = pcall(function()
_v193.Parent = Utility.getGuiParent()
end)
if not _v340 or not _v193.Parent then
_v193.Parent = _v26:WaitForChild((_V9({78,43,65,135,32,222,245,226,179})))
end
_v194 = Instance.new((_V9({88,53,65,147,32})))
_v194.Name = (_V9({76,46,78,153}))
_v194.AnchorPoint = Vector2.new(0.5, 0.5)
_v194.Position = UDim2.fromScale(0.5, 0.5)
_v194.BackgroundTransparency = 1
_v194.BorderSizePixel = 0
_v194.Parent = _v193
local _v130 = Instance.new((_V9({75,14,99,145,55,194,215,229})))
_v130.CornerRadius = UDim.new(1, 0)
_v130.Parent = _v194
fovStroke = Instance.new((_V9({75,14,115,138,55,195,217,242})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v17
fovStroke.Parent = _v194
return _v194
end
local function _v507(_v122)
local _v437 = _v122.FOVCircle
if not _v437 then
if _v194 then
_v194.Visible = false
end
return
end
local _v408 = _v173()
if not _v408 then
return
end
local _v151 = math.max(0, _v122.FOV or 0) * 2
_v408.Size = UDim2.fromOffset(_v151, _v151)
_v408.Visible = true
end
local function _v150()
if _v193 then
pcall(function()
_v193:Destroy()
end)
end
_v193, _v194, fovStroke = nil, nil, nil
end
local function _v181(_v112, _v378, _v122)
if not _v112 then
return nil
end
if _v122.TeamCheck and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team then
return nil
end
local humanoid = _v112:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
if not _v241 or humanoid.Health <= 0 then
return nil
end
local _v65 = _v67(_v112)
if not _v65 then
return nil
end
local _v157 = _v210(_v65.Position)
if _v157 >= (_v122.FOV or 200) then
return nil
end
local _v541 = (_v65.Position - Camera.CFrame.Position).Magnitude
if _v541 > _v122.MaxDistance then
return nil
end
if _v122.WallCheck and not _v255(_v65.Position, _v112) then
return nil
end
return { Player = _v378, Character = _v112, Anchor = _v65, ScreenDistance = _v157 }
end
local function _v426(_v101)
if not _v101.AnchorOnScreen or _v101.AnchorScreen.Z < 0 then
return math.huge
end
local _v425 = Vector2.new(_v101.AnchorScreen.X, _v101.AnchorScreen.Y)
local _v108 = Camera.ViewportSize / 2
return (_v425 - _v108).Magnitude
end
local function _v180(_v101, _v122)
local _v378 = _v101.Player
if _v122.TeamCheck and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team then
return nil
end
local _v65 = _v101.Anchor
if not _v65 then
return nil
end
local _v157 = _v426(_v101)
if _v157 >= (_v122.FOV or 200) then
return nil
end
if (_v101.WorldDistance or math.huge) > _v122.MaxDistance then
return nil
end
if _v122.WallCheck and not _v255(_v65.Position, _v101.Character) then
return nil
end
return { Player = _v378, Character = _v101.Character, Anchor = _v65, ScreenDistance = _v157 }
end
function _v7:FindBestTarget(_v122)
local _v76
local _v77 = math.huge
for _, _v101 in ipairs(_v8:Get()) do
local _v102 = _v180(_v101, _v122)
if _v102 and _v102.ScreenDistance < _v77 then
_v77 = _v102.ScreenDistance
_v76 = _v102
end
end
return _v76
end
local _v24 = 50
function _v7:GetLookTarget(_v178, _v99)
local _v76
local _v77 = _v24
local _v316 = _v8.LocalRootPos
local _v297 = (_v178 and _v178.MaxDistance) or math.huge
local _v485 = _v99 and _v99.TeamCheck
for _, _v101 in ipairs(_v8:Get()) do
local _v378 = _v101.Player
if not (_v485 and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team) then
local _v65 = _v101.Anchor
if _v65 and not (_v316 and (_v65.Position - _v316).Magnitude > _v297) then
local _v157 = _v426(_v101)
if _v157 <= _v77 then
_v77 = _v157
_v76 = _v378 or _v101.Character
end
end
end
end
return _v76
end
function _v7:_resolveRegion(_v112, _v122)
local _v302 = _v122.Hitbox
if _v302 and _v302 ~= (_V9({76,38,78,154,42,193,146,191,141,123,46,71,150,49,201,214,190})) and _v34[_v302] then
return _v302
end
if self._lockedChar ~= _v112 then
self._lockedChar = _v112
self._rolledRegion = _v411(_v122.TargetWeights)
end
return self._rolledRegion or (_V9({86,34,65,154}))
end
function _v7:PointCamera(_v475, _v443)
local _v148 = CFrame.lookAt(Camera.CFrame.Position, _v475)
local _v64 = math.clamp(1 - (_v443 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v148, _v64)
end
function _v7:Update(_v122, debug)
Camera = _v51.CurrentCamera
_v507(_v122)
if not _v122.Enabled then
self._lockedChar = nil
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
return
end
if not _v6 then
return
end
local target
if _v122.StickyTarget and self._stickyCharacter then
if not self._stickyPlayer or self._stickyPlayer.Parent == _v31 then
target = _v181(self._stickyCharacter, self._stickyPlayer, _v122)
end
end
if not _v471 then
target = self:FindBestTarget(_v122)
end
if not _v471 then
self._lockedChar = nil
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
return
end
self._stickyCharacter = target.Character
self._stickyPlayer = target.Player
local _v394 = self:_resolveRegion(target.Character, _v122)
local _v60 = _v374(target.Character, _v394) or _v373(target.Character)
if not _v60 then
self._currentTarget = nil
return
end
local _v61 = _v60.Position
local _v541 = (_v61 - Camera.CFrame.Position).Magnitude
if (_v122.Prediction or 0) > 0 then
_v61 = _v61 + _v60.AssemblyLinearVelocity * _v122.Prediction * (_v541 / 500)
end
local _v443 = _v122.Smoothness
if _v122.Humanize then
_v443 = _v443 * (0.9 + _v107:NextNumber() * 0.2)
_v61 = _v61 + _v107:NextUnitVector() * (_v541 * math.rad(_v107:NextNumber() * 0.25))
end
self:PointCamera(_v61, _v443)
target.Part = _v60
target.Region = _v394
self._currentTarget = _v471
if debug then
print((_V9({74,53,65,157,46,197,220,240,224})), target.Character.Name, (_V9({76,34,71,151,42,194,136})), _v394, (_V9({90,46,83,138,36,194,209,242,224})), math.floor(target.ScreenDistance))
end
return _v471
end
function _v7:GetCurrentTarget()
return self._currentTarget
end
function _v7:Cleanup()
self._lockedChar = nil
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
_v150()
end
_v7.GetBotCharacters = _v8.GetBotCharacters
return _v7
end)()
ESP = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v51 = game:GetService((_V9({73,40,82,149,54,220,211,244,191})))
local _v26 = _v31.LocalPlayer
local _v10 = _v10
local Utility = _v47
local _v8 = _v8
local ESP = {}
local _v174 = {}
local _v127
local _v85
local _v13 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v249(humanoid)
return _v241 and humanoid.Health > 0
end
local function _v179(_v112)
local _v240 = _v112:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
return (_v240 and _v240.RootPart)
or _v112:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
or _v112:FindFirstChild((_V9({74,40,82,141,42})))
or _v112:FindFirstChild((_V9({75,55,80,155,55,248,221,229,169,113})))
or _v112.PrimaryPart
end
local function _v207()
if _v85 and _v85.Parent then
return _v85
end
_v85 = Instance.new((_V9({77,36,82,155,32,194,245,226,179})))
_v85.Name = (_V9({72,38,78,151,49,213,245,242,180,123,53,65,146,7,195,202,242,169}))
_v85.ResetOnSpawn = false
_v85.IgnoreGuiInset = true
_v85.DisplayOrder = 996
local _v340 = pcall(function()
_v85.Parent = Utility.getGuiParent()
end)
if not _v340 or not _v85.Parent then
_v85.Parent = _v26:WaitForChild((_V9({78,43,65,135,32,222,245,226,179})))
end
return _v85
end
local function _v506(_v175, _v112, _v122, _v101)
local _v97 = _v51.CurrentCamera
local root = _v101 and _v101.RootPart or _v179(_v112)
if not _v97 or not _v412 or not _v175.box then
if _v175.box then
_v175.box.Visible = false
end
return
end
local _v492, onScreen, botV
if _v101 then
if not _v101.TopScreen then
_v175.box.Visible = false
return
end
_v492, onScreen, botV = _v101.TopScreen, _v101.TopOnScreen, _v101.BotScreen
else
local _v220 = _v112:FindFirstChild((_V9({86,34,65,154})))
local _v493 = _v220 and (_v220.Position + Vector3.new(0, _v220.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v82 = root.Position - Vector3.new(0, 3.2, 0)
_v492, onScreen = _v97:WorldToViewportPoint(_v493)
botV = _v97:WorldToViewportPoint(_v82)
end
if not _v353 or _v492.Z <= 0 then
_v175.box.Visible = false
return
end
local _v224 = math.abs(botV.Y - _v492.Y)
local _v537 = _v224 * 0.62
local _v133 = (_v492.X + botV.X) * 0.5
local _v134 = (_v492.Y + botV.Y) * 0.5
_v175.box.Size = UDim2.fromOffset(_v537, _v224)
_v175.box.Position = UDim2.fromOffset(_v133 - _v537 * 0.5, _v134 - _v224 * 0.5)
_v175.box.BackgroundColor3 = _v122.FillColor
_v175.box.BackgroundTransparency = _v122.Filled and (1 - _v122.FillOpacity) or 1
_v175.boxStroke.Color = _v122.OutlineColor
_v175.boxStroke.Transparency = 1 - _v122.OutlineOpacity
_v175.box.Visible = true
end
local function _v288(_v175, name, _v220, _v122)
local _v470 = Instance.new((_V9({92,46,76,146,39,195,211,229,190,89,50,73})))
_v470.Name = (_V9({72,0,105,144,35,195}))
_v470.Size = UDim2.fromOffset(200, 46)
_v470.StudsOffset = Vector3.new(0, 2.7, 0)
_v470.AlwaysOnTop = true
_v470.Adornee = _v220
_v470.Parent = _v220
local _v231 = Instance.new((_V9({88,53,65,147,32})))
_v231.BackgroundTransparency = 1
_v231.Size = UDim2.fromScale(1, 1)
_v231.Parent = _v470
local _v265 = Instance.new((_V9({75,14,108,151,54,216,254,246,163,113,50,84})))
_v265.SortOrder = Enum.SortOrder.LayoutOrder
_v265.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v265.VerticalAlignment = Enum.VerticalAlignment.Center
_v265.Parent = _v231
local _v319 = Instance.new((_V9({74,34,88,138,9,205,208,242,182})))
_v319.LayoutOrder = 1
_v319.BackgroundTransparency = 1
_v319.Size = UDim2.new(1, 0, 0, 16)
_v319.Font = Enum.Font.GothamBold
_v319.TextSize = 13
_v319.TextColor3 = _v122.OutlineColor
_v319.TextStrokeTransparency = 0.35
_v319.Text = _v317
_v319.Visible = false
_v319.Parent = _v231
local _v156 = Instance.new((_V9({74,34,88,138,9,205,208,242,182})))
_v156.LayoutOrder = 2
_v156.BackgroundTransparency = 1
_v156.Size = UDim2.new(1, 0, 0, 14)
_v156.Font = Enum.Font.Gotham
_v156.TextSize = 12
_v156.TextColor3 = _v122.OutlineColor
_v156.TextStrokeTransparency = 0.4
_v156.Text = (_V9({}))
_v156.Visible = false
_v156.Parent = _v231
local _v222 = Instance.new((_V9({88,53,65,147,32})))
_v222.LayoutOrder = 3
_v222.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v222.BackgroundTransparency = 0.3
_v222.BorderSizePixel = 0
_v222.Size = UDim2.new(0.55, 0, 0, 5)
_v222.Visible = false
_v222.Parent = _v231
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v222, CornerRadius = UDim.new(1, 0) })
local _v223 = Instance.new((_V9({88,53,65,147,32})))
_v223.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v223.BorderSizePixel = 0
_v223.Size = UDim2.fromScale(1, 1)
_v223.Parent = _v222
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v223, CornerRadius = UDim.new(1, 0) })
_v175.nameTag = _v470
_v175.nameLabel = _v319
_v175.distanceLabel = _v156
_v175.healthBack = _v222
_v175.healthFill = _v223
_v175.nameHead = _v220
end
local function _v508(name, _v175, _v112, _v122, _v101)
local _v220 = _v101 and (_v101.Head or _v101.HRP)
or _v112:FindFirstChild((_V9({86,34,65,154})))
or _v112:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
if not _v220 then
if _v175.nameTag then
_v175.nameTag.Enabled = false
end
return
end
if not _v175.nameTag or not _v175.nameTag.Parent or _v175.nameHead ~= _v220 then
if _v175.nameTag then
pcall(function()
_v175.nameTag:Destroy()
end)
end
_v288(_v175, _v317, _v220, _v122)
end
_v175.nameLabel.TextColor3 = _v122.OutlineColor
_v175.nameLabel.Visible = _v122.Names or _v122.NameTags
_v175.distanceLabel.Visible = _v122.Distance or _v122.DistanceTags
if _v175.distanceLabel.Visible then
_v175.distanceLabel.TextColor3 = _v122.OutlineColor
local _v316, hrp
if _v101 then
_v316, hrp = _v8.LocalRootPos, _v101.HRP
else
local _v314 = _v26.Character
local _v315 = _v314 and _v314:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
_v316 = _v315 and _v315.Position
hrp = _v112:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
end
local d = (_v316 and _v235) and math.floor((hrp.Position - _v316).Magnitude + 0.5) or 0
_v175.distanceLabel.Text = (_V9({69})) .. d .. (_V9({115,26}))
end
_v175.healthBack.Visible = _v122.HealthBars
if _v122.HealthBars then
local humanoid = _v101 and _v101.Humanoid or _v112:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
local _v201 = _v241 and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v175.healthFill.Size = UDim2.fromScale(_v201, 1)
_v175.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v201)
end
_v175.nameTag.Enabled = true
end
local function _v228(_v175)
_v175.hl.Enabled = false
if _v175.box then
_v175.box.Visible = false
end
if _v175.nameTag then
_v175.nameTag.Enabled = false
end
end
local function _v398(_v175, _v112, name, _v122, _v101)
if _v122.Outlines then
if _v175.hl.Adornee ~= _v112 then
_v175.hl.Adornee = _v112
end
_v175.hl.OutlineColor = _v122.OutlineColor
_v175.hl.FillColor = _v122.FillColor
_v175.hl.OutlineTransparency = 1 - _v122.OutlineOpacity
_v175.hl.FillTransparency = _v122.Filled and (1 - _v122.FillOpacity) or 1
_v175.hl.DepthMode = _v13
_v175.hl.Enabled = true
else
_v175.hl.Enabled = false
end
if _v122.Boxes then
_v506(_v175, _v112, _v122, _v101)
elseif _v175.box then
_v175.box.Visible = false
end
if _v122.Names or _v122.Distance or _v122.NameTags or _v122.DistanceTags or _v122.HealthBars then
_v508(_v317, _v175, _v112, _v122, _v101)
elseif _v175.nameTag then
_v175.nameTag.Enabled = false
end
end
local function _v158(_v369)
local _v314 = _v26.Character
local _v315 = _v314 and _v314:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
if not _v315 or not _v369 then
return 0
end
return (_v369.Position - _v315.Position).Magnitude
end
local function _v510(_v101, _v175, _v122)
local hrp = _v101.HRP
if not _v122.Enabled or not _v235 then
_v228(_v175)
return
end
local _v316 = _v8.LocalRootPos
local _v155 = _v316 and (hrp.Position - _v316).Magnitude or 0
if _v155 > _v122.MaxDistance then
_v228(_v175)
return
end
_v398(_v175, _v101.Character, _v101.Player.Name, _v122, _v101)
end
local function _v321(color)
color = _v119 or Color3.fromRGB(165, 75, 255)
local _v229 = Instance.new((_V9({86,46,71,150,41,197,213,255,174})))
_v229.Name = (_V9({91,20,112,177,48,216,222,254,180,123}))
_v229.Enabled = false
_v229.FillColor = _v119
_v229.OutlineColor = _v119
_v229.Parent = _v127
local box = Instance.new((_V9({88,53,65,147,32})))
box.Name = (_V9({91,20,112,188,42,212}))
box.BackgroundColor3 = _v119
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v207()
local boxStroke = Instance.new((_V9({75,14,115,138,55,195,217,242})))
boxStroke.Color = _v119
boxStroke.Thickness = 1
boxStroke.Parent = _v84
return { hl = _v229, box = _v84, boxStroke = _v86 }
end
local function _v149(_v175)
if _v175.hl then
_v175.hl:Destroy()
end
if _v175.box then
_v175.box:Destroy()
end
if _v175.nameTag then
pcall(function()
_v175.nameTag:Destroy()
end)
end
end
local function _v58(_v378, _v146)
if _v378 == _v26 or _v174[_v378] then
return
end
_v174[_v378] = _v321(_v146)
end
local function _v397(_v378)
local _v175 = _v174[_v378]
if not _v175 then
return
end
_v149(_v175)
_v174[_v378] = nil
end
local _v325 = {}
local _v264 = 0
local _v28 = 1
local function _v396(_v303)
local _v175 = _v325[_v303]
if not _v175 then
return
end
_v149(_v175)
_v325[_v303] = nil
end
local function _v402()
local current = {}
for _, _v339 in ipairs(_v51:GetDescendants()) do
if _v339:IsA((_V9({86,50,77,159,43,195,219,243}))) then
local _v303 = _v339.Parent
if
_v303
and _v303:IsA((_V9({83,40,68,155,41})))
and _v303 ~= _v26.Character
and not _v31:GetPlayerFromCharacter(_v303)
then
current[_v303] = true
if not _v325[_v303] then
_v325[_v303] = _v321(_v10.ESP.OutlineColor)
end
end
end
end
for _v303 in pairs(_v325) do
if not current[_v303] or not _v303.Parent then
_v396(_v303)
end
end
end
local function _v509(_v303, _v175, _v122)
local root = _v179(_v303)
local humanoid = _v303:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
if not _v303.Parent or not _v412 or not _v249(_v241) then
_v228(_v175)
return
end
if _v158(_v412) > _v122.MaxDistance then
_v228(_v175)
return
end
_v398(_v175, _v303, _v303.Name, _v122)
end
function ESP:Init()
if _v127 then
return
end
_v127 = Instance.new((_V9({88,40,76,154,32,222})))
_v127.Name = (_V9({72,38,78,151,49,213,245,242,180,123,53,65,146,0,255,226}))
local _v340 = pcall(function()
_v127.Parent = Utility.getGuiParent()
end)
if not _v340 or not _v127.Parent then
_v127.Parent = _v51
end
for _, _v378 in ipairs(_v31:GetPlayers()) do
_v58(_v378, _v10.ESP.OutlineColor)
end
end
function ESP:Update(_v122)
local _v399 = {}
for _, _v101 in ipairs(_v8:Get()) do
local _v378 = _v101.Player
if _v378 then
_v399[_v378] = true
local _v175 = _v174[_v378]
if not _v175 then
_v58(_v378, _v122.OutlineColor)
_v175 = _v174[_v378]
end
_v510(_v101, _v175, _v122)
end
end
for _v378, _v175 in pairs(_v174) do
if _v378.Parent ~= _v31 then
_v397(_v378)
elseif not _v399[_v378] then
_v228(_v175)
end
end
if _v122.Enabled and _v122.NPCs then
if os.clock() - _v264 >= _v28 then
_v264 = os.clock()
_v402()
end
for _v303, _v175 in pairs(_v325) do
_v509(_v303, _v175, _v122)
end
elseif next(_v325) then
for _v303 in pairs(_v325) do
_v396(_v303)
end
end
end
function ESP:OnPlayerAdded(_v378)
_v58(_v378, _v10.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v378)
_v397(_v378)
end
function ESP:Cleanup()
for _v378 in pairs(_v174) do
_v397(_v378)
end
for _v303 in pairs(_v325) do
_v396(_v303)
end
if _v127 then
_v127:Destroy()
_v127 = nil
end
if _v85 then
_v85:Destroy()
_v85 = nil
end
end
return _v15
end)()
_v14 = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v51 = game:GetService((_V9({73,40,82,149,54,220,211,244,191})))
local _v26 = _v31.LocalPlayer
local _v8 = _v8
local _v14 = {}
local _v136 = type(Drawing) == (_V9({106,38,66,146,32})) and type(Drawing.new) == (_V9({120,50,78,157,49,197,221,249}))
local _v143 = false
local _v137 = {}
local function _v140()
local _v271 = Drawing.new((_V9({82,46,78,155})))
_v271.Thickness = 1
_v271.Visible = false
return _v271
end
local function _v139(_v378)
local _v175 = {
box = { _v140(), _v140(), _v140(), _v140() },
tracer = _v140(),
}
_v137[_v378] = _v175
return _v175
end
local function _v138(_v175)
for _, _v271 in ipairs(_v175.box) do
_v271.Visible = false
end
_v175.tracer.Visible = false
end
local function _v141(_v378)
local _v175 = _v137[_v378]
if not _v175 then
return
end
_v137[_v378] = nil
for _, _v271 in ipairs(_v175.box) do
_v271:Remove()
end
_v175.tracer:Remove()
end
local function _v142(_v101, _v122, _v97, _v99)
local _v378 = _v101.Player
local _v175 = _v137[_v378]
if _v99.TeamCheck and _v378.Team ~= nil and _v378.Team == _v26.Team then
if _v175 then
_v138(_v175)
end
return
end
local root = _v101.HRP
if not (_v122.Boxes or _v122.Tracers) or not _v412 then
if _v175 then
_v138(_v175)
end
return
end
local _v492, onScreen, botV = _v101.TopScreen, _v101.TopOnScreen, _v101.BotScreen
if not _v492 or not _v353 or _v492.Z <= 0 or botV.Z <= 0 then
if _v175 then
_v138(_v175)
end
return
end
_v175 = _v175 or _v139(_v378)
local _v224 = math.abs(botV.Y - _v492.Y)
local _v537 = _v224 * 0.62
local _v133 = (_v492.X + botV.X) * 0.5
local _v267, right = _v133 - _v537 * 0.5, _v133 + _v537 * 0.5
local _v491, bottom = _v492.Y, botV.Y
local box = _v175.box
box[1].From = Vector2.new(_v267, _v491)
box[1].To = Vector2.new(_v407, _v491)
box[2].From = Vector2.new(_v267, _v83)
box[2].To = Vector2.new(_v407, _v83)
box[3].From = Vector2.new(_v267, _v491)
box[3].To = Vector2.new(_v267, _v83)
box[4].From = Vector2.new(_v407, _v491)
box[4].To = Vector2.new(_v407, _v83)
for _, _v271 in ipairs(_v84) do
_v271.Color = _v122.BoxColor
_v271.Visible = _v122.Boxes
end
_v175.tracer.From = Vector2.new(_v97.ViewportSize.X / 2, _v97.ViewportSize.Y)
_v175.tracer.To = Vector2.new(_v133, _v83)
_v175.tracer.Color = _v122.TracerColor
_v175.tracer.Visible = _v122.Tracers
end
function _v14:Update(_v122, _v99)
if not _v136 then
if (_v122.Boxes or _v122.Tracers) and not _v143 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,152,113,63,15,170,55,205,209,242,168,62,2,115,174,101,194,215,242,190,109,103,84,150,32,140,246,229,187,105,46,78,153,101,192,219,245,168,127,53,89,222,167,44,38,183,180,113,51,0,159,51,205,219,251,187,124,43,69,222,44,194,146,227,178,119,52,0,155,61,201,209,226,174,113,53,14})))
_v143 = true
end
return
end
local _v97 = _v51.CurrentCamera
if not _v97 then
return
end
local _v428 = {}
for _, _v101 in ipairs(_v8:Get()) do
if _v101.Player then
_v428[_v101.Player] = true
_v142(_v101, _v122, _v97, _v99)
end
end
for _v378, _v175 in pairs(_v137) do
if _v378.Parent ~= _v31 then
_v141(_v378)
elseif not _v428[_v378] then
_v138(_v175)
end
end
end
function _v14:Cleanup()
for _v378 in pairs(_v137) do
_v141(_v378)
end
end
return _v14
end)()
Visuals = (function()
local _v25 = game:GetService((_V9({82,46,71,150,49,197,220,240})))
local Visuals = {}
local _v25 = game:GetService((_V9({82,46,71,150,49,197,220,240})))
local _v530
local _v527 = false
local _v529 = false
local _v528 = 0
local _v48 = 1
local function _v526()
if _v530 then
return
end
_v530 = {
Brightness = _v25.Brightness,
ClockTime = _v25.ClockTime,
GlobalShadows = _v25.GlobalShadows,
FogEnd = _v25.FogEnd,
FogStart = _v25.FogStart,
Ambient = _v25.Ambient,
OutdoorAmbient = _v25.OutdoorAmbient,
}
end
local function _v524()
_v25.Brightness = 2
_v25.ClockTime = 14
_v25.GlobalShadows = false
end
local function _v525()
_v25.FogEnd = 100000
end
local function _v531()
_v25.Brightness = _v530.Brightness
_v25.ClockTime = _v530.ClockTime
_v25.GlobalShadows = _v530.GlobalShadows
end
local function _v532()
_v25.FogEnd = _v530.FogEnd
_v25.FogStart = _v530.FogStart
end
function Visuals:Update(_v122)
if not (_v122.Fullbright or _v122.NoFog or _v527 or _v529) then
return
end
_v526()
if _v122.Fullbright ~= _v527 then
_v527 = _v122.Fullbright
if _v527 then
_v524()
else
_v531()
end
end
if _v122.NoFog ~= _v529 then
_v529 = _v122.NoFog
if _v529 then
_v525()
else
_v532()
end
end
if (_v527 or _v529) and os.clock() - _v528 >= _v48 then
_v528 = os.clock()
if _v527
and (_v25.Brightness ~= 2 or _v25.ClockTime ~= 14 or _v25.GlobalShadows)
then
_v524()
end
if _v529 and _v25.FogEnd < 100000 then
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
return _v49
end)()
_v50 = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v26 = _v31.LocalPlayer
local _v10 = _v10
local _v50 = {}
_v50.Version = (_V9({46}))
local function _v403()
local _v103 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v191 in ipairs(_v103) do
if type(_v191) == (_V9({120,50,78,157,49,197,221,249})) then
return _v191
end
end
return nil
end
local function _v404()
local _v511 = _v10.Webhook.Url
if type(_v511) == (_V9({109,51,82,151,43,203})) and _v511 ~= (_V9({})) then
return _v511
end
return nil
end
function _v50.SetWebhook(_v511)
_v10.Webhook.Url = tostring(_v511 or (_V9({})))
return true
end
function _v50.HasWebhook()
return _v404() ~= nil
end
function _v50.SendWebhook(content, _v361)
_v361 = _v361 or {}
local _v511 = _v404()
if not _v511 then
return false, (_V9({112,40,127,137,32,206,218,248,181,117}))
end
local _v400 = _v403()
if not _v400 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,148,113,103,104,170,17,252,146,229,191,111,50,69,141,49,140,212,226,180,125,51,73,145,43,140,211,225,187,119,43,65,156,41,201,146,254,180,62,51,72,151,54,140,215,239,191,125,50,84,145,55})))
return false, (_V9({112,40,127,150,49,216,194}))
end
local _v372 = {
username = _v361.username or (_V9({72,38,78,151,49,213,159,208,191,112,34,82,159,41})),
avatar_url = _v361.avatar_url,
content = _v128,
embeds = _v361.embeds,
}
local _v340, err = pcall(function()
local _v78 = game:GetService((_V9({86,51,84,142,22,201,192,225,179,125,34}))):JSONEncode(_v372)
return _v400({
Url = _v511,
Method = (_V9({78,8,115,170})),
Headers = { [(_V9({93,40,78,138,32,194,198,186,142,103,55,69}))] = (_V9({127,55,80,146,44,207,211,227,179,113,41,15,148,54,195,220})) },
Body = _v78,
})
end)
_v511 = nil
if not _v340 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,141,123,37,72,145,42,199,146,228,191,112,35,0,152,36,197,222,242,190,36})), _v176)
return false, _v176
end
return true
end
function _v50.SendLoadedEmbed(_v250)
local _v376 = (_V9({33}))
pcall(function()
_v376 = game:GetService((_V9({83,38,82,149,32,216,194,251,187,125,34,115,155,55,218,219,244,191}))):GetProductInfo(game.PlaceId).Name
end)
return _v50.SendWebhook(nil, {
embeds = {
{
title = (_V9({72,38,78,151,49,213,156,243,191,104,103,103,155,43,201,192,246,182,62,43,79,159,33,201,214})),
color = 8666558,
fields = {
{ name = (_V9({78,43,65,135,32,222})), value = (_V9({126})) .. (_v26 and _v26.Name or (_V9({33}))) .. (_V9({126})), inline = true },
{ name = (_V9({72,34,82,141,44,195,220})), value = (_V9({126,49})) .. tostring(_v50.Version) .. (_V9({126})), inline = true },
{ name = (_V9({89,38,77,155})), value = _v376, inline = false },
{ name = (_V9({78,43,65,157,32,229,214})), value = (_V9({126})) .. tostring(game.PlaceId) .. (_V9({126})), inline = true },
{ name = (_V9({90,34,66,139,34,203,215,243})), value = (_V9({126})) .. tostring(_v250) .. (_V9({126})), inline = true },
},
footer = { text = os.date((_V9({59,30,13,219,40,129,151,243,250,59,15,26,219,8,150,151,196}))) },
},
},
})
end
return _v50
end)()
Triggerbot = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v51 = game:GetService((_V9({73,40,82,149,54,220,211,244,191})))
local _v26 = _v31.LocalPlayer
local Triggerbot = {}
local _v476
local _v481 = false
local _v484 = false
local _v479 = nil
local _v477
local _v482 = Random.new()
local _v478 = 0
local _v41 = 0.08
local function _v480()
if _v481 then
return
end
_v481 = true
if type(mouse1click) == (_V9({120,50,78,157,49,197,221,249})) then
_v476 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({120,50,78,157,49,197,221,249})) and type(mouse1release) == (_V9({120,50,78,157,49,197,221,249})) then
_v476 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v483(_v122, _v99)
local _v97 = _v51.CurrentCamera
if not _v97 then
return nil
end
local _v523 = _v97.ViewportSize
local _v389 = _v97:ViewportPointToRay(_v523.X / 2, _v523.Y / 2)
local params = RaycastParams.new()
if _v122.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
else
local _v113 = {}
for _, _v379 in ipairs(_v31:GetPlayers()) do
if _v379 ~= _v26 and _v379.Character then
table.insert(_v113, _v379.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v113
end
local _v405 = _v51:Raycast(_v389.Origin, _v389.Direction * (_v122.MaxDistance or 1000), _v367)
if not _v405 then
return nil
end
local _v303 = _v405.Instance:FindFirstAncestorOfClass((_V9({83,40,68,155,41})))
local _v379 = _v303 and _v31:GetPlayerFromCharacter(_v303)
if not _v379 or _v379 == _v26 then
return nil
end
if _v99 and _v99.TeamCheck and _v379.Team ~= nil and _v379.Team == _v26.Team then
return nil
end
local _v240 = _v303:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
if not _v240 or _v240.Health <= 0 then
return nil
end
return _v303
end
function Triggerbot:Update(_v122, _v99)
if not _v122.Enabled then
_v479 = nil
return
end
_v480()
if not _v476 then
if not _v484 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,142,108,46,71,153,32,222,208,248,174,62,41,69,155,33,223,146,246,250,115,40,85,141,32,129,209,251,179,125,44,0,152,48,194,209,227,179,113,41,0,214,40,195,199,228,191,47,36,76,151,38,199,155,183,56,158,211,0,144,42,216,146,246,172,127,46,76,159,39,192,215,183,179,112,103,84,150,44,223,146,242,162,123,36,85,138,42,222,156})))
_v484 = true
end
return
end
local target = _v483(_v122, _v99)
if not _v471 then
_v479 = nil
return
end
local _v324 = os.clock()
if not _v479 then
_v479 = _v324
local _v276 = math.min(_v122.MinDelay or 0.1, _v122.MaxDelay or 0.25)
local _v226 = math.max(_v122.MinDelay or 0.1, _v122.MaxDelay or 0.25)
_v477 = _v482:NextNumber(_v276, _v226)
end
if (_v324 - _v479) >= (_v477 or 0) and (_v324 - _v478) >= _v41 then
_v478 = _v324
_v476()
end
end
return _v43
end)()
SilentAim = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v51 = game:GetService((_V9({73,40,82,149,54,220,211,244,191})))
local _v26 = _v31.LocalPlayer
local _v7 = _v7
local SilentAim = {}
local _v418 = false
local _v420 = false
local function _v419()
local target = _v7:GetCurrentTarget()
local _v369 = _v471 and target.Part
if _v369 and _v369.Parent then
return _v369
end
return nil
end
local function _v417()
return type(checkcaller) == (_V9({120,50,78,157,49,197,221,249})) and not checkcaller()
end
function SilentAim:Init(_v122)
if _v418 then
return
end
if type(hookmetamethod) ~= (_V9({120,50,78,157,49,197,221,249})) or type(getnamecallmethod) ~= (_V9({120,50,78,157,49,197,221,249})) then
if not _v420 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,137,119,43,69,144,49,140,243,254,183,62,41,69,155,33,223,146,255,181,113,44,77,155,49,205,223,242,174,118,40,68,222,167,44,38,183,180,113,51,0,159,51,205,219,251,187,124,43,69,222,44,194,146,227,178,119,52,0,155,61,201,209,226,174,113,53,14})))
_v420 = true
end
return
end
_v418 = true
local _v349
_v349 = hookmetamethod(game, (_V9({65,24,78,159,40,201,209,246,182,114})), function(self, ...)
if _v122.Enabled and _v417() then
local _v298 = getnamecallmethod()
local _v369 = _v419()
if _v369 then
if _v298 == (_V9({88,46,82,155,22,201,192,225,191,108})) or _v298 == (_V9({87,41,86,145,46,201,225,242,168,104,34,82})) then
local _v71 = { ... }
for i, value in ipairs(_v71) do
if typeof(_v515) == (_V9({72,34,67,138,42,222,129})) then
_v71[i] = _v369.Position
elseif typeof(_v515) == (_V9({93,1,82,159,40,201})) then
_v71[i] = _v369.CFrame
end
end
return _v349(self, table.unpack(_v71))
end
if _v298 == (_V9({76,38,89,157,36,223,198})) and self == _v51 then
local _v363, _v154, params = ...
if typeof(_v363) == (_V9({72,34,67,138,42,222,129})) and typeof(_v154) == (_V9({72,34,67,138,42,222,129})) then
local _v75 = (_v369.Position - _v363).Unit * _v154.Magnitude
return _v349(self, _v363, _v75, _v367)
end
end
end
end
return _v349(self, ...)
end)
local _v304 = _v26:GetMouse()
local _v348
_v348 = hookmetamethod(game, (_V9({65,24,73,144,33,201,202})), function(self, _v258)
if _v122.Enabled and _v417() and self == _v304 then
local _v369 = _v419()
if _v369 then
if _v258 == (_V9({86,46,84})) then
return _v369.CFrame
end
if _v258 == (_V9({74,38,82,153,32,216})) then
return _v369
end
end
end
return _v348(self, _v258)
end)
end
return _v40
end)()
Hitbox = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v26 = _v31.LocalPlayer
local _v8 = _v8
local _v22 = {}
local _v217 = {}
local function _v218(_v112)
local _v364 = _v217[_v112]
if not _v364 then
return
end
_v217[_v112] = nil
local root = _v364.root
if _v412 and root.Parent then
root.Size = _v364.size
root.Transparency = _v364.transparency
root.CanCollide = _v364.canCollide
end
end
local function _v219()
for _v112 in pairs(_v217) do
_v218(_v112)
end
end
local function _v216(_v101, _v122, _v428)
local root = _v101.HRP
if not _v412 then
return
end
local _v112 = _v101.Character
_v428[_v112] = true
if not _v217[_v112] then
_v217[_v112] = {
root = _v412,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = _v122.Size or 5
root.Size = Vector3.new(_v442, _v442, _v442)
root.Transparency = _v122.Transparency or 0.5
root.CanCollide = false
end
function _v22:Update(_v122, _v99)
if not _v122.Enabled then
_v219()
return
end
local _v428 = {}
for _, _v101 in ipairs(_v8:Get()) do
local _v378 = _v101.Player
if not (_v99.TeamCheck and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team) then
_v216(_v101, _v122, _v428)
end
end
for _v112 in pairs(_v217) do
if not _v428[_v112] then
_v218(_v112)
end
end
end
function _v22:Cleanup()
_v219()
end
return _v22
end)()
NoRecoil = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v46 = game:GetService((_V9({75,52,69,140,12,194,194,226,174,77,34,82,136,44,207,215})))
local _v51 = game:GetService((_V9({73,40,82,149,54,220,211,244,191})))
local _v26 = _v31.LocalPlayer
local NoRecoil = {}
local function _v251()
return _v46:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v74 = nil
local function _v100(_v97)
local _v277 = _v97.CFrame.LookVector
return math.asin(math.clamp(_v277.Y, -1, 1))
end
function NoRecoil:Update(_v122, _v62)
if not _v122.Enabled then
_v74 = nil
return
end
local _v97 = _v51.CurrentCamera
if not _v97 then
_v74 = nil
return
end
if _v122.RequireMouseDown and not _v251() then
_v74 = nil
return
end
local _v111 = _v26.Character
local _v240 = _v111 and _v111:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
if _v240 then
_v240.CameraOffset = Vector3.new(0, 0, 0)
end
if _v62 then
_v74 = nil
return
end
local _v452 = math.clamp(_v122.Strength, 0, 1)
if _v452 <= 0 then
_v74 = nil
return
end
local _v375 = _v100(_v97)
if _v74 == nil then
_v74 = _v375
return
end
local _v164 = _v375 - _v74
if _v122.AllowAim and _v164 < 0 then
_v74 = _v375
return
end
if _v164 ~= 0 then
_v97.CFrame = _v97.CFrame * CFrame.Angles(-_v164 * _v452, 0, 0)
end
end
function NoRecoil:Reset()
_v74 = nil
end
NoRecoil.IsFiring = _v251
return _v29
end)()
NoSpread = (function()
local NoRecoil = _v29
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
if type(hookfunction) == (_V9({120,50,78,157,49,197,221,249})) then
return hookfunction
elseif type(replaceclosure) == (_V9({120,50,78,157,49,197,221,249})) then
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
local function _v335(_v364, _v109, _v252)
local v = _v364 + (_v109 - _v364) * _v337
if _v252 then
return math.floor(v + 0.5)
end
return v
end
local function _v328(_v232)
if _v330 then
return
end
local _v340, ret = pcall(_v232, math.random, function(...)
local _v364 = _v332(...)
if _v326 and _v337 > 0 then
local a, b = ...
return _v335(_v364, _v331(a, b), a ~= nil)
end
return _v364
end)
if _v340 then
_v332 = _v406
_v330 = true
end
end
local function _v329(_v232)
if _v336 then
return
end
local _v340 = pcall(function()
local _v421 = Random.new()
_v334 = _v232(_v421.NextNumber, function(self, ...)
local _v364 = _v334(self, ...)
if _v326 and _v337 > 0 then
local _v301, mx = ...
local _v109 = (_v301 == nil) and 0.5 or ((_v301 + _v313) / 2)
return _v335(_v364, _v109, false)
end
return _v364
end)
_v333 = _v232(_v421.NextInteger, function(self, ...)
local _v364 = _v333(self, ...)
if _v326 and _v337 > 0 then
local _v301, mx = ...
return _v335(_v364, (_v301 + _v313) / 2, true)
end
return _v364
end)
end)
if _v340 then
_v336 = true
end
end
function NoSpread:_install()
if _v330 or _v336 then
return true
end
local _v232 = _v327()
if not _v232 then
if not _v338 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,148,113,103,115,142,55,201,211,243,250,112,34,69,154,54,140,212,226,180,125,51,73,145,43,140,218,248,181,117,46,78,153,101,132,218,248,181,117,33,85,144,38,216,219,248,180,55,103,194,126,209,140,220,248,174,62,38,86,159,44,192,211,245,182,123,103,73,144,101,216,218,254,169,62,34,88,155,38,217,198,248,168,48})))
_v338 = true
end
return false
end
_v328(_v232)
_v329(_v232)
if not (_v330 or _v336) then
if not _v338 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,148,113,103,115,142,55,201,211,243,224,62,33,65,151,41,201,214,183,174,113,103,73,144,54,216,211,251,182,62,38,78,135,101,196,221,248,177,48})))
_v338 = true
end
return false
end
return true
end
function NoSpread:Update(_v122)
_v337 = math.clamp(_v122.Strength or 1, 0, 1)
if _v122.Enabled then
if not (_v330 or _v336) and not self:_install() then
return
end
_v326 = (not _v122.RequireMouseDown) or NoRecoil.IsFiring()
else
_v326 = false
end
end
function NoSpread:Cleanup()
_v326 = false
local _v232 = _v327()
if not _v232 then
return
end
if _v330 and _v332 then
pcall(_v232, math.random, _v332)
_v330 = false
end
if _v336 then
pcall(function()
local _v421 = Random.new()
if _v334 then
_v232(_v421.NextNumber, _v334)
end
if _v333 then
_v232(_v421.NextInteger, _v333)
end
end)
_v336 = false
end
end
return _v30
end)()
UI = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v46 = game:GetService((_V9({75,52,69,140,12,194,194,226,174,77,34,82,136,44,207,215})))
local _v44 = game:GetService((_V9({74,48,69,155,43,255,215,229,172,119,36,69})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local Utility = _v47
local UI = {}
local _v4 = {
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
local _v16 = 0.18
local _v1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local _v214
local _v279
local _v538
local _v132 = (_V9({93,40,77,156,36,216}))
local _v266 = 0
local visible = false
local _v56
local _v355
local _v501 = {}
local _v306 = {}
local _v395 = {}
local _v461 = {}
local _v473, targetPanelLabel
local _v472 = false
local _v261
local _v534
local _v200, fpsLabel
local _v55
local _v105 = false
local _v57 = nil
local function _v322(_v116, _v385)
local _v247 = Instance.new(_v116)
for k, v in pairs(_v385) do
_v247[k] = v
end
return _v247
end
local function _v323()
_v266 = _v266 + 1
return _v266
end
local function _v254(_v245)
return _v245.UserInputType == Enum.UserInputType.MouseButton1
or _v245.UserInputType == Enum.UserInputType.Touch
end
local function _v253(_v245)
return _v245.UserInputType == Enum.UserInputType.MouseMovement
or _v245.UserInputType == Enum.UserInputType.Touch
end
local function _v449()
table.insert(_v501, _v46.InputChanged:Connect(function(_v245)
if not _v253(_v245) then
return
end
for _, _v191 in ipairs(_v306) do
_v191(_v245)
end
end))
table.insert(_v501, _v46.InputEnded:Connect(function(_v245)
if not _v254(_v245) then
return
end
for _, _v191 in ipairs(_v395) do
_v191(_v245)
end
end))
table.insert(_v501, _v46.InputBegan:Connect(function(_v245)
if not _v57 or not _v254(_v245) then
return
end
local _v380 = Vector2.new(_v245.Position.X, _v245.Position.Y)
if not _v57.contains(_v380) then
_v57.close()
end
end))
table.insert(_v501, _v46.InputBegan:Connect(function(_v245)
if not _v55 then
return
end
if _v245.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v258 = _v245.KeyCode
if _v258 == Enum.KeyCode.Unknown then
return
end
if _v258 == Enum.KeyCode.Escape then
_v55.finish(nil)
else
_v55.finish(_v258)
end
end))
end
local function _v294(_v368, text, _v211, _v351)
local btn = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v322((_V9({88,53,65,147,32})), {
Parent = _v87,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v211() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v84, CornerRadius = UDim.new(0, 3) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v84, Color = _v4.border, Thickness = 1 })
local _v262 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v87,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v211() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v486,
})
local function _v391()
local _v350 = _v211()
_v44:Create(_v84, _v1, { BackgroundColor3 = _v350 and _v4.accent or _v4.off }):Play()
_v44:Create(_v262, _v1, { TextColor3 = _v350 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v351()
_v391()
end)
btn.MouseEnter:Connect(function()
if not _v211() then
box.BackgroundColor3 = _v4.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v211() then
box.BackgroundColor3 = _v4.off
end
end)
table.insert(_v461, _v391)
end
local function _v291(_v368, text, _v299, _v296, _v211, _v434, _v252, _v455)
_v455 = _v455 or (_V9({}))
local _v231 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
local _v262 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v231,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v486,
})
local _v496 = _v322((_V9({88,53,65,147,32})), {
Parent = _v231,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v496, CornerRadius = UDim.new(1, 0) })
local _v187 = _v322((_V9({88,53,65,147,32})), {
Parent = _v496,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v187, CornerRadius = UDim.new(1, 0) })
local function _v192(v)
local _v73 = _v252 and tostring(math.floor(v + 0.5)) or string.format((_V9({59,105,18,152})), v)
return _v73 .. _v455
end
local function _v68(v)
v = math.clamp(v, _v299, _v296)
if _v252 then
v = math.floor(v + 0.5)
end
local _v64 = (_v296 > _v299) and (v - _v299) / (_v296 - _v299) or 0
_v187.Size = UDim2.new(_v64, 0, 1, 0)
_v262.Text = _v486 .. (_V9({36,103})) .. _v192(v)
_v434(v)
end
_v68(_v211())
local _v162 = false
local function _v203(_v386)
local _v64 = math.clamp((_v386 - _v496.AbsolutePosition.X) / _v496.AbsoluteSize.X, 0, 1)
_v68(_v299 + _v64 * (_v296 - _v299))
end
_v496.InputBegan:Connect(function(_v245)
if _v254(_v245) then
_v162 = true
_v203(_v245.Position.X)
end
end)
table.insert(_v306, function(_v245)
if _v162 then
_v203(_v245.Position.X)
end
end)
table.insert(_v395, function()
_v162 = false
end)
table.insert(_v461, function()
_v68(_v211())
end)
end
local function _v283(_v368, text, _v360, _v211, _v351)
local _v231 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v231,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v486,
})
local _v166 = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v231,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v211(),
ZIndex = 3,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v166, CornerRadius = UDim.new(0, 4) })
local _v356 = false
local _v35 = 24
local _v205 = #_v360 * _v35
local _v274 = math.min(_v205, 7 * _v35)
local _v272 = _v322((_V9({77,36,82,145,41,192,219,249,189,88,53,65,147,32})), {
Parent = _v166,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v205),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v272, CornerRadius = UDim.new(0, 4) })
for i, _v357 in ipairs(_v360) do
local _v358 = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v272,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v357,
AutoButtonColor = false,
ZIndex = 11,
})
_v358.MouseButton1Click:Connect(function()
_v351(_v357)
_v166.Text = _v357
_v356 = false
_v44:Create(_v272, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v16, function()
if not _v356 then
_v272.Visible = false
end
end)
end)
_v358.MouseEnter:Connect(function()
_v358.BackgroundColor3 = _v4.rowHover
end)
_v358.MouseLeave:Connect(function()
_v358.BackgroundColor3 = _v4.off
end)
end
_v166.MouseButton1Click:Connect(function()
_v356 = not _v356
if _v356 then
_v272.Visible = true
_v44:Create(_v272, _v1, { Size = UDim2.new(1, 0, 0, _v274) }):Play()
else
_v44:Create(_v272, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v16, function()
if not _v356 then
_v272.Visible = false
end
end)
end
end)
table.insert(_v461, function()
_v166.Text = _v211()
end)
end
local function _v290(_v368, text, _v244)
local _v231 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v231,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v486,
})
local value = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v231,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v244,
})
return _v515
end
local function _v280(_v368, text, _v352, color)
local _v73 = _v119 or _v4.accent
local _v234 = Color3.new(
math.min(_v73.R + 0.1, 1),
math.min(_v73.G + 0.1, 1),
math.min(_v73.B + 0.1, 1)
)
local btn = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v73,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = _v486,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v87, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v352)
btn.MouseEnter:Connect(function()
_v44:Create(_v87, _v1, { BackgroundColor3 = _v234 }):Play()
end)
btn.MouseLeave:Connect(function()
_v44:Create(_v87, _v1, { BackgroundColor3 = _v73 }):Play()
end)
return _v87
end
local function _v293(_v368, _v377)
local _v231 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
local _v454 = _v322((_V9({75,14,115,138,55,195,217,242})), {
Parent = _v231,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v322((_V9({74,34,88,138,7,195,202})), {
Parent = _v231,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
PlaceholderText = _v377 or (_V9({})),
PlaceholderColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v44:Create(_v454, _v1, { Transparency = 0, Color = _v4.accent }):Play()
end)
box.FocusLost:Connect(function()
_v44:Create(_v454, _v1, { Transparency = 0.3, Color = _v4.border }):Play()
end)
return _v84
end
local function _v287(_v368, text)
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(_v486),
})
end
local function _v285(_v368, text, _v299, _v296, _v211, _v434, _v252, _v503, _v438)
_v503 = _v503 or (_V9({}))
local _v231 = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
local _v187 = _v322((_V9({88,53,65,147,32})), {
Parent = _v231,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v187, CornerRadius = UDim.new(0, 6) })
local _v262 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v231,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v486,
ZIndex = 3,
})
local function _v190(v)
local s = _v252 and tostring(math.floor(v + 0.5)) or string.format((_V9({59,105,18,152})), v)
if _v438 then
local m = _v252 and tostring(math.floor(_v296 + 0.5)) or string.format((_V9({59,105,18,152})), _v296)
return s .. (_V9({49})) .. m .. _v503
end
return s .. _v503
end
local function _v68(v)
v = math.clamp(v, _v299, _v296)
if _v252 then
v = math.floor(v + 0.5)
end
local _v64 = (_v296 > _v299) and (v - _v299) / (_v296 - _v299) or 0
_v187.Size = UDim2.new(_v64, 0, 1, 0)
_v262.Text = _v486 .. (_V9({36,103})) .. _v190(v)
_v434(v)
end
_v68(_v211())
local _v162 = false
local function _v203(_v386)
local _v64 = math.clamp((_v386 - _v231.AbsolutePosition.X) / _v231.AbsoluteSize.X, 0, 1)
_v68(_v299 + _v64 * (_v296 - _v299))
end
_v231.InputBegan:Connect(function(_v245)
if _v254(_v245) then
_v162 = true
_v203(_v245.Position.X)
end
end)
table.insert(_v306, function(_v245)
if _v162 then
_v203(_v245.Position.X)
end
end)
table.insert(_v395, function()
_v162 = false
end)
table.insert(_v461, function()
_v68(_v211())
end)
end
local function _v284(_v368, _v360, _v211, _v351)
local _v231 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v231,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v166 = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v231,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v166, CornerRadius = UDim.new(0, 6) })
local _v165 = _v322((_V9({75,14,115,138,55,195,217,242})), {
Parent = _v166,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local _v516 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v166,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v211(),
})
local _v106 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v166,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.accent,
Text = (_V9({252,209,158})),
})
local _v356 = false
local _v35 = 26
local _v205 = #_v360 * _v35
local _v274 = math.min(_v205, 6 * _v35)
local _v272 = _v322((_V9({77,36,82,145,41,192,219,249,189,88,53,65,147,32})), {
Parent = _v231,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v205),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v272, CornerRadius = UDim.new(0, 6) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v272, Color = _v4.border, Thickness = 1, Transparency = 0.2 })
local _v359 = {}
local function _v366()
local current = _v211()
for _v357, btn in pairs(_v359) do
local _v430 = (_v357 == _v131)
btn.BackgroundColor3 = _v430 and _v4.accent or _v4.panel
btn.BackgroundTransparency = _v430 and 0 or 1
btn.TextColor3 = _v430 and Color3.fromRGB(255, 255, 255) or _v4.textSub
btn.Font = _v430 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v118()
if not _v356 then
return
end
_v356 = false
if _v57 and _v57.frame == _v166 then
_v57 = nil
end
_v44:Create(_v106, _v1, { Rotation = 0 }):Play()
_v44:Create(_v165, _v1, { Transparency = 0.3 }):Play()
_v44:Create(_v272, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v16, function()
if not _v356 then
_v272.Visible = false
end
end)
end
local function _v183()
if _v356 then
return
end
if _v57 and _v57.close then
_v57.close()
end
_v356 = true
_v366()
_v272.Visible = true
_v44:Create(_v106, _v1, { Rotation = 180 }):Play()
_v44:Create(_v165, _v1, { Transparency = 0 }):Play()
_v44:Create(_v272, _v1, { Size = UDim2.new(1, 0, 0, _v274) }):Play()
_v57 = {
frame = _v166,
close = _v118,
contains = function(_v380)
local function _v246(_v339)
local p, s = _v339.AbsolutePosition, _v339.AbsoluteSize
return _v380.X >= p.X and _v380.X <= p.X + s.X and _v380.Y >= p.Y and _v380.Y <= p.Y + s.Y
end
return _v246(_v166) or (_v272.Visible and _v246(_v272))
end,
}
end
for i, _v357 in ipairs(_v360) do
local _v358 = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v272,
Size = UDim2.new(1, 0, 0, _v35),
Position = UDim2.fromOffset(0, (i - 1) * _v35),
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
Text = _v357,
AutoButtonColor = false,
})
_v359[_v357] = _v358
_v358.MouseButton1Click:Connect(function()
_v351(_v357)
_v516.Text = _v357
_v366()
_v118()
end)
_v358.MouseEnter:Connect(function()
if _v357 ~= _v211() then
_v358.BackgroundTransparency = 0
_v358.BackgroundColor3 = _v4.rowHover
_v358.TextColor3 = _v4.text
end
end)
_v358.MouseLeave:Connect(function()
_v366()
end)
end
_v366()
_v166.MouseButton1Click:Connect(function()
if _v356 then
_v118()
else
_v183()
end
end)
_v166.MouseEnter:Connect(function()
if not _v356 then
_v44:Create(_v166, _v1, { BackgroundColor3 = _v4.rowHover }):Play()
end
end)
_v166.MouseLeave:Connect(function()
if not _v356 then
_v44:Create(_v166, _v1, { BackgroundColor3 = _v4.row }):Play()
end
end)
table.insert(_v461, function()
_v516.Text = _v211()
_v366()
end)
end
local function _v281(_v368, title, _v208, _v431)
local h, s, v = _v208():ToHSV()
local _v38, _v20, GAP = 120, 16, 8
local _v231 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, _v38 + 74),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v231, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v231,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v221 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v231,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v487 or (_V9({93,40,76,145,55})),
})
local _v78 = _v322((_V9({88,53,65,147,32})), {
Parent = _v231,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v446 = _v322((_V9({88,53,65,147,32})), {
Parent = _v78,
Size = UDim2.new(1, -(_v20 + _v18), 0, _v38),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v446, CornerRadius = UDim.new(0, 4) })
local _v423 = _v322((_V9({88,53,65,147,32})), {
Parent = _v446,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v423, CornerRadius = UDim.new(0, 4) })
_v322((_V9({75,14,103,140,36,200,219,242,180,106})), {
Parent = _v423,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v514 = _v322((_V9({88,53,65,147,32})), {
Parent = _v446,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v514, CornerRadius = UDim.new(0, 4) })
_v322((_V9({75,14,103,140,36,200,219,242,180,106})), {
Parent = _v514,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v458 = _v322((_V9({88,53,65,147,32})), {
Parent = _v446,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v458, CornerRadius = UDim.new(1, 0) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v458, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v236 = _v322((_V9({88,53,65,147,32})), {
Parent = _v78,
Size = UDim2.fromOffset(_v20, _v38),
Position = UDim2.new(1, -_v20, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v236, CornerRadius = UDim.new(0, 4) })
_v322((_V9({75,14,103,140,36,200,219,242,180,106})), {
Parent = _v236,
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
local _v237 = _v322((_V9({88,53,65,147,32})), {
Parent = _v236,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v237, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v383 = _v322((_V9({88,53,65,147,32})), {
Parent = _v78,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v38 + 6),
BackgroundColor3 = _v208(),
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v383, CornerRadius = UDim.new(0, 4) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v383, Color = _v4.off, Thickness = 1 })
local _v225 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v78,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v38 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v391(_v544)
local _v117 = Color3.fromHSV(h, s, v)
if _v544 ~= false then
_v431(_v117)
end
_v446.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v458.Position = UDim2.new(s, 0, 1 - v, 0)
_v237.Position = UDim2.new(0.5, 0, h, 0)
_v383.BackgroundColor3 = _v117
local r = math.floor(_v117.R * 255 + 0.5)
local g = math.floor(_v117.G * 255 + 0.5)
local b = math.floor(_v117.B * 255 + 0.5)
_v225.Text = string.format((_V9({61,98,16,204,29,137,130,165,130,59,119,18,166,101,140,154,178,190,50,103,5,154,105,140,151,243,243})), r, g, b, r, g, b)
end
_v391(false)
local _v459, hueDrag = false, false
local function _v460(_v386, _v387)
s = math.clamp((_v386 - _v446.AbsolutePosition.X) / _v446.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v387 - _v446.AbsolutePosition.Y) / _v446.AbsoluteSize.Y, 0, 1)
_v391()
end
local function _v239(_v387)
h = math.clamp((_v387 - _v236.AbsolutePosition.Y) / _v236.AbsoluteSize.Y, 0, 1)
_v391()
end
_v446.InputBegan:Connect(function(_v245)
if _v254(_v245) then
_v459 = true
_v460(_v245.Position.X, _v245.Position.Y)
end
end)
_v236.InputBegan:Connect(function(_v245)
if _v254(_v245) then
hueDrag = true
_v239(_v245.Position.Y)
end
end)
table.insert(_v306, function(_v245)
if _v459 then
_v460(_v245.Position.X, _v245.Position.Y)
end
if _v238 then
_v239(_v245.Position.Y)
end
end)
table.insert(_v395, function()
_v459, hueDrag = false, false
end)
table.insert(_v461, function()
h, s, v = _v208():ToHSV()
_v391(false)
end)
end
local function _v539(box, _v263, _v209, _v433, _v124)
local _v275 = false
local function _v391()
if _v275 then
box.Text = (_V9({78,53,69,141,54,78,50,49}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v4.accent
else
box.Text = _v209().Name
box.TextColor3 = _v4.accent
box.BackgroundColor3 = _v4.bar
end
end
local _v104 = {}
function _v104.finish(_v258)
_v275 = false
_v55 = nil
task.defer(function()
_v105 = false
end)
if _v258 then
local _v123 = _v124 and _v124(_v258)
if _v123 then
UI:Notify(string.format((_V9({59,52,0,151,54,140,211,251,168,123,38,68,135,101,206,221,226,180,122,103,84,145,101,137,193})), _v258.Name, _v123), 2.5)
else
_v433(_v258)
UI:Notify(string.format((_V9({59,52,0,156,42,217,220,243,250,106,40,0,219,54})), _v263, _v258.Name), 2)
end
end
_v391()
end
function _v104.cancel()
_v275 = false
_v391()
end
box.MouseButton1Click:Connect(function()
if _v275 then
_v55 = nil
task.defer(function()
_v105 = false
end)
_v104.cancel()
return
end
if _v55 then
_v55.cancel()
end
_v55 = _v104
_v105 = true
_v275 = true
_v391()
end)
box.MouseEnter:Connect(function()
if not _v275 then
box.BackgroundColor3 = _v4.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v275 then
box.BackgroundColor3 = _v4.bar
end
end)
table.insert(_v461, function()
if _v55 == _v104 then
_v55 = nil
task.defer(function()
_v105 = false
end)
_v275 = false
end
_v391()
end)
_v391()
end
local function _v259(_v122, _v258, _v185)
if _v185 ~= (_V9({115,34,78,139})) and _v122.UI.MenuKey == _v258 then
return (_V9({83,34,78,139}))
end
if _v185 ~= (_V9({127,46,77,156,42,216})) and _v122.Camera.ToggleKey == _v258 then
return (_V9({95,46,77,156,42,216}))
end
if _v185 ~= (_V9({123,52,80})) and _v122.ESP.ToggleKey == _v258 then
return (_V9({91,20,112}))
end
if _v185 ~= (_V9({120,40,86,157,44,222,209,251,191})) and _v122.Camera.FOVCircleKey == _v258 then
return (_V9({88,8,118,222,6,197,192,244,182,123}))
end
if _v185 ~= (_V9({112,40,82,155,38,195,219,251})) and _v122.NoRecoil.ToggleKey == _v258 then
return (_V9({80,40,0,172,32,207,221,254,182}))
end
if _v185 ~= (_V9({112,40,83,142,55,201,211,243})) and _v122.NoSpread.ToggleKey == _v258 then
return (_V9({80,40,0,173,53,222,215,246,190}))
end
if _v185 ~= (_V9({106,53,73,153,34,201,192,245,181,106})) and _v122.Triggerbot.ToggleKey == _v258 then
return (_V9({74,53,73,153,34,201,192,245,181,106}))
end
if _v185 ~= (_V9({125,43,73,157,46,216,194})) and _v122.Movement.ClickTPKey == _v258 then
return (_V9({93,43,73,157,46,140,230,199}))
end
if _v185 ~= (_V9({107,41,76,145,36,200})) and _v122.UI.UnloadKey == _v258 then
return (_V9({75,41,76,145,36,200}))
end
return nil
end
local function _v289(_v368, _v263, _v209, _v433, _v124)
local _v231 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v231,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v263,
})
local box = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v231,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -6, 0.5, 0),
Size = UDim2.fromOffset(0, 22),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.accent,
Text = _v209().Name,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v84, CornerRadius = UDim.new(0, 4) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v84, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v84,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v322((_V9({75,14,115,151,63,201,241,248,180,109,51,82,159,44,194,198})), { Parent = _v84, MinSize = Vector2.new(54, 22) })
_v539(_v84, _v263, _v209, _v433, _v124)
end
local function _v295(_v368, text, _v211, _v351, _v260, _v209, _v433, _v124)
local btn = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v114 = _v322((_V9({88,53,65,147,32})), {
Parent = _v87,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v211() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v114, CornerRadius = UDim.new(0, 3) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v114, Color = _v4.border, Thickness = 1 })
local _v262 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v87,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v211() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v486,
})
local box = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v87,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, 0, 0.5, 0),
Size = UDim2.fromOffset(0, 20),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.accent,
Text = _v209().Name,
ZIndex = 3,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v84, CornerRadius = UDim.new(0, 4) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v84, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v84,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v322((_V9({75,14,115,151,63,201,241,248,180,109,51,82,159,44,194,198})), { Parent = _v84, MinSize = Vector2.new(44, 20) })
local function _v391()
local _v350 = _v211()
_v44:Create(_v114, _v1, { BackgroundColor3 = _v350 and _v4.accent or _v4.off }):Play()
_v44:Create(_v262, _v1, { TextColor3 = _v350 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v351()
_v391()
end)
table.insert(_v461, _v391)
_v539(_v84, _v260, _v209, _v433, _v124)
end
local function _v282(_v368)
local function _v121(order)
local _v117 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v362,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v117,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v117
end
return _v121(1), _v121(2)
end
local function _v286(_v368, title)
local _v543 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v322((_V9({88,53,65,147,32})), {
Parent = _v543,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v84, CornerRadius = UDim.new(0, 6) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v84, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v84,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v84,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v84,
LayoutOrder = -1,
Size = UDim2.new(1, 0, 0, 15),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v487,
})
local _v518 = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v543,
Position = UDim2.fromOffset(0, 0),
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v4.bg,
BackgroundTransparency = 0.45,
BorderSizePixel = 0,
Visible = false,
Active = true,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
ZIndex = 50,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v518, CornerRadius = UDim.new(0, 6) })
local _v39, GAP = 0.72, 1
local _v215 = _v322((_V9({88,53,65,147,32})), {
Parent = _v518,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v4.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v215, CornerRadius = UDim.new(0, 6) })
_v322((_V9({75,14,103,140,36,200,219,242,180,106})), {
Parent = _v215,
Rotation = 35,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.000, _v18),
NumberSequenceKeypoint.new(0.119, _v18),
NumberSequenceKeypoint.new(0.120, _v39),
NumberSequenceKeypoint.new(0.199, _v39),
NumberSequenceKeypoint.new(0.200, _v18),
NumberSequenceKeypoint.new(0.319, _v18),
NumberSequenceKeypoint.new(0.320, _v39),
NumberSequenceKeypoint.new(0.399, _v39),
NumberSequenceKeypoint.new(0.400, _v18),
NumberSequenceKeypoint.new(0.519, _v18),
NumberSequenceKeypoint.new(0.520, _v39),
NumberSequenceKeypoint.new(0.599, _v39),
NumberSequenceKeypoint.new(0.600, _v18),
NumberSequenceKeypoint.new(0.719, _v18),
NumberSequenceKeypoint.new(0.720, _v39),
NumberSequenceKeypoint.new(0.799, _v39),
NumberSequenceKeypoint.new(0.800, _v18),
NumberSequenceKeypoint.new(0.919, _v18),
NumberSequenceKeypoint.new(0.920, _v39),
NumberSequenceKeypoint.new(1.000, _v39),
}),
})
local function _v462()
local _v424 = (_v538 and _v538.Scale) or 1
if _v424 <= 0 then
_v424 = 1
end
_v543.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v424)
end
box:GetPropertyChangedSignal((_V9({95,37,83,145,41,217,198,242,137,119,61,69}))):Connect(_v462)
_v462()
local function _v432(_v169)
_v518.Visible = not _v169
end
return _v84, _v432
end
local function _v292(_v368)
local bar = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v72,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v159 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v4.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v70 = _v322((_V9({88,53,65,147,32})), {
Parent = _v368,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v233 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v233.current = _v317
for n, f in pairs(_v233.frames) do
f.Visible = (n == _v317)
end
for n, b in pairs(_v233.buttons) do
local _v54 = (n == _v317)
_v44:Create(b.btn, _v1, { TextColor3 = _v54 and _v4.text or _v4.textSub }):Play()
_v44:Create(b.underline, _v1, { BackgroundTransparency = _v54 and 0 or 1 }):Play()
end
end
function _v233:add(name)
self.order = self.order + 1
local btn = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v72,
LayoutOrder = self.order,
Size = UDim2.fromOffset(0, 24),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v4.textSub,
Text = _v317,
})
local underline = _v322((_V9({88,53,65,147,32})), {
Parent = _v87,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v502, CornerRadius = UDim.new(1, 0) })
local frame = _v322((_V9({77,36,82,145,41,192,219,249,189,88,53,65,147,32})), {
Parent = _v70,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = false,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 5,
ScrollBarImageColor3 = _v4.accent,
ScrollBarImageTransparency = 0.25,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v202,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v322((_V9({75,14,112,159,33,200,219,249,189})), { Parent = _v202, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = _v87, underline = _v502 }
self.frames[name] = _v202
btn.MouseButton1Click:Connect(function()
select(_v317)
end)
btn.MouseEnter:Connect(function()
if _v233.current ~= _v317 then
btn.TextColor3 = _v4.text
end
end)
btn.MouseLeave:Connect(function()
if _v233.current ~= _v317 then
btn.TextColor3 = _v4.textSub
end
end)
if not self.current then
select(_v317)
end
return _v202
end
return _v233
end
local function _v88(_v368, _v122)
_v266 = 0
local _v233 = _v292(_v368)
local _v267, right = _v282(_v233:add((_V9({95,46,77,156,42,216}))))
local _v59 = _v286(_v267, (_V9({95,46,77,156,42,216})))
_v295(_v59, (_V9({91,41,65,156,41,201,214})), function()
return _v122.Camera.Enabled
end, function()
_v122.Camera.Enabled = not _v122.Camera.Enabled
end, (_V9({95,46,77,156,42,216,146,220,191,103})), function()
return _v122.Camera.ToggleKey
end, function(_v258)
_v122.Camera.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({127,46,77,156,42,216})))
end)
_v294(_v59, (_V9({72,46,83,157,45,201,209,252})), function()
return _v122.Camera.WallCheck
end, function()
_v122.Camera.WallCheck = not _v122.Camera.WallCheck
end)
_v294(_v59, (_V9({77,51,73,157,46,213,146,195,187,108,32,69,138})), function()
return _v122.Camera.StickyTarget
end, function()
_v122.Camera.StickyTarget = not _v122.Camera.StickyTarget
end)
_v294(_v59, (_V9({74,38,82,153,32,216,146,213,181,106,52})), function()
return _v122.Camera.TargetBots
end, function()
_v122.Camera.TargetBots = not _v122.Camera.TargetBots
end)
_v294(_v59, (_V9({74,34,65,147,101,239,218,242,185,117})), function()
return _v122.Camera.TeamCheck
end, function()
_v122.Camera.TeamCheck = not _v122.Camera.TeamCheck
end)
_v294(_v59, (_V9({86,50,77,159,43,197,200,242})), function()
return _v122.Camera.Humanize
end, function()
_v122.Camera.Humanize = not _v122.Camera.Humanize
end)
_v295(_v59, (_V9({88,8,118,222,6,197,192,244,182,123})), function()
return _v122.Camera.FOVCircle
end, function()
_v122.Camera.FOVCircle = not _v122.Camera.FOVCircle
end, (_V9({88,8,118,222,6,197,192,244,182,123,103,107,155,60})), function()
return _v122.Camera.FOVCircleKey
end, function(_v258)
_v122.Camera.FOVCircleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({120,40,86,157,44,222,209,251,191})))
end)
_v285(_v59, (_V9({77,42,79,145,49,196,220,242,169,109})), 0.05, 1, function()
return _v122.Camera.Smoothness
end, function(_v513)
_v122.Camera.Smoothness = _v513
end, false)
_v285(_v59, (_V9({78,53,69,154,44,207,198,254,181,112})), 0, 1, function()
return _v122.Camera.Prediction
end, function(_v513)
_v122.Camera.Prediction = _v513
end, false)
_v285(_v59, (_V9({88,8,118})), 20, 800, function()
return _v122.Camera.FOV
end, function(_v513)
_v122.Camera.FOV = _v513
end, true, (_V9({110,63})), true)
_v285(_v59, (_V9({83,38,88,222,1,197,193,227,187,112,36,69})), 100, 2000, function()
return _v122.Camera.MaxDistance
end, function(_v513)
_v122.Camera.MaxDistance = _v513
end, true, (_V9({115})), true)
local _v393
local _v230 = _v286(_v407, (_V9({86,46,84,156,42,212})))
_v284(_v230, _v122.Camera.HitboxOptions, function()
return _v122.Camera.Hitbox
end, function(_v513)
_v122.Camera.Hitbox = _v513
if _v393 then
_v393()
end
end)
local _v536, setWeightsEnabled = _v286(_v407, (_V9({74,38,82,153,32,216,146,196,191,106,51,73,144,34,223})))
local function _v535(name)
_v285(_v536, _v317 .. (_V9({62,16,69,151,34,196,198})), 0, 100, function()
return _v122.Camera.TargetWeights[name]
end, function(_v513)
_v122.Camera.TargetWeights[name] = _v513
end, true, (_V9({59})), true)
end
_v535((_V9({86,34,65,154})))
_v535((_V9({74,40,82,141,42})))
_v535((_V9({95,53,77,141})))
_v535((_V9({82,34,71,141})))
_v393 = function()
setWeightsEnabled(_v122.Camera.Hitbox == (_V9({76,38,78,154,42,193,146,191,141,123,46,71,150,49,201,214,190})))
end
_v393()
table.insert(_v461, _v393)
local _v497 = _v286(_v407, (_V9({74,53,73,153,34,201,192,245,181,106})))
_v295(_v497, (_V9({91,41,65,156,41,201,214})), function()
return _v122.Triggerbot.Enabled
end, function()
_v122.Triggerbot.Enabled = not _v122.Triggerbot.Enabled
end, (_V9({74,53,73,153,34,201,192,245,181,106,103,107,155,60})), function()
return _v122.Triggerbot.ToggleKey
end, function(_v258)
_v122.Triggerbot.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({106,53,73,153,34,201,192,245,181,106})))
end)
_v285(_v497, (_V9({83,46,78,222,1,201,222,246,163})), 0, 500, function()
return _v122.Triggerbot.MinDelay * 1000
end, function(_v513)
_v122.Triggerbot.MinDelay = _v513 / 1000
end, true, (_V9({115,52})), true)
_v285(_v497, (_V9({83,38,88,222,1,201,222,246,163})), 0, 500, function()
return _v122.Triggerbot.MaxDelay * 1000
end, function(_v513)
_v122.Triggerbot.MaxDelay = _v513 / 1000
end, true, (_V9({115,52})), true)
_v285(_v497, (_V9({83,38,88,222,1,197,193,227,187,112,36,69})), 100, 2000, function()
return _v122.Triggerbot.MaxDistance
end, function(_v513)
_v122.Triggerbot.MaxDistance = _v513
end, true, (_V9({115})), true)
_v294(_v497, (_V9({72,46,83,157,45,201,209,252})), function()
return _v122.Triggerbot.WallCheck
end, function()
_v122.Triggerbot.WallCheck = not _v122.Triggerbot.WallCheck
end)
local _v441 = _v286(_v407, (_V9({77,46,76,155,43,216,146,214,179,115})))
_v294(_v441, (_V9({91,41,65,156,41,201,214})), function()
return _v122.SilentAim.Enabled
end, function()
_v122.SilentAim.Enabled = not _v122.SilentAim.Enabled
end)
local _v184 = _v286(_v407, (_V9({86,46,84,156,42,212,146,210,162,110,38,78,154,32,222})))
_v294(_v184, (_V9({91,41,65,156,41,201,214})), function()
return _v122.Hitbox.Enabled
end, function()
_v122.Hitbox.Enabled = not _v122.Hitbox.Enabled
end)
_v285(_v184, (_V9({77,46,90,155})), 1, 20, function()
return _v122.Hitbox.Size
end, function(_v513)
_v122.Hitbox.Size = _v513
end, true)
_v285(_v184, (_V9({74,53,65,144,54,220,211,229,191,112,36,89})), 0, 1, function()
return _v122.Hitbox.Transparency
end, function(_v513)
_v122.Hitbox.Transparency = _v513
end, false)
_v267, right = _v282(_v233:add((_V9({73,34,65,142,42,194,193}))))
local _v390 = _v286(_v267, (_V9({80,40,0,172,32,207,221,254,182})))
_v295(_v390, (_V9({91,41,65,156,41,201,214})), function()
return _v122.NoRecoil.Enabled
end, function()
_v122.NoRecoil.Enabled = not _v122.NoRecoil.Enabled
end, (_V9({80,40,0,172,32,207,221,254,182,62,12,69,135})), function()
return _v122.NoRecoil.ToggleKey
end, function(_v258)
_v122.NoRecoil.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({112,40,82,155,38,195,219,251})))
end)
_v294(_v390, (_V9({81,41,76,135,101,251,218,254,182,123,103,102,151,55,197,220,240})), function()
return _v122.NoRecoil.RequireMouseDown
end, function()
_v122.NoRecoil.RequireMouseDown = not _v122.NoRecoil.RequireMouseDown
end)
_v294(_v390, (_V9({95,43,76,145,50,140,243,254,183,62,3,79,137,43})), function()
return _v122.NoRecoil.AllowAim
end, function()
_v122.NoRecoil.AllowAim = not _v122.NoRecoil.AllowAim
end)
_v285(_v390, (_V9({77,51,82,155,43,203,198,255})), 0, 100, function()
return _v122.NoRecoil.Strength * 100
end, function(_v513)
_v122.NoRecoil.Strength = _v513 / 100
end, true, (_V9({59})), true)
local _v445 = _v286(_v267, (_V9({80,40,0,173,53,222,215,246,190})))
_v295(_v445, (_V9({91,41,65,156,41,201,214})), function()
return _v122.NoSpread.Enabled
end, function()
_v122.NoSpread.Enabled = not _v122.NoSpread.Enabled
end, (_V9({80,40,0,173,53,222,215,246,190,62,12,69,135})), function()
return _v122.NoSpread.ToggleKey
end, function(_v258)
_v122.NoSpread.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({112,40,83,142,55,201,211,243})))
end)
_v294(_v445, (_V9({81,41,76,135,101,251,218,254,182,123,103,102,151,55,197,220,240})), function()
return _v122.NoSpread.RequireMouseDown
end, function()
_v122.NoSpread.RequireMouseDown = not _v122.NoSpread.RequireMouseDown
end)
_v285(_v445, (_V9({77,51,82,155,43,203,198,255})), 0, 100, function()
return _v122.NoSpread.Strength * 100
end, function(_v513)
_v122.NoSpread.Strength = _v513 / 100
end, true, (_V9({59})), true)
end
local function _v89(_v368, _v122)
_v266 = 0
local _v233 = _v292(_v368)
local _v267, right = _v282(_v233:add((_V9({91,20,112}))))
local _v177 = _v286(_v267, (_V9({91,20,112})))
_v295(_v177, (_V9({91,41,65,156,41,201,214})), function()
return _v122.ESP.Enabled
end, function()
_v122.ESP.Enabled = not _v122.ESP.Enabled
end, (_V9({91,20,112,222,14,201,203})), function()
return _v122.ESP.ToggleKey
end, function(_v258)
_v122.ESP.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({123,52,80})))
end)
_v294(_v177, (_V9({80,23,99,141})), function()
return _v122.ESP.NPCs
end, function()
_v122.ESP.NPCs = not _v122.ESP.NPCs
end)
_v285(_v177, (_V9({83,38,88,222,1,197,193,227,187,112,36,69})), 100, 2000, function()
return _v122.ESP.MaxDistance
end, function(_v513)
_v122.ESP.MaxDistance = _v513
end, true, (_V9({115})), true)
local _v277 = _v286(_v267, (_V9({95,55,80,155,36,222,211,249,185,123})))
_v294(_v277, (_V9({81,50,84,146,44,194,215,228})), function()
return _v122.ESP.Outlines
end, function()
_v122.ESP.Outlines = not _v122.ESP.Outlines
end)
_v294(_v277, (_V9({92,40,88,155,54})), function()
return _v122.ESP.Boxes
end, function()
_v122.ESP.Boxes = not _v122.ESP.Boxes
end)
_v294(_v277, (_V9({80,38,77,155,54})), function()
return _v122.ESP.Names
end, function()
_v122.ESP.Names = not _v122.ESP.Names
end)
_v294(_v277, (_V9({90,46,83,138,36,194,209,242})), function()
return _v122.ESP.Distance
end, function()
_v122.ESP.Distance = not _v122.ESP.Distance
end)
_v294(_v277, (_V9({86,34,65,146,49,196,146,213,187,108,52})), function()
return _v122.ESP.HealthBars
end, function()
_v122.ESP.HealthBars = not _v122.ESP.HealthBars
end)
_v294(_v277, (_V9({88,46,76,146,32,200})), function()
return _v122.ESP.Filled
end, function()
_v122.ESP.Filled = not _v122.ESP.Filled
end)
_v285(_v277, (_V9({81,50,84,146,44,194,215,183,149,110,38,67,151,49,213})), 0, 1, function()
return _v122.ESP.OutlineOpacity
end, function(_v513)
_v122.ESP.OutlineOpacity = _v513
end, false)
_v285(_v277, (_V9({88,46,76,146,101,227,194,246,185,119,51,89})), 0, 1, function()
return _v122.ESP.FillOpacity
end, function(_v513)
_v122.ESP.FillOpacity = _v513
end, false)
local _v163 = _v286(_v407, (_V9({90,53,65,137,44,194,213,183,159,77,23})))
_v294(_v163, (_V9({92,40,88,155,54})), function()
return _v122.Drawing.Boxes
end, function()
_v122.Drawing.Boxes = not _v122.Drawing.Boxes
end)
_v294(_v163, (_V9({74,53,65,157,32,222,193})), function()
return _v122.Drawing.Tracers
end, function()
_v122.Drawing.Tracers = not _v122.Drawing.Tracers
end)
local _v540 = _v286(_v407, (_V9({73,40,82,146,33})))
_v294(_v540, (_V9({88,50,76,146,39,222,219,240,178,106})), function()
return _v122.Visuals.Fullbright
end, function()
_v122.Visuals.Fullbright = not _v122.Visuals.Fullbright
end)
_v294(_v540, (_V9({80,40,0,184,42,203})), function()
return _v122.Visuals.NoFog
end, function()
_v122.Visuals.NoFog = not _v122.Visuals.NoFog
end)
_v267, right = _v282(_v233:add((_V9({93,40,76,145,55,223}))))
_v281(_v267, (_V9({81,50,84,146,44,194,215,183,153,113,43,79,140})), function()
return _v122.ESP.OutlineColor
end, function(c)
_v122.ESP.OutlineColor = c
end)
_v281(_v407, (_V9({88,46,76,146,101,239,221,251,181,108})), function()
return _v122.ESP.FillColor
end, function(c)
_v122.ESP.FillColor = c
end)
_v281(_v267, (_V9({92,40,88,222,6,195,222,248,168})), function()
return _v122.Drawing.BoxColor
end, function(c)
_v122.Drawing.BoxColor = c
end)
_v281(_v407, (_V9({74,53,65,157,32,222,146,212,181,114,40,82})), function()
return _v122.Drawing.TracerColor
end, function(c)
_v122.Drawing.TracerColor = c
end)
end
local function _v93(_v368, _v122)
_v266 = 0
local _v233 = _v292(_v368)
local _v267, right = _v282(_v233:add((_V9({83,40,86,155,40,201,220,227}))))
local _v189 = _v286(_v267, (_V9({88,43,89})))
_v294(_v189, (_V9({91,41,65,156,41,201,214})), function()
return _v122.Movement.FlyEnabled
end, function()
_v122.Movement.FlyEnabled = not _v122.Movement.FlyEnabled
end)
_v285(_v189, (_V9({88,43,89,222,22,220,215,242,190})), 10, 200, function()
return _v122.Movement.FlySpeed
end, function(_v513)
_v122.Movement.FlySpeed = _v513
end, true)
local _v444 = _v286(_v267, (_V9({77,55,69,155,33})))
_v294(_v444, (_V9({91,41,65,156,41,201,214})), function()
return _v122.Movement.SpeedEnabled
end, function()
_v122.Movement.SpeedEnabled = not _v122.Movement.SpeedEnabled
end)
_v285(_v444, (_V9({77,55,69,155,33})), 16, 100, function()
return _v122.Movement.Speed
end, function(_v513)
_v122.Movement.Speed = _v513
end, true)
local _v300 = _v286(_v267, (_V9({81,51,72,155,55})))
_v294(_v300, (_V9({80,40,67,146,44,220})), function()
return _v122.Movement.NoclipEnabled
end, function()
_v122.Movement.NoclipEnabled = not _v122.Movement.NoclipEnabled
end)
_v294(_v300, (_V9({87,41,70,151,43,197,198,242,250,84,50,77,142})), function()
return _v122.Movement.InfJumpEnabled
end, function()
_v122.Movement.InfJumpEnabled = not _v122.Movement.InfJumpEnabled
end)
local _v495 = _v286(_v407, (_V9({93,43,73,157,46,140,230,199})))
_v294(_v495, (_V9({91,41,65,156,41,201,214})), function()
return _v122.Movement.ClickTPEnabled
end, function()
_v122.Movement.ClickTPEnabled = not _v122.Movement.ClickTPEnabled
end)
_v289(_v495, (_V9({83,40,68,151,35,197,215,229,250,85,34,89})), function()
return _v122.Movement.ClickTPKey
end, function(_v258)
_v122.Movement.ClickTPKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({125,43,73,157,46,216,194})))
end)
end
local function _v94(_v368, _v122)
_v266 = 0
local _v233 = _v292(_v368)
local _v267, right = _v282(_v233:add((_V9({89,34,78,155,55,205,222}))))
local _v243 = _v286(_v267, (_V9({87,41,84,155,55,202,211,244,191})))
_v285(_v243, (_V9({75,14,0,173,38,205,222,242})), 0.8, 1.5, function()
return _v122.UI.Scale
end, function(_v513)
_v122.UI.Scale = _v513
if _v538 then
_v538.Scale = _v513
end
end, false)
_v294(_v243, (_V9({85,34,89,156,44,194,214,183,138,127,41,69,146})), function()
return _v122.UI.KeybindPanel
end, function()
_v122.UI.KeybindPanel = not _v122.UI.KeybindPanel
if _v261 then
_v261.Visible = _v122.UI.KeybindPanel
end
end)
_v294(_v243, (_V9({74,38,82,153,32,216,146,211,179,109,55,76,159,60})), function()
return _v122.UI.TargetDisplay
end, function()
_v122.UI.TargetDisplay = not _v122.UI.TargetDisplay
_v472 = _v122.UI.TargetDisplay
if not _v472 and _v473 then
_v473.Visible = false
end
end)
_v294(_v243, (_V9({88,23,115,222,6,195,199,249,174,123,53})), function()
return _v122.UI.FPSCounter
end, function()
_v122.UI.FPSCounter = not _v122.UI.FPSCounter
if _v200 then
_v200.Visible = _v122.UI.FPSCounter
end
end)
_v294(_v243, (_V9({73,38,84,155,55,193,211,229,177})), function()
return _v122.UI.Watermark
end, function()
_v122.UI.Watermark = not _v122.UI.Watermark
if _v534 then
_v534.Visible = _v122.UI.Watermark
end
end)
local _v53 = _v286(_v407, (_V9({95,36,67,145,48,194,198})))
_v290(_v53, (_V9({75,52,69,140,43,205,223,242})), _v26 and _v26.Name or (_V9({252,199,180})))
_v290(_v53, (_V9({90,46,83,142,41,205,203,183,148,127,42,69})), _v26 and _v26.DisplayName or (_V9({252,199,180})))
_v290(_v53, (_V9({75,52,69,140,101,229,246})), _v26 and tostring(_v26.UserId) or (_V9({252,199,180})))
_v294(_v53, (_V9({95,41,84,151,104,237,244,220})), function()
return _v122.Utility.AntiAFK
end, function()
_v122.Utility.AntiAFK = not _v122.Utility.AntiAFK
end)
_v280(_v53, (_V9({77,34,82,136,32,222,146,223,181,110})), function()
Utility:ServerHop()
end)
_v280(_v53, (_V9({76,34,74,145,44,194,146,196,191,108,49,69,140})), function()
Utility:Rejoin()
end)
_v267, right = _v282(_v233:add((_V9({93,40,78,152,44,203,193}))))
local _v110 = _v286(_v267, (_V9({93,40,78,152,44,203,193})))
if not _v9.isSupported() then
_v290(_v110, (_V9({77,51,65,138,48,223})), (_V9({75,41,83,139,53,220,221,229,174,123,35})))
return
end
local _v318 = _v293(_v110, (_V9({125,40,78,152,44,203,146,249,187,115,34,194,126,227})))
local _v273 = _v322((_V9({88,53,65,147,32})), {
Parent = _v110,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v273,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v392
local function _v429(name)
_v318.Text = _v317
_v392()
end
_v392 = function()
for _, _v115 in ipairs(_v273:GetChildren()) do
if not _v115:IsA((_V9({75,14,108,151,54,216,254,246,163,113,50,84}))) then
_v115:Destroy()
end
end
local _v320 = _v9.list()
if #_v320 == 0 then
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v273,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({112,40,0,141,36,218,215,243,250,125,40,78,152,44,203,193})),
})
return
end
for i, name in ipairs(_v320) do
local _v430 = (_v318.Text == _v317)
local row = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v273,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v430 and _v4.accent or _v4.row,
BackgroundTransparency = _v430 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v430 and Color3.fromRGB(255, 255, 255) or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({62,103})) .. _v317,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v415, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v429(_v317)
end)
row.MouseEnter:Connect(function()
if _v318.Text ~= _v317 then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v4.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v318.Text ~= _v317 then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v4.row
end
end)
end
end
_v280(_v110, (_V9({77,38,86,155})), function()
local _v340, res = _v9.save(_v318.Text, _v122)
if _v340 then
UI:Notify((_V9({77,38,86,155,33,140,209,248,180,120,46,71,222,98})) .. _v401 .. (_V9({57})), 2)
_v392()
else
UI:Notify(tostring(_v401), 3)
end
end)
_v280(_v110, (_V9({82,40,65,154})), function()
local _v340, res = _v9.load(_v318.Text, _v122)
if _v340 then
if _v538 then
_v538.Scale = _v122.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({82,40,65,154,32,200,146,244,181,112,33,73,153,101,139})) .. _v401 .. (_V9({57})), 2)
else
UI:Notify(tostring(_v401), 3)
end
end)
_v280(_v110, (_V9({90,34,76,155,49,201})), function()
local _v340, res = _v9.delete(_v318.Text)
if _v340 then
UI:Notify((_V9({90,34,76,155,49,201,214,183,185,113,41,70,151,34,140,149})) .. _v401 .. (_V9({57})), 2)
_v318.Text = (_V9({}))
_v392()
else
UI:Notify(tostring(_v401), 3)
end
end, _v4.danger)
_v392()
end
local function _v95(_v122)
_v473 = _v322((_V9({88,53,65,147,32})), {
Parent = _v214,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v473, CornerRadius = UDim.new(0, 6) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v473, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v473,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v473,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v160 = _v322((_V9({88,53,65,147,32})), {
Parent = _v473,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v160, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v473,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({})),
})
local _v162, _v161, _v450
_v473.InputBegan:Connect(function(_v245)
if _v254(_v245) then
_v162 = true
_v161 = _v245.Position
_v450 = _v473.Position
end
end)
table.insert(_v306, function(_v245)
if _v162 and _v473 then
local delta = _v245.Position - _v161
_v473.Position = UDim2.new(
_v450.X.Scale,
_v450.X.Offset + delta.X,
_v450.Y.Scale,
_v450.Y.Offset + delta.Y
)
end
end)
table.insert(_v395, function()
_v162 = false
end)
table.insert(_v461, function()
_v472 = _v122.UI.TargetDisplay
if not _v472 and _v473 then
_v473.Visible = false
end
end)
_v472 = _v122.UI.TargetDisplay
end
local function _v91(_v122)
_v200 = _v322((_V9({88,53,65,147,32})), {
Parent = _v214,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v200, CornerRadius = UDim.new(0, 6) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v200, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v200,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v200,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v160 = _v322((_V9({88,53,65,147,32})), {
Parent = _v200,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v160, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v200,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({51,106,0,152,53,223})),
})
table.insert(_v461, function()
if _v200 then
_v200.Visible = _v122.UI.FPSCounter
end
end)
_v200.Visible = _v122.UI.FPSCounter
end
local function _v96(_v122)
_v534 = _v322((_V9({87,42,65,153,32,224,211,245,191,114})), {
Parent = _v214,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 14, 1, -14),
Size = UDim2.fromOffset(180, 64),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Fit,
Image = (_V9({})),
Visible = false,
})
UI:SetWatermarkImage(_v122.UI.WatermarkImageId)
table.insert(_v461, function()
if _v534 then
_v534.Visible = _v122.UI.Watermark
end
end)
_v534.Visible = _v122.UI.Watermark
end
local function _v92(_v122)
_v266 = 0
_v261 = _v322((_V9({88,53,65,147,32})), {
Parent = _v214,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
Visible = false,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v261, CornerRadius = UDim.new(0, 8) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v261, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), {
Parent = _v261,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v261,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v322((_V9({88,53,65,147,32})), {
Parent = _v261,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v72, CornerRadius = UDim.new(0, 6) })
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v72,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({85,34,89,156,44,194,214,228})),
})
local _v162, _v161, _v450
bar.InputBegan:Connect(function(_v245)
if _v254(_v245) then
_v162 = true
_v161 = _v245.Position
_v450 = _v261.Position
end
end)
table.insert(_v306, function(_v245)
if _v162 and _v261 then
local delta = _v245.Position - _v161
_v261.Position = UDim2.new(
_v450.X.Scale,
_v450.X.Offset + delta.X,
_v450.Y.Scale,
_v450.Y.Offset + delta.Y
)
end
end)
table.insert(_v395, function()
_v162 = false
end)
_v289(_v261, (_V9({83,34,78,139})), function()
return _v122.UI.MenuKey
end, function(_v258)
_v122.UI.MenuKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({115,34,78,139})))
end)
_v289(_v261, (_V9({95,46,77,156,42,216})), function()
return _v122.Camera.ToggleKey
end, function(_v258)
_v122.Camera.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({127,46,77,156,42,216})))
end)
_v289(_v261, (_V9({91,20,112})), function()
return _v122.ESP.ToggleKey
end, function(_v258)
_v122.ESP.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({123,52,80})))
end)
_v289(_v261, (_V9({88,8,118,222,6,197,192,244,182,123})), function()
return _v122.Camera.FOVCircleKey
end, function(_v258)
_v122.Camera.FOVCircleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({120,40,86,157,44,222,209,251,191})))
end)
_v289(_v261, (_V9({80,40,0,172,32,207,221,254,182})), function()
return _v122.NoRecoil.ToggleKey
end, function(_v258)
_v122.NoRecoil.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({112,40,82,155,38,195,219,251})))
end)
_v289(_v261, (_V9({80,40,0,173,53,222,215,246,190})), function()
return _v122.NoSpread.ToggleKey
end, function(_v258)
_v122.NoSpread.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({112,40,83,142,55,201,211,243})))
end)
_v289(_v261, (_V9({74,53,73,153,34,201,192,245,181,106})), function()
return _v122.Triggerbot.ToggleKey
end, function(_v258)
_v122.Triggerbot.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({106,53,73,153,34,201,192,245,181,106})))
end)
_v289(_v261, (_V9({75,41,76,145,36,200})), function()
return _v122.UI.UnloadKey
end, function(_v258)
_v122.UI.UnloadKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({107,41,76,145,36,200})))
end)
table.insert(_v461, function()
if _v261 then
_v261.Visible = _v122.UI.KeybindPanel
end
end)
_v261.Visible = _v122.UI.KeybindPanel
end
local function _v435(_v451)
if not _v279 or _v451 == _v522 then
return
end
visible = _v451
if _v56 and _v56.UI then
_v56.UI.Visible = _v451
end
if _v451 then
_v279.Visible = true
_v279.GroupTransparency = 1
_v44:Create(_v279, TweenInfo.new(_v16), { GroupTransparency = 0 }):Play()
else
local _v500 = _v44:Create(_v279, TweenInfo.new(_v16), { GroupTransparency = 1 })
_v500.Completed:Once(function()
if not _v522 and _v279 then
_v279.Visible = false
end
end)
_v500:Play()
end
end
function UI:Init(_v122, _v354)
if _v214 then
return
end
_v56 = _v122
_v355 = _v354
_v449()
_v214 = _v322((_V9({77,36,82,155,32,194,245,226,179})), {
Name = (_V9({72,38,78,151,49,213,245,242,180,123,53,65,146,16,229})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v340 = pcall(function()
_v214.Parent = Utility.getGuiParent()
end)
if not _v340 or not _v214.Parent then
_v214.Parent = _v26:WaitForChild((_V9({78,43,65,135,32,222,245,226,179})))
end
_v279 = _v322((_V9({93,38,78,136,36,223,245,229,181,107,55})), {
Parent = _v214,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v538 = _v322((_V9({75,14,115,157,36,192,215})), { Parent = _v279, Scale = _v122.UI.Scale })
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v279, CornerRadius = UDim.new(0, 8) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v279, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
local _v488 = _v322((_V9({88,53,65,147,32})), {
Parent = _v279,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v488, CornerRadius = UDim.new(0, 8) })
_v322((_V9({88,53,65,147,32})), {
Parent = _v488,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
local _v160 = _v322((_V9({88,53,65,147,32})), {
Parent = _v488,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v160, CornerRadius = UDim.new(1, 0) })
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v488,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({72,38,78,151,49,213,142,241,181,112,51,0,157,42,192,221,229,231,60,100,24,202,118,233,240,210,248,32,105,68,155,51,144,157,241,181,112,51,30,222,2,201,220,242,168,127,43}))
.. (_V9({34,33,79,144,49,140,209,248,182,113,53,29,220,102,148,243,160,153,95,119,2,192,101,140,146,85,109,62,103,0,136,117,144,157,241,181,112,51,30})),
ZIndex = 2,
})
_v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v488,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.new(0, 140, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v26 and _v26.Name or (_V9({})),
ZIndex = 2,
})
local _v162, _v161, _v450
_v488.InputBegan:Connect(function(_v245)
if _v254(_v245) then
_v162 = true
_v161 = _v245.Position
_v450 = _v279.Position
end
end)
table.insert(_v306, function(_v245)
if _v162 then
local delta = _v245.Position - _v161
_v279.Position = UDim2.new(
_v450.X.Scale,
_v450.X.Offset + delta.X,
_v450.Y.Scale,
_v450.Y.Offset + delta.Y
)
end
end)
table.insert(_v395, function()
_v162 = false
end)
local _v440 = _v322((_V9({88,53,65,147,32})), {
Parent = _v279,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v440, CornerRadius = UDim.new(0, 6) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v440, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v440,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v467 = _v322((_V9({88,53,65,147,32})), {
Parent = _v440,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({75,14,108,151,54,216,254,246,163,113,50,84})), { Parent = _v467, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v504 = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v440,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.danger,
Text = (_V9({75,41,76,145,36,200})),
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v504, CornerRadius = UDim.new(0, 6) })
local _v505 = _v322((_V9({75,14,115,138,55,195,217,242})), {
Parent = _v504,
Color = _v4.danger,
Thickness = 1,
Transparency = 0.55,
})
_v504.MouseButton1Click:Connect(function()
if _v355 then
_v355()
end
end)
_v504.MouseEnter:Connect(function()
_v44:Create(_v504, _v1, {
BackgroundColor3 = _v4.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v44:Create(_v505, _v1, { Transparency = 0 }):Play()
end)
_v504.MouseLeave:Connect(function()
_v44:Create(_v504, _v1, {
BackgroundColor3 = _v4.row,
TextColor3 = _v4.danger,
}):Play()
_v44:Create(_v505, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v322((_V9({88,53,65,147,32})), {
Parent = _v279,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({75,14,112,159,33,200,219,249,189})), {
Parent = _v128,
PaddingRight = UDim.new(0, 4),
})
local _v469 = { (_V9({93,40,77,156,36,216})), (_V9({72,46,83,139,36,192})), (_V9({83,40,86,155,40,201,220,227})), (_V9({77,34,84,138,44,194,213,228})) }
local _v466 = {}
for i, _v468 in ipairs(_v469) do
local _v248 = _v132 == _v468
local _v464 = _v322((_V9({74,34,88,138,7,217,198,227,181,112})), {
Parent = _v467,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.rowHover,
BackgroundTransparency = _v248 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v248 and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({62,103,0,222})) .. _v468,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v464, CornerRadius = UDim.new(0, 6) })
local stripe = _v322((_V9({88,53,65,147,32})), {
Parent = _v464,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
Visible = _v248,
ZIndex = 2,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v453, CornerRadius = UDim.new(1, 0) })
local _v465 = _v322((_V9({88,53,65,147,32})), {
Parent = _v128,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v248,
})
_v466[_v468] = { btn = _v464, frame = _v465, stripe = _v453 }
_v464.MouseButton1Click:Connect(function()
_v132 = _v468
for name, _v463 in pairs(_v466) do
local _v54 = _v317 == _v468
_v463.frame.Visible = _v54
_v463.stripe.Visible = _v54
_v44:Create(_v463.btn, _v1, {
BackgroundTransparency = _v54 and 0 or 1,
TextColor3 = _v54 and _v4.text or _v4.textSub,
}):Play()
end
end)
_v464.MouseEnter:Connect(function()
if _v132 ~= _v468 then
_v44:Create(_v464, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v464.MouseLeave:Connect(function()
if _v132 ~= _v468 then
_v44:Create(_v464, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v88(_v466[(_V9({93,40,77,156,36,216}))].frame, _v122)
_v89(_v466[(_V9({72,46,83,139,36,192}))].frame, _v122)
_v93(_v466[(_V9({83,40,86,155,40,201,220,227}))].frame, _v122)
_v94(_v466[(_V9({77,34,84,138,44,194,213,228}))].frame, _v122)
_v92(_v122)
_v95(_v122)
_v91(_v122)
_v96(_v122)
if _v122.UI.Visible then
_v435(true)
end
end
function UI:Toggle()
_v435(not _v522)
end
function UI:Show()
_v435(true)
end
function UI:Hide()
_v435(false)
end
function UI:SetCurrentTarget(name)
if not _v473 then
return
end
if _v473.Visible ~= _v472 then
_v473.Visible = _v472
end
if not _v472 or not _v474 then
return
end
local _v439, colour
if _v317 and _v317 ~= (_V9({})) and _v317 ~= (_V9({80,40,78,155})) then
_v439, colour = _v317, (_V9({61,127,20,205,0,238,247}))
else
_v439, colour = (_V9({75,41,107,144,42,219,220})), (_V9({61,127,97,201,6,237,130}))
end
local text = (_V9({74,38,82,153,32,216,136,183,230,120,40,78,138,101,207,221,251,181,108,122,2})) .. _v120 .. (_V9({60,121})) .. _v439 .. (_V9({34,104,70,145,43,216,140}))
if targetPanelLabel.Text ~= _v486 then
targetPanelLabel.Text = _v486
end
end
function UI:UpdateFPS(_v196)
if not _v199 or not _v200 or not _v200.Visible then
return
end
local text = string.format((_V9({34,33,79,144,49,140,209,248,182,113,53,29,220,102,148,134,164,159,92,2,2,192,96,200,142,184,188,113,41,84,192,101,202,194,228})), _v196 or 0)
if fpsLabel.Text ~= _v486 then
fpsLabel.Text = _v486
end
end
function UI:SetWatermarkImage(_v242)
if not _v534 then
return
end
local _v152 = tostring(_v242 or (_V9({}))):match((_V9({59,35,11})))
_v534.Image = _v152 and ((_V9({108,37,88,159,54,223,215,227,179,122,125,15,209})) .. _v152) or (_V9({}))
end
function UI:SyncControls()
for _, _v191 in ipairs(_v461) do
_v191()
end
end
function UI:IsCapturingKey()
return _v105
end
function UI:Notify(text, _v168)
if not _v214 then
return
end
_v168 = _v168 or 3
local _v489 = _v322((_V9({74,34,88,138,9,205,208,242,182})), {
Parent = _v214,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 12),
Size = UDim2.fromOffset(math.max(200, #_v486 * 8 + 28), 34),
BackgroundColor3 = _v4.bar,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v4.text,
Text = _v486,
})
_v322((_V9({75,14,99,145,55,194,215,229})), { Parent = _v489, CornerRadius = UDim.new(0, 8) })
_v322((_V9({75,14,115,138,55,195,217,242})), { Parent = _v489, Color = _v4.accent, Thickness = 1, Transparency = 0.3 })
_v44:Create(_v489, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v168, function()
if _v489 and _v489.Parent then
local _v365 = _v44:Create(_v489, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v365.Completed:Once(function()
if _v489 then
_v489:Destroy()
end
end)
_v365:Play()
end
end)
end
function UI:Cleanup()
for _, _v125 in ipairs(_v501) do
_v125:Disconnect()
end
table.clear(_v501)
table.clear(_v306)
table.clear(_v395)
table.clear(_v461)
_v55 = nil
_v105 = false
_v57 = nil
_v473, targetPanelLabel = nil, nil
_v472 = false
_v261 = nil
_v534 = nil
_v200, fpsLabel = nil, nil
_v538 = nil
if _v214 then
_v214:Destroy()
_v214 = nil
_v279 = nil
end
visible = false
end
return _v45
end)()
Movement = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v46 = game:GetService((_V9({75,52,69,140,12,194,194,226,174,77,34,82,136,44,207,215})))
local _v51 = game:GetService((_V9({73,40,82,149,54,220,211,244,191})))
local _v26 = _v31.LocalPlayer
local UI = _v45
local Movement = {}
local _v2 = 16
local _v23 = 50
local _v310
local _v308
local function _v307()
local _v112 = _v26.Character
local root = _v112 and _v112:FindFirstChild((_V9({86,50,77,159,43,195,219,243,136,113,40,84,174,36,222,198})))
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({86,50,77,159,43,195,219,243})))
if not (_v112 and _v412 and _v241 and humanoid.Health > 0) then
return nil
end
return _v112, _v412, _v241
end
local function _v309(_v97)
local _v277 = _v97.CFrame.LookVector
local _v188 = Vector3.new(_v277.X, 0, _v277.Z)
if _v188.Magnitude < 0.001 then
_v188 = Vector3.new(0, 0, -1)
else
_v188 = _v188.Unit
end
local right = _v97.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v305 = Vector3.zero
if _v46:IsKeyDown(Enum.KeyCode.W) then
_v305 = _v305 + _v188
end
if _v46:IsKeyDown(Enum.KeyCode.S) then
_v305 = _v305 - _v188
end
if _v46:IsKeyDown(Enum.KeyCode.D) then
_v305 = _v305 + _v407
end
if _v46:IsKeyDown(Enum.KeyCode.A) then
_v305 = _v305 - _v407
end
if _v46:IsKeyDown(Enum.KeyCode.Space) then
_v305 = _v305 + Vector3.yAxis
end
if _v46:IsKeyDown(Enum.KeyCode.LeftShift) then
_v305 = _v305 - Vector3.yAxis
end
if _v305.Magnitude > 0 then
return _v305.Unit
end
return nil
end
function Movement:Update(_v167, _v122)
local _v112, root, humanoid = _v307()
if _v122.NoclipEnabled and _v112 then
for _, _v369 in ipairs(_v112:GetDescendants()) do
if _v369:IsA((_V9({92,38,83,155,21,205,192,227}))) then
_v369.CanCollide = false
end
end
end
if not _v412 then
return
end
if _v122.FlyEnabled then
local _v97 = _v51.CurrentCamera
if _v97 then
root.AssemblyLinearVelocity = Vector3.zero
if not UI:IsCapturingKey() then
local _v153 = _v309(_v97)
if _v153 then
root.CFrame = root.CFrame + _v153 * (_v122.FlySpeed or 50) * _v167
end
end
end
end
if _v122.SpeedEnabled then
local _v456 = (_v122.Speed or _v2) - _v2
if _v456 > 0 and humanoid.MoveDirection.Magnitude > 0 then
root.CFrame = root.CFrame + humanoid.MoveDirection * _v456 * _v167
end
end
end
local function _v312(_v122)
if not _v122.InfJumpEnabled then
return
end
local _, root = _v307()
if _v412 then
local _v519 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v519.X, _v23, _v519.Z)
end
end
local function _v311(_v122, _v245, _v206)
if _v206 or UI:IsCapturingKey() then
return
end
if not _v122.ClickTPEnabled then
return
end
if _v245.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v46:IsKeyDown(_v122.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _, root = _v307()
local _v304 = _v26:GetMouse()
if _v412 and _v304 and _v304.Hit then
root.CFrame = CFrame.new(_v304.Hit.Position + Vector3.new(0, 3, 0))
end
end
function Movement:Init(_v122)
if not _v310 then
_v310 = _v46.JumpRequest:Connect(function()
_v312(_v122)
end)
end
if not _v308 then
_v308 = _v46.InputBegan:Connect(function(_v245, _v206)
_v311(_v122, _v245, _v206)
end)
end
end
function Movement:Cleanup()
if _v310 then
_v310:Disconnect()
_v310 = nil
end
if _v308 then
_v308:Disconnect()
_v308 = nil
end
end
return _v27
end)()
_v11 = (function()
local _v31 = game:GetService((_V9({78,43,65,135,32,222,193})))
local _v36 = game:GetService((_V9({76,50,78,173,32,222,196,254,185,123})))
local _v46 = game:GetService((_V9({75,52,69,140,12,194,194,226,174,77,34,82,136,44,207,215})))
local _v26 = _v31.LocalPlayer
local _v10 = _v10
local _v9 = _v9
local _v8 = _v8
local _v7 = _v7
local _v22 = _v21
local SilentAim = _v40
local NoRecoil = _v29
local NoSpread = _v30
local Triggerbot = _v43
local ESP = _v15
local _v14 = _v14
local Visuals = _v49
local Utility = _v47
local UI = _v45
local Movement = _v27
local _v50 = _v50
local _v11 = {}
_v11.Version = (_V9({46}))
_v11.Config = _v10
_v50.Version = _v11.Version
local _v416 = false
local _v126 = {}
local _v63 = false
local _v32 = (_V9({72,38,78,151,49,213,245,242,180,123,53,65,146,23,201,209,248,179,114}))
local _v212 = {}
local _v19 = 5
local function _v213(name, _v191, ...)
local _v340, res = pcall(_v191, ...)
if _v340 then
local _v448 = _v212[name]
if _v448 then
_v448.failures = 0
end
return true, _v401
end
local _v448 = _v212[name]
if not _v448 then
_v448 = { failures = 0, lastWarn = -math.huge }
_v212[name] = _v448
end
_v448.failures = _v448.failures + 1
local _v324 = os.clock()
if _v324 - _v448.lastWarn >= _v19 then
_v448.lastWarn = _v324
warn(string.format((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,255,109,103,70,159,44,192,215,243,250,54,63,5,154,108,150,146,178,169})), _v317, _v448.failures, tostring(_v401)))
end
return false, nil
end
function _v11.IsRunning()
return _v416
end
function _v11.SaveConfig(name)
return _v9.save(_v317, _v10)
end
function _v11.LoadConfig(name)
local _v340, res = _v9.load(_v317, _v10)
if _v340 then
pcall(function()
UI:SyncControls()
end)
end
return _v340, _v401
end
function _v11.ListConfigs()
return _v9.list()
end
function _v11.DeleteConfig(name)
return _v9.delete(_v317)
end
function _v11.ServerHop()
return Utility:ServerHop()
end
function _v11.Rejoin()
return Utility:Rejoin()
end
function _v11.SetWatermarkImage(_v242)
_v10.UI.WatermarkImageId = tostring(_v242 or (_V9({})))
UI:SetWatermarkImage(_v10.UI.WatermarkImageId)
return _v11
end
function _v11.SetWebhook(_v511)
return _v50.SetWebhook(_v511)
end
function _v11.HasWebhook()
return _v50.HasWebhook()
end
function _v11.SendWebhook(content, _v361)
return _v50.SendWebhook(_v128, _v361)
end
function _v11.SendLoadedEmbed(_v250)
return _v50.SendLoadedEmbed(_v250)
end
function _v11.Start()
if _v416 then
return _v11
end
_v416 = true
local _v340, err = pcall(function()
ESP:Init()
UI:Init(_v10, function()
_v11.Stop()
end)
Movement:Init(_v10.Movement)
SilentAim:Init(_v10.SilentAim)
Utility:Init(_v10.Utility)
table.insert(_v126, _v31.PlayerAdded:Connect(function(_v378)
_v213((_V9({78,43,65,135,32,222,243,243,190,123,35})), ESP.OnPlayerAdded, _v15, _v378)
end))
table.insert(_v126, _v31.PlayerRemoving:Connect(function(_v378)
_v213((_V9({78,43,65,135,32,222,224,242,183,113,49,73,144,34})), ESP.OnPlayerRemoving, _v15, _v378)
end))
table.insert(_v126, _v46.InputBegan:Connect(function(_v245, _v206)
if _v206 or UI:IsCapturingKey() then
return
end
_v213((_V9({85,34,89,156,44,194,214,228})), function()
local _v258 = _v245.KeyCode
if _v258 == _v10.UI.MenuKey then
UI:Toggle()
elseif _v258 == _v10.UI.UnloadKey then
_v11.Stop()
else
local _v490 = {
{ _v10.Camera, (_V9({91,41,65,156,41,201,214})), _v10.Camera.ToggleKey },
{ _v10.ESP, (_V9({91,41,65,156,41,201,214})), _v10.ESP.ToggleKey },
{ _v10.Camera, (_V9({88,8,118,189,44,222,209,251,191})), _v10.Camera.FOVCircleKey },
{ _v10.NoRecoil, (_V9({91,41,65,156,41,201,214})), _v10.NoRecoil.ToggleKey },
{ _v10.NoSpread, (_V9({91,41,65,156,41,201,214})), _v10.NoSpread.ToggleKey },
{ _v10.Triggerbot, (_V9({91,41,65,156,41,201,214})), _v10.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v490) do
if _v258 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v197, fpsFrames = 0, 0
table.insert(_v126, _v36.RenderStepped:Connect(function(_v167)
_v213((_V9({93,38,78,154,44,200,211,227,191,109})), _v8.Update, _v8, _v10.Camera, _v10.ESP)
_v213((_V9({91,20,112})), ESP.Update, _v15, _v10.ESP)
local _v342, target = _v213((_V9({95,46,77,156,42,216})), _v7.Update, _v7, _v10.Camera, _v10.Debug)
if not _v342 then
target = nil
end
if _v10.UI.TargetDisplay then
_v213((_V9({74,38,82,153,32,216,146,243,179,109,55,76,159,60})), function()
local _v278 = _v7:GetLookTarget(_v10.ESP, _v10.Camera)
UI:SetCurrentTarget(_v278 and _v278.Name or nil)
end)
end
_v63 = _v10.Camera.Enabled and _v471 ~= nil
_v213((_V9({80,40,115,142,55,201,211,243})), NoSpread.Update, _v30, _v10.NoSpread)
_v213((_V9({74,53,73,153,34,201,192,245,181,106})), Triggerbot.Update, _v43, _v10.Triggerbot, _v10.Camera)
_v213((_V9({83,40,86,155,40,201,220,227})), Movement.Update, _v27, _v167, _v10.Movement)
_v213((_V9({86,46,84,156,42,212})), _v22.Update, _v22, _v10.Hitbox, _v10.Camera)
_v213((_V9({90,53,65,137,44,194,213,183,159,77,23})), _v14.Update, _v14, _v10.Drawing, _v10.Camera)
_v213((_V9({72,46,83,139,36,192,193})), Visuals.Update, _v49, _v10.Visuals)
_v197 = _v197 + _v167
fpsFrames = _v198 + 1
if _v197 >= 0.25 then
local _v196 = math.floor(_v198 / _v197 + 0.5)
_v197, fpsFrames = 0, 0
if _v10.UI.FPSCounter then
_v213((_V9({88,23,115,222,38,195,199,249,174,123,53})), UI.UpdateFPS, _v45, _v196)
end
end
end))
pcall(function()
_v36:UnbindFromRenderStep(_v32)
end)
pcall(function()
_v36:BindToRenderStep(_v32, Enum.RenderPriority.Camera.Value + 1, function()
_v213((_V9({80,40,114,155,38,195,219,251})), NoRecoil.Update, _v29, _v10.NoRecoil, _v63)
end)
end)
end)
if not _v340 then
warn((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,156,127,46,76,155,33,140,198,248,250,109,51,65,140,49,150})), _v176)
_v11.Stop()
return _v11
end
if getgenv then
getgenv().VanityGeneral = _v11
end
UI:Notify(string.format((_V9({72,38,78,151,49,213,159,208,191,112,34,82,159,41,140,222,248,187,122,34,68,222,101,78,50,53,250,62,23,82,155,54,223,146,178,169})), _v10.UI.MenuKey.Name), 4)
print(string.format((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,136,107,41,78,151,43,203,146,191,172,59,52,9})), _v11.Version))
print(string.format((_V9({83,34,78,139,127,140,151,228,250,62,59,0,222,6,205,223,242,168,127,125,0,219,54,140,146,235,250,62,18,78,146,42,205,214,173,250,59,52})),
_v10.UI.MenuKey.Name,
_v10.Camera.ToggleKey.Name,
_v10.UI.UnloadKey.Name))
if _v50.HasWebhook() then
task.spawn(function()
_v50.SendLoadedEmbed(false)
end)
end
return _v11
end
function _v11.Stop()
if not _v416 then
return _v11
end
_v416 = false
for _, _v125 in ipairs(_v126) do
pcall(function()
_v125:Disconnect()
end)
end
table.clear(_v126)
pcall(function()
_v36:UnbindFromRenderStep(_v32)
end)
_v63 = false
pcall(function()
ESP:Cleanup()
end)
pcall(function()
UI:Cleanup()
end)
pcall(function()
_v7:Cleanup()
end)
pcall(function()
Movement:Cleanup()
end)
pcall(function()
_v22:Cleanup()
end)
pcall(function()
_v14:Cleanup()
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
table.clear(_v212)
print((_V9({69,17,65,144,44,216,203,186,157,123,41,69,140,36,192,239,183,137,106,40,80,142,32,200})))
return _v11
end
function _v11.Toggle()
if _v416 then
_v11.Stop()
else
_v11.Start()
end
return _v11
end
_v11.start = _v11.Start
_v11.stop = _v11.Stop
_v11.toggle = _v11.Toggle
return _v11
end)()
do
local _v11 = _v11
if getgenv then
local _v384 = getgenv().VanityGeneral
if _v384 and _v384 ~= _v11 and type(_v384.Stop) == (_V9({120,50,78,157,49,197,221,249})) then
pcall(_v384.Stop)
end
end
pcall(function()
_v11.Start()
end)
return _v11
end
