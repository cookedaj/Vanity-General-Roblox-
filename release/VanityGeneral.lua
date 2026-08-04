local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({221,98,125,165,184,114,233,61,117})
local _v9
local _v8
local Utility
local _v7
local _v6
local ESP
local _v13
local Visuals
local _v40
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
Hitbox = (_V9({143,3,19,193,215,31,201,21,34,184,11,26,205,204,23,141,20})),
HitboxOptions = { (_V9({143,3,19,193,215,31,201,21,34,184,11,26,205,204,23,141,20})), (_V9({149,7,28,193})), (_V9({137,13,15,214,215})), (_V9({156,16,16,214})), (_V9({145,7,26,214})) },
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
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
WatermarkImageId = (_V9({236,81,68,157,140,71,223,4,70,229,87,69,157,141,68})),
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
Hitbox = (_V9({143,3,19,193,215,31,201,21,34,184,11,26,205,204,23,141,20})),
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
function _v9.reset()
for _v381, _v460 in pairs(_v11) do
for _v223, value in pairs(_v460) do
if type(value) == (_V9({169,3,31,201,221})) then
local target = _v9[_v381][_v223]
if type(target) ~= (_V9({169,3,31,201,221})) then
target = {}
_v9[_v381][_v223] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v9[_v381][_v223] = value
end
end
end
end
return _v9
end)()
_v8 = (function()
local _v8 = {}
local _v5 = (_V9({139,3,19,204,204,11,174,88,27,184,16,28,201}))
local _v32 = { (_V9({158,3,16,192,202,19})), (_V9({152,49,45})), (_V9({147,13,47,192,219,29,128,81})), (_V9({147,13,46,213,202,23,136,89})), (_V9({144,13,11,192,213,23,135,73})), (_V9({142,11,17,192,214,6,168,84,24})), (_V9({149,11,9,199,215,10})), (_V9({153,16,28,210,209,28,142})), (_V9({139,11,14,208,217,30,154})), (_V9({136,22,20,201,209,6,144})), (_V9({136,43})) }
local function _v175()
return type(writefile) == (_V9({187,23,19,198,204,27,134,83}))
and type(readfile) == (_V9({187,23,19,198,204,27,134,83}))
and type(listfiles) == (_V9({187,23,19,198,204,27,134,83}))
end
local function _v150()
if type(isfolder) == (_V9({187,23,19,198,204,27,134,83})) and type(makefolder) == (_V9({187,23,19,198,204,27,134,83})) then
if not isfolder(_v5) then
pcall(makefolder, _v5)
end
end
end
local function _v376(name)
return (tostring(name or (_V9({}))):gsub((_V9({134,60,88,210,231,87,196,29,40})), (_V9({}))):gsub((_V9({131,71,14,142})), (_V9({}))):gsub((_V9({248,17,86,129})), (_V9({}))))
end
local function _v331(name)
return _v5 .. (_V9({242,18,15,202,222,27,133,88,42})) .. game.PlaceId .. (_V9({130})) .. name .. (_V9({243,8,14,202,214}))
end
local function _v234(name)
return _v5 .. (_V9({242})) .. name .. (_V9({243,8,14,202,214}))
end
local function _v149(v)
local t = typeof(v)
if t == (_V9({158,13,17,202,202,65})) then
return { __t = (_V9({158,13,17,202,202,65})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({152,12,8,200,241,6,140,80})) then
return { __t = (_V9({152,12,8,200})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({169,3,31,201,221})) then
local _v326 = {}
for k, _v457 in pairs(v) do
if type(_v457) ~= (_V9({187,23,19,198,204,27,134,83})) then
local _v148 = _v149(_v457)
if _v148 ~= nil then
_v326[k] = _v148
end
end
end
return _v326
elseif t == (_V9({179,23,16,199,221,0})) or t == (_V9({174,22,15,204,214,21})) or t == (_V9({191,13,18,201,221,19,135})) then
return v
end
return nil
end
local function _v122(v)
if type(v) ~= (_V9({169,3,31,201,221})) then
return v
end
if v.__t == (_V9({158,13,17,202,202,65})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({152,12,8,200})) then
local _v303, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v303 then
return item
end
return nil
end
return v
end
local function _v59(target, _v399)
for k, v in pairs(_v399) do
if type(v) == (_V9({169,3,31,201,221})) and v.__t == nil then
if type(target[k]) == (_V9({169,3,31,201,221})) then
_v59(target[k], v)
end
else
local _v123 = _v122(v)
if _v123 ~= nil then
target[k] = _v123
end
end
end
end
function _v8.isSupported()
return _v175()
end
function _v8.list()
local _v326 = {}
if not _v175() then
return _v326
end
_v150()
local _v303, files = pcall(listfiles, _v5)
if not _v303 or type(files) ~= (_V9({169,3,31,201,221})) then
return _v326
end
for _, _v330 in ipairs(files) do
local _v342 = (_V9({173,16,18,195,209,30,140,98})) .. game.PlaceId .. (_V9({130}))
local name = tostring(_v330):match((_V9({245,57,35,138,228,47,194,20,80,243,8,14,202,214,86})))
if name and name:sub(1, #_v342) == _v342 then
table.insert(_v326, name:sub(#_v342 + 1))
end
end
table.sort(_v326)
return _v326
end
function _v8.save(name, _v104)
if not _v175() then
return false, (_V9({137,10,20,214,152,23,145,88,22,168,22,18,215,152,26,136,78,85,179,13,93,195,209,30,140,29,52,141,43}))
end
name = _v376(name)
if name == (_V9({})) then
return false, (_V9({152,12,9,192,202,82,136,29,22,178,12,27,204,223,82,135,92,24,184}))
end
_v150()
local data = {}
for _, _v381 in ipairs(_v32) do
if type(_v104[_v381]) == (_V9({169,3,31,201,221})) then
data[_v381] = _v149(_v104[_v381])
end
end
local _v307, json = pcall(function()
return game:GetService((_V9({149,22,9,213,235,23,155,75,28,190,7}))):JSONEncode(data)
end)
if not _v307 then
return false, (_V9({152,12,30,202,220,23,201,91,20,180,14,24,193,130,82})) .. tostring(json)
end
local _v310, err = pcall(writefile, _v331(name), json)
if not _v310 then
return false, (_V9({138,16,20,209,221,82,143,92,28,177,7,25,159,152})) .. tostring(err)
end
return true, name
end
function _v8.load(name, _v104)
if not _v175() then
return false, (_V9({137,10,20,214,152,23,145,88,22,168,22,18,215,152,26,136,78,85,179,13,93,195,209,30,140,29,52,141,43}))
end
name = _v376(name)
if name == (_V9({})) then
return false, (_V9({152,12,9,192,202,82,136,29,22,178,12,27,204,223,82,135,92,24,184}))
end
local _v330 = _v331(name)
if type(isfile) == (_V9({187,23,19,198,204,27,134,83})) then
local _v306, exists = pcall(isfile, _v330)
if _v306 and not exists then
local _v233 = _v234(name)
local _v308, legacyExists = pcall(isfile, _v233)
if _v308 and legacyExists then
_v330 = _v233
else
return false, (_V9({147,13,93,198,215,28,143,84,18,253,12,28,200,221,22,201,26})) .. name .. (_V9({250}))
end
end
end
local _v309, raw = pcall(readfile, _v330)
if not _v309 or type(raw) ~= (_V9({174,22,15,204,214,21})) then
return false, (_V9({143,7,28,193,152,20,136,84,25,184,6}))
end
local _v307, data = pcall(function()
return game:GetService((_V9({149,22,9,213,235,23,155,75,28,190,7}))):JSONDecode(raw)
end)
if not _v307 or type(data) ~= (_V9({169,3,31,201,221})) then
return false, (_V9({137,10,28,209,152,20,128,81,16,253,11,14,203,159,6,201,75,20,177,11,25,133,242,33,166,115}))
end
for _, _v381 in ipairs(_v32) do
if type(data[_v381]) == (_V9({169,3,31,201,221})) and type(_v104[_v381]) == (_V9({169,3,31,201,221})) then
_v59(_v104[_v381], data[_v381])
end
end
return true, name
end
function _v8.delete(name)
name = _v376(name)
if name == (_V9({})) then
return false, (_V9({152,12,9,192,202,82,136,29,22,178,12,27,204,223,82,135,92,24,184}))
end
if type(delfile) ~= (_V9({187,23,19,198,204,27,134,83})) then
return false, (_V9({137,10,20,214,152,23,145,88,22,168,22,18,215,152,17,136,83,82,169,66,25,192,212,23,157,88,85,187,11,17,192,203}))
end
local _v303, err = pcall(delfile, _v331(name))
if not _v303 then
return false, tostring(err)
end
return true, name
end
return _v8
end)()
Utility = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v36 = game:GetService((_V9({137,7,17,192,200,29,155,73,38,184,16,11,204,219,23})))
local _v22 = _v26.LocalPlayer
local Utility = {}
local _v36 = game:GetService((_V9({137,7,17,192,200,29,155,73,38,184,16,11,204,219,23})))
local _v456
function Utility:Init(_v104)
if _v456 then
return
end
local _v474 = (type(VirtualUser) ~= (_V9({179,11,17})) and VirtualUser) or nil
if not _v474 then
pcall(function()
_v474 = game:GetService((_V9({139,11,15,209,205,19,133,104,6,184,16})))
end)
end
if not _v474 then
return
end
_v456 = _v22.Idled:Connect(function()
if _v104.AntiAFK then
_v474:CaptureController()
_v474:ClickButton2(Vector2.new())
end
end)
end
function Utility:Cleanup()
if _v456 then
_v456:Disconnect()
_v456 = nil
end
end
function Utility:ServerHop()
local _v303, err = pcall(function()
_v36:Teleport(game.PlaceId, _v22)
end)
if not _v303 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,38,184,16,11,192,202,82,129,82,5,253,4,28,204,212,23,141,7})), err)
end
return _v303
end
function Utility:Rejoin()
local _v303, err = pcall(function()
_v36:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v22)
end)
if not _v303 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,39,184,8,18,204,214,82,143,92,28,177,7,25,159})), err)
end
return _v303
end
function Utility.getGuiParent()
local _v303, hidden = pcall(function()
return gethui and gethui()
end)
if _v303 and hidden then
return hidden
end
local _v304, coreGui = pcall(function()
return game:GetService((_V9({158,13,15,192,255,7,128})))
end)
if _v304 and coreGui then
return coreGui
end
return _v22:WaitForChild((_V9({141,14,28,220,221,0,174,72,28})))
end
return Utility
end)()
_v7 = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v41 = game:GetService((_V9({138,13,15,206,203,2,136,94,16})))
local _v22 = _v26.LocalPlayer
local _v7 = {}
_v7.LocalRootPos = nil
local frame = {}
local _v3 = 0.5
local _v68 = {}
local _v69 = -math.huge
function _v7.GetBotCharacters()
local _v287 = os.clock()
if _v287 - _v69 < _v3 then
return _v68
end
_v69 = _v287
table.clear(_v68)
for _, _v125 in ipairs(_v41:GetDescendants()) do
if _v125:IsA((_V9({144,13,25,192,212})))
and _v125:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
and not _v26:GetPlayerFromCharacter(_v125)
then
table.insert(_v68, _v125)
end
end
return _v68
end
local function _v369(_v96, humanoid)
return humanoid.RootPart
or _v96:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
or _v96:FindFirstChild((_V9({137,13,15,214,215})))
or _v96:FindFirstChild((_V9({136,18,13,192,202,38,134,79,6,178})))
or _v96.PrimaryPart
end
local _v29 = {
Head = { (_V9({149,7,28,193})) },
Torso = { (_V9({136,18,13,192,202,38,134,79,6,178})), (_V9({145,13,10,192,202,38,134,79,6,178})), (_V9({137,13,15,214,215})), (_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})) },
Arms = {
(_V9({145,7,27,209,240,19,135,89})), (_V9({143,11,26,205,204,58,136,83,17})),
(_V9({145,7,27,209,244,29,158,88,7,156,16,16})), (_V9({143,11,26,205,204,62,134,74,16,175,35,15,200})),
(_V9({145,7,27,209,237,2,153,88,7,156,16,16})), (_V9({143,11,26,205,204,39,153,77,16,175,35,15,200})),
(_V9({145,7,27,209,152,51,155,80})), (_V9({143,11,26,205,204,82,168,79,24})),
},
Legs = {
(_V9({145,7,27,209,254,29,134,73})), (_V9({143,11,26,205,204,52,134,82,1})),
(_V9({145,7,27,209,244,29,158,88,7,145,7,26})), (_V9({143,11,26,205,204,62,134,74,16,175,46,24,194})),
(_V9({145,7,27,209,237,2,153,88,7,145,7,26})), (_V9({143,11,26,205,204,39,153,77,16,175,46,24,194})),
(_V9({145,7,27,209,152,62,140,90})), (_V9({143,11,26,205,204,82,165,88,18})),
},
}
local _v28 = { (_V9({149,7,28,193})), (_V9({137,13,15,214,215})), (_V9({156,16,16,214})), (_V9({145,7,26,214})) }
local function _v334(_v96, _v353)
local _v283 = _v29[_v353]
if not _v283 then
return nil
end
for _, name in ipairs(_v283) do
local _v329 = _v96:FindFirstChild(name)
if _v329 and _v329:IsA((_V9({159,3,14,192,232,19,155,73}))) then
return _v329
end
end
return nil
end
local function _v333(_v96)
for _, _v353 in ipairs(_v28) do
local _v329 = _v334(_v96, _v353)
if _v329 then
return _v329
end
end
for _, _v125 in ipairs(_v96:GetDescendants()) do
if _v125:IsA((_V9({159,3,14,192,232,19,155,73}))) then
return _v125
end
end
return nil
end
local function _v56(_v96, _v191, hrp)
return _v191
or hrp
or _v96:FindFirstChild((_V9({136,18,13,192,202,38,134,79,6,178})))
or _v96:FindFirstChild((_V9({137,13,15,214,215})))
or _v333(_v96)
end
local function _v74(_v96, _v338, _v81, _v82)
local humanoid = _v96 and _v96:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v191 = _v96:FindFirstChild((_V9({149,7,28,193})))
local hrp = _v96:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
local _v368 = _v369(_v96, humanoid)
local _v55 = _v56(_v96, _v191, hrp)
local _v153 = {
Player = _v338,
Character = _v96,
Humanoid = humanoid,
Head = _v191,
RootPart = _v368,
HRP = hrp,
Anchor = _v55,
}
if _v55 then
_v153.WorldDistance = (_v55.Position - _v82).Magnitude
local _v407, vis = _v81:WorldToViewportPoint(_v55.Position)
_v153.AnchorScreen = _v407
_v153.AnchorOnScreen = vis
end
if _v368 then
local _v439 = _v191 and (_v191.Position + Vector3.new(0, _v191.Size.Y, 0))
or (_v368.Position + Vector3.new(0, 3, 0))
local _v444, tvis = _v81:WorldToViewportPoint(_v439)
_v153.TopScreen = _v444
_v153.TopOnScreen = tvis
_v153.BotScreen = _v81:WorldToViewportPoint(_v368.Position - Vector3.new(0, 3.2, 0))
end
return _v153
end
function _v7:Update(_v83, _v155)
table.clear(frame)
local _v81 = _v41.CurrentCamera
local _v278 = _v22.Character
local _v279 = _v278 and _v278:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
_v7.LocalRootPos = _v279 and _v279.Position or nil
if not _v81 then
return
end
local _v82 = _v81.CFrame.Position
for _, _v338 in ipairs(_v26:GetPlayers()) do
if _v338 ~= _v22 then
local _v153 = _v74(_v338.Character, _v338, _v81, _v82)
if _v153 then
table.insert(frame, _v153)
end
end
end
if _v83 and _v83.TargetBots then
for _, _v96 in ipairs(_v7.GetBotCharacters()) do
local _v153 = _v74(_v96, nil, _v81, _v82)
if _v153 then
table.insert(frame, _v153)
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
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v41 = game:GetService((_V9({138,13,15,206,203,2,136,94,16})))
local _v22 = _v26.LocalPlayer
local Utility = Utility
local _v7 = _v7
local _v6 = {}
local Camera = _v41.CurrentCamera
local _v91 = Random.new()
local _v29 = {
Head = { (_V9({149,7,28,193})) },
Torso = { (_V9({136,18,13,192,202,38,134,79,6,178})), (_V9({145,13,10,192,202,38,134,79,6,178})), (_V9({137,13,15,214,215})), (_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})) },
Arms = {
(_V9({145,7,27,209,240,19,135,89})), (_V9({143,11,26,205,204,58,136,83,17})),
(_V9({145,7,27,209,244,29,158,88,7,156,16,16})), (_V9({143,11,26,205,204,62,134,74,16,175,35,15,200})),
(_V9({145,7,27,209,237,2,153,88,7,156,16,16})), (_V9({143,11,26,205,204,39,153,77,16,175,35,15,200})),
(_V9({145,7,27,209,152,51,155,80})), (_V9({143,11,26,205,204,82,168,79,24})),
},
Legs = {
(_V9({145,7,27,209,254,29,134,73})), (_V9({143,11,26,205,204,52,134,82,1})),
(_V9({145,7,27,209,244,29,158,88,7,145,7,26})), (_V9({143,11,26,205,204,62,134,74,16,175,46,24,194})),
(_V9({145,7,27,209,237,2,153,88,7,145,7,26})), (_V9({143,11,26,205,204,39,153,77,16,175,46,24,194})),
(_V9({145,7,27,209,152,62,140,90})), (_V9({143,11,26,205,204,82,165,88,18})),
},
}
local _v28 = { (_V9({149,7,28,193})), (_V9({137,13,15,214,215})), (_V9({156,16,16,214})), (_V9({145,7,26,214})) }
local _v365 = Random.new()
local function _v334(_v96, _v353)
local _v283 = _v29[_v353]
if not _v283 then
return nil
end
for _, name in ipairs(_v283) do
local _v329 = _v96:FindFirstChild(name)
if _v329 and _v329:IsA((_V9({159,3,14,192,232,19,155,73}))) then
return _v329
end
end
return nil
end
local function _v333(_v96)
for _, _v353 in ipairs(_v28) do
local _v329 = _v334(_v96, _v353)
if _v329 then
return _v329
end
end
for _, _v125 in ipairs(_v96:GetDescendants()) do
if _v125:IsA((_V9({159,3,14,192,232,19,155,73}))) then
return _v125
end
end
return nil
end
local function _v57(_v96)
return _v96:FindFirstChild((_V9({149,7,28,193})))
or _v96:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
or _v96:FindFirstChild((_V9({136,18,13,192,202,38,134,79,6,178})))
or _v96:FindFirstChild((_V9({137,13,15,214,215})))
or _v333(_v96)
end
local function _v367(_v477)
local _v440 = 0
for _, _v353 in ipairs(_v28) do
_v440 = _v440 + math.max(0, (_v477 and _v477[_v353]) or 0)
end
if _v440 <= 0 then
return (_V9({149,7,28,193}))
end
local _v366 = _v365:NextNumber() * _v440
local _v42 = 0
for _, _v353 in ipairs(_v28) do
_v42 = _v42 + math.max(0, _v477[_v353] or 0)
if _v366 <= _v42 then
return _v353
end
end
return (_V9({149,7,28,193}))
end
local function _v181(_v483)
local _v463, visible = Camera:WorldToViewportPoint(_v483)
if not visible or _v463.Z < 0 then
return math.huge
end
local _v379 = Vector2.new(_v463.X, _v463.Y)
local _v92 = Camera.ViewportSize / 2
return (_v379 - _v92).Magnitude
end
local function _v222(_v341, _v96)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v22.Character }
local _v363 = _v41:Raycast(Camera.CFrame.Position, _v341 - Camera.CFrame.Position, params)
return not _v363 or _v363.Instance:IsDescendantOf(_v96)
end
local _v15 = Color3.fromRGB(132, 62, 190)
local _v168, _v169, fovStroke
local function _v151()
if _v169 and _v169.Parent then
return _v169
end
_v168 = Instance.new((_V9({142,1,15,192,221,28,174,72,28})))
_v168.Name = (_V9({139,3,19,204,204,11,174,88,27,184,16,28,201,254,61,191}))
_v168.ResetOnSpawn = false
_v168.IgnoreGuiInset = true
_v168.DisplayOrder = 998
local _v303 = pcall(function()
_v168.Parent = Utility.getGuiParent()
end)
if not _v303 or not _v168.Parent then
_v168.Parent = _v22:WaitForChild((_V9({141,14,28,220,221,0,174,72,28})))
end
_v169 = Instance.new((_V9({155,16,28,200,221})))
_v169.Name = (_V9({143,11,19,194}))
_v169.AnchorPoint = Vector2.new(0.5, 0.5)
_v169.Position = UDim2.fromScale(0.5, 0.5)
_v169.BackgroundTransparency = 1
_v169.BorderSizePixel = 0
_v169.Parent = _v168
local _v110 = Instance.new((_V9({136,43,62,202,202,28,140,79})))
_v110.CornerRadius = UDim.new(1, 0)
_v110.Parent = _v169
fovStroke = Instance.new((_V9({136,43,46,209,202,29,130,88})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v15
fovStroke.Parent = _v169
return _v169
end
local function _v451(_v104)
local _v390 = _v104.FOVCircle
if not _v390 then
if _v169 then
_v169.Visible = false
end
return
end
local _v364 = _v151()
if not _v364 then
return
end
local _v129 = math.max(0, _v104.FOV or 0) * 2
_v364.Size = UDim2.fromOffset(_v129, _v129)
_v364.Visible = true
end
local function _v128()
if _v168 then
pcall(function()
_v168:Destroy()
end)
end
_v168, _v169, fovStroke = nil, nil, nil
end
local function _v158(_v96, _v338, _v104)
if not _v96 then
return nil
end
if _v104.TeamCheck and _v338 and _v338.Team ~= nil and _v338.Team == _v22.Team then
return nil
end
local humanoid = _v96:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v55 = _v57(_v96)
if not _v55 then
return nil
end
local _v135 = _v181(_v55.Position)
if _v135 >= (_v104.FOV or 200) then
return nil
end
local _v482 = (_v55.Position - Camera.CFrame.Position).Magnitude
if _v482 > _v104.MaxDistance then
return nil
end
if _v104.WallCheck and not _v222(_v55.Position, _v96) then
return nil
end
return { Player = _v338, Character = _v96, Anchor = _v55, ScreenDistance = _v135 }
end
local function _v380(_v85)
if not _v85.AnchorOnScreen or _v85.AnchorScreen.Z < 0 then
return math.huge
end
local _v379 = Vector2.new(_v85.AnchorScreen.X, _v85.AnchorScreen.Y)
local _v92 = Camera.ViewportSize / 2
return (_v379 - _v92).Magnitude
end
local function _v157(_v85, _v104)
local _v338 = _v85.Player
if _v104.TeamCheck and _v338 and _v338.Team ~= nil and _v338.Team == _v22.Team then
return nil
end
local _v55 = _v85.Anchor
if not _v55 then
return nil
end
local _v135 = _v380(_v85)
if _v135 >= (_v104.FOV or 200) then
return nil
end
if (_v85.WorldDistance or math.huge) > _v104.MaxDistance then
return nil
end
if _v104.WallCheck and not _v222(_v55.Position, _v85.Character) then
return nil
end
return { Player = _v338, Character = _v85.Character, Anchor = _v55, ScreenDistance = _v135 }
end
function _v6:FindBestTarget(_v104)
local _v65
local _v66 = math.huge
for _, _v85 in ipairs(_v7:Get()) do
local _v86 = _v157(_v85, _v104)
if _v86 and _v86.ScreenDistance < _v66 then
_v66 = _v86.ScreenDistance
_v65 = _v86
end
end
return _v65
end
local _v20 = 50
function _v6:GetLookTarget(_v155, _v83)
local _v65
local _v66 = _v20
local _v280 = _v7.LocalRootPos
local _v261 = (_v155 and _v155.MaxDistance) or math.huge
local _v433 = _v83 and _v83.TeamCheck
for _, _v85 in ipairs(_v7:Get()) do
local _v338 = _v85.Player
if not (_v433 and _v338 and _v338.Team ~= nil and _v338.Team == _v22.Team) then
local _v55 = _v85.Anchor
if _v55 and not (_v280 and (_v55.Position - _v280).Magnitude > _v261) then
local _v135 = _v380(_v85)
if _v135 <= _v66 then
_v66 = _v135
_v65 = _v338 or _v85.Character
end
end
end
end
return _v65
end
function _v6:_resolveRegion(_v96, _v104)
local _v266 = _v104.Hitbox
if _v266 and _v266 ~= (_V9({143,3,19,193,215,31,201,21,34,184,11,26,205,204,23,141,20})) and _v29[_v266] then
return _v266
end
if self._lockedChar ~= _v96 then
self._lockedChar = _v96
self._rolledRegion = _v367(_v104.TargetWeights)
end
return self._rolledRegion or (_V9({149,7,28,193}))
end
function _v6:PointCamera(_v423, _v395)
local _v126 = CFrame.lookAt(Camera.CFrame.Position, _v423)
local _v54 = math.clamp(1 - (_v395 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v126, _v54)
end
function _v6:Update(_v104, debug)
Camera = _v41.CurrentCamera
_v451(_v104)
if not _v104.Enabled then
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
if _v104.StickyTarget and self._stickyCharacter then
if not self._stickyPlayer or self._stickyPlayer.Parent == _v26 then
target = _v158(self._stickyCharacter, self._stickyPlayer, _v104)
end
end
if not target then
target = self:FindBestTarget(_v104)
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
local _v353 = self:_resolveRegion(target.Character, _v104)
local _v50 = _v334(target.Character, _v353) or _v333(target.Character)
if not _v50 then
self._currentTarget = nil
return
end
local _v51 = _v50.Position
local _v482 = (_v51 - Camera.CFrame.Position).Magnitude
if (_v104.Prediction or 0) > 0 then
_v51 = _v51 + _v50.AssemblyLinearVelocity * _v104.Prediction * (_v482 / 500)
end
local _v395 = _v104.Smoothness
if _v104.Humanize then
_v395 = _v395 * (0.9 + _v91:NextNumber() * 0.2)
_v51 = _v51 + _v91:NextUnitVector() * (_v482 * math.rad(_v91:NextNumber() * 0.25))
end
self:PointCamera(_v51, _v395)
target.Part = _v50
target.Region = _v353
self._currentTarget = target
if debug then
print((_V9({137,16,28,198,211,27,135,90,79})), target.Character.Name, (_V9({143,7,26,204,215,28,211})), _v353, (_V9({153,11,14,209,217,28,138,88,79})), math.floor(target.ScreenDistance))
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
_v128()
end
_v6.GetBotCharacters = _v7.GetBotCharacters
return _v6
end)()
ESP = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v41 = game:GetService((_V9({138,13,15,206,203,2,136,94,16})))
local _v22 = _v26.LocalPlayer
local _v9 = _v9
local Utility = Utility
local _v7 = _v7
local ESP = {}
local _v152 = {}
local _v109
local _v71
local _v12 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v216(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v156(_v96)
local _v208 = _v96:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
return (_v208 and _v208.RootPart)
or _v96:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
or _v96:FindFirstChild((_V9({137,13,15,214,215})))
or _v96:FindFirstChild((_V9({136,18,13,192,202,38,134,79,6,178})))
or _v96.PrimaryPart
end
local function _v178()
if _v71 and _v71.Parent then
return _v71
end
_v71 = Instance.new((_V9({142,1,15,192,221,28,174,72,28})))
_v71.Name = (_V9({139,3,19,204,204,11,174,88,27,184,16,28,201,250,29,145,88,6}))
_v71.ResetOnSpawn = false
_v71.IgnoreGuiInset = true
_v71.DisplayOrder = 996
local _v303 = pcall(function()
_v71.Parent = Utility.getGuiParent()
end)
if not _v303 or not _v71.Parent then
_v71.Parent = _v22:WaitForChild((_V9({141,14,28,220,221,0,174,72,28})))
end
return _v71
end
local function _v450(_v153, _v96, _v104, _v85)
local _v81 = _v41.CurrentCamera
local root = _v85 and _v85.RootPart or _v156(_v96)
if not _v81 or not root or not _v153.box then
if _v153.box then
_v153.box.Visible = false
end
return
end
local _v438, onScreen, botV
if _v85 then
if not _v85.TopScreen then
_v153.box.Visible = false
return
end
_v438, onScreen, botV = _v85.TopScreen, _v85.TopOnScreen, _v85.BotScreen
else
local _v191 = _v96:FindFirstChild((_V9({149,7,28,193})))
local _v439 = _v191 and (_v191.Position + Vector3.new(0, _v191.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v70 = root.Position - Vector3.new(0, 3.2, 0)
_v438, onScreen = _v81:WorldToViewportPoint(_v439)
botV = _v81:WorldToViewportPoint(_v70)
end
if not onScreen or _v438.Z <= 0 then
_v153.box.Visible = false
return
end
local _v195 = math.abs(botV.Y - _v438.Y)
local _v478 = _v195 * 0.62
local _v112 = (_v438.X + botV.X) * 0.5
local _v113 = (_v438.Y + botV.Y) * 0.5
_v153.box.Size = UDim2.fromOffset(_v478, _v195)
_v153.box.Position = UDim2.fromOffset(_v112 - _v478 * 0.5, _v113 - _v195 * 0.5)
_v153.box.BackgroundColor3 = _v104.FillColor
_v153.box.BackgroundTransparency = _v104.Filled and (1 - _v104.FillOpacity) or 1
_v153.boxStroke.Color = _v104.OutlineColor
_v153.boxStroke.Transparency = 1 - _v104.OutlineOpacity
_v153.box.Visible = true
end
local function _v252(_v153, name, _v191, _v104)
local _v420 = Instance.new((_V9({159,11,17,201,218,29,136,79,17,154,23,20})))
_v420.Name = (_V9({139,37,52,203,222,29}))
_v420.Size = UDim2.fromOffset(200, 46)
_v420.StudsOffset = Vector3.new(0, 2.7, 0)
_v420.AlwaysOnTop = true
_v420.Adornee = _v191
_v420.Parent = _v191
local _v201 = Instance.new((_V9({155,16,28,200,221})))
_v201.BackgroundTransparency = 1
_v201.Size = UDim2.fromScale(1, 1)
_v201.Parent = _v420
local _v230 = Instance.new((_V9({136,43,49,204,203,6,165,92,12,178,23,9})))
_v230.SortOrder = Enum.SortOrder.LayoutOrder
_v230.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v230.VerticalAlignment = Enum.VerticalAlignment.Center
_v230.Parent = _v201
local _v282 = Instance.new((_V9({137,7,5,209,244,19,139,88,25})))
_v282.LayoutOrder = 1
_v282.BackgroundTransparency = 1
_v282.Size = UDim2.new(1, 0, 0, 16)
_v282.Font = Enum.Font.GothamBold
_v282.TextSize = 13
_v282.TextColor3 = _v104.OutlineColor
_v282.TextStrokeTransparency = 0.35
_v282.Text = name
_v282.Visible = false
_v282.Parent = _v201
local _v134 = Instance.new((_V9({137,7,5,209,244,19,139,88,25})))
_v134.LayoutOrder = 2
_v134.BackgroundTransparency = 1
_v134.Size = UDim2.new(1, 0, 0, 14)
_v134.Font = Enum.Font.Gotham
_v134.TextSize = 12
_v134.TextColor3 = _v104.OutlineColor
_v134.TextStrokeTransparency = 0.4
_v134.Text = (_V9({}))
_v134.Visible = false
_v134.Parent = _v201
local _v193 = Instance.new((_V9({155,16,28,200,221})))
_v193.LayoutOrder = 3
_v193.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v193.BackgroundTransparency = 0.3
_v193.BorderSizePixel = 0
_v193.Size = UDim2.new(0.55, 0, 0, 5)
_v193.Visible = false
_v193.Parent = _v201
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v193, CornerRadius = UDim.new(1, 0) })
local _v194 = Instance.new((_V9({155,16,28,200,221})))
_v194.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v194.BorderSizePixel = 0
_v194.Size = UDim2.fromScale(1, 1)
_v194.Parent = _v193
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v194, CornerRadius = UDim.new(1, 0) })
_v153.nameTag = _v420
_v153.nameLabel = _v282
_v153.distanceLabel = _v134
_v153.healthBack = _v193
_v153.healthFill = _v194
_v153.nameHead = _v191
end
local function _v452(name, _v153, _v96, _v104, _v85)
local _v191 = _v85 and (_v85.Head or _v85.HRP)
or _v96:FindFirstChild((_V9({149,7,28,193})))
or _v96:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
if not _v191 then
if _v153.nameTag then
_v153.nameTag.Enabled = false
end
return
end
if not _v153.nameTag or not _v153.nameTag.Parent or _v153.nameHead ~= _v191 then
if _v153.nameTag then
pcall(function()
_v153.nameTag:Destroy()
end)
end
_v252(_v153, name, _v191, _v104)
end
_v153.nameLabel.TextColor3 = _v104.OutlineColor
_v153.nameLabel.Visible = _v104.Names or _v104.NameTags
_v153.distanceLabel.Visible = _v104.Distance or _v104.DistanceTags
if _v153.distanceLabel.Visible then
_v153.distanceLabel.TextColor3 = _v104.OutlineColor
local _v280, hrp
if _v85 then
_v280, hrp = _v7.LocalRootPos, _v85.HRP
else
local _v278 = _v22.Character
local _v279 = _v278 and _v278:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
_v280 = _v279 and _v279.Position
hrp = _v96:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
end
local d = (_v280 and hrp) and math.floor((hrp.Position - _v280).Magnitude + 0.5) or 0
_v153.distanceLabel.Text = (_V9({134})) .. d .. (_V9({176,63}))
end
_v153.healthBack.Visible = _v104.HealthBars
if _v104.HealthBars then
local humanoid = _v85 and _v85.Humanoid or _v96:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
local _v173 = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v153.healthFill.Size = UDim2.fromScale(_v173, 1)
_v153.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v173)
end
_v153.nameTag.Enabled = true
end
local function _v198(_v153)
_v153.hl.Enabled = false
if _v153.box then
_v153.box.Visible = false
end
if _v153.nameTag then
_v153.nameTag.Enabled = false
end
end
local function _v357(_v153, _v96, name, _v104, _v85)
if _v104.Outlines then
if _v153.hl.Adornee ~= _v96 then
_v153.hl.Adornee = _v96
end
_v153.hl.OutlineColor = _v104.OutlineColor
_v153.hl.FillColor = _v104.FillColor
_v153.hl.OutlineTransparency = 1 - _v104.OutlineOpacity
_v153.hl.FillTransparency = _v104.Filled and (1 - _v104.FillOpacity) or 1
_v153.hl.DepthMode = _v12
_v153.hl.Enabled = true
else
_v153.hl.Enabled = false
end
if _v104.Boxes then
_v450(_v153, _v96, _v104, _v85)
elseif _v153.box then
_v153.box.Visible = false
end
if _v104.Names or _v104.Distance or _v104.NameTags or _v104.DistanceTags or _v104.HealthBars then
_v452(name, _v153, _v96, _v104, _v85)
elseif _v153.nameTag then
_v153.nameTag.Enabled = false
end
end
local function _v136(_v329)
local _v278 = _v22.Character
local _v279 = _v278 and _v278:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
if not _v279 or not _v329 then
return 0
end
return (_v329.Position - _v279.Position).Magnitude
end
local function _v454(_v85, _v153, _v104)
local hrp = _v85.HRP
if not _v104.Enabled or not hrp then
_v198(_v153)
return
end
local _v280 = _v7.LocalRootPos
local _v133 = _v280 and (hrp.Position - _v280).Magnitude or 0
if _v133 > _v104.MaxDistance then
_v198(_v153)
return
end
_v357(_v153, _v85.Character, _v85.Player.Name, _v104, _v85)
end
local function _v284(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v199 = Instance.new((_V9({149,11,26,205,212,27,142,85,1})))
_v199.Name = (_V9({152,49,45,234,205,6,133,84,27,184}))
_v199.Enabled = false
_v199.FillColor = color
_v199.OutlineColor = color
_v199.Parent = _v109
local box = Instance.new((_V9({155,16,28,200,221})))
box.Name = (_V9({152,49,45,231,215,10}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v178()
local boxStroke = Instance.new((_V9({136,43,46,209,202,29,130,88})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = _v199, box = box, boxStroke = boxStroke }
end
local function _v127(_v153)
if _v153.hl then
_v153.hl:Destroy()
end
if _v153.box then
_v153.box:Destroy()
end
if _v153.nameTag then
pcall(function()
_v153.nameTag:Destroy()
end)
end
end
local function _v48(_v338, _v124)
if _v338 == _v22 or _v152[_v338] then
return
end
_v152[_v338] = _v284(_v124)
end
local function _v356(_v338)
local _v153 = _v152[_v338]
if not _v153 then
return
end
_v127(_v153)
_v152[_v338] = nil
end
local _v288 = {}
local _v229 = 0
local _v23 = 1
local function _v355(_v267)
local _v153 = _v288[_v267]
if not _v153 then
return
end
_v127(_v153)
_v288[_v267] = nil
end
local function _v360()
local current = {}
for _, _v302 in ipairs(_v41:GetDescendants()) do
if _v302:IsA((_V9({149,23,16,196,214,29,128,89}))) then
local _v267 = _v302.Parent
if
_v267
and _v267:IsA((_V9({144,13,25,192,212})))
and _v267 ~= _v22.Character
and not _v26:GetPlayerFromCharacter(_v267)
then
current[_v267] = true
if not _v288[_v267] then
_v288[_v267] = _v284(_v9.ESP.OutlineColor)
end
end
end
end
for _v267 in pairs(_v288) do
if not current[_v267] or not _v267.Parent then
_v355(_v267)
end
end
end
local function _v453(_v267, _v153, _v104)
local root = _v156(_v267)
local humanoid = _v267:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
if not _v267.Parent or not root or not _v216(humanoid) then
_v198(_v153)
return
end
if _v136(root) > _v104.MaxDistance then
_v198(_v153)
return
end
_v357(_v153, _v267, _v267.Name, _v104)
end
function ESP:Init()
if _v109 then
return
end
_v109 = Instance.new((_V9({155,13,17,193,221,0})))
_v109.Name = (_V9({139,3,19,204,204,11,174,88,27,184,16,28,201,253,33,185}))
local _v303 = pcall(function()
_v109.Parent = Utility.getGuiParent()
end)
if not _v303 or not _v109.Parent then
_v109.Parent = _v41
end
for _, _v338 in ipairs(_v26:GetPlayers()) do
_v48(_v338, _v9.ESP.OutlineColor)
end
end
function ESP:Update(_v104)
local _v358 = {}
for _, _v85 in ipairs(_v7:Get()) do
local _v338 = _v85.Player
if _v338 then
_v358[_v338] = true
local _v153 = _v152[_v338]
if not _v153 then
_v48(_v338, _v104.OutlineColor)
_v153 = _v152[_v338]
end
_v454(_v85, _v153, _v104)
end
end
for _v338, _v153 in pairs(_v152) do
if _v338.Parent ~= _v26 then
_v356(_v338)
elseif not _v358[_v338] then
_v198(_v153)
end
end
if _v104.Enabled and _v104.NPCs then
if os.clock() - _v229 >= _v23 then
_v229 = os.clock()
_v360()
end
for _v267, _v153 in pairs(_v288) do
_v453(_v267, _v153, _v104)
end
elseif next(_v288) then
for _v267 in pairs(_v288) do
_v355(_v267)
end
end
end
function ESP:OnPlayerAdded(_v338)
_v48(_v338, _v9.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v338)
_v356(_v338)
end
function ESP:Cleanup()
for _v338 in pairs(_v152) do
_v356(_v338)
end
for _v267 in pairs(_v288) do
_v355(_v267)
end
if _v109 then
_v109:Destroy()
_v109 = nil
end
if _v71 then
_v71:Destroy()
_v71 = nil
end
end
return ESP
end)()
_v13 = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v41 = game:GetService((_V9({138,13,15,206,203,2,136,94,16})))
local _v22 = _v26.LocalPlayer
local _v7 = _v7
local _v13 = {}
local _v114 = type(Drawing) == (_V9({169,3,31,201,221})) and type(Drawing.new) == (_V9({187,23,19,198,204,27,134,83}))
local _v121 = false
local _v115 = {}
local function _v118()
local _v235 = Drawing.new((_V9({145,11,19,192})))
_v235.Thickness = 1
_v235.Visible = false
return _v235
end
local function _v117(_v338)
local _v153 = {
box = { _v118(), _v118(), _v118(), _v118() },
tracer = _v118(),
}
_v115[_v338] = _v153
return _v153
end
local function _v116(_v153)
for _, _v235 in ipairs(_v153.box) do
_v235.Visible = false
end
_v153.tracer.Visible = false
end
local function _v119(_v338)
local _v153 = _v115[_v338]
if not _v153 then
return
end
_v115[_v338] = nil
for _, _v235 in ipairs(_v153.box) do
_v235:Remove()
end
_v153.tracer:Remove()
end
local function _v120(_v85, _v104, _v81, _v83)
local _v338 = _v85.Player
local _v153 = _v115[_v338]
if _v83.TeamCheck and _v338.Team ~= nil and _v338.Team == _v22.Team then
if _v153 then
_v116(_v153)
end
return
end
local root = _v85.HRP
if not (_v104.Boxes or _v104.Tracers) or not root then
if _v153 then
_v116(_v153)
end
return
end
local _v438, onScreen, botV = _v85.TopScreen, _v85.TopOnScreen, _v85.BotScreen
if not _v438 or not onScreen or _v438.Z <= 0 or botV.Z <= 0 then
if _v153 then
_v116(_v153)
end
return
end
_v153 = _v153 or _v117(_v338)
local _v195 = math.abs(botV.Y - _v438.Y)
local _v478 = _v195 * 0.62
local _v112 = (_v438.X + botV.X) * 0.5
local _v232, right = _v112 - _v478 * 0.5, _v112 + _v478 * 0.5
local _v437, bottom = _v438.Y, botV.Y
local box = _v153.box
box[1].From = Vector2.new(_v232, _v437)
box[1].To = Vector2.new(right, _v437)
box[2].From = Vector2.new(_v232, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v232, _v437)
box[3].To = Vector2.new(_v232, bottom)
box[4].From = Vector2.new(right, _v437)
box[4].To = Vector2.new(right, bottom)
for _, _v235 in ipairs(box) do
_v235.Color = _v104.BoxColor
_v235.Visible = _v104.Boxes
end
_v153.tracer.From = Vector2.new(_v81.ViewportSize.X / 2, _v81.ViewportSize.Y)
_v153.tracer.To = Vector2.new(_v112, bottom)
_v153.tracer.Color = _v104.TracerColor
_v153.tracer.Visible = _v104.Tracers
end
function _v13:Update(_v104, _v83)
if not _v114 then
if (_v104.Boxes or _v104.Tracers) and not _v121 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,55,178,26,82,241,202,19,138,88,7,253,39,46,245,152,28,140,88,17,174,66,9,205,221,82,173,79,20,170,11,19,194,152,30,128,95,7,188,16,4,133,90,242,125,29,27,178,22,93,196,206,19,128,81,20,191,14,24,133,209,28,201,73,29,180,17,93,192,192,23,138,72,1,178,16,83})))
_v121 = true
end
return
end
local _v81 = _v41.CurrentCamera
if not _v81 then
return
end
local _v382 = {}
for _, _v85 in ipairs(_v7:Get()) do
if _v85.Player then
_v382[_v85.Player] = true
_v120(_v85, _v104, _v81, _v83)
end
end
for _v338, _v153 in pairs(_v115) do
if _v338.Parent ~= _v26 then
_v119(_v338)
elseif not _v382[_v338] then
_v116(_v153)
end
end
end
function _v13:Cleanup()
for _v338 in pairs(_v115) do
_v119(_v338)
end
end
return _v13
end)()
Visuals = (function()
local _v21 = game:GetService((_V9({145,11,26,205,204,27,135,90})))
local Visuals = {}
local _v21 = game:GetService((_V9({145,11,26,205,204,27,135,90})))
local _v471
local _v468 = false
local _v470 = false
local _v469 = 0
local _v39 = 1
local function _v467()
if _v471 then
return
end
_v471 = {
Brightness = _v21.Brightness,
ClockTime = _v21.ClockTime,
GlobalShadows = _v21.GlobalShadows,
FogEnd = _v21.FogEnd,
FogStart = _v21.FogStart,
Ambient = _v21.Ambient,
OutdoorAmbient = _v21.OutdoorAmbient,
}
end
local function _v465()
_v21.Brightness = 2
_v21.ClockTime = 14
_v21.GlobalShadows = false
end
local function _v466()
_v21.FogEnd = 100000
end
local function _v472()
_v21.Brightness = _v471.Brightness
_v21.ClockTime = _v471.ClockTime
_v21.GlobalShadows = _v471.GlobalShadows
end
local function _v473()
_v21.FogEnd = _v471.FogEnd
_v21.FogStart = _v471.FogStart
end
function Visuals:Update(_v104)
if not (_v104.Fullbright or _v104.NoFog or _v468 or _v470) then
return
end
_v467()
if _v104.Fullbright ~= _v468 then
_v468 = _v104.Fullbright
if _v468 then
_v465()
else
_v472()
end
end
if _v104.NoFog ~= _v470 then
_v470 = _v104.NoFog
if _v470 then
_v466()
else
_v473()
end
end
if (_v468 or _v470) and os.clock() - _v469 >= _v39 then
_v469 = os.clock()
if _v468
and (_v21.Brightness ~= 2 or _v21.ClockTime ~= 14 or _v21.GlobalShadows)
then
_v465()
end
if _v470 and _v21.FogEnd < 100000 then
_v466()
end
end
end
function Visuals:Cleanup()
if _v471 then
if _v468 then
_v472()
end
if _v470 then
_v473()
end
end
_v468 = false
_v470 = false
end
return Visuals
end)()
_v40 = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v22 = _v26.LocalPlayer
local _v9 = _v9
local _v40 = {}
_v40.Version = (_V9({237}))
local function _v361()
local _v87 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v166 in ipairs(_v87) do
if type(_v166) == (_V9({187,23,19,198,204,27,134,83})) then
return _v166
end
end
return nil
end
local function _v362()
local _v455 = _v9.Webhook.Url
if type(_v455) == (_V9({174,22,15,204,214,21})) and _v455 ~= (_V9({})) then
return _v455
end
return nil
end
function _v40.SetWebhook(_v455)
_v9.Webhook.Url = tostring(_v455 or (_V9({})))
return true
end
function _v40.HasWebhook()
return _v362() ~= nil
end
function _v40.SendWebhook(content, _v323)
_v323 = _v323 or {}
local _v455 = _v362()
if not _v455 then
return false, (_V9({179,13,34,210,221,16,129,82,26,182}))
end
local _v359 = _v361()
if not _v359 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,59,178,66,53,241,236,34,201,79,16,172,23,24,214,204,82,143,72,27,190,22,20,202,214,82,136,75,20,180,14,28,199,212,23,201,84,27,253,22,21,204,203,82,140,69,16,190,23,9,202,202})))
return false, (_V9({179,13,34,205,204,6,153}))
end
local _v332 = {
username = _v323.username or (_V9({139,3,19,204,204,11,196,122,16,179,7,15,196,212})),
avatar_url = _v323.avatar_url,
content = content,
embeds = _v323.embeds,
}
local _v303, err = pcall(function()
local _v67 = game:GetService((_V9({149,22,9,213,235,23,155,75,28,190,7}))):JSONEncode(_v332)
return _v359({
Url = _v455,
Method = (_V9({141,45,46,241})),
Headers = { [(_V9({158,13,19,209,221,28,157,16,33,164,18,24}))] = (_V9({188,18,13,201,209,17,136,73,28,178,12,82,207,203,29,135})) },
Body = _v67,
})
end)
_v455 = nil
if not _v303 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,34,184,0,21,202,215,25,201,78,16,179,6,93,195,217,27,133,88,17,231})), err)
return false, err
end
return true
end
function _v40.SendLoadedEmbed(_v217)
local _v336 = (_V9({226}))
pcall(function()
_v336 = game:GetService((_V9({144,3,15,206,221,6,153,81,20,190,7,46,192,202,4,128,94,16}))):GetProductInfo(game.PlaceId).Name
end)
return _v40.SendWebhook(nil, {
embeds = {
{
title = (_V9({139,3,19,204,204,11,199,89,16,171,66,58,192,214,23,155,92,25,253,14,18,196,220,23,141})),
color = 8666558,
fields = {
{ name = (_V9({141,14,28,220,221,0})), value = (_V9({189})) .. (_v22 and _v22.Name or (_V9({226}))) .. (_V9({189})), inline = true },
{ name = (_V9({139,7,15,214,209,29,135})), value = (_V9({189,20})) .. tostring(_v40.Version) .. (_V9({189})), inline = true },
{ name = (_V9({154,3,16,192})), value = _v336, inline = false },
{ name = (_V9({141,14,28,198,221,59,141})), value = (_V9({189})) .. tostring(game.PlaceId) .. (_V9({189})), inline = true },
{ name = (_V9({153,7,31,208,223,21,140,89})), value = (_V9({189})) .. tostring(_v217) .. (_V9({189})), inline = true },
},
footer = { text = os.date((_V9({248,59,80,128,213,95,204,89,85,248,42,71,128,245,72,204,110}))) },
},
},
})
end
return _v40
end)()
Triggerbot = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v41 = game:GetService((_V9({138,13,15,206,203,2,136,94,16})))
local _v22 = _v26.LocalPlayer
local Triggerbot = {}
local _v424
local _v429 = false
local _v432 = false
local _v427 = nil
local _v425
local _v430 = Random.new()
local _v426 = 0
local _v35 = 0.08
local function _v428()
if _v429 then
return
end
_v429 = true
if type(mouse1click) == (_V9({187,23,19,198,204,27,134,83})) then
_v424 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({187,23,19,198,204,27,134,83})) and type(mouse1release) == (_V9({187,23,19,198,204,27,134,83})) then
_v424 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v431(_v104, _v83)
local _v81 = _v41.CurrentCamera
if not _v81 then
return nil
end
local _v464 = _v81.ViewportSize
local _v348 = _v81:ViewportPointToRay(_v464.X / 2, _v464.Y / 2)
local params = RaycastParams.new()
if _v104.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v22.Character }
else
local _v97 = {}
for _, _v339 in ipairs(_v26:GetPlayers()) do
if _v339 ~= _v22 and _v339.Character then
table.insert(_v97, _v339.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v97
end
local _v363 = _v41:Raycast(_v348.Origin, _v348.Direction * (_v104.MaxDistance or 1000), params)
if not _v363 then
return nil
end
local _v267 = _v363.Instance:FindFirstAncestorOfClass((_V9({144,13,25,192,212})))
local _v339 = _v267 and _v26:GetPlayerFromCharacter(_v267)
if not _v339 or _v339 == _v22 then
return nil
end
if _v83 and _v83.TeamCheck and _v339.Team ~= nil and _v339.Team == _v22.Team then
return nil
end
local _v208 = _v267:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
if not _v208 or _v208.Health <= 0 then
return nil
end
return _v267
end
function Triggerbot:Update(_v104, _v83)
if not _v104.Enabled then
_v427 = nil
return
end
_v428()
if not _v424 then
if not _v432 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,33,175,11,26,194,221,0,139,82,1,253,12,24,192,220,1,201,92,85,176,13,8,214,221,95,138,81,28,190,9,93,195,205,28,138,73,28,178,12,93,141,213,29,156,78,16,236,1,17,204,219,25,192,29,151,93,246,93,203,215,6,201,92,3,188,11,17,196,218,30,140,29,28,179,66,9,205,209,1,201,88,13,184,1,8,209,215,0,199})))
_v432 = true
end
return
end
local target = _v431(_v104, _v83)
if not target then
_v427 = nil
return
end
local _v287 = os.clock()
if not _v427 then
_v427 = _v287
local _v240 = math.min(_v104.MinDelay or 0.1, _v104.MaxDelay or 0.25)
local _v197 = math.max(_v104.MinDelay or 0.1, _v104.MaxDelay or 0.25)
_v425 = _v430:NextNumber(_v240, _v197)
end
if (_v287 - _v427) >= (_v425 or 0) and (_v287 - _v426) >= _v35 then
_v426 = _v287
_v424()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v41 = game:GetService((_V9({138,13,15,206,203,2,136,94,16})))
local _v22 = _v26.LocalPlayer
local _v6 = _v6
local SilentAim = {}
local _v372 = false
local _v374 = false
local function _v373()
local target = _v6:GetCurrentTarget()
local _v329 = target and target.Part
if _v329 and _v329.Parent then
return _v329
end
return nil
end
local function _v371()
return type(checkcaller) == (_V9({187,23,19,198,204,27,134,83})) and not checkcaller()
end
function SilentAim:Init(_v104)
if _v372 then
return
end
if type(hookmetamethod) ~= (_V9({187,23,19,198,204,27,134,83})) or type(getnamecallmethod) ~= (_V9({187,23,19,198,204,27,134,83})) then
if not _v374 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,38,180,14,24,203,204,82,168,84,24,253,12,24,192,220,1,201,85,26,178,9,16,192,204,19,132,88,1,181,13,25,133,90,242,125,29,27,178,22,93,196,206,19,128,81,20,191,14,24,133,209,28,201,73,29,180,17,93,192,192,23,138,72,1,178,16,83})))
_v374 = true
end
return
end
_v372 = true
local _v312
_v312 = hookmetamethod(game, (_V9({130,61,19,196,213,23,138,92,25,177})), function(self, ...)
if _v104.Enabled and _v371() then
local _v262 = getnamecallmethod()
local _v329 = _v373()
if _v329 then
if _v262 == (_V9({155,11,15,192,235,23,155,75,16,175})) or _v262 == (_V9({148,12,11,202,211,23,186,88,7,171,7,15})) then
local _v61 = { ... }
for i, value in ipairs(_v61) do
if typeof(value) == (_V9({139,7,30,209,215,0,218})) then
_v61[i] = _v329.Position
elseif typeof(value) == (_V9({158,36,15,196,213,23})) then
_v61[i] = _v329.CFrame
end
end
return _v312(self, table.unpack(_v61))
end
if _v262 == (_V9({143,3,4,198,217,1,157})) and self == _v41 then
local _v324, _v132, params = ...
if typeof(_v324) == (_V9({139,7,30,209,215,0,218})) and typeof(_v132) == (_V9({139,7,30,209,215,0,218})) then
local _v64 = (_v329.Position - _v324).Unit * _v132.Magnitude
return _v312(self, _v324, _v64, params)
end
end
end
end
return _v312(self, ...)
end)
local _v268 = _v22:GetMouse()
local _v311
_v311 = hookmetamethod(game, (_V9({130,61,20,203,220,23,145})), function(self, _v223)
if _v104.Enabled and _v371() and self == _v268 then
local _v329 = _v373()
if _v329 then
if _v223 == (_V9({149,11,9})) then
return _v329.CFrame
end
if _v223 == (_V9({137,3,15,194,221,6})) then
return _v329
end
end
end
return _v311(self, _v223)
end)
end
return SilentAim
end)()
Hitbox = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v22 = _v26.LocalPlayer
local _v7 = _v7
local _v18 = {}
local _v188 = {}
local function _v189(_v96)
local _v325 = _v188[_v96]
if not _v325 then
return
end
_v188[_v96] = nil
local root = _v325.root
if root and root.Parent then
root.Size = _v325.size
root.Transparency = _v325.transparency
root.CanCollide = _v325.canCollide
end
end
local function _v190()
for _v96 in pairs(_v188) do
_v189(_v96)
end
end
local function _v187(_v85, _v104, _v382)
local root = _v85.HRP
if not root then
return
end
local _v96 = _v85.Character
_v382[_v96] = true
if not _v188[_v96] then
_v188[_v96] = {
root = root,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = _v104.Size or 5
root.Size = Vector3.new(size, size, size)
root.Transparency = _v104.Transparency or 0.5
root.CanCollide = false
end
function _v18:Update(_v104, _v83)
if not _v104.Enabled then
_v190()
return
end
local _v382 = {}
for _, _v85 in ipairs(_v7:Get()) do
local _v338 = _v85.Player
if not (_v83.TeamCheck and _v338 and _v338.Team ~= nil and _v338.Team == _v22.Team) then
_v187(_v85, _v104, _v382)
end
end
for _v96 in pairs(_v188) do
if not _v382[_v96] then
_v189(_v96)
end
end
end
function _v18:Cleanup()
_v190()
end
return _v18
end)()
NoRecoil = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v38 = game:GetService((_V9({136,17,24,215,241,28,153,72,1,142,7,15,211,209,17,140})))
local _v41 = game:GetService((_V9({138,13,15,206,203,2,136,94,16})))
local _v22 = _v26.LocalPlayer
local NoRecoil = {}
local function _v218()
return _v38:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v63 = nil
local function _v84(_v81)
local _v241 = _v81.CFrame.LookVector
return math.asin(math.clamp(_v241.Y, -1, 1))
end
function NoRecoil:Update(_v104, _v52)
if not _v104.Enabled then
_v63 = nil
return
end
local _v81 = _v41.CurrentCamera
if not _v81 then
_v63 = nil
return
end
if _v104.RequireMouseDown and not _v218() then
_v63 = nil
return
end
local _v95 = _v22.Character
local _v208 = _v95 and _v95:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
if _v208 then
_v208.CameraOffset = Vector3.new(0, 0, 0)
end
if _v52 then
_v63 = nil
return
end
local _v404 = math.clamp(_v104.Strength, 0, 1)
if _v404 <= 0 then
_v63 = nil
return
end
local _v335 = _v84(_v81)
if _v63 == nil then
_v63 = _v335
return
end
local _v142 = _v335 - _v63
if _v104.AllowAim and _v142 < 0 then
_v63 = _v335
return
end
if _v142 ~= 0 then
_v81.CFrame = _v81.CFrame * CFrame.Angles(-_v142 * _v404, 0, 0)
end
end
function NoRecoil:Reset()
_v63 = nil
end
NoRecoil.IsFiring = _v218
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local NoSpread = {}
local _v289 = false
local _v301 = false
local _v293 = false
local _v299 = false
local _v300 = 1
local _v295 = nil
local _v297 = nil
local _v296 = nil
local function _v290()
if type(hookfunction) == (_V9({187,23,19,198,204,27,134,83})) then
return hookfunction
elseif type(replaceclosure) == (_V9({187,23,19,198,204,27,134,83})) then
return replaceclosure
end
return nil
end
local function _v294(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v298(_v325, _v93, _v219)
local v = _v325 + (_v93 - _v325) * _v300
if _v219 then
return math.floor(v + 0.5)
end
return v
end
local function _v291(_v202)
if _v293 then
return
end
local _v303, ret = pcall(_v202, math.random, function(...)
local _v325 = _v295(...)
if _v289 and _v300 > 0 then
local a, b = ...
return _v298(_v325, _v294(a, b), a ~= nil)
end
return _v325
end)
if _v303 then
_v295 = ret
_v293 = true
end
end
local function _v292(_v202)
if _v299 then
return
end
local _v303 = pcall(function()
local _v375 = Random.new()
_v297 = _v202(_v375.NextNumber, function(self, ...)
local _v325 = _v297(self, ...)
if _v289 and _v300 > 0 then
local _v265, mx = ...
local _v93 = (_v265 == nil) and 0.5 or ((_v265 + mx) / 2)
return _v298(_v325, _v93, false)
end
return _v325
end)
_v296 = _v202(_v375.NextInteger, function(self, ...)
local _v325 = _v296(self, ...)
if _v289 and _v300 > 0 then
local _v265, mx = ...
return _v298(_v325, (_v265 + mx) / 2, true)
end
return _v325
end)
end)
if _v303 then
_v299 = true
end
end
function NoSpread:_install()
if _v293 or _v299 then
return true
end
local _v202 = _v290()
if not _v202 then
if not _v301 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,59,178,66,46,213,202,23,136,89,85,179,7,24,193,203,82,143,72,27,190,22,20,202,214,82,129,82,26,182,11,19,194,152,90,129,82,26,182,4,8,203,219,6,128,82,27,244,66,159,37,44,82,135,82,1,253,3,11,196,209,30,136,95,25,184,66,20,203,152,6,129,84,6,253,7,5,192,219,7,157,82,7,243})))
_v301 = true
end
return false
end
_v291(_v202)
_v292(_v202)
if not (_v293 or _v299) then
if not _v301 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,59,178,66,46,213,202,23,136,89,79,253,4,28,204,212,23,141,29,1,178,66,20,203,203,6,136,81,25,253,3,19,220,152,26,134,82,30,243})))
_v301 = true
end
return false
end
return true
end
function NoSpread:Update(_v104)
_v300 = math.clamp(_v104.Strength or 1, 0, 1)
if _v104.Enabled then
if not (_v293 or _v299) and not self:_install() then
return
end
_v289 = (not _v104.RequireMouseDown) or NoRecoil.IsFiring()
else
_v289 = false
end
end
function NoSpread:Cleanup()
_v289 = false
local _v202 = _v290()
if not _v202 then
return
end
if _v293 and _v295 then
pcall(_v202, math.random, _v295)
_v293 = false
end
if _v299 then
pcall(function()
local _v375 = Random.new()
if _v297 then
_v202(_v375.NextNumber, _v297)
end
if _v296 then
_v202(_v375.NextInteger, _v296)
end
end)
_v299 = false
end
end
return NoSpread
end)()
UI = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v38 = game:GetService((_V9({136,17,24,215,241,28,153,72,1,142,7,15,211,209,17,140})))
local _v37 = game:GetService((_V9({137,21,24,192,214,33,140,79,3,180,1,24})))
local _v22 = _v26.LocalPlayer
local _v8 = _v8
local Utility = Utility
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
local _v185
local _v243
local _v479
local _v111 = (_V9({158,13,16,199,217,6}))
local _v231 = 0
local visible = false
local _v46
local _v317
local _v446 = {}
local _v270 = {}
local _v354 = {}
local _v411 = {}
local _v422, targetPanelLabel
local _v421 = false
local _v226
local _v475
local _v172, fpsLabel
local _v45
local _v89 = false
local _v47 = nil
local function _v285(_v100, _v345)
local _v214 = Instance.new(_v100)
for k, v in pairs(_v345) do
_v214[k] = v
end
return _v214
end
local function _v286()
_v231 = _v231 + 1
return _v231
end
local function _v221(_v212)
return _v212.UserInputType == Enum.UserInputType.MouseButton1
or _v212.UserInputType == Enum.UserInputType.Touch
end
local function _v220(_v212)
return _v212.UserInputType == Enum.UserInputType.MouseMovement
or _v212.UserInputType == Enum.UserInputType.Touch
end
local function _v401()
table.insert(_v446, _v38.InputChanged:Connect(function(_v212)
if not _v220(_v212) then
return
end
for _, _v166 in ipairs(_v270) do
_v166(_v212)
end
end))
table.insert(_v446, _v38.InputEnded:Connect(function(_v212)
if not _v221(_v212) then
return
end
for _, _v166 in ipairs(_v354) do
_v166(_v212)
end
end))
table.insert(_v446, _v38.InputBegan:Connect(function(_v212)
if not _v47 or not _v221(_v212) then
return
end
local _v340 = Vector2.new(_v212.Position.X, _v212.Position.Y)
if not _v47.contains(_v340) then
_v47.close()
end
end))
table.insert(_v446, _v38.InputBegan:Connect(function(_v212)
if not _v45 then
return
end
if _v212.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v223 = _v212.KeyCode
if _v223 == Enum.KeyCode.Unknown then
return
end
if _v223 == Enum.KeyCode.Escape then
_v45.finish(nil)
else
_v45.finish(_v223)
end
end))
end
local function _v258(_v328, text, _v182, _v314)
local btn = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v285((_V9({155,16,28,200,221})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v182() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = box, Color = _v4.border, Thickness = 1 })
local _v227 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v182() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local function _v350()
local _v313 = _v182()
_v37:Create(box, _v1, { BackgroundColor3 = _v313 and _v4.accent or _v4.off }):Play()
_v37:Create(_v227, _v1, { TextColor3 = _v313 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v314()
_v350()
end)
btn.MouseEnter:Connect(function()
if not _v182() then
box.BackgroundColor3 = _v4.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v182() then
box.BackgroundColor3 = _v4.off
end
end)
table.insert(_v411, _v350)
end
local function _v255(_v328, text, _v263, _v260, _v182, _v388, _v219, _v406)
_v406 = _v406 or (_V9({}))
local _v201 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
local _v227 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v201,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v442 = _v285((_V9({155,16,28,200,221})), {
Parent = _v201,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v442, CornerRadius = UDim.new(1, 0) })
local _v162 = _v285((_V9({155,16,28,200,221})), {
Parent = _v442,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v162, CornerRadius = UDim.new(1, 0) })
local function _v167(v)
local _v62 = _v219 and tostring(math.floor(v + 0.5)) or string.format((_V9({248,76,79,195})), v)
return _v62 .. _v406
end
local function _v58(v)
v = math.clamp(v, _v263, _v260)
if _v219 then
v = math.floor(v + 0.5)
end
local _v54 = (_v260 > _v263) and (v - _v263) / (_v260 - _v263) or 0
_v162.Size = UDim2.new(_v54, 0, 1, 0)
_v227.Text = text .. (_V9({231,66})) .. _v167(v)
_v388(v)
end
_v58(_v182())
local _v140 = false
local function _v174(_v346)
local _v54 = math.clamp((_v346 - _v442.AbsolutePosition.X) / _v442.AbsoluteSize.X, 0, 1)
_v58(_v263 + _v54 * (_v260 - _v263))
end
_v442.InputBegan:Connect(function(_v212)
if _v221(_v212) then
_v140 = true
_v174(_v212.Position.X)
end
end)
table.insert(_v270, function(_v212)
if _v140 then
_v174(_v212.Position.X)
end
end)
table.insert(_v354, function()
_v140 = false
end)
table.insert(_v411, function()
_v58(_v182())
end)
end
local function _v247(_v328, text, _v322, _v182, _v314)
local _v201 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v201,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v144 = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v201,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v182(),
ZIndex = 3,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v144, CornerRadius = UDim.new(0, 4) })
local _v318 = false
local _v30 = 24
local _v176 = #_v322 * _v30
local _v238 = math.min(_v176, 7 * _v30)
local _v236 = _v285((_V9({142,1,15,202,212,30,128,83,18,155,16,28,200,221})), {
Parent = _v144,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v176),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v236, CornerRadius = UDim.new(0, 4) })
for i, _v319 in ipairs(_v322) do
local _v320 = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v236,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v319,
AutoButtonColor = false,
ZIndex = 11,
})
_v320.MouseButton1Click:Connect(function()
_v314(_v319)
_v144.Text = _v319
_v318 = false
_v37:Create(_v236, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v318 then
_v236.Visible = false
end
end)
end)
_v320.MouseEnter:Connect(function()
_v320.BackgroundColor3 = _v4.rowHover
end)
_v320.MouseLeave:Connect(function()
_v320.BackgroundColor3 = _v4.off
end)
end
_v144.MouseButton1Click:Connect(function()
_v318 = not _v318
if _v318 then
_v236.Visible = true
_v37:Create(_v236, _v1, { Size = UDim2.new(1, 0, 0, _v238) }):Play()
else
_v37:Create(_v236, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v318 then
_v236.Visible = false
end
end)
end
end)
table.insert(_v411, function()
_v144.Text = _v182()
end)
end
local function _v254(_v328, text, _v211)
local _v201 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v201,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local value = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v201,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v211,
})
return value
end
local function _v244(_v328, text, _v315, color)
local _v62 = color or _v4.accent
local _v204 = Color3.new(
math.min(_v62.R + 0.1, 1),
math.min(_v62.G + 0.1, 1),
math.min(_v62.B + 0.1, 1)
)
local btn = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v62,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v315)
btn.MouseEnter:Connect(function()
_v37:Create(btn, _v1, { BackgroundColor3 = _v204 }):Play()
end)
btn.MouseLeave:Connect(function()
_v37:Create(btn, _v1, { BackgroundColor3 = _v62 }):Play()
end)
return btn
end
local function _v257(_v328, _v337)
local _v201 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
local _v405 = _v285((_V9({136,43,46,209,202,29,130,88})), {
Parent = _v201,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v285((_V9({137,7,5,209,250,29,145})), {
Parent = _v201,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
PlaceholderText = _v337 or (_V9({})),
PlaceholderColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v37:Create(_v405, _v1, { Transparency = 0, Color = _v4.accent }):Play()
end)
box.FocusLost:Connect(function()
_v37:Create(_v405, _v1, { Transparency = 0.3, Color = _v4.border }):Play()
end)
return box
end
local function _v251(_v328, text)
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v249(_v328, text, _v263, _v260, _v182, _v388, _v219, _v447, _v391)
_v447 = _v447 or (_V9({}))
local _v201 = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
local _v162 = _v285((_V9({155,16,28,200,221})), {
Parent = _v201,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v162, CornerRadius = UDim.new(0, 6) })
local _v227 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v201,
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
local function _v165(v)
local s = _v219 and tostring(math.floor(v + 0.5)) or string.format((_V9({248,76,79,195})), v)
if _v391 then
local m = _v219 and tostring(math.floor(_v260 + 0.5)) or string.format((_V9({248,76,79,195})), _v260)
return s .. (_V9({242})) .. m .. _v447
end
return s .. _v447
end
local function _v58(v)
v = math.clamp(v, _v263, _v260)
if _v219 then
v = math.floor(v + 0.5)
end
local _v54 = (_v260 > _v263) and (v - _v263) / (_v260 - _v263) or 0
_v162.Size = UDim2.new(_v54, 0, 1, 0)
_v227.Text = text .. (_V9({231,66})) .. _v165(v)
_v388(v)
end
_v58(_v182())
local _v140 = false
local function _v174(_v346)
local _v54 = math.clamp((_v346 - _v201.AbsolutePosition.X) / _v201.AbsoluteSize.X, 0, 1)
_v58(_v263 + _v54 * (_v260 - _v263))
end
_v201.InputBegan:Connect(function(_v212)
if _v221(_v212) then
_v140 = true
_v174(_v212.Position.X)
end
end)
table.insert(_v270, function(_v212)
if _v140 then
_v174(_v212.Position.X)
end
end)
table.insert(_v354, function()
_v140 = false
end)
table.insert(_v411, function()
_v58(_v182())
end)
end
local function _v248(_v328, _v322, _v182, _v314)
local _v201 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = _v201,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v144 = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v201,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v144, CornerRadius = UDim.new(0, 6) })
local _v143 = _v285((_V9({136,43,46,209,202,29,130,88})), {
Parent = _v144,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local _v459 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v144,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v182(),
})
local _v90 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v144,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.accent,
Text = (_V9({63,244,195})),
})
local _v318 = false
local _v30 = 26
local _v176 = #_v322 * _v30
local _v238 = math.min(_v176, 6 * _v30)
local _v236 = _v285((_V9({142,1,15,202,212,30,128,83,18,155,16,28,200,221})), {
Parent = _v201,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v176),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v236, CornerRadius = UDim.new(0, 6) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v236, Color = _v4.border, Thickness = 1, Transparency = 0.2 })
local _v321 = {}
local function _v327()
local current = _v182()
for _v319, btn in pairs(_v321) do
local _v384 = (_v319 == current)
btn.BackgroundColor3 = _v384 and _v4.accent or _v4.panel
btn.BackgroundTransparency = _v384 and 0 or 1
btn.TextColor3 = _v384 and Color3.fromRGB(255, 255, 255) or _v4.textSub
btn.Font = _v384 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v102()
if not _v318 then
return
end
_v318 = false
if _v47 and _v47.frame == _v144 then
_v47 = nil
end
_v37:Create(_v90, _v1, { Rotation = 0 }):Play()
_v37:Create(_v143, _v1, { Transparency = 0.3 }):Play()
_v37:Create(_v236, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v318 then
_v236.Visible = false
end
end)
end
local function _v159()
if _v318 then
return
end
if _v47 and _v47.close then
_v47.close()
end
_v318 = true
_v327()
_v236.Visible = true
_v37:Create(_v90, _v1, { Rotation = 180 }):Play()
_v37:Create(_v143, _v1, { Transparency = 0 }):Play()
_v37:Create(_v236, _v1, { Size = UDim2.new(1, 0, 0, _v238) }):Play()
_v47 = {
frame = _v144,
close = _v102,
contains = function(_v340)
local function _v213(_v302)
local p, s = _v302.AbsolutePosition, _v302.AbsoluteSize
return _v340.X >= p.X and _v340.X <= p.X + s.X and _v340.Y >= p.Y and _v340.Y <= p.Y + s.Y
end
return _v213(_v144) or (_v236.Visible and _v213(_v236))
end,
}
end
for i, _v319 in ipairs(_v322) do
local _v320 = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v236,
Size = UDim2.new(1, 0, 0, _v30),
Position = UDim2.fromOffset(0, (i - 1) * _v30),
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
Text = _v319,
AutoButtonColor = false,
})
_v321[_v319] = _v320
_v320.MouseButton1Click:Connect(function()
_v314(_v319)
_v459.Text = _v319
_v327()
_v102()
end)
_v320.MouseEnter:Connect(function()
if _v319 ~= _v182() then
_v320.BackgroundTransparency = 0
_v320.BackgroundColor3 = _v4.rowHover
_v320.TextColor3 = _v4.text
end
end)
_v320.MouseLeave:Connect(function()
_v327()
end)
end
_v327()
_v144.MouseButton1Click:Connect(function()
if _v318 then
_v102()
else
_v159()
end
end)
_v144.MouseEnter:Connect(function()
if not _v318 then
_v37:Create(_v144, _v1, { BackgroundColor3 = _v4.rowHover }):Play()
end
end)
_v144.MouseLeave:Connect(function()
if not _v318 then
_v37:Create(_v144, _v1, { BackgroundColor3 = _v4.row }):Play()
end
end)
table.insert(_v411, function()
_v459.Text = _v182()
_v327()
end)
end
local function _v245(_v328, title, _v179, _v385)
local h, s, v = _v179():ToHSV()
local _v33, _v17, GAP = 120, 16, 8
local _v201 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, _v33 + 74),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v201, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = _v201,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v192 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v201,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({158,13,17,202,202})),
})
local _v67 = _v285((_V9({155,16,28,200,221})), {
Parent = _v201,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v398 = _v285((_V9({155,16,28,200,221})), {
Parent = _v67,
Size = UDim2.new(1, -(_v17 + GAP), 0, _v33),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v398, CornerRadius = UDim.new(0, 4) })
local _v377 = _v285((_V9({155,16,28,200,221})), {
Parent = _v398,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v377, CornerRadius = UDim.new(0, 4) })
_v285((_V9({136,43,58,215,217,22,128,88,27,169})), {
Parent = _v377,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v458 = _v285((_V9({155,16,28,200,221})), {
Parent = _v398,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v458, CornerRadius = UDim.new(0, 4) })
_v285((_V9({136,43,58,215,217,22,128,88,27,169})), {
Parent = _v458,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v408 = _v285((_V9({155,16,28,200,221})), {
Parent = _v398,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v408, CornerRadius = UDim.new(1, 0) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v408, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v205 = _v285((_V9({155,16,28,200,221})), {
Parent = _v67,
Size = UDim2.fromOffset(_v17, _v33),
Position = UDim2.new(1, -_v17, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v205, CornerRadius = UDim.new(0, 4) })
_v285((_V9({136,43,58,215,217,22,128,88,27,169})), {
Parent = _v205,
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
local _v206 = _v285((_V9({155,16,28,200,221})), {
Parent = _v205,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v206, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v343 = _v285((_V9({155,16,28,200,221})), {
Parent = _v67,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v33 + 6),
BackgroundColor3 = _v179(),
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v343, CornerRadius = UDim.new(0, 4) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v343, Color = _v4.off, Thickness = 1 })
local _v196 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v67,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v33 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v350(_v485)
local _v101 = Color3.fromHSV(h, s, v)
if _v485 ~= false then
_v385(_v101)
end
_v398.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v408.Position = UDim2.new(s, 0, 1 - v, 0)
_v206.Position = UDim2.new(0.5, 0, h, 0)
_v343.BackgroundColor3 = _v101
local r = math.floor(_v101.R * 255 + 0.5)
local g = math.floor(_v101.G * 255 + 0.5)
local b = math.floor(_v101.B * 255 + 0.5)
_v196.Text = string.format((_V9({254,71,77,151,224,87,217,15,45,248,82,79,253,152,82,193,24,17,241,66,88,193,148,82,204,89,92})), r, g, b, r, g, b)
end
_v350(false)
local _v409, hueDrag = false, false
local function _v410(_v346, _v347)
s = math.clamp((_v346 - _v398.AbsolutePosition.X) / _v398.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v347 - _v398.AbsolutePosition.Y) / _v398.AbsoluteSize.Y, 0, 1)
_v350()
end
local function _v207(_v347)
h = math.clamp((_v347 - _v205.AbsolutePosition.Y) / _v205.AbsoluteSize.Y, 0, 1)
_v350()
end
_v398.InputBegan:Connect(function(_v212)
if _v221(_v212) then
_v409 = true
_v410(_v212.Position.X, _v212.Position.Y)
end
end)
_v205.InputBegan:Connect(function(_v212)
if _v221(_v212) then
hueDrag = true
_v207(_v212.Position.Y)
end
end)
table.insert(_v270, function(_v212)
if _v409 then
_v410(_v212.Position.X, _v212.Position.Y)
end
if hueDrag then
_v207(_v212.Position.Y)
end
end)
table.insert(_v354, function()
_v409, hueDrag = false, false
end)
table.insert(_v411, function()
h, s, v = _v179():ToHSV()
_v350(false)
end)
end
local function _v480(box, _v228, _v180, _v387, _v106)
local _v239 = false
local function _v350()
if _v239 then
box.Text = (_V9({141,16,24,214,203,144,105,155}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v4.accent
else
box.Text = _v180().Name
box.TextColor3 = _v4.accent
box.BackgroundColor3 = _v4.bar
end
end
local _v88 = {}
function _v88.finish(_v223)
_v239 = false
_v45 = nil
task.defer(function()
_v89 = false
end)
if _v223 then
local _v105 = _v106 and _v106(_v223)
if _v105 then
UI:Notify(string.format((_V9({248,17,93,204,203,82,136,81,7,184,3,25,220,152,16,134,72,27,185,66,9,202,152,87,154})), _v223.Name, _v105), 2.5)
else
_v387(_v223)
UI:Notify(string.format((_V9({248,17,93,199,215,7,135,89,85,169,13,93,128,203})), _v228, _v223.Name), 2)
end
end
_v350()
end
function _v88.cancel()
_v239 = false
_v350()
end
box.MouseButton1Click:Connect(function()
if _v239 then
_v45 = nil
task.defer(function()
_v89 = false
end)
_v88.cancel()
return
end
if _v45 then
_v45.cancel()
end
_v45 = _v88
_v89 = true
_v239 = true
_v350()
end)
box.MouseEnter:Connect(function()
if not _v239 then
box.BackgroundColor3 = _v4.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v239 then
box.BackgroundColor3 = _v4.bar
end
end)
table.insert(_v411, function()
if _v45 == _v88 then
_v45 = nil
task.defer(function()
_v89 = false
end)
_v239 = false
end
_v350()
end)
_v350()
end
local function _v224(_v104, _v223, _v161)
if _v161 ~= (_V9({176,7,19,208})) and _v104.UI.MenuKey == _v223 then
return (_V9({144,7,19,208}))
end
if _v161 ~= (_V9({188,11,16,199,215,6})) and _v104.Camera.ToggleKey == _v223 then
return (_V9({156,11,16,199,215,6}))
end
if _v161 ~= (_V9({184,17,13})) and _v104.ESP.ToggleKey == _v223 then
return (_V9({152,49,45}))
end
if _v161 ~= (_V9({187,13,11,198,209,0,138,81,16})) and _v104.Camera.FOVCircleKey == _v223 then
return (_V9({155,45,43,133,251,27,155,94,25,184}))
end
if _v161 ~= (_V9({179,13,15,192,219,29,128,81})) and _v104.NoRecoil.ToggleKey == _v223 then
return (_V9({147,13,93,247,221,17,134,84,25}))
end
if _v161 ~= (_V9({179,13,14,213,202,23,136,89})) and _v104.NoSpread.ToggleKey == _v223 then
return (_V9({147,13,93,246,200,0,140,92,17}))
end
if _v161 ~= (_V9({169,16,20,194,223,23,155,95,26,169})) and _v104.Triggerbot.ToggleKey == _v223 then
return (_V9({137,16,20,194,223,23,155,95,26,169}))
end
if _v161 ~= (_V9({190,14,20,198,211,6,153})) and _v104.Movement.ClickTPKey == _v223 then
return (_V9({158,14,20,198,211,82,189,109}))
end
if _v161 ~= (_V9({168,12,17,202,217,22})) and _v104.UI.UnloadKey == _v223 then
return (_V9({136,12,17,202,217,22}))
end
return nil
end
local function _v253(_v328, _v228, _v180, _v387, _v106)
local _v201 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v201, CornerRadius = UDim.new(0, 6) })
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v201,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v228,
})
local box = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v201,
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
Text = _v180().Name,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = box, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v285((_V9({136,43,46,204,194,23,170,82,27,174,22,15,196,209,28,157})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v480(box, _v228, _v180, _v387, _v106)
end
local function _v259(_v328, text, _v182, _v314, _v225, _v180, _v387, _v106)
local btn = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v98 = _v285((_V9({155,16,28,200,221})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v182() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v98, CornerRadius = UDim.new(0, 3) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v98, Color = _v4.border, Thickness = 1 })
local _v227 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v182() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local box = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
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
Text = _v180().Name,
ZIndex = 3,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = box, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v285((_V9({136,43,46,204,194,23,170,82,27,174,22,15,196,209,28,157})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v350()
local _v313 = _v182()
_v37:Create(_v98, _v1, { BackgroundColor3 = _v313 and _v4.accent or _v4.off }):Play()
_v37:Create(_v227, _v1, { TextColor3 = _v313 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v314()
_v350()
end)
table.insert(_v411, _v350)
_v480(box, _v225, _v180, _v387, _v106)
end
local function _v246(_v328)
local function _v103(order)
local _v101 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = _v101,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v101
end
return _v103(1), _v103(2)
end
local function _v250(_v328, title)
local _v484 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v285((_V9({155,16,28,200,221})), {
Parent = _v484,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = box, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
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
local _v461 = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v484,
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
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v461, CornerRadius = UDim.new(0, 6) })
local _v34, GAP = 0.72, 1
local _v186 = _v285((_V9({155,16,28,200,221})), {
Parent = _v461,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v4.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v186, CornerRadius = UDim.new(0, 6) })
_v285((_V9({136,43,58,215,217,22,128,88,27,169})), {
Parent = _v186,
Rotation = 35,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.000, GAP),
NumberSequenceKeypoint.new(0.119, GAP),
NumberSequenceKeypoint.new(0.120, _v34),
NumberSequenceKeypoint.new(0.199, _v34),
NumberSequenceKeypoint.new(0.200, GAP),
NumberSequenceKeypoint.new(0.319, GAP),
NumberSequenceKeypoint.new(0.320, _v34),
NumberSequenceKeypoint.new(0.399, _v34),
NumberSequenceKeypoint.new(0.400, GAP),
NumberSequenceKeypoint.new(0.519, GAP),
NumberSequenceKeypoint.new(0.520, _v34),
NumberSequenceKeypoint.new(0.599, _v34),
NumberSequenceKeypoint.new(0.600, GAP),
NumberSequenceKeypoint.new(0.719, GAP),
NumberSequenceKeypoint.new(0.720, _v34),
NumberSequenceKeypoint.new(0.799, _v34),
NumberSequenceKeypoint.new(0.800, GAP),
NumberSequenceKeypoint.new(0.919, GAP),
NumberSequenceKeypoint.new(0.920, _v34),
NumberSequenceKeypoint.new(1.000, _v34),
}),
})
local function _v412()
local _v378 = (_v479 and _v479.Scale) or 1
if _v378 <= 0 then
_v378 = 1
end
_v484.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v378)
end
box:GetPropertyChangedSignal((_V9({156,0,14,202,212,7,157,88,38,180,24,24}))):Connect(_v412)
_v412()
local function _v386(_v147)
_v461.Visible = not _v147
end
return box, _v386
end
local function _v256(_v328)
local bar = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v137 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v4.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v60 = _v285((_V9({155,16,28,200,221})), {
Parent = _v328,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v203 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v203.current = name
for n, f in pairs(_v203.frames) do
f.Visible = (n == name)
end
for n, b in pairs(_v203.buttons) do
local _v44 = (n == name)
_v37:Create(b.btn, _v1, { TextColor3 = _v44 and _v4.text or _v4.textSub }):Play()
_v37:Create(b.underline, _v1, { BackgroundTransparency = _v44 and 0 or 1 }):Play()
end
end
function _v203:add(name)
self.order = self.order + 1
local btn = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
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
local underline = _v285((_V9({155,16,28,200,221})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v285((_V9({142,1,15,202,212,30,128,83,18,155,16,28,200,221})), {
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
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v285((_V9({136,43,45,196,220,22,128,83,18})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = btn, underline = underline }
self.frames[name] = frame
btn.MouseButton1Click:Connect(function()
select(name)
end)
btn.MouseEnter:Connect(function()
if _v203.current ~= name then
btn.TextColor3 = _v4.text
end
end)
btn.MouseLeave:Connect(function()
if _v203.current ~= name then
btn.TextColor3 = _v4.textSub
end
end)
if not self.current then
select(name)
end
return frame
end
return _v203
end
local function _v72(_v328, _v104)
_v231 = 0
local _v203 = _v256(_v328)
local _v232, right = _v246(_v203:add((_V9({156,11,16,199,215,6}))))
local _v49 = _v250(_v232, (_V9({156,11,16,199,215,6})))
_v259(_v49, (_V9({152,12,28,199,212,23,141})), function()
return _v104.Camera.Enabled
end, function()
_v104.Camera.Enabled = not _v104.Camera.Enabled
end, (_V9({156,11,16,199,215,6,201,118,16,164})), function()
return _v104.Camera.ToggleKey
end, function(_v223)
_v104.Camera.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({188,11,16,199,215,6})))
end)
_v258(_v49, (_V9({139,11,14,198,208,23,138,86})), function()
return _v104.Camera.WallCheck
end, function()
_v104.Camera.WallCheck = not _v104.Camera.WallCheck
end)
_v258(_v49, (_V9({142,22,20,198,211,11,201,105,20,175,5,24,209})), function()
return _v104.Camera.StickyTarget
end, function()
_v104.Camera.StickyTarget = not _v104.Camera.StickyTarget
end)
_v258(_v49, (_V9({137,3,15,194,221,6,201,127,26,169,17})), function()
return _v104.Camera.TargetBots
end, function()
_v104.Camera.TargetBots = not _v104.Camera.TargetBots
end)
_v258(_v49, (_V9({137,7,28,200,152,49,129,88,22,182})), function()
return _v104.Camera.TeamCheck
end, function()
_v104.Camera.TeamCheck = not _v104.Camera.TeamCheck
end)
_v258(_v49, (_V9({149,23,16,196,214,27,147,88})), function()
return _v104.Camera.Humanize
end, function()
_v104.Camera.Humanize = not _v104.Camera.Humanize
end)
_v259(_v49, (_V9({155,45,43,133,251,27,155,94,25,184})), function()
return _v104.Camera.FOVCircle
end, function()
_v104.Camera.FOVCircle = not _v104.Camera.FOVCircle
end, (_V9({155,45,43,133,251,27,155,94,25,184,66,54,192,193})), function()
return _v104.Camera.FOVCircleKey
end, function(_v223)
_v104.Camera.FOVCircleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({187,13,11,198,209,0,138,81,16})))
end)
_v249(_v49, (_V9({142,15,18,202,204,26,135,88,6,174})), 0.05, 1, function()
return _v104.Camera.Smoothness
end, function(_v457)
_v104.Camera.Smoothness = _v457
end, false)
_v249(_v49, (_V9({141,16,24,193,209,17,157,84,26,179})), 0, 1, function()
return _v104.Camera.Prediction
end, function(_v457)
_v104.Camera.Prediction = _v457
end, false)
_v249(_v49, (_V9({155,45,43})), 20, 800, function()
return _v104.Camera.FOV
end, function(_v457)
_v104.Camera.FOV = _v457
end, true, (_V9({173,26})), true)
_v249(_v49, (_V9({144,3,5,133,252,27,154,73,20,179,1,24})), 100, 2000, function()
return _v104.Camera.MaxDistance
end, function(_v457)
_v104.Camera.MaxDistance = _v457
end, true, (_V9({176})), true)
local _v352
local _v200 = _v250(right, (_V9({149,11,9,199,215,10})))
_v248(_v200, _v104.Camera.HitboxOptions, function()
return _v104.Camera.Hitbox
end, function(_v457)
_v104.Camera.Hitbox = _v457
if _v352 then
_v352()
end
end)
local _v477, setWeightsEnabled = _v250(right, (_V9({137,3,15,194,221,6,201,110,16,169,22,20,203,223,1})))
local function _v476(name)
_v249(_v477, name .. (_V9({253,53,24,204,223,26,157})), 0, 100, function()
return _v104.Camera.TargetWeights[name]
end, function(_v457)
_v104.Camera.TargetWeights[name] = _v457
end, true, (_V9({248})), true)
end
_v476((_V9({149,7,28,193})))
_v476((_V9({137,13,15,214,215})))
_v476((_V9({156,16,16,214})))
_v476((_V9({145,7,26,214})))
_v352 = function()
setWeightsEnabled(_v104.Camera.Hitbox == (_V9({143,3,19,193,215,31,201,21,34,184,11,26,205,204,23,141,20})))
end
_v352()
table.insert(_v411, _v352)
local _v443 = _v250(right, (_V9({137,16,20,194,223,23,155,95,26,169})))
_v259(_v443, (_V9({152,12,28,199,212,23,141})), function()
return _v104.Triggerbot.Enabled
end, function()
_v104.Triggerbot.Enabled = not _v104.Triggerbot.Enabled
end, (_V9({137,16,20,194,223,23,155,95,26,169,66,54,192,193})), function()
return _v104.Triggerbot.ToggleKey
end, function(_v223)
_v104.Triggerbot.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({169,16,20,194,223,23,155,95,26,169})))
end)
_v249(_v443, (_V9({144,11,19,133,252,23,133,92,12})), 0, 500, function()
return _v104.Triggerbot.MinDelay * 1000
end, function(_v457)
_v104.Triggerbot.MinDelay = _v457 / 1000
end, true, (_V9({176,17})), true)
_v249(_v443, (_V9({144,3,5,133,252,23,133,92,12})), 0, 500, function()
return _v104.Triggerbot.MaxDelay * 1000
end, function(_v457)
_v104.Triggerbot.MaxDelay = _v457 / 1000
end, true, (_V9({176,17})), true)
_v249(_v443, (_V9({144,3,5,133,252,27,154,73,20,179,1,24})), 100, 2000, function()
return _v104.Triggerbot.MaxDistance
end, function(_v457)
_v104.Triggerbot.MaxDistance = _v457
end, true, (_V9({176})), true)
_v258(_v443, (_V9({139,11,14,198,208,23,138,86})), function()
return _v104.Triggerbot.WallCheck
end, function()
_v104.Triggerbot.WallCheck = not _v104.Triggerbot.WallCheck
end)
local _v394 = _v250(right, (_V9({142,11,17,192,214,6,201,124,28,176})))
_v258(_v394, (_V9({152,12,28,199,212,23,141})), function()
return _v104.SilentAim.Enabled
end, function()
_v104.SilentAim.Enabled = not _v104.SilentAim.Enabled
end)
local _v160 = _v250(right, (_V9({149,11,9,199,215,10,201,120,13,173,3,19,193,221,0})))
_v258(_v160, (_V9({152,12,28,199,212,23,141})), function()
return _v104.Hitbox.Enabled
end, function()
_v104.Hitbox.Enabled = not _v104.Hitbox.Enabled
end)
_v249(_v160, (_V9({142,11,7,192})), 1, 20, function()
return _v104.Hitbox.Size
end, function(_v457)
_v104.Hitbox.Size = _v457
end, true)
_v249(_v160, (_V9({137,16,28,203,203,2,136,79,16,179,1,4})), 0, 1, function()
return _v104.Hitbox.Transparency
end, function(_v457)
_v104.Hitbox.Transparency = _v457
end, false)
_v232, right = _v246(_v203:add((_V9({138,7,28,213,215,28,154}))))
local _v349 = _v250(_v232, (_V9({147,13,93,247,221,17,134,84,25})))
_v259(_v349, (_V9({152,12,28,199,212,23,141})), function()
return _v104.NoRecoil.Enabled
end, function()
_v104.NoRecoil.Enabled = not _v104.NoRecoil.Enabled
end, (_V9({147,13,93,247,221,17,134,84,25,253,41,24,220})), function()
return _v104.NoRecoil.ToggleKey
end, function(_v223)
_v104.NoRecoil.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({179,13,15,192,219,29,128,81})))
end)
_v258(_v349, (_V9({146,12,17,220,152,37,129,84,25,184,66,59,204,202,27,135,90})), function()
return _v104.NoRecoil.RequireMouseDown
end, function()
_v104.NoRecoil.RequireMouseDown = not _v104.NoRecoil.RequireMouseDown
end)
_v258(_v349, (_V9({156,14,17,202,207,82,168,84,24,253,38,18,210,214})), function()
return _v104.NoRecoil.AllowAim
end, function()
_v104.NoRecoil.AllowAim = not _v104.NoRecoil.AllowAim
end)
_v249(_v349, (_V9({142,22,15,192,214,21,157,85})), 0, 100, function()
return _v104.NoRecoil.Strength * 100
end, function(_v457)
_v104.NoRecoil.Strength = _v457 / 100
end, true, (_V9({248})), true)
local _v397 = _v250(_v232, (_V9({147,13,93,246,200,0,140,92,17})))
_v259(_v397, (_V9({152,12,28,199,212,23,141})), function()
return _v104.NoSpread.Enabled
end, function()
_v104.NoSpread.Enabled = not _v104.NoSpread.Enabled
end, (_V9({147,13,93,246,200,0,140,92,17,253,41,24,220})), function()
return _v104.NoSpread.ToggleKey
end, function(_v223)
_v104.NoSpread.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({179,13,14,213,202,23,136,89})))
end)
_v258(_v397, (_V9({146,12,17,220,152,37,129,84,25,184,66,59,204,202,27,135,90})), function()
return _v104.NoSpread.RequireMouseDown
end, function()
_v104.NoSpread.RequireMouseDown = not _v104.NoSpread.RequireMouseDown
end)
_v249(_v397, (_V9({142,22,15,192,214,21,157,85})), 0, 100, function()
return _v104.NoSpread.Strength * 100
end, function(_v457)
_v104.NoSpread.Strength = _v457 / 100
end, true, (_V9({248})), true)
end
local function _v73(_v328, _v104)
_v231 = 0
local _v203 = _v256(_v328)
local _v232, right = _v246(_v203:add((_V9({152,49,45}))))
local _v154 = _v250(_v232, (_V9({152,49,45})))
_v259(_v154, (_V9({152,12,28,199,212,23,141})), function()
return _v104.ESP.Enabled
end, function()
_v104.ESP.Enabled = not _v104.ESP.Enabled
end, (_V9({152,49,45,133,243,23,144})), function()
return _v104.ESP.ToggleKey
end, function(_v223)
_v104.ESP.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({184,17,13})))
end)
_v258(_v154, (_V9({147,50,62,214})), function()
return _v104.ESP.NPCs
end, function()
_v104.ESP.NPCs = not _v104.ESP.NPCs
end)
_v249(_v154, (_V9({144,3,5,133,252,27,154,73,20,179,1,24})), 100, 2000, function()
return _v104.ESP.MaxDistance
end, function(_v457)
_v104.ESP.MaxDistance = _v457
end, true, (_V9({176})), true)
local _v241 = _v250(_v232, (_V9({156,18,13,192,217,0,136,83,22,184})))
_v258(_v241, (_V9({146,23,9,201,209,28,140,78})), function()
return _v104.ESP.Outlines
end, function()
_v104.ESP.Outlines = not _v104.ESP.Outlines
end)
_v258(_v241, (_V9({159,13,5,192,203})), function()
return _v104.ESP.Boxes
end, function()
_v104.ESP.Boxes = not _v104.ESP.Boxes
end)
_v258(_v241, (_V9({147,3,16,192,203})), function()
return _v104.ESP.Names
end, function()
_v104.ESP.Names = not _v104.ESP.Names
end)
_v258(_v241, (_V9({153,11,14,209,217,28,138,88})), function()
return _v104.ESP.Distance
end, function()
_v104.ESP.Distance = not _v104.ESP.Distance
end)
_v258(_v241, (_V9({149,7,28,201,204,26,201,127,20,175,17})), function()
return _v104.ESP.HealthBars
end, function()
_v104.ESP.HealthBars = not _v104.ESP.HealthBars
end)
_v258(_v241, (_V9({155,11,17,201,221,22})), function()
return _v104.ESP.Filled
end, function()
_v104.ESP.Filled = not _v104.ESP.Filled
end)
_v249(_v241, (_V9({146,23,9,201,209,28,140,29,58,173,3,30,204,204,11})), 0, 1, function()
return _v104.ESP.OutlineOpacity
end, function(_v457)
_v104.ESP.OutlineOpacity = _v457
end, false)
_v249(_v241, (_V9({155,11,17,201,152,61,153,92,22,180,22,4})), 0, 1, function()
return _v104.ESP.FillOpacity
end, function(_v457)
_v104.ESP.FillOpacity = _v457
end, false)
local _v141 = _v250(right, (_V9({153,16,28,210,209,28,142,29,48,142,50})))
_v258(_v141, (_V9({159,13,5,192,203})), function()
return _v104.Drawing.Boxes
end, function()
_v104.Drawing.Boxes = not _v104.Drawing.Boxes
end)
_v258(_v141, (_V9({137,16,28,198,221,0,154})), function()
return _v104.Drawing.Tracers
end, function()
_v104.Drawing.Tracers = not _v104.Drawing.Tracers
end)
local _v481 = _v250(right, (_V9({138,13,15,201,220})))
_v258(_v481, (_V9({155,23,17,201,218,0,128,90,29,169})), function()
return _v104.Visuals.Fullbright
end, function()
_v104.Visuals.Fullbright = not _v104.Visuals.Fullbright
end)
_v258(_v481, (_V9({147,13,93,227,215,21})), function()
return _v104.Visuals.NoFog
end, function()
_v104.Visuals.NoFog = not _v104.Visuals.NoFog
end)
_v232, right = _v246(_v203:add((_V9({158,13,17,202,202,1}))))
_v245(_v232, (_V9({146,23,9,201,209,28,140,29,54,178,14,18,215})), function()
return _v104.ESP.OutlineColor
end, function(c)
_v104.ESP.OutlineColor = c
end)
_v245(right, (_V9({155,11,17,201,152,49,134,81,26,175})), function()
return _v104.ESP.FillColor
end, function(c)
_v104.ESP.FillColor = c
end)
_v245(_v232, (_V9({159,13,5,133,251,29,133,82,7})), function()
return _v104.Drawing.BoxColor
end, function(c)
_v104.Drawing.BoxColor = c
end)
_v245(right, (_V9({137,16,28,198,221,0,201,126,26,177,13,15})), function()
return _v104.Drawing.TracerColor
end, function(c)
_v104.Drawing.TracerColor = c
end)
end
local function _v77(_v328, _v104)
_v231 = 0
local _v203 = _v256(_v328)
local _v232, right = _v246(_v203:add((_V9({144,13,11,192,213,23,135,73}))))
local _v164 = _v250(_v232, (_V9({155,14,4})))
_v258(_v164, (_V9({152,12,28,199,212,23,141})), function()
return _v104.Movement.FlyEnabled
end, function()
_v104.Movement.FlyEnabled = not _v104.Movement.FlyEnabled
end)
_v249(_v164, (_V9({155,14,4,133,235,2,140,88,17})), 10, 200, function()
return _v104.Movement.FlySpeed
end, function(_v457)
_v104.Movement.FlySpeed = _v457
end, true)
local _v396 = _v250(_v232, (_V9({142,18,24,192,220})))
_v258(_v396, (_V9({152,12,28,199,212,23,141})), function()
return _v104.Movement.SpeedEnabled
end, function()
_v104.Movement.SpeedEnabled = not _v104.Movement.SpeedEnabled
end)
_v249(_v396, (_V9({142,18,24,192,220})), 16, 100, function()
return _v104.Movement.Speed
end, function(_v457)
_v104.Movement.Speed = _v457
end, true)
local _v264 = _v250(_v232, (_V9({146,22,21,192,202})))
_v258(_v264, (_V9({141,23,17,214,221,82,193,124,27,169,11,80,233,217,21,139,92,22,182,75})), function()
return _v104.Movement.Pulse
end, function()
_v104.Movement.Pulse = not _v104.Movement.Pulse
end)
_v258(_v264, (_V9({147,13,30,201,209,2})), function()
return _v104.Movement.NoclipEnabled
end, function()
_v104.Movement.NoclipEnabled = not _v104.Movement.NoclipEnabled
end)
_v258(_v264, (_V9({148,12,27,204,214,27,157,88,85,151,23,16,213})), function()
return _v104.Movement.InfJumpEnabled
end, function()
_v104.Movement.InfJumpEnabled = not _v104.Movement.InfJumpEnabled
end)
local _v441 = _v250(right, (_V9({158,14,20,198,211,82,189,109})))
_v258(_v441, (_V9({152,12,28,199,212,23,141})), function()
return _v104.Movement.ClickTPEnabled
end, function()
_v104.Movement.ClickTPEnabled = not _v104.Movement.ClickTPEnabled
end)
_v253(_v441, (_V9({144,13,25,204,222,27,140,79,85,150,7,4})), function()
return _v104.Movement.ClickTPKey
end, function(_v223)
_v104.Movement.ClickTPKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({190,14,20,198,211,6,153})))
end)
end
local function _v78(_v328, _v104)
_v231 = 0
local _v203 = _v256(_v328)
local _v232, right = _v246(_v203:add((_V9({154,7,19,192,202,19,133}))))
local _v210 = _v250(_v232, (_V9({148,12,9,192,202,20,136,94,16})))
_v249(_v210, (_V9({136,43,93,246,219,19,133,88})), 0.8, 1.5, function()
return _v104.UI.Scale
end, function(_v457)
_v104.UI.Scale = _v457
if _v479 then
_v479.Scale = _v457
end
end, false)
_v258(_v210, (_V9({150,7,4,199,209,28,141,29,37,188,12,24,201})), function()
return _v104.UI.KeybindPanel
end, function()
_v104.UI.KeybindPanel = not _v104.UI.KeybindPanel
if _v226 then
_v226.Visible = _v104.UI.KeybindPanel
end
end)
_v258(_v210, (_V9({137,3,15,194,221,6,201,121,28,174,18,17,196,193})), function()
return _v104.UI.TargetDisplay
end, function()
_v104.UI.TargetDisplay = not _v104.UI.TargetDisplay
_v421 = _v104.UI.TargetDisplay
if not _v421 and _v422 then
_v422.Visible = false
end
end)
_v258(_v210, (_V9({155,50,46,133,251,29,156,83,1,184,16})), function()
return _v104.UI.FPSCounter
end, function()
_v104.UI.FPSCounter = not _v104.UI.FPSCounter
if _v172 then
_v172.Visible = _v104.UI.FPSCounter
end
end)
_v258(_v210, (_V9({138,3,9,192,202,31,136,79,30})), function()
return _v104.UI.Watermark
end, function()
_v104.UI.Watermark = not _v104.UI.Watermark
if _v475 then
_v475.Visible = _v104.UI.Watermark
end
end)
local _v43 = _v250(right, (_V9({156,1,30,202,205,28,157})))
_v254(_v43, (_V9({136,17,24,215,214,19,132,88})), _v22 and _v22.Name or (_V9({63,226,233})))
_v254(_v43, (_V9({153,11,14,213,212,19,144,29,59,188,15,24})), _v22 and _v22.DisplayName or (_V9({63,226,233})))
_v254(_v43, (_V9({136,17,24,215,152,59,173})), _v22 and tostring(_v22.UserId) or (_V9({63,226,233})))
_v258(_v43, (_V9({156,12,9,204,149,51,175,118})), function()
return _v104.Utility.AntiAFK
end, function()
_v104.Utility.AntiAFK = not _v104.Utility.AntiAFK
end)
_v244(_v43, (_V9({142,7,15,211,221,0,201,117,26,173})), function()
Utility:ServerHop()
end)
_v244(_v43, (_V9({143,7,23,202,209,28,201,110,16,175,20,24,215})), function()
Utility:Rejoin()
end)
_v232, right = _v246(_v203:add((_V9({158,13,19,195,209,21,154}))))
local _v94 = _v250(_v232, (_V9({158,13,19,195,209,21,154})))
if not _v8.isSupported() then
_v254(_v94, (_V9({142,22,28,209,205,1})), (_V9({136,12,14,208,200,2,134,79,1,184,6})))
return
end
local _v281 = _v257(_v94, (_V9({190,13,19,195,209,21,201,83,20,176,7,159,37,30})))
local _v237 = _v285((_V9({155,16,28,200,221})), {
Parent = _v94,
LayoutOrder = _v286(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = _v237,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v351
local function _v383(name)
_v281.Text = name
_v351()
end
_v351 = function()
for _, _v99 in ipairs(_v237:GetChildren()) do
if not _v99:IsA((_V9({136,43,49,204,203,6,165,92,12,178,23,9}))) then
_v99:Destroy()
end
end
local _v283 = _v8.list()
if #_v283 == 0 then
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v237,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({179,13,93,214,217,4,140,89,85,190,13,19,195,209,21,154})),
})
return
end
for i, name in ipairs(_v283) do
local _v384 = (_v281.Text == name)
local row = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v237,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v384 and _v4.accent or _v4.row,
BackgroundTransparency = _v384 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v384 and Color3.fromRGB(255, 255, 255) or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({253,66})) .. name,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v383(name)
end)
row.MouseEnter:Connect(function()
if _v281.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v4.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v281.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v4.row
end
end)
end
end
_v244(_v94, (_V9({142,3,11,192})), function()
local _v303, res = _v8.save(_v281.Text, _v104)
if _v303 then
UI:Notify((_V9({142,3,11,192,220,82,138,82,27,187,11,26,133,159})) .. res .. (_V9({250})), 2)
_v351()
else
UI:Notify(tostring(res), 3)
end
end)
_v244(_v94, (_V9({145,13,28,193})), function()
local _v303, res = _v8.load(_v281.Text, _v104)
if _v303 then
if _v479 then
_v479.Scale = _v104.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({145,13,28,193,221,22,201,94,26,179,4,20,194,152,85})) .. res .. (_V9({250})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v244(_v94, (_V9({153,7,17,192,204,23})), function()
local _v303, res = _v8.delete(_v281.Text)
if _v303 then
UI:Notify((_V9({153,7,17,192,204,23,141,29,22,178,12,27,204,223,82,206})) .. res .. (_V9({250})), 2)
_v281.Text = (_V9({}))
_v351()
else
UI:Notify(tostring(res), 3)
end
end, _v4.danger)
_v351()
end
local function _v79(_v104)
_v422 = _v285((_V9({155,16,28,200,221})), {
Parent = _v185,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v422, CornerRadius = UDim.new(0, 6) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v422, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = _v422,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = _v422,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v138 = _v285((_V9({155,16,28,200,221})), {
Parent = _v422,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v138, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v422,
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
local _v140, _v139, _v402
_v422.InputBegan:Connect(function(_v212)
if _v221(_v212) then
_v140 = true
_v139 = _v212.Position
_v402 = _v422.Position
end
end)
table.insert(_v270, function(_v212)
if _v140 and _v422 then
local delta = _v212.Position - _v139
_v422.Position = UDim2.new(
_v402.X.Scale,
_v402.X.Offset + delta.X,
_v402.Y.Scale,
_v402.Y.Offset + delta.Y
)
end
end)
table.insert(_v354, function()
_v140 = false
end)
table.insert(_v411, function()
_v421 = _v104.UI.TargetDisplay
if not _v421 and _v422 then
_v422.Visible = false
end
end)
_v421 = _v104.UI.TargetDisplay
end
local function _v75(_v104)
_v172 = _v285((_V9({155,16,28,200,221})), {
Parent = _v185,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v172, CornerRadius = UDim.new(0, 6) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v172, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = _v172,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = _v172,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v138 = _v285((_V9({155,16,28,200,221})), {
Parent = _v172,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v138, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v172,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({240,79,93,195,200,1})),
})
table.insert(_v411, function()
if _v172 then
_v172.Visible = _v104.UI.FPSCounter
end
end)
_v172.Visible = _v104.UI.FPSCounter
end
local function _v80(_v104)
_v475 = _v285((_V9({148,15,28,194,221,62,136,95,16,177})), {
Parent = _v185,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 14, 1, -14),
Size = UDim2.fromOffset(180, 64),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Fit,
Image = (_V9({})),
Visible = false,
})
UI:SetWatermarkImage(_v104.UI.WatermarkImageId)
table.insert(_v411, function()
if _v475 then
_v475.Visible = _v104.UI.Watermark
end
end)
_v475.Visible = _v104.UI.Watermark
end
local function _v76(_v104)
_v231 = 0
_v226 = _v285((_V9({155,16,28,200,221})), {
Parent = _v185,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
Visible = false,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v226, CornerRadius = UDim.new(0, 8) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v226, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), {
Parent = _v226,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = _v226,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v285((_V9({155,16,28,200,221})), {
Parent = _v226,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({150,7,4,199,209,28,141,78})),
})
local _v140, _v139, _v402
bar.InputBegan:Connect(function(_v212)
if _v221(_v212) then
_v140 = true
_v139 = _v212.Position
_v402 = _v226.Position
end
end)
table.insert(_v270, function(_v212)
if _v140 and _v226 then
local delta = _v212.Position - _v139
_v226.Position = UDim2.new(
_v402.X.Scale,
_v402.X.Offset + delta.X,
_v402.Y.Scale,
_v402.Y.Offset + delta.Y
)
end
end)
table.insert(_v354, function()
_v140 = false
end)
_v253(_v226, (_V9({144,7,19,208})), function()
return _v104.UI.MenuKey
end, function(_v223)
_v104.UI.MenuKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({176,7,19,208})))
end)
_v253(_v226, (_V9({156,11,16,199,215,6})), function()
return _v104.Camera.ToggleKey
end, function(_v223)
_v104.Camera.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({188,11,16,199,215,6})))
end)
_v253(_v226, (_V9({152,49,45})), function()
return _v104.ESP.ToggleKey
end, function(_v223)
_v104.ESP.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({184,17,13})))
end)
_v253(_v226, (_V9({155,45,43,133,251,27,155,94,25,184})), function()
return _v104.Camera.FOVCircleKey
end, function(_v223)
_v104.Camera.FOVCircleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({187,13,11,198,209,0,138,81,16})))
end)
_v253(_v226, (_V9({147,13,93,247,221,17,134,84,25})), function()
return _v104.NoRecoil.ToggleKey
end, function(_v223)
_v104.NoRecoil.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({179,13,15,192,219,29,128,81})))
end)
_v253(_v226, (_V9({147,13,93,246,200,0,140,92,17})), function()
return _v104.NoSpread.ToggleKey
end, function(_v223)
_v104.NoSpread.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({179,13,14,213,202,23,136,89})))
end)
_v253(_v226, (_V9({137,16,20,194,223,23,155,95,26,169})), function()
return _v104.Triggerbot.ToggleKey
end, function(_v223)
_v104.Triggerbot.ToggleKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({169,16,20,194,223,23,155,95,26,169})))
end)
_v253(_v226, (_V9({136,12,17,202,217,22})), function()
return _v104.UI.UnloadKey
end, function(_v223)
_v104.UI.UnloadKey = _v223
end, function(_v223)
return _v224(_v104, _v223, (_V9({168,12,17,202,217,22})))
end)
table.insert(_v411, function()
if _v226 then
_v226.Visible = _v104.UI.KeybindPanel
end
end)
_v226.Visible = _v104.UI.KeybindPanel
end
local function _v389(_v403)
if not _v243 or _v403 == visible then
return
end
visible = _v403
if _v46 and _v46.UI then
_v46.UI.Visible = _v403
end
if _v403 then
_v243.Visible = true
_v243.GroupTransparency = 1
_v37:Create(_v243, TweenInfo.new(_v14), { GroupTransparency = 0 }):Play()
else
local _v445 = _v37:Create(_v243, TweenInfo.new(_v14), { GroupTransparency = 1 })
_v445.Completed:Once(function()
if not visible and _v243 then
_v243.Visible = false
end
end)
_v445:Play()
end
end
function UI:Init(_v104, _v316)
if _v185 then
return
end
_v46 = _v104
_v317 = _v316
_v401()
_v185 = _v285((_V9({142,1,15,192,221,28,174,72,28})), {
Name = (_V9({139,3,19,204,204,11,174,88,27,184,16,28,201,237,59})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v303 = pcall(function()
_v185.Parent = Utility.getGuiParent()
end)
if not _v303 or not _v185.Parent then
_v185.Parent = _v22:WaitForChild((_V9({141,14,28,220,221,0,174,72,28})))
end
_v243 = _v285((_V9({158,3,19,211,217,1,174,79,26,168,18})), {
Parent = _v185,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v479 = _v285((_V9({136,43,46,198,217,30,140})), { Parent = _v243, Scale = _v104.UI.Scale })
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v243, CornerRadius = UDim.new(0, 8) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v243, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
local _v434 = _v285((_V9({155,16,28,200,221})), {
Parent = _v243,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v434, CornerRadius = UDim.new(0, 8) })
_v285((_V9({155,16,28,200,221})), {
Parent = _v434,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
local _v138 = _v285((_V9({155,16,28,200,221})), {
Parent = _v434,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v138, CornerRadius = UDim.new(1, 0) })
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v434,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({139,3,19,204,204,11,213,91,26,179,22,93,198,215,30,134,79,72,255,65,69,145,139,55,171,120,87,227,76,25,192,206,78,198,91,26,179,22,67,133,255,23,135,88,7,188,14}))
.. (_V9({225,4,18,203,204,82,138,82,25,178,16,64,135,155,74,168,10,54,156,82,95,155,152,82,201,255,194,253,66,93,211,136,78,198,91,26,179,22,67})),
ZIndex = 2,
})
_v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v434,
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
local _v140, _v139, _v402
_v434.InputBegan:Connect(function(_v212)
if _v221(_v212) then
_v140 = true
_v139 = _v212.Position
_v402 = _v243.Position
end
end)
table.insert(_v270, function(_v212)
if _v140 then
local delta = _v212.Position - _v139
_v243.Position = UDim2.new(
_v402.X.Scale,
_v402.X.Offset + delta.X,
_v402.Y.Scale,
_v402.Y.Offset + delta.Y
)
end
end)
table.insert(_v354, function()
_v140 = false
end)
local _v393 = _v285((_V9({155,16,28,200,221})), {
Parent = _v243,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v393, CornerRadius = UDim.new(0, 6) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v393, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = _v393,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v417 = _v285((_V9({155,16,28,200,221})), {
Parent = _v393,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v285((_V9({136,43,49,204,203,6,165,92,12,178,23,9})), { Parent = _v417, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v448 = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v393,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.danger,
Text = (_V9({136,12,17,202,217,22})),
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v448, CornerRadius = UDim.new(0, 6) })
local _v449 = _v285((_V9({136,43,46,209,202,29,130,88})), {
Parent = _v448,
Color = _v4.danger,
Thickness = 1,
Transparency = 0.55,
})
_v448.MouseButton1Click:Connect(function()
if _v317 then
_v317()
end
end)
_v448.MouseEnter:Connect(function()
_v37:Create(_v448, _v1, {
BackgroundColor3 = _v4.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v37:Create(_v449, _v1, { Transparency = 0 }):Play()
end)
_v448.MouseLeave:Connect(function()
_v37:Create(_v448, _v1, {
BackgroundColor3 = _v4.row,
TextColor3 = _v4.danger,
}):Play()
_v37:Create(_v449, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v285((_V9({155,16,28,200,221})), {
Parent = _v243,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v285((_V9({136,43,45,196,220,22,128,83,18})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v419 = { (_V9({158,13,16,199,217,6})), (_V9({139,11,14,208,217,30})), (_V9({144,13,11,192,213,23,135,73})), (_V9({142,7,9,209,209,28,142,78})) }
local _v416 = {}
for i, _v418 in ipairs(_v419) do
local _v215 = _v111 == _v418
local _v414 = _v285((_V9({137,7,5,209,250,7,157,73,26,179})), {
Parent = _v417,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.rowHover,
BackgroundTransparency = _v215 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v215 and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({253,66,93,133})) .. _v418,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v414, CornerRadius = UDim.new(0, 6) })
local stripe = _v285((_V9({155,16,28,200,221})), {
Parent = _v414,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
Visible = _v215,
ZIndex = 2,
})
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v415 = _v285((_V9({155,16,28,200,221})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v215,
})
_v416[_v418] = { btn = _v414, frame = _v415, stripe = stripe }
_v414.MouseButton1Click:Connect(function()
_v111 = _v418
for name, _v413 in pairs(_v416) do
local _v44 = name == _v418
_v413.frame.Visible = _v44
_v413.stripe.Visible = _v44
_v37:Create(_v413.btn, _v1, {
BackgroundTransparency = _v44 and 0 or 1,
TextColor3 = _v44 and _v4.text or _v4.textSub,
}):Play()
end
end)
_v414.MouseEnter:Connect(function()
if _v111 ~= _v418 then
_v37:Create(_v414, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v414.MouseLeave:Connect(function()
if _v111 ~= _v418 then
_v37:Create(_v414, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v72(_v416[(_V9({158,13,16,199,217,6}))].frame, _v104)
_v73(_v416[(_V9({139,11,14,208,217,30}))].frame, _v104)
_v77(_v416[(_V9({144,13,11,192,213,23,135,73}))].frame, _v104)
_v78(_v416[(_V9({142,7,9,209,209,28,142,78}))].frame, _v104)
_v76(_v104)
_v79(_v104)
_v75(_v104)
_v80(_v104)
if _v104.UI.Visible then
_v389(true)
end
end
function UI:Toggle()
_v389(not visible)
end
function UI:Show()
_v389(true)
end
function UI:Hide()
_v389(false)
end
function UI:SetCurrentTarget(name)
if not _v422 then
return
end
if _v422.Visible ~= _v421 then
_v422.Visible = _v421
end
if not _v421 or not targetPanelLabel then
return
end
local _v392, colour
if name and name ~= (_V9({})) and name ~= (_V9({147,13,19,192})) then
_v392, colour = name, (_V9({254,90,73,150,253,48,172}))
else
_v392, colour = (_V9({136,12,54,203,215,5,135})), (_V9({254,90,60,146,251,51,217}))
end
local text = (_V9({137,3,15,194,221,6,211,29,73,187,13,19,209,152,17,134,81,26,175,95,95})) .. colour .. (_V9({255,92})) .. _v392 .. (_V9({225,77,27,202,214,6,215}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v170)
if not fpsLabel or not _v172 or not _v172.Visible then
return
end
local text = string.format((_V9({225,4,18,203,204,82,138,82,25,178,16,64,135,155,74,221,14,48,159,39,95,155,157,22,213,18,19,178,12,9,155,152,20,153,78})), _v170 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v209)
if not _v475 then
return
end
local _v130 = tostring(_v209 or (_V9({}))):match((_V9({248,6,86})))
_v475.Image = _v130 and ((_V9({175,0,5,196,203,1,140,73,28,185,88,82,138})) .. _v130) or (_V9({}))
end
function UI:SyncControls()
for _, _v166 in ipairs(_v411) do
_v166()
end
end
function UI:IsCapturingKey()
return _v89
end
function UI:Notify(text, _v146)
if not _v185 then
return
end
_v146 = _v146 or 3
local _v435 = _v285((_V9({137,7,5,209,244,19,139,88,25})), {
Parent = _v185,
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
_v285((_V9({136,43,62,202,202,28,140,79})), { Parent = _v435, CornerRadius = UDim.new(0, 8) })
_v285((_V9({136,43,46,209,202,29,130,88})), { Parent = _v435, Color = _v4.accent, Thickness = 1, Transparency = 0.3 })
_v37:Create(_v435, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v146, function()
if _v435 and _v435.Parent then
local _v326 = _v37:Create(_v435, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v326.Completed:Once(function()
if _v435 then
_v435:Destroy()
end
end)
_v326:Play()
end
end)
end
function UI:Cleanup()
for _, _v107 in ipairs(_v446) do
_v107:Disconnect()
end
table.clear(_v446)
table.clear(_v270)
table.clear(_v354)
table.clear(_v411)
_v45 = nil
_v89 = false
_v47 = nil
_v422, targetPanelLabel = nil, nil
_v421 = false
_v226 = nil
_v475 = nil
_v172, fpsLabel = nil, nil
_v479 = nil
if _v185 then
_v185:Destroy()
_v185 = nil
_v243 = nil
end
visible = false
end
return UI
end)()
Movement = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v38 = game:GetService((_V9({136,17,24,215,241,28,153,72,1,142,7,15,211,209,17,140})))
local _v41 = game:GetService((_V9({138,13,15,206,203,2,136,94,16})))
local _v22 = _v26.LocalPlayer
local UI = UI
local Movement = {}
local _v2 = 16
local _v19 = 50
local _v274
local _v272
local function _v271()
local _v96 = _v22.Character
local root = _v96 and _v96:FindFirstChild((_V9({149,23,16,196,214,29,128,89,39,178,13,9,245,217,0,157})))
local humanoid = _v96 and _v96:FindFirstChildOfClass((_V9({149,23,16,196,214,29,128,89})))
if not (_v96 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v96, root, humanoid
end
local function _v273(_v81)
local _v241 = _v81.CFrame.LookVector
local _v163 = Vector3.new(_v241.X, 0, _v241.Z)
if _v163.Magnitude < 0.001 then
_v163 = Vector3.new(0, 0, -1)
else
_v163 = _v163.Unit
end
local right = _v81.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v269 = Vector3.zero
if _v38:IsKeyDown(Enum.KeyCode.W) then
_v269 = _v269 + _v163
end
if _v38:IsKeyDown(Enum.KeyCode.S) then
_v269 = _v269 - _v163
end
if _v38:IsKeyDown(Enum.KeyCode.D) then
_v269 = _v269 + right
end
if _v38:IsKeyDown(Enum.KeyCode.A) then
_v269 = _v269 - right
end
if _v38:IsKeyDown(Enum.KeyCode.Space) then
_v269 = _v269 + Vector3.yAxis
end
if _v38:IsKeyDown(Enum.KeyCode.LeftShift) then
_v269 = _v269 - Vector3.yAxis
end
if _v269.Magnitude > 0 then
return _v269.Unit
end
return nil
end
local _v25 = 0.2
local _v24 = 0.5
local function _v277(_v104)
if _v104.Pulse == false then
return true
end
return (os.clock() % _v25) < (_v25 * _v24)
end
function Movement:Update(_v145, _v104)
local _v96, root, humanoid = _v271()
if _v104.NoclipEnabled and _v96 then
for _, _v329 in ipairs(_v96:GetDescendants()) do
if _v329:IsA((_V9({159,3,14,192,232,19,155,73}))) then
_v329.CanCollide = false
end
end
end
if not root then
return
end
if _v104.FlyEnabled then
local _v81 = _v41.CurrentCamera
if _v81 then
local _v462 = Vector3.zero
if not UI:IsCapturingKey() then
local _v131 = _v273(_v81)
if _v131 then
local _v396 = _v104.FlySpeed or 50
if not _v277(_v104) then
_v396 = math.min(_v396, _v2)
end
_v462 = _v131 * _v396
end
end
root.AssemblyLinearVelocity = _v462
end
return
end
if _v104.SpeedEnabled then
local _v396 = _v104.Speed or _v2
local _v269 = humanoid.MoveDirection
if _v396 > _v2 and _v269.Magnitude > 0 and _v277(_v104) then
local _v462 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v269.X * _v396, _v462.Y, _v269.Z * _v396)
end
end
end
local function _v276(_v104)
if not _v104.InfJumpEnabled then
return
end
local _, root = _v271()
if root then
local _v462 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v462.X, _v19, _v462.Z)
end
end
local function _v275(_v104, _v212, _v177)
if _v177 or UI:IsCapturingKey() then
return
end
if not _v104.ClickTPEnabled then
return
end
if _v212.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v38:IsKeyDown(_v104.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _, root = _v271()
local _v268 = _v22:GetMouse()
if root and _v268 and _v268.Hit then
root.CFrame = CFrame.new(_v268.Hit.Position + Vector3.new(0, 3, 0))
end
end
function Movement:Init(_v104)
if not _v274 then
_v274 = _v38.JumpRequest:Connect(function()
_v276(_v104)
end)
end
if not _v272 then
_v272 = _v38.InputBegan:Connect(function(_v212, _v177)
_v275(_v104, _v212, _v177)
end)
end
end
function Movement:Cleanup()
if _v274 then
_v274:Disconnect()
_v274 = nil
end
if _v272 then
_v272:Disconnect()
_v272 = nil
end
end
return Movement
end)()
_v10 = (function()
local _v26 = game:GetService((_V9({141,14,28,220,221,0,154})))
local _v31 = game:GetService((_V9({143,23,19,246,221,0,159,84,22,184})))
local _v38 = game:GetService((_V9({136,17,24,215,241,28,153,72,1,142,7,15,211,209,17,140})))
local _v22 = _v26.LocalPlayer
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
local _v40 = _v40
local _v10 = {}
_v10.Version = (_V9({237}))
_v10.Config = _v9
_v40.Version = _v10.Version
local _v370 = false
local _v108 = {}
local _v53 = false
local _v27 = (_V9({139,3,19,204,204,11,174,88,27,184,16,28,201,234,23,138,82,28,177}))
local _v183 = {}
local _v16 = 5
local function _v184(name, _v166, ...)
local _v303, res = pcall(_v166, ...)
if _v303 then
local _v400 = _v183[name]
if _v400 then
_v400.failures = 0
end
return true, res
end
local _v400 = _v183[name]
if not _v400 then
_v400 = { failures = 0, lastWarn = -math.huge }
_v183[name] = _v400
end
_v400.failures = _v400.failures + 1
local _v287 = os.clock()
if _v287 - _v400.lastWarn >= _v16 then
_v400.lastWarn = _v287
warn(string.format((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,80,174,66,27,196,209,30,140,89,85,245,26,88,193,145,72,201,24,6})), name, _v400.failures, tostring(res)))
end
return false, nil
end
function _v10.IsRunning()
return _v370
end
function _v10.SaveConfig(name)
return _v8.save(name, _v9)
end
function _v10.LoadConfig(name)
local _v303, res = _v8.load(name, _v9)
if _v303 then
pcall(function()
UI:SyncControls()
end)
end
return _v303, res
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
function _v10.SetWatermarkImage(_v209)
_v9.UI.WatermarkImageId = tostring(_v209 or (_V9({})))
UI:SetWatermarkImage(_v9.UI.WatermarkImageId)
return _v10
end
function _v10.SetWebhook(_v455)
return _v40.SetWebhook(_v455)
end
function _v10.HasWebhook()
return _v40.HasWebhook()
end
function _v10.SendWebhook(content, _v323)
return _v40.SendWebhook(content, _v323)
end
function _v10.SendLoadedEmbed(_v217)
return _v40.SendLoadedEmbed(_v217)
end
function _v10.Start()
if _v370 then
return _v10
end
_v370 = true
local _v303, err = pcall(function()
ESP:Init()
UI:Init(_v9, function()
_v10.Stop()
end)
Movement:Init(_v9.Movement)
SilentAim:Init(_v9.SilentAim)
Utility:Init(_v9.Utility)
table.insert(_v108, _v26.PlayerAdded:Connect(function(_v338)
_v184((_V9({141,14,28,220,221,0,168,89,17,184,6})), ESP.OnPlayerAdded, ESP, _v338)
end))
table.insert(_v108, _v26.PlayerRemoving:Connect(function(_v338)
_v184((_V9({141,14,28,220,221,0,187,88,24,178,20,20,203,223})), ESP.OnPlayerRemoving, ESP, _v338)
end))
table.insert(_v108, _v38.InputBegan:Connect(function(_v212, _v177)
if _v177 or UI:IsCapturingKey() then
return
end
_v184((_V9({150,7,4,199,209,28,141,78})), function()
local _v223 = _v212.KeyCode
if _v223 == _v9.UI.MenuKey then
UI:Toggle()
elseif _v223 == _v9.UI.UnloadKey then
_v10.Stop()
else
local _v436 = {
{ _v9.Camera, (_V9({152,12,28,199,212,23,141})), _v9.Camera.ToggleKey },
{ _v9.ESP, (_V9({152,12,28,199,212,23,141})), _v9.ESP.ToggleKey },
{ _v9.Camera, (_V9({155,45,43,230,209,0,138,81,16})), _v9.Camera.FOVCircleKey },
{ _v9.NoRecoil, (_V9({152,12,28,199,212,23,141})), _v9.NoRecoil.ToggleKey },
{ _v9.NoSpread, (_V9({152,12,28,199,212,23,141})), _v9.NoSpread.ToggleKey },
{ _v9.Triggerbot, (_V9({152,12,28,199,212,23,141})), _v9.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v436) do
if _v223 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v171, fpsFrames = 0, 0
table.insert(_v108, _v31.RenderStepped:Connect(function(_v145)
_v184((_V9({158,3,19,193,209,22,136,73,16,174})), _v7.Update, _v7, _v9.Camera, _v9.ESP)
_v184((_V9({152,49,45})), ESP.Update, ESP, _v9.ESP)
local _v305, target = _v184((_V9({156,11,16,199,215,6})), _v6.Update, _v6, _v9.Camera, _v9.Debug)
if not _v305 then
target = nil
end
if _v9.UI.TargetDisplay then
_v184((_V9({137,3,15,194,221,6,201,89,28,174,18,17,196,193})), function()
local _v242 = _v6:GetLookTarget(_v9.ESP, _v9.Camera)
UI:SetCurrentTarget(_v242 and _v242.Name or nil)
end)
end
_v53 = _v9.Camera.Enabled and target ~= nil
_v184((_V9({147,13,46,213,202,23,136,89})), NoSpread.Update, NoSpread, _v9.NoSpread)
_v184((_V9({137,16,20,194,223,23,155,95,26,169})), Triggerbot.Update, Triggerbot, _v9.Triggerbot, _v9.Camera)
_v184((_V9({144,13,11,192,213,23,135,73})), Movement.Update, Movement, _v145, _v9.Movement)
_v184((_V9({149,11,9,199,215,10})), _v18.Update, _v18, _v9.Hitbox, _v9.Camera)
_v184((_V9({153,16,28,210,209,28,142,29,48,142,50})), _v13.Update, _v13, _v9.Drawing, _v9.Camera)
_v184((_V9({139,11,14,208,217,30,154})), Visuals.Update, Visuals, _v9.Visuals)
_v171 = _v171 + _v145
fpsFrames = fpsFrames + 1
if _v171 >= 0.25 then
local _v170 = math.floor(fpsFrames / _v171 + 0.5)
_v171, fpsFrames = 0, 0
if _v9.UI.FPSCounter then
_v184((_V9({155,50,46,133,219,29,156,83,1,184,16})), UI.UpdateFPS, UI, _v170)
end
end
end))
pcall(function()
_v31:UnbindFromRenderStep(_v27)
end)
pcall(function()
_v31:BindToRenderStep(_v27, Enum.RenderPriority.Camera.Value + 1, function()
_v184((_V9({147,13,47,192,219,29,128,81})), NoRecoil.Update, NoRecoil, _v9.NoRecoil, _v53)
end)
end)
end)
if not _v303 then
warn((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,51,188,11,17,192,220,82,157,82,85,174,22,28,215,204,72})), err)
_v10.Stop()
return _v10
end
if getgenv then
getgenv().VanityGeneral = _v10
end
UI:Notify(string.format((_V9({139,3,19,204,204,11,196,122,16,179,7,15,196,212,82,133,82,20,185,7,25,133,152,144,105,159,85,253,50,15,192,203,1,201,24,6})), _v9.UI.MenuKey.Name), 4)
print(string.format((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,39,168,12,19,204,214,21,201,21,3,248,17,84})), _v10.Version))
print(string.format((_V9({144,7,19,208,130,82,204,78,85,253,30,93,133,251,19,132,88,7,188,88,93,128,203,82,201,65,85,253,55,19,201,215,19,141,7,85,248,17})),
_v9.UI.MenuKey.Name,
_v9.Camera.ToggleKey.Name,
_v9.UI.UnloadKey.Name))
if _v40.HasWebhook() then
task.spawn(function()
_v40.SendLoadedEmbed(false)
end)
end
return _v10
end
function _v10.Stop()
if not _v370 then
return _v10
end
_v370 = false
for _, _v107 in ipairs(_v108) do
pcall(function()
_v107:Disconnect()
end)
end
table.clear(_v108)
pcall(function()
_v31:UnbindFromRenderStep(_v27)
end)
_v53 = false
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
table.clear(_v183)
print((_V9({134,52,28,203,209,6,144,16,50,184,12,24,215,217,30,180,29,38,169,13,13,213,221,22})))
return _v10
end
function _v10.Toggle()
if _v370 then
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
local _v344 = getgenv().VanityGeneral
if _v344 and _v344 ~= _v10 and type(_v344.Stop) == (_V9({187,23,19,198,204,27,134,83})) then
pcall(_v344.Stop)
end
end
pcall(function()
_v10.Start()
end)
return _v10
end
