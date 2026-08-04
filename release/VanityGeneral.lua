local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({41,113,184,51,26,158,110,133,163})
local _v9
local _v8
local Utility
local _v7
local ESP
local _v13
local Visuals
local _v49
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
Hitbox = (_V9({123,16,214,87,117,243,78,173,244,76,24,223,91,110,251,10,172})),
HitboxOptions = { (_V9({123,16,214,87,117,243,78,173,244,76,24,223,91,110,251,10,172})), (_V9({97,20,217,87})), (_V9({125,30,202,64,117})), (_V9({104,3,213,64})), (_V9({101,20,223,64})) },
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
WatermarkImageId = (_V9({24,66,129,11,46,171,88,188,144,17,68,128,11,47,168})),
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
Hitbox = (_V9({123,16,214,87,117,243,78,173,244,76,24,223,91,110,251,10,172})),
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
function _v9.reset()
for _v418, _v505 in pairs(_v11) do
for _v254, value in pairs(_v505) do
if type(_v503) == (_V9({93,16,218,95,127})) then
local target = _v9[_v418][_v254]
if type(_v461) ~= (_V9({93,16,218,95,127})) then
target = {}
_v9[_v418][_v254] = _v461
end
for k, v in pairs(_v503) do
target[k] = v
end
else
_v9[_v418][_v254] = _v503
end
end
end
end
return _v9
end)()
_v8 = (function()
local _v8 = {}
local _v5 = (_V9({127,16,214,90,110,231,41,224,205,76,3,217,95}))
local _v36 = { (_V9({106,16,213,86,104,255})), (_V9({108,34,232})), (_V9({103,30,234,86,121,241,7,233})), (_V9({103,30,235,67,104,251,15,225})), (_V9({100,30,206,86,119,251,0,241})), (_V9({122,24,212,86,116,234,47,236,206})), (_V9({97,24,204,81,117,230})), (_V9({109,3,217,68,115,240,9})), (_V9({127,24,203,70,123,242,29})), (_V9({124,5,209,95,115,234,23})), (_V9({124,56})) }
local function _v199()
return type(writefile) == (_V9({79,4,214,80,110,247,1,235}))
and type(readfile) == (_V9({79,4,214,80,110,247,1,235}))
and type(listfiles) == (_V9({79,4,214,80,110,247,1,235}))
end
local function _v167()
if type(isfolder) == (_V9({79,4,214,80,110,247,1,235})) and type(makefolder) == (_V9({79,4,214,80,110,247,1,235})) then
if not isfolder(_v5) then
pcall(makefolder, _v5)
end
end
end
local function _v414(name)
return (tostring(_v312 or (_V9({}))):gsub((_V9({114,47,157,68,69,187,67,165,254})), (_V9({}))):gsub((_V9({119,84,203,24})), (_V9({}))):gsub((_V9({12,2,147,23})), (_V9({}))))
end
local function _v366(name)
return _v5 .. (_V9({6,1,202,92,124,247,2,224,252})) .. game.PlaceId .. (_V9({118})) .. _v312 .. (_V9({7,27,203,92,116}))
end
local function _v266(name)
return _v5 .. (_V9({6})) .. _v312 .. (_V9({7,27,203,92,116}))
end
local function _v166(v)
local t = typeof(v)
if t == (_V9({106,30,212,92,104,173})) then
return { __t = (_V9({106,30,212,92,104,173})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({108,31,205,94,83,234,11,232})) then
return { __t = (_V9({108,31,205,94})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({93,16,218,95,127})) then
local _v360 = {}
for k, _v501 in pairs(v) do
if type(_v501) ~= (_V9({79,4,214,80,110,247,1,235})) then
local _v165 = _v166(_v501)
if _v165 ~= nil then
_v360[k] = _v165
end
end
end
return _v360
elseif t == (_V9({71,4,213,81,127,236})) or t == (_V9({90,5,202,90,116,249})) or t == (_V9({75,30,215,95,127,255,0})) then
return v
end
return nil
end
local function _v140(v)
if type(v) ~= (_V9({93,16,218,95,127})) then
return v
end
if v.__t == (_V9({106,30,212,92,104,173})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({108,31,205,94})) then
local _v335, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v335 then
return _v252
end
return nil
end
return v
end
local function _v67(target, _v438)
for k, v in pairs(_v438) do
if type(v) == (_V9({93,16,218,95,127})) and v.__t == nil then
if type(target[k]) == (_V9({93,16,218,95,127})) then
_v67(target[k], v)
end
else
local _v141 = _v140(v)
if _v141 ~= nil then
target[k] = _v141
end
end
end
end
function _v8.isSupported()
return _v199()
end
function _v8.list()
local _v360 = {}
if not _v199() then
return _v360
end
_v167()
local _v335, files = pcall(listfiles, _v5)
if not _v335 or type(_v181) ~= (_V9({93,16,218,95,127})) then
return _v360
end
for _, _v365 in ipairs(_v181) do
local _v377 = (_V9({89,3,215,85,115,242,11,218})) .. game.PlaceId .. (_V9({118}))
local name = tostring(_v365):match((_V9({1,42,230,28,70,195,69,172,134,7,27,203,92,116,186})))
if _v312 and name:sub(1, #_v377) == _v377 then
table.insert(_v360, name:sub(#_v377 + 1))
end
end
table.sort(_v360)
return _v360
end
function _v8.save(name, _v117)
if not _v199() then
return false, (_V9({125,25,209,64,58,251,22,224,192,92,5,215,65,58,246,15,246,131,71,30,152,85,115,242,11,165,226,121,56}))
end
name = _v414(_v312)
if _v312 == (_V9({})) then
return false, (_V9({108,31,204,86,104,190,15,165,192,70,31,222,90,125,190,0,228,206,76}))
end
_v167()
local data = {}
for _, _v418 in ipairs(_v36) do
if type(_v117[_v418]) == (_V9({93,16,218,95,127})) then
data[_v418] = _v166(_v117[_v418])
end
end
local _v339, json = pcall(function()
return game:GetService((_V9({97,5,204,67,73,251,28,243,202,74,20}))):JSONEncode(_v131)
end)
if not _v339 then
return false, (_V9({108,31,219,92,126,251,78,227,194,64,29,221,87,32,190})) .. tostring(_v253)
end
local _v342, err = pcall(writefile, _v366(_v312), _v253)
if not _v342 then
return false, (_V9({126,3,209,71,127,190,8,228,202,69,20,220,9,58})) .. tostring(_v171)
end
return true, _v312
end
function _v8.load(name, _v117)
if not _v199() then
return false, (_V9({125,25,209,64,58,251,22,224,192,92,5,215,65,58,246,15,246,131,71,30,152,85,115,242,11,165,226,121,56}))
end
name = _v414(_v312)
if _v312 == (_V9({})) then
return false, (_V9({108,31,204,86,104,190,15,165,192,70,31,222,90,125,190,0,228,206,76}))
end
local _v365 = _v366(_v312)
if type(isfile) == (_V9({79,4,214,80,110,247,1,235})) then
local _v338, exists = pcall(isfile, _v365)
if _v338 and not _v177 then
local _v264 = _v266(_v312)
local _v340, legacyExists = pcall(isfile, _v264)
if _v340 and _v265 then
_v365 = _v264
else
return false, (_V9({103,30,152,80,117,240,8,236,196,9,31,217,94,127,250,78,162})) .. _v312 .. (_V9({14}))
end
end
end
local _v341, raw = pcall(readfile, _v365)
if not _v341 or type(_v383) ~= (_V9({90,5,202,90,116,249})) then
return false, (_V9({123,20,217,87,58,248,15,236,207,76,21}))
end
local _v339, data = pcall(function()
return game:GetService((_V9({97,5,204,67,73,251,28,243,202,74,20}))):JSONDecode(_v383)
end)
if not _v339 or type(_v131) ~= (_V9({93,16,218,95,127})) then
return false, (_V9({125,25,217,71,58,248,7,233,198,9,24,203,93,61,234,78,243,194,69,24,220,19,80,205,33,203}))
end
for _, _v418 in ipairs(_v36) do
if type(data[_v418]) == (_V9({93,16,218,95,127})) and type(_v117[_v418]) == (_V9({93,16,218,95,127})) then
_v67(_v117[_v418], data[_v418])
end
end
return true, _v312
end
function _v8.delete(name)
name = _v414(_v312)
if _v312 == (_V9({})) then
return false, (_V9({108,31,204,86,104,190,15,165,192,70,31,222,90,125,190,0,228,206,76}))
end
if type(delfile) ~= (_V9({79,4,214,80,110,247,1,235})) then
return false, (_V9({125,25,209,64,58,251,22,224,192,92,5,215,65,58,253,15,235,132,93,81,220,86,118,251,26,224,131,79,24,212,86,105}))
end
local _v335, err = pcall(delfile, _v366(_v312))
if not _v335 then
return false, tostring(_v171)
end
return true, _v312
end
return _v8
end)()
Utility = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v41 = game:GetService((_V9({125,20,212,86,106,241,28,241,240,76,3,206,90,121,251})))
local _v25 = _v30.LocalPlayer
local Utility = {}
local _v41 = game:GetService((_V9({125,20,212,86,106,241,28,241,240,76,3,206,90,121,251})))
local _v500
function Utility:Init(_v117)
if _v500 then
return
end
local _v520 = (type(VirtualUser) ~= (_V9({71,24,212})) and VirtualUser) or nil
if not _v520 then
pcall(function()
_v520 = game:GetService((_V9({127,24,202,71,111,255,2,208,208,76,3})))
end)
end
if not _v520 then
return
end
_v500 = _v25.Idled:Connect(function()
if _v117.AntiAFK then
_v520:CaptureController()
_v520:ClickButton2(Vector2.new())
end
end)
end
function Utility:Cleanup()
if _v500 then
_v500:Disconnect()
_v500 = nil
end
end
function Utility:ServerHop()
local _v335, err = pcall(function()
_v41:Teleport(game.PlaceId, _v25)
end)
if not _v335 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,240,76,3,206,86,104,190,6,234,211,9,23,217,90,118,251,10,191})), _v171)
end
return _v335
end
function Utility:Rejoin()
local _v335, err = pcall(function()
_v41:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v25)
end)
if not _v335 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,241,76,27,215,90,116,190,8,228,202,69,20,220,9})), _v171)
end
return _v335
end
function Utility.getGuiParent()
local _v335, hidden = pcall(function()
return gethui and gethui()
end)
if _v335 and _v223 then
return _v223
end
local _v336, coreGui = pcall(function()
return game:GetService((_V9({106,30,202,86,93,235,7})))
end)
if _v336 and _v125 then
return _v125
end
return _v25:WaitForChild((_V9({121,29,217,74,127,236,41,240,202})))
end
return _v46
end)()
_v7 = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v50 = game:GetService((_V9({126,30,202,88,105,238,15,230,198})))
local _v25 = _v30.LocalPlayer
local Utility = _v46
local _v7 = {}
local _v3 = 0.5
local _v77 = {}
local _v78 = -math.huge
local function _v202()
local _v319 = os.clock()
if _v319 - _v78 < _v3 then
return _v77
end
_v78 = _v319
table.clear(_v77)
for _, _v143 in ipairs(_v50:GetDescendants()) do
if _v143:IsA((_V9({100,30,220,86,118})))
and _v143:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
and not _v30:GetPlayerFromCharacter(_v143)
then
table.insert(_v77, _v143)
end
end
return _v77
end
local Camera = _v50.CurrentCamera
local _v102 = Random.new()
local _v33 = {
Head = { (_V9({97,20,217,87})) },
Torso = { (_V9({124,1,200,86,104,202,1,247,208,70})), (_V9({101,30,207,86,104,202,1,247,208,70})), (_V9({125,30,202,64,117})), (_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})) },
Arms = {
(_V9({101,20,222,71,82,255,0,225})), (_V9({123,24,223,91,110,214,15,235,199})),
(_V9({101,20,222,71,86,241,25,224,209,104,3,213})), (_V9({123,24,223,91,110,210,1,242,198,91,48,202,94})),
(_V9({101,20,222,71,79,238,30,224,209,104,3,213})), (_V9({123,24,223,91,110,203,30,245,198,91,48,202,94})),
(_V9({101,20,222,71,58,223,28,232})), (_V9({123,24,223,91,110,190,47,247,206})),
},
Legs = {
(_V9({101,20,222,71,92,241,1,241})), (_V9({123,24,223,91,110,216,1,234,215})),
(_V9({101,20,222,71,86,241,25,224,209,101,20,223})), (_V9({123,24,223,91,110,210,1,242,198,91,61,221,84})),
(_V9({101,20,222,71,79,238,30,224,209,101,20,223})), (_V9({123,24,223,91,110,203,30,245,198,91,61,221,84})),
(_V9({101,20,222,71,58,210,11,226})), (_V9({123,24,223,91,110,190,34,224,196})),
},
}
local _v32 = { (_V9({97,20,217,87})), (_V9({125,30,202,64,117})), (_V9({104,3,213,64})), (_V9({101,20,223,64})) }
local _v403 = Random.new()
local function _v369(_v107, _v389)
local _v315 = _v33[_v389]
if not _v315 then
return nil
end
for _, name in ipairs(_v315) do
local _v364 = _v107:FindFirstChild(_v312)
if _v364 and _v364:IsA((_V9({107,16,203,86,74,255,28,241}))) then
return _v364
end
end
return nil
end
local function _v368(_v107)
for _, _v389 in ipairs(_v32) do
local _v364 = _v369(_v107, _v389)
if _v364 then
return _v364
end
end
for _, _v143 in ipairs(_v107:GetDescendants()) do
if _v143:IsA((_V9({107,16,203,86,74,255,28,241}))) then
return _v143
end
end
return nil
end
local function _v65(_v107)
return _v107:FindFirstChild((_V9({97,20,217,87})))
or _v107:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
or _v107:FindFirstChild((_V9({124,1,200,86,104,202,1,247,208,70})))
or _v107:FindFirstChild((_V9({125,30,202,64,117})))
or _v368(_v107)
end
local function _v405(_v523)
local _v484 = 0
for _, _v389 in ipairs(_v32) do
_v484 = _v484 + math.max(0, (_v523 and _v523[_v389]) or 0)
end
if _v484 <= 0 then
return (_V9({97,20,217,87}))
end
local _v404 = _v403:NextNumber() * _v484
local _v51 = 0
for _, _v389 in ipairs(_v32) do
_v51 = _v51 + math.max(0, _v523[_v389] or 0)
if _v404 <= _v51 then
return _v389
end
end
return (_V9({97,20,217,87}))
end
local function _v206(_v529)
local _v508, visible = Camera:WorldToViewportPoint(_v529)
if not _v509 or _v508.Z < 0 then
return math.huge
end
local _v417 = Vector2.new(_v508.X, _v508.Y)
local _v103 = Camera.ViewportSize / 2
return (_v417 - _v103).Magnitude
end
local function _v251(_v376, _v107)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v25.Character }
local _v399 = _v50:Raycast(Camera.CFrame.Position, _v376 - Camera.CFrame.Position, _v362)
return not _v399 or _v399.Instance:IsDescendantOf(_v107)
end
local _v16 = Color3.fromRGB(132, 62, 190)
local _v188, _v189, fovStroke
local function _v168()
if _v189 and _v189.Parent then
return _v189
end
_v188 = Instance.new((_V9({122,18,202,86,127,240,41,240,202})))
_v188.Name = (_V9({127,16,214,90,110,231,41,224,205,76,3,217,95,92,209,56}))
_v188.ResetOnSpawn = false
_v188.IgnoreGuiInset = true
_v188.DisplayOrder = 998
local _v335 = pcall(function()
_v188.Parent = Utility.getGuiParent()
end)
if not _v335 or not _v188.Parent then
_v188.Parent = _v25:WaitForChild((_V9({121,29,217,74,127,236,41,240,202})))
end
_v189 = Instance.new((_V9({111,3,217,94,127})))
_v189.Name = (_V9({123,24,214,84}))
_v189.AnchorPoint = Vector2.new(0.5, 0.5)
_v189.Position = UDim2.fromScale(0.5, 0.5)
_v189.BackgroundTransparency = 1
_v189.BorderSizePixel = 0
_v189.Parent = _v188
local _v126 = Instance.new((_V9({124,56,251,92,104,240,11,247})))
_v126.CornerRadius = UDim.new(1, 0)
_v126.Parent = _v189
fovStroke = Instance.new((_V9({124,56,235,71,104,241,5,224})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v16
fovStroke.Parent = _v189
return _v189
end
local function _v495(_v117)
local _v428 = _v117.FOVCircle
if not _v428 then
if _v189 then
_v189.Visible = false
end
return
end
local _v402 = _v168()
if not _v402 then
return
end
local _v147 = math.max(0, _v117.FOV or 0) * 2
_v402.Size = UDim2.fromOffset(_v147, _v147)
_v402.Visible = true
end
local function _v146()
if _v188 then
pcall(function()
_v188:Destroy()
end)
end
_v188, _v189, fovStroke = nil, nil, nil
end
local function _v175(_v107, _v373, _v117)
if not _v107 then
return nil
end
if _v117.TeamCheck and _v373 and _v373.Team ~= nil and _v373.Team == _v25.Team then
return nil
end
local humanoid = _v107:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
if not _v237 or humanoid.Health <= 0 then
return nil
end
local _v64 = _v65(_v107)
if not _v64 then
return nil
end
local _v152 = _v206(_v64.Position)
if _v152 >= (_v117.FOV or 200) then
return nil
end
local _v528 = (_v64.Position - Camera.CFrame.Position).Magnitude
if _v528 > _v117.MaxDistance then
return nil
end
if _v117.WallCheck and not _v251(_v64.Position, _v107) then
return nil
end
return { Player = _v373, Character = _v107, Anchor = _v64, ScreenDistance = _v152 }
end
local function _v176(_v373, _v117)
if not _v373 or _v373.Parent ~= _v30 or _v373 == _v25 then
return nil
end
return _v175(_v373.Character, _v373, _v117)
end
function _v7:FindBestTarget(_v117)
local _v74
local _v75 = math.huge
for _, _v373 in ipairs(_v30:GetPlayers()) do
local _v97 = _v176(_v373, _v117)
if _v97 and _v97.ScreenDistance < _v75 then
_v75 = _v97.ScreenDistance
_v74 = _v97
end
end
if _v117.TargetBots then
for _, _v107 in ipairs(_v202()) do
local _v97 = _v175(_v107, nil, _v117)
if _v97 and _v97.ScreenDistance < _v75 then
_v75 = _v97.ScreenDistance
_v74 = _v97
end
end
end
return _v74
end
local _v23 = 50
function _v7:GetLookTarget(_v173, _v95)
local _v74
local _v75 = _v23
local _v310 = _v25.Character
local _v311 = _v310 and _v310:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
local _v293 = (_v173 and _v173.MaxDistance) or math.huge
local function _v122(_v107, _v399)
local humanoid = _v107 and _v107:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
local _v64 = _v237 and humanoid.Health > 0 and _v65(_v107) or nil
if not _v64 then
return
end
if _v311 and (_v64.Position - _v311.Position).Magnitude > _v293 then
return
end
local _v152 = _v206(_v64.Position)
if _v152 <= _v75 then
_v75 = _v152
_v74 = _v399
end
end
local _v475 = _v95 and _v95.TeamCheck
for _, _v373 in ipairs(_v30:GetPlayers()) do
if _v373 ~= _v25
and not (_v475 and _v373.Team ~= nil and _v373.Team == _v25.Team)
then
_v122(_v373.Character, _v373)
end
end
if _v95 and _v95.TargetBots then
for _, _v107 in ipairs(_v202()) do
_v122(_v107, _v107)
end
end
return _v74
end
function _v7:_resolveRegion(_v107, _v117)
local _v298 = _v117.Hitbox
if _v298 and _v298 ~= (_V9({123,16,214,87,117,243,78,173,244,76,24,223,91,110,251,10,172})) and _v33[_v298] then
return _v298
end
if self._lockedChar ~= _v107 then
self._lockedChar = _v107
self._rolledRegion = _v405(_v117.TargetWeights)
end
return self._rolledRegion or (_V9({97,20,217,87}))
end
function _v7:PointCamera(_v465, _v434)
local _v144 = CFrame.lookAt(Camera.CFrame.Position, _v465)
local _v63 = math.clamp(1 - (_v434 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v144, _v63)
end
function _v7:Update(_v117, debug)
Camera = _v50.CurrentCamera
_v495(_v117)
if not _v117.Enabled then
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
if _v117.StickyTarget and self._stickyCharacter then
if not self._stickyPlayer or self._stickyPlayer.Parent == _v30 then
target = _v175(self._stickyCharacter, self._stickyPlayer, _v117)
end
end
if not _v461 then
target = self:FindBestTarget(_v117)
end
if not _v461 then
self._lockedChar = nil
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
return
end
self._stickyCharacter = target.Character
self._stickyPlayer = target.Player
local _v389 = self:_resolveRegion(target.Character, _v117)
local _v59 = _v369(target.Character, _v389) or _v368(target.Character)
if not _v59 then
self._currentTarget = nil
return
end
local _v60 = _v59.Position
local _v528 = (_v60 - Camera.CFrame.Position).Magnitude
if (_v117.Prediction or 0) > 0 then
_v60 = _v60 + _v59.AssemblyLinearVelocity * _v117.Prediction * (_v528 / 500)
end
local _v434 = _v117.Smoothness
if _v117.Humanize then
_v434 = _v434 * (0.9 + _v102:NextNumber() * 0.2)
_v60 = _v60 + _v102:NextUnitVector() * (_v528 * math.rad(_v102:NextNumber() * 0.25))
end
self:PointCamera(_v60, _v434)
target.Part = _v59
target.Region = _v389
self._currentTarget = _v461
if debug then
print((_V9({125,3,217,80,113,247,0,226,153})), target.Character.Name, (_V9({123,20,223,90,117,240,84})), _v389, (_V9({109,24,203,71,123,240,13,224,153})), math.floor(target.ScreenDistance))
end
return _v461
end
function _v7:GetCurrentTarget()
return self._currentTarget
end
function _v7:Cleanup()
self._lockedChar = nil
self._stickyCharacter = nil
self._stickyPlayer = nil
self._currentTarget = nil
_v146()
end
_v7.GetBotCharacters = _v202
return _v7
end)()
ESP = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v50 = game:GetService((_V9({126,30,202,88,105,238,15,230,198})))
local _v25 = _v30.LocalPlayer
local _v9 = _v9
local Utility = _v46
local ESP = {}
local _v169 = {}
local _v123
local _v83
local _v12 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v245(humanoid)
return _v237 and humanoid.Health > 0
end
local function _v174(_v107)
local _v236 = _v107:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
return (_v236 and _v236.RootPart)
or _v107:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
or _v107:FindFirstChild((_V9({125,30,202,64,117})))
or _v107:FindFirstChild((_V9({124,1,200,86,104,202,1,247,208,70})))
or _v107.PrimaryPart
end
local function _v203()
if _v83 and _v83.Parent then
return _v83
end
_v83 = Instance.new((_V9({122,18,202,86,127,240,41,240,202})))
_v83.Name = (_V9({127,16,214,90,110,231,41,224,205,76,3,217,95,88,241,22,224,208}))
_v83.ResetOnSpawn = false
_v83.IgnoreGuiInset = true
_v83.DisplayOrder = 996
local _v335 = pcall(function()
_v83.Parent = Utility.getGuiParent()
end)
if not _v335 or not _v83.Parent then
_v83.Parent = _v25:WaitForChild((_V9({121,29,217,74,127,236,41,240,202})))
end
return _v83
end
local function _v494(_v170, _v107, _v117)
local _v94 = _v50.CurrentCamera
local root = _v174(_v107)
if not _v94 or not _v406 or not _v170.box then
if _v170.box then
_v170.box.Visible = false
end
return
end
local _v216 = _v107:FindFirstChild((_V9({97,20,217,87})))
local _v483 = _v216 and (_v216.Position + Vector3.new(0, _v216.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v80 = root.Position - Vector3.new(0, 3.2, 0)
local _v482, onScreen = _v94:WorldToViewportPoint(_v483)
local _v79 = _v94:WorldToViewportPoint(_v80)
if not _v348 or _v482.Z <= 0 then
_v170.box.Visible = false
return
end
local _v220 = math.abs(_v79.Y - _v482.Y)
local _v524 = _v220 * 0.62
local _v129 = (_v482.X + _v79.X) * 0.5
local _v130 = (_v482.Y + _v79.Y) * 0.5
_v170.box.Size = UDim2.fromOffset(_v524, _v220)
_v170.box.Position = UDim2.fromOffset(_v129 - _v524 * 0.5, _v130 - _v220 * 0.5)
_v170.box.BackgroundColor3 = _v117.FillColor
_v170.box.BackgroundTransparency = _v117.Filled and (1 - _v117.FillOpacity) or 1
_v170.boxStroke.Color = _v117.OutlineColor
_v170.boxStroke.Transparency = 1 - _v117.OutlineOpacity
_v170.box.Visible = true
end
local function _v284(_v170, name, _v216, _v117)
local _v460 = Instance.new((_V9({107,24,212,95,120,241,15,247,199,110,4,209})))
_v460.Name = (_V9({127,54,241,93,124,241}))
_v460.Size = UDim2.fromOffset(200, 46)
_v460.StudsOffset = Vector3.new(0, 2.7, 0)
_v460.AlwaysOnTop = true
_v460.Adornee = _v216
_v460.Parent = _v216
local _v227 = Instance.new((_V9({111,3,217,94,127})))
_v227.BackgroundTransparency = 1
_v227.Size = UDim2.fromScale(1, 1)
_v227.Parent = _v460
local _v261 = Instance.new((_V9({124,56,244,90,105,234,34,228,218,70,4,204})))
_v261.SortOrder = Enum.SortOrder.LayoutOrder
_v261.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v261.VerticalAlignment = Enum.VerticalAlignment.Center
_v261.Parent = _v227
local _v314 = Instance.new((_V9({125,20,192,71,86,255,12,224,207})))
_v314.LayoutOrder = 1
_v314.BackgroundTransparency = 1
_v314.Size = UDim2.new(1, 0, 0, 16)
_v314.Font = Enum.Font.GothamBold
_v314.TextSize = 13
_v314.TextColor3 = _v117.OutlineColor
_v314.TextStrokeTransparency = 0.35
_v314.Text = _v312
_v314.Visible = false
_v314.Parent = _v227
local _v151 = Instance.new((_V9({125,20,192,71,86,255,12,224,207})))
_v151.LayoutOrder = 2
_v151.BackgroundTransparency = 1
_v151.Size = UDim2.new(1, 0, 0, 14)
_v151.Font = Enum.Font.Gotham
_v151.TextSize = 12
_v151.TextColor3 = _v117.OutlineColor
_v151.TextStrokeTransparency = 0.4
_v151.Text = (_V9({}))
_v151.Visible = false
_v151.Parent = _v227
local _v218 = Instance.new((_V9({111,3,217,94,127})))
_v218.LayoutOrder = 3
_v218.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v218.BackgroundTransparency = 0.3
_v218.BorderSizePixel = 0
_v218.Size = UDim2.new(0.55, 0, 0, 5)
_v218.Visible = false
_v218.Parent = _v227
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v218, CornerRadius = UDim.new(1, 0) })
local _v219 = Instance.new((_V9({111,3,217,94,127})))
_v219.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v219.BorderSizePixel = 0
_v219.Size = UDim2.fromScale(1, 1)
_v219.Parent = _v218
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v219, CornerRadius = UDim.new(1, 0) })
_v170.nameTag = _v460
_v170.nameLabel = _v314
_v170.distanceLabel = _v151
_v170.healthBack = _v218
_v170.healthFill = _v219
_v170.nameHead = _v216
end
local function _v496(name, _v170, _v107, _v117)
local _v216 = _v107:FindFirstChild((_V9({97,20,217,87}))) or _v107:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
if not _v216 then
if _v170.nameTag then
_v170.nameTag.Enabled = false
end
return
end
if not _v170.nameTag or not _v170.nameTag.Parent or _v170.nameHead ~= _v216 then
if _v170.nameTag then
pcall(function()
_v170.nameTag:Destroy()
end)
end
_v284(_v170, _v312, _v216, _v117)
end
_v170.nameLabel.TextColor3 = _v117.OutlineColor
_v170.nameLabel.Visible = _v117.Names or _v117.NameTags
_v170.distanceLabel.Visible = _v117.Distance or _v117.DistanceTags
if _v170.distanceLabel.Visible then
_v170.distanceLabel.TextColor3 = _v117.OutlineColor
local _v310 = _v25.Character
local _v311 = _v310 and _v310:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
local _v231 = _v107:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
local d = (_v311 and _v231) and math.floor((_v231.Position - _v311.Position).Magnitude + 0.5) or 0
_v170.distanceLabel.Text = (_V9({114})) .. d .. (_V9({68,44}))
end
_v170.healthBack.Visible = _v117.HealthBars
if _v117.HealthBars then
local humanoid = _v107:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
local _v196 = _v237 and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v170.healthFill.Size = UDim2.fromScale(_v196, 1)
_v170.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v196)
end
_v170.nameTag.Enabled = true
end
local function _v224(_v170)
_v170.hl.Enabled = false
if _v170.box then
_v170.box.Visible = false
end
if _v170.nameTag then
_v170.nameTag.Enabled = false
end
end
local function _v393(_v170, _v107, name, _v117)
if _v117.Outlines then
if _v170.hl.Adornee ~= _v107 then
_v170.hl.Adornee = _v107
end
_v170.hl.OutlineColor = _v117.OutlineColor
_v170.hl.FillColor = _v117.FillColor
_v170.hl.OutlineTransparency = 1 - _v117.OutlineOpacity
_v170.hl.FillTransparency = _v117.Filled and (1 - _v117.FillOpacity) or 1
_v170.hl.DepthMode = _v12
_v170.hl.Enabled = true
else
_v170.hl.Enabled = false
end
if _v117.Boxes then
_v494(_v170, _v107, _v117)
elseif _v170.box then
_v170.box.Visible = false
end
if _v117.Names or _v117.Distance or _v117.NameTags or _v117.DistanceTags or _v117.HealthBars then
_v496(_v312, _v170, _v107, _v117)
elseif _v170.nameTag then
_v170.nameTag.Enabled = false
end
end
local function _v153(_v364)
local _v310 = _v25.Character
local _v311 = _v310 and _v310:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
if not _v311 or not _v364 then
return 0
end
return (_v364.Position - _v311.Position).Magnitude
end
local function _v498(_v373, _v170, _v117)
local _v107 = _v373.Character
if not _v107 then
_v224(_v170)
return
end
local _v231 = _v107:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
local humanoid = _v107:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
if not _v117.Enabled or not _v231 or not _v245(_v237) then
_v224(_v170)
return
end
if _v153(_v231) > _v117.MaxDistance then
_v224(_v170)
return
end
_v393(_v170, _v107, _v373.Name, _v117)
end
local function _v316(color)
color = _v114 or Color3.fromRGB(165, 75, 255)
local _v225 = Instance.new((_V9({97,24,223,91,118,247,9,237,215})))
_v225.Name = (_V9({108,34,232,124,111,234,2,236,205,76}))
_v225.Enabled = false
_v225.FillColor = _v114
_v225.OutlineColor = _v114
_v225.Parent = _v123
local box = Instance.new((_V9({111,3,217,94,127})))
box.Name = (_V9({108,34,232,113,117,230}))
box.BackgroundColor3 = _v114
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v203()
local boxStroke = Instance.new((_V9({124,56,235,71,104,241,5,224})))
boxStroke.Color = _v114
boxStroke.Thickness = 1
boxStroke.Parent = _v82
return { hl = _v225, box = _v82, boxStroke = _v84 }
end
local function _v145(_v170)
if _v170.hl then
_v170.hl:Destroy()
end
if _v170.box then
_v170.box:Destroy()
end
if _v170.nameTag then
pcall(function()
_v170.nameTag:Destroy()
end)
end
end
local function _v57(_v373, _v142)
if _v373 == _v25 or _v169[_v373] then
return
end
_v169[_v373] = _v316(_v142)
end
local function _v392(_v373)
local _v170 = _v169[_v373]
if not _v170 then
return
end
_v145(_v170)
_v169[_v373] = nil
end
local _v320 = {}
local _v260 = 0
local _v27 = 1
local function _v391(_v299)
local _v170 = _v320[_v299]
if not _v170 then
return
end
_v145(_v170)
_v320[_v299] = nil
end
local function _v396()
local current = {}
for _, _v334 in ipairs(_v50:GetDescendants()) do
if _v334:IsA((_V9({97,4,213,82,116,241,7,225}))) then
local _v299 = _v334.Parent
if
_v299
and _v299:IsA((_V9({100,30,220,86,118})))
and _v299 ~= _v25.Character
and not _v30:GetPlayerFromCharacter(_v299)
then
current[_v299] = true
if not _v320[_v299] then
_v320[_v299] = _v316(_v9.ESP.OutlineColor)
end
end
end
end
for _v299 in pairs(_v320) do
if not current[_v299] or not _v299.Parent then
_v391(_v299)
end
end
end
local function _v497(_v299, _v170, _v117)
local root = _v174(_v299)
local humanoid = _v299:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
if not _v299.Parent or not _v406 or not _v245(_v237) then
_v224(_v170)
return
end
if _v153(_v406) > _v117.MaxDistance then
_v224(_v170)
return
end
_v393(_v170, _v299, _v299.Name, _v117)
end
function ESP:Init()
if _v123 then
return
end
_v123 = Instance.new((_V9({111,30,212,87,127,236})))
_v123.Name = (_V9({127,16,214,90,110,231,41,224,205,76,3,217,95,95,205,62}))
local _v335 = pcall(function()
_v123.Parent = Utility.getGuiParent()
end)
if not _v335 or not _v123.Parent then
_v123.Parent = _v50
end
for _, _v373 in ipairs(_v30:GetPlayers()) do
_v57(_v373, _v9.ESP.OutlineColor)
end
end
function ESP:Update(_v117)
for _, _v373 in ipairs(_v30:GetPlayers()) do
if not _v169[_v373] then
_v57(_v373, _v117.OutlineColor)
end
end
for _v373, _v170 in pairs(_v169) do
if _v373.Parent == _v30 then
_v498(_v373, _v170, _v117)
else
_v392(_v373)
end
end
if _v117.Enabled and _v117.NPCs then
if os.clock() - _v260 >= _v27 then
_v260 = os.clock()
_v396()
end
for _v299, _v170 in pairs(_v320) do
_v497(_v299, _v170, _v117)
end
elseif next(_v320) then
for _v299 in pairs(_v320) do
_v391(_v299)
end
end
end
function ESP:OnPlayerAdded(_v373)
_v57(_v373, _v9.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v373)
_v392(_v373)
end
function ESP:Cleanup()
for _v373 in pairs(_v169) do
_v392(_v373)
end
for _v299 in pairs(_v320) do
_v391(_v299)
end
if _v123 then
_v123:Destroy()
_v123 = nil
end
if _v83 then
_v83:Destroy()
_v83 = nil
end
end
return _v14
end)()
_v13 = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v50 = game:GetService((_V9({126,30,202,88,105,238,15,230,198})))
local _v25 = _v30.LocalPlayer
local _v13 = {}
local _v132 = type(Drawing) == (_V9({93,16,218,95,127})) and type(Drawing.new) == (_V9({79,4,214,80,110,247,1,235}))
local _v139 = false
local _v133 = {}
local function _v136()
local _v267 = Drawing.new((_V9({101,24,214,86})))
_v267.Thickness = 1
_v267.Visible = false
return _v267
end
local function _v135(_v373)
local _v170 = {
box = { _v136(), _v136(), _v136(), _v136() },
tracer = _v136(),
}
_v133[_v373] = _v170
return _v170
end
local function _v134(_v170)
for _, _v267 in ipairs(_v170.box) do
_v267.Visible = false
end
_v170.tracer.Visible = false
end
local function _v137(_v373)
local _v170 = _v133[_v373]
if not _v170 then
return
end
_v133[_v373] = nil
for _, _v267 in ipairs(_v170.box) do
_v267:Remove()
end
_v170.tracer:Remove()
end
local function _v138(_v373, _v117, _v94)
local _v170 = _v133[_v373]
local _v107 = _v373.Character
local humanoid = _v107 and _v107:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
local root = _v107 and _v107:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
if not (_v117.Boxes or _v117.Tracers) or not _v406 or not (_v237 and humanoid.Health > 0) then
if _v170 then
_v134(_v170)
end
return
end
local _v216 = _v107:FindFirstChild((_V9({97,20,217,87})))
local _v483 = _v216 and (_v216.Position + Vector3.new(0, _v216.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v80 = root.Position - Vector3.new(0, 3.2, 0)
local _v482, onScreen = _v94:WorldToViewportPoint(_v483)
local _v79 = _v94:WorldToViewportPoint(_v80)
if not _v348 or _v482.Z <= 0 or _v79.Z <= 0 then
if _v170 then
_v134(_v170)
end
return
end
_v170 = _v170 or _v135(_v373)
local _v220 = math.abs(_v79.Y - _v482.Y)
local _v524 = _v220 * 0.62
local _v129 = (_v482.X + _v79.X) * 0.5
local _v263, right = _v129 - _v524 * 0.5, _v129 + _v524 * 0.5
local _v481, bottom = _v482.Y, _v79.Y
local box = _v170.box
box[1].From = Vector2.new(_v263, _v481)
box[1].To = Vector2.new(_v401, _v481)
box[2].From = Vector2.new(_v263, _v81)
box[2].To = Vector2.new(_v401, _v81)
box[3].From = Vector2.new(_v263, _v481)
box[3].To = Vector2.new(_v263, _v81)
box[4].From = Vector2.new(_v401, _v481)
box[4].To = Vector2.new(_v401, _v81)
for _, _v267 in ipairs(_v82) do
_v267.Color = _v117.BoxColor
_v267.Visible = _v117.Boxes
end
_v170.tracer.From = Vector2.new(_v94.ViewportSize.X / 2, _v94.ViewportSize.Y)
_v170.tracer.To = Vector2.new(_v129, _v81)
_v170.tracer.Color = _v117.TracerColor
_v170.tracer.Visible = _v117.Tracers
end
function _v13:Update(_v117, _v95)
if not _v132 then
if (_v117.Boxes or _v117.Tracers) and not _v139 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,225,70,9,151,103,104,255,13,224,209,9,52,235,99,58,240,11,224,199,90,81,204,91,127,190,42,247,194,94,24,214,84,58,242,7,231,209,72,3,193,19,248,30,250,165,205,70,5,152,82,108,255,7,233,194,75,29,221,19,115,240,78,241,203,64,2,152,86,98,251,13,240,215,70,3,150})))
_v139 = true
end
return
end
local _v94 = _v50.CurrentCamera
if not _v94 then
return
end
for _, _v373 in ipairs(_v30:GetPlayers()) do
if _v373 ~= _v25
and not (_v95.TeamCheck and _v373.Team ~= nil and _v373.Team == _v25.Team)
then
_v138(_v373, _v117, _v94)
end
end
for _v373 in pairs(_v133) do
if _v373.Parent ~= _v30 then
_v137(_v373)
end
end
end
function _v13:Cleanup()
for _v373 in pairs(_v133) do
_v137(_v373)
end
end
return _v13
end)()
Visuals = (function()
local _v24 = game:GetService((_V9({101,24,223,91,110,247,0,226})))
local Visuals = {}
local _v24 = game:GetService((_V9({101,24,223,91,110,247,0,226})))
local _v517
local _v514 = false
local _v516 = false
local _v515 = 0
local _v47 = 1
local function _v513()
if _v517 then
return
end
_v517 = {
Brightness = _v24.Brightness,
ClockTime = _v24.ClockTime,
GlobalShadows = _v24.GlobalShadows,
FogEnd = _v24.FogEnd,
FogStart = _v24.FogStart,
Ambient = _v24.Ambient,
OutdoorAmbient = _v24.OutdoorAmbient,
}
end
local function _v511()
_v24.Brightness = 2
_v24.ClockTime = 14
_v24.GlobalShadows = false
end
local function _v512()
_v24.FogEnd = 100000
end
local function _v518()
_v24.Brightness = _v517.Brightness
_v24.ClockTime = _v517.ClockTime
_v24.GlobalShadows = _v517.GlobalShadows
end
local function _v519()
_v24.FogEnd = _v517.FogEnd
_v24.FogStart = _v517.FogStart
end
function Visuals:Update(_v117)
if not (_v117.Fullbright or _v117.NoFog or _v514 or _v516) then
return
end
_v513()
if _v117.Fullbright ~= _v514 then
_v514 = _v117.Fullbright
if _v514 then
_v511()
else
_v518()
end
end
if _v117.NoFog ~= _v516 then
_v516 = _v117.NoFog
if _v516 then
_v512()
else
_v519()
end
end
if (_v514 or _v516) and os.clock() - _v515 >= _v47 then
_v515 = os.clock()
if _v514
and (_v24.Brightness ~= 2 or _v24.ClockTime ~= 14 or _v24.GlobalShadows)
then
_v511()
end
if _v516 and _v24.FogEnd < 100000 then
_v512()
end
end
end
function Visuals:Cleanup()
if _v517 then
if _v514 then
_v518()
end
if _v516 then
_v519()
end
end
_v514 = false
_v516 = false
end
return _v48
end)()
_v49 = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v25 = _v30.LocalPlayer
local _v9 = _v9
local _v49 = {}
_v49.Version = (_V9({25}))
local function _v397()
local _v98 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v186 in ipairs(_v98) do
if type(_v186) == (_V9({79,4,214,80,110,247,1,235})) then
return _v186
end
end
return nil
end
local function _v398()
local _v499 = _v9.Webhook.Url
if type(_v499) == (_V9({90,5,202,90,116,249})) and _v499 ~= (_V9({})) then
return _v499
end
return nil
end
function _v49.SetWebhook(_v499)
_v9.Webhook.Url = tostring(_v499 or (_V9({})))
return true
end
function _v49.HasWebhook()
return _v398() ~= nil
end
function _v49.SendWebhook(content, _v356)
_v356 = _v356 or {}
local _v499 = _v398()
if not _v499 then
return false, (_V9({71,30,231,68,127,252,6,234,204,66}))
end
local _v394 = _v397()
if not _v394 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,237,70,81,240,103,78,206,78,247,198,88,4,221,64,110,190,8,240,205,74,5,209,92,116,190,15,243,194,64,29,217,81,118,251,78,236,205,9,5,208,90,105,190,11,253,198,74,4,204,92,104})))
return false, (_V9({71,30,231,91,110,234,30}))
end
local _v367 = {
username = _v356.username or (_V9({127,16,214,90,110,231,67,194,198,71,20,202,82,118})),
avatar_url = _v356.avatar_url,
content = _v124,
embeds = _v356.embeds,
}
local _v335, err = pcall(function()
local _v76 = game:GetService((_V9({97,5,204,67,73,251,28,243,202,74,20}))):JSONEncode(_v367)
return _v394({
Url = _v499,
Method = (_V9({121,62,235,103})),
Headers = { [(_V9({106,30,214,71,127,240,26,168,247,80,1,221}))] = (_V9({72,1,200,95,115,253,15,241,202,70,31,151,89,105,241,0})) },
Body = _v76,
})
end)
_v499 = nil
if not _v335 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,244,76,19,208,92,117,245,78,246,198,71,21,152,85,123,247,2,224,199,19})), _v171)
return false, _v171
end
return true
end
function _v49.SendLoadedEmbed(_v246)
local _v371 = (_V9({22}))
pcall(function()
_v371 = game:GetService((_V9({100,16,202,88,127,234,30,233,194,74,20,235,86,104,232,7,230,198}))):GetProductInfo(game.PlaceId).Name
end)
return _v49.SendWebhook(nil, {
embeds = {
{
title = (_V9({127,16,214,90,110,231,64,225,198,95,81,255,86,116,251,28,228,207,9,29,215,82,126,251,10})),
color = 8666558,
fields = {
{ name = (_V9({121,29,217,74,127,236})), value = (_V9({73})) .. (_v25 and _v25.Name or (_V9({22}))) .. (_V9({73})), inline = true },
{ name = (_V9({127,20,202,64,115,241,0})), value = (_V9({73,7})) .. tostring(_v49.Version) .. (_V9({73})), inline = true },
{ name = (_V9({110,16,213,86})), value = _v371, inline = false },
{ name = (_V9({121,29,217,80,127,215,10})), value = (_V9({73})) .. tostring(game.PlaceId) .. (_V9({73})), inline = true },
{ name = (_V9({109,20,218,70,125,249,11,225})), value = (_V9({73})) .. tostring(_v246) .. (_V9({73})), inline = true },
},
footer = { text = os.date((_V9({12,40,149,22,119,179,75,225,131,12,57,130,22,87,164,75,214}))) },
},
},
})
end
return _v49
end)()
Triggerbot = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v50 = game:GetService((_V9({126,30,202,88,105,238,15,230,198})))
local _v25 = _v30.LocalPlayer
local Triggerbot = {}
local _v466
local _v471 = false
local _v474 = false
local _v469 = nil
local _v467
local _v472 = Random.new()
local _v468 = 0
local _v40 = 0.08
local function _v470()
if _v471 then
return
end
_v471 = true
if type(mouse1click) == (_V9({79,4,214,80,110,247,1,235})) then
_v466 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({79,4,214,80,110,247,1,235})) and type(mouse1release) == (_V9({79,4,214,80,110,247,1,235})) then
_v466 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v473(_v117, _v95)
local _v94 = _v50.CurrentCamera
if not _v94 then
return nil
end
local _v510 = _v94.ViewportSize
local _v384 = _v94:ViewportPointToRay(_v510.X / 2, _v510.Y / 2)
local params = RaycastParams.new()
if _v117.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v25.Character }
else
local _v108 = {}
for _, _v374 in ipairs(_v30:GetPlayers()) do
if _v374 ~= _v25 and _v374.Character then
table.insert(_v108, _v374.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v108
end
local _v399 = _v50:Raycast(_v384.Origin, _v384.Direction * (_v117.MaxDistance or 1000), _v362)
if not _v399 then
return nil
end
local _v299 = _v399.Instance:FindFirstAncestorOfClass((_V9({100,30,220,86,118})))
local _v374 = _v299 and _v30:GetPlayerFromCharacter(_v299)
if not _v374 or _v374 == _v25 then
return nil
end
if _v95 and _v95.TeamCheck and _v374.Team ~= nil and _v374.Team == _v25.Team then
return nil
end
local _v236 = _v299:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
if not _v236 or _v236.Health <= 0 then
return nil
end
return _v299
end
function Triggerbot:Update(_v117, _v95)
if not _v117.Enabled then
_v469 = nil
return
end
_v470()
if not _v466 then
if not _v474 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,247,91,24,223,84,127,236,12,234,215,9,31,221,86,126,237,78,228,131,68,30,205,64,127,179,13,233,202,74,26,152,85,111,240,13,241,202,70,31,152,27,119,241,27,246,198,24,18,212,90,121,245,71,165,65,169,229,152,93,117,234,78,228,213,72,24,212,82,120,242,11,165,202,71,81,204,91,115,237,78,224,219,76,18,205,71,117,236,64})))
_v474 = true
end
return
end
local target = _v473(_v117, _v95)
if not _v461 then
_v469 = nil
return
end
local _v319 = os.clock()
if not _v469 then
_v469 = _v319
local _v272 = math.min(_v117.MinDelay or 0.1, _v117.MaxDelay or 0.25)
local _v222 = math.max(_v117.MinDelay or 0.1, _v117.MaxDelay or 0.25)
_v467 = _v472:NextNumber(_v272, _v222)
end
if (_v319 - _v469) >= (_v467 or 0) and (_v319 - _v468) >= _v40 then
_v468 = _v319
_v466()
end
end
return _v42
end)()
SilentAim = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v50 = game:GetService((_V9({126,30,202,88,105,238,15,230,198})))
local _v25 = _v30.LocalPlayer
local _v7 = _v7
local SilentAim = {}
local _v410 = false
local _v412 = false
local function _v411()
local target = _v7:GetCurrentTarget()
local _v364 = _v461 and target.Part
if _v364 and _v364.Parent then
return _v364
end
return nil
end
local function _v409()
return type(checkcaller) == (_V9({79,4,214,80,110,247,1,235})) and not checkcaller()
end
function SilentAim:Init(_v117)
if _v410 then
return
end
if type(hookmetamethod) ~= (_V9({79,4,214,80,110,247,1,235})) or type(getnamecallmethod) ~= (_V9({79,4,214,80,110,247,1,235})) then
if not _v412 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,240,64,29,221,93,110,190,47,236,206,9,31,221,86,126,237,78,237,204,70,26,213,86,110,255,3,224,215,65,30,220,19,248,30,250,165,205,70,5,152,82,108,255,7,233,194,75,29,221,19,115,240,78,241,203,64,2,152,86,98,251,13,240,215,70,3,150})))
_v412 = true
end
return
end
_v410 = true
local _v344
_v344 = hookmetamethod(game, (_V9({118,46,214,82,119,251,13,228,207,69})), function(self, ...)
if _v117.Enabled and _v409() then
local _v294 = getnamecallmethod()
local _v364 = _v411()
if _v364 then
if _v294 == (_V9({111,24,202,86,73,251,28,243,198,91})) or _v294 == (_V9({96,31,206,92,113,251,61,224,209,95,20,202})) then
local _v69 = { ... }
for i, value in ipairs(_v69) do
if typeof(_v503) == (_V9({127,20,219,71,117,236,93})) then
_v69[i] = _v364.Position
elseif typeof(_v503) == (_V9({106,55,202,82,119,251})) then
_v69[i] = _v364.CFrame
end
end
return _v344(self, table.unpack(_v69))
end
if _v294 == (_V9({123,16,193,80,123,237,26})) and self == _v50 then
local _v358, _v150, params = ...
if typeof(_v358) == (_V9({127,20,219,71,117,236,93})) and typeof(_v150) == (_V9({127,20,219,71,117,236,93})) then
local _v73 = (_v364.Position - _v358).Unit * _v150.Magnitude
return _v344(self, _v358, _v73, _v362)
end
end
end
end
return _v344(self, ...)
end)
local _v300 = _v25:GetMouse()
local _v343
_v343 = hookmetamethod(game, (_V9({118,46,209,93,126,251,22})), function(self, _v254)
if _v117.Enabled and _v409() and self == _v300 then
local _v364 = _v411()
if _v364 then
if _v254 == (_V9({97,24,204})) then
return _v364.CFrame
end
if _v254 == (_V9({125,16,202,84,127,234})) then
return _v364
end
end
end
return _v343(self, _v254)
end)
end
return _v39
end)()
Hitbox = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v25 = _v30.LocalPlayer
local _v7 = _v7
local _v21 = {}
local _v213 = {}
local function _v214(_v107)
local _v359 = _v213[_v107]
if not _v359 then
return
end
_v213[_v107] = nil
local root = _v359.root
if _v406 and root.Parent then
root.Size = _v359.size
root.Transparency = _v359.transparency
root.CanCollide = _v359.canCollide
end
end
local function _v215()
for _v107 in pairs(_v213) do
_v214(_v107)
end
end
local function _v212(_v107, _v117, _v419)
local humanoid = _v107 and _v107:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
local root = _v107 and _v107:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
if not (_v237 and humanoid.Health > 0 and _v406) then
return
end
_v419[_v107] = true
if not _v213[_v107] then
_v213[_v107] = {
root = _v406,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = _v117.Size or 5
root.Size = Vector3.new(_v433, _v433, _v433)
root.Transparency = _v117.Transparency or 0.5
root.CanCollide = false
end
function _v21:Update(_v117, _v95)
if not _v117.Enabled then
_v215()
return
end
local _v419 = {}
for _, _v373 in ipairs(_v30:GetPlayers()) do
if _v373 ~= _v25
and not (_v95.TeamCheck and _v373.Team ~= nil and _v373.Team == _v25.Team)
then
_v212(_v373.Character, _v117, _v419)
end
end
if _v95.TargetBots then
for _, _v107 in ipairs(_v7.GetBotCharacters()) do
_v212(_v107, _v117, _v419)
end
end
for _v107 in pairs(_v213) do
if not _v419[_v107] then
_v214(_v107)
end
end
end
function _v21:Cleanup()
_v215()
end
return _v21
end)()
NoRecoil = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v45 = game:GetService((_V9({124,2,221,65,83,240,30,240,215,122,20,202,69,115,253,11})))
local _v50 = game:GetService((_V9({126,30,202,88,105,238,15,230,198})))
local _v25 = _v30.LocalPlayer
local NoRecoil = {}
local function _v247()
return _v45:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v72 = nil
local function _v96(_v94)
local _v273 = _v94.CFrame.LookVector
return math.asin(math.clamp(_v273.Y, -1, 1))
end
function NoRecoil:Update(_v117, _v61)
if not _v117.Enabled then
_v72 = nil
return
end
local _v94 = _v50.CurrentCamera
if not _v94 then
_v72 = nil
return
end
if _v117.RequireMouseDown and not _v247() then
_v72 = nil
return
end
local _v106 = _v25.Character
local _v236 = _v106 and _v106:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
if _v236 then
_v236.CameraOffset = Vector3.new(0, 0, 0)
end
if _v61 then
_v72 = nil
return
end
local _v443 = math.clamp(_v117.Strength, 0, 1)
if _v443 <= 0 then
_v72 = nil
return
end
local _v370 = _v96(_v94)
if _v72 == nil then
_v72 = _v370
return
end
local _v159 = _v370 - _v72
if _v117.AllowAim and _v159 < 0 then
_v72 = _v370
return
end
if _v159 ~= 0 then
_v94.CFrame = _v94.CFrame * CFrame.Angles(-_v159 * _v443, 0, 0)
end
end
function NoRecoil:Reset()
_v72 = nil
end
NoRecoil.IsFiring = _v247
return _v28
end)()
NoSpread = (function()
local NoRecoil = _v28
local NoSpread = {}
local _v321 = false
local _v333 = false
local _v325 = false
local _v331 = false
local _v332 = 1
local _v327 = nil
local _v329 = nil
local _v328 = nil
local function _v322()
if type(hookfunction) == (_V9({79,4,214,80,110,247,1,235})) then
return hookfunction
elseif type(replaceclosure) == (_V9({79,4,214,80,110,247,1,235})) then
return replaceclosure
end
return nil
end
local function _v326(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v330(_v359, _v104, _v248)
local v = _v359 + (_v104 - _v359) * _v332
if _v248 then
return math.floor(v + 0.5)
end
return v
end
local function _v323(_v228)
if _v325 then
return
end
local _v335, ret = pcall(_v228, math.random, function(...)
local _v359 = _v327(...)
if _v321 and _v332 > 0 then
local a, b = ...
return _v330(_v359, _v326(a, b), a ~= nil)
end
return _v359
end)
if _v335 then
_v327 = _v400
_v325 = true
end
end
local function _v324(_v228)
if _v331 then
return
end
local _v335 = pcall(function()
local _v413 = Random.new()
_v329 = _v228(_v413.NextNumber, function(self, ...)
local _v359 = _v329(self, ...)
if _v321 and _v332 > 0 then
local _v297, mx = ...
local _v104 = (_v297 == nil) and 0.5 or ((_v297 + _v309) / 2)
return _v330(_v359, _v104, false)
end
return _v359
end)
_v328 = _v228(_v413.NextInteger, function(self, ...)
local _v359 = _v328(self, ...)
if _v321 and _v332 > 0 then
local _v297, mx = ...
return _v330(_v359, (_v297 + _v309) / 2, true)
end
return _v359
end)
end)
if _v335 then
_v331 = true
end
end
function NoSpread:_install()
if _v325 or _v331 then
return true
end
local _v228 = _v322()
if not _v228 then
if not _v333 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,237,70,81,235,67,104,251,15,225,131,71,20,221,87,105,190,8,240,205,74,5,209,92,116,190,6,234,204,66,24,214,84,58,182,6,234,204,66,23,205,93,121,234,7,234,205,0,81,90,179,142,190,0,234,215,9,16,206,82,115,242,15,231,207,76,81,209,93,58,234,6,236,208,9,20,192,86,121,235,26,234,209,7})))
_v333 = true
end
return false
end
_v323(_v228)
_v324(_v228)
if not (_v325 or _v331) then
if not _v333 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,237,70,81,235,67,104,251,15,225,153,9,23,217,90,118,251,10,165,215,70,81,209,93,105,234,15,233,207,9,16,214,74,58,246,1,234,200,7})))
_v333 = true
end
return false
end
return true
end
function NoSpread:Update(_v117)
_v332 = math.clamp(_v117.Strength or 1, 0, 1)
if _v117.Enabled then
if not (_v325 or _v331) and not self:_install() then
return
end
_v321 = (not _v117.RequireMouseDown) or NoRecoil.IsFiring()
else
_v321 = false
end
end
function NoSpread:Cleanup()
_v321 = false
local _v228 = _v322()
if not _v228 then
return
end
if _v325 and _v327 then
pcall(_v228, math.random, _v327)
_v325 = false
end
if _v331 then
pcall(function()
local _v413 = Random.new()
if _v329 then
_v228(_v413.NextNumber, _v329)
end
if _v328 then
_v228(_v413.NextInteger, _v328)
end
end)
_v331 = false
end
end
return _v29
end)()
UI = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v45 = game:GetService((_V9({124,2,221,65,83,240,30,240,215,122,20,202,69,115,253,11})))
local _v43 = game:GetService((_V9({125,6,221,86,116,205,11,247,213,64,18,221})))
local _v25 = _v30.LocalPlayer
local _v8 = _v8
local Utility = _v46
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
local _v15 = 0.18
local _v1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local _v210
local _v275
local _v525
local _v128 = (_V9({106,30,213,81,123,234}))
local _v262 = 0
local visible = false
local _v55
local _v350
local _v489 = {}
local _v302 = {}
local _v390 = {}
local _v451 = {}
local _v463, targetPanelLabel
local _v462 = false
local _v257
local _v521
local _v195, fpsLabel
local _v54
local _v100 = false
local _v56 = nil
local function _v317(_v111, _v380)
local _v243 = Instance.new(_v111)
for k, v in pairs(_v380) do
_v243[k] = v
end
return _v243
end
local function _v318()
_v262 = _v262 + 1
return _v262
end
local function _v250(_v241)
return _v241.UserInputType == Enum.UserInputType.MouseButton1
or _v241.UserInputType == Enum.UserInputType.Touch
end
local function _v249(_v241)
return _v241.UserInputType == Enum.UserInputType.MouseMovement
or _v241.UserInputType == Enum.UserInputType.Touch
end
local function _v440()
table.insert(_v489, _v45.InputChanged:Connect(function(_v241)
if not _v249(_v241) then
return
end
for _, _v186 in ipairs(_v302) do
_v186(_v241)
end
end))
table.insert(_v489, _v45.InputEnded:Connect(function(_v241)
if not _v250(_v241) then
return
end
for _, _v186 in ipairs(_v390) do
_v186(_v241)
end
end))
table.insert(_v489, _v45.InputBegan:Connect(function(_v241)
if not _v56 or not _v250(_v241) then
return
end
local _v375 = Vector2.new(_v241.Position.X, _v241.Position.Y)
if not _v56.contains(_v375) then
_v56.close()
end
end))
table.insert(_v489, _v45.InputBegan:Connect(function(_v241)
if not _v54 then
return
end
if _v241.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v254 = _v241.KeyCode
if _v254 == Enum.KeyCode.Unknown then
return
end
if _v254 == Enum.KeyCode.Escape then
_v54.finish(nil)
else
_v54.finish(_v254)
end
end))
end
local function _v290(_v363, text, _v207, _v346)
local btn = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v317((_V9({111,3,217,94,127})), {
Parent = _v85,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v207() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v82, CornerRadius = UDim.new(0, 3) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v82, Color = _v4.border, Thickness = 1 })
local _v258 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v85,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v207() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v476,
})
local function _v386()
local _v345 = _v207()
_v43:Create(_v82, _v1, { BackgroundColor3 = _v345 and _v4.accent or _v4.off }):Play()
_v43:Create(_v258, _v1, { TextColor3 = _v345 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v346()
_v386()
end)
btn.MouseEnter:Connect(function()
if not _v207() then
box.BackgroundColor3 = _v4.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v207() then
box.BackgroundColor3 = _v4.off
end
end)
table.insert(_v451, _v386)
end
local function _v287(_v363, text, _v295, _v292, _v207, _v425, _v248, _v446)
_v446 = _v446 or (_V9({}))
local _v227 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v227, CornerRadius = UDim.new(0, 6) })
local _v258 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v227,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v476,
})
local _v486 = _v317((_V9({111,3,217,94,127})), {
Parent = _v227,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v486, CornerRadius = UDim.new(1, 0) })
local _v182 = _v317((_V9({111,3,217,94,127})), {
Parent = _v486,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v182, CornerRadius = UDim.new(1, 0) })
local function _v187(v)
local _v71 = _v248 and tostring(math.floor(v + 0.5)) or string.format((_V9({12,95,138,85})), v)
return _v71 .. _v446
end
local function _v66(v)
v = math.clamp(v, _v295, _v292)
if _v248 then
v = math.floor(v + 0.5)
end
local _v63 = (_v292 > _v295) and (v - _v295) / (_v292 - _v295) or 0
_v182.Size = UDim2.new(_v63, 0, 1, 0)
_v258.Text = _v476 .. (_V9({19,81})) .. _v187(v)
_v425(v)
end
_v66(_v207())
local _v157 = false
local function _v198(_v381)
local _v63 = math.clamp((_v381 - _v486.AbsolutePosition.X) / _v486.AbsoluteSize.X, 0, 1)
_v66(_v295 + _v63 * (_v292 - _v295))
end
_v486.InputBegan:Connect(function(_v241)
if _v250(_v241) then
_v157 = true
_v198(_v241.Position.X)
end
end)
table.insert(_v302, function(_v241)
if _v157 then
_v198(_v241.Position.X)
end
end)
table.insert(_v390, function()
_v157 = false
end)
table.insert(_v451, function()
_v66(_v207())
end)
end
local function _v279(_v363, text, _v355, _v207, _v346)
local _v227 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v227, CornerRadius = UDim.new(0, 6) })
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v227,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v476,
})
local _v161 = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v227,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v207(),
ZIndex = 3,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v161, CornerRadius = UDim.new(0, 4) })
local _v351 = false
local _v34 = 24
local _v200 = #_v355 * _v34
local _v270 = math.min(_v200, 7 * _v34)
local _v268 = _v317((_V9({122,18,202,92,118,242,7,235,196,111,3,217,94,127})), {
Parent = _v161,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v200),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v268, CornerRadius = UDim.new(0, 4) })
for i, _v352 in ipairs(_v355) do
local _v353 = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v268,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v352,
AutoButtonColor = false,
ZIndex = 11,
})
_v353.MouseButton1Click:Connect(function()
_v346(_v352)
_v161.Text = _v352
_v351 = false
_v43:Create(_v268, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v15, function()
if not _v351 then
_v268.Visible = false
end
end)
end)
_v353.MouseEnter:Connect(function()
_v353.BackgroundColor3 = _v4.rowHover
end)
_v353.MouseLeave:Connect(function()
_v353.BackgroundColor3 = _v4.off
end)
end
_v161.MouseButton1Click:Connect(function()
_v351 = not _v351
if _v351 then
_v268.Visible = true
_v43:Create(_v268, _v1, { Size = UDim2.new(1, 0, 0, _v270) }):Play()
else
_v43:Create(_v268, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v15, function()
if not _v351 then
_v268.Visible = false
end
end)
end
end)
table.insert(_v451, function()
_v161.Text = _v207()
end)
end
local function _v286(_v363, text, _v240)
local _v227 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v227, CornerRadius = UDim.new(0, 6) })
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v227,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v476,
})
local value = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v227,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v240,
})
return _v503
end
local function _v276(_v363, text, _v347, color)
local _v71 = _v114 or _v4.accent
local _v230 = Color3.new(
math.min(_v71.R + 0.1, 1),
math.min(_v71.G + 0.1, 1),
math.min(_v71.B + 0.1, 1)
)
local btn = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v71,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = _v476,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v85, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v347)
btn.MouseEnter:Connect(function()
_v43:Create(_v85, _v1, { BackgroundColor3 = _v230 }):Play()
end)
btn.MouseLeave:Connect(function()
_v43:Create(_v85, _v1, { BackgroundColor3 = _v71 }):Play()
end)
return _v85
end
local function _v289(_v363, _v372)
local _v227 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v227, CornerRadius = UDim.new(0, 6) })
local _v445 = _v317((_V9({124,56,235,71,104,241,5,224})), {
Parent = _v227,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v317((_V9({125,20,192,71,88,241,22})), {
Parent = _v227,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
PlaceholderText = _v372 or (_V9({})),
PlaceholderColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v43:Create(_v445, _v1, { Transparency = 0, Color = _v4.accent }):Play()
end)
box.FocusLost:Connect(function()
_v43:Create(_v445, _v1, { Transparency = 0.3, Color = _v4.border }):Play()
end)
return _v82
end
local function _v283(_v363, text)
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(_v476),
})
end
local function _v281(_v363, text, _v295, _v292, _v207, _v425, _v248, _v491, _v429)
_v491 = _v491 or (_V9({}))
local _v227 = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v227, CornerRadius = UDim.new(0, 6) })
local _v182 = _v317((_V9({111,3,217,94,127})), {
Parent = _v227,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v182, CornerRadius = UDim.new(0, 6) })
local _v258 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v227,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v476,
ZIndex = 3,
})
local function _v185(v)
local s = _v248 and tostring(math.floor(v + 0.5)) or string.format((_V9({12,95,138,85})), v)
if _v429 then
local m = _v248 and tostring(math.floor(_v292 + 0.5)) or string.format((_V9({12,95,138,85})), _v292)
return s .. (_V9({6})) .. m .. _v491
end
return s .. _v491
end
local function _v66(v)
v = math.clamp(v, _v295, _v292)
if _v248 then
v = math.floor(v + 0.5)
end
local _v63 = (_v292 > _v295) and (v - _v295) / (_v292 - _v295) or 0
_v182.Size = UDim2.new(_v63, 0, 1, 0)
_v258.Text = _v476 .. (_V9({19,81})) .. _v185(v)
_v425(v)
end
_v66(_v207())
local _v157 = false
local function _v198(_v381)
local _v63 = math.clamp((_v381 - _v227.AbsolutePosition.X) / _v227.AbsoluteSize.X, 0, 1)
_v66(_v295 + _v63 * (_v292 - _v295))
end
_v227.InputBegan:Connect(function(_v241)
if _v250(_v241) then
_v157 = true
_v198(_v241.Position.X)
end
end)
table.insert(_v302, function(_v241)
if _v157 then
_v198(_v241.Position.X)
end
end)
table.insert(_v390, function()
_v157 = false
end)
table.insert(_v451, function()
_v66(_v207())
end)
end
local function _v280(_v363, _v355, _v207, _v346)
local _v227 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v227,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v161 = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v227,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v161, CornerRadius = UDim.new(0, 6) })
local _v160 = _v317((_V9({124,56,235,71,104,241,5,224})), {
Parent = _v161,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local _v504 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v161,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v207(),
})
local _v101 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v161,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.accent,
Text = (_V9({203,231,6})),
})
local _v351 = false
local _v34 = 26
local _v200 = #_v355 * _v34
local _v270 = math.min(_v200, 6 * _v34)
local _v268 = _v317((_V9({122,18,202,92,118,242,7,235,196,111,3,217,94,127})), {
Parent = _v227,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v200),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v268, CornerRadius = UDim.new(0, 6) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v268, Color = _v4.border, Thickness = 1, Transparency = 0.2 })
local _v354 = {}
local function _v361()
local current = _v207()
for _v352, btn in pairs(_v354) do
local _v421 = (_v352 == _v127)
btn.BackgroundColor3 = _v421 and _v4.accent or _v4.panel
btn.BackgroundTransparency = _v421 and 0 or 1
btn.TextColor3 = _v421 and Color3.fromRGB(255, 255, 255) or _v4.textSub
btn.Font = _v421 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v113()
if not _v351 then
return
end
_v351 = false
if _v56 and _v56.frame == _v161 then
_v56 = nil
end
_v43:Create(_v101, _v1, { Rotation = 0 }):Play()
_v43:Create(_v160, _v1, { Transparency = 0.3 }):Play()
_v43:Create(_v268, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v15, function()
if not _v351 then
_v268.Visible = false
end
end)
end
local function _v178()
if _v351 then
return
end
if _v56 and _v56.close then
_v56.close()
end
_v351 = true
_v361()
_v268.Visible = true
_v43:Create(_v101, _v1, { Rotation = 180 }):Play()
_v43:Create(_v160, _v1, { Transparency = 0 }):Play()
_v43:Create(_v268, _v1, { Size = UDim2.new(1, 0, 0, _v270) }):Play()
_v56 = {
frame = _v161,
close = _v113,
contains = function(_v375)
local function _v242(_v334)
local p, s = _v334.AbsolutePosition, _v334.AbsoluteSize
return _v375.X >= p.X and _v375.X <= p.X + s.X and _v375.Y >= p.Y and _v375.Y <= p.Y + s.Y
end
return _v242(_v161) or (_v268.Visible and _v242(_v268))
end,
}
end
for i, _v352 in ipairs(_v355) do
local _v353 = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v268,
Size = UDim2.new(1, 0, 0, _v34),
Position = UDim2.fromOffset(0, (i - 1) * _v34),
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
Text = _v352,
AutoButtonColor = false,
})
_v354[_v352] = _v353
_v353.MouseButton1Click:Connect(function()
_v346(_v352)
_v504.Text = _v352
_v361()
_v113()
end)
_v353.MouseEnter:Connect(function()
if _v352 ~= _v207() then
_v353.BackgroundTransparency = 0
_v353.BackgroundColor3 = _v4.rowHover
_v353.TextColor3 = _v4.text
end
end)
_v353.MouseLeave:Connect(function()
_v361()
end)
end
_v361()
_v161.MouseButton1Click:Connect(function()
if _v351 then
_v113()
else
_v178()
end
end)
_v161.MouseEnter:Connect(function()
if not _v351 then
_v43:Create(_v161, _v1, { BackgroundColor3 = _v4.rowHover }):Play()
end
end)
_v161.MouseLeave:Connect(function()
if not _v351 then
_v43:Create(_v161, _v1, { BackgroundColor3 = _v4.row }):Play()
end
end)
table.insert(_v451, function()
_v504.Text = _v207()
_v361()
end)
end
local function _v277(_v363, title, _v204, _v422)
local h, s, v = _v204():ToHSV()
local _v37, _v19, GAP = 120, 16, 8
local _v227 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, _v37 + 74),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v227, CornerRadius = UDim.new(0, 6) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v227, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v227,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v217 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v227,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v477 or (_V9({106,30,212,92,104})),
})
local _v76 = _v317((_V9({111,3,217,94,127})), {
Parent = _v227,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v437 = _v317((_V9({111,3,217,94,127})), {
Parent = _v76,
Size = UDim2.new(1, -(_v19 + _v17), 0, _v37),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v437, CornerRadius = UDim.new(0, 4) })
local _v415 = _v317((_V9({111,3,217,94,127})), {
Parent = _v437,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v415, CornerRadius = UDim.new(0, 4) })
_v317((_V9({124,56,255,65,123,250,7,224,205,93})), {
Parent = _v415,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v502 = _v317((_V9({111,3,217,94,127})), {
Parent = _v437,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v502, CornerRadius = UDim.new(0, 4) })
_v317((_V9({124,56,255,65,123,250,7,224,205,93})), {
Parent = _v502,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v448 = _v317((_V9({111,3,217,94,127})), {
Parent = _v437,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v448, CornerRadius = UDim.new(1, 0) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v448, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v232 = _v317((_V9({111,3,217,94,127})), {
Parent = _v76,
Size = UDim2.fromOffset(_v19, _v37),
Position = UDim2.new(1, -_v19, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v232, CornerRadius = UDim.new(0, 4) })
_v317((_V9({124,56,255,65,123,250,7,224,205,93})), {
Parent = _v232,
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
local _v233 = _v317((_V9({111,3,217,94,127})), {
Parent = _v232,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v233, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v378 = _v317((_V9({111,3,217,94,127})), {
Parent = _v76,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v37 + 6),
BackgroundColor3 = _v204(),
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v378, CornerRadius = UDim.new(0, 4) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v378, Color = _v4.off, Thickness = 1 })
local _v221 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v76,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v37 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v386(_v531)
local _v112 = Color3.fromHSV(h, s, v)
if _v531 ~= false then
_v422(_v112)
end
_v437.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v448.Position = UDim2.new(s, 0, 1 - v, 0)
_v233.Position = UDim2.new(0.5, 0, h, 0)
_v378.BackgroundColor3 = _v112
local r = math.floor(_v112.R * 255 + 0.5)
local g = math.floor(_v112.G * 255 + 0.5)
local b = math.floor(_v112.B * 255 + 0.5)
_v221.Text = string.format((_V9({10,84,136,1,66,187,94,183,251,12,65,138,107,58,190,70,160,199,5,81,157,87,54,190,75,225,138})), r, g, b, r, g, b)
end
_v386(false)
local _v449, hueDrag = false, false
local function _v450(_v381, _v382)
s = math.clamp((_v381 - _v437.AbsolutePosition.X) / _v437.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v382 - _v437.AbsolutePosition.Y) / _v437.AbsoluteSize.Y, 0, 1)
_v386()
end
local function _v235(_v382)
h = math.clamp((_v382 - _v232.AbsolutePosition.Y) / _v232.AbsoluteSize.Y, 0, 1)
_v386()
end
_v437.InputBegan:Connect(function(_v241)
if _v250(_v241) then
_v449 = true
_v450(_v241.Position.X, _v241.Position.Y)
end
end)
_v232.InputBegan:Connect(function(_v241)
if _v250(_v241) then
hueDrag = true
_v235(_v241.Position.Y)
end
end)
table.insert(_v302, function(_v241)
if _v449 then
_v450(_v241.Position.X, _v241.Position.Y)
end
if _v234 then
_v235(_v241.Position.Y)
end
end)
table.insert(_v390, function()
_v449, hueDrag = false, false
end)
table.insert(_v451, function()
h, s, v = _v204():ToHSV()
_v386(false)
end)
end
local function _v526(box, _v259, _v205, _v424, _v119)
local _v271 = false
local function _v386()
if _v271 then
box.Text = (_V9({121,3,221,64,105,124,238,35}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v4.accent
else
box.Text = _v205().Name
box.TextColor3 = _v4.accent
box.BackgroundColor3 = _v4.bar
end
end
local _v99 = {}
function _v99.finish(_v254)
_v271 = false
_v54 = nil
task.defer(function()
_v100 = false
end)
if _v254 then
local _v118 = _v119 and _v119(_v254)
if _v118 then
UI:Notify(string.format((_V9({12,2,152,90,105,190,15,233,209,76,16,220,74,58,252,1,240,205,77,81,204,92,58,187,29})), _v254.Name, _v118), 2.5)
else
_v424(_v254)
UI:Notify(string.format((_V9({12,2,152,81,117,235,0,225,131,93,30,152,22,105})), _v259, _v254.Name), 2)
end
end
_v386()
end
function _v99.cancel()
_v271 = false
_v386()
end
box.MouseButton1Click:Connect(function()
if _v271 then
_v54 = nil
task.defer(function()
_v100 = false
end)
_v99.cancel()
return
end
if _v54 then
_v54.cancel()
end
_v54 = _v99
_v100 = true
_v271 = true
_v386()
end)
box.MouseEnter:Connect(function()
if not _v271 then
box.BackgroundColor3 = _v4.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v271 then
box.BackgroundColor3 = _v4.bar
end
end)
table.insert(_v451, function()
if _v54 == _v99 then
_v54 = nil
task.defer(function()
_v100 = false
end)
_v271 = false
end
_v386()
end)
_v386()
end
local function _v255(_v117, _v254, _v180)
if _v180 ~= (_V9({68,20,214,70})) and _v117.UI.MenuKey == _v254 then
return (_V9({100,20,214,70}))
end
if _v180 ~= (_V9({72,24,213,81,117,234})) and _v117.Camera.ToggleKey == _v254 then
return (_V9({104,24,213,81,117,234}))
end
if _v180 ~= (_V9({76,2,200})) and _v117.ESP.ToggleKey == _v254 then
return (_V9({108,34,232}))
end
if _v180 ~= (_V9({79,30,206,80,115,236,13,233,198})) and _v117.Camera.FOVCircleKey == _v254 then
return (_V9({111,62,238,19,89,247,28,230,207,76}))
end
if _v180 ~= (_V9({71,30,202,86,121,241,7,233})) and _v117.NoRecoil.ToggleKey == _v254 then
return (_V9({103,30,152,97,127,253,1,236,207}))
end
if _v180 ~= (_V9({71,30,203,67,104,251,15,225})) and _v117.NoSpread.ToggleKey == _v254 then
return (_V9({103,30,152,96,106,236,11,228,199}))
end
if _v180 ~= (_V9({93,3,209,84,125,251,28,231,204,93})) and _v117.Triggerbot.ToggleKey == _v254 then
return (_V9({125,3,209,84,125,251,28,231,204,93}))
end
if _v180 ~= (_V9({74,29,209,80,113,234,30})) and _v117.Movement.ClickTPKey == _v254 then
return (_V9({106,29,209,80,113,190,58,213}))
end
if _v180 ~= (_V9({92,31,212,92,123,250})) and _v117.UI.UnloadKey == _v254 then
return (_V9({124,31,212,92,123,250}))
end
return nil
end
local function _v285(_v363, _v259, _v205, _v424, _v119)
local _v227 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v227, CornerRadius = UDim.new(0, 6) })
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v227,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v259,
})
local box = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v227,
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
Text = _v205().Name,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v82, CornerRadius = UDim.new(0, 4) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v82, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v82,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v317((_V9({124,56,235,90,96,251,45,234,205,90,5,202,82,115,240,26})), { Parent = _v82, MinSize = Vector2.new(54, 22) })
_v526(_v82, _v259, _v205, _v424, _v119)
end
local function _v291(_v363, text, _v207, _v346, _v256, _v205, _v424, _v119)
local btn = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v109 = _v317((_V9({111,3,217,94,127})), {
Parent = _v85,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v207() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v109, CornerRadius = UDim.new(0, 3) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v109, Color = _v4.border, Thickness = 1 })
local _v258 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v85,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v207() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v476,
})
local box = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v85,
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
Text = _v205().Name,
ZIndex = 3,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v82, CornerRadius = UDim.new(0, 4) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v82, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v82,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v317((_V9({124,56,235,90,96,251,45,234,205,90,5,202,82,115,240,26})), { Parent = _v82, MinSize = Vector2.new(44, 20) })
local function _v386()
local _v345 = _v207()
_v43:Create(_v109, _v1, { BackgroundColor3 = _v345 and _v4.accent or _v4.off }):Play()
_v43:Create(_v258, _v1, { TextColor3 = _v345 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v346()
_v386()
end)
table.insert(_v451, _v386)
_v526(_v82, _v256, _v205, _v424, _v119)
end
local function _v278(_v363)
local function _v116(order)
local _v112 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v357,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v112,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v112
end
return _v116(1), _v116(2)
end
local function _v282(_v363, title)
local _v530 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v317((_V9({111,3,217,94,127})), {
Parent = _v530,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v82, CornerRadius = UDim.new(0, 6) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v82, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v82,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v82,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v82,
LayoutOrder = -1,
Size = UDim2.new(1, 0, 0, 15),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v477,
})
local _v506 = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v530,
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
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v506, CornerRadius = UDim.new(0, 6) })
local _v38, GAP = 0.72, 1
local _v211 = _v317((_V9({111,3,217,94,127})), {
Parent = _v506,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v4.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v211, CornerRadius = UDim.new(0, 6) })
_v317((_V9({124,56,255,65,123,250,7,224,205,93})), {
Parent = _v211,
Rotation = 35,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.000, _v17),
NumberSequenceKeypoint.new(0.119, _v17),
NumberSequenceKeypoint.new(0.120, _v38),
NumberSequenceKeypoint.new(0.199, _v38),
NumberSequenceKeypoint.new(0.200, _v17),
NumberSequenceKeypoint.new(0.319, _v17),
NumberSequenceKeypoint.new(0.320, _v38),
NumberSequenceKeypoint.new(0.399, _v38),
NumberSequenceKeypoint.new(0.400, _v17),
NumberSequenceKeypoint.new(0.519, _v17),
NumberSequenceKeypoint.new(0.520, _v38),
NumberSequenceKeypoint.new(0.599, _v38),
NumberSequenceKeypoint.new(0.600, _v17),
NumberSequenceKeypoint.new(0.719, _v17),
NumberSequenceKeypoint.new(0.720, _v38),
NumberSequenceKeypoint.new(0.799, _v38),
NumberSequenceKeypoint.new(0.800, _v17),
NumberSequenceKeypoint.new(0.919, _v17),
NumberSequenceKeypoint.new(0.920, _v38),
NumberSequenceKeypoint.new(1.000, _v38),
}),
})
local function _v452()
local _v416 = (_v525 and _v525.Scale) or 1
if _v416 <= 0 then
_v416 = 1
end
_v530.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v416)
end
box:GetPropertyChangedSignal((_V9({104,19,203,92,118,235,26,224,240,64,11,221}))):Connect(_v452)
_v452()
local function _v423(_v164)
_v506.Visible = not _v164
end
return _v82, _v423
end
local function _v288(_v363)
local bar = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v70,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v154 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v4.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v68 = _v317((_V9({111,3,217,94,127})), {
Parent = _v363,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v229 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v229.current = _v312
for n, f in pairs(_v229.frames) do
f.Visible = (n == _v312)
end
for n, b in pairs(_v229.buttons) do
local _v53 = (n == _v312)
_v43:Create(b.btn, _v1, { TextColor3 = _v53 and _v4.text or _v4.textSub }):Play()
_v43:Create(b.underline, _v1, { BackgroundTransparency = _v53 and 0 or 1 }):Play()
end
end
function _v229:add(name)
self.order = self.order + 1
local btn = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v70,
LayoutOrder = self.order,
Size = UDim2.fromOffset(0, 24),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v4.textSub,
Text = _v312,
})
local underline = _v317((_V9({111,3,217,94,127})), {
Parent = _v85,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v490, CornerRadius = UDim.new(1, 0) })
local frame = _v317((_V9({122,18,202,92,118,242,7,235,196,111,3,217,94,127})), {
Parent = _v68,
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
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v197,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v317((_V9({124,56,232,82,126,250,7,235,196})), { Parent = _v197, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = _v85, underline = _v490 }
self.frames[name] = _v197
btn.MouseButton1Click:Connect(function()
select(_v312)
end)
btn.MouseEnter:Connect(function()
if _v229.current ~= _v312 then
btn.TextColor3 = _v4.text
end
end)
btn.MouseLeave:Connect(function()
if _v229.current ~= _v312 then
btn.TextColor3 = _v4.textSub
end
end)
if not self.current then
select(_v312)
end
return _v197
end
return _v229
end
local function _v86(_v363, _v117)
_v262 = 0
local _v229 = _v288(_v363)
local _v263, right = _v278(_v229:add((_V9({104,24,213,81,117,234}))))
local _v58 = _v282(_v263, (_V9({104,24,213,81,117,234})))
_v291(_v58, (_V9({108,31,217,81,118,251,10})), function()
return _v117.Camera.Enabled
end, function()
_v117.Camera.Enabled = not _v117.Camera.Enabled
end, (_V9({104,24,213,81,117,234,78,206,198,80})), function()
return _v117.Camera.ToggleKey
end, function(_v254)
_v117.Camera.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({72,24,213,81,117,234})))
end)
_v290(_v58, (_V9({127,24,203,80,114,251,13,238})), function()
return _v117.Camera.WallCheck
end, function()
_v117.Camera.WallCheck = not _v117.Camera.WallCheck
end)
_v290(_v58, (_V9({122,5,209,80,113,231,78,209,194,91,22,221,71})), function()
return _v117.Camera.StickyTarget
end, function()
_v117.Camera.StickyTarget = not _v117.Camera.StickyTarget
end)
_v290(_v58, (_V9({125,16,202,84,127,234,78,199,204,93,2})), function()
return _v117.Camera.TargetBots
end, function()
_v117.Camera.TargetBots = not _v117.Camera.TargetBots
end)
_v290(_v58, (_V9({125,20,217,94,58,221,6,224,192,66})), function()
return _v117.Camera.TeamCheck
end, function()
_v117.Camera.TeamCheck = not _v117.Camera.TeamCheck
end)
_v290(_v58, (_V9({97,4,213,82,116,247,20,224})), function()
return _v117.Camera.Humanize
end, function()
_v117.Camera.Humanize = not _v117.Camera.Humanize
end)
_v291(_v58, (_V9({111,62,238,19,89,247,28,230,207,76})), function()
return _v117.Camera.FOVCircle
end, function()
_v117.Camera.FOVCircle = not _v117.Camera.FOVCircle
end, (_V9({111,62,238,19,89,247,28,230,207,76,81,243,86,99})), function()
return _v117.Camera.FOVCircleKey
end, function(_v254)
_v117.Camera.FOVCircleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({79,30,206,80,115,236,13,233,198})))
end)
_v281(_v58, (_V9({122,28,215,92,110,246,0,224,208,90})), 0.05, 1, function()
return _v117.Camera.Smoothness
end, function(_v501)
_v117.Camera.Smoothness = _v501
end, false)
_v281(_v58, (_V9({121,3,221,87,115,253,26,236,204,71})), 0, 1, function()
return _v117.Camera.Prediction
end, function(_v501)
_v117.Camera.Prediction = _v501
end, false)
_v281(_v58, (_V9({111,62,238})), 20, 800, function()
return _v117.Camera.FOV
end, function(_v501)
_v117.Camera.FOV = _v501
end, true, (_V9({89,9})), true)
_v281(_v58, (_V9({100,16,192,19,94,247,29,241,194,71,18,221})), 100, 2000, function()
return _v117.Camera.MaxDistance
end, function(_v501)
_v117.Camera.MaxDistance = _v501
end, true, (_V9({68})), true)
local _v388
local _v226 = _v282(_v401, (_V9({97,24,204,81,117,230})))
_v280(_v226, _v117.Camera.HitboxOptions, function()
return _v117.Camera.Hitbox
end, function(_v501)
_v117.Camera.Hitbox = _v501
if _v388 then
_v388()
end
end)
local _v523, setWeightsEnabled = _v282(_v401, (_V9({125,16,202,84,127,234,78,214,198,93,5,209,93,125,237})))
local function _v522(name)
_v281(_v523, _v312 .. (_V9({9,38,221,90,125,246,26})), 0, 100, function()
return _v117.Camera.TargetWeights[name]
end, function(_v501)
_v117.Camera.TargetWeights[name] = _v501
end, true, (_V9({12})), true)
end
_v522((_V9({97,20,217,87})))
_v522((_V9({125,30,202,64,117})))
_v522((_V9({104,3,213,64})))
_v522((_V9({101,20,223,64})))
_v388 = function()
setWeightsEnabled(_v117.Camera.Hitbox == (_V9({123,16,214,87,117,243,78,173,244,76,24,223,91,110,251,10,172})))
end
_v388()
table.insert(_v451, _v388)
local _v487 = _v282(_v401, (_V9({125,3,209,84,125,251,28,231,204,93})))
_v291(_v487, (_V9({108,31,217,81,118,251,10})), function()
return _v117.Triggerbot.Enabled
end, function()
_v117.Triggerbot.Enabled = not _v117.Triggerbot.Enabled
end, (_V9({125,3,209,84,125,251,28,231,204,93,81,243,86,99})), function()
return _v117.Triggerbot.ToggleKey
end, function(_v254)
_v117.Triggerbot.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({93,3,209,84,125,251,28,231,204,93})))
end)
_v281(_v487, (_V9({100,24,214,19,94,251,2,228,218})), 0, 500, function()
return _v117.Triggerbot.MinDelay * 1000
end, function(_v501)
_v117.Triggerbot.MinDelay = _v501 / 1000
end, true, (_V9({68,2})), true)
_v281(_v487, (_V9({100,16,192,19,94,251,2,228,218})), 0, 500, function()
return _v117.Triggerbot.MaxDelay * 1000
end, function(_v501)
_v117.Triggerbot.MaxDelay = _v501 / 1000
end, true, (_V9({68,2})), true)
_v281(_v487, (_V9({100,16,192,19,94,247,29,241,194,71,18,221})), 100, 2000, function()
return _v117.Triggerbot.MaxDistance
end, function(_v501)
_v117.Triggerbot.MaxDistance = _v501
end, true, (_V9({68})), true)
_v290(_v487, (_V9({127,24,203,80,114,251,13,238})), function()
return _v117.Triggerbot.WallCheck
end, function()
_v117.Triggerbot.WallCheck = not _v117.Triggerbot.WallCheck
end)
local _v432 = _v282(_v401, (_V9({122,24,212,86,116,234,78,196,202,68})))
_v290(_v432, (_V9({108,31,217,81,118,251,10})), function()
return _v117.SilentAim.Enabled
end, function()
_v117.SilentAim.Enabled = not _v117.SilentAim.Enabled
end)
local _v179 = _v282(_v401, (_V9({97,24,204,81,117,230,78,192,219,89,16,214,87,127,236})))
_v290(_v179, (_V9({108,31,217,81,118,251,10})), function()
return _v117.Hitbox.Enabled
end, function()
_v117.Hitbox.Enabled = not _v117.Hitbox.Enabled
end)
_v281(_v179, (_V9({122,24,194,86})), 1, 20, function()
return _v117.Hitbox.Size
end, function(_v501)
_v117.Hitbox.Size = _v501
end, true)
_v281(_v179, (_V9({125,3,217,93,105,238,15,247,198,71,18,193})), 0, 1, function()
return _v117.Hitbox.Transparency
end, function(_v501)
_v117.Hitbox.Transparency = _v501
end, false)
_v263, right = _v278(_v229:add((_V9({126,20,217,67,117,240,29}))))
local _v385 = _v282(_v263, (_V9({103,30,152,97,127,253,1,236,207})))
_v291(_v385, (_V9({108,31,217,81,118,251,10})), function()
return _v117.NoRecoil.Enabled
end, function()
_v117.NoRecoil.Enabled = not _v117.NoRecoil.Enabled
end, (_V9({103,30,152,97,127,253,1,236,207,9,58,221,74})), function()
return _v117.NoRecoil.ToggleKey
end, function(_v254)
_v117.NoRecoil.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({71,30,202,86,121,241,7,233})))
end)
_v290(_v385, (_V9({102,31,212,74,58,201,6,236,207,76,81,254,90,104,247,0,226})), function()
return _v117.NoRecoil.RequireMouseDown
end, function()
_v117.NoRecoil.RequireMouseDown = not _v117.NoRecoil.RequireMouseDown
end)
_v290(_v385, (_V9({104,29,212,92,109,190,47,236,206,9,53,215,68,116})), function()
return _v117.NoRecoil.AllowAim
end, function()
_v117.NoRecoil.AllowAim = not _v117.NoRecoil.AllowAim
end)
_v281(_v385, (_V9({122,5,202,86,116,249,26,237})), 0, 100, function()
return _v117.NoRecoil.Strength * 100
end, function(_v501)
_v117.NoRecoil.Strength = _v501 / 100
end, true, (_V9({12})), true)
local _v436 = _v282(_v263, (_V9({103,30,152,96,106,236,11,228,199})))
_v291(_v436, (_V9({108,31,217,81,118,251,10})), function()
return _v117.NoSpread.Enabled
end, function()
_v117.NoSpread.Enabled = not _v117.NoSpread.Enabled
end, (_V9({103,30,152,96,106,236,11,228,199,9,58,221,74})), function()
return _v117.NoSpread.ToggleKey
end, function(_v254)
_v117.NoSpread.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({71,30,203,67,104,251,15,225})))
end)
_v290(_v436, (_V9({102,31,212,74,58,201,6,236,207,76,81,254,90,104,247,0,226})), function()
return _v117.NoSpread.RequireMouseDown
end, function()
_v117.NoSpread.RequireMouseDown = not _v117.NoSpread.RequireMouseDown
end)
_v281(_v436, (_V9({122,5,202,86,116,249,26,237})), 0, 100, function()
return _v117.NoSpread.Strength * 100
end, function(_v501)
_v117.NoSpread.Strength = _v501 / 100
end, true, (_V9({12})), true)
end
local function _v87(_v363, _v117)
_v262 = 0
local _v229 = _v288(_v363)
local _v263, right = _v278(_v229:add((_V9({108,34,232}))))
local _v172 = _v282(_v263, (_V9({108,34,232})))
_v291(_v172, (_V9({108,31,217,81,118,251,10})), function()
return _v117.ESP.Enabled
end, function()
_v117.ESP.Enabled = not _v117.ESP.Enabled
end, (_V9({108,34,232,19,81,251,23})), function()
return _v117.ESP.ToggleKey
end, function(_v254)
_v117.ESP.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({76,2,200})))
end)
_v290(_v172, (_V9({103,33,251,64})), function()
return _v117.ESP.NPCs
end, function()
_v117.ESP.NPCs = not _v117.ESP.NPCs
end)
_v281(_v172, (_V9({100,16,192,19,94,247,29,241,194,71,18,221})), 100, 2000, function()
return _v117.ESP.MaxDistance
end, function(_v501)
_v117.ESP.MaxDistance = _v501
end, true, (_V9({68})), true)
local _v273 = _v282(_v263, (_V9({104,1,200,86,123,236,15,235,192,76})))
_v290(_v273, (_V9({102,4,204,95,115,240,11,246})), function()
return _v117.ESP.Outlines
end, function()
_v117.ESP.Outlines = not _v117.ESP.Outlines
end)
_v290(_v273, (_V9({107,30,192,86,105})), function()
return _v117.ESP.Boxes
end, function()
_v117.ESP.Boxes = not _v117.ESP.Boxes
end)
_v290(_v273, (_V9({103,16,213,86,105})), function()
return _v117.ESP.Names
end, function()
_v117.ESP.Names = not _v117.ESP.Names
end)
_v290(_v273, (_V9({109,24,203,71,123,240,13,224})), function()
return _v117.ESP.Distance
end, function()
_v117.ESP.Distance = not _v117.ESP.Distance
end)
_v290(_v273, (_V9({97,20,217,95,110,246,78,199,194,91,2})), function()
return _v117.ESP.HealthBars
end, function()
_v117.ESP.HealthBars = not _v117.ESP.HealthBars
end)
_v290(_v273, (_V9({111,24,212,95,127,250})), function()
return _v117.ESP.Filled
end, function()
_v117.ESP.Filled = not _v117.ESP.Filled
end)
_v281(_v273, (_V9({102,4,204,95,115,240,11,165,236,89,16,219,90,110,231})), 0, 1, function()
return _v117.ESP.OutlineOpacity
end, function(_v501)
_v117.ESP.OutlineOpacity = _v501
end, false)
_v281(_v273, (_V9({111,24,212,95,58,209,30,228,192,64,5,193})), 0, 1, function()
return _v117.ESP.FillOpacity
end, function(_v501)
_v117.ESP.FillOpacity = _v501
end, false)
local _v158 = _v282(_v401, (_V9({109,3,217,68,115,240,9,165,230,122,33})))
_v290(_v158, (_V9({107,30,192,86,105})), function()
return _v117.Drawing.Boxes
end, function()
_v117.Drawing.Boxes = not _v117.Drawing.Boxes
end)
_v290(_v158, (_V9({125,3,217,80,127,236,29})), function()
return _v117.Drawing.Tracers
end, function()
_v117.Drawing.Tracers = not _v117.Drawing.Tracers
end)
local _v527 = _v282(_v401, (_V9({126,30,202,95,126})))
_v290(_v527, (_V9({111,4,212,95,120,236,7,226,203,93})), function()
return _v117.Visuals.Fullbright
end, function()
_v117.Visuals.Fullbright = not _v117.Visuals.Fullbright
end)
_v290(_v527, (_V9({103,30,152,117,117,249})), function()
return _v117.Visuals.NoFog
end, function()
_v117.Visuals.NoFog = not _v117.Visuals.NoFog
end)
_v263, right = _v278(_v229:add((_V9({106,30,212,92,104,237}))))
_v277(_v263, (_V9({102,4,204,95,115,240,11,165,224,70,29,215,65})), function()
return _v117.ESP.OutlineColor
end, function(c)
_v117.ESP.OutlineColor = c
end)
_v277(_v401, (_V9({111,24,212,95,58,221,1,233,204,91})), function()
return _v117.ESP.FillColor
end, function(c)
_v117.ESP.FillColor = c
end)
_v277(_v263, (_V9({107,30,192,19,89,241,2,234,209})), function()
return _v117.Drawing.BoxColor
end, function(c)
_v117.Drawing.BoxColor = c
end)
_v277(_v401, (_V9({125,3,217,80,127,236,78,198,204,69,30,202})), function()
return _v117.Drawing.TracerColor
end, function(c)
_v117.Drawing.TracerColor = c
end)
end
local function _v90(_v363, _v117)
_v262 = 0
local _v229 = _v288(_v363)
local _v263, right = _v278(_v229:add((_V9({100,30,206,86,119,251,0,241}))))
local _v184 = _v282(_v263, (_V9({111,29,193})))
_v290(_v184, (_V9({108,31,217,81,118,251,10})), function()
return _v117.Movement.FlyEnabled
end, function()
_v117.Movement.FlyEnabled = not _v117.Movement.FlyEnabled
end)
_v281(_v184, (_V9({111,29,193,19,73,238,11,224,199})), 10, 200, function()
return _v117.Movement.FlySpeed
end, function(_v501)
_v117.Movement.FlySpeed = _v501
end, true)
local _v435 = _v282(_v263, (_V9({122,1,221,86,126})))
_v290(_v435, (_V9({108,31,217,81,118,251,10})), function()
return _v117.Movement.SpeedEnabled
end, function()
_v117.Movement.SpeedEnabled = not _v117.Movement.SpeedEnabled
end)
_v281(_v435, (_V9({122,1,221,86,126})), 16, 100, function()
return _v117.Movement.Speed
end, function(_v501)
_v117.Movement.Speed = _v501
end, true)
local _v296 = _v282(_v263, (_V9({102,5,208,86,104})))
_v290(_v296, (_V9({103,30,219,95,115,238})), function()
return _v117.Movement.NoclipEnabled
end, function()
_v117.Movement.NoclipEnabled = not _v117.Movement.NoclipEnabled
end)
_v290(_v296, (_V9({96,31,222,90,116,247,26,224,131,99,4,213,67})), function()
return _v117.Movement.InfJumpEnabled
end, function()
_v117.Movement.InfJumpEnabled = not _v117.Movement.InfJumpEnabled
end)
local _v485 = _v282(_v401, (_V9({106,29,209,80,113,190,58,213})))
_v290(_v485, (_V9({108,31,217,81,118,251,10})), function()
return _v117.Movement.ClickTPEnabled
end, function()
_v117.Movement.ClickTPEnabled = not _v117.Movement.ClickTPEnabled
end)
_v285(_v485, (_V9({100,30,220,90,124,247,11,247,131,98,20,193})), function()
return _v117.Movement.ClickTPKey
end, function(_v254)
_v117.Movement.ClickTPKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({74,29,209,80,113,234,30})))
end)
end
local function _v91(_v363, _v117)
_v262 = 0
local _v229 = _v288(_v363)
local _v263, right = _v278(_v229:add((_V9({110,20,214,86,104,255,2}))))
local _v239 = _v282(_v263, (_V9({96,31,204,86,104,248,15,230,198})))
_v281(_v239, (_V9({124,56,152,96,121,255,2,224})), 0.8, 1.5, function()
return _v117.UI.Scale
end, function(_v501)
_v117.UI.Scale = _v501
if _v525 then
_v525.Scale = _v501
end
end, false)
_v290(_v239, (_V9({98,20,193,81,115,240,10,165,243,72,31,221,95})), function()
return _v117.UI.KeybindPanel
end, function()
_v117.UI.KeybindPanel = not _v117.UI.KeybindPanel
if _v257 then
_v257.Visible = _v117.UI.KeybindPanel
end
end)
_v290(_v239, (_V9({125,16,202,84,127,234,78,193,202,90,1,212,82,99})), function()
return _v117.UI.TargetDisplay
end, function()
_v117.UI.TargetDisplay = not _v117.UI.TargetDisplay
_v462 = _v117.UI.TargetDisplay
if not _v462 and _v463 then
_v463.Visible = false
end
end)
_v290(_v239, (_V9({111,33,235,19,89,241,27,235,215,76,3})), function()
return _v117.UI.FPSCounter
end, function()
_v117.UI.FPSCounter = not _v117.UI.FPSCounter
if _v195 then
_v195.Visible = _v117.UI.FPSCounter
end
end)
_v290(_v239, (_V9({126,16,204,86,104,243,15,247,200})), function()
return _v117.UI.Watermark
end, function()
_v117.UI.Watermark = not _v117.UI.Watermark
if _v521 then
_v521.Visible = _v117.UI.Watermark
end
end)
local _v52 = _v282(_v401, (_V9({104,18,219,92,111,240,26})))
_v286(_v52, (_V9({124,2,221,65,116,255,3,224})), _v25 and _v25.Name or (_V9({203,241,44})))
_v286(_v52, (_V9({109,24,203,67,118,255,23,165,237,72,28,221})), _v25 and _v25.DisplayName or (_V9({203,241,44})))
_v286(_v52, (_V9({124,2,221,65,58,215,42})), _v25 and tostring(_v25.UserId) or (_V9({203,241,44})))
_v290(_v52, (_V9({104,31,204,90,55,223,40,206})), function()
return _v117.Utility.AntiAFK
end, function()
_v117.Utility.AntiAFK = not _v117.Utility.AntiAFK
end)
_v276(_v52, (_V9({122,20,202,69,127,236,78,205,204,89})), function()
Utility:ServerHop()
end)
_v276(_v52, (_V9({123,20,210,92,115,240,78,214,198,91,7,221,65})), function()
Utility:Rejoin()
end)
_v263, right = _v278(_v229:add((_V9({106,30,214,85,115,249,29}))))
local _v105 = _v282(_v263, (_V9({106,30,214,85,115,249,29})))
if not _v8.isSupported() then
_v286(_v105, (_V9({122,5,217,71,111,237})), (_V9({124,31,203,70,106,238,1,247,215,76,21})))
return
end
local _v313 = _v289(_v105, (_V9({74,30,214,85,115,249,78,235,194,68,20,90,179,188})))
local _v269 = _v317((_V9({111,3,217,94,127})), {
Parent = _v105,
LayoutOrder = _v318(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v269,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v387
local function _v420(name)
_v313.Text = _v312
_v387()
end
_v387 = function()
for _, _v110 in ipairs(_v269:GetChildren()) do
if not _v110:IsA((_V9({124,56,244,90,105,234,34,228,218,70,4,204}))) then
_v110:Destroy()
end
end
local _v315 = _v8.list()
if #_v315 == 0 then
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v269,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({71,30,152,64,123,232,11,225,131,74,30,214,85,115,249,29})),
})
return
end
for i, name in ipairs(_v315) do
local _v421 = (_v313.Text == _v312)
local row = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v269,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v421 and _v4.accent or _v4.row,
BackgroundTransparency = _v421 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v421 and Color3.fromRGB(255, 255, 255) or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({9,81})) .. _v312,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v407, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v420(_v312)
end)
row.MouseEnter:Connect(function()
if _v313.Text ~= _v312 then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v4.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v313.Text ~= _v312 then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v4.row
end
end)
end
end
_v276(_v105, (_V9({122,16,206,86})), function()
local _v335, res = _v8.save(_v313.Text, _v117)
if _v335 then
UI:Notify((_V9({122,16,206,86,126,190,13,234,205,79,24,223,19,61})) .. _v395 .. (_V9({14})), 2)
_v387()
else
UI:Notify(tostring(_v395), 3)
end
end)
_v276(_v105, (_V9({101,30,217,87})), function()
local _v335, res = _v8.load(_v313.Text, _v117)
if _v335 then
if _v525 then
_v525.Scale = _v117.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({101,30,217,87,127,250,78,230,204,71,23,209,84,58,185})) .. _v395 .. (_V9({14})), 2)
else
UI:Notify(tostring(_v395), 3)
end
end)
_v276(_v105, (_V9({109,20,212,86,110,251})), function()
local _v335, res = _v8.delete(_v313.Text)
if _v335 then
UI:Notify((_V9({109,20,212,86,110,251,10,165,192,70,31,222,90,125,190,73})) .. _v395 .. (_V9({14})), 2)
_v313.Text = (_V9({}))
_v387()
else
UI:Notify(tostring(_v395), 3)
end
end, _v4.danger)
_v387()
end
local function _v92(_v117)
_v463 = _v317((_V9({111,3,217,94,127})), {
Parent = _v210,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v463, CornerRadius = UDim.new(0, 6) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v463, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v463,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v463,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v155 = _v317((_V9({111,3,217,94,127})), {
Parent = _v463,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v155, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v463,
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
local _v157, _v156, _v441
_v463.InputBegan:Connect(function(_v241)
if _v250(_v241) then
_v157 = true
_v156 = _v241.Position
_v441 = _v463.Position
end
end)
table.insert(_v302, function(_v241)
if _v157 and _v463 then
local delta = _v241.Position - _v156
_v463.Position = UDim2.new(
_v441.X.Scale,
_v441.X.Offset + delta.X,
_v441.Y.Scale,
_v441.Y.Offset + delta.Y
)
end
end)
table.insert(_v390, function()
_v157 = false
end)
table.insert(_v451, function()
_v462 = _v117.UI.TargetDisplay
if not _v462 and _v463 then
_v463.Visible = false
end
end)
_v462 = _v117.UI.TargetDisplay
end
local function _v88(_v117)
_v195 = _v317((_V9({111,3,217,94,127})), {
Parent = _v210,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v195, CornerRadius = UDim.new(0, 6) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v195, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v195,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v195,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v155 = _v317((_V9({111,3,217,94,127})), {
Parent = _v195,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v155, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v195,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({4,92,152,85,106,237})),
})
table.insert(_v451, function()
if _v195 then
_v195.Visible = _v117.UI.FPSCounter
end
end)
_v195.Visible = _v117.UI.FPSCounter
end
local function _v93(_v117)
_v521 = _v317((_V9({96,28,217,84,127,210,15,231,198,69})), {
Parent = _v210,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 14, 1, -14),
Size = UDim2.fromOffset(180, 64),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Fit,
Image = (_V9({})),
Visible = false,
})
UI:SetWatermarkImage(_v117.UI.WatermarkImageId)
table.insert(_v451, function()
if _v521 then
_v521.Visible = _v117.UI.Watermark
end
end)
_v521.Visible = _v117.UI.Watermark
end
local function _v89(_v117)
_v262 = 0
_v257 = _v317((_V9({111,3,217,94,127})), {
Parent = _v210,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
Visible = false,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v257, CornerRadius = UDim.new(0, 8) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v257, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), {
Parent = _v257,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v257,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v317((_V9({111,3,217,94,127})), {
Parent = _v257,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v70, CornerRadius = UDim.new(0, 6) })
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v70,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({98,20,193,81,115,240,10,246})),
})
local _v157, _v156, _v441
bar.InputBegan:Connect(function(_v241)
if _v250(_v241) then
_v157 = true
_v156 = _v241.Position
_v441 = _v257.Position
end
end)
table.insert(_v302, function(_v241)
if _v157 and _v257 then
local delta = _v241.Position - _v156
_v257.Position = UDim2.new(
_v441.X.Scale,
_v441.X.Offset + delta.X,
_v441.Y.Scale,
_v441.Y.Offset + delta.Y
)
end
end)
table.insert(_v390, function()
_v157 = false
end)
_v285(_v257, (_V9({100,20,214,70})), function()
return _v117.UI.MenuKey
end, function(_v254)
_v117.UI.MenuKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({68,20,214,70})))
end)
_v285(_v257, (_V9({104,24,213,81,117,234})), function()
return _v117.Camera.ToggleKey
end, function(_v254)
_v117.Camera.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({72,24,213,81,117,234})))
end)
_v285(_v257, (_V9({108,34,232})), function()
return _v117.ESP.ToggleKey
end, function(_v254)
_v117.ESP.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({76,2,200})))
end)
_v285(_v257, (_V9({111,62,238,19,89,247,28,230,207,76})), function()
return _v117.Camera.FOVCircleKey
end, function(_v254)
_v117.Camera.FOVCircleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({79,30,206,80,115,236,13,233,198})))
end)
_v285(_v257, (_V9({103,30,152,97,127,253,1,236,207})), function()
return _v117.NoRecoil.ToggleKey
end, function(_v254)
_v117.NoRecoil.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({71,30,202,86,121,241,7,233})))
end)
_v285(_v257, (_V9({103,30,152,96,106,236,11,228,199})), function()
return _v117.NoSpread.ToggleKey
end, function(_v254)
_v117.NoSpread.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({71,30,203,67,104,251,15,225})))
end)
_v285(_v257, (_V9({125,3,209,84,125,251,28,231,204,93})), function()
return _v117.Triggerbot.ToggleKey
end, function(_v254)
_v117.Triggerbot.ToggleKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({93,3,209,84,125,251,28,231,204,93})))
end)
_v285(_v257, (_V9({124,31,212,92,123,250})), function()
return _v117.UI.UnloadKey
end, function(_v254)
_v117.UI.UnloadKey = _v254
end, function(_v254)
return _v255(_v117, _v254, (_V9({92,31,212,92,123,250})))
end)
table.insert(_v451, function()
if _v257 then
_v257.Visible = _v117.UI.KeybindPanel
end
end)
_v257.Visible = _v117.UI.KeybindPanel
end
local function _v426(_v442)
if not _v275 or _v442 == _v509 then
return
end
visible = _v442
if _v55 and _v55.UI then
_v55.UI.Visible = _v442
end
if _v442 then
_v275.Visible = true
_v275.GroupTransparency = 1
_v43:Create(_v275, TweenInfo.new(_v15), { GroupTransparency = 0 }):Play()
else
local _v488 = _v43:Create(_v275, TweenInfo.new(_v15), { GroupTransparency = 1 })
_v488.Completed:Once(function()
if not _v509 and _v275 then
_v275.Visible = false
end
end)
_v488:Play()
end
end
function UI:Init(_v117, _v349)
if _v210 then
return
end
_v55 = _v117
_v350 = _v349
_v440()
_v210 = _v317((_V9({122,18,202,86,127,240,41,240,202})), {
Name = (_V9({127,16,214,90,110,231,41,224,205,76,3,217,95,79,215})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v335 = pcall(function()
_v210.Parent = Utility.getGuiParent()
end)
if not _v335 or not _v210.Parent then
_v210.Parent = _v25:WaitForChild((_V9({121,29,217,74,127,236,41,240,202})))
end
_v275 = _v317((_V9({106,16,214,69,123,237,41,247,204,92,1})), {
Parent = _v210,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v525 = _v317((_V9({124,56,235,80,123,242,11})), { Parent = _v275, Scale = _v117.UI.Scale })
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v275, CornerRadius = UDim.new(0, 8) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v275, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
local _v478 = _v317((_V9({111,3,217,94,127})), {
Parent = _v275,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v478, CornerRadius = UDim.new(0, 8) })
_v317((_V9({111,3,217,94,127})), {
Parent = _v478,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
local _v155 = _v317((_V9({111,3,217,94,127})), {
Parent = _v478,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v155, CornerRadius = UDim.new(1, 0) })
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v478,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({127,16,214,90,110,231,82,227,204,71,5,152,80,117,242,1,247,158,11,82,128,7,41,219,44,192,129,23,95,220,86,108,162,65,227,204,71,5,134,19,93,251,0,224,209,72,29}))
.. (_V9({21,23,215,93,110,190,13,234,207,70,3,133,17,57,166,47,178,224,104,65,154,13,58,190,78,71,20,9,81,152,69,42,162,65,227,204,71,5,134})),
ZIndex = 2,
})
_v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v478,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.new(0, 140, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v25 and _v25.Name or (_V9({})),
ZIndex = 2,
})
local _v157, _v156, _v441
_v478.InputBegan:Connect(function(_v241)
if _v250(_v241) then
_v157 = true
_v156 = _v241.Position
_v441 = _v275.Position
end
end)
table.insert(_v302, function(_v241)
if _v157 then
local delta = _v241.Position - _v156
_v275.Position = UDim2.new(
_v441.X.Scale,
_v441.X.Offset + delta.X,
_v441.Y.Scale,
_v441.Y.Offset + delta.Y
)
end
end)
table.insert(_v390, function()
_v157 = false
end)
local _v431 = _v317((_V9({111,3,217,94,127})), {
Parent = _v275,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v431, CornerRadius = UDim.new(0, 6) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v431, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v431,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v457 = _v317((_V9({111,3,217,94,127})), {
Parent = _v431,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({124,56,244,90,105,234,34,228,218,70,4,204})), { Parent = _v457, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v492 = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v431,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.danger,
Text = (_V9({124,31,212,92,123,250})),
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v492, CornerRadius = UDim.new(0, 6) })
local _v493 = _v317((_V9({124,56,235,71,104,241,5,224})), {
Parent = _v492,
Color = _v4.danger,
Thickness = 1,
Transparency = 0.55,
})
_v492.MouseButton1Click:Connect(function()
if _v350 then
_v350()
end
end)
_v492.MouseEnter:Connect(function()
_v43:Create(_v492, _v1, {
BackgroundColor3 = _v4.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v43:Create(_v493, _v1, { Transparency = 0 }):Play()
end)
_v492.MouseLeave:Connect(function()
_v43:Create(_v492, _v1, {
BackgroundColor3 = _v4.row,
TextColor3 = _v4.danger,
}):Play()
_v43:Create(_v493, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v317((_V9({111,3,217,94,127})), {
Parent = _v275,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v317((_V9({124,56,232,82,126,250,7,235,196})), {
Parent = _v124,
PaddingRight = UDim.new(0, 4),
})
local _v459 = { (_V9({106,30,213,81,123,234})), (_V9({127,24,203,70,123,242})), (_V9({100,30,206,86,119,251,0,241})), (_V9({122,20,204,71,115,240,9,246})) }
local _v456 = {}
for i, _v458 in ipairs(_v459) do
local _v244 = _v128 == _v458
local _v454 = _v317((_V9({125,20,192,71,88,235,26,241,204,71})), {
Parent = _v457,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.rowHover,
BackgroundTransparency = _v244 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v244 and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({9,81,152,19})) .. _v458,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v454, CornerRadius = UDim.new(0, 6) })
local stripe = _v317((_V9({111,3,217,94,127})), {
Parent = _v454,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
Visible = _v244,
ZIndex = 2,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v444, CornerRadius = UDim.new(1, 0) })
local _v455 = _v317((_V9({111,3,217,94,127})), {
Parent = _v124,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v244,
})
_v456[_v458] = { btn = _v454, frame = _v455, stripe = _v444 }
_v454.MouseButton1Click:Connect(function()
_v128 = _v458
for name, _v453 in pairs(_v456) do
local _v53 = _v312 == _v458
_v453.frame.Visible = _v53
_v453.stripe.Visible = _v53
_v43:Create(_v453.btn, _v1, {
BackgroundTransparency = _v53 and 0 or 1,
TextColor3 = _v53 and _v4.text or _v4.textSub,
}):Play()
end
end)
_v454.MouseEnter:Connect(function()
if _v128 ~= _v458 then
_v43:Create(_v454, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v454.MouseLeave:Connect(function()
if _v128 ~= _v458 then
_v43:Create(_v454, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v86(_v456[(_V9({106,30,213,81,123,234}))].frame, _v117)
_v87(_v456[(_V9({127,24,203,70,123,242}))].frame, _v117)
_v90(_v456[(_V9({100,30,206,86,119,251,0,241}))].frame, _v117)
_v91(_v456[(_V9({122,20,204,71,115,240,9,246}))].frame, _v117)
_v89(_v117)
_v92(_v117)
_v88(_v117)
_v93(_v117)
if _v117.UI.Visible then
_v426(true)
end
end
function UI:Toggle()
_v426(not _v509)
end
function UI:Show()
_v426(true)
end
function UI:Hide()
_v426(false)
end
function UI:SetCurrentTarget(name)
if not _v463 then
return
end
if _v463.Visible ~= _v462 then
_v463.Visible = _v462
end
if not _v462 or not _v464 then
return
end
local _v430, colour
if _v312 and _v312 ~= (_V9({})) and _v312 ~= (_V9({103,30,214,86})) then
_v430, colour = _v312, (_V9({10,73,140,0,95,220,43}))
else
_v430, colour = (_V9({124,31,243,93,117,233,0})), (_V9({10,73,249,4,89,223,94}))
end
local text = (_V9({125,16,202,84,127,234,84,165,159,79,30,214,71,58,253,1,233,204,91,76,154})) .. _v115 .. (_V9({11,79})) .. _v430 .. (_V9({21,94,222,92,116,234,80}))
if targetPanelLabel.Text ~= _v476 then
targetPanelLabel.Text = _v476
end
end
function UI:UpdateFPS(_v191)
if not _v194 or not _v195 or not _v195.Visible then
return
end
local text = string.format((_V9({21,23,215,93,110,190,13,234,207,70,3,133,17,57,166,90,182,230,107,52,154,13,63,250,82,170,197,70,31,204,13,58,248,30,246})), _v191 or 0)
if fpsLabel.Text ~= _v476 then
fpsLabel.Text = _v476
end
end
function UI:SetWatermarkImage(_v238)
if not _v521 then
return
end
local _v148 = tostring(_v238 or (_V9({}))):match((_V9({12,21,147})))
_v521.Image = _v148 and ((_V9({91,19,192,82,105,237,11,241,202,77,75,151,28})) .. _v148) or (_V9({}))
end
function UI:SyncControls()
for _, _v186 in ipairs(_v451) do
_v186()
end
end
function UI:IsCapturingKey()
return _v100
end
function UI:Notify(text, _v163)
if not _v210 then
return
end
_v163 = _v163 or 3
local _v479 = _v317((_V9({125,20,192,71,86,255,12,224,207})), {
Parent = _v210,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 12),
Size = UDim2.fromOffset(math.max(200, #_v476 * 8 + 28), 34),
BackgroundColor3 = _v4.bar,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v4.text,
Text = _v476,
})
_v317((_V9({124,56,251,92,104,240,11,247})), { Parent = _v479, CornerRadius = UDim.new(0, 8) })
_v317((_V9({124,56,235,71,104,241,5,224})), { Parent = _v479, Color = _v4.accent, Thickness = 1, Transparency = 0.3 })
_v43:Create(_v479, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v163, function()
if _v479 and _v479.Parent then
local _v360 = _v43:Create(_v479, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v360.Completed:Once(function()
if _v479 then
_v479:Destroy()
end
end)
_v360:Play()
end
end)
end
function UI:Cleanup()
for _, _v120 in ipairs(_v489) do
_v120:Disconnect()
end
table.clear(_v489)
table.clear(_v302)
table.clear(_v390)
table.clear(_v451)
_v54 = nil
_v100 = false
_v56 = nil
_v463, targetPanelLabel = nil, nil
_v462 = false
_v257 = nil
_v521 = nil
_v195, fpsLabel = nil, nil
_v525 = nil
if _v210 then
_v210:Destroy()
_v210 = nil
_v275 = nil
end
visible = false
end
return _v44
end)()
Movement = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v45 = game:GetService((_V9({124,2,221,65,83,240,30,240,215,122,20,202,69,115,253,11})))
local _v50 = game:GetService((_V9({126,30,202,88,105,238,15,230,198})))
local _v25 = _v30.LocalPlayer
local UI = _v44
local Movement = {}
local _v2 = 16
local _v22 = 50
local _v306
local _v304
local function _v303()
local _v107 = _v25.Character
local root = _v107 and _v107:FindFirstChild((_V9({97,4,213,82,116,241,7,225,241,70,30,204,99,123,236,26})))
local humanoid = _v107 and _v107:FindFirstChildOfClass((_V9({97,4,213,82,116,241,7,225})))
if not (_v107 and _v406 and _v237 and humanoid.Health > 0) then
return nil
end
return _v107, _v406, _v237
end
local function _v305(_v94)
local _v273 = _v94.CFrame.LookVector
local _v183 = Vector3.new(_v273.X, 0, _v273.Z)
if _v183.Magnitude < 0.001 then
_v183 = Vector3.new(0, 0, -1)
else
_v183 = _v183.Unit
end
local right = _v94.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v301 = Vector3.zero
if _v45:IsKeyDown(Enum.KeyCode.W) then
_v301 = _v301 + _v183
end
if _v45:IsKeyDown(Enum.KeyCode.S) then
_v301 = _v301 - _v183
end
if _v45:IsKeyDown(Enum.KeyCode.D) then
_v301 = _v301 + _v401
end
if _v45:IsKeyDown(Enum.KeyCode.A) then
_v301 = _v301 - _v401
end
if _v45:IsKeyDown(Enum.KeyCode.Space) then
_v301 = _v301 + Vector3.yAxis
end
if _v45:IsKeyDown(Enum.KeyCode.LeftShift) then
_v301 = _v301 - Vector3.yAxis
end
if _v301.Magnitude > 0 then
return _v301.Unit
end
return nil
end
function Movement:Update(_v162, _v117)
local _v107, root, humanoid = _v303()
if _v117.NoclipEnabled and _v107 then
for _, _v364 in ipairs(_v107:GetDescendants()) do
if _v364:IsA((_V9({107,16,203,86,74,255,28,241}))) then
_v364.CanCollide = false
end
end
end
if not _v406 then
return
end
if _v117.FlyEnabled then
local _v94 = _v50.CurrentCamera
if _v94 then
root.AssemblyLinearVelocity = Vector3.zero
if not UI:IsCapturingKey() then
local _v149 = _v305(_v94)
if _v149 then
root.CFrame = root.CFrame + _v149 * (_v117.FlySpeed or 50) * _v162
end
end
end
end
if _v117.SpeedEnabled then
local _v447 = (_v117.Speed or _v2) - _v2
if _v447 > 0 and humanoid.MoveDirection.Magnitude > 0 then
root.CFrame = root.CFrame + humanoid.MoveDirection * _v447 * _v162
end
end
end
local function _v308(_v117)
if not _v117.InfJumpEnabled then
return
end
local _, root = _v303()
if _v406 then
local _v507 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v507.X, _v22, _v507.Z)
end
end
local function _v307(_v117, _v241, _v201)
if _v201 or UI:IsCapturingKey() then
return
end
if not _v117.ClickTPEnabled then
return
end
if _v241.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v45:IsKeyDown(_v117.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _, root = _v303()
local _v300 = _v25:GetMouse()
if _v406 and _v300 and _v300.Hit then
root.CFrame = CFrame.new(_v300.Hit.Position + Vector3.new(0, 3, 0))
end
end
function Movement:Init(_v117)
if not _v306 then
_v306 = _v45.JumpRequest:Connect(function()
_v308(_v117)
end)
end
if not _v304 then
_v304 = _v45.InputBegan:Connect(function(_v241, _v201)
_v307(_v117, _v241, _v201)
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
return _v26
end)()
_v10 = (function()
local _v30 = game:GetService((_V9({121,29,217,74,127,236,29})))
local _v35 = game:GetService((_V9({123,4,214,96,127,236,24,236,192,76})))
local _v45 = game:GetService((_V9({124,2,221,65,83,240,30,240,215,122,20,202,69,115,253,11})))
local _v25 = _v30.LocalPlayer
local _v9 = _v9
local _v8 = _v8
local _v7 = _v7
local _v21 = _v20
local SilentAim = _v39
local NoRecoil = _v28
local NoSpread = _v29
local Triggerbot = _v42
local ESP = _v14
local _v13 = _v13
local Visuals = _v48
local Utility = _v46
local UI = _v44
local Movement = _v26
local _v49 = _v49
local _v10 = {}
_v10.Version = (_V9({25}))
_v10.Config = _v9
_v49.Version = _v10.Version
local _v408 = false
local _v121 = {}
local _v62 = false
local _v31 = (_V9({127,16,214,90,110,231,41,224,205,76,3,217,95,72,251,13,234,202,69}))
local _v208 = {}
local _v18 = 5
local function _v209(name, _v186, ...)
local _v335, res = pcall(_v186, ...)
if _v335 then
local _v439 = _v208[name]
if _v439 then
_v439.failures = 0
end
return true, _v395
end
local _v439 = _v208[name]
if not _v439 then
_v439 = { failures = 0, lastWarn = -math.huge }
_v208[name] = _v439
end
_v439.failures = _v439.failures + 1
local _v319 = os.clock()
if _v319 - _v439.lastWarn >= _v18 then
_v439.lastWarn = _v319
warn(string.format((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,134,90,81,222,82,115,242,11,225,131,1,9,157,87,51,164,78,160,208})), _v312, _v439.failures, tostring(_v395)))
end
return false, nil
end
function _v10.IsRunning()
return _v408
end
function _v10.SaveConfig(name)
return _v8.save(_v312, _v9)
end
function _v10.LoadConfig(name)
local _v335, res = _v8.load(_v312, _v9)
if _v335 then
pcall(function()
UI:SyncControls()
end)
end
return _v335, _v395
end
function _v10.ListConfigs()
return _v8.list()
end
function _v10.DeleteConfig(name)
return _v8.delete(_v312)
end
function _v10.ServerHop()
return Utility:ServerHop()
end
function _v10.Rejoin()
return Utility:Rejoin()
end
function _v10.SetWatermarkImage(_v238)
_v9.UI.WatermarkImageId = tostring(_v238 or (_V9({})))
UI:SetWatermarkImage(_v9.UI.WatermarkImageId)
return _v10
end
function _v10.SetWebhook(_v499)
return _v49.SetWebhook(_v499)
end
function _v10.HasWebhook()
return _v49.HasWebhook()
end
function _v10.SendWebhook(content, _v356)
return _v49.SendWebhook(_v124, _v356)
end
function _v10.SendLoadedEmbed(_v246)
return _v49.SendLoadedEmbed(_v246)
end
function _v10.Start()
if _v408 then
return _v10
end
_v408 = true
local _v335, err = pcall(function()
ESP:Init()
UI:Init(_v9, function()
_v10.Stop()
end)
Movement:Init(_v9.Movement)
SilentAim:Init(_v9.SilentAim)
Utility:Init(_v9.Utility)
table.insert(_v121, _v30.PlayerAdded:Connect(function(_v373)
_v209((_V9({121,29,217,74,127,236,47,225,199,76,21})), ESP.OnPlayerAdded, _v14, _v373)
end))
table.insert(_v121, _v30.PlayerRemoving:Connect(function(_v373)
_v209((_V9({121,29,217,74,127,236,60,224,206,70,7,209,93,125})), ESP.OnPlayerRemoving, _v14, _v373)
end))
table.insert(_v121, _v45.InputBegan:Connect(function(_v241, _v201)
if _v201 or UI:IsCapturingKey() then
return
end
_v209((_V9({98,20,193,81,115,240,10,246})), function()
local _v254 = _v241.KeyCode
if _v254 == _v9.UI.MenuKey then
UI:Toggle()
elseif _v254 == _v9.UI.UnloadKey then
_v10.Stop()
else
local _v480 = {
{ _v9.Camera, (_V9({108,31,217,81,118,251,10})), _v9.Camera.ToggleKey },
{ _v9.ESP, (_V9({108,31,217,81,118,251,10})), _v9.ESP.ToggleKey },
{ _v9.Camera, (_V9({111,62,238,112,115,236,13,233,198})), _v9.Camera.FOVCircleKey },
{ _v9.NoRecoil, (_V9({108,31,217,81,118,251,10})), _v9.NoRecoil.ToggleKey },
{ _v9.NoSpread, (_V9({108,31,217,81,118,251,10})), _v9.NoSpread.ToggleKey },
{ _v9.Triggerbot, (_V9({108,31,217,81,118,251,10})), _v9.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v480) do
if _v254 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v192, fpsFrames = 0, 0
table.insert(_v121, _v35.RenderStepped:Connect(function(_v162)
_v209((_V9({108,34,232})), ESP.Update, _v14, _v9.ESP)
local _v337, target = _v209((_V9({104,24,213,81,117,234})), _v7.Update, _v7, _v9.Camera, _v9.Debug)
if not _v337 then
target = nil
end
if _v9.UI.TargetDisplay then
_v209((_V9({125,16,202,84,127,234,78,225,202,90,1,212,82,99})), function()
local _v274 = _v7:GetLookTarget(_v9.ESP, _v9.Camera)
UI:SetCurrentTarget(_v274 and _v274.Name or nil)
end)
end
_v62 = _v9.Camera.Enabled and _v461 ~= nil
_v209((_V9({103,30,235,67,104,251,15,225})), NoSpread.Update, _v29, _v9.NoSpread)
_v209((_V9({125,3,209,84,125,251,28,231,204,93})), Triggerbot.Update, _v42, _v9.Triggerbot, _v9.Camera)
_v209((_V9({100,30,206,86,119,251,0,241})), Movement.Update, _v26, _v162, _v9.Movement)
_v209((_V9({97,24,204,81,117,230})), _v21.Update, _v21, _v9.Hitbox, _v9.Camera)
_v209((_V9({109,3,217,68,115,240,9,165,230,122,33})), _v13.Update, _v13, _v9.Drawing, _v9.Camera)
_v209((_V9({127,24,203,70,123,242,29})), Visuals.Update, _v48, _v9.Visuals)
_v192 = _v192 + _v162
fpsFrames = _v193 + 1
if _v192 >= 0.25 then
local _v191 = math.floor(_v193 / _v192 + 0.5)
_v192, fpsFrames = 0, 0
if _v9.UI.FPSCounter then
_v209((_V9({111,33,235,19,121,241,27,235,215,76,3})), UI.UpdateFPS, _v44, _v191)
end
end
end))
pcall(function()
_v35:UnbindFromRenderStep(_v31)
end)
pcall(function()
_v35:BindToRenderStep(_v31, Enum.RenderPriority.Camera.Value + 1, function()
_v209((_V9({103,30,234,86,121,241,7,233})), NoRecoil.Update, _v28, _v9.NoRecoil, _v62)
end)
end)
end)
if not _v335 then
warn((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,229,72,24,212,86,126,190,26,234,131,90,5,217,65,110,164})), _v171)
_v10.Stop()
return _v10
end
if getgenv then
getgenv().VanityGeneral = _v10
end
UI:Notify(string.format((_V9({127,16,214,90,110,231,67,194,198,71,20,202,82,118,190,2,234,194,77,20,220,19,58,124,238,39,131,9,33,202,86,105,237,78,160,208})), _v9.UI.MenuKey.Name), 4)
print(string.format((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,241,92,31,214,90,116,249,78,173,213,12,2,145})), _v10.Version))
print(string.format((_V9({100,20,214,70,32,190,75,246,131,9,13,152,19,89,255,3,224,209,72,75,152,22,105,190,78,249,131,9,36,214,95,117,255,10,191,131,12,2})),
_v9.UI.MenuKey.Name,
_v9.Camera.ToggleKey.Name,
_v9.UI.UnloadKey.Name))
if _v49.HasWebhook() then
task.spawn(function()
_v49.SendLoadedEmbed(false)
end)
end
return _v10
end
function _v10.Stop()
if not _v408 then
return _v10
end
_v408 = false
for _, _v120 in ipairs(_v121) do
pcall(function()
_v120:Disconnect()
end)
end
table.clear(_v121)
pcall(function()
_v35:UnbindFromRenderStep(_v31)
end)
_v62 = false
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
_v21:Cleanup()
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
table.clear(_v208)
print((_V9({114,39,217,93,115,234,23,168,228,76,31,221,65,123,242,51,165,240,93,30,200,67,127,250})))
return _v10
end
function _v10.Toggle()
if _v408 then
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
local _v379 = getgenv().VanityGeneral
if _v379 and _v379 ~= _v10 and type(_v379.Stop) == (_V9({79,4,214,80,110,247,1,235})) then
pcall(_v379.Stop)
end
end
pcall(function()
_v10.Start()
end)
return _v10
end
