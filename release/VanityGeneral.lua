local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({205,38,215,121,61,223,111,159,97})
local _v9
local _v8
local Utility
local _v7
local _v6
local ESP
local _v13
local Visuals
local _v38
local Triggerbot
local SilentAim
local Hitbox
local NoRecoil
local NoSpread
local UI
local Movement
local _v10
_v9 = (function()
local _v9 = {}
_v9.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Prediction = 0,
Humanize = true,
Hitbox = (_V9({159,71,185,29,82,178,79,183,54,168,79,176,17,73,186,11,182})),
HitboxOptions = { (_V9({159,71,185,29,82,178,79,183,54,168,79,176,17,73,186,11,182})), (_V9({133,67,182,29})), (_V9({153,73,165,10,82})), (_V9({140,84,186,10})), (_V9({129,67,176,10})) },
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
_v9.NoRecoil = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
AllowAim = false,
ToggleKey = Enum.KeyCode.F2,
}
_v9.NoSpread = {
Enabled = false,
Strength = 1,
RequireMouseDown = true,
ToggleKey = Enum.KeyCode.F3,
}
_v9.Triggerbot = {
Enabled = false,
MinDelay = 0.1,
MaxDelay = 0.25,
MaxDistance = 1000,
WallCheck = true,
ToggleKey = Enum.KeyCode.F4,
}
_v9.Movement = {
FlyEnabled = false,
FlySpeed = 50,
NoclipEnabled = false,
SpeedEnabled = false,
Speed = 16,
InfJumpEnabled = false,
ClickTPEnabled = false,
ClickTPKey = Enum.KeyCode.LeftControl,
Pulse = true,
PulseBoost = 0.1,
PulseCoast = 0.15,
ClickTPSteps = false,
ClickTPStep = 10,
ClickTPInterval = 0.05,
}
_v9.SilentAim = {
Enabled = false,
}
_v9.Hitbox = {
Enabled = false,
Size = 5,
Transparency = 0.5,
}
_v9.Drawing = {
Boxes = false,
Tracers = false,
BoxColor = Color3.fromRGB(165, 75, 255),
TracerColor = Color3.fromRGB(255, 255, 255),
}
_v9.Visuals = {
Fullbright = false,
NoFog = false,
}
_v9.Utility = {
AntiAFK = true,
}
_v9.ESP = {
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
_v9.UI = {
Scale = 1,
MenuKey = Enum.KeyCode.RightShift,
UnloadKey = Enum.KeyCode.End,
Visible = false,
Accent = Color3.fromRGB(132, 62, 190),
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
WatermarkImageId = (_V9({252,21,238,65,9,234,89,166,82,245,19,239,65,8,233})),
}
_v9.Webhook = {
Url = (_V9({})),
}
_v9.Debug = false
local _v11 = {
Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Prediction = 0,
Humanize = true,
Hitbox = (_V9({159,71,185,29,82,178,79,183,54,168,79,176,17,73,186,11,182})),
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
Pulse = true,
PulseBoost = 0.1,
PulseCoast = 0.15,
ClickTPSteps = false,
ClickTPStep = 10,
ClickTPInterval = 0.05,
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
Accent = Color3.fromRGB(132, 62, 190),
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
},
}
function _v9.reset()
for _v398, _v486 in pairs(_v11) do
for _v229, value in pairs(_v486) do
if type(value) == (_V9({185,71,181,21,88})) then
local target = _v9[_v398][_v229]
if type(target) ~= (_V9({185,71,181,21,88})) then
target = {}
_v9[_v398][_v229] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v9[_v398][_v229] = value
end
end
end
end
return _v9
end)()
_v8 = (function()
local _v8 = {}
local _v5 = (_V9({155,71,185,16,73,166,40,250,15,168,84,182,21}))
local _v30 = { (_V9({142,71,186,28,79,190})), (_V9({136,117,135})), (_V9({131,73,133,28,94,176,6,243})), (_V9({131,73,132,9,79,186,14,251})), (_V9({128,73,161,28,80,186,1,235})), (_V9({158,79,187,28,83,171,46,246,12})), (_V9({133,79,163,27,82,167})), (_V9({137,84,182,14,84,177,8})), (_V9({155,79,164,12,92,179,28})), (_V9({152,82,190,21,84,171,22})), (_V9({152,111})) }
local function _v180()
return type(writefile) == (_V9({171,83,185,26,73,182,0,241}))
and type(readfile) == (_V9({171,83,185,26,73,182,0,241}))
and type(listfiles) == (_V9({171,83,185,26,73,182,0,241}))
end
local function _v155()
if type(isfolder) == (_V9({171,83,185,26,73,182,0,241})) and type(makefolder) == (_V9({171,83,185,26,73,182,0,241})) then
if not isfolder(_v5) then
pcall(makefolder, _v5)
end
end
end
local function _v393(name)
return (tostring(name or (_V9({}))):gsub((_V9({150,120,242,14,98,250,66,191,60})), (_V9({}))):gsub((_V9({147,3,164,82})), (_V9({}))):gsub((_V9({232,85,252,93})), (_V9({}))))
end
local function _v344(name)
return _v5 .. (_V9({226,86,165,22,91,182,3,250,62})) .. game.PlaceId .. (_V9({146})) .. name .. (_V9({227,76,164,22,83}))
end
local function _v241(name)
return _v5 .. (_V9({226})) .. name .. (_V9({227,76,164,22,83}))
end
local function _v154(v)
local t = typeof(v)
if t == (_V9({142,73,187,22,79,236})) then
return { __t = (_V9({142,73,187,22,79,236})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({136,72,162,20,116,171,10,242})) then
return { __t = (_V9({136,72,162,20})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({185,71,181,21,88})) then
local _v339 = {}
for k, _v483 in pairs(v) do
if type(_v483) ~= (_V9({171,83,185,26,73,182,0,241})) then
local _v153 = _v154(_v483)
if _v153 ~= nil then
_v339[k] = _v153
end
end
end
return _v339
elseif t == (_V9({163,83,186,27,88,173})) or t == (_V9({190,82,165,16,83,184})) or t == (_V9({175,73,184,21,88,190,1})) then
return v
end
return nil
end
local function _v127(v)
if type(v) ~= (_V9({185,71,181,21,88})) then
return v
end
if v.__t == (_V9({142,73,187,22,79,236})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({136,72,162,20})) then
local _v315, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v315 then
return item
end
return nil
end
return v
end
local function _v59(target, _v420)
for k, v in pairs(_v420) do
if type(v) == (_V9({185,71,181,21,88})) and v.__t == nil then
if type(target[k]) == (_V9({185,71,181,21,88})) then
_v59(target[k], v)
end
else
local _v128 = _v127(v)
if _v128 ~= nil then
target[k] = _v128
end
end
end
end
function _v8.isSupported()
return _v180()
end
function _v8.list()
local _v339 = {}
if not _v180() then
return _v339
end
_v155()
local _v315, files = pcall(listfiles, _v5)
if not _v315 or type(files) ~= (_V9({185,71,181,21,88})) then
return _v339
end
for _, _v343 in ipairs(files) do
local _v357 = (_V9({189,84,184,31,84,179,10,192})) .. game.PlaceId .. (_V9({146}))
local name = tostring(_v343):match((_V9({229,125,137,86,97,130,68,182,68,227,76,164,22,83,251})))
if name and name:sub(1, #_v357) == _v357 then
table.insert(_v339, name:sub(#_v357 + 1))
end
end
table.sort(_v339)
return _v339
end
function _v8.save(name, _v108)
if not _v180() then
return false, (_V9({153,78,190,10,29,186,23,250,2,184,82,184,11,29,183,14,236,65,163,73,247,31,84,179,10,191,32,157,111}))
end
name = _v393(name)
if name == (_V9({})) then
return false, (_V9({136,72,163,28,79,255,14,191,2,162,72,177,16,90,255,1,254,12,168}))
end
_v155()
local data = {}
for _, _v398 in ipairs(_v30) do
if type(_v108[_v398]) == (_V9({185,71,181,21,88})) then
data[_v398] = _v154(_v108[_v398])
end
end
local _v319, json = pcall(function()
return game:GetService((_V9({133,82,163,9,110,186,29,233,8,174,67}))):JSONEncode(data)
end)
if not _v319 then
return false, (_V9({136,72,180,22,89,186,79,249,0,164,74,178,29,7,255})) .. tostring(json)
end
local _v322, err = pcall(writefile, _v344(name), json)
if not _v322 then
return false, (_V9({154,84,190,13,88,255,9,254,8,161,67,179,67,29})) .. tostring(err)
end
return true, name
end
function _v8.load(name, _v108)
if not _v180() then
return false, (_V9({153,78,190,10,29,186,23,250,2,184,82,184,11,29,183,14,236,65,163,73,247,31,84,179,10,191,32,157,111}))
end
name = _v393(name)
if name == (_V9({})) then
return false, (_V9({136,72,163,28,79,255,14,191,2,162,72,177,16,90,255,1,254,12,168}))
end
local _v343 = _v344(name)
if type(isfile) == (_V9({171,83,185,26,73,182,0,241})) then
local _v318, exists = pcall(isfile, _v343)
if _v318 and not exists then
local _v240 = _v241(name)
local _v320, legacyExists = pcall(isfile, _v240)
if _v320 and legacyExists then
_v343 = _v240
else
return false, (_V9({131,73,247,26,82,177,9,246,6,237,72,182,20,88,187,79,184})) .. name .. (_V9({234}))
end
end
end
local _v321, raw = pcall(readfile, _v343)
if not _v321 or type(raw) ~= (_V9({190,82,165,16,83,184})) then
return false, (_V9({159,67,182,29,29,185,14,246,13,168,66}))
end
local _v319, data = pcall(function()
return game:GetService((_V9({133,82,163,9,110,186,29,233,8,174,67}))):JSONDecode(raw)
end)
if not _v319 or type(data) ~= (_V9({185,71,181,21,88})) then
return false, (_V9({153,78,182,13,29,185,6,243,4,237,79,164,23,26,171,79,233,0,161,79,179,89,119,140,32,209}))
end
for _, _v398 in ipairs(_v30) do
if type(data[_v398]) == (_V9({185,71,181,21,88})) and type(_v108[_v398]) == (_V9({185,71,181,21,88})) then
_v59(_v108[_v398], data[_v398])
end
end
return true, name
end
function _v8.delete(name)
name = _v393(name)
if name == (_V9({})) then
return false, (_V9({136,72,163,28,79,255,14,191,2,162,72,177,16,90,255,1,254,12,168}))
end
if type(delfile) ~= (_V9({171,83,185,26,73,182,0,241})) then
return false, (_V9({153,78,190,10,29,186,23,250,2,184,82,184,11,29,188,14,241,70,185,6,179,28,81,186,27,250,65,171,79,187,28,78}))
end
local _v315, err = pcall(delfile, _v344(name))
if not _v315 then
return false, tostring(err)
end
return true, name
end
return _v8
end)()
Utility = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v34 = game:GetService((_V9({153,67,187,28,77,176,29,235,50,168,84,161,16,94,186})))
local _v22 = _v24.LocalPlayer
local Utility = {}
local _v34 = game:GetService((_V9({153,67,187,28,77,176,29,235,50,168,84,161,16,94,186})))
local _v482
function Utility:Init(_v108)
if _v482 then
return
end
local _v500 = (type(VirtualUser) ~= (_V9({163,79,187})) and VirtualUser) or nil
if not _v500 then
pcall(function()
_v500 = game:GetService((_V9({155,79,165,13,72,190,3,202,18,168,84})))
end)
end
if not _v500 then
return
end
_v482 = _v22.Idled:Connect(function()
if _v108.AntiAFK then
_v500:CaptureController()
_v500:ClickButton2(Vector2.new())
end
end)
end
function Utility:Cleanup()
if _v482 then
_v482:Disconnect()
_v482 = nil
end
end
function Utility:ServerHop()
local _v315, err = pcall(function()
_v34:Teleport(game.PlaceId, _v22)
end)
if not _v315 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,50,168,84,161,28,79,255,7,240,17,237,64,182,16,81,186,11,165})), err)
end
return _v315
end
function Utility:Rejoin()
local _v315, err = pcall(function()
_v34:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v22)
end)
if not _v315 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,51,168,76,184,16,83,255,9,254,8,161,67,179,67})), err)
end
return _v315
end
function Utility.getGuiParent()
local _v315, hidden = pcall(function()
return gethui and gethui()
end)
if _v315 and hidden then
return hidden
end
local _v316, coreGui = pcall(function()
return game:GetService((_V9({142,73,165,28,122,170,6})))
end)
if _v316 and coreGui then
return coreGui
end
return _v22:WaitForChild((_V9({157,74,182,0,88,173,40,234,8})))
end
return Utility
end)()
_v7 = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local _v7 = {}
_v7.LocalRootPos = nil
local frame = {}
local _v3 = 0.5
local _v69 = {}
local _v70 = -math.huge
function _v7.GetBotCharacters()
local _v298 = os.clock()
if _v298 - _v70 < _v3 then
return _v69
end
_v70 = _v298
table.clear(_v69)
for _, _v130 in ipairs(_v39:GetDescendants()) do
if _v130:IsA((_V9({128,73,179,28,81})))
and _v130:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
and not _v24:GetPlayerFromCharacter(_v130)
then
table.insert(_v69, _v130)
end
end
return _v69
end
local function _v386(_v99, humanoid)
return humanoid.RootPart
or _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
or _v99:FindFirstChild((_V9({153,73,165,10,82})))
or _v99:FindFirstChild((_V9({152,86,167,28,79,139,0,237,18,162})))
or _v99.PrimaryPart
end
local _v27 = {
Head = { (_V9({133,67,182,29})) },
Torso = { (_V9({152,86,167,28,79,139,0,237,18,162})), (_V9({129,73,160,28,79,139,0,237,18,162})), (_V9({153,73,165,10,82})), (_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})) },
Arms = {
(_V9({129,67,177,13,117,190,1,251})), (_V9({159,79,176,17,73,151,14,241,5})),
(_V9({129,67,177,13,113,176,24,250,19,140,84,186})), (_V9({159,79,176,17,73,147,0,232,4,191,103,165,20})),
(_V9({129,67,177,13,104,175,31,250,19,140,84,186})), (_V9({159,79,176,17,73,138,31,239,4,191,103,165,20})),
(_V9({129,67,177,13,29,158,29,242})), (_V9({159,79,176,17,73,255,46,237,12})),
},
Legs = {
(_V9({129,67,177,13,123,176,0,235})), (_V9({159,79,176,17,73,153,0,240,21})),
(_V9({129,67,177,13,113,176,24,250,19,129,67,176})), (_V9({159,79,176,17,73,147,0,232,4,191,106,178,30})),
(_V9({129,67,177,13,104,175,31,250,19,129,67,176})), (_V9({159,79,176,17,73,138,31,239,4,191,106,178,30})),
(_V9({129,67,177,13,29,147,10,248})), (_V9({159,79,176,17,73,255,35,250,6})),
},
}
local _v26 = { (_V9({133,67,182,29})), (_V9({153,73,165,10,82})), (_V9({140,84,186,10})), (_V9({129,67,176,10})) }
local function _v347(_v99, _v370)
local _v293 = _v27[_v370]
if not _v293 then
return nil
end
for _, name in ipairs(_v293) do
local _v342 = _v99:FindFirstChild(name)
if _v342 and _v342:IsA((_V9({143,71,164,28,109,190,29,235}))) then
return _v342
end
end
return nil
end
local function _v346(_v99)
for _, _v370 in ipairs(_v26) do
local _v342 = _v347(_v99, _v370)
if _v342 then
return _v342
end
end
for _, _v130 in ipairs(_v99:GetDescendants()) do
if _v130:IsA((_V9({143,71,164,28,109,190,29,235}))) then
return _v130
end
end
return nil
end
local function _v55(_v99, _v196, hrp)
return _v196
or hrp
or _v99:FindFirstChild((_V9({152,86,167,28,79,139,0,237,18,162})))
or _v99:FindFirstChild((_V9({153,73,165,10,82})))
or _v346(_v99)
end
local function _v75(_v99, _v351, _v84, _v85)
local humanoid = _v99 and _v99:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v196 = _v99:FindFirstChild((_V9({133,67,182,29})))
local hrp = _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
local _v385 = _v386(_v99, humanoid)
local _v54 = _v55(_v99, _v196, hrp)
local _v158 = {
Player = _v351,
Character = _v99,
Humanoid = humanoid,
Head = _v196,
RootPart = _v385,
HRP = hrp,
Anchor = _v54,
}
if _v54 then
_v158.WorldDistance = (_v54.Position - _v85).Magnitude
local _v431, vis = _v84:WorldToViewportPoint(_v54.Position)
_v158.AnchorScreen = _v431
_v158.AnchorOnScreen = vis
end
if _v385 then
local _v464 = _v196 and (_v196.Position + Vector3.new(0, _v196.Size.Y, 0))
or (_v385.Position + Vector3.new(0, 3, 0))
local _v469, tvis = _v84:WorldToViewportPoint(_v464)
_v158.TopScreen = _v469
_v158.TopOnScreen = tvis
_v158.BotScreen = _v84:WorldToViewportPoint(_v385.Position - Vector3.new(0, 3.2, 0))
end
return _v158
end
function _v7:Update(_v86, _v160)
table.clear(frame)
local _v84 = _v39.CurrentCamera
local _v288 = _v22.Character
local _v289 = _v288 and _v288:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
_v7.LocalRootPos = _v289 and _v289.Position or nil
if not _v84 then
return
end
local _v85 = _v84.CFrame.Position
for _, _v351 in ipairs(_v24:GetPlayers()) do
if _v351 ~= _v22 then
local _v158 = _v75(_v351.Character, _v351, _v84, _v85)
if _v158 then
table.insert(frame, _v158)
end
end
end
if _v86 and _v86.TargetBots then
for _, _v99 in ipairs(_v7.GetBotCharacters()) do
local _v158 = _v75(_v99, nil, _v84, _v85)
if _v158 then
table.insert(frame, _v158)
end
end
end
end
function _v7:Get()
return frame
end
return _v7
end)()
_v6 = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local Utility = Utility
local _v7 = _v7
local _v6 = {}
local Camera = _v39.CurrentCamera
local _v94 = Random.new()
local _v27 = {
Head = { (_V9({133,67,182,29})) },
Torso = { (_V9({152,86,167,28,79,139,0,237,18,162})), (_V9({129,73,160,28,79,139,0,237,18,162})), (_V9({153,73,165,10,82})), (_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})) },
Arms = {
(_V9({129,67,177,13,117,190,1,251})), (_V9({159,79,176,17,73,151,14,241,5})),
(_V9({129,67,177,13,113,176,24,250,19,140,84,186})), (_V9({159,79,176,17,73,147,0,232,4,191,103,165,20})),
(_V9({129,67,177,13,104,175,31,250,19,140,84,186})), (_V9({159,79,176,17,73,138,31,239,4,191,103,165,20})),
(_V9({129,67,177,13,29,158,29,242})), (_V9({159,79,176,17,73,255,46,237,12})),
},
Legs = {
(_V9({129,67,177,13,123,176,0,235})), (_V9({159,79,176,17,73,153,0,240,21})),
(_V9({129,67,177,13,113,176,24,250,19,129,67,176})), (_V9({159,79,176,17,73,147,0,232,4,191,106,178,30})),
(_V9({129,67,177,13,104,175,31,250,19,129,67,176})), (_V9({159,79,176,17,73,138,31,239,4,191,106,178,30})),
(_V9({129,67,177,13,29,147,10,248})), (_V9({159,79,176,17,73,255,35,250,6})),
},
}
local _v26 = { (_V9({133,67,182,29})), (_V9({153,73,165,10,82})), (_V9({140,84,186,10})), (_V9({129,67,176,10})) }
local _v382 = Random.new()
local function _v347(_v99, _v370)
local _v293 = _v27[_v370]
if not _v293 then
return nil
end
for _, name in ipairs(_v293) do
local _v342 = _v99:FindFirstChild(name)
if _v342 and _v342:IsA((_V9({143,71,164,28,109,190,29,235}))) then
return _v342
end
end
return nil
end
local function _v346(_v99)
for _, _v370 in ipairs(_v26) do
local _v342 = _v347(_v99, _v370)
if _v342 then
return _v342
end
end
for _, _v130 in ipairs(_v99:GetDescendants()) do
if _v130:IsA((_V9({143,71,164,28,109,190,29,235}))) then
return _v130
end
end
return nil
end
local function _v56(_v99)
return _v99:FindFirstChild((_V9({133,67,182,29})))
or _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
or _v99:FindFirstChild((_V9({152,86,167,28,79,139,0,237,18,162})))
or _v99:FindFirstChild((_V9({153,73,165,10,82})))
or _v346(_v99)
end
local function _v384(_v504)
local _v465 = 0
for _, _v370 in ipairs(_v26) do
_v465 = _v465 + math.max(0, (_v504 and _v504[_v370]) or 0)
end
if _v465 <= 0 then
return (_V9({133,67,182,29}))
end
local _v383 = _v382:NextNumber() * _v465
local _v40 = 0
for _, _v370 in ipairs(_v26) do
_v40 = _v40 + math.max(0, _v504[_v370] or 0)
if _v383 <= _v40 then
return _v370
end
end
return (_V9({133,67,182,29}))
end
local function _v186(_v510)
local _v489, visible = Camera:WorldToViewportPoint(_v510)
if not visible or _v489.Z < 0 then
return math.huge
end
local _v396 = Vector2.new(_v489.X, _v489.Y)
local _v95 = Camera.ViewportSize / 2
return (_v396 - _v95).Magnitude
end
local function _v228(_v356, _v99)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v22.Character }
local _v380 = _v39:Raycast(Camera.CFrame.Position, _v356 - Camera.CFrame.Position, params)
return not _v380 or _v380.Instance:IsDescendantOf(_v99)
end
local _v15 = Color3.fromRGB(132, 62, 190)
local _v173, _v174, fovStroke
local function _v156()
if _v174 and _v174.Parent then
return _v174
end
_v173 = Instance.new((_V9({158,69,165,28,88,177,40,234,8})))
_v173.Name = (_V9({155,71,185,16,73,166,40,250,15,168,84,182,21,123,144,57}))
_v173.ResetOnSpawn = false
_v173.IgnoreGuiInset = true
_v173.DisplayOrder = 998
local _v315 = pcall(function()
_v173.Parent = Utility.getGuiParent()
end)
if not _v315 or not _v173.Parent then
_v173.Parent = _v22:WaitForChild((_V9({157,74,182,0,88,173,40,234,8})))
end
_v174 = Instance.new((_V9({139,84,182,20,88})))
_v174.Name = (_V9({159,79,185,30}))
_v174.AnchorPoint = Vector2.new(0.5, 0.5)
_v174.Position = UDim2.fromScale(0.5, 0.5)
_v174.BackgroundTransparency = 1
_v174.BorderSizePixel = 0
_v174.Parent = _v173
local _v114 = Instance.new((_V9({152,111,148,22,79,177,10,237})))
_v114.CornerRadius = UDim.new(1, 0)
_v114.Parent = _v174
fovStroke = Instance.new((_V9({152,111,132,13,79,176,4,250})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v15
fovStroke.Parent = _v174
return _v174
end
local function _v476(_v108)
local _v409 = _v108.FOVCircle
if not _v409 then
if _v174 then
_v174.Visible = false
end
return
end
local _v381 = _v156()
if not _v381 then
return
end
local _v135 = math.max(0, _v108.FOV or 0) * 2
_v381.Size = UDim2.fromOffset(_v135, _v135)
_v381.Visible = true
end
local function _v134()
if _v173 then
pcall(function()
_v173:Destroy()
end)
end
_v173, _v174, fovStroke = nil, nil, nil
end
local function _v163(_v99, _v351, _v108)
if not _v99 then
return nil
end
if _v108.TeamCheck and _v351 and _v351.Team ~= nil and _v351.Team == _v22.Team then
return nil
end
local humanoid = _v99:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v54 = _v56(_v99)
if not _v54 then
return nil
end
local _v140 = _v186(_v54.Position)
if _v140 >= (_v108.FOV or 200) then
return nil
end
local _v509 = (_v54.Position - Camera.CFrame.Position).Magnitude
if _v509 > _v108.MaxDistance then
return nil
end
if _v108.WallCheck and not _v228(_v54.Position, _v99) then
return nil
end
return { Player = _v351, Character = _v99, Anchor = _v54, ScreenDistance = _v140 }
end
local function _v397(_v88)
if not _v88.AnchorOnScreen or _v88.AnchorScreen.Z < 0 then
return math.huge
end
local _v396 = Vector2.new(_v88.AnchorScreen.X, _v88.AnchorScreen.Y)
local _v95 = Camera.ViewportSize / 2
return (_v396 - _v95).Magnitude
end
local function _v162(_v88, _v108)
local _v351 = _v88.Player
if _v108.TeamCheck and _v351 and _v351.Team ~= nil and _v351.Team == _v22.Team then
return nil
end
local _v54 = _v88.Anchor
if not _v54 then
return nil
end
local _v140 = _v397(_v88)
if _v140 >= (_v108.FOV or 200) then
return nil
end
if (_v88.WorldDistance or math.huge) > _v108.MaxDistance then
return nil
end
if _v108.WallCheck and not _v228(_v54.Position, _v88.Character) then
return nil
end
return { Player = _v351, Character = _v88.Character, Anchor = _v54, ScreenDistance = _v140 }
end
function _v6:FindBestTarget(_v108)
local _v65
local _v66 = math.huge
for _, _v88 in ipairs(_v7:Get()) do
local _v89 = _v162(_v88, _v108)
if _v89 and _v89.ScreenDistance < _v66 then
_v66 = _v89.ScreenDistance
_v65 = _v89
end
end
return _v65
end
local _v20 = 50
function _v6:GetLookTarget(_v160, _v86)
local _v65
local _v66 = _v20
local _v290 = _v7.LocalRootPos
local _v269 = (_v160 and _v160.MaxDistance) or math.huge
local _v457 = _v86 and _v86.TeamCheck
for _, _v88 in ipairs(_v7:Get()) do
local _v351 = _v88.Player
if not (_v457 and _v351 and _v351.Team ~= nil and _v351.Team == _v22.Team) then
local _v54 = _v88.Anchor
if _v54 and not (_v290 and (_v54.Position - _v290).Magnitude > _v269) then
local _v140 = _v397(_v88)
if _v140 <= _v66 then
_v66 = _v140
_v65 = _v351 or _v88.Character
end
end
end
end
return _v65
end
function _v6:_resolveRegion(_v99, _v108)
local _v274 = _v108.Hitbox
if _v274 and _v274 ~= (_V9({159,71,185,29,82,178,79,183,54,168,79,176,17,73,186,11,182})) and _v27[_v274] then
return _v274
end
if self._lockedChar ~= _v99 then
self._lockedChar = _v99
self._rolledRegion = _v384(_v108.TargetWeights)
end
return self._rolledRegion or (_V9({133,67,182,29}))
end
function _v6:PointCamera(_v447, _v414)
local _v131 = CFrame.lookAt(Camera.CFrame.Position, _v447)
local _v53 = math.clamp(1 - (_v414 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v131, _v53)
end
function _v6:Update(_v108, debug)
Camera = _v39.CurrentCamera
_v476(_v108)
if not _v108.Enabled then
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
if _v108.StickyTarget and self._stickyCharacter then
if not self._stickyPlayer or self._stickyPlayer.Parent == _v24 then
target = _v163(self._stickyCharacter, self._stickyPlayer, _v108)
end
end
if not target then
target = self:FindBestTarget(_v108)
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
local _v370 = self:_resolveRegion(target.Character, _v108)
local _v49 = _v347(target.Character, _v370) or _v346(target.Character)
if not _v49 then
self._currentTarget = nil
return
end
local _v50 = _v49.Position
local _v509 = (_v50 - Camera.CFrame.Position).Magnitude
if (_v108.Prediction or 0) > 0 then
_v50 = _v50 + _v49.AssemblyLinearVelocity * _v108.Prediction * (_v509 / 500)
end
local _v414 = _v108.Smoothness
if _v108.Humanize then
_v414 = _v414 * (0.9 + _v94:NextNumber() * 0.2)
_v50 = _v50 + _v94:NextUnitVector() * (_v509 * math.rad(_v94:NextNumber() * 0.25))
end
self:PointCamera(_v50, _v414)
target.Part = _v49
target.Region = _v370
self._currentTarget = target
if debug then
print((_V9({153,84,182,26,86,182,1,248,91})), target.Character.Name, (_V9({159,67,176,16,82,177,85})), _v370, (_V9({137,79,164,13,92,177,12,250,91})), math.floor(target.ScreenDistance))
end
return target
end
function _v6:GetCurrentTarget()
return self._currentTarget
end
function _v6:Cleanup()
self._lockedChar = nil
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
_v134()
end
_v6.GetBotCharacters = _v7.GetBotCharacters
return _v6
end)()
ESP = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local _v9 = _v9
local Utility = Utility
local _v7 = _v7
local ESP = {}
local _v157 = {}
local _v113
local _v72
local _v12 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v222(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v161(_v99)
local _v213 = _v99:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
return (_v213 and _v213.RootPart)
or _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
or _v99:FindFirstChild((_V9({153,73,165,10,82})))
or _v99:FindFirstChild((_V9({152,86,167,28,79,139,0,237,18,162})))
or _v99.PrimaryPart
end
local function _v183()
if _v72 and _v72.Parent then
return _v72
end
_v72 = Instance.new((_V9({158,69,165,28,88,177,40,234,8})))
_v72.Name = (_V9({155,71,185,16,73,166,40,250,15,168,84,182,21,127,176,23,250,18}))
_v72.ResetOnSpawn = false
_v72.IgnoreGuiInset = true
_v72.DisplayOrder = 996
local _v315 = pcall(function()
_v72.Parent = Utility.getGuiParent()
end)
if not _v315 or not _v72.Parent then
_v72.Parent = _v22:WaitForChild((_V9({157,74,182,0,88,173,40,234,8})))
end
return _v72
end
local function _v475(_v158, _v99, _v108, _v88)
local _v84 = _v39.CurrentCamera
local root = _v88 and _v88.RootPart or _v161(_v99)
if not _v84 or not root or not _v158.box then
if _v158.box then
_v158.box.Visible = false
end
return
end
local _v463, onScreen, botV
if _v88 then
if not _v88.TopScreen then
_v158.box.Visible = false
return
end
_v463, onScreen, botV = _v88.TopScreen, _v88.TopOnScreen, _v88.BotScreen
else
local _v196 = _v99:FindFirstChild((_V9({133,67,182,29})))
local _v464 = _v196 and (_v196.Position + Vector3.new(0, _v196.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v71 = root.Position - Vector3.new(0, 3.2, 0)
_v463, onScreen = _v84:WorldToViewportPoint(_v464)
botV = _v84:WorldToViewportPoint(_v71)
end
if not onScreen or _v463.Z <= 0 then
_v158.box.Visible = false
return
end
local _v200 = math.abs(botV.Y - _v463.Y)
local _v505 = _v200 * 0.62
local _v117 = (_v463.X + botV.X) * 0.5
local _v118 = (_v463.Y + botV.Y) * 0.5
_v158.box.Size = UDim2.fromOffset(_v505, _v200)
_v158.box.Position = UDim2.fromOffset(_v117 - _v505 * 0.5, _v118 - _v200 * 0.5)
_v158.box.BackgroundColor3 = _v108.FillColor
_v158.box.BackgroundTransparency = _v108.Filled and (1 - _v108.FillOpacity) or 1
_v158.boxStroke.Color = _v108.OutlineColor
_v158.boxStroke.Transparency = 1 - _v108.OutlineOpacity
_v158.box.Visible = true
end
local function _v260(_v158, name, _v196, _v108)
local _v444 = Instance.new((_V9({143,79,187,21,95,176,14,237,5,138,83,190})))
_v444.Name = (_V9({155,97,158,23,91,176}))
_v444.Size = UDim2.fromOffset(200, 46)
_v444.StudsOffset = Vector3.new(0, 2.7, 0)
_v444.AlwaysOnTop = true
_v444.Adornee = _v196
_v444.Parent = _v196
local _v206 = Instance.new((_V9({139,84,182,20,88})))
_v206.BackgroundTransparency = 1
_v206.Size = UDim2.fromScale(1, 1)
_v206.Parent = _v444
local _v237 = Instance.new((_V9({152,111,155,16,78,171,35,254,24,162,83,163})))
_v237.SortOrder = Enum.SortOrder.LayoutOrder
_v237.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v237.VerticalAlignment = Enum.VerticalAlignment.Center
_v237.Parent = _v206
local _v292 = Instance.new((_V9({153,67,175,13,113,190,13,250,13})))
_v292.LayoutOrder = 1
_v292.BackgroundTransparency = 1
_v292.Size = UDim2.new(1, 0, 0, 16)
_v292.Font = Enum.Font.GothamBold
_v292.TextSize = 13
_v292.TextColor3 = _v108.OutlineColor
_v292.TextStrokeTransparency = 0.35
_v292.Text = name
_v292.Visible = false
_v292.Parent = _v206
local _v139 = Instance.new((_V9({153,67,175,13,113,190,13,250,13})))
_v139.LayoutOrder = 2
_v139.BackgroundTransparency = 1
_v139.Size = UDim2.new(1, 0, 0, 14)
_v139.Font = Enum.Font.Gotham
_v139.TextSize = 12
_v139.TextColor3 = _v108.OutlineColor
_v139.TextStrokeTransparency = 0.4
_v139.Text = (_V9({}))
_v139.Visible = false
_v139.Parent = _v206
local _v198 = Instance.new((_V9({139,84,182,20,88})))
_v198.LayoutOrder = 3
_v198.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v198.BackgroundTransparency = 0.3
_v198.BorderSizePixel = 0
_v198.Size = UDim2.new(0.55, 0, 0, 5)
_v198.Visible = false
_v198.Parent = _v206
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v198, CornerRadius = UDim.new(1, 0) })
local _v199 = Instance.new((_V9({139,84,182,20,88})))
_v199.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v199.BorderSizePixel = 0
_v199.Size = UDim2.fromScale(1, 1)
_v199.Parent = _v198
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v199, CornerRadius = UDim.new(1, 0) })
_v158.nameTag = _v444
_v158.nameLabel = _v292
_v158.distanceLabel = _v139
_v158.healthBack = _v198
_v158.healthFill = _v199
_v158.nameHead = _v196
end
local function _v477(name, _v158, _v99, _v108, _v88)
local _v196 = _v88 and (_v88.Head or _v88.HRP)
or _v99:FindFirstChild((_V9({133,67,182,29})))
or _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
if not _v196 then
if _v158.nameTag then
_v158.nameTag.Enabled = false
end
return
end
if not _v158.nameTag or not _v158.nameTag.Parent or _v158.nameHead ~= _v196 then
if _v158.nameTag then
pcall(function()
_v158.nameTag:Destroy()
end)
end
_v260(_v158, name, _v196, _v108)
end
_v158.nameLabel.TextColor3 = _v108.OutlineColor
_v158.nameLabel.Visible = _v108.Names or _v108.NameTags
_v158.distanceLabel.Visible = _v108.Distance or _v108.DistanceTags
if _v158.distanceLabel.Visible then
_v158.distanceLabel.TextColor3 = _v108.OutlineColor
local _v290, hrp
if _v88 then
_v290, hrp = _v7.LocalRootPos, _v88.HRP
else
local _v288 = _v22.Character
local _v289 = _v288 and _v288:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
_v290 = _v289 and _v289.Position
hrp = _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
end
local d = (_v290 and hrp) and math.floor((hrp.Position - _v290).Magnitude + 0.5) or 0
_v158.distanceLabel.Text = (_V9({150})) .. d .. (_V9({160,123}))
end
_v158.healthBack.Visible = _v108.HealthBars
if _v108.HealthBars then
local humanoid = _v88 and _v88.Humanoid or _v99:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
local _v178 = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v158.healthFill.Size = UDim2.fromScale(_v178, 1)
_v158.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v178)
end
_v158.nameTag.Enabled = true
end
local function _v203(_v158)
_v158.hl.Enabled = false
if _v158.box then
_v158.box.Visible = false
end
if _v158.nameTag then
_v158.nameTag.Enabled = false
end
end
local function _v374(_v158, _v99, name, _v108, _v88)
if _v108.Outlines then
if _v158.hl.Adornee ~= _v99 then
_v158.hl.Adornee = _v99
end
_v158.hl.OutlineColor = _v108.OutlineColor
_v158.hl.FillColor = _v108.FillColor
_v158.hl.OutlineTransparency = 1 - _v108.OutlineOpacity
_v158.hl.FillTransparency = _v108.Filled and (1 - _v108.FillOpacity) or 1
_v158.hl.DepthMode = _v12
_v158.hl.Enabled = true
else
_v158.hl.Enabled = false
end
if _v108.Boxes then
_v475(_v158, _v99, _v108, _v88)
elseif _v158.box then
_v158.box.Visible = false
end
if _v108.Names or _v108.Distance or _v108.NameTags or _v108.DistanceTags or _v108.HealthBars then
_v477(name, _v158, _v99, _v108, _v88)
elseif _v158.nameTag then
_v158.nameTag.Enabled = false
end
end
local function _v141(_v342)
local _v288 = _v22.Character
local _v289 = _v288 and _v288:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
if not _v289 or not _v342 then
return 0
end
return (_v342.Position - _v289.Position).Magnitude
end
local function _v479(_v88, _v158, _v108)
local hrp = _v88.HRP
if not _v108.Enabled or not hrp then
_v203(_v158)
return
end
local _v290 = _v7.LocalRootPos
local dist = _v290 and (hrp.Position - _v290).Magnitude or 0
if dist > _v108.MaxDistance then
_v203(_v158)
return
end
_v374(_v158, _v88.Character, _v88.Player.Name, _v108, _v88)
end
local function _v295(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v204 = Instance.new((_V9({133,79,176,17,81,182,8,247,21})))
_v204.Name = (_V9({136,117,135,54,72,171,3,246,15,168}))
_v204.Enabled = false
_v204.FillColor = color
_v204.OutlineColor = color
_v204.Parent = _v113
local box = Instance.new((_V9({139,84,182,20,88})))
box.Name = (_V9({136,117,135,59,82,167}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v183()
local boxStroke = Instance.new((_V9({152,111,132,13,79,176,4,250})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = _v204, box = box, boxStroke = boxStroke }
end
local function _v133(_v158)
if _v158.hl then
_v158.hl:Destroy()
end
if _v158.box then
_v158.box:Destroy()
end
if _v158.nameTag then
pcall(function()
_v158.nameTag:Destroy()
end)
end
end
local function _v47(_v351, _v129)
if _v351 == _v22 or _v157[_v351] then
return
end
_v157[_v351] = _v295(_v129)
end
local function _v373(_v351)
local _v158 = _v157[_v351]
if not _v158 then
return
end
_v133(_v158)
_v157[_v351] = nil
end
local _v299 = {}
local _v235 = 0
local _v23 = 1
local function _v372(_v275)
local _v158 = _v299[_v275]
if not _v158 then
return
end
_v133(_v158)
_v299[_v275] = nil
end
local function _v377()
local current = {}
for _, _v313 in ipairs(_v39:GetDescendants()) do
if _v313:IsA((_V9({133,83,186,24,83,176,6,251}))) then
local _v275 = _v313.Parent
if
_v275
and _v275:IsA((_V9({128,73,179,28,81})))
and _v275 ~= _v22.Character
and not _v24:GetPlayerFromCharacter(_v275)
then
current[_v275] = true
if not _v299[_v275] then
_v299[_v275] = _v295(_v9.ESP.OutlineColor)
end
end
end
end
for _v275 in pairs(_v299) do
if not current[_v275] or not _v275.Parent then
_v372(_v275)
end
end
end
local function _v478(_v275, _v158, _v108)
local root = _v161(_v275)
local humanoid = _v275:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
if not _v275.Parent or not root or not _v222(humanoid) then
_v203(_v158)
return
end
if _v141(root) > _v108.MaxDistance then
_v203(_v158)
return
end
_v374(_v158, _v275, _v275.Name, _v108)
end
function ESP:Init()
if _v113 then
return
end
_v113 = Instance.new((_V9({139,73,187,29,88,173})))
_v113.Name = (_V9({155,71,185,16,73,166,40,250,15,168,84,182,21,120,140,63}))
local _v315 = pcall(function()
_v113.Parent = Utility.getGuiParent()
end)
if not _v315 or not _v113.Parent then
_v113.Parent = _v39
end
for _, _v351 in ipairs(_v24:GetPlayers()) do
_v47(_v351, _v9.ESP.OutlineColor)
end
end
function ESP:Update(_v108)
local _v375 = {}
for _, _v88 in ipairs(_v7:Get()) do
local _v351 = _v88.Player
if _v351 then
_v375[_v351] = true
local _v158 = _v157[_v351]
if not _v158 then
_v47(_v351, _v108.OutlineColor)
_v158 = _v157[_v351]
end
_v479(_v88, _v158, _v108)
end
end
for _v351, _v158 in pairs(_v157) do
if _v351.Parent ~= _v24 then
_v373(_v351)
elseif not _v375[_v351] then
_v203(_v158)
end
end
if _v108.Enabled and _v108.NPCs then
if os.clock() - _v235 >= _v23 then
_v235 = os.clock()
_v377()
end
for _v275, _v158 in pairs(_v299) do
_v478(_v275, _v158, _v108)
end
elseif next(_v299) then
for _v275 in pairs(_v299) do
_v372(_v275)
end
end
end
function ESP:OnPlayerAdded(_v351)
_v47(_v351, _v9.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v351)
_v373(_v351)
end
function ESP:Cleanup()
for _v351 in pairs(_v157) do
_v373(_v351)
end
for _v275 in pairs(_v299) do
_v372(_v275)
end
if _v113 then
_v113:Destroy()
_v113 = nil
end
if _v72 then
_v72:Destroy()
_v72 = nil
end
end
return ESP
end)()
_v13 = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local _v7 = _v7
local _v13 = {}
local _v119 = type(Drawing) == (_V9({185,71,181,21,88})) and type(Drawing.new) == (_V9({171,83,185,26,73,182,0,241}))
local _v126 = false
local _v120 = {}
local function _v123()
local _v242 = Drawing.new((_V9({129,79,185,28})))
_v242.Thickness = 1
_v242.Visible = false
return _v242
end
local function _v122(_v351)
local _v158 = {
box = { _v123(), _v123(), _v123(), _v123() },
tracer = _v123(),
}
_v120[_v351] = _v158
return _v158
end
local function _v121(_v158)
for _, _v242 in ipairs(_v158.box) do
_v242.Visible = false
end
_v158.tracer.Visible = false
end
local function _v124(_v351)
local _v158 = _v120[_v351]
if not _v158 then
return
end
_v120[_v351] = nil
for _, _v242 in ipairs(_v158.box) do
_v242:Remove()
end
_v158.tracer:Remove()
end
local function _v125(_v88, _v108, _v84, _v86)
local _v351 = _v88.Player
local _v158 = _v120[_v351]
if _v86.TeamCheck and _v351.Team ~= nil and _v351.Team == _v22.Team then
if _v158 then
_v121(_v158)
end
return
end
local root = _v88.HRP
if not (_v108.Boxes or _v108.Tracers) or not root then
if _v158 then
_v121(_v158)
end
return
end
local _v463, onScreen, botV = _v88.TopScreen, _v88.TopOnScreen, _v88.BotScreen
if not _v463 or not onScreen or _v463.Z <= 0 or botV.Z <= 0 then
if _v158 then
_v121(_v158)
end
return
end
_v158 = _v158 or _v122(_v351)
local _v200 = math.abs(botV.Y - _v463.Y)
local _v505 = _v200 * 0.62
local _v117 = (_v463.X + botV.X) * 0.5
local _v239, right = _v117 - _v505 * 0.5, _v117 + _v505 * 0.5
local _v462, bottom = _v463.Y, botV.Y
local box = _v158.box
box[1].From = Vector2.new(_v239, _v462)
box[1].To = Vector2.new(right, _v462)
box[2].From = Vector2.new(_v239, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v239, _v462)
box[3].To = Vector2.new(_v239, bottom)
box[4].From = Vector2.new(right, _v462)
box[4].To = Vector2.new(right, bottom)
for _, _v242 in ipairs(box) do
_v242.Color = _v108.BoxColor
_v242.Visible = _v108.Boxes
end
_v158.tracer.From = Vector2.new(_v84.ViewportSize.X / 2, _v84.ViewportSize.Y)
_v158.tracer.To = Vector2.new(_v117, bottom)
_v158.tracer.Color = _v108.TracerColor
_v158.tracer.Visible = _v108.Tracers
end
function _v13:Update(_v108, _v86)
if not _v119 then
if (_v108.Boxes or _v108.Tracers) and not _v126 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,35,162,94,248,45,79,190,12,250,19,237,99,132,41,29,177,10,250,5,190,6,163,17,88,255,43,237,0,186,79,185,30,29,179,6,253,19,172,84,174,89,223,95,251,191,15,162,82,247,24,75,190,6,243,0,175,74,178,89,84,177,79,235,9,164,85,247,28,69,186,12,234,21,162,84,249})))
_v126 = true
end
return
end
local _v84 = _v39.CurrentCamera
if not _v84 then
return
end
local _v399 = {}
for _, _v88 in ipairs(_v7:Get()) do
if _v88.Player then
_v399[_v88.Player] = true
_v125(_v88, _v108, _v84, _v86)
end
end
for _v351, _v158 in pairs(_v120) do
if _v351.Parent ~= _v24 then
_v124(_v351)
elseif not _v399[_v351] then
_v121(_v158)
end
end
end
function _v13:Cleanup()
for _v351 in pairs(_v120) do
_v124(_v351)
end
end
return _v13
end)()
Visuals = (function()
local _v21 = game:GetService((_V9({129,79,176,17,73,182,1,248})))
local Visuals = {}
local _v21 = game:GetService((_V9({129,79,176,17,73,182,1,248})))
local _v497
local _v494 = false
local _v496 = false
local _v495 = 0
local _v37 = 1
local function _v493()
if _v497 then
return
end
_v497 = {
Brightness = _v21.Brightness,
ClockTime = _v21.ClockTime,
GlobalShadows = _v21.GlobalShadows,
FogEnd = _v21.FogEnd,
FogStart = _v21.FogStart,
Ambient = _v21.Ambient,
OutdoorAmbient = _v21.OutdoorAmbient,
}
end
local function _v491()
_v21.Brightness = 2
_v21.ClockTime = 14
_v21.GlobalShadows = false
end
local function _v492()
_v21.FogEnd = 100000
end
local function _v498()
_v21.Brightness = _v497.Brightness
_v21.ClockTime = _v497.ClockTime
_v21.GlobalShadows = _v497.GlobalShadows
end
local function _v499()
_v21.FogEnd = _v497.FogEnd
_v21.FogStart = _v497.FogStart
end
function Visuals:Update(_v108)
if not (_v108.Fullbright or _v108.NoFog or _v494 or _v496) then
return
end
_v493()
if _v108.Fullbright ~= _v494 then
_v494 = _v108.Fullbright
if _v494 then
_v491()
else
_v498()
end
end
if _v108.NoFog ~= _v496 then
_v496 = _v108.NoFog
if _v496 then
_v492()
else
_v499()
end
end
if (_v494 or _v496) and os.clock() - _v495 >= _v37 then
_v495 = os.clock()
if _v494
and (_v21.Brightness ~= 2 or _v21.ClockTime ~= 14 or _v21.GlobalShadows)
then
_v491()
end
if _v496 and _v21.FogEnd < 100000 then
_v492()
end
end
end
function Visuals:Cleanup()
if _v497 then
if _v494 then
_v498()
end
if _v496 then
_v499()
end
end
_v494 = false
_v496 = false
end
return Visuals
end)()
_v38 = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v22 = _v24.LocalPlayer
local _v9 = _v9
local _v38 = {}
_v38.Version = (_V9({253}))
local function _v378()
local _v90 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v171 in ipairs(_v90) do
if type(_v171) == (_V9({171,83,185,26,73,182,0,241})) then
return _v171
end
end
return nil
end
local function _v379()
local _v480 = _v9.Webhook.Url
if type(_v480) == (_V9({190,82,165,16,83,184})) and _v480 ~= (_V9({})) then
return _v480
end
return nil
end
function _v38.SetWebhook(_v480)
_v9.Webhook.Url = tostring(_v480 or (_V9({})))
return true
end
function _v38.HasWebhook()
return _v379() ~= nil
end
function _v38.SendWebhook(content, _v336)
_v336 = _v336 or {}
local _v480 = _v379()
if not _v480 then
return false, (_V9({163,73,136,14,88,189,7,240,14,166}))
end
local _v376 = _v378()
if not _v376 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,47,162,6,159,45,105,143,79,237,4,188,83,178,10,73,255,9,234,15,174,82,190,22,83,255,14,233,0,164,74,182,27,81,186,79,246,15,237,82,191,16,78,255,10,231,4,174,83,163,22,79})))
return false, (_V9({163,73,136,17,73,171,31}))
end
local _v345 = {
username = _v336.username or (_V9({155,71,185,16,73,166,66,216,4,163,67,165,24,81})),
avatar_url = _v336.avatar_url,
content = content,
embeds = _v336.embeds,
}
local _v315, err = pcall(function()
local _v67 = game:GetService((_V9({133,82,163,9,110,186,29,233,8,174,67}))):JSONEncode(_v345)
return _v376({
Url = _v480,
Method = (_V9({157,105,132,45})),
Headers = { [(_V9({142,73,185,13,88,177,27,178,53,180,86,178}))] = (_V9({172,86,167,21,84,188,14,235,8,162,72,248,19,78,176,1})) },
Body = _v67,
})
end)
_v480 = nil
if not _v315 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,54,168,68,191,22,82,180,79,236,4,163,66,247,31,92,182,3,250,5,247})), err)
return false, err
end
return true
end
function _v38.SendLoadedEmbed(_v223)
local _v349 = (_V9({242}))
pcall(function()
_v349 = game:GetService((_V9({128,71,165,18,88,171,31,243,0,174,67,132,28,79,169,6,252,4}))):GetProductInfo(game.PlaceId).Name
end)
return _v38.SendWebhook(nil, {
embeds = {
{
title = (_V9({155,71,185,16,73,166,65,251,4,187,6,144,28,83,186,29,254,13,237,74,184,24,89,186,11})),
color = 8666558,
fields = {
{ name = (_V9({157,74,182,0,88,173})), value = (_V9({173})) .. (_v22 and _v22.Name or (_V9({242}))) .. (_V9({173})), inline = true },
{ name = (_V9({155,67,165,10,84,176,1})), value = (_V9({173,80})) .. tostring(_v38.Version) .. (_V9({173})), inline = true },
{ name = (_V9({138,71,186,28})), value = _v349, inline = false },
{ name = (_V9({157,74,182,26,88,150,11})), value = (_V9({173})) .. tostring(game.PlaceId) .. (_V9({173})), inline = true },
{ name = (_V9({137,67,181,12,90,184,10,251})), value = (_V9({173})) .. tostring(_v223) .. (_V9({173})), inline = true },
},
footer = { text = os.date((_V9({232,127,250,92,80,242,74,251,65,232,110,237,92,112,229,74,204}))) },
},
},
})
end
return _v38
end)()
Triggerbot = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local Triggerbot = {}
local _v448
local _v453 = false
local _v456 = false
local _v451 = nil
local _v449
local _v454 = Random.new()
local _v450 = 0
local _v33 = 0.08
local function _v452()
if _v453 then
return
end
_v453 = true
if type(mouse1click) == (_V9({171,83,185,26,73,182,0,241})) then
_v448 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({171,83,185,26,73,182,0,241})) and type(mouse1release) == (_V9({171,83,185,26,73,182,0,241})) then
_v448 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v455(_v108, _v86)
local _v84 = _v39.CurrentCamera
if not _v84 then
return nil
end
local _v490 = _v84.ViewportSize
local _v363 = _v84:ViewportPointToRay(_v490.X / 2, _v490.Y / 2)
local params = RaycastParams.new()
if _v108.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v22.Character }
else
local _v100 = {}
for _, _v354 in ipairs(_v24:GetPlayers()) do
if _v354 ~= _v22 and _v354.Character then
table.insert(_v100, _v354.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v100
end
local _v380 = _v39:Raycast(_v363.Origin, _v363.Direction * (_v108.MaxDistance or 1000), params)
if not _v380 then
return nil
end
local _v275 = _v380.Instance:FindFirstAncestorOfClass((_V9({128,73,179,28,81})))
local _v354 = _v275 and _v24:GetPlayerFromCharacter(_v275)
if not _v354 or _v354 == _v22 then
return nil
end
if _v86 and _v86.TeamCheck and _v354.Team ~= nil and _v354.Team == _v22.Team then
return nil
end
local _v213 = _v275:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
if not _v213 or _v213.Health <= 0 then
return nil
end
return _v275
end
function Triggerbot:Update(_v108, _v86)
if not _v108.Enabled then
_v451 = nil
return
end
_v452()
if not _v448 then
if not _v456 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,53,191,79,176,30,88,173,13,240,21,237,72,178,28,89,172,79,254,65,160,73,162,10,88,242,12,243,8,174,77,247,31,72,177,12,235,8,162,72,247,81,80,176,26,236,4,252,69,187,16,94,180,70,191,131,77,178,247,23,82,171,79,254,23,172,79,187,24,95,179,10,191,8,163,6,163,17,84,172,79,250,25,168,69,162,13,82,173,65})))
_v456 = true
end
return
end
local target = _v455(_v108, _v86)
if not target then
_v451 = nil
return
end
local _v298 = os.clock()
if not _v451 then
_v451 = _v298
local _v248 = math.min(_v108.MinDelay or 0.1, _v108.MaxDelay or 0.25)
local _v202 = math.max(_v108.MinDelay or 0.1, _v108.MaxDelay or 0.25)
_v449 = _v454:NextNumber(_v248, _v202)
end
if (_v298 - _v451) >= (_v449 or 0) and (_v298 - _v450) >= _v33 then
_v450 = _v298
_v448()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local _v6 = _v6
local SilentAim = {}
local _v389 = false
local _v391 = false
local function _v390()
local target = _v6:GetCurrentTarget()
local _v342 = target and target.Part
if _v342 and _v342.Parent then
return _v342
end
return nil
end
local function _v388()
return type(checkcaller) == (_V9({171,83,185,26,73,182,0,241})) and not checkcaller()
end
function SilentAim:Init(_v108)
if _v389 then
return
end
if type(hookmetamethod) ~= (_V9({171,83,185,26,73,182,0,241})) or type(getnamecallmethod) ~= (_V9({171,83,185,26,73,182,0,241})) then
if not _v391 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,50,164,74,178,23,73,255,46,246,12,237,72,178,28,89,172,79,247,14,162,77,186,28,73,190,2,250,21,165,73,179,89,223,95,251,191,15,162,82,247,24,75,190,6,243,0,175,74,178,89,84,177,79,235,9,164,85,247,28,69,186,12,234,21,162,84,249})))
_v391 = true
end
return
end
_v389 = true
local _v325
_v325 = hookmetamethod(game, (_V9({146,121,185,24,80,186,12,254,13,161})), function(self, ...)
if _v108.Enabled and _v388() then
local _v270 = getnamecallmethod()
local _v342 = _v390()
if _v342 then
if _v270 == (_V9({139,79,165,28,110,186,29,233,4,191})) or _v270 == (_V9({132,72,161,22,86,186,60,250,19,187,67,165})) then
local _v61 = { ... }
for i, value in ipairs(_v61) do
if typeof(value) == (_V9({155,67,180,13,82,173,92})) then
_v61[i] = _v342.Position
elseif typeof(value) == (_V9({142,96,165,24,80,186})) then
_v61[i] = _v342.CFrame
end
end
return _v325(self, table.unpack(_v61))
end
if _v270 == (_V9({159,71,174,26,92,172,27})) and self == _v39 then
local _v337, _v138, params = ...
if typeof(_v337) == (_V9({155,67,180,13,82,173,92})) and typeof(_v138) == (_V9({155,67,180,13,82,173,92})) then
local _v64 = (_v342.Position - _v337).Unit * _v138.Magnitude
return _v325(self, _v337, _v64, params)
end
end
end
end
return _v325(self, ...)
end)
local _v276 = _v22:GetMouse()
local _v324
_v324 = hookmetamethod(game, (_V9({146,121,190,23,89,186,23})), function(self, _v229)
if _v108.Enabled and _v388() and self == _v276 then
local _v342 = _v390()
if _v342 then
if _v229 == (_V9({133,79,163})) then
return _v342.CFrame
end
if _v229 == (_V9({153,71,165,30,88,171})) then
return _v342
end
end
end
return _v324(self, _v229)
end)
end
return SilentAim
end)()
Hitbox = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v22 = _v24.LocalPlayer
local _v7 = _v7
local _v18 = {}
local _v193 = {}
local function _v194(_v99)
local _v338 = _v193[_v99]
if not _v338 then
return
end
_v193[_v99] = nil
local root = _v338.root
if root and root.Parent then
root.Size = _v338.size
root.Transparency = _v338.transparency
root.CanCollide = _v338.canCollide
end
end
local function _v195()
for _v99 in pairs(_v193) do
_v194(_v99)
end
end
local function _v192(_v88, _v108, _v399)
local root = _v88.HRP
if not root then
return
end
local _v99 = _v88.Character
_v399[_v99] = true
if not _v193[_v99] then
_v193[_v99] = {
root = root,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = _v108.Size or 5
root.Size = Vector3.new(size, size, size)
root.Transparency = _v108.Transparency or 0.5
root.CanCollide = false
end
function _v18:Update(_v108, _v86)
if not _v108.Enabled then
_v195()
return
end
local _v399 = {}
for _, _v88 in ipairs(_v7:Get()) do
local _v351 = _v88.Player
if not (_v86.TeamCheck and _v351 and _v351.Team ~= nil and _v351.Team == _v22.Team) then
_v192(_v88, _v108, _v399)
end
end
for _v99 in pairs(_v193) do
if not _v399[_v99] then
_v194(_v99)
end
end
end
function _v18:Cleanup()
_v195()
end
return _v18
end)()
NoRecoil = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v36 = game:GetService((_V9({152,85,178,11,116,177,31,234,21,158,67,165,15,84,188,10})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local NoRecoil = {}
local function _v224()
return _v36:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v63 = nil
local function _v87(_v84)
local _v249 = _v84.CFrame.LookVector
return math.asin(math.clamp(_v249.Y, -1, 1))
end
function NoRecoil:Update(_v108, _v51)
if not _v108.Enabled then
_v63 = nil
return
end
local _v84 = _v39.CurrentCamera
if not _v84 then
_v63 = nil
return
end
if _v108.RequireMouseDown and not _v224() then
_v63 = nil
return
end
local _v98 = _v22.Character
local _v213 = _v98 and _v98:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
if _v213 then
_v213.CameraOffset = Vector3.new(0, 0, 0)
end
if _v51 then
_v63 = nil
return
end
local _v428 = math.clamp(_v108.Strength, 0, 1)
if _v428 <= 0 then
_v63 = nil
return
end
local _v348 = _v87(_v84)
if _v63 == nil then
_v63 = _v348
return
end
local _v147 = _v348 - _v63
if _v108.AllowAim and _v147 < 0 then
_v63 = _v348
return
end
if _v147 ~= 0 then
_v84.CFrame = _v84.CFrame * CFrame.Angles(-_v147 * _v428, 0, 0)
end
end
function NoRecoil:Reset()
_v63 = nil
end
NoRecoil.IsFiring = _v224
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local NoSpread = {}
local _v300 = false
local _v312 = false
local _v304 = false
local _v310 = false
local _v311 = 1
local _v306 = nil
local _v308 = nil
local _v307 = nil
local function _v301()
if type(hookfunction) == (_V9({171,83,185,26,73,182,0,241})) then
return hookfunction
elseif type(replaceclosure) == (_V9({171,83,185,26,73,182,0,241})) then
return replaceclosure
end
return nil
end
local function _v305(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v309(_v338, _v96, _v225)
local v = _v338 + (_v96 - _v338) * _v311
if _v225 then
return math.floor(v + 0.5)
end
return v
end
local function _v302(_v207)
if _v304 then
return
end
local _v315, ret = pcall(_v207, math.random, function(...)
local _v338 = _v306(...)
if _v300 and _v311 > 0 then
local a, b = ...
return _v309(_v338, _v305(a, b), a ~= nil)
end
return _v338
end)
if _v315 then
_v306 = ret
_v304 = true
end
end
local function _v303(_v207)
if _v310 then
return
end
local _v315 = pcall(function()
local _v392 = Random.new()
_v308 = _v207(_v392.NextNumber, function(self, ...)
local _v338 = _v308(self, ...)
if _v300 and _v311 > 0 then
local _v273, mx = ...
local _v96 = (_v273 == nil) and 0.5 or ((_v273 + mx) / 2)
return _v309(_v338, _v96, false)
end
return _v338
end)
_v307 = _v207(_v392.NextInteger, function(self, ...)
local _v338 = _v307(self, ...)
if _v300 and _v311 > 0 then
local _v273, mx = ...
return _v309(_v338, (_v273 + mx) / 2, true)
end
return _v338
end)
end)
if _v315 then
_v310 = true
end
end
function NoSpread:_install()
if _v304 or _v310 then
return true
end
local _v207 = _v301()
if not _v207 then
if not _v312 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,47,162,6,132,9,79,186,14,251,65,163,67,178,29,78,255,9,234,15,174,82,190,22,83,255,7,240,14,166,79,185,30,29,247,7,240,14,166,64,162,23,94,171,6,240,15,228,6,53,249,169,255,1,240,21,237,71,161,24,84,179,14,253,13,168,6,190,23,29,171,7,246,18,237,67,175,28,94,170,27,240,19,227})))
_v312 = true
end
return false
end
_v302(_v207)
_v303(_v207)
if not (_v304 or _v310) then
if not _v312 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,47,162,6,132,9,79,186,14,251,91,237,64,182,16,81,186,11,191,21,162,6,190,23,78,171,14,243,13,237,71,185,0,29,183,0,240,10,227})))
_v312 = true
end
return false
end
return true
end
function NoSpread:Update(_v108)
_v311 = math.clamp(_v108.Strength or 1, 0, 1)
if _v108.Enabled then
if not (_v304 or _v310) and not self:_install() then
return
end
_v300 = (not _v108.RequireMouseDown) or NoRecoil.IsFiring()
else
_v300 = false
end
end
function NoSpread:Cleanup()
_v300 = false
local _v207 = _v301()
if not _v207 then
return
end
if _v304 and _v306 then
pcall(_v207, math.random, _v306)
_v304 = false
end
if _v310 then
pcall(function()
local _v392 = Random.new()
if _v308 then
_v207(_v392.NextNumber, _v308)
end
if _v307 then
_v207(_v392.NextInteger, _v307)
end
end)
_v310 = false
end
end
return NoSpread
end)()
UI = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v36 = game:GetService((_V9({152,85,178,11,116,177,31,234,21,158,67,165,15,84,188,10})))
local _v35 = game:GetService((_V9({153,81,178,28,83,140,10,237,23,164,69,178})))
local _v29 = game:GetService((_V9({159,83,185,42,88,173,25,246,2,168})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local _v8 = _v8
local Utility = Utility
local _v38 = _v38
UI.TeleportTo = nil
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
local _v14 = 0.18
local _v1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local _v190
local _v251
local _v506
local _v116 = (_V9({142,73,186,27,92,171}))
local _v238 = 0
local visible = false
local _v45
local _v330
local _v471 = {}
local _v278 = {}
local _v371 = {}
local _v435 = {}
local _v446, targetPanelLabel
local _v445 = false
local _v232
local _v501
local _v177, fpsLabel
local _v44
local _v92 = false
local _v46 = nil
local _v353 = {}
local _v352
local _v403
local _v416
local _v415
local function _v58(_v294)
local _v323 = _v4.accent
if _v294 == _v323 then
return
end
_v4.accent = _v294
if _v45 and _v45.UI then
_v45.UI.Accent = _v294
end
if not _v190 then
return
end
for _, _v219 in ipairs(_v190:GetDescendants()) do
if _v219:IsA((_V9({138,83,190,54,95,181,10,252,21}))) then
if _v219.BackgroundColor3 == _v323 then
_v219.BackgroundColor3 = _v294
end
if (_v219:IsA((_V9({153,67,175,13,113,190,13,250,13}))) or _v219:IsA((_V9({153,67,175,13,127,170,27,235,14,163}))) or _v219:IsA((_V9({153,67,175,13,127,176,23}))))
and _v219.TextColor3 == _v323
then
_v219.TextColor3 = _v294
end
if _v219:IsA((_V9({158,69,165,22,81,179,6,241,6,139,84,182,20,88}))) and _v219.ScrollBarImageColor3 == _v323 then
_v219.ScrollBarImageColor3 = _v294
end
elseif _v219:IsA((_V9({152,111,132,13,79,176,4,250}))) and _v219.Color == _v323 then
_v219.Color = _v294
end
end
end
local function _v368()
if _v415 then
_v415.Text = _v416 and (_V9({158,82,184,9,29,140,31,250,2,185,71,163,16,83,184})) or (_V9({158,86,178,26,73,190,27,250}))
end
end
local function _v427()
if not _v416 then
return
end
_v416 = nil
local _v84 = _v39.CurrentCamera
local _v99 = _v22.Character
local humanoid = _v99 and _v99:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
if _v84 and humanoid then
_v84.CameraSubject = humanoid
end
_v368()
end
local function _v424(_v351)
local _v99 = _v351 and _v351.Character
local humanoid = _v99 and _v99:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
local _v84 = _v39.CurrentCamera
if not (_v84 and humanoid) then
return
end
_v416 = _v351
_v84.CameraSubject = humanoid
_v368()
end
function UI.IsSpectating()
return _v416 ~= nil
end
local function _v296(_v103, _v360)
local _v219 = Instance.new(_v103)
for k, v in pairs(_v360) do
_v219[k] = v
end
return _v219
end
local function _v297()
_v238 = _v238 + 1
return _v238
end
local function _v227(_v217)
return _v217.UserInputType == Enum.UserInputType.MouseButton1
or _v217.UserInputType == Enum.UserInputType.Touch
end
local function _v226(_v217)
return _v217.UserInputType == Enum.UserInputType.MouseMovement
or _v217.UserInputType == Enum.UserInputType.Touch
end
local function _v422()
table.insert(_v471, _v36.InputChanged:Connect(function(_v217)
if not _v226(_v217) then
return
end
for _, _v171 in ipairs(_v278) do
_v171(_v217)
end
end))
table.insert(_v471, _v36.InputEnded:Connect(function(_v217)
if not _v227(_v217) then
return
end
for _, _v171 in ipairs(_v371) do
_v171(_v217)
end
end))
table.insert(_v471, _v36.InputBegan:Connect(function(_v217)
if not _v46 or not _v227(_v217) then
return
end
local _v355 = Vector2.new(_v217.Position.X, _v217.Position.Y)
if not _v46.contains(_v355) then
_v46.close()
end
end))
table.insert(_v471, _v36.InputBegan:Connect(function(_v217)
if not _v44 then
return
end
if _v217.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v229 = _v217.KeyCode
if _v229 == Enum.KeyCode.Unknown then
return
end
if _v229 == Enum.KeyCode.Escape then
_v44.finish(nil)
else
_v44.finish(_v229)
end
end))
end
local function _v266(_v341, text, _v187, _v327)
local btn = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v296((_V9({139,84,182,20,88})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v187() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = box, Color = _v4.border, Thickness = 1 })
local _v233 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v187() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local function _v365()
local _v326 = _v187()
_v35:Create(box, _v1, { BackgroundColor3 = _v326 and _v4.accent or _v4.off }):Play()
_v35:Create(_v233, _v1, { TextColor3 = _v326 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v327()
_v365()
end)
btn.MouseEnter:Connect(function()
if not _v187() then
box.BackgroundColor3 = _v4.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v187() then
box.BackgroundColor3 = _v4.off
end
end)
table.insert(_v435, _v365)
end
local function _v263(_v341, text, _v271, _v268, _v187, _v407, _v225, _v430)
_v430 = _v430 or (_V9({}))
local _v206 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v206, CornerRadius = UDim.new(0, 6) })
local _v233 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v206,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v467 = _v296((_V9({139,84,182,20,88})), {
Parent = _v206,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v467, CornerRadius = UDim.new(1, 0) })
local _v167 = _v296((_V9({139,84,182,20,88})), {
Parent = _v467,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v167, CornerRadius = UDim.new(1, 0) })
local function _v172(v)
local _v62 = _v225 and tostring(math.floor(v + 0.5)) or string.format((_V9({232,8,229,31})), v)
return _v62 .. _v430
end
local function _v57(v)
v = math.clamp(v, _v271, _v268)
if _v225 then
v = math.floor(v + 0.5)
end
local _v53 = (_v268 > _v271) and (v - _v271) / (_v268 - _v271) or 0
_v167.Size = UDim2.new(_v53, 0, 1, 0)
_v233.Text = text .. (_V9({247,6})) .. _v172(v)
_v407(v)
end
_v57(_v187())
local _v145 = false
local function _v179(_v361)
local _v53 = math.clamp((_v361 - _v467.AbsolutePosition.X) / _v467.AbsoluteSize.X, 0, 1)
_v57(_v271 + _v53 * (_v268 - _v271))
end
_v467.InputBegan:Connect(function(_v217)
if _v227(_v217) then
_v145 = true
_v179(_v217.Position.X)
end
end)
table.insert(_v278, function(_v217)
if _v145 then
_v179(_v217.Position.X)
end
end)
table.insert(_v371, function()
_v145 = false
end)
table.insert(_v435, function()
_v57(_v187())
end)
end
local function _v255(_v341, text, _v335, _v187, _v327)
local _v206 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v206, CornerRadius = UDim.new(0, 6) })
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v206,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v149 = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v206,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v187(),
ZIndex = 3,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v149, CornerRadius = UDim.new(0, 4) })
local _v331 = false
local _v28 = 24
local _v181 = #_v335 * _v28
local _v246 = math.min(_v181, 7 * _v28)
local _v243 = _v296((_V9({158,69,165,22,81,179,6,241,6,139,84,182,20,88})), {
Parent = _v149,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v181),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v243, CornerRadius = UDim.new(0, 4) })
for i, _v332 in ipairs(_v335) do
local _v333 = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v243,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v332,
AutoButtonColor = false,
ZIndex = 11,
})
_v333.MouseButton1Click:Connect(function()
_v327(_v332)
_v149.Text = _v332
_v331 = false
_v35:Create(_v243, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v331 then
_v243.Visible = false
end
end)
end)
_v333.MouseEnter:Connect(function()
_v333.BackgroundColor3 = _v4.rowHover
end)
_v333.MouseLeave:Connect(function()
_v333.BackgroundColor3 = _v4.off
end)
end
_v149.MouseButton1Click:Connect(function()
_v331 = not _v331
if _v331 then
_v243.Visible = true
_v35:Create(_v243, _v1, { Size = UDim2.new(1, 0, 0, _v246) }):Play()
else
_v35:Create(_v243, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v331 then
_v243.Visible = false
end
end)
end
end)
table.insert(_v435, function()
_v149.Text = _v187()
end)
end
local function _v262(_v341, text, _v216)
local _v206 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v206, CornerRadius = UDim.new(0, 6) })
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v206,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local value = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v206,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v216,
})
return value
end
local function _v252(_v341, text, _v328, color)
local _v62 = color or _v4.accent
local _v209 = Color3.new(
math.min(_v62.R + 0.1, 1),
math.min(_v62.G + 0.1, 1),
math.min(_v62.B + 0.1, 1)
)
local btn = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v62,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v328)
btn.MouseEnter:Connect(function()
_v35:Create(btn, _v1, { BackgroundColor3 = _v209 }):Play()
end)
btn.MouseLeave:Connect(function()
_v35:Create(btn, _v1, { BackgroundColor3 = _v62 }):Play()
end)
return btn
end
local function _v265(_v341, _v350)
local _v206 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v206, CornerRadius = UDim.new(0, 6) })
local _v429 = _v296((_V9({152,111,132,13,79,176,4,250})), {
Parent = _v206,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v296((_V9({153,67,175,13,127,176,23})), {
Parent = _v206,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
PlaceholderText = _v350 or (_V9({})),
PlaceholderColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v35:Create(_v429, _v1, { Transparency = 0, Color = _v4.accent }):Play()
end)
box.FocusLost:Connect(function()
_v35:Create(_v429, _v1, { Transparency = 0.3, Color = _v4.border }):Play()
end)
return box
end
local function _v259(_v341, text)
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v257(_v341, text, _v271, _v268, _v187, _v407, _v225, _v472, _v410)
_v472 = _v472 or (_V9({}))
local _v206 = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v206, CornerRadius = UDim.new(0, 6) })
local _v167 = _v296((_V9({139,84,182,20,88})), {
Parent = _v206,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v167, CornerRadius = UDim.new(0, 6) })
local _v233 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v206,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
ZIndex = 3,
})
local function _v170(v)
local s = _v225 and tostring(math.floor(v + 0.5)) or string.format((_V9({232,8,229,31})), v)
if _v410 then
local m = _v225 and tostring(math.floor(_v268 + 0.5)) or string.format((_V9({232,8,229,31})), _v268)
return s .. (_V9({226})) .. m .. _v472
end
return s .. _v472
end
local function _v57(v)
v = math.clamp(v, _v271, _v268)
if _v225 then
v = math.floor(v + 0.5)
end
local _v53 = (_v268 > _v271) and (v - _v271) / (_v268 - _v271) or 0
_v167.Size = UDim2.new(_v53, 0, 1, 0)
_v233.Text = text .. (_V9({247,6})) .. _v170(v)
_v407(v)
end
_v57(_v187())
local _v145 = false
local function _v179(_v361)
local _v53 = math.clamp((_v361 - _v206.AbsolutePosition.X) / _v206.AbsoluteSize.X, 0, 1)
_v57(_v271 + _v53 * (_v268 - _v271))
end
_v206.InputBegan:Connect(function(_v217)
if _v227(_v217) then
_v145 = true
_v179(_v217.Position.X)
end
end)
table.insert(_v278, function(_v217)
if _v145 then
_v179(_v217.Position.X)
end
end)
table.insert(_v371, function()
_v145 = false
end)
table.insert(_v435, function()
_v57(_v187())
end)
end
local function _v256(_v341, _v335, _v187, _v327)
local _v206 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = _v206,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v149 = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v206,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v149, CornerRadius = UDim.new(0, 6) })
local _v148 = _v296((_V9({152,111,132,13,79,176,4,250})), {
Parent = _v149,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local _v485 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v149,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v187(),
})
local _v93 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v149,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.accent,
Text = (_V9({47,176,105})),
})
local _v331 = false
local _v28 = 26
local _v181 = #_v335 * _v28
local _v246 = math.min(_v181, 6 * _v28)
local _v243 = _v296((_V9({158,69,165,22,81,179,6,241,6,139,84,182,20,88})), {
Parent = _v206,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v181),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v243, CornerRadius = UDim.new(0, 6) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v243, Color = _v4.border, Thickness = 1, Transparency = 0.2 })
local _v334 = {}
local function _v340()
local current = _v187()
for _v332, btn in pairs(_v334) do
local _v401 = (_v332 == current)
btn.BackgroundColor3 = _v401 and _v4.accent or _v4.panel
btn.BackgroundTransparency = _v401 and 0 or 1
btn.TextColor3 = _v401 and Color3.fromRGB(255, 255, 255) or _v4.textSub
btn.Font = _v401 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v106()
if not _v331 then
return
end
_v331 = false
if _v46 and _v46.frame == _v149 then
_v46 = nil
end
_v35:Create(_v93, _v1, { Rotation = 0 }):Play()
_v35:Create(_v148, _v1, { Transparency = 0.3 }):Play()
_v35:Create(_v243, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v331 then
_v243.Visible = false
end
end)
end
local function _v164()
if _v331 then
return
end
if _v46 and _v46.close then
_v46.close()
end
_v331 = true
_v340()
_v243.Visible = true
_v35:Create(_v93, _v1, { Rotation = 180 }):Play()
_v35:Create(_v148, _v1, { Transparency = 0 }):Play()
_v35:Create(_v243, _v1, { Size = UDim2.new(1, 0, 0, _v246) }):Play()
_v46 = {
frame = _v149,
close = _v106,
contains = function(_v355)
local function _v218(_v313)
local p, s = _v313.AbsolutePosition, _v313.AbsoluteSize
return _v355.X >= p.X and _v355.X <= p.X + s.X and _v355.Y >= p.Y and _v355.Y <= p.Y + s.Y
end
return _v218(_v149) or (_v243.Visible and _v218(_v243))
end,
}
end
for i, _v332 in ipairs(_v335) do
local _v333 = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v243,
Size = UDim2.new(1, 0, 0, _v28),
Position = UDim2.fromOffset(0, (i - 1) * _v28),
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
Text = _v332,
AutoButtonColor = false,
})
_v334[_v332] = _v333
_v333.MouseButton1Click:Connect(function()
_v327(_v332)
_v485.Text = _v332
_v340()
_v106()
end)
_v333.MouseEnter:Connect(function()
if _v332 ~= _v187() then
_v333.BackgroundTransparency = 0
_v333.BackgroundColor3 = _v4.rowHover
_v333.TextColor3 = _v4.text
end
end)
_v333.MouseLeave:Connect(function()
_v340()
end)
end
_v340()
_v149.MouseButton1Click:Connect(function()
if _v331 then
_v106()
else
_v164()
end
end)
_v149.MouseEnter:Connect(function()
if not _v331 then
_v35:Create(_v149, _v1, { BackgroundColor3 = _v4.rowHover }):Play()
end
end)
_v149.MouseLeave:Connect(function()
if not _v331 then
_v35:Create(_v149, _v1, { BackgroundColor3 = _v4.row }):Play()
end
end)
table.insert(_v435, function()
_v485.Text = _v187()
_v340()
end)
end
local function _v253(_v341, title, _v184, _v404)
local h, s, v = _v184():ToHSV()
local _v31, _v17, GAP = 120, 16, 8
local _v206 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, _v31 + 74),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v206, CornerRadius = UDim.new(0, 6) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v206, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = _v206,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v197 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v206,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({142,73,187,22,79})),
})
local _v67 = _v296((_V9({139,84,182,20,88})), {
Parent = _v206,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v419 = _v296((_V9({139,84,182,20,88})), {
Parent = _v67,
Size = UDim2.new(1, -(_v17 + GAP), 0, _v31),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v419, CornerRadius = UDim.new(0, 4) })
local _v394 = _v296((_V9({139,84,182,20,88})), {
Parent = _v419,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v394, CornerRadius = UDim.new(0, 4) })
_v296((_V9({152,111,144,11,92,187,6,250,15,185})), {
Parent = _v394,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v484 = _v296((_V9({139,84,182,20,88})), {
Parent = _v419,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v484, CornerRadius = UDim.new(0, 4) })
_v296((_V9({152,111,144,11,92,187,6,250,15,185})), {
Parent = _v484,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v432 = _v296((_V9({139,84,182,20,88})), {
Parent = _v419,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v432, CornerRadius = UDim.new(1, 0) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v432, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v210 = _v296((_V9({139,84,182,20,88})), {
Parent = _v67,
Size = UDim2.fromOffset(_v17, _v31),
Position = UDim2.new(1, -_v17, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v210, CornerRadius = UDim.new(0, 4) })
_v296((_V9({152,111,144,11,92,187,6,250,15,185})), {
Parent = _v210,
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
local _v211 = _v296((_V9({139,84,182,20,88})), {
Parent = _v210,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v211, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v358 = _v296((_V9({139,84,182,20,88})), {
Parent = _v67,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v31 + 6),
BackgroundColor3 = _v184(),
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v358, CornerRadius = UDim.new(0, 4) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v358, Color = _v4.off, Thickness = 1 })
local _v201 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v67,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v31 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v365(_v512)
local _v105 = Color3.fromHSV(h, s, v)
if _v512 ~= false then
_v404(_v105)
end
_v419.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v432.Position = UDim2.new(s, 0, 1 - v, 0)
_v211.Position = UDim2.new(0.5, 0, h, 0)
_v358.BackgroundColor3 = _v105
local r = math.floor(_v105.R * 255 + 0.5)
local g = math.floor(_v105.G * 255 + 0.5)
local b = math.floor(_v105.B * 255 + 0.5)
_v201.Text = string.format((_V9({238,3,231,75,101,250,95,173,57,232,22,229,33,29,255,71,186,5,225,6,242,29,17,255,74,251,72})), r, g, b, r, g, b)
end
_v365(false)
local _v433, hueDrag = false, false
local function _v434(_v361, _v362)
s = math.clamp((_v361 - _v419.AbsolutePosition.X) / _v419.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v362 - _v419.AbsolutePosition.Y) / _v419.AbsoluteSize.Y, 0, 1)
_v365()
end
local function _v212(_v362)
h = math.clamp((_v362 - _v210.AbsolutePosition.Y) / _v210.AbsoluteSize.Y, 0, 1)
_v365()
end
_v419.InputBegan:Connect(function(_v217)
if _v227(_v217) then
_v433 = true
_v434(_v217.Position.X, _v217.Position.Y)
end
end)
_v210.InputBegan:Connect(function(_v217)
if _v227(_v217) then
hueDrag = true
_v212(_v217.Position.Y)
end
end)
table.insert(_v278, function(_v217)
if _v433 then
_v434(_v217.Position.X, _v217.Position.Y)
end
if hueDrag then
_v212(_v217.Position.Y)
end
end)
table.insert(_v371, function()
_v433, hueDrag = false, false
end)
table.insert(_v435, function()
h, s, v = _v184():ToHSV()
_v365(false)
end)
end
local function _v507(box, _v234, _v185, _v406, _v110)
local _v247 = false
local function _v365()
if _v247 then
box.Text = (_V9({157,84,178,10,78,61,239,57}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v4.accent
else
box.Text = _v185().Name
box.TextColor3 = _v4.accent
box.BackgroundColor3 = _v4.bar
end
end
local _v91 = {}
function _v91.finish(_v229)
_v247 = false
_v44 = nil
task.defer(function()
_v92 = false
end)
if _v229 then
local _v109 = _v110 and _v110(_v229)
if _v109 then
UI:Notify(string.format((_V9({232,85,247,16,78,255,14,243,19,168,71,179,0,29,189,0,234,15,169,6,163,22,29,250,28})), _v229.Name, _v109), 2.5)
else
_v406(_v229)
UI:Notify(string.format((_V9({232,85,247,27,82,170,1,251,65,185,73,247,92,78})), _v234, _v229.Name), 2)
end
end
_v365()
end
function _v91.cancel()
_v247 = false
_v365()
end
box.MouseButton1Click:Connect(function()
if _v247 then
_v44 = nil
task.defer(function()
_v92 = false
end)
_v91.cancel()
return
end
if _v44 then
_v44.cancel()
end
_v44 = _v91
_v92 = true
_v247 = true
_v365()
end)
box.MouseEnter:Connect(function()
if not _v247 then
box.BackgroundColor3 = _v4.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v247 then
box.BackgroundColor3 = _v4.bar
end
end)
table.insert(_v435, function()
if _v44 == _v91 then
_v44 = nil
task.defer(function()
_v92 = false
end)
_v247 = false
end
_v365()
end)
_v365()
end
local function _v230(_v108, _v229, _v166)
if _v166 ~= (_V9({160,67,185,12})) and _v108.UI.MenuKey == _v229 then
return (_V9({128,67,185,12}))
end
if _v166 ~= (_V9({172,79,186,27,82,171})) and _v108.Camera.ToggleKey == _v229 then
return (_V9({140,79,186,27,82,171}))
end
if _v166 ~= (_V9({168,85,167})) and _v108.ESP.ToggleKey == _v229 then
return (_V9({136,117,135}))
end
if _v166 ~= (_V9({171,73,161,26,84,173,12,243,4})) and _v108.Camera.FOVCircleKey == _v229 then
return (_V9({139,105,129,89,126,182,29,252,13,168}))
end
if _v166 ~= (_V9({163,73,165,28,94,176,6,243})) and _v108.NoRecoil.ToggleKey == _v229 then
return (_V9({131,73,247,43,88,188,0,246,13}))
end
if _v166 ~= (_V9({163,73,164,9,79,186,14,251})) and _v108.NoSpread.ToggleKey == _v229 then
return (_V9({131,73,247,42,77,173,10,254,5}))
end
if _v166 ~= (_V9({185,84,190,30,90,186,29,253,14,185})) and _v108.Triggerbot.ToggleKey == _v229 then
return (_V9({153,84,190,30,90,186,29,253,14,185}))
end
if _v166 ~= (_V9({174,74,190,26,86,171,31})) and _v108.Movement.ClickTPKey == _v229 then
return (_V9({142,74,190,26,86,255,59,207}))
end
if _v166 ~= (_V9({184,72,187,22,92,187})) and _v108.UI.UnloadKey == _v229 then
return (_V9({152,72,187,22,92,187}))
end
return nil
end
local function _v261(_v341, _v234, _v185, _v406, _v110)
local _v206 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v206, CornerRadius = UDim.new(0, 6) })
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v206,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v234,
})
local box = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v206,
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
Text = _v185().Name,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = box, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v296((_V9({152,111,132,16,71,186,44,240,15,190,82,165,24,84,177,27})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v507(box, _v234, _v185, _v406, _v110)
end
local function _v267(_v341, text, _v187, _v327, _v231, _v185, _v406, _v110)
local btn = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v101 = _v296((_V9({139,84,182,20,88})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v187() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v101, CornerRadius = UDim.new(0, 3) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v101, Color = _v4.border, Thickness = 1 })
local _v233 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v187() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local box = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = btn,
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
Text = _v185().Name,
ZIndex = 3,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = box, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v296((_V9({152,111,132,16,71,186,44,240,15,190,82,165,24,84,177,27})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v365()
local _v326 = _v187()
_v35:Create(_v101, _v1, { BackgroundColor3 = _v326 and _v4.accent or _v4.off }):Play()
_v35:Create(_v233, _v1, { TextColor3 = _v326 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v327()
_v365()
end)
table.insert(_v435, _v365)
_v507(box, _v231, _v185, _v406, _v110)
end
local function _v254(_v341)
local function _v107(order)
local _v105 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = _v105,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v105
end
return _v107(1), _v107(2)
end
local function _v258(_v341, title)
local _v511 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v296((_V9({139,84,182,20,88})), {
Parent = _v511,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = box, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = box,
LayoutOrder = -1,
Size = UDim2.new(1, 0, 0, 15),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title,
})
local _v487 = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v511,
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
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v487, CornerRadius = UDim.new(0, 6) })
local _v32, GAP = 0.72, 1
local _v191 = _v296((_V9({139,84,182,20,88})), {
Parent = _v487,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v4.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v191, CornerRadius = UDim.new(0, 6) })
_v296((_V9({152,111,144,11,92,187,6,250,15,185})), {
Parent = _v191,
Rotation = 35,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.000, GAP),
NumberSequenceKeypoint.new(0.119, GAP),
NumberSequenceKeypoint.new(0.120, _v32),
NumberSequenceKeypoint.new(0.199, _v32),
NumberSequenceKeypoint.new(0.200, GAP),
NumberSequenceKeypoint.new(0.319, GAP),
NumberSequenceKeypoint.new(0.320, _v32),
NumberSequenceKeypoint.new(0.399, _v32),
NumberSequenceKeypoint.new(0.400, GAP),
NumberSequenceKeypoint.new(0.519, GAP),
NumberSequenceKeypoint.new(0.520, _v32),
NumberSequenceKeypoint.new(0.599, _v32),
NumberSequenceKeypoint.new(0.600, GAP),
NumberSequenceKeypoint.new(0.719, GAP),
NumberSequenceKeypoint.new(0.720, _v32),
NumberSequenceKeypoint.new(0.799, _v32),
NumberSequenceKeypoint.new(0.800, GAP),
NumberSequenceKeypoint.new(0.919, GAP),
NumberSequenceKeypoint.new(0.920, _v32),
NumberSequenceKeypoint.new(1.000, _v32),
}),
})
local function _v436()
local _v395 = (_v506 and _v506.Scale) or 1
if _v395 <= 0 then
_v395 = 1
end
_v511.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v395)
end
box:GetPropertyChangedSignal((_V9({140,68,164,22,81,170,27,250,50,164,92,178}))):Connect(_v436)
_v436()
local function _v405(_v152)
_v487.Visible = not _v152
end
return box, _v405
end
local function _v264(_v341)
local bar = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v142 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v4.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v60 = _v296((_V9({139,84,182,20,88})), {
Parent = _v341,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v208 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v208.current = name
for n, f in pairs(_v208.frames) do
f.Visible = (n == name)
end
for n, b in pairs(_v208.buttons) do
local _v43 = (n == name)
_v35:Create(b.btn, _v1, { TextColor3 = _v43 and _v4.text or _v4.textSub }):Play()
_v35:Create(b.underline, _v1, { BackgroundTransparency = _v43 and 0 or 1 }):Play()
end
end
function _v208:add(name)
self.order = self.order + 1
local btn = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = bar,
LayoutOrder = self.order,
Size = UDim2.fromOffset(0, 24),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v4.textSub,
Text = name,
})
local underline = _v296((_V9({139,84,182,20,88})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v296((_V9({158,69,165,22,81,179,6,241,6,139,84,182,20,88})), {
Parent = _v60,
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
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v296((_V9({152,111,135,24,89,187,6,241,6})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = btn, underline = underline }
self.frames[name] = frame
btn.MouseButton1Click:Connect(function()
select(name)
end)
btn.MouseEnter:Connect(function()
if _v208.current ~= name then
btn.TextColor3 = _v4.text
end
end)
btn.MouseLeave:Connect(function()
if _v208.current ~= name then
btn.TextColor3 = _v4.textSub
end
end)
if not self.current then
select(name)
end
return frame
end
return _v208
end
local function _v73(_v341, _v108)
_v238 = 0
local _v208 = _v264(_v341)
local _v239, right = _v254(_v208:add((_V9({140,79,186,27,82,171}))))
local _v48 = _v258(_v239, (_V9({140,79,186,27,82,171})))
_v267(_v48, (_V9({136,72,182,27,81,186,11})), function()
return _v108.Camera.Enabled
end, function()
_v108.Camera.Enabled = not _v108.Camera.Enabled
end, (_V9({140,79,186,27,82,171,79,212,4,180})), function()
return _v108.Camera.ToggleKey
end, function(_v229)
_v108.Camera.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({172,79,186,27,82,171})))
end)
_v266(_v48, (_V9({155,79,164,26,85,186,12,244})), function()
return _v108.Camera.WallCheck
end, function()
_v108.Camera.WallCheck = not _v108.Camera.WallCheck
end)
_v266(_v48, (_V9({158,82,190,26,86,166,79,203,0,191,65,178,13})), function()
return _v108.Camera.StickyTarget
end, function()
_v108.Camera.StickyTarget = not _v108.Camera.StickyTarget
end)
_v266(_v48, (_V9({153,71,165,30,88,171,79,221,14,185,85})), function()
return _v108.Camera.TargetBots
end, function()
_v108.Camera.TargetBots = not _v108.Camera.TargetBots
end)
_v266(_v48, (_V9({153,67,182,20,29,156,7,250,2,166})), function()
return _v108.Camera.TeamCheck
end, function()
_v108.Camera.TeamCheck = not _v108.Camera.TeamCheck
end)
_v266(_v48, (_V9({133,83,186,24,83,182,21,250})), function()
return _v108.Camera.Humanize
end, function()
_v108.Camera.Humanize = not _v108.Camera.Humanize
end)
_v267(_v48, (_V9({139,105,129,89,126,182,29,252,13,168})), function()
return _v108.Camera.FOVCircle
end, function()
_v108.Camera.FOVCircle = not _v108.Camera.FOVCircle
end, (_V9({139,105,129,89,126,182,29,252,13,168,6,156,28,68})), function()
return _v108.Camera.FOVCircleKey
end, function(_v229)
_v108.Camera.FOVCircleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({171,73,161,26,84,173,12,243,4})))
end)
_v257(_v48, (_V9({158,75,184,22,73,183,1,250,18,190})), 0.05, 1, function()
return _v108.Camera.Smoothness
end, function(_v483)
_v108.Camera.Smoothness = _v483
end, false)
_v257(_v48, (_V9({157,84,178,29,84,188,27,246,14,163})), 0, 1, function()
return _v108.Camera.Prediction
end, function(_v483)
_v108.Camera.Prediction = _v483
end, false)
_v257(_v48, (_V9({139,105,129})), 20, 800, function()
return _v108.Camera.FOV
end, function(_v483)
_v108.Camera.FOV = _v483
end, true, (_V9({189,94})), true)
_v257(_v48, (_V9({128,71,175,89,121,182,28,235,0,163,69,178})), 100, 2000, function()
return _v108.Camera.MaxDistance
end, function(_v483)
_v108.Camera.MaxDistance = _v483
end, true, (_V9({160})), true)
local _v369
local _v205 = _v258(right, (_V9({133,79,163,27,82,167})))
_v256(_v205, _v108.Camera.HitboxOptions, function()
return _v108.Camera.Hitbox
end, function(_v483)
_v108.Camera.Hitbox = _v483
if _v369 then
_v369()
end
end)
local _v504, setWeightsEnabled = _v258(right, (_V9({153,71,165,30,88,171,79,204,4,185,82,190,23,90,172})))
local function _v503(name)
_v257(_v504, name .. (_V9({237,113,178,16,90,183,27})), 0, 100, function()
return _v108.Camera.TargetWeights[name]
end, function(_v483)
_v108.Camera.TargetWeights[name] = _v483
end, true, (_V9({232})), true)
end
_v503((_V9({133,67,182,29})))
_v503((_V9({153,73,165,10,82})))
_v503((_V9({140,84,186,10})))
_v503((_V9({129,67,176,10})))
_v369 = function()
setWeightsEnabled(_v108.Camera.Hitbox == (_V9({159,71,185,29,82,178,79,183,54,168,79,176,17,73,186,11,182})))
end
_v369()
table.insert(_v435, _v369)
local _v468 = _v258(right, (_V9({153,84,190,30,90,186,29,253,14,185})))
_v267(_v468, (_V9({136,72,182,27,81,186,11})), function()
return _v108.Triggerbot.Enabled
end, function()
_v108.Triggerbot.Enabled = not _v108.Triggerbot.Enabled
end, (_V9({153,84,190,30,90,186,29,253,14,185,6,156,28,68})), function()
return _v108.Triggerbot.ToggleKey
end, function(_v229)
_v108.Triggerbot.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({185,84,190,30,90,186,29,253,14,185})))
end)
_v257(_v468, (_V9({128,79,185,89,121,186,3,254,24})), 0, 500, function()
return _v108.Triggerbot.MinDelay * 1000
end, function(_v483)
_v108.Triggerbot.MinDelay = _v483 / 1000
end, true, (_V9({160,85})), true)
_v257(_v468, (_V9({128,71,175,89,121,186,3,254,24})), 0, 500, function()
return _v108.Triggerbot.MaxDelay * 1000
end, function(_v483)
_v108.Triggerbot.MaxDelay = _v483 / 1000
end, true, (_V9({160,85})), true)
_v257(_v468, (_V9({128,71,175,89,121,182,28,235,0,163,69,178})), 100, 2000, function()
return _v108.Triggerbot.MaxDistance
end, function(_v483)
_v108.Triggerbot.MaxDistance = _v483
end, true, (_V9({160})), true)
_v266(_v468, (_V9({155,79,164,26,85,186,12,244})), function()
return _v108.Triggerbot.WallCheck
end, function()
_v108.Triggerbot.WallCheck = not _v108.Triggerbot.WallCheck
end)
local _v413 = _v258(right, (_V9({158,79,187,28,83,171,79,222,8,160})))
_v266(_v413, (_V9({136,72,182,27,81,186,11})), function()
return _v108.SilentAim.Enabled
end, function()
_v108.SilentAim.Enabled = not _v108.SilentAim.Enabled
end)
local _v165 = _v258(right, (_V9({133,79,163,27,82,167,79,218,25,189,71,185,29,88,173})))
_v266(_v165, (_V9({136,72,182,27,81,186,11})), function()
return _v108.Hitbox.Enabled
end, function()
_v108.Hitbox.Enabled = not _v108.Hitbox.Enabled
end)
_v257(_v165, (_V9({158,79,173,28})), 1, 20, function()
return _v108.Hitbox.Size
end, function(_v483)
_v108.Hitbox.Size = _v483
end, true)
_v257(_v165, (_V9({153,84,182,23,78,175,14,237,4,163,69,174})), 0, 1, function()
return _v108.Hitbox.Transparency
end, function(_v483)
_v108.Hitbox.Transparency = _v483
end, false)
_v239, right = _v254(_v208:add((_V9({154,67,182,9,82,177,28}))))
local _v364 = _v258(_v239, (_V9({131,73,247,43,88,188,0,246,13})))
_v267(_v364, (_V9({136,72,182,27,81,186,11})), function()
return _v108.NoRecoil.Enabled
end, function()
_v108.NoRecoil.Enabled = not _v108.NoRecoil.Enabled
end, (_V9({131,73,247,43,88,188,0,246,13,237,109,178,0})), function()
return _v108.NoRecoil.ToggleKey
end, function(_v229)
_v108.NoRecoil.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({163,73,165,28,94,176,6,243})))
end)
_v266(_v364, (_V9({130,72,187,0,29,136,7,246,13,168,6,145,16,79,182,1,248})), function()
return _v108.NoRecoil.RequireMouseDown
end, function()
_v108.NoRecoil.RequireMouseDown = not _v108.NoRecoil.RequireMouseDown
end)
_v266(_v364, (_V9({140,74,187,22,74,255,46,246,12,237,98,184,14,83})), function()
return _v108.NoRecoil.AllowAim
end, function()
_v108.NoRecoil.AllowAim = not _v108.NoRecoil.AllowAim
end)
_v257(_v364, (_V9({158,82,165,28,83,184,27,247})), 0, 100, function()
return _v108.NoRecoil.Strength * 100
end, function(_v483)
_v108.NoRecoil.Strength = _v483 / 100
end, true, (_V9({232})), true)
local _v418 = _v258(_v239, (_V9({131,73,247,42,77,173,10,254,5})))
_v267(_v418, (_V9({136,72,182,27,81,186,11})), function()
return _v108.NoSpread.Enabled
end, function()
_v108.NoSpread.Enabled = not _v108.NoSpread.Enabled
end, (_V9({131,73,247,42,77,173,10,254,5,237,109,178,0})), function()
return _v108.NoSpread.ToggleKey
end, function(_v229)
_v108.NoSpread.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({163,73,164,9,79,186,14,251})))
end)
_v266(_v418, (_V9({130,72,187,0,29,136,7,246,13,168,6,145,16,79,182,1,248})), function()
return _v108.NoSpread.RequireMouseDown
end, function()
_v108.NoSpread.RequireMouseDown = not _v108.NoSpread.RequireMouseDown
end)
_v257(_v418, (_V9({158,82,165,28,83,184,27,247})), 0, 100, function()
return _v108.NoSpread.Strength * 100
end, function(_v483)
_v108.NoSpread.Strength = _v483 / 100
end, true, (_V9({232})), true)
end
local function _v74(_v341, _v108)
_v238 = 0
local _v208 = _v264(_v341)
local _v239, right = _v254(_v208:add((_V9({136,117,135}))))
local _v159 = _v258(_v239, (_V9({136,117,135})))
_v267(_v159, (_V9({136,72,182,27,81,186,11})), function()
return _v108.ESP.Enabled
end, function()
_v108.ESP.Enabled = not _v108.ESP.Enabled
end, (_V9({136,117,135,89,118,186,22})), function()
return _v108.ESP.ToggleKey
end, function(_v229)
_v108.ESP.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({168,85,167})))
end)
_v266(_v159, (_V9({131,118,148,10})), function()
return _v108.ESP.NPCs
end, function()
_v108.ESP.NPCs = not _v108.ESP.NPCs
end)
_v257(_v159, (_V9({128,71,175,89,121,182,28,235,0,163,69,178})), 100, 2000, function()
return _v108.ESP.MaxDistance
end, function(_v483)
_v108.ESP.MaxDistance = _v483
end, true, (_V9({160})), true)
local _v249 = _v258(_v239, (_V9({140,86,167,28,92,173,14,241,2,168})))
_v266(_v249, (_V9({130,83,163,21,84,177,10,236})), function()
return _v108.ESP.Outlines
end, function()
_v108.ESP.Outlines = not _v108.ESP.Outlines
end)
_v266(_v249, (_V9({143,73,175,28,78})), function()
return _v108.ESP.Boxes
end, function()
_v108.ESP.Boxes = not _v108.ESP.Boxes
end)
_v266(_v249, (_V9({131,71,186,28,78})), function()
return _v108.ESP.Names
end, function()
_v108.ESP.Names = not _v108.ESP.Names
end)
_v266(_v249, (_V9({137,79,164,13,92,177,12,250})), function()
return _v108.ESP.Distance
end, function()
_v108.ESP.Distance = not _v108.ESP.Distance
end)
_v266(_v249, (_V9({133,67,182,21,73,183,79,221,0,191,85})), function()
return _v108.ESP.HealthBars
end, function()
_v108.ESP.HealthBars = not _v108.ESP.HealthBars
end)
_v266(_v249, (_V9({139,79,187,21,88,187})), function()
return _v108.ESP.Filled
end, function()
_v108.ESP.Filled = not _v108.ESP.Filled
end)
_v257(_v249, (_V9({130,83,163,21,84,177,10,191,46,189,71,180,16,73,166})), 0, 1, function()
return _v108.ESP.OutlineOpacity
end, function(_v483)
_v108.ESP.OutlineOpacity = _v483
end, false)
_v257(_v249, (_V9({139,79,187,21,29,144,31,254,2,164,82,174})), 0, 1, function()
return _v108.ESP.FillOpacity
end, function(_v483)
_v108.ESP.FillOpacity = _v483
end, false)
local _v146 = _v258(right, (_V9({137,84,182,14,84,177,8,191,36,158,118})))
_v266(_v146, (_V9({143,73,175,28,78})), function()
return _v108.Drawing.Boxes
end, function()
_v108.Drawing.Boxes = not _v108.Drawing.Boxes
end)
_v266(_v146, (_V9({153,84,182,26,88,173,28})), function()
return _v108.Drawing.Tracers
end, function()
_v108.Drawing.Tracers = not _v108.Drawing.Tracers
end)
local _v508 = _v258(right, (_V9({154,73,165,21,89})))
_v266(_v508, (_V9({139,83,187,21,95,173,6,248,9,185})), function()
return _v108.Visuals.Fullbright
end, function()
_v108.Visuals.Fullbright = not _v108.Visuals.Fullbright
end)
_v266(_v508, (_V9({131,73,247,63,82,184})), function()
return _v108.Visuals.NoFog
end, function()
_v108.Visuals.NoFog = not _v108.Visuals.NoFog
end)
_v239, right = _v254(_v208:add((_V9({142,73,187,22,79,172}))))
_v253(_v239, (_V9({130,83,163,21,84,177,10,191,34,162,74,184,11})), function()
return _v108.ESP.OutlineColor
end, function(c)
_v108.ESP.OutlineColor = c
end)
_v253(right, (_V9({139,79,187,21,29,156,0,243,14,191})), function()
return _v108.ESP.FillColor
end, function(c)
_v108.ESP.FillColor = c
end)
_v253(_v239, (_V9({143,73,175,89,126,176,3,240,19})), function()
return _v108.Drawing.BoxColor
end, function(c)
_v108.Drawing.BoxColor = c
end)
_v253(right, (_V9({153,84,182,26,88,173,79,220,14,161,73,165})), function()
return _v108.Drawing.TracerColor
end, function(c)
_v108.Drawing.TracerColor = c
end)
end
local function _v79(_v341, _v108)
_v238 = 0
local _v208 = _v264(_v341)
local _v239, right = _v254(_v208:add((_V9({128,73,161,28,80,186,1,235}))))
local _v169 = _v258(_v239, (_V9({139,74,174})))
_v266(_v169, (_V9({136,72,182,27,81,186,11})), function()
return _v108.Movement.FlyEnabled
end, function()
_v108.Movement.FlyEnabled = not _v108.Movement.FlyEnabled
end)
_v257(_v169, (_V9({139,74,174,89,110,175,10,250,5})), 10, 200, function()
return _v108.Movement.FlySpeed
end, function(_v483)
_v108.Movement.FlySpeed = _v483
end, true)
local _v417 = _v258(_v239, (_V9({158,86,178,28,89})))
_v266(_v417, (_V9({136,72,182,27,81,186,11})), function()
return _v108.Movement.SpeedEnabled
end, function()
_v108.Movement.SpeedEnabled = not _v108.Movement.SpeedEnabled
end)
_v257(_v417, (_V9({158,86,178,28,89})), 16, 100, function()
return _v108.Movement.Speed
end, function(_v483)
_v108.Movement.Speed = _v483
end, true)
local _v272 = _v258(_v239, (_V9({130,82,191,28,79})))
_v266(_v272, (_V9({157,83,187,10,88,255,71,222,15,185,79,250,53,92,184,13,254,2,166,15})), function()
return _v108.Movement.Pulse
end, function()
_v108.Movement.Pulse = not _v108.Movement.Pulse
end)
_v257(_v272, (_V9({157,83,187,10,88,255,45,240,14,190,82})), 50, 500, function()
return (_v108.Movement.PulseBoost or 0.1) * 1000
end, function(_v483)
_v108.Movement.PulseBoost = _v483 / 1000
end, true)
_v257(_v272, (_V9({157,83,187,10,88,255,44,240,0,190,82})), 50, 1000, function()
return (_v108.Movement.PulseCoast or 0.15) * 1000
end, function(_v483)
_v108.Movement.PulseCoast = _v483 / 1000
end, true)
_v266(_v272, (_V9({158,82,178,9,77,186,11,191,53,157})), function()
return _v108.Movement.ClickTPSteps
end, function()
_v108.Movement.ClickTPSteps = not _v108.Movement.ClickTPSteps
end)
_v257(_v272, (_V9({153,118,247,42,73,186,31,191,50,164,92,178})), 1, 50, function()
return _v108.Movement.ClickTPStep or 10
end, function(_v483)
_v108.Movement.ClickTPStep = _v483
end, true)
_v257(_v272, (_V9({153,118,247,48,83,171,10,237,23,172,74})), 10, 500, function()
return (_v108.Movement.ClickTPInterval or 0.05) * 1000
end, function(_v483)
_v108.Movement.ClickTPInterval = _v483 / 1000
end, true)
_v266(_v272, (_V9({131,73,180,21,84,175})), function()
return _v108.Movement.NoclipEnabled
end, function()
_v108.Movement.NoclipEnabled = not _v108.Movement.NoclipEnabled
end)
_v266(_v272, (_V9({132,72,177,16,83,182,27,250,65,135,83,186,9})), function()
return _v108.Movement.InfJumpEnabled
end, function()
_v108.Movement.InfJumpEnabled = not _v108.Movement.InfJumpEnabled
end)
local _v466 = _v258(right, (_V9({142,74,190,26,86,255,59,207})))
_v266(_v466, (_V9({136,72,182,27,81,186,11})), function()
return _v108.Movement.ClickTPEnabled
end, function()
_v108.Movement.ClickTPEnabled = not _v108.Movement.ClickTPEnabled
end)
_v261(_v466, (_V9({128,73,179,16,91,182,10,237,65,134,67,174})), function()
return _v108.Movement.ClickTPKey
end, function(_v229)
_v108.Movement.ClickTPKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({174,74,190,26,86,171,31})))
end)
end
local function _v80(_v341, _v108)
_v238 = 0
local _v208 = _v264(_v341)
local _v239, right = _v254(_v208:add((_V9({157,74,182,0,88,173,28}))))
local _v244 = _v258(_v239, (_V9({157,74,182,0,88,173,79,211,8,190,82})))
_v352 = _v296((_V9({158,69,165,22,81,179,6,241,6,139,84,182,20,88})), {
Parent = _v244,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 230),
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.5,
BorderSizePixel = 0,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v352, CornerRadius = UDim.new(0, 6) })
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = _v352,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = _v352,
PaddingTop = UDim.new(0, 4),
PaddingBottom = UDim.new(0, 4),
PaddingLeft = UDim.new(0, 4),
PaddingRight = UDim.new(0, 4),
})
local function _v367()
for _v351, row in pairs(_v353) do
row.btn.BackgroundColor3 = (_v351 == _v403) and _v4.accent or _v4.row
end
end
local function _v366()
if not _v352 then
return
end
for _, _v102 in ipairs(_v352:GetChildren()) do
if not _v102:IsA((_V9({152,111,155,16,78,171,35,254,24,162,83,163}))) then
_v102:Destroy()
end
end
table.clear(_v353)
local _v115 = 0
for _, _v351 in ipairs(_v24:GetPlayers()) do
if _v351 ~= _v22 then
_v115 = _v115 + 1
local row = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v352,
LayoutOrder = _v115,
Size = UDim2.new(1, 0, 0, 24),
BackgroundColor3 = (_v351 == _v403) and _v4.accent or _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = row, CornerRadius = UDim.new(0, 4) })
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = row,
Size = UDim2.new(0.65, -8, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v351.TeamColor.Color,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v351.Name,
})
local dist = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = row,
Size = UDim2.new(0.35, -8, 1, 0),
Position = UDim2.new(0.65, 0, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = (_V9({47,166,67})),
})
row.MouseButton1Click:Connect(function()
_v403 = (_v403 == _v351) and nil or _v351
_v367()
end)
_v353[_v351] = { btn = row, dist = dist }
end
end
if _v115 == 0 then
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v352,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({237,6,185,22,29,176,27,247,4,191,6,167,21,92,166,10,237,18})),
})
end
end
local _v42 = _v258(right, (_V9({140,69,163,16,82,177,28})))
local _v402 = _v262(_v42, (_V9({158,67,187,28,94,171,10,251})), (_V9({47,166,67})))
_v252(_v42, (_V9({153,67,187,28,77,176,29,235,65,153,73})), function()
local _v99 = _v403 and _v403.Character
local root = _v99 and _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
if root and UI.TeleportTo then
UI.TeleportTo(root.Position)
end
end)
_v415 = _v252(_v42, (_V9({158,86,178,26,73,190,27,250})), function()
if _v416 then
_v427()
elseif _v403 then
_v424(_v403)
end
end)
table.insert(_v435, function()
_v402.Text = _v403 and _v403.Name or (_V9({47,166,67}))
_v367()
end)
_v366()
table.insert(_v471, _v24.PlayerAdded:Connect(function()
_v366()
end))
table.insert(_v471, _v24.PlayerRemoving:Connect(function(_v351)
if _v351 == _v403 then
_v403 = nil
end
if _v351 == _v416 then
_v427()
end
_v366()
end))
local _v236 = 0
table.insert(_v471, _v29.RenderStepped:Connect(function()
if os.clock() - _v236 < 0.5 then
return
end
_v236 = os.clock()
_v402.Text = _v403 and _v403.Name or (_V9({47,166,67}))
local _v288 = _v22.Character
local _v289 = _v288 and _v288:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
for _v351, row in pairs(_v353) do
local _v99 = _v351.Character
local root = _v99 and _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
row.dist.Text = (_v289 and root)
and (math.floor((root.Position - _v289.Position).Magnitude + 0.5) .. (_V9({160})))
or (_V9({47,166,67}))
end
if _v416 then
if _v45 and _v45.Movement and _v45.Movement.FlyEnabled then
_v427()
else
local _v99 = _v416.Character
local humanoid = _v99 and _v99:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
local _v84 = _v39.CurrentCamera
if humanoid and humanoid.Health > 0 and _v84 then
_v84.CameraSubject = humanoid
else
_v427()
end
end
end
end))
end
local function _v78(_v341, _v108)
_v238 = 0
local _v208 = _v264(_v341)
local _v239, right = _v254(_v208:add((_V9({158,67,164,10,84,176,1}))))
local _v41 = _v258(_v239, (_V9({140,69,180,22,72,177,27})))
_v262(_v41, (_V9({152,85,178,11,83,190,2,250})), _v22 and _v22.Name or (_V9({47,166,67})))
_v262(_v41, (_V9({137,79,164,9,81,190,22,191,47,172,75,178})), _v22 and _v22.DisplayName or (_V9({47,166,67})))
_v262(_v41, (_V9({152,85,178,11,29,150,43})), _v22 and tostring(_v22.UserId) or (_V9({47,166,67})))
_v266(_v41, (_V9({140,72,163,16,16,158,41,212})), function()
return _v108.Utility.AntiAFK
end, function()
_v108.Utility.AntiAFK = not _v108.Utility.AntiAFK
end)
_v252(_v41, (_V9({158,67,165,15,88,173,79,215,14,189})), function()
Utility:ServerHop()
end)
_v252(_v41, (_V9({159,67,189,22,84,177,79,204,4,191,80,178,11})), function()
Utility:Rejoin()
end)
local _v502 = _v258(right, (_V9({154,67,181,17,82,176,4})))
local _v481 = _v265(_v502, (_V9({186,67,181,17,82,176,4,191,20,191,74,53,249,155})))
_v481.Text = _v108.Webhook.Url
_v481.FocusLost:Connect(function()
_v108.Webhook.Url = _v481.Text
end)
_v252(_v502, (_V9({158,67,185,29,29,139,10,236,21,237,113,178,27,85,176,0,244})), function()
local _v315, res = _v38.SendWebhook((_V9({155,71,185,16,73,166,66,216,4,163,67,165,24,81,255,27,250,18,185,6,160,28,95,183,0,240,10})))
if _v315 then
UI:Notify((_V9({153,67,164,13,29,168,10,253,9,162,73,188,89,78,186,1,235})), 2)
else
UI:Notify((_V9({154,67,181,17,82,176,4,191,7,172,79,187,28,89,229,79})) .. tostring(res), 3)
end
end)
end
local function _v81(_v341, _v108)
_v238 = 0
local _v208 = _v264(_v341)
local _v239, right = _v254(_v208:add((_V9({138,67,185,28,79,190,3}))))
local _v215 = _v258(_v239, (_V9({132,72,163,28,79,185,14,252,4})))
_v257(_v215, (_V9({152,111,247,42,94,190,3,250})), 0.8, 1.5, function()
return _v108.UI.Scale
end, function(_v483)
_v108.UI.Scale = _v483
if _v506 then
_v506.Scale = _v483
end
end, false)
_v266(_v215, (_V9({134,67,174,27,84,177,11,191,49,172,72,178,21})), function()
return _v108.UI.KeybindPanel
end, function()
_v108.UI.KeybindPanel = not _v108.UI.KeybindPanel
if _v232 then
_v232.Visible = _v108.UI.KeybindPanel
end
end)
_v266(_v215, (_V9({153,71,165,30,88,171,79,219,8,190,86,187,24,68})), function()
return _v108.UI.TargetDisplay
end, function()
_v108.UI.TargetDisplay = not _v108.UI.TargetDisplay
_v445 = _v108.UI.TargetDisplay
if not _v445 and _v446 then
_v446.Visible = false
end
end)
_v266(_v215, (_V9({139,118,132,89,126,176,26,241,21,168,84})), function()
return _v108.UI.FPSCounter
end, function()
_v108.UI.FPSCounter = not _v108.UI.FPSCounter
if _v177 then
_v177.Visible = _v108.UI.FPSCounter
end
end)
_v266(_v215, (_V9({154,71,163,28,79,178,14,237,10})), function()
return _v108.UI.Watermark
end, function()
_v108.UI.Watermark = not _v108.UI.Watermark
if _v501 then
_v501.Visible = _v108.UI.Watermark
end
end)
_v253(_v215, (_V9({140,69,180,28,83,171,79,220,14,161,73,165})), function()
return _v108.UI.Accent
end, function(_v294)
_v58(_v294)
end)
table.insert(_v435, function()
if _v108.UI.Accent then
_v58(_v108.UI.Accent)
end
end)
_v239, right = _v254(_v208:add((_V9({142,73,185,31,84,184,28}))))
local _v97 = _v258(_v239, (_V9({142,73,185,31,84,184,28})))
if not _v8.isSupported() then
_v262(_v97, (_V9({158,82,182,13,72,172})), (_V9({152,72,164,12,77,175,0,237,21,168,66})))
return
end
local _v291 = _v265(_v97, (_V9({174,73,185,31,84,184,79,241,0,160,67,53,249,155})))
local _v245 = _v296((_V9({139,84,182,20,88})), {
Parent = _v97,
LayoutOrder = _v297(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = _v245,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v366
local function _v400(name)
_v291.Text = name
_v366()
end
_v366 = function()
for _, _v102 in ipairs(_v245:GetChildren()) do
if not _v102:IsA((_V9({152,111,155,16,78,171,35,254,24,162,83,163}))) then
_v102:Destroy()
end
end
local _v293 = _v8.list()
if #_v293 == 0 then
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v245,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({163,73,247,10,92,169,10,251,65,174,73,185,31,84,184,28})),
})
return
end
for i, name in ipairs(_v293) do
local _v401 = (_v291.Text == name)
local row = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v245,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v401 and _v4.accent or _v4.row,
BackgroundTransparency = _v401 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v401 and Color3.fromRGB(255, 255, 255) or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({237,6})) .. name,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v400(name)
end)
row.MouseEnter:Connect(function()
if _v291.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v4.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v291.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v4.row
end
end)
end
end
_v252(_v97, (_V9({158,71,161,28})), function()
local _v315, res = _v8.save(_v291.Text, _v108)
if _v315 then
UI:Notify((_V9({158,71,161,28,89,255,12,240,15,171,79,176,89,26})) .. res .. (_V9({234})), 2)
_v366()
else
UI:Notify(tostring(res), 3)
end
end)
_v252(_v97, (_V9({129,73,182,29})), function()
local _v315, res = _v8.load(_v291.Text, _v108)
if _v315 then
if _v506 then
_v506.Scale = _v108.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({129,73,182,29,88,187,79,252,14,163,64,190,30,29,248})) .. res .. (_V9({234})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v252(_v97, (_V9({137,67,187,28,73,186})), function()
local _v315, res = _v8.delete(_v291.Text)
if _v315 then
UI:Notify((_V9({137,67,187,28,73,186,11,191,2,162,72,177,16,90,255,72})) .. res .. (_V9({234})), 2)
_v291.Text = (_V9({}))
_v366()
else
UI:Notify(tostring(res), 3)
end
end, _v4.danger)
_v366()
end
local function _v82(_v108)
_v446 = _v296((_V9({139,84,182,20,88})), {
Parent = _v190,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v446, CornerRadius = UDim.new(0, 6) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v446, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = _v446,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = _v446,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v143 = _v296((_V9({139,84,182,20,88})), {
Parent = _v446,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v143, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v446,
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
local _v145, _v144, _v423
_v446.InputBegan:Connect(function(_v217)
if _v227(_v217) then
_v145 = true
_v144 = _v217.Position
_v423 = _v446.Position
end
end)
table.insert(_v278, function(_v217)
if _v145 and _v446 then
local delta = _v217.Position - _v144
_v446.Position = UDim2.new(
_v423.X.Scale,
_v423.X.Offset + delta.X,
_v423.Y.Scale,
_v423.Y.Offset + delta.Y
)
end
end)
table.insert(_v371, function()
_v145 = false
end)
table.insert(_v435, function()
_v445 = _v108.UI.TargetDisplay
if not _v445 and _v446 then
_v446.Visible = false
end
end)
_v445 = _v108.UI.TargetDisplay
end
local function _v76(_v108)
_v177 = _v296((_V9({139,84,182,20,88})), {
Parent = _v190,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v177, CornerRadius = UDim.new(0, 6) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v177, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = _v177,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = _v177,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v143 = _v296((_V9({139,84,182,20,88})), {
Parent = _v177,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v143, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v177,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({224,11,247,31,77,172})),
})
table.insert(_v435, function()
if _v177 then
_v177.Visible = _v108.UI.FPSCounter
end
end)
_v177.Visible = _v108.UI.FPSCounter
end
local function _v83(_v108)
_v501 = _v296((_V9({132,75,182,30,88,147,14,253,4,161})), {
Parent = _v190,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 14, 1, -14),
Size = UDim2.fromOffset(180, 64),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Fit,
Image = (_V9({})),
Visible = false,
})
UI:SetWatermarkImage(_v108.UI.WatermarkImageId)
table.insert(_v435, function()
if _v501 then
_v501.Visible = _v108.UI.Watermark
end
end)
_v501.Visible = _v108.UI.Watermark
end
local function _v77(_v108)
_v238 = 0
_v232 = _v296((_V9({139,84,182,20,88})), {
Parent = _v190,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
Visible = false,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v232, CornerRadius = UDim.new(0, 8) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v232, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), {
Parent = _v232,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = _v232,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v296((_V9({139,84,182,20,88})), {
Parent = _v232,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({134,67,174,27,84,177,11,236})),
})
local _v145, _v144, _v423
bar.InputBegan:Connect(function(_v217)
if _v227(_v217) then
_v145 = true
_v144 = _v217.Position
_v423 = _v232.Position
end
end)
table.insert(_v278, function(_v217)
if _v145 and _v232 then
local delta = _v217.Position - _v144
_v232.Position = UDim2.new(
_v423.X.Scale,
_v423.X.Offset + delta.X,
_v423.Y.Scale,
_v423.Y.Offset + delta.Y
)
end
end)
table.insert(_v371, function()
_v145 = false
end)
_v261(_v232, (_V9({128,67,185,12})), function()
return _v108.UI.MenuKey
end, function(_v229)
_v108.UI.MenuKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({160,67,185,12})))
end)
_v261(_v232, (_V9({140,79,186,27,82,171})), function()
return _v108.Camera.ToggleKey
end, function(_v229)
_v108.Camera.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({172,79,186,27,82,171})))
end)
_v261(_v232, (_V9({136,117,135})), function()
return _v108.ESP.ToggleKey
end, function(_v229)
_v108.ESP.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({168,85,167})))
end)
_v261(_v232, (_V9({139,105,129,89,126,182,29,252,13,168})), function()
return _v108.Camera.FOVCircleKey
end, function(_v229)
_v108.Camera.FOVCircleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({171,73,161,26,84,173,12,243,4})))
end)
_v261(_v232, (_V9({131,73,247,43,88,188,0,246,13})), function()
return _v108.NoRecoil.ToggleKey
end, function(_v229)
_v108.NoRecoil.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({163,73,165,28,94,176,6,243})))
end)
_v261(_v232, (_V9({131,73,247,42,77,173,10,254,5})), function()
return _v108.NoSpread.ToggleKey
end, function(_v229)
_v108.NoSpread.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({163,73,164,9,79,186,14,251})))
end)
_v261(_v232, (_V9({153,84,190,30,90,186,29,253,14,185})), function()
return _v108.Triggerbot.ToggleKey
end, function(_v229)
_v108.Triggerbot.ToggleKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({185,84,190,30,90,186,29,253,14,185})))
end)
_v261(_v232, (_V9({152,72,187,22,92,187})), function()
return _v108.UI.UnloadKey
end, function(_v229)
_v108.UI.UnloadKey = _v229
end, function(_v229)
return _v230(_v108, _v229, (_V9({184,72,187,22,92,187})))
end)
table.insert(_v435, function()
if _v232 then
_v232.Visible = _v108.UI.KeybindPanel
end
end)
_v232.Visible = _v108.UI.KeybindPanel
end
local function _v408(_v425)
if not _v251 or _v425 == visible then
return
end
visible = _v425
if _v45 and _v45.UI then
_v45.UI.Visible = _v425
end
if _v425 then
_v251.Visible = true
_v251.GroupTransparency = 1
_v35:Create(_v251, TweenInfo.new(_v14), { GroupTransparency = 0 }):Play()
else
local _v470 = _v35:Create(_v251, TweenInfo.new(_v14), { GroupTransparency = 1 })
_v470.Completed:Once(function()
if not visible and _v251 then
_v251.Visible = false
end
end)
_v470:Play()
end
end
function UI:Init(_v108, _v329)
if _v190 then
return
end
_v45 = _v108
_v330 = _v329
if _v108.UI.Accent then
_v4.accent = _v108.UI.Accent
end
_v422()
_v190 = _v296((_V9({158,69,165,28,88,177,40,234,8})), {
Name = (_V9({155,71,185,16,73,166,40,250,15,168,84,182,21,104,150})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v315 = pcall(function()
_v190.Parent = Utility.getGuiParent()
end)
if not _v315 or not _v190.Parent then
_v190.Parent = _v22:WaitForChild((_V9({157,74,182,0,88,173,40,234,8})))
end
_v251 = _v296((_V9({142,71,185,15,92,172,40,237,14,184,86})), {
Parent = _v190,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v506 = _v296((_V9({152,111,132,26,92,179,10})), { Parent = _v251, Scale = _v108.UI.Scale })
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v251, CornerRadius = UDim.new(0, 8) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v251, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
local _v458 = _v296((_V9({139,84,182,20,88})), {
Parent = _v251,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v458, CornerRadius = UDim.new(0, 8) })
_v296((_V9({139,84,182,20,88})), {
Parent = _v458,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
local _v143 = _v296((_V9({139,84,182,20,88})), {
Parent = _v458,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v143, CornerRadius = UDim.new(1, 0) })
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v458,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({155,71,185,16,73,166,83,249,14,163,82,247,26,82,179,0,237,92,239,5,239,77,14,154,45,218,67,243,8,179,28,75,227,64,249,14,163,82,233,89,122,186,1,250,19,172,74}))
.. (_V9({241,64,184,23,73,255,12,240,13,162,84,234,91,30,231,46,168,34,140,22,245,71,29,255,79,93,214,237,6,247,15,13,227,64,249,14,163,82,233})),
ZIndex = 2,
})
_v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v458,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.new(0, 140, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v22 and _v22.Name or (_V9({})),
ZIndex = 2,
})
local _v145, _v144, _v423
_v458.InputBegan:Connect(function(_v217)
if _v227(_v217) then
_v145 = true
_v144 = _v217.Position
_v423 = _v251.Position
end
end)
table.insert(_v278, function(_v217)
if _v145 then
local delta = _v217.Position - _v144
_v251.Position = UDim2.new(
_v423.X.Scale,
_v423.X.Offset + delta.X,
_v423.Y.Scale,
_v423.Y.Offset + delta.Y
)
end
end)
table.insert(_v371, function()
_v145 = false
end)
local _v412 = _v296((_V9({139,84,182,20,88})), {
Parent = _v251,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v412, CornerRadius = UDim.new(0, 6) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v412, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = _v412,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v441 = _v296((_V9({139,84,182,20,88})), {
Parent = _v412,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v296((_V9({152,111,155,16,78,171,35,254,24,162,83,163})), { Parent = _v441, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v473 = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v412,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.danger,
Text = (_V9({152,72,187,22,92,187})),
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v473, CornerRadius = UDim.new(0, 6) })
local _v474 = _v296((_V9({152,111,132,13,79,176,4,250})), {
Parent = _v473,
Color = _v4.danger,
Thickness = 1,
Transparency = 0.55,
})
_v473.MouseButton1Click:Connect(function()
if _v330 then
_v330()
end
end)
_v473.MouseEnter:Connect(function()
_v35:Create(_v473, _v1, {
BackgroundColor3 = _v4.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v35:Create(_v474, _v1, { Transparency = 0 }):Play()
end)
_v473.MouseLeave:Connect(function()
_v35:Create(_v473, _v1, {
BackgroundColor3 = _v4.row,
TextColor3 = _v4.danger,
}):Play()
_v35:Create(_v474, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v296((_V9({139,84,182,20,88})), {
Parent = _v251,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v296((_V9({152,111,135,24,89,187,6,241,6})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v443 = { (_V9({142,73,186,27,92,171})), (_V9({155,79,164,12,92,179})), (_V9({128,73,161,28,80,186,1,235})), (_V9({157,74,182,0,88,173,28})), (_V9({128,79,164,26})), (_V9({158,67,163,13,84,177,8,236})) }
local _v440 = {}
for i, _v442 in ipairs(_v443) do
local _v221 = _v116 == _v442
local _v438 = _v296((_V9({153,67,175,13,127,170,27,235,14,163})), {
Parent = _v441,
LayoutOrder = i,
Size = UDim2.new(1, 0, 1 / #_v443, -6),
BackgroundColor3 = _v4.rowHover,
BackgroundTransparency = _v221 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v221 and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({237,6,247,89})) .. _v442,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v438, CornerRadius = UDim.new(0, 6) })
local stripe = _v296((_V9({139,84,182,20,88})), {
Parent = _v438,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
Visible = _v221,
ZIndex = 2,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v439 = _v296((_V9({139,84,182,20,88})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v221,
})
_v440[_v442] = { btn = _v438, frame = _v439, stripe = stripe }
_v438.MouseButton1Click:Connect(function()
_v116 = _v442
for name, _v437 in pairs(_v440) do
local _v43 = name == _v442
_v437.frame.Visible = _v43
_v437.stripe.Visible = _v43
_v35:Create(_v437.btn, _v1, {
BackgroundTransparency = _v43 and 0 or 1,
TextColor3 = _v43 and _v4.text or _v4.textSub,
}):Play()
end
end)
_v438.MouseEnter:Connect(function()
if _v116 ~= _v442 then
_v35:Create(_v438, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v438.MouseLeave:Connect(function()
if _v116 ~= _v442 then
_v35:Create(_v438, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v73(_v440[(_V9({142,73,186,27,92,171}))].frame, _v108)
_v74(_v440[(_V9({155,79,164,12,92,179}))].frame, _v108)
_v79(_v440[(_V9({128,73,161,28,80,186,1,235}))].frame, _v108)
_v80(_v440[(_V9({157,74,182,0,88,173,28}))].frame, _v108)
_v78(_v440[(_V9({128,79,164,26}))].frame, _v108)
_v81(_v440[(_V9({158,67,163,13,84,177,8,236}))].frame, _v108)
_v77(_v108)
_v82(_v108)
_v76(_v108)
_v83(_v108)
if _v108.UI.Visible then
_v408(true)
end
end
function UI:Toggle()
_v408(not visible)
end
function UI:Show()
_v408(true)
end
function UI:Hide()
_v408(false)
end
function UI:SetCurrentTarget(name)
if not _v446 then
return
end
if _v446.Visible ~= _v445 then
_v446.Visible = _v445
end
if not _v445 or not targetPanelLabel then
return
end
local _v411, colour
if name and name ~= (_V9({})) and name ~= (_V9({131,73,185,28})) then
_v411, colour = name, (_V9({238,30,227,74,120,157,42}))
else
_v411, colour = (_V9({152,72,156,23,82,168,1})), (_V9({238,30,150,78,126,158,95}))
end
local text = (_V9({153,71,165,30,88,171,85,191,93,171,73,185,13,29,188,0,243,14,191,27,245})) .. colour .. (_V9({239,24})) .. _v411 .. (_V9({241,9,177,22,83,171,81}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v175)
if not fpsLabel or not _v177 or not _v177.Visible then
return
end
local text = string.format((_V9({241,64,184,23,73,255,12,240,13,162,84,234,91,30,231,91,172,36,143,99,245,71,24,187,83,176,7,162,72,163,71,29,185,31,236})), _v175 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v214)
if not _v501 then
return
end
local _v136 = tostring(_v214 or (_V9({}))):match((_V9({232,66,252})))
_v501.Image = _v136 and ((_V9({191,68,175,24,78,172,10,235,8,169,28,248,86})) .. _v136) or (_V9({}))
end
function UI:SyncControls()
for _, _v171 in ipairs(_v435) do
_v171()
end
end
function UI:IsCapturingKey()
return _v92
end
function UI:Notify(text, _v151)
if not _v190 then
return
end
_v151 = _v151 or 3
local _v459 = _v296((_V9({153,67,175,13,113,190,13,250,13})), {
Parent = _v190,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 12),
Size = UDim2.fromOffset(math.max(200, #text * 8 + 28), 34),
BackgroundColor3 = _v4.bar,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v4.text,
Text = text,
})
_v296((_V9({152,111,148,22,79,177,10,237})), { Parent = _v459, CornerRadius = UDim.new(0, 8) })
_v296((_V9({152,111,132,13,79,176,4,250})), { Parent = _v459, Color = _v4.accent, Thickness = 1, Transparency = 0.3 })
_v35:Create(_v459, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v151, function()
if _v459 and _v459.Parent then
local _v339 = _v35:Create(_v459, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v339.Completed:Once(function()
if _v459 then
_v459:Destroy()
end
end)
_v339:Play()
end
end)
end
function UI:Cleanup()
_v427()
_v403 = nil
_v415 = nil
_v352 = nil
table.clear(_v353)
for _, _v111 in ipairs(_v471) do
_v111:Disconnect()
end
table.clear(_v471)
table.clear(_v278)
table.clear(_v371)
table.clear(_v435)
_v44 = nil
_v92 = false
_v46 = nil
_v446, targetPanelLabel = nil, nil
_v445 = false
_v232 = nil
_v501 = nil
_v177, fpsLabel = nil, nil
_v506 = nil
if _v190 then
_v190:Destroy()
_v190 = nil
_v251 = nil
end
visible = false
end
return UI
end)()
Movement = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v36 = game:GetService((_V9({152,85,178,11,116,177,31,234,21,158,67,165,15,84,188,10})))
local _v39 = game:GetService((_V9({154,73,165,18,78,175,14,252,4})))
local _v22 = _v24.LocalPlayer
local UI = UI
local Movement = {}
local _v2 = 16
local _v19 = 50
local _v283
local _v281
local _v287 = 0
local _v279
local function _v280()
local _v99 = _v22.Character
local root = _v99 and _v99:FindFirstChild((_V9({133,83,186,24,83,176,6,251,51,162,73,163,41,92,173,27})))
local humanoid = _v99 and _v99:FindFirstChildOfClass((_V9({133,83,186,24,83,176,6,251})))
if not (_v99 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v99, root, humanoid
end
local function _v282(_v84)
local _v249 = _v84.CFrame.LookVector
local _v168 = Vector3.new(_v249.X, 0, _v249.Z)
if _v168.Magnitude < 0.001 then
_v168 = Vector3.new(0, 0, -1)
else
_v168 = _v168.Unit
end
local right = _v84.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v277 = Vector3.zero
if _v36:IsKeyDown(Enum.KeyCode.W) then
_v277 = _v277 + _v168
end
if _v36:IsKeyDown(Enum.KeyCode.S) then
_v277 = _v277 - _v168
end
if _v36:IsKeyDown(Enum.KeyCode.D) then
_v277 = _v277 + right
end
if _v36:IsKeyDown(Enum.KeyCode.A) then
_v277 = _v277 - right
end
if _v36:IsKeyDown(Enum.KeyCode.Space) then
_v277 = _v277 + Vector3.yAxis
end
if _v36:IsKeyDown(Enum.KeyCode.LeftShift) then
_v277 = _v277 - Vector3.yAxis
end
if _v277.Magnitude > 0 then
return _v277.Unit
end
return nil
end
local function _v286(_v108)
if _v108.Pulse == false then
return true
end
local _v68 = _v108.PulseBoost or 0.1
local _v104 = _v108.PulseCoast or 0.15
return (os.clock() % (_v68 + _v104)) < _v68
end
function Movement:Update(_v150, _v108)
local _v99, root, humanoid = _v280()
if _v108.NoclipEnabled and _v99 then
for _, _v342 in ipairs(_v99:GetDescendants()) do
if _v342:IsA((_V9({143,71,164,28,109,190,29,235}))) then
_v342.CanCollide = false
end
end
end
if not root then
return
end
if _v108.FlyEnabled then
local _v84 = _v39.CurrentCamera
if _v84 then
local _v488 = Vector3.zero
if not UI:IsCapturingKey() then
local _v137 = _v282(_v84)
if _v137 then
local _v417 = _v108.FlySpeed or 50
if not _v286(_v108) then
_v417 = math.min(_v417, _v2)
end
_v488 = _v137 * _v417
end
end
root.AssemblyLinearVelocity = _v488
end
return
end
if _v108.SpeedEnabled then
local _v417 = _v108.Speed or _v2
local _v277 = humanoid.MoveDirection
if _v417 > _v2 and _v277.Magnitude > 0 and _v286(_v108) then
local _v488 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v277.X * _v417, _v488.Y, _v277.Z * _v417)
end
end
end
local function _v285(_v108)
if not _v108.InfJumpEnabled then
return
end
local _, root = _v280()
if root then
local _v488 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v488.X, _v19, _v488.Z)
end
end
function Movement.TeleportTo(_v356)
local _v132 = _v356 + Vector3.new(0, 3, 0)
local _v108 = _v279 or {}
if not _v108.ClickTPSteps then
local _, root = _v280()
if root then
root.CFrame = CFrame.new(_v132)
end
return
end
_v287 = _v287 + 1
local _v461 = _v287
local _v426 = _v108.ClickTPStep or 10
local _v220 = _v108.ClickTPInterval or 0.05
task.spawn(function()
while _v461 == _v287 do
local _, currentRoot = _v280()
if not currentRoot then
return
end
local _v314 = _v132 - currentRoot.CFrame.Position
if _v314.Magnitude <= _v426 then
currentRoot.CFrame = CFrame.new(_v132)
return
end
currentRoot.CFrame = currentRoot.CFrame + _v314.Unit * _v426
task.wait(_v220)
end
end)
end
local function _v284(_v108, _v217, _v182)
if _v182 or UI:IsCapturingKey() then
return
end
if not _v108.ClickTPEnabled then
return
end
if _v217.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v36:IsKeyDown(_v108.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _v276 = _v22:GetMouse()
if _v276 and _v276.Hit then
Movement.TeleportTo(_v276.Hit.Position)
end
end
function Movement:Init(_v108)
_v279 = _v108
if not _v283 then
_v283 = _v36.JumpRequest:Connect(function()
_v285(_v108)
end)
end
if not _v281 then
_v281 = _v36.InputBegan:Connect(function(_v217, _v182)
_v284(_v108, _v217, _v182)
end)
end
end
function Movement:Cleanup()
if _v283 then
_v283:Disconnect()
_v283 = nil
end
if _v281 then
_v281:Disconnect()
_v281 = nil
end
end
return Movement
end)()
_v10 = (function()
local _v24 = game:GetService((_V9({157,74,182,0,88,173,28})))
local _v29 = game:GetService((_V9({159,83,185,42,88,173,25,246,2,168})))
local _v36 = game:GetService((_V9({152,85,178,11,116,177,31,234,21,158,67,165,15,84,188,10})))
local _v22 = _v24.LocalPlayer
local _v9 = _v9
local _v8 = _v8
local _v7 = _v7
local _v6 = _v6
local _v18 = Hitbox
local SilentAim = SilentAim
local NoRecoil = NoRecoil
local NoSpread = NoSpread
local Triggerbot = Triggerbot
local ESP = ESP
local _v13 = _v13
local Visuals = Visuals
local Utility = Utility
local UI = UI
local Movement = Movement
local _v38 = _v38
local _v10 = {}
_v10.Version = (_V9({253}))
_v10.Config = _v9
UI.TeleportTo = Movement.TeleportTo
_v38.Version = _v10.Version
local _v387 = false
local _v112 = {}
local _v52 = false
local _v25 = (_V9({155,71,185,16,73,166,40,250,15,168,84,182,21,111,186,12,240,8,161}))
local _v188 = {}
local _v16 = 5
local function _v189(name, _v171, ...)
local _v315, res = pcall(_v171, ...)
if _v315 then
local _v421 = _v188[name]
if _v421 then
_v421.failures = 0
end
return true, res
end
local _v421 = _v188[name]
if not _v421 then
_v421 = { failures = 0, lastWarn = -math.huge }
_v188[name] = _v421
end
_v421.failures = _v421.failures + 1
local _v298 = os.clock()
if _v298 - _v421.lastWarn >= _v16 then
_v421.lastWarn = _v298
warn(string.format((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,68,190,6,177,24,84,179,10,251,65,229,94,242,29,20,229,79,186,18})), name, _v421.failures, tostring(res)))
end
return false, nil
end
function _v10.IsRunning()
return _v387
end
function _v10.SaveConfig(name)
return _v8.save(name, _v9)
end
function _v10.LoadConfig(name)
local _v315, res = _v8.load(name, _v9)
if _v315 then
pcall(function()
UI:SyncControls()
end)
end
return _v315, res
end
function _v10.ListConfigs()
return _v8.list()
end
function _v10.DeleteConfig(name)
return _v8.delete(name)
end
function _v10.ServerHop()
return Utility:ServerHop()
end
function _v10.Rejoin()
return Utility:Rejoin()
end
function _v10.SetWatermarkImage(_v214)
_v9.UI.WatermarkImageId = tostring(_v214 or (_V9({})))
UI:SetWatermarkImage(_v9.UI.WatermarkImageId)
return _v10
end
function _v10.SetWebhook(_v480)
return _v38.SetWebhook(_v480)
end
function _v10.HasWebhook()
return _v38.HasWebhook()
end
function _v10.SendWebhook(content, _v336)
return _v38.SendWebhook(content, _v336)
end
function _v10.SendLoadedEmbed(_v223)
return _v38.SendLoadedEmbed(_v223)
end
function _v10.Start()
if _v387 then
return _v10
end
_v387 = true
local _v315, err = pcall(function()
ESP:Init()
UI:Init(_v9, function()
_v10.Stop()
end)
Movement:Init(_v9.Movement)
SilentAim:Init(_v9.SilentAim)
Utility:Init(_v9.Utility)
table.insert(_v112, _v24.PlayerAdded:Connect(function(_v351)
_v189((_V9({157,74,182,0,88,173,46,251,5,168,66})), ESP.OnPlayerAdded, ESP, _v351)
end))
table.insert(_v112, _v24.PlayerRemoving:Connect(function(_v351)
_v189((_V9({157,74,182,0,88,173,61,250,12,162,80,190,23,90})), ESP.OnPlayerRemoving, ESP, _v351)
end))
table.insert(_v112, _v36.InputBegan:Connect(function(_v217, _v182)
if _v182 or UI:IsCapturingKey() then
return
end
_v189((_V9({134,67,174,27,84,177,11,236})), function()
local _v229 = _v217.KeyCode
if _v229 == _v9.UI.MenuKey then
UI:Toggle()
elseif _v229 == _v9.UI.UnloadKey then
_v10.Stop()
else
local _v460 = {
{ _v9.Camera, (_V9({136,72,182,27,81,186,11})), _v9.Camera.ToggleKey },
{ _v9.ESP, (_V9({136,72,182,27,81,186,11})), _v9.ESP.ToggleKey },
{ _v9.Camera, (_V9({139,105,129,58,84,173,12,243,4})), _v9.Camera.FOVCircleKey },
{ _v9.NoRecoil, (_V9({136,72,182,27,81,186,11})), _v9.NoRecoil.ToggleKey },
{ _v9.NoSpread, (_V9({136,72,182,27,81,186,11})), _v9.NoSpread.ToggleKey },
{ _v9.Triggerbot, (_V9({136,72,182,27,81,186,11})), _v9.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v460) do
if _v229 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v176, fpsFrames = 0, 0
table.insert(_v112, _v29.RenderStepped:Connect(function(_v150)
_v189((_V9({142,71,185,29,84,187,14,235,4,190})), _v7.Update, _v7, _v9.Camera, _v9.ESP)
_v189((_V9({136,117,135})), ESP.Update, ESP, _v9.ESP)
local _v317, target = true, nil
if not (UI.IsSpectating and UI.IsSpectating()) then
_v317, target = _v189((_V9({140,79,186,27,82,171})), _v6.Update, _v6, _v9.Camera, _v9.Debug)
end
if not _v317 then
target = nil
end
if _v9.UI.TargetDisplay then
_v189((_V9({153,71,165,30,88,171,79,251,8,190,86,187,24,68})), function()
local _v250 = _v6:GetLookTarget(_v9.ESP, _v9.Camera)
UI:SetCurrentTarget(_v250 and _v250.Name or nil)
end)
end
_v52 = _v9.Camera.Enabled and target ~= nil
_v189((_V9({131,73,132,9,79,186,14,251})), NoSpread.Update, NoSpread, _v9.NoSpread)
_v189((_V9({153,84,190,30,90,186,29,253,14,185})), Triggerbot.Update, Triggerbot, _v9.Triggerbot, _v9.Camera)
_v189((_V9({128,73,161,28,80,186,1,235})), Movement.Update, Movement, _v150, _v9.Movement)
_v189((_V9({133,79,163,27,82,167})), _v18.Update, _v18, _v9.Hitbox, _v9.Camera)
_v189((_V9({137,84,182,14,84,177,8,191,36,158,118})), _v13.Update, _v13, _v9.Drawing, _v9.Camera)
_v189((_V9({155,79,164,12,92,179,28})), Visuals.Update, Visuals, _v9.Visuals)
_v176 = _v176 + _v150
fpsFrames = fpsFrames + 1
if _v176 >= 0.25 then
local _v175 = math.floor(fpsFrames / _v176 + 0.5)
_v176, fpsFrames = 0, 0
if _v9.UI.FPSCounter then
_v189((_V9({139,118,132,89,94,176,26,241,21,168,84})), UI.UpdateFPS, UI, _v175)
end
end
end))
pcall(function()
_v29:UnbindFromRenderStep(_v25)
end)
pcall(function()
_v29:BindToRenderStep(_v25, Enum.RenderPriority.Camera.Value + 1, function()
_v189((_V9({131,73,133,28,94,176,6,243})), NoRecoil.Update, NoRecoil, _v9.NoRecoil, _v52)
end)
end)
end)
if not _v315 then
warn((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,39,172,79,187,28,89,255,27,240,65,190,82,182,11,73,229})), err)
_v10.Stop()
return _v10
end
if getgenv then
getgenv().VanityGeneral = _v10
end
UI:Notify(string.format((_V9({155,71,185,16,73,166,66,216,4,163,67,165,24,81,255,3,240,0,169,67,179,89,29,61,239,61,65,237,118,165,28,78,172,79,186,18})), _v9.UI.MenuKey.Name), 4)
print(string.format((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,51,184,72,185,16,83,184,79,183,23,232,85,254})), _v10.Version))
print(string.format((_V9({128,67,185,12,7,255,74,236,65,237,90,247,89,126,190,2,250,19,172,28,247,92,78,255,79,227,65,237,115,185,21,82,190,11,165,65,232,85})),
_v9.UI.MenuKey.Name,
_v9.Camera.ToggleKey.Name,
_v9.UI.UnloadKey.Name))
if _v38.HasWebhook() then
task.spawn(function()
_v38.SendLoadedEmbed(false)
end)
end
return _v10
end
function _v10.Stop()
if not _v387 then
return _v10
end
_v387 = false
for _, _v111 in ipairs(_v112) do
pcall(function()
_v111:Disconnect()
end)
end
table.clear(_v112)
pcall(function()
_v29:UnbindFromRenderStep(_v25)
end)
_v52 = false
pcall(function()
ESP:Cleanup()
end)
pcall(function()
UI:Cleanup()
end)
pcall(function()
_v6:Cleanup()
end)
pcall(function()
Movement:Cleanup()
end)
pcall(function()
_v18:Cleanup()
end)
pcall(function()
_v13:Cleanup()
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
table.clear(_v188)
print((_V9({150,112,182,23,84,171,22,178,38,168,72,178,11,92,179,50,191,50,185,73,167,9,88,187})))
return _v10
end
function _v10.Toggle()
if _v387 then
_v10.Stop()
else
_v10.Start()
end
return _v10
end
_v10.start = _v10.Start
_v10.stop = _v10.Stop
_v10.toggle = _v10.Toggle
return _v10
end)()
do
local _v10 = _v10
if getgenv then
local _v359 = getgenv().VanityGeneral
if _v359 and _v359 ~= _v10 and type(_v359.Stop) == (_V9({171,83,185,26,73,182,0,241})) then
pcall(_v359.Stop)
end
end
pcall(function()
_v10.Start()
end)
return _v10
end
