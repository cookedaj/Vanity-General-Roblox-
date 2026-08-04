local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({61,144,105,93,103,151,249,131,20})
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
Hitbox = (_V9({111,241,7,57,8,250,217,171,67,88,249,14,53,19,242,157,170})),
HitboxOptions = { (_V9({111,241,7,57,8,250,217,171,67,88,249,14,53,19,242,157,170})), (_V9({117,245,8,57})), (_V9({105,255,27,46,8})), (_V9({124,226,4,46})), (_V9({113,245,14,46})) },
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
WatermarkImageId = (_V9({12,163,80,101,83,162,207,186,39,5,165,81,101,82,161})),
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
Hitbox = (_V9({111,241,7,57,8,250,217,171,67,88,249,14,53,19,242,157,170})),
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
for _v427, _v516 in pairs(_v12) do
for _v258, value in pairs(_v516) do
if type(_v514) == (_V9({73,241,11,49,2})) then
local target = _v10[_v427][_v258]
if type(_v470) ~= (_V9({73,241,11,49,2})) then
target = {}
_v10[_v427][_v258] = _v470
end
for k, v in pairs(_v514) do
target[k] = v
end
else
_v10[_v427][_v258] = _v514
end
end
end
end
return _v10
end)()
_v9 = (function()
local _v9 = {}
local _v5 = (_V9({107,241,7,52,19,238,190,230,122,88,226,8,49}))
local _v37 = { (_V9({126,241,4,56,21,246})), (_V9({120,195,57})), (_V9({115,255,59,56,4,248,144,239})), (_V9({115,255,58,45,21,242,152,231})), (_V9({112,255,31,56,10,242,151,247})), (_V9({110,249,5,56,9,227,184,234,121})), (_V9({117,249,29,63,8,239})), (_V9({121,226,8,42,14,249,158})), (_V9({107,249,26,40,6,251,138})), (_V9({104,228,0,49,14,227,128})), (_V9({104,217})) }
local function _v204()
return type(writefile) == (_V9({91,229,7,62,19,254,150,237}))
and type(readfile) == (_V9({91,229,7,62,19,254,150,237}))
and type(listfiles) == (_V9({91,229,7,62,19,254,150,237}))
end
local function _v172()
if type(isfolder) == (_V9({91,229,7,62,19,254,150,237})) and type(makefolder) == (_V9({91,229,7,62,19,254,150,237})) then
if not isfolder(_v5) then
pcall(makefolder, _v5)
end
end
end
local function _v422(name)
return (tostring(_v317 or (_V9({}))):gsub((_V9({102,206,76,42,56,178,212,163,73})), (_V9({}))):gsub((_V9({99,181,26,118})), (_V9({}))):gsub((_V9({24,227,66,121})), (_V9({}))))
end
local function _v371(name)
return _v5 .. (_V9({18,224,27,50,1,254,149,230,75})) .. game.PlaceId .. (_V9({98})) .. _v317 .. (_V9({19,250,26,50,9}))
end
local function _v270(name)
return _v5 .. (_V9({18})) .. _v317 .. (_V9({19,250,26,50,9}))
end
local function _v171(v)
local t = typeof(v)
if t == (_V9({126,255,5,50,21,164})) then
return { __t = (_V9({126,255,5,50,21,164})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({120,254,28,48,46,227,156,238})) then
return { __t = (_V9({120,254,28,48})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({73,241,11,49,2})) then
local _v365 = {}
for k, _v512 in pairs(v) do
if type(_v512) ~= (_V9({91,229,7,62,19,254,150,237})) then
local _v170 = _v171(_v512)
if _v170 ~= nil then
_v365[k] = _v170
end
end
end
return _v365
elseif t == (_V9({83,229,4,63,2,229})) or t == (_V9({78,228,27,52,9,240})) or t == (_V9({95,255,6,49,2,246,151})) then
return v
end
return nil
end
local function _v144(v)
if type(v) ~= (_V9({73,241,11,49,2})) then
return v
end
if v.__t == (_V9({126,255,5,50,21,164})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({120,254,28,48})) then
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
if type(v) == (_V9({73,241,11,49,2})) and v.__t == nil then
if type(target[k]) == (_V9({73,241,11,49,2})) then
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
if not _v340 or type(_v186) ~= (_V9({73,241,11,49,2})) then
return _v365
end
for _, _v370 in ipairs(_v186) do
local _v382 = (_V9({77,226,6,59,14,251,156,220})) .. game.PlaceId .. (_V9({98}))
local name = tostring(_v370):match((_V9({21,203,55,114,59,202,210,170,49,19,250,26,50,9,179})))
if _v317 and name:sub(1, #_v382) == _v382 then
table.insert(_v365, name:sub(#_v382 + 1))
end
end
table.sort(_v365)
return _v365
end
function _v9.save(name, _v122)
if not _v204() then
return false, (_V9({105,248,0,46,71,242,129,230,119,72,228,6,47,71,255,152,240,52,83,255,73,59,14,251,156,163,85,109,217}))
end
name = _v422(_v317)
if _v317 == (_V9({})) then
return false, (_V9({120,254,29,56,21,183,152,163,119,82,254,15,52,0,183,151,226,121,88}))
end
_v172()
local data = {}
for _, _v427 in ipairs(_v37) do
if type(_v122[_v427]) == (_V9({73,241,11,49,2})) then
data[_v427] = _v171(_v122[_v427])
end
end
local _v344, json = pcall(function()
return game:GetService((_V9({117,228,29,45,52,242,139,245,125,94,245}))):JSONEncode(_v135)
end)
if not _v344 then
return false, (_V9({120,254,10,50,3,242,217,229,117,84,252,12,57,93,183})) .. tostring(_v257)
end
local _v347, err = pcall(writefile, _v371(_v317), _v257)
if not _v347 then
return false, (_V9({106,226,0,41,2,183,159,226,125,81,245,13,103,71})) .. tostring(_v176)
end
return true, _v317
end
function _v9.load(name, _v122)
if not _v204() then
return false, (_V9({105,248,0,46,71,242,129,230,119,72,228,6,47,71,255,152,240,52,83,255,73,59,14,251,156,163,85,109,217}))
end
name = _v422(_v317)
if _v317 == (_V9({})) then
return false, (_V9({120,254,29,56,21,183,152,163,119,82,254,15,52,0,183,151,226,121,88}))
end
local _v370 = _v371(_v317)
if type(isfile) == (_V9({91,229,7,62,19,254,150,237})) then
local _v343, exists = pcall(isfile, _v370)
if _v343 and not _v182 then
local _v268 = _v270(_v317)
local _v345, legacyExists = pcall(isfile, _v268)
if _v345 and _v269 then
_v370 = _v268
else
return false, (_V9({115,255,73,62,8,249,159,234,115,29,254,8,48,2,243,217,164})) .. _v317 .. (_V9({26}))
end
end
end
local _v346, raw = pcall(readfile, _v370)
if not _v346 or type(_v388) ~= (_V9({78,228,27,52,9,240})) then
return false, (_V9({111,245,8,57,71,241,152,234,120,88,244}))
end
local _v344, data = pcall(function()
return game:GetService((_V9({117,228,29,45,52,242,139,245,125,94,245}))):JSONDecode(_v388)
end)
if not _v344 or type(_v135) ~= (_V9({73,241,11,49,2})) then
return false, (_V9({105,248,8,41,71,241,144,239,113,29,249,26,51,64,227,217,245,117,81,249,13,125,45,196,182,205}))
end
for _, _v427 in ipairs(_v37) do
if type(data[_v427]) == (_V9({73,241,11,49,2})) and type(_v122[_v427]) == (_V9({73,241,11,49,2})) then
_v69(_v122[_v427], data[_v427])
end
end
return true, _v317
end
function _v9.delete(name)
name = _v422(_v317)
if _v317 == (_V9({})) then
return false, (_V9({120,254,29,56,21,183,152,163,119,82,254,15,52,0,183,151,226,121,88}))
end
if type(delfile) ~= (_V9({91,229,7,62,19,254,150,237})) then
return false, (_V9({105,248,0,46,71,242,129,230,119,72,228,6,47,71,244,152,237,51,73,176,13,56,11,242,141,230,52,91,249,5,56,20}))
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v42 = game:GetService((_V9({105,245,5,56,23,248,139,247,71,88,226,31,52,4,242})))
local _v26 = _v31.LocalPlayer
local Utility = {}
local _v42 = game:GetService((_V9({105,245,5,56,23,248,139,247,71,88,226,31,52,4,242})))
local _v511
function Utility:Init(_v122)
if _v511 then
return
end
local _v532 = (type(VirtualUser) ~= (_V9({83,249,5})) and VirtualUser) or nil
if not _v532 then
pcall(function()
_v532 = game:GetService((_V9({107,249,27,41,18,246,149,214,103,88,226})))
end)
end
if not _v532 then
return
end
_v511 = _v26.Idled:Connect(function()
if _v122.AntiAFK then
_v532:CaptureController()
_v532:ClickButton2(Vector2.new())
end
end)
end
function Utility:Cleanup()
if _v511 then
_v511:Disconnect()
_v511 = nil
end
end
function Utility:ServerHop()
local _v340, err = pcall(function()
_v42:Teleport(game.PlaceId, _v26)
end)
if not _v340 then
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,71,88,226,31,56,21,183,145,236,100,29,246,8,52,11,242,157,185})), _v176)
end
return _v340
end
function Utility:Rejoin()
local _v340, err = pcall(function()
_v42:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v26)
end)
if not _v340 then
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,70,88,250,6,52,9,183,159,226,125,81,245,13,103})), _v176)
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
return game:GetService((_V9({126,255,27,56,32,226,144})))
end)
if _v341 and _v129 then
return _v129
end
return _v26:WaitForChild((_V9({109,252,8,36,2,229,190,246,125})))
end
return _v47
end)()
_v8 = (function()
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v51 = game:GetService((_V9({106,255,27,54,20,231,152,224,113})))
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
if _v147:IsA((_V9({112,255,13,56,11})))
and _v147:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
and not _v31:GetPlayerFromCharacter(_v147)
then
table.insert(_v79, _v147)
end
end
return _v79
end
local function _v414(_v112, humanoid)
return humanoid.RootPart
or _v112:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
or _v112:FindFirstChild((_V9({105,255,27,46,8})))
or _v112:FindFirstChild((_V9({104,224,25,56,21,195,150,241,103,82})))
or _v112.PrimaryPart
end
local _v34 = {
Head = { (_V9({117,245,8,57})) },
Torso = { (_V9({104,224,25,56,21,195,150,241,103,82})), (_V9({113,255,30,56,21,195,150,241,103,82})), (_V9({105,255,27,46,8})), (_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})) },
Arms = {
(_V9({113,245,15,41,47,246,151,231})), (_V9({111,249,14,53,19,223,152,237,112})),
(_V9({113,245,15,41,43,248,142,230,102,124,226,4})), (_V9({111,249,14,53,19,219,150,244,113,79,209,27,48})),
(_V9({113,245,15,41,50,231,137,230,102,124,226,4})), (_V9({111,249,14,53,19,194,137,243,113,79,209,27,48})),
(_V9({113,245,15,41,71,214,139,238})), (_V9({111,249,14,53,19,183,184,241,121})),
},
Legs = {
(_V9({113,245,15,41,33,248,150,247})), (_V9({111,249,14,53,19,209,150,236,96})),
(_V9({113,245,15,41,43,248,142,230,102,113,245,14})), (_V9({111,249,14,53,19,219,150,244,113,79,220,12,58})),
(_V9({113,245,15,41,50,231,137,230,102,113,245,14})), (_V9({111,249,14,53,19,194,137,243,113,79,220,12,58})),
(_V9({113,245,15,41,71,219,156,228})), (_V9({111,249,14,53,19,183,181,230,115})),
},
}
local _v33 = { (_V9({117,245,8,57})), (_V9({105,255,27,46,8})), (_V9({124,226,4,46})), (_V9({113,245,14,46})) }
local function _v374(_v112, _v394)
local _v320 = _v34[_v394]
if not _v320 then
return nil
end
for _, name in ipairs(_v320) do
local _v369 = _v112:FindFirstChild(_v317)
if _v369 and _v369:IsA((_V9({127,241,26,56,55,246,139,247}))) then
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
if _v147:IsA((_V9({127,241,26,56,55,246,139,247}))) then
return _v147
end
end
return nil
end
local function _v66(_v112, _v220, hrp)
return _v220
or _v235
or _v112:FindFirstChild((_V9({104,224,25,56,21,195,150,241,103,82})))
or _v112:FindFirstChild((_V9({105,255,27,46,8})))
or _v373(_v112)
end
local function _v90(_v112, _v378, _v97, _v98)
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
if not _v241 or humanoid.Health <= 0 then
return nil
end
local _v220 = _v112:FindFirstChild((_V9({117,245,8,57})))
local hrp = _v112:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
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
local _v456, vis = _v97:WorldToViewportPoint(_v65.Position)
_v175.AnchorScreen = _v456
_v175.AnchorOnScreen = _v520
end
if _v413 then
local _v492 = _v220 and (_v220.Position + Vector3.new(0, _v220.Size.Y, 0))
or (_v413.Position + Vector3.new(0, 3, 0))
local _v497, tvis = _v97:WorldToViewportPoint(_v492)
_v175.TopScreen = _v497
_v175.TopOnScreen = _v498
_v175.BotScreen = _v97:WorldToViewportPoint(_v413.Position - Vector3.new(0, 3.2, 0))
end
return _v175
end
function _v8:Update(_v99, _v178)
table.clear(_v202)
local _v97 = _v51.CurrentCamera
local _v314 = _v26.Character
local _v315 = _v314 and _v314:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v51 = game:GetService((_V9({106,255,27,54,20,231,152,224,113})))
local _v26 = _v31.LocalPlayer
local Utility = _v47
local _v8 = _v8
local _v7 = {}
local Camera = _v51.CurrentCamera
local _v107 = Random.new()
local _v34 = {
Head = { (_V9({117,245,8,57})) },
Torso = { (_V9({104,224,25,56,21,195,150,241,103,82})), (_V9({113,255,30,56,21,195,150,241,103,82})), (_V9({105,255,27,46,8})), (_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})) },
Arms = {
(_V9({113,245,15,41,47,246,151,231})), (_V9({111,249,14,53,19,223,152,237,112})),
(_V9({113,245,15,41,43,248,142,230,102,124,226,4})), (_V9({111,249,14,53,19,219,150,244,113,79,209,27,48})),
(_V9({113,245,15,41,50,231,137,230,102,124,226,4})), (_V9({111,249,14,53,19,194,137,243,113,79,209,27,48})),
(_V9({113,245,15,41,71,214,139,238})), (_V9({111,249,14,53,19,183,184,241,121})),
},
Legs = {
(_V9({113,245,15,41,33,248,150,247})), (_V9({111,249,14,53,19,209,150,236,96})),
(_V9({113,245,15,41,43,248,142,230,102,113,245,14})), (_V9({111,249,14,53,19,219,150,244,113,79,220,12,58})),
(_V9({113,245,15,41,50,231,137,230,102,113,245,14})), (_V9({111,249,14,53,19,194,137,243,113,79,220,12,58})),
(_V9({113,245,15,41,71,219,156,228})), (_V9({111,249,14,53,19,183,181,230,115})),
},
}
local _v33 = { (_V9({117,245,8,57})), (_V9({105,255,27,46,8})), (_V9({124,226,4,46})), (_V9({113,245,14,46})) }
local _v409 = Random.new()
local function _v374(_v112, _v394)
local _v320 = _v34[_v394]
if not _v320 then
return nil
end
for _, name in ipairs(_v320) do
local _v369 = _v112:FindFirstChild(_v317)
if _v369 and _v369:IsA((_V9({127,241,26,56,55,246,139,247}))) then
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
if _v147:IsA((_V9({127,241,26,56,55,246,139,247}))) then
return _v147
end
end
return nil
end
local function _v67(_v112)
return _v112:FindFirstChild((_V9({117,245,8,57})))
or _v112:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
or _v112:FindFirstChild((_V9({104,224,25,56,21,195,150,241,103,82})))
or _v112:FindFirstChild((_V9({105,255,27,46,8})))
or _v373(_v112)
end
local function _v411(_v535)
local _v493 = 0
for _, _v394 in ipairs(_v33) do
_v493 = _v493 + math.max(0, (_v535 and _v535[_v394]) or 0)
end
if _v493 <= 0 then
return (_V9({117,245,8,57}))
end
local _v410 = _v409:NextNumber() * _v493
local _v52 = 0
for _, _v394 in ipairs(_v33) do
_v52 = _v52 + math.max(0, _v535[_v394] or 0)
if _v410 <= _v52 then
return _v394
end
end
return (_V9({117,245,8,57}))
end
local function _v210(_v541)
local _v519, visible = Camera:WorldToViewportPoint(_v541)
if not _v521 or _v519.Z < 0 then
return math.huge
end
local _v425 = Vector2.new(_v519.X, _v519.Y)
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
_v193 = Instance.new((_V9({110,243,27,56,2,249,190,246,125})))
_v193.Name = (_V9({107,241,7,52,19,238,190,230,122,88,226,8,49,33,216,175}))
_v193.ResetOnSpawn = false
_v193.IgnoreGuiInset = true
_v193.DisplayOrder = 998
local _v340 = pcall(function()
_v193.Parent = Utility.getGuiParent()
end)
if not _v340 or not _v193.Parent then
_v193.Parent = _v26:WaitForChild((_V9({109,252,8,36,2,229,190,246,125})))
end
_v194 = Instance.new((_V9({123,226,8,48,2})))
_v194.Name = (_V9({111,249,7,58}))
_v194.AnchorPoint = Vector2.new(0.5, 0.5)
_v194.Position = UDim2.fromScale(0.5, 0.5)
_v194.BackgroundTransparency = 1
_v194.BorderSizePixel = 0
_v194.Parent = _v193
local _v130 = Instance.new((_V9({104,217,42,50,21,249,156,241})))
_v130.CornerRadius = UDim.new(1, 0)
_v130.Parent = _v194
fovStroke = Instance.new((_V9({104,217,58,41,21,248,146,230})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v17
fovStroke.Parent = _v194
return _v194
end
local function _v506(_v122)
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
local humanoid = _v112:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
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
local _v540 = (_v65.Position - Camera.CFrame.Position).Magnitude
if _v540 > _v122.MaxDistance then
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
local _v484 = _v99 and _v99.TeamCheck
for _, _v101 in ipairs(_v8:Get()) do
local _v378 = _v101.Player
if not (_v484 and _v378 and _v378.Team ~= nil and _v378.Team == _v26.Team) then
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
if _v302 and _v302 ~= (_V9({111,241,7,57,8,250,217,171,67,88,249,14,53,19,242,157,170})) and _v34[_v302] then
return _v302
end
if self._lockedChar ~= _v112 then
self._lockedChar = _v112
self._rolledRegion = _v411(_v122.TargetWeights)
end
return self._rolledRegion or (_V9({117,245,8,57}))
end
function _v7:PointCamera(_v474, _v443)
local _v148 = CFrame.lookAt(Camera.CFrame.Position, _v474)
local _v64 = math.clamp(1 - (_v443 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v148, _v64)
end
function _v7:Update(_v122, debug)
Camera = _v51.CurrentCamera
_v506(_v122)
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
if not _v470 then
target = self:FindBestTarget(_v122)
end
if not _v470 then
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
local _v540 = (_v61 - Camera.CFrame.Position).Magnitude
if (_v122.Prediction or 0) > 0 then
_v61 = _v61 + _v60.AssemblyLinearVelocity * _v122.Prediction * (_v540 / 500)
end
local _v443 = _v122.Smoothness
if _v122.Humanize then
_v443 = _v443 * (0.9 + _v107:NextNumber() * 0.2)
_v61 = _v61 + _v107:NextUnitVector() * (_v540 * math.rad(_v107:NextNumber() * 0.25))
end
self:PointCamera(_v61, _v443)
target.Part = _v60
target.Region = _v394
self._currentTarget = _v470
if debug then
print((_V9({105,226,8,62,12,254,151,228,46})), target.Character.Name, (_V9({111,245,14,52,8,249,195})), _v394, (_V9({121,249,26,41,6,249,154,230,46})), math.floor(target.ScreenDistance))
end
return _v470
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v51 = game:GetService((_V9({106,255,27,54,20,231,152,224,113})))
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
local _v240 = _v112:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
return (_v240 and _v240.RootPart)
or _v112:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
or _v112:FindFirstChild((_V9({105,255,27,46,8})))
or _v112:FindFirstChild((_V9({104,224,25,56,21,195,150,241,103,82})))
or _v112.PrimaryPart
end
local function _v207()
if _v85 and _v85.Parent then
return _v85
end
_v85 = Instance.new((_V9({110,243,27,56,2,249,190,246,125})))
_v85.Name = (_V9({107,241,7,52,19,238,190,230,122,88,226,8,49,37,248,129,230,103}))
_v85.ResetOnSpawn = false
_v85.IgnoreGuiInset = true
_v85.DisplayOrder = 996
local _v340 = pcall(function()
_v85.Parent = Utility.getGuiParent()
end)
if not _v340 or not _v85.Parent then
_v85.Parent = _v26:WaitForChild((_V9({109,252,8,36,2,229,190,246,125})))
end
return _v85
end
local function _v505(_v175, _v112, _v122, _v101)
local _v97 = _v51.CurrentCamera
local root = _v101 and _v101.RootPart or _v179(_v112)
if not _v97 or not _v412 or not _v175.box then
if _v175.box then
_v175.box.Visible = false
end
return
end
local _v491, onScreen, botV
if _v101 then
if not _v101.TopScreen then
_v175.box.Visible = false
return
end
_v491, onScreen, botV = _v101.TopScreen, _v101.TopOnScreen, _v101.BotScreen
else
local _v220 = _v112:FindFirstChild((_V9({117,245,8,57})))
local _v492 = _v220 and (_v220.Position + Vector3.new(0, _v220.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v82 = root.Position - Vector3.new(0, 3.2, 0)
_v491, onScreen = _v97:WorldToViewportPoint(_v492)
botV = _v97:WorldToViewportPoint(_v82)
end
if not _v353 or _v491.Z <= 0 then
_v175.box.Visible = false
return
end
local _v224 = math.abs(botV.Y - _v491.Y)
local _v536 = _v224 * 0.62
local _v133 = (_v491.X + botV.X) * 0.5
local _v134 = (_v491.Y + botV.Y) * 0.5
_v175.box.Size = UDim2.fromOffset(_v536, _v224)
_v175.box.Position = UDim2.fromOffset(_v133 - _v536 * 0.5, _v134 - _v224 * 0.5)
_v175.box.BackgroundColor3 = _v122.FillColor
_v175.box.BackgroundTransparency = _v122.Filled and (1 - _v122.FillOpacity) or 1
_v175.boxStroke.Color = _v122.OutlineColor
_v175.boxStroke.Transparency = 1 - _v122.OutlineOpacity
_v175.box.Visible = true
end
local function _v288(_v175, name, _v220, _v122)
local _v469 = Instance.new((_V9({127,249,5,49,5,248,152,241,112,122,229,0})))
_v469.Name = (_V9({107,215,32,51,1,248}))
_v469.Size = UDim2.fromOffset(200, 46)
_v469.StudsOffset = Vector3.new(0, 2.7, 0)
_v469.AlwaysOnTop = true
_v469.Adornee = _v220
_v469.Parent = _v220
local _v231 = Instance.new((_V9({123,226,8,48,2})))
_v231.BackgroundTransparency = 1
_v231.Size = UDim2.fromScale(1, 1)
_v231.Parent = _v469
local _v265 = Instance.new((_V9({104,217,37,52,20,227,181,226,109,82,229,29})))
_v265.SortOrder = Enum.SortOrder.LayoutOrder
_v265.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v265.VerticalAlignment = Enum.VerticalAlignment.Center
_v265.Parent = _v231
local _v319 = Instance.new((_V9({105,245,17,41,43,246,155,230,120})))
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
local _v156 = Instance.new((_V9({105,245,17,41,43,246,155,230,120})))
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
local _v222 = Instance.new((_V9({123,226,8,48,2})))
_v222.LayoutOrder = 3
_v222.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v222.BackgroundTransparency = 0.3
_v222.BorderSizePixel = 0
_v222.Size = UDim2.new(0.55, 0, 0, 5)
_v222.Visible = false
_v222.Parent = _v231
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v222, CornerRadius = UDim.new(1, 0) })
local _v223 = Instance.new((_V9({123,226,8,48,2})))
_v223.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v223.BorderSizePixel = 0
_v223.Size = UDim2.fromScale(1, 1)
_v223.Parent = _v222
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v223, CornerRadius = UDim.new(1, 0) })
_v175.nameTag = _v469
_v175.nameLabel = _v319
_v175.distanceLabel = _v156
_v175.healthBack = _v222
_v175.healthFill = _v223
_v175.nameHead = _v220
end
local function _v507(name, _v175, _v112, _v122, _v101)
local _v220 = _v101 and (_v101.Head or _v101.HRP)
or _v112:FindFirstChild((_V9({117,245,8,57})))
or _v112:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
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
local _v315 = _v314 and _v314:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
_v316 = _v315 and _v315.Position
hrp = _v112:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
end
local d = (_v316 and _v235) and math.floor((hrp.Position - _v316).Magnitude + 0.5) or 0
_v175.distanceLabel.Text = (_V9({102})) .. d .. (_V9({80,205}))
end
_v175.healthBack.Visible = _v122.HealthBars
if _v122.HealthBars then
local humanoid = _v101 and _v101.Humanoid or _v112:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
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
_v505(_v175, _v112, _v122, _v101)
elseif _v175.box then
_v175.box.Visible = false
end
if _v122.Names or _v122.Distance or _v122.NameTags or _v122.DistanceTags or _v122.HealthBars then
_v507(_v317, _v175, _v112, _v122, _v101)
elseif _v175.nameTag then
_v175.nameTag.Enabled = false
end
end
local function _v158(_v369)
local _v314 = _v26.Character
local _v315 = _v314 and _v314:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
if not _v315 or not _v369 then
return 0
end
return (_v369.Position - _v315.Position).Magnitude
end
local function _v509(_v101, _v175, _v122)
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
local _v229 = Instance.new((_V9({117,249,14,53,11,254,158,235,96})))
_v229.Name = (_V9({120,195,57,18,18,227,149,234,122,88}))
_v229.Enabled = false
_v229.FillColor = _v119
_v229.OutlineColor = _v119
_v229.Parent = _v127
local box = Instance.new((_V9({123,226,8,48,2})))
box.Name = (_V9({120,195,57,31,8,239}))
box.BackgroundColor3 = _v119
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v207()
local boxStroke = Instance.new((_V9({104,217,58,41,21,248,146,230})))
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
if _v339:IsA((_V9({117,229,4,60,9,248,144,231}))) then
local _v303 = _v339.Parent
if
_v303
and _v303:IsA((_V9({112,255,13,56,11})))
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
local function _v508(_v303, _v175, _v122)
local root = _v179(_v303)
local humanoid = _v303:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
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
_v127 = Instance.new((_V9({123,255,5,57,2,229})))
_v127.Name = (_V9({107,241,7,52,19,238,190,230,122,88,226,8,49,34,196,169}))
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
_v509(_v101, _v175, _v122)
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
_v508(_v303, _v175, _v122)
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v51 = game:GetService((_V9({106,255,27,54,20,231,152,224,113})))
local _v26 = _v31.LocalPlayer
local _v8 = _v8
local _v14 = {}
local _v136 = type(Drawing) == (_V9({73,241,11,49,2})) and type(Drawing.new) == (_V9({91,229,7,62,19,254,150,237}))
local _v143 = false
local _v137 = {}
local function _v140()
local _v271 = Drawing.new((_V9({113,249,7,56})))
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
local _v491, onScreen, botV = _v101.TopScreen, _v101.TopOnScreen, _v101.BotScreen
if not _v491 or not _v353 or _v491.Z <= 0 or botV.Z <= 0 then
if _v175 then
_v138(_v175)
end
return
end
_v175 = _v175 or _v139(_v378)
local _v224 = math.abs(botV.Y - _v491.Y)
local _v536 = _v224 * 0.62
local _v133 = (_v491.X + botV.X) * 0.5
local _v267, right = _v133 - _v536 * 0.5, _v133 + _v536 * 0.5
local _v490, bottom = _v491.Y, botV.Y
local box = _v175.box
box[1].From = Vector2.new(_v267, _v490)
box[1].To = Vector2.new(_v407, _v490)
box[2].From = Vector2.new(_v267, _v83)
box[2].To = Vector2.new(_v407, _v83)
box[3].From = Vector2.new(_v267, _v490)
box[3].To = Vector2.new(_v267, _v83)
box[4].From = Vector2.new(_v407, _v490)
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
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,86,82,232,70,9,21,246,154,230,102,29,213,58,13,71,249,156,230,112,78,176,29,53,2,183,189,241,117,74,249,7,58,71,251,144,225,102,92,226,16,125,133,23,109,163,122,82,228,73,60,17,246,144,239,117,95,252,12,125,14,249,217,247,124,84,227,73,56,31,242,154,246,96,82,226,71})))
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
local _v25 = game:GetService((_V9({113,249,14,53,19,254,151,228})))
local Visuals = {}
local _v25 = game:GetService((_V9({113,249,14,53,19,254,151,228})))
local _v529
local _v526 = false
local _v528 = false
local _v527 = 0
local _v48 = 1
local function _v525()
if _v529 then
return
end
_v529 = {
Brightness = _v25.Brightness,
ClockTime = _v25.ClockTime,
GlobalShadows = _v25.GlobalShadows,
FogEnd = _v25.FogEnd,
FogStart = _v25.FogStart,
Ambient = _v25.Ambient,
OutdoorAmbient = _v25.OutdoorAmbient,
}
end
local function _v523()
_v25.Brightness = 2
_v25.ClockTime = 14
_v25.GlobalShadows = false
end
local function _v524()
_v25.FogEnd = 100000
end
local function _v530()
_v25.Brightness = _v529.Brightness
_v25.ClockTime = _v529.ClockTime
_v25.GlobalShadows = _v529.GlobalShadows
end
local function _v531()
_v25.FogEnd = _v529.FogEnd
_v25.FogStart = _v529.FogStart
end
function Visuals:Update(_v122)
if not (_v122.Fullbright or _v122.NoFog or _v526 or _v528) then
return
end
_v525()
if _v122.Fullbright ~= _v526 then
_v526 = _v122.Fullbright
if _v526 then
_v523()
else
_v530()
end
end
if _v122.NoFog ~= _v528 then
_v528 = _v122.NoFog
if _v528 then
_v524()
else
_v531()
end
end
if (_v526 or _v528) and os.clock() - _v527 >= _v48 then
_v527 = os.clock()
if _v526
and (_v25.Brightness ~= 2 or _v25.ClockTime ~= 14 or _v25.GlobalShadows)
then
_v523()
end
if _v528 and _v25.FogEnd < 100000 then
_v524()
end
end
end
function Visuals:Cleanup()
if _v529 then
if _v526 then
_v530()
end
if _v528 then
_v531()
end
end
_v526 = false
_v528 = false
end
return _v49
end)()
_v50 = (function()
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v26 = _v31.LocalPlayer
local _v10 = _v10
local _v50 = {}
_v50.Version = (_V9({13}))
local function _v403()
local _v103 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v191 in ipairs(_v103) do
if type(_v191) == (_V9({91,229,7,62,19,254,150,237})) then
return _v191
end
end
return nil
end
local function _v404()
local _v510 = _v10.Webhook.Url
if type(_v510) == (_V9({78,228,27,52,9,240})) and _v510 ~= (_V9({})) then
return _v510
end
return nil
end
function _v50.SetWebhook(_v510)
_v10.Webhook.Url = tostring(_v510 or (_V9({})))
return true
end
function _v50.HasWebhook()
return _v404() ~= nil
end
function _v50.SendWebhook(content, _v361)
_v361 = _v361 or {}
local _v510 = _v404()
if not _v510 then
return false, (_V9({83,255,54,42,2,245,145,236,123,86}))
end
local _v400 = _v403()
if not _v400 then
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,90,82,176,33,9,51,199,217,241,113,76,229,12,46,19,183,159,246,122,94,228,0,50,9,183,152,245,117,84,252,8,63,11,242,217,234,122,29,228,1,52,20,183,156,251,113,94,229,29,50,21})))
return false, (_V9({83,255,54,53,19,227,137}))
end
local _v372 = {
username = _v361.username or (_V9({107,241,7,52,19,238,212,196,113,83,245,27,60,11})),
avatar_url = _v361.avatar_url,
content = _v128,
embeds = _v361.embeds,
}
local _v340, err = pcall(function()
local _v78 = game:GetService((_V9({117,228,29,45,52,242,139,245,125,94,245}))):JSONEncode(_v372)
return _v400({
Url = _v510,
Method = (_V9({109,223,58,9})),
Headers = { [(_V9({126,255,7,41,2,249,141,174,64,68,224,12}))] = (_V9({92,224,25,49,14,244,152,247,125,82,254,70,55,20,248,151})) },
Body = _v78,
})
end)
_v510 = nil
if not _v340 then
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,67,88,242,1,50,8,252,217,240,113,83,244,73,59,6,254,149,230,112,7})), _v176)
return false, _v176
end
return true
end
function _v50.SendLoadedEmbed(_v250)
local _v376 = (_V9({2}))
pcall(function()
_v376 = game:GetService((_V9({112,241,27,54,2,227,137,239,117,94,245,58,56,21,225,144,224,113}))):GetProductInfo(game.PlaceId).Name
end)
return _v50.SendWebhook(nil, {
embeds = {
{
title = (_V9({107,241,7,52,19,238,215,231,113,75,176,46,56,9,242,139,226,120,29,252,6,60,3,242,157})),
color = 8666558,
fields = {
{ name = (_V9({109,252,8,36,2,229})), value = (_V9({93})) .. (_v26 and _v26.Name or (_V9({2}))) .. (_V9({93})), inline = true },
{ name = (_V9({107,245,27,46,14,248,151})), value = (_V9({93,230})) .. tostring(_v50.Version) .. (_V9({93})), inline = true },
{ name = (_V9({122,241,4,56})), value = _v376, inline = false },
{ name = (_V9({109,252,8,62,2,222,157})), value = (_V9({93})) .. tostring(game.PlaceId) .. (_V9({93})), inline = true },
{ name = (_V9({121,245,11,40,0,240,156,231})), value = (_V9({93})) .. tostring(_v250) .. (_V9({93})), inline = true },
},
footer = { text = os.date((_V9({24,201,68,120,10,186,220,231,52,24,216,83,120,42,173,220,208}))) },
},
},
})
end
return _v50
end)()
Triggerbot = (function()
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v51 = game:GetService((_V9({106,255,27,54,20,231,152,224,113})))
local _v26 = _v31.LocalPlayer
local Triggerbot = {}
local _v475
local _v480 = false
local _v483 = false
local _v478 = nil
local _v476
local _v481 = Random.new()
local _v477 = 0
local _v41 = 0.08
local function _v479()
if _v480 then
return
end
_v480 = true
if type(mouse1click) == (_V9({91,229,7,62,19,254,150,237})) then
_v475 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({91,229,7,62,19,254,150,237})) and type(mouse1release) == (_V9({91,229,7,62,19,254,150,237})) then
_v475 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v482(_v122, _v99)
local _v97 = _v51.CurrentCamera
if not _v97 then
return nil
end
local _v522 = _v97.ViewportSize
local _v389 = _v97:ViewportPointToRay(_v522.X / 2, _v522.Y / 2)
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
local _v303 = _v405.Instance:FindFirstAncestorOfClass((_V9({112,255,13,56,11})))
local _v379 = _v303 and _v31:GetPlayerFromCharacter(_v303)
if not _v379 or _v379 == _v26 then
return nil
end
if _v99 and _v99.TeamCheck and _v379.Team ~= nil and _v379.Team == _v26.Team then
return nil
end
local _v240 = _v303:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
if not _v240 or _v240.Health <= 0 then
return nil
end
return _v303
end
function Triggerbot:Update(_v122, _v99)
if not _v122.Enabled then
_v478 = nil
return
end
_v479()
if not _v475 then
if not _v483 then
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,64,79,249,14,58,2,229,155,236,96,29,254,12,56,3,228,217,226,52,80,255,28,46,2,186,154,239,125,94,251,73,59,18,249,154,247,125,82,254,73,117,10,248,140,240,113,12,243,5,52,4,252,208,163,246,189,4,73,51,8,227,217,226,98,92,249,5,60,5,251,156,163,125,83,176,29,53,14,228,217,230,108,88,243,28,41,8,229,215})))
_v483 = true
end
return
end
local target = _v482(_v122, _v99)
if not _v470 then
_v478 = nil
return
end
local _v324 = os.clock()
if not _v478 then
_v478 = _v324
local _v276 = math.min(_v122.MinDelay or 0.1, _v122.MaxDelay or 0.25)
local _v226 = math.max(_v122.MinDelay or 0.1, _v122.MaxDelay or 0.25)
_v476 = _v481:NextNumber(_v276, _v226)
end
if (_v324 - _v478) >= (_v476 or 0) and (_v324 - _v477) >= _v41 then
_v477 = _v324
_v475()
end
end
return _v43
end)()
SilentAim = (function()
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v51 = game:GetService((_V9({106,255,27,54,20,231,152,224,113})))
local _v26 = _v31.LocalPlayer
local _v7 = _v7
local SilentAim = {}
local _v418 = false
local _v420 = false
local function _v419()
local target = _v7:GetCurrentTarget()
local _v369 = _v470 and target.Part
if _v369 and _v369.Parent then
return _v369
end
return nil
end
local function _v417()
return type(checkcaller) == (_V9({91,229,7,62,19,254,150,237})) and not checkcaller()
end
function SilentAim:Init(_v122)
if _v418 then
return
end
if type(hookmetamethod) ~= (_V9({91,229,7,62,19,254,150,237})) or type(getnamecallmethod) ~= (_V9({91,229,7,62,19,254,150,237})) then
if not _v420 then
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,71,84,252,12,51,19,183,184,234,121,29,254,12,56,3,228,217,235,123,82,251,4,56,19,246,148,230,96,85,255,13,125,133,23,109,163,122,82,228,73,60,17,246,144,239,117,95,252,12,125,14,249,217,247,124,84,227,73,56,31,242,154,246,96,82,226,71})))
_v420 = true
end
return
end
_v418 = true
local _v349
_v349 = hookmetamethod(game, (_V9({98,207,7,60,10,242,154,226,120,81})), function(self, ...)
if _v122.Enabled and _v417() then
local _v298 = getnamecallmethod()
local _v369 = _v419()
if _v369 then
if _v298 == (_V9({123,249,27,56,52,242,139,245,113,79})) or _v298 == (_V9({116,254,31,50,12,242,170,230,102,75,245,27})) then
local _v71 = { ... }
for i, value in ipairs(_v71) do
if typeof(_v514) == (_V9({107,245,10,41,8,229,202})) then
_v71[i] = _v369.Position
elseif typeof(_v514) == (_V9({126,214,27,60,10,242})) then
_v71[i] = _v369.CFrame
end
end
return _v349(self, table.unpack(_v71))
end
if _v298 == (_V9({111,241,16,62,6,228,141})) and self == _v51 then
local _v363, _v154, params = ...
if typeof(_v363) == (_V9({107,245,10,41,8,229,202})) and typeof(_v154) == (_V9({107,245,10,41,8,229,202})) then
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
_v348 = hookmetamethod(game, (_V9({98,207,0,51,3,242,129})), function(self, _v258)
if _v122.Enabled and _v417() and self == _v304 then
local _v369 = _v419()
if _v369 then
if _v258 == (_V9({117,249,29})) then
return _v369.CFrame
end
if _v258 == (_V9({105,241,27,58,2,227})) then
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v46 = game:GetService((_V9({104,227,12,47,46,249,137,246,96,110,245,27,43,14,244,156})))
local _v51 = game:GetService((_V9({106,255,27,54,20,231,152,224,113})))
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
local _v240 = _v111 and _v111:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
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
if type(hookfunction) == (_V9({91,229,7,62,19,254,150,237})) then
return hookfunction
elseif type(replaceclosure) == (_V9({91,229,7,62,19,254,150,237})) then
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
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,90,82,176,58,45,21,242,152,231,52,83,245,12,57,20,183,159,246,122,94,228,0,50,9,183,145,236,123,86,249,7,58,71,191,145,236,123,86,246,28,51,4,227,144,236,122,20,176,139,221,243,183,151,236,96,29,241,31,60,14,251,152,225,120,88,176,0,51,71,227,145,234,103,29,245,17,56,4,226,141,236,102,19})))
_v338 = true
end
return false
end
_v328(_v232)
_v329(_v232)
if not (_v330 or _v336) then
if not _v338 then
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,90,82,176,58,45,21,242,152,231,46,29,246,8,52,11,242,157,163,96,82,176,0,51,20,227,152,239,120,29,241,7,36,71,255,150,236,127,19})))
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v46 = game:GetService((_V9({104,227,12,47,46,249,137,246,96,110,245,27,43,14,244,156})))
local _v44 = game:GetService((_V9({105,231,12,56,9,196,156,241,98,84,243,12})))
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
local _v537
local _v132 = (_V9({126,255,4,63,6,227}))
local _v266 = 0
local visible = false
local _v56
local _v355
local _v500 = {}
local _v306 = {}
local _v395 = {}
local _v460 = {}
local _v472, targetPanelLabel
local _v471 = false
local _v261
local _v533
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
table.insert(_v500, _v46.InputChanged:Connect(function(_v245)
if not _v253(_v245) then
return
end
for _, _v191 in ipairs(_v306) do
_v191(_v245)
end
end))
table.insert(_v500, _v46.InputEnded:Connect(function(_v245)
if not _v254(_v245) then
return
end
for _, _v191 in ipairs(_v395) do
_v191(_v245)
end
end))
table.insert(_v500, _v46.InputBegan:Connect(function(_v245)
if not _v57 or not _v254(_v245) then
return
end
local _v380 = Vector2.new(_v245.Position.X, _v245.Position.Y)
if not _v57.contains(_v380) then
_v57.close()
end
end))
table.insert(_v500, _v46.InputBegan:Connect(function(_v245)
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
local btn = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v322((_V9({123,226,8,48,2})), {
Parent = _v87,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v211() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v84, CornerRadius = UDim.new(0, 3) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v84, Color = _v4.border, Thickness = 1 })
local _v262 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v87,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v211() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v485,
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
table.insert(_v460, _v391)
end
local function _v291(_v368, text, _v299, _v296, _v211, _v434, _v252, _v455)
_v455 = _v455 or (_V9({}))
local _v231 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
local _v262 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v231,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v485,
})
local _v495 = _v322((_V9({123,226,8,48,2})), {
Parent = _v231,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v495, CornerRadius = UDim.new(1, 0) })
local _v187 = _v322((_V9({123,226,8,48,2})), {
Parent = _v495,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v187, CornerRadius = UDim.new(1, 0) })
local function _v192(v)
local _v73 = _v252 and tostring(math.floor(v + 0.5)) or string.format((_V9({24,190,91,59})), v)
return _v73 .. _v455
end
local function _v68(v)
v = math.clamp(v, _v299, _v296)
if _v252 then
v = math.floor(v + 0.5)
end
local _v64 = (_v296 > _v299) and (v - _v299) / (_v296 - _v299) or 0
_v187.Size = UDim2.new(_v64, 0, 1, 0)
_v262.Text = _v485 .. (_V9({7,176})) .. _v192(v)
_v434(v)
end
_v68(_v211())
local _v162 = false
local function _v203(_v386)
local _v64 = math.clamp((_v386 - _v495.AbsolutePosition.X) / _v495.AbsoluteSize.X, 0, 1)
_v68(_v299 + _v64 * (_v296 - _v299))
end
_v495.InputBegan:Connect(function(_v245)
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
table.insert(_v460, function()
_v68(_v211())
end)
end
local function _v283(_v368, text, _v360, _v211, _v351)
local _v231 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v231,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v485,
})
local _v166 = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
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
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v166, CornerRadius = UDim.new(0, 4) })
local _v356 = false
local _v35 = 24
local _v205 = #_v360 * _v35
local _v274 = math.min(_v205, 7 * _v35)
local _v272 = _v322((_V9({110,243,27,50,11,251,144,237,115,123,226,8,48,2})), {
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
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v272, CornerRadius = UDim.new(0, 4) })
for i, _v357 in ipairs(_v360) do
local _v358 = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
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
table.insert(_v460, function()
_v166.Text = _v211()
end)
end
local function _v290(_v368, text, _v244)
local _v231 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v231,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v485,
})
local value = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
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
return _v514
end
local function _v280(_v368, text, _v352, color)
local _v73 = _v119 or _v4.accent
local _v234 = Color3.new(
math.min(_v73.R + 0.1, 1),
math.min(_v73.G + 0.1, 1),
math.min(_v73.B + 0.1, 1)
)
local btn = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v73,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = _v485,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v87, CornerRadius = UDim.new(0, 6) })
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
local _v231 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
local _v454 = _v322((_V9({104,217,58,41,21,248,146,230})), {
Parent = _v231,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v322((_V9({105,245,17,41,37,248,129})), {
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
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(_v485),
})
end
local function _v285(_v368, text, _v299, _v296, _v211, _v434, _v252, _v502, _v438)
_v502 = _v502 or (_V9({}))
local _v231 = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
local _v187 = _v322((_V9({123,226,8,48,2})), {
Parent = _v231,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v187, CornerRadius = UDim.new(0, 6) })
local _v262 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v231,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v485,
ZIndex = 3,
})
local function _v190(v)
local s = _v252 and tostring(math.floor(v + 0.5)) or string.format((_V9({24,190,91,59})), v)
if _v438 then
local m = _v252 and tostring(math.floor(_v296 + 0.5)) or string.format((_V9({24,190,91,59})), _v296)
return s .. (_V9({18})) .. m .. _v502
end
return s .. _v502
end
local function _v68(v)
v = math.clamp(v, _v299, _v296)
if _v252 then
v = math.floor(v + 0.5)
end
local _v64 = (_v296 > _v299) and (v - _v299) / (_v296 - _v299) or 0
_v187.Size = UDim2.new(_v64, 0, 1, 0)
_v262.Text = _v485 .. (_V9({7,176})) .. _v190(v)
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
table.insert(_v460, function()
_v68(_v211())
end)
end
local function _v284(_v368, _v360, _v211, _v351)
local _v231 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
Parent = _v231,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v166 = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
Parent = _v231,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v166, CornerRadius = UDim.new(0, 6) })
local _v165 = _v322((_V9({104,217,58,41,21,248,146,230})), {
Parent = _v166,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local _v515 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
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
local _v106 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v166,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.accent,
Text = (_V9({223,6,215})),
})
local _v356 = false
local _v35 = 26
local _v205 = #_v360 * _v35
local _v274 = math.min(_v205, 6 * _v35)
local _v272 = _v322((_V9({110,243,27,50,11,251,144,237,115,123,226,8,48,2})), {
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
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v272, CornerRadius = UDim.new(0, 6) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v272, Color = _v4.border, Thickness = 1, Transparency = 0.2 })
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
local _v358 = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
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
_v515.Text = _v357
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
table.insert(_v460, function()
_v515.Text = _v211()
_v366()
end)
end
local function _v281(_v368, title, _v208, _v431)
local h, s, v = _v208():ToHSV()
local _v38, _v20, GAP = 120, 16, 8
local _v231 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, _v38 + 74),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v231, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v231,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v221 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v231,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v486 or (_V9({126,255,5,50,21})),
})
local _v78 = _v322((_V9({123,226,8,48,2})), {
Parent = _v231,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v446 = _v322((_V9({123,226,8,48,2})), {
Parent = _v78,
Size = UDim2.new(1, -(_v20 + _v18), 0, _v38),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v446, CornerRadius = UDim.new(0, 4) })
local _v423 = _v322((_V9({123,226,8,48,2})), {
Parent = _v446,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v423, CornerRadius = UDim.new(0, 4) })
_v322((_V9({104,217,46,47,6,243,144,230,122,73})), {
Parent = _v423,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v513 = _v322((_V9({123,226,8,48,2})), {
Parent = _v446,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v513, CornerRadius = UDim.new(0, 4) })
_v322((_V9({104,217,46,47,6,243,144,230,122,73})), {
Parent = _v513,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v457 = _v322((_V9({123,226,8,48,2})), {
Parent = _v446,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v457, CornerRadius = UDim.new(1, 0) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v457, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v236 = _v322((_V9({123,226,8,48,2})), {
Parent = _v78,
Size = UDim2.fromOffset(_v20, _v38),
Position = UDim2.new(1, -_v20, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v236, CornerRadius = UDim.new(0, 4) })
_v322((_V9({104,217,46,47,6,243,144,230,122,73})), {
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
local _v237 = _v322((_V9({123,226,8,48,2})), {
Parent = _v236,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v237, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v383 = _v322((_V9({123,226,8,48,2})), {
Parent = _v78,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v38 + 6),
BackgroundColor3 = _v208(),
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v383, CornerRadius = UDim.new(0, 4) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v383, Color = _v4.off, Thickness = 1 })
local _v225 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
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
local function _v391(_v543)
local _v117 = Color3.fromHSV(h, s, v)
if _v543 ~= false then
_v431(_v117)
end
_v446.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v457.Position = UDim2.new(s, 0, 1 - v, 0)
_v237.Position = UDim2.new(0.5, 0, h, 0)
_v383.BackgroundColor3 = _v117
local r = math.floor(_v117.R * 255 + 0.5)
local g = math.floor(_v117.G * 255 + 0.5)
local b = math.floor(_v117.B * 255 + 0.5)
_v225.Text = string.format((_V9({30,181,89,111,63,178,201,177,76,24,160,91,5,71,183,209,166,112,17,176,76,57,75,183,220,231,61})), r, g, b, r, g, b)
end
_v391(false)
local _v458, hueDrag = false, false
local function _v459(_v386, _v387)
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
_v458 = true
_v459(_v245.Position.X, _v245.Position.Y)
end
end)
_v236.InputBegan:Connect(function(_v245)
if _v254(_v245) then
hueDrag = true
_v239(_v245.Position.Y)
end
end)
table.insert(_v306, function(_v245)
if _v458 then
_v459(_v245.Position.X, _v245.Position.Y)
end
if _v238 then
_v239(_v245.Position.Y)
end
end)
table.insert(_v395, function()
_v458, hueDrag = false, false
end)
table.insert(_v460, function()
h, s, v = _v208():ToHSV()
_v391(false)
end)
end
local function _v538(box, _v263, _v209, _v433, _v124)
local _v275 = false
local function _v391()
if _v275 then
box.Text = (_V9({109,226,12,46,20,117,121,37}))
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
UI:Notify(string.format((_V9({24,227,73,52,20,183,152,239,102,88,241,13,36,71,245,150,246,122,89,176,29,50,71,178,138})), _v258.Name, _v123), 2.5)
else
_v433(_v258)
UI:Notify(string.format((_V9({24,227,73,63,8,226,151,231,52,73,255,73,120,20})), _v263, _v258.Name), 2)
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
table.insert(_v460, function()
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
if _v185 ~= (_V9({80,245,7,40})) and _v122.UI.MenuKey == _v258 then
return (_V9({112,245,7,40}))
end
if _v185 ~= (_V9({92,249,4,63,8,227})) and _v122.Camera.ToggleKey == _v258 then
return (_V9({124,249,4,63,8,227}))
end
if _v185 ~= (_V9({88,227,25})) and _v122.ESP.ToggleKey == _v258 then
return (_V9({120,195,57}))
end
if _v185 ~= (_V9({91,255,31,62,14,229,154,239,113})) and _v122.Camera.FOVCircleKey == _v258 then
return (_V9({123,223,63,125,36,254,139,224,120,88}))
end
if _v185 ~= (_V9({83,255,27,56,4,248,144,239})) and _v122.NoRecoil.ToggleKey == _v258 then
return (_V9({115,255,73,15,2,244,150,234,120}))
end
if _v185 ~= (_V9({83,255,26,45,21,242,152,231})) and _v122.NoSpread.ToggleKey == _v258 then
return (_V9({115,255,73,14,23,229,156,226,112}))
end
if _v185 ~= (_V9({73,226,0,58,0,242,139,225,123,73})) and _v122.Triggerbot.ToggleKey == _v258 then
return (_V9({105,226,0,58,0,242,139,225,123,73}))
end
if _v185 ~= (_V9({94,252,0,62,12,227,137})) and _v122.Movement.ClickTPKey == _v258 then
return (_V9({126,252,0,62,12,183,173,211}))
end
if _v185 ~= (_V9({72,254,5,50,6,243})) and _v122.UI.UnloadKey == _v258 then
return (_V9({104,254,5,50,6,243}))
end
return nil
end
local function _v289(_v368, _v263, _v209, _v433, _v124)
local _v231 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v231, CornerRadius = UDim.new(0, 6) })
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
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
local box = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
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
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v84, CornerRadius = UDim.new(0, 4) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v84, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v84,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v322((_V9({104,217,58,52,29,242,186,236,122,78,228,27,60,14,249,141})), { Parent = _v84, MinSize = Vector2.new(54, 22) })
_v538(_v84, _v263, _v209, _v433, _v124)
end
local function _v295(_v368, text, _v211, _v351, _v260, _v209, _v433, _v124)
local btn = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v114 = _v322((_V9({123,226,8,48,2})), {
Parent = _v87,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v211() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v114, CornerRadius = UDim.new(0, 3) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v114, Color = _v4.border, Thickness = 1 })
local _v262 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v87,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v211() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v485,
})
local box = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
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
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v84, CornerRadius = UDim.new(0, 4) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v84, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v84,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v322((_V9({104,217,58,52,29,242,186,236,122,78,228,27,60,14,249,141})), { Parent = _v84, MinSize = Vector2.new(44, 20) })
local function _v391()
local _v350 = _v211()
_v44:Create(_v114, _v1, { BackgroundColor3 = _v350 and _v4.accent or _v4.off }):Play()
_v44:Create(_v262, _v1, { TextColor3 = _v350 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v351()
_v391()
end)
table.insert(_v460, _v391)
_v538(_v84, _v260, _v209, _v433, _v124)
end
local function _v282(_v368)
local function _v121(order)
local _v117 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v362,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
Parent = _v117,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v117
end
return _v121(1), _v121(2)
end
local function _v286(_v368, title)
local _v542 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v322((_V9({123,226,8,48,2})), {
Parent = _v542,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v84, CornerRadius = UDim.new(0, 6) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v84, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v84,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
Parent = _v84,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v84,
LayoutOrder = -1,
Size = UDim2.new(1, 0, 0, 15),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v486,
})
local _v517 = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
Parent = _v542,
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
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v517, CornerRadius = UDim.new(0, 6) })
local _v39, GAP = 0.72, 1
local _v215 = _v322((_V9({123,226,8,48,2})), {
Parent = _v517,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v4.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v215, CornerRadius = UDim.new(0, 6) })
_v322((_V9({104,217,46,47,6,243,144,230,122,73})), {
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
local function _v461()
local _v424 = (_v537 and _v537.Scale) or 1
if _v424 <= 0 then
_v424 = 1
end
_v542.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v424)
end
box:GetPropertyChangedSignal((_V9({124,242,26,50,11,226,141,230,71,84,234,12}))):Connect(_v461)
_v461()
local function _v432(_v169)
_v517.Visible = not _v169
end
return _v84, _v432
end
local function _v292(_v368)
local bar = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
Parent = _v72,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v159 = _v322((_V9({123,226,8,48,2})), {
Parent = _v368,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v4.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v70 = _v322((_V9({123,226,8,48,2})), {
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
local btn = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
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
local underline = _v322((_V9({123,226,8,48,2})), {
Parent = _v87,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v501, CornerRadius = UDim.new(1, 0) })
local frame = _v322((_V9({110,243,27,50,11,251,144,237,115,123,226,8,48,2})), {
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
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
Parent = _v202,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v322((_V9({104,217,57,60,3,243,144,237,115})), { Parent = _v202, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = _v87, underline = _v501 }
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
local _v267, right = _v282(_v233:add((_V9({124,249,4,63,8,227}))))
local _v59 = _v286(_v267, (_V9({124,249,4,63,8,227})))
_v295(_v59, (_V9({120,254,8,63,11,242,157})), function()
return _v122.Camera.Enabled
end, function()
_v122.Camera.Enabled = not _v122.Camera.Enabled
end, (_V9({124,249,4,63,8,227,217,200,113,68})), function()
return _v122.Camera.ToggleKey
end, function(_v258)
_v122.Camera.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({92,249,4,63,8,227})))
end)
_v294(_v59, (_V9({107,249,26,62,15,242,154,232})), function()
return _v122.Camera.WallCheck
end, function()
_v122.Camera.WallCheck = not _v122.Camera.WallCheck
end)
_v294(_v59, (_V9({110,228,0,62,12,238,217,215,117,79,247,12,41})), function()
return _v122.Camera.StickyTarget
end, function()
_v122.Camera.StickyTarget = not _v122.Camera.StickyTarget
end)
_v294(_v59, (_V9({105,241,27,58,2,227,217,193,123,73,227})), function()
return _v122.Camera.TargetBots
end, function()
_v122.Camera.TargetBots = not _v122.Camera.TargetBots
end)
_v294(_v59, (_V9({105,245,8,48,71,212,145,230,119,86})), function()
return _v122.Camera.TeamCheck
end, function()
_v122.Camera.TeamCheck = not _v122.Camera.TeamCheck
end)
_v294(_v59, (_V9({117,229,4,60,9,254,131,230})), function()
return _v122.Camera.Humanize
end, function()
_v122.Camera.Humanize = not _v122.Camera.Humanize
end)
_v295(_v59, (_V9({123,223,63,125,36,254,139,224,120,88})), function()
return _v122.Camera.FOVCircle
end, function()
_v122.Camera.FOVCircle = not _v122.Camera.FOVCircle
end, (_V9({123,223,63,125,36,254,139,224,120,88,176,34,56,30})), function()
return _v122.Camera.FOVCircleKey
end, function(_v258)
_v122.Camera.FOVCircleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({91,255,31,62,14,229,154,239,113})))
end)
_v285(_v59, (_V9({110,253,6,50,19,255,151,230,103,78})), 0.05, 1, function()
return _v122.Camera.Smoothness
end, function(_v512)
_v122.Camera.Smoothness = _v512
end, false)
_v285(_v59, (_V9({109,226,12,57,14,244,141,234,123,83})), 0, 1, function()
return _v122.Camera.Prediction
end, function(_v512)
_v122.Camera.Prediction = _v512
end, false)
_v285(_v59, (_V9({123,223,63})), 20, 800, function()
return _v122.Camera.FOV
end, function(_v512)
_v122.Camera.FOV = _v512
end, true, (_V9({77,232})), true)
_v285(_v59, (_V9({112,241,17,125,35,254,138,247,117,83,243,12})), 100, 2000, function()
return _v122.Camera.MaxDistance
end, function(_v512)
_v122.Camera.MaxDistance = _v512
end, true, (_V9({80})), true)
local _v393
local _v230 = _v286(_v407, (_V9({117,249,29,63,8,239})))
_v284(_v230, _v122.Camera.HitboxOptions, function()
return _v122.Camera.Hitbox
end, function(_v512)
_v122.Camera.Hitbox = _v512
if _v393 then
_v393()
end
end)
local _v535, setWeightsEnabled = _v286(_v407, (_V9({105,241,27,58,2,227,217,208,113,73,228,0,51,0,228})))
local function _v534(name)
_v285(_v535, _v317 .. (_V9({29,199,12,52,0,255,141})), 0, 100, function()
return _v122.Camera.TargetWeights[name]
end, function(_v512)
_v122.Camera.TargetWeights[name] = _v512
end, true, (_V9({24})), true)
end
_v534((_V9({117,245,8,57})))
_v534((_V9({105,255,27,46,8})))
_v534((_V9({124,226,4,46})))
_v534((_V9({113,245,14,46})))
_v393 = function()
setWeightsEnabled(_v122.Camera.Hitbox == (_V9({111,241,7,57,8,250,217,171,67,88,249,14,53,19,242,157,170})))
end
_v393()
table.insert(_v460, _v393)
local _v496 = _v286(_v407, (_V9({105,226,0,58,0,242,139,225,123,73})))
_v295(_v496, (_V9({120,254,8,63,11,242,157})), function()
return _v122.Triggerbot.Enabled
end, function()
_v122.Triggerbot.Enabled = not _v122.Triggerbot.Enabled
end, (_V9({105,226,0,58,0,242,139,225,123,73,176,34,56,30})), function()
return _v122.Triggerbot.ToggleKey
end, function(_v258)
_v122.Triggerbot.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({73,226,0,58,0,242,139,225,123,73})))
end)
_v285(_v496, (_V9({112,249,7,125,35,242,149,226,109})), 0, 500, function()
return _v122.Triggerbot.MinDelay * 1000
end, function(_v512)
_v122.Triggerbot.MinDelay = _v512 / 1000
end, true, (_V9({80,227})), true)
_v285(_v496, (_V9({112,241,17,125,35,242,149,226,109})), 0, 500, function()
return _v122.Triggerbot.MaxDelay * 1000
end, function(_v512)
_v122.Triggerbot.MaxDelay = _v512 / 1000
end, true, (_V9({80,227})), true)
_v285(_v496, (_V9({112,241,17,125,35,254,138,247,117,83,243,12})), 100, 2000, function()
return _v122.Triggerbot.MaxDistance
end, function(_v512)
_v122.Triggerbot.MaxDistance = _v512
end, true, (_V9({80})), true)
_v294(_v496, (_V9({107,249,26,62,15,242,154,232})), function()
return _v122.Triggerbot.WallCheck
end, function()
_v122.Triggerbot.WallCheck = not _v122.Triggerbot.WallCheck
end)
local _v441 = _v286(_v407, (_V9({110,249,5,56,9,227,217,194,125,80})))
_v294(_v441, (_V9({120,254,8,63,11,242,157})), function()
return _v122.SilentAim.Enabled
end, function()
_v122.SilentAim.Enabled = not _v122.SilentAim.Enabled
end)
local _v184 = _v286(_v407, (_V9({117,249,29,63,8,239,217,198,108,77,241,7,57,2,229})))
_v294(_v184, (_V9({120,254,8,63,11,242,157})), function()
return _v122.Hitbox.Enabled
end, function()
_v122.Hitbox.Enabled = not _v122.Hitbox.Enabled
end)
_v285(_v184, (_V9({110,249,19,56})), 1, 20, function()
return _v122.Hitbox.Size
end, function(_v512)
_v122.Hitbox.Size = _v512
end, true)
_v285(_v184, (_V9({105,226,8,51,20,231,152,241,113,83,243,16})), 0, 1, function()
return _v122.Hitbox.Transparency
end, function(_v512)
_v122.Hitbox.Transparency = _v512
end, false)
_v267, right = _v282(_v233:add((_V9({106,245,8,45,8,249,138}))))
local _v390 = _v286(_v267, (_V9({115,255,73,15,2,244,150,234,120})))
_v295(_v390, (_V9({120,254,8,63,11,242,157})), function()
return _v122.NoRecoil.Enabled
end, function()
_v122.NoRecoil.Enabled = not _v122.NoRecoil.Enabled
end, (_V9({115,255,73,15,2,244,150,234,120,29,219,12,36})), function()
return _v122.NoRecoil.ToggleKey
end, function(_v258)
_v122.NoRecoil.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({83,255,27,56,4,248,144,239})))
end)
_v294(_v390, (_V9({114,254,5,36,71,192,145,234,120,88,176,47,52,21,254,151,228})), function()
return _v122.NoRecoil.RequireMouseDown
end, function()
_v122.NoRecoil.RequireMouseDown = not _v122.NoRecoil.RequireMouseDown
end)
_v294(_v390, (_V9({124,252,5,50,16,183,184,234,121,29,212,6,42,9})), function()
return _v122.NoRecoil.AllowAim
end, function()
_v122.NoRecoil.AllowAim = not _v122.NoRecoil.AllowAim
end)
_v285(_v390, (_V9({110,228,27,56,9,240,141,235})), 0, 100, function()
return _v122.NoRecoil.Strength * 100
end, function(_v512)
_v122.NoRecoil.Strength = _v512 / 100
end, true, (_V9({24})), true)
local _v445 = _v286(_v267, (_V9({115,255,73,14,23,229,156,226,112})))
_v295(_v445, (_V9({120,254,8,63,11,242,157})), function()
return _v122.NoSpread.Enabled
end, function()
_v122.NoSpread.Enabled = not _v122.NoSpread.Enabled
end, (_V9({115,255,73,14,23,229,156,226,112,29,219,12,36})), function()
return _v122.NoSpread.ToggleKey
end, function(_v258)
_v122.NoSpread.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({83,255,26,45,21,242,152,231})))
end)
_v294(_v445, (_V9({114,254,5,36,71,192,145,234,120,88,176,47,52,21,254,151,228})), function()
return _v122.NoSpread.RequireMouseDown
end, function()
_v122.NoSpread.RequireMouseDown = not _v122.NoSpread.RequireMouseDown
end)
_v285(_v445, (_V9({110,228,27,56,9,240,141,235})), 0, 100, function()
return _v122.NoSpread.Strength * 100
end, function(_v512)
_v122.NoSpread.Strength = _v512 / 100
end, true, (_V9({24})), true)
end
local function _v89(_v368, _v122)
_v266 = 0
local _v233 = _v292(_v368)
local _v267, right = _v282(_v233:add((_V9({120,195,57}))))
local _v177 = _v286(_v267, (_V9({120,195,57})))
_v295(_v177, (_V9({120,254,8,63,11,242,157})), function()
return _v122.ESP.Enabled
end, function()
_v122.ESP.Enabled = not _v122.ESP.Enabled
end, (_V9({120,195,57,125,44,242,128})), function()
return _v122.ESP.ToggleKey
end, function(_v258)
_v122.ESP.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({88,227,25})))
end)
_v294(_v177, (_V9({115,192,42,46})), function()
return _v122.ESP.NPCs
end, function()
_v122.ESP.NPCs = not _v122.ESP.NPCs
end)
_v285(_v177, (_V9({112,241,17,125,35,254,138,247,117,83,243,12})), 100, 2000, function()
return _v122.ESP.MaxDistance
end, function(_v512)
_v122.ESP.MaxDistance = _v512
end, true, (_V9({80})), true)
local _v277 = _v286(_v267, (_V9({124,224,25,56,6,229,152,237,119,88})))
_v294(_v277, (_V9({114,229,29,49,14,249,156,240})), function()
return _v122.ESP.Outlines
end, function()
_v122.ESP.Outlines = not _v122.ESP.Outlines
end)
_v294(_v277, (_V9({127,255,17,56,20})), function()
return _v122.ESP.Boxes
end, function()
_v122.ESP.Boxes = not _v122.ESP.Boxes
end)
_v294(_v277, (_V9({115,241,4,56,20})), function()
return _v122.ESP.Names
end, function()
_v122.ESP.Names = not _v122.ESP.Names
end)
_v294(_v277, (_V9({121,249,26,41,6,249,154,230})), function()
return _v122.ESP.Distance
end, function()
_v122.ESP.Distance = not _v122.ESP.Distance
end)
_v294(_v277, (_V9({117,245,8,49,19,255,217,193,117,79,227})), function()
return _v122.ESP.HealthBars
end, function()
_v122.ESP.HealthBars = not _v122.ESP.HealthBars
end)
_v294(_v277, (_V9({123,249,5,49,2,243})), function()
return _v122.ESP.Filled
end, function()
_v122.ESP.Filled = not _v122.ESP.Filled
end)
_v285(_v277, (_V9({114,229,29,49,14,249,156,163,91,77,241,10,52,19,238})), 0, 1, function()
return _v122.ESP.OutlineOpacity
end, function(_v512)
_v122.ESP.OutlineOpacity = _v512
end, false)
_v285(_v277, (_V9({123,249,5,49,71,216,137,226,119,84,228,16})), 0, 1, function()
return _v122.ESP.FillOpacity
end, function(_v512)
_v122.ESP.FillOpacity = _v512
end, false)
local _v163 = _v286(_v407, (_V9({121,226,8,42,14,249,158,163,81,110,192})))
_v294(_v163, (_V9({127,255,17,56,20})), function()
return _v122.Drawing.Boxes
end, function()
_v122.Drawing.Boxes = not _v122.Drawing.Boxes
end)
_v294(_v163, (_V9({105,226,8,62,2,229,138})), function()
return _v122.Drawing.Tracers
end, function()
_v122.Drawing.Tracers = not _v122.Drawing.Tracers
end)
local _v539 = _v286(_v407, (_V9({106,255,27,49,3})))
_v294(_v539, (_V9({123,229,5,49,5,229,144,228,124,73})), function()
return _v122.Visuals.Fullbright
end, function()
_v122.Visuals.Fullbright = not _v122.Visuals.Fullbright
end)
_v294(_v539, (_V9({115,255,73,27,8,240})), function()
return _v122.Visuals.NoFog
end, function()
_v122.Visuals.NoFog = not _v122.Visuals.NoFog
end)
_v267, right = _v282(_v233:add((_V9({126,255,5,50,21,228}))))
_v281(_v267, (_V9({114,229,29,49,14,249,156,163,87,82,252,6,47})), function()
return _v122.ESP.OutlineColor
end, function(c)
_v122.ESP.OutlineColor = c
end)
_v281(_v407, (_V9({123,249,5,49,71,212,150,239,123,79})), function()
return _v122.ESP.FillColor
end, function(c)
_v122.ESP.FillColor = c
end)
_v281(_v267, (_V9({127,255,17,125,36,248,149,236,102})), function()
return _v122.Drawing.BoxColor
end, function(c)
_v122.Drawing.BoxColor = c
end)
_v281(_v407, (_V9({105,226,8,62,2,229,217,192,123,81,255,27})), function()
return _v122.Drawing.TracerColor
end, function(c)
_v122.Drawing.TracerColor = c
end)
end
local function _v93(_v368, _v122)
_v266 = 0
local _v233 = _v292(_v368)
local _v267, right = _v282(_v233:add((_V9({112,255,31,56,10,242,151,247}))))
local _v189 = _v286(_v267, (_V9({123,252,16})))
_v294(_v189, (_V9({120,254,8,63,11,242,157})), function()
return _v122.Movement.FlyEnabled
end, function()
_v122.Movement.FlyEnabled = not _v122.Movement.FlyEnabled
end)
_v285(_v189, (_V9({123,252,16,125,52,231,156,230,112})), 10, 200, function()
return _v122.Movement.FlySpeed
end, function(_v512)
_v122.Movement.FlySpeed = _v512
end, true)
local _v444 = _v286(_v267, (_V9({110,224,12,56,3})))
_v294(_v444, (_V9({120,254,8,63,11,242,157})), function()
return _v122.Movement.SpeedEnabled
end, function()
_v122.Movement.SpeedEnabled = not _v122.Movement.SpeedEnabled
end)
_v285(_v444, (_V9({110,224,12,56,3})), 16, 100, function()
return _v122.Movement.Speed
end, function(_v512)
_v122.Movement.Speed = _v512
end, true)
local _v300 = _v286(_v267, (_V9({114,228,1,56,21})))
_v294(_v300, (_V9({115,255,10,49,14,231})), function()
return _v122.Movement.NoclipEnabled
end, function()
_v122.Movement.NoclipEnabled = not _v122.Movement.NoclipEnabled
end)
_v294(_v300, (_V9({116,254,15,52,9,254,141,230,52,119,229,4,45})), function()
return _v122.Movement.InfJumpEnabled
end, function()
_v122.Movement.InfJumpEnabled = not _v122.Movement.InfJumpEnabled
end)
local _v494 = _v286(_v407, (_V9({126,252,0,62,12,183,173,211})))
_v294(_v494, (_V9({120,254,8,63,11,242,157})), function()
return _v122.Movement.ClickTPEnabled
end, function()
_v122.Movement.ClickTPEnabled = not _v122.Movement.ClickTPEnabled
end)
_v289(_v494, (_V9({112,255,13,52,1,254,156,241,52,118,245,16})), function()
return _v122.Movement.ClickTPKey
end, function(_v258)
_v122.Movement.ClickTPKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({94,252,0,62,12,227,137})))
end)
end
local function _v94(_v368, _v122)
_v266 = 0
local _v233 = _v292(_v368)
local _v267, right = _v282(_v233:add((_V9({122,245,7,56,21,246,149}))))
local _v243 = _v286(_v267, (_V9({116,254,29,56,21,241,152,224,113})))
_v285(_v243, (_V9({104,217,73,14,4,246,149,230})), 0.8, 1.5, function()
return _v122.UI.Scale
end, function(_v512)
_v122.UI.Scale = _v512
if _v537 then
_v537.Scale = _v512
end
end, false)
_v294(_v243, (_V9({118,245,16,63,14,249,157,163,68,92,254,12,49})), function()
return _v122.UI.KeybindPanel
end, function()
_v122.UI.KeybindPanel = not _v122.UI.KeybindPanel
if _v261 then
_v261.Visible = _v122.UI.KeybindPanel
end
end)
_v294(_v243, (_V9({105,241,27,58,2,227,217,199,125,78,224,5,60,30})), function()
return _v122.UI.TargetDisplay
end, function()
_v122.UI.TargetDisplay = not _v122.UI.TargetDisplay
_v471 = _v122.UI.TargetDisplay
if not _v471 and _v472 then
_v472.Visible = false
end
end)
_v294(_v243, (_V9({123,192,58,125,36,248,140,237,96,88,226})), function()
return _v122.UI.FPSCounter
end, function()
_v122.UI.FPSCounter = not _v122.UI.FPSCounter
if _v200 then
_v200.Visible = _v122.UI.FPSCounter
end
end)
_v294(_v243, (_V9({106,241,29,56,21,250,152,241,127})), function()
return _v122.UI.Watermark
end, function()
_v122.UI.Watermark = not _v122.UI.Watermark
if _v533 then
_v533.Visible = _v122.UI.Watermark
end
end)
local _v53 = _v286(_v407, (_V9({124,243,10,50,18,249,141})))
_v290(_v53, (_V9({104,227,12,47,9,246,148,230})), _v26 and _v26.Name or (_V9({223,16,253})))
_v290(_v53, (_V9({121,249,26,45,11,246,128,163,90,92,253,12})), _v26 and _v26.DisplayName or (_V9({223,16,253})))
_v290(_v53, (_V9({104,227,12,47,71,222,189})), _v26 and tostring(_v26.UserId) or (_V9({223,16,253})))
_v294(_v53, (_V9({124,254,29,52,74,214,191,200})), function()
return _v122.Utility.AntiAFK
end, function()
_v122.Utility.AntiAFK = not _v122.Utility.AntiAFK
end)
_v280(_v53, (_V9({110,245,27,43,2,229,217,203,123,77})), function()
Utility:ServerHop()
end)
_v280(_v53, (_V9({111,245,3,50,14,249,217,208,113,79,230,12,47})), function()
Utility:Rejoin()
end)
_v267, right = _v282(_v233:add((_V9({126,255,7,59,14,240,138}))))
local _v110 = _v286(_v267, (_V9({126,255,7,59,14,240,138})))
if not _v9.isSupported() then
_v290(_v110, (_V9({110,228,8,41,18,228})), (_V9({104,254,26,40,23,231,150,241,96,88,244})))
return
end
local _v318 = _v293(_v110, (_V9({94,255,7,59,14,240,217,237,117,80,245,139,221,193})))
local _v273 = _v322((_V9({123,226,8,48,2})), {
Parent = _v110,
LayoutOrder = _v323(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
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
if not _v115:IsA((_V9({104,217,37,52,20,227,181,226,109,82,229,29}))) then
_v115:Destroy()
end
end
local _v320 = _v9.list()
if #_v320 == 0 then
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v273,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({83,255,73,46,6,225,156,231,52,94,255,7,59,14,240,138})),
})
return
end
for i, name in ipairs(_v320) do
local _v430 = (_v318.Text == _v317)
local row = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
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
Text = (_V9({29,176})) .. _v317,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v415, CornerRadius = UDim.new(0, 4) })
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
_v280(_v110, (_V9({110,241,31,56})), function()
local _v340, res = _v9.save(_v318.Text, _v122)
if _v340 then
UI:Notify((_V9({110,241,31,56,3,183,154,236,122,91,249,14,125,64})) .. _v401 .. (_V9({26})), 2)
_v392()
else
UI:Notify(tostring(_v401), 3)
end
end)
_v280(_v110, (_V9({113,255,8,57})), function()
local _v340, res = _v9.load(_v318.Text, _v122)
if _v340 then
if _v537 then
_v537.Scale = _v122.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({113,255,8,57,2,243,217,224,123,83,246,0,58,71,176})) .. _v401 .. (_V9({26})), 2)
else
UI:Notify(tostring(_v401), 3)
end
end)
_v280(_v110, (_V9({121,245,5,56,19,242})), function()
local _v340, res = _v9.delete(_v318.Text)
if _v340 then
UI:Notify((_V9({121,245,5,56,19,242,157,163,119,82,254,15,52,0,183,222})) .. _v401 .. (_V9({26})), 2)
_v318.Text = (_V9({}))
_v392()
else
UI:Notify(tostring(_v401), 3)
end
end, _v4.danger)
_v392()
end
local function _v95(_v122)
_v472 = _v322((_V9({123,226,8,48,2})), {
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
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v472, CornerRadius = UDim.new(0, 6) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v472, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v472,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
Parent = _v472,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v160 = _v322((_V9({123,226,8,48,2})), {
Parent = _v472,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v160, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v472,
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
_v472.InputBegan:Connect(function(_v245)
if _v254(_v245) then
_v162 = true
_v161 = _v245.Position
_v450 = _v472.Position
end
end)
table.insert(_v306, function(_v245)
if _v162 and _v472 then
local delta = _v245.Position - _v161
_v472.Position = UDim2.new(
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
table.insert(_v460, function()
_v471 = _v122.UI.TargetDisplay
if not _v471 and _v472 then
_v472.Visible = false
end
end)
_v471 = _v122.UI.TargetDisplay
end
local function _v91(_v122)
_v200 = _v322((_V9({123,226,8,48,2})), {
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
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v200, CornerRadius = UDim.new(0, 6) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v200, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v200,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
Parent = _v200,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v160 = _v322((_V9({123,226,8,48,2})), {
Parent = _v200,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v160, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
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
Text = (_V9({16,189,73,59,23,228})),
})
table.insert(_v460, function()
if _v200 then
_v200.Visible = _v122.UI.FPSCounter
end
end)
_v200.Visible = _v122.UI.FPSCounter
end
local function _v96(_v122)
_v533 = _v322((_V9({116,253,8,58,2,219,152,225,113,81})), {
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
table.insert(_v460, function()
if _v533 then
_v533.Visible = _v122.UI.Watermark
end
end)
_v533.Visible = _v122.UI.Watermark
end
local function _v92(_v122)
_v266 = 0
_v261 = _v322((_V9({123,226,8,48,2})), {
Parent = _v214,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
Visible = false,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v261, CornerRadius = UDim.new(0, 8) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v261, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), {
Parent = _v261,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v261,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v322((_V9({123,226,8,48,2})), {
Parent = _v261,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v72, CornerRadius = UDim.new(0, 6) })
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v72,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({118,245,16,63,14,249,157,240})),
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
_v289(_v261, (_V9({112,245,7,40})), function()
return _v122.UI.MenuKey
end, function(_v258)
_v122.UI.MenuKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({80,245,7,40})))
end)
_v289(_v261, (_V9({124,249,4,63,8,227})), function()
return _v122.Camera.ToggleKey
end, function(_v258)
_v122.Camera.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({92,249,4,63,8,227})))
end)
_v289(_v261, (_V9({120,195,57})), function()
return _v122.ESP.ToggleKey
end, function(_v258)
_v122.ESP.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({88,227,25})))
end)
_v289(_v261, (_V9({123,223,63,125,36,254,139,224,120,88})), function()
return _v122.Camera.FOVCircleKey
end, function(_v258)
_v122.Camera.FOVCircleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({91,255,31,62,14,229,154,239,113})))
end)
_v289(_v261, (_V9({115,255,73,15,2,244,150,234,120})), function()
return _v122.NoRecoil.ToggleKey
end, function(_v258)
_v122.NoRecoil.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({83,255,27,56,4,248,144,239})))
end)
_v289(_v261, (_V9({115,255,73,14,23,229,156,226,112})), function()
return _v122.NoSpread.ToggleKey
end, function(_v258)
_v122.NoSpread.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({83,255,26,45,21,242,152,231})))
end)
_v289(_v261, (_V9({105,226,0,58,0,242,139,225,123,73})), function()
return _v122.Triggerbot.ToggleKey
end, function(_v258)
_v122.Triggerbot.ToggleKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({73,226,0,58,0,242,139,225,123,73})))
end)
_v289(_v261, (_V9({104,254,5,50,6,243})), function()
return _v122.UI.UnloadKey
end, function(_v258)
_v122.UI.UnloadKey = _v258
end, function(_v258)
return _v259(_v122, _v258, (_V9({72,254,5,50,6,243})))
end)
table.insert(_v460, function()
if _v261 then
_v261.Visible = _v122.UI.KeybindPanel
end
end)
_v261.Visible = _v122.UI.KeybindPanel
end
local function _v435(_v451)
if not _v279 or _v451 == _v521 then
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
local _v499 = _v44:Create(_v279, TweenInfo.new(_v16), { GroupTransparency = 1 })
_v499.Completed:Once(function()
if not _v521 and _v279 then
_v279.Visible = false
end
end)
_v499:Play()
end
end
function UI:Init(_v122, _v354)
if _v214 then
return
end
_v56 = _v122
_v355 = _v354
_v449()
_v214 = _v322((_V9({110,243,27,56,2,249,190,246,125})), {
Name = (_V9({107,241,7,52,19,238,190,230,122,88,226,8,49,50,222})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v340 = pcall(function()
_v214.Parent = Utility.getGuiParent()
end)
if not _v340 or not _v214.Parent then
_v214.Parent = _v26:WaitForChild((_V9({109,252,8,36,2,229,190,246,125})))
end
_v279 = _v322((_V9({126,241,7,43,6,228,190,241,123,72,224})), {
Parent = _v214,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v537 = _v322((_V9({104,217,58,62,6,251,156})), { Parent = _v279, Scale = _v122.UI.Scale })
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v279, CornerRadius = UDim.new(0, 8) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v279, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
local _v487 = _v322((_V9({123,226,8,48,2})), {
Parent = _v279,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v487, CornerRadius = UDim.new(0, 8) })
_v322((_V9({123,226,8,48,2})), {
Parent = _v487,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
local _v160 = _v322((_V9({123,226,8,48,2})), {
Parent = _v487,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v160, CornerRadius = UDim.new(1, 0) })
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v487,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({107,241,7,52,19,238,197,229,123,83,228,73,62,8,251,150,241,41,31,179,81,105,84,210,187,198,54,3,190,13,56,17,171,214,229,123,83,228,87,125,32,242,151,230,102,92,252}))
.. (_V9({1,246,6,51,19,183,154,236,120,82,226,84,127,68,175,184,180,87,124,160,75,99,71,183,217,65,163,29,176,73,43,87,171,214,229,123,83,228,87})),
ZIndex = 2,
})
_v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v487,
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
_v487.InputBegan:Connect(function(_v245)
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
local _v440 = _v322((_V9({123,226,8,48,2})), {
Parent = _v279,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v440, CornerRadius = UDim.new(0, 6) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v440, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v440,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v466 = _v322((_V9({123,226,8,48,2})), {
Parent = _v440,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({104,217,37,52,20,227,181,226,109,82,229,29})), { Parent = _v466, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v503 = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
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
Text = (_V9({104,254,5,50,6,243})),
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v503, CornerRadius = UDim.new(0, 6) })
local _v504 = _v322((_V9({104,217,58,41,21,248,146,230})), {
Parent = _v503,
Color = _v4.danger,
Thickness = 1,
Transparency = 0.55,
})
_v503.MouseButton1Click:Connect(function()
if _v355 then
_v355()
end
end)
_v503.MouseEnter:Connect(function()
_v44:Create(_v503, _v1, {
BackgroundColor3 = _v4.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v44:Create(_v504, _v1, { Transparency = 0 }):Play()
end)
_v503.MouseLeave:Connect(function()
_v44:Create(_v503, _v1, {
BackgroundColor3 = _v4.row,
TextColor3 = _v4.danger,
}):Play()
_v44:Create(_v504, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v322((_V9({123,226,8,48,2})), {
Parent = _v279,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v322((_V9({104,217,57,60,3,243,144,237,115})), {
Parent = _v128,
PaddingRight = UDim.new(0, 4),
})
local _v468 = { (_V9({126,255,4,63,6,227})), (_V9({107,249,26,40,6,251})), (_V9({112,255,31,56,10,242,151,247})), (_V9({110,245,29,41,14,249,158,240})) }
local _v465 = {}
for i, _v467 in ipairs(_v468) do
local _v248 = _v132 == _v467
local _v463 = _v322((_V9({105,245,17,41,37,226,141,247,123,83})), {
Parent = _v466,
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
Text = (_V9({29,176,73,125})) .. _v467,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v463, CornerRadius = UDim.new(0, 6) })
local stripe = _v322((_V9({123,226,8,48,2})), {
Parent = _v463,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
Visible = _v248,
ZIndex = 2,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v453, CornerRadius = UDim.new(1, 0) })
local _v464 = _v322((_V9({123,226,8,48,2})), {
Parent = _v128,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v248,
})
_v465[_v467] = { btn = _v463, frame = _v464, stripe = _v453 }
_v463.MouseButton1Click:Connect(function()
_v132 = _v467
for name, _v462 in pairs(_v465) do
local _v54 = _v317 == _v467
_v462.frame.Visible = _v54
_v462.stripe.Visible = _v54
_v44:Create(_v462.btn, _v1, {
BackgroundTransparency = _v54 and 0 or 1,
TextColor3 = _v54 and _v4.text or _v4.textSub,
}):Play()
end
end)
_v463.MouseEnter:Connect(function()
if _v132 ~= _v467 then
_v44:Create(_v463, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v463.MouseLeave:Connect(function()
if _v132 ~= _v467 then
_v44:Create(_v463, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v88(_v465[(_V9({126,255,4,63,6,227}))].frame, _v122)
_v89(_v465[(_V9({107,249,26,40,6,251}))].frame, _v122)
_v93(_v465[(_V9({112,255,31,56,10,242,151,247}))].frame, _v122)
_v94(_v465[(_V9({110,245,29,41,14,249,158,240}))].frame, _v122)
_v92(_v122)
_v95(_v122)
_v91(_v122)
_v96(_v122)
if _v122.UI.Visible then
_v435(true)
end
end
function UI:Toggle()
_v435(not _v521)
end
function UI:Show()
_v435(true)
end
function UI:Hide()
_v435(false)
end
function UI:SetCurrentTarget(name)
if not _v472 then
return
end
if _v472.Visible ~= _v471 then
_v472.Visible = _v471
end
if not _v471 or not _v473 then
return
end
local _v439, colour
if _v317 and _v317 ~= (_V9({})) and _v317 ~= (_V9({115,255,7,56})) then
_v439, colour = _v317, (_V9({30,168,93,110,34,213,188}))
else
_v439, colour = (_V9({104,254,34,51,8,224,151})), (_V9({30,168,40,106,36,214,201}))
end
local text = (_V9({105,241,27,58,2,227,195,163,40,91,255,7,41,71,244,150,239,123,79,173,75})) .. _v120 .. (_V9({31,174})) .. _v439 .. (_V9({1,191,15,50,9,227,199}))
if targetPanelLabel.Text ~= _v485 then
targetPanelLabel.Text = _v485
end
end
function UI:UpdateFPS(_v196)
if not _v199 or not _v200 or not _v200.Visible then
return
end
local text = string.format((_V9({1,246,6,51,19,183,154,236,120,82,226,84,127,68,175,205,176,81,127,213,75,99,66,243,197,172,114,82,254,29,99,71,241,137,240})), _v196 or 0)
if fpsLabel.Text ~= _v485 then
fpsLabel.Text = _v485
end
end
function UI:SetWatermarkImage(_v242)
if not _v533 then
return
end
local _v152 = tostring(_v242 or (_V9({}))):match((_V9({24,244,66})))
_v533.Image = _v152 and ((_V9({79,242,17,60,20,228,156,247,125,89,170,70,114})) .. _v152) or (_V9({}))
end
function UI:SyncControls()
for _, _v191 in ipairs(_v460) do
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
local _v488 = _v322((_V9({105,245,17,41,43,246,155,230,120})), {
Parent = _v214,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 12),
Size = UDim2.fromOffset(math.max(200, #_v485 * 8 + 28), 34),
BackgroundColor3 = _v4.bar,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v4.text,
Text = _v485,
})
_v322((_V9({104,217,42,50,21,249,156,241})), { Parent = _v488, CornerRadius = UDim.new(0, 8) })
_v322((_V9({104,217,58,41,21,248,146,230})), { Parent = _v488, Color = _v4.accent, Thickness = 1, Transparency = 0.3 })
_v44:Create(_v488, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v168, function()
if _v488 and _v488.Parent then
local _v365 = _v44:Create(_v488, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v365.Completed:Once(function()
if _v488 then
_v488:Destroy()
end
end)
_v365:Play()
end
end)
end
function UI:Cleanup()
for _, _v125 in ipairs(_v500) do
_v125:Disconnect()
end
table.clear(_v500)
table.clear(_v306)
table.clear(_v395)
table.clear(_v460)
_v55 = nil
_v105 = false
_v57 = nil
_v472, targetPanelLabel = nil, nil
_v471 = false
_v261 = nil
_v533 = nil
_v200, fpsLabel = nil, nil
_v537 = nil
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v46 = game:GetService((_V9({104,227,12,47,46,249,137,246,96,110,245,27,43,14,244,156})))
local _v51 = game:GetService((_V9({106,255,27,54,20,231,152,224,113})))
local _v26 = _v31.LocalPlayer
local UI = _v45
local Movement = {}
local _v2 = 16
local _v23 = 50
local _v310
local _v308
local function _v307()
local _v112 = _v26.Character
local root = _v112 and _v112:FindFirstChild((_V9({117,229,4,60,9,248,144,231,70,82,255,29,13,6,229,141})))
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({117,229,4,60,9,248,144,231})))
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
if _v369:IsA((_V9({127,241,26,56,55,246,139,247}))) then
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
local _v518 = Vector3.zero
if not UI:IsCapturingKey() then
local _v153 = _v309(_v97)
if _v153 then
_v518 = _v153 * (_v122.FlySpeed or 50)
end
end
root.AssemblyLinearVelocity = _v518
end
return
end
if _v122.SpeedEnabled then
local _v444 = _v122.Speed or _v2
local _v305 = humanoid.MoveDirection
if _v444 > _v2 and _v305.Magnitude > 0 then
local _v518 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v305.X * _v444, _v518.Y, _v305.Z * _v444)
end
end
end
local function _v312(_v122)
if not _v122.InfJumpEnabled then
return
end
local _, root = _v307()
if _v412 then
local _v518 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v518.X, _v23, _v518.Z)
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
local _v31 = game:GetService((_V9({109,252,8,36,2,229,138})))
local _v36 = game:GetService((_V9({111,229,7,14,2,229,143,234,119,88})))
local _v46 = game:GetService((_V9({104,227,12,47,46,249,137,246,96,110,245,27,43,14,244,156})))
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
_v11.Version = (_V9({13}))
_v11.Config = _v10
_v50.Version = _v11.Version
local _v416 = false
local _v126 = {}
local _v63 = false
local _v32 = (_V9({107,241,7,52,19,238,190,230,122,88,226,8,49,53,242,154,236,125,81}))
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
warn(string.format((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,49,78,176,15,60,14,251,156,231,52,21,232,76,57,78,173,217,166,103})), _v317, _v448.failures, tostring(_v401)))
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
function _v11.SetWebhook(_v510)
return _v50.SetWebhook(_v510)
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
_v213((_V9({109,252,8,36,2,229,184,231,112,88,244})), ESP.OnPlayerAdded, _v15, _v378)
end))
table.insert(_v126, _v31.PlayerRemoving:Connect(function(_v378)
_v213((_V9({109,252,8,36,2,229,171,230,121,82,230,0,51,0})), ESP.OnPlayerRemoving, _v15, _v378)
end))
table.insert(_v126, _v46.InputBegan:Connect(function(_v245, _v206)
if _v206 or UI:IsCapturingKey() then
return
end
_v213((_V9({118,245,16,63,14,249,157,240})), function()
local _v258 = _v245.KeyCode
if _v258 == _v10.UI.MenuKey then
UI:Toggle()
elseif _v258 == _v10.UI.UnloadKey then
_v11.Stop()
else
local _v489 = {
{ _v10.Camera, (_V9({120,254,8,63,11,242,157})), _v10.Camera.ToggleKey },
{ _v10.ESP, (_V9({120,254,8,63,11,242,157})), _v10.ESP.ToggleKey },
{ _v10.Camera, (_V9({123,223,63,30,14,229,154,239,113})), _v10.Camera.FOVCircleKey },
{ _v10.NoRecoil, (_V9({120,254,8,63,11,242,157})), _v10.NoRecoil.ToggleKey },
{ _v10.NoSpread, (_V9({120,254,8,63,11,242,157})), _v10.NoSpread.ToggleKey },
{ _v10.Triggerbot, (_V9({120,254,8,63,11,242,157})), _v10.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v489) do
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
_v213((_V9({126,241,7,57,14,243,152,247,113,78})), _v8.Update, _v8, _v10.Camera, _v10.ESP)
_v213((_V9({120,195,57})), ESP.Update, _v15, _v10.ESP)
local _v342, target = _v213((_V9({124,249,4,63,8,227})), _v7.Update, _v7, _v10.Camera, _v10.Debug)
if not _v342 then
target = nil
end
if _v10.UI.TargetDisplay then
_v213((_V9({105,241,27,58,2,227,217,231,125,78,224,5,60,30})), function()
local _v278 = _v7:GetLookTarget(_v10.ESP, _v10.Camera)
UI:SetCurrentTarget(_v278 and _v278.Name or nil)
end)
end
_v63 = _v10.Camera.Enabled and _v470 ~= nil
_v213((_V9({115,255,58,45,21,242,152,231})), NoSpread.Update, _v30, _v10.NoSpread)
_v213((_V9({105,226,0,58,0,242,139,225,123,73})), Triggerbot.Update, _v43, _v10.Triggerbot, _v10.Camera)
_v213((_V9({112,255,31,56,10,242,151,247})), Movement.Update, _v27, _v167, _v10.Movement)
_v213((_V9({117,249,29,63,8,239})), _v22.Update, _v22, _v10.Hitbox, _v10.Camera)
_v213((_V9({121,226,8,42,14,249,158,163,81,110,192})), _v14.Update, _v14, _v10.Drawing, _v10.Camera)
_v213((_V9({107,249,26,40,6,251,138})), Visuals.Update, _v49, _v10.Visuals)
_v197 = _v197 + _v167
fpsFrames = _v198 + 1
if _v197 >= 0.25 then
local _v196 = math.floor(_v198 / _v197 + 0.5)
_v197, fpsFrames = 0, 0
if _v10.UI.FPSCounter then
_v213((_V9({123,192,58,125,4,248,140,237,96,88,226})), UI.UpdateFPS, _v45, _v196)
end
end
end))
pcall(function()
_v36:UnbindFromRenderStep(_v32)
end)
pcall(function()
_v36:BindToRenderStep(_v32, Enum.RenderPriority.Camera.Value + 1, function()
_v213((_V9({115,255,59,56,4,248,144,239})), NoRecoil.Update, _v29, _v10.NoRecoil, _v63)
end)
end)
end)
if not _v340 then
warn((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,82,92,249,5,56,3,183,141,236,52,78,228,8,47,19,173})), _v176)
_v11.Stop()
return _v11
end
if getgenv then
getgenv().VanityGeneral = _v11
end
UI:Notify(string.format((_V9({107,241,7,52,19,238,212,196,113,83,245,27,60,11,183,149,236,117,89,245,13,125,71,117,121,33,52,29,192,27,56,20,228,217,166,103})), _v10.UI.MenuKey.Name), 4)
print(string.format((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,70,72,254,7,52,9,240,217,171,98,24,227,64})), _v11.Version))
print(string.format((_V9({112,245,7,40,93,183,220,240,52,29,236,73,125,36,246,148,230,102,92,170,73,120,20,183,217,255,52,29,197,7,49,8,246,157,185,52,24,227})),
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
print((_V9({102,198,8,51,14,227,128,174,83,88,254,12,47,6,251,164,163,71,73,255,25,45,2,243})))
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
if _v384 and _v384 ~= _v11 and type(_v384.Stop) == (_V9({91,229,7,62,19,254,150,237})) then
pcall(_v384.Stop)
end
end
pcall(function()
_v11.Start()
end)
return _v11
end
