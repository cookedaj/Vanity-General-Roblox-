local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({167,28,232,53,110,232,159,221,134})
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
Hitbox = (_V9({245,125,134,81,1,133,191,245,209,194,117,143,93,26,141,251,244})),
HitboxOptions = { (_V9({245,125,134,81,1,133,191,245,209,194,117,143,93,26,141,251,244})), (_V9({239,121,137,81})), (_V9({243,115,154,70,1})), (_V9({230,110,133,70})), (_V9({235,121,143,70})) },
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
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
WatermarkImageId = (_V9({150,47,209,13,90,221,169,228,181,159,41,208,13,91,222})),
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
Hitbox = (_V9({245,125,134,81,1,133,191,245,209,194,117,143,93,26,141,251,244})),
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
KeybindPanel = true,
TargetDisplay = true,
FPSCounter = true,
Watermark = true,
},
}
function _v9.reset()
for _v385, _v466 in pairs(_v11) do
for _v225, value in pairs(_v466) do
if type(value) == (_V9({211,125,138,89,11})) then
local target = _v9[_v385][_v225]
if type(target) ~= (_V9({211,125,138,89,11})) then
target = {}
_v9[_v385][_v225] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v9[_v385][_v225] = value
end
end
end
end
return _v9
end)()
_v8 = (function()
local _v8 = {}
local _v5 = (_V9({241,125,134,92,26,145,216,184,232,194,110,137,89}))
local _v30 = { (_V9({228,125,133,80,28,137})), (_V9({226,79,184})), (_V9({233,115,186,80,13,135,246,177})), (_V9({233,115,187,69,28,141,254,185})), (_V9({234,115,158,80,3,141,241,169})), (_V9({244,117,132,80,0,156,222,180,235})), (_V9({239,117,156,87,1,144})), (_V9({227,110,137,66,7,134,248})), (_V9({241,117,155,64,15,132,236})), (_V9({242,104,129,89,7,156,230})), (_V9({242,85})) }
local function _v176()
return type(writefile) == (_V9({193,105,134,86,26,129,240,179}))
and type(readfile) == (_V9({193,105,134,86,26,129,240,179}))
and type(listfiles) == (_V9({193,105,134,86,26,129,240,179}))
end
local function _v151()
if type(isfolder) == (_V9({193,105,134,86,26,129,240,179})) and type(makefolder) == (_V9({193,105,134,86,26,129,240,179})) then
if not isfolder(_v5) then
pcall(makefolder, _v5)
end
end
end
local function _v380(name)
return (tostring(name or (_V9({}))):gsub((_V9({252,66,205,66,49,205,178,253,219})), (_V9({}))):gsub((_V9({249,57,155,30})), (_V9({}))):gsub((_V9({130,111,195,17})), (_V9({}))))
end
local function _v335(name)
return _v5 .. (_V9({136,108,154,90,8,129,243,184,217})) .. game.PlaceId .. (_V9({248})) .. name .. (_V9({137,118,155,90,0}))
end
local function _v236(name)
return _v5 .. (_V9({136})) .. name .. (_V9({137,118,155,90,0}))
end
local function _v150(v)
local t = typeof(v)
if t == (_V9({228,115,132,90,28,219})) then
return { __t = (_V9({228,115,132,90,28,219})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({226,114,157,88,39,156,250,176})) then
return { __t = (_V9({226,114,157,88})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({211,125,138,89,11})) then
local _v330 = {}
for k, _v463 in pairs(v) do
if type(_v463) ~= (_V9({193,105,134,86,26,129,240,179})) then
local _v149 = _v150(_v463)
if _v149 ~= nil then
_v330[k] = _v149
end
end
end
return _v330
elseif t == (_V9({201,105,133,87,11,154})) or t == (_V9({212,104,154,92,0,143})) or t == (_V9({197,115,135,89,11,137,241})) then
return v
end
return nil
end
local function _v122(v)
if type(v) ~= (_V9({211,125,138,89,11})) then
return v
end
if v.__t == (_V9({228,115,132,90,28,219})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({226,114,157,88})) then
local _v307, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v307 then
return item
end
return nil
end
return v
end
local function _v57(target, _v403)
for k, v in pairs(_v403) do
if type(v) == (_V9({211,125,138,89,11})) and v.__t == nil then
if type(target[k]) == (_V9({211,125,138,89,11})) then
_v57(target[k], v)
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
return _v176()
end
function _v8.list()
local _v330 = {}
if not _v176() then
return _v330
end
_v151()
local _v307, files = pcall(listfiles, _v5)
if not _v307 or type(files) ~= (_V9({211,125,138,89,11})) then
return _v330
end
for _, _v334 in ipairs(files) do
local _v346 = (_V9({215,110,135,83,7,132,250,130})) .. game.PlaceId .. (_V9({248}))
local name = tostring(_v334):match((_V9({143,71,182,26,50,181,180,244,163,137,118,155,90,0,204})))
if name and name:sub(1, #_v346) == _v346 then
table.insert(_v330, name:sub(#_v346 + 1))
end
end
table.sort(_v330)
return _v330
end
function _v8.save(name, _v104)
if not _v176() then
return false, (_V9({243,116,129,70,78,141,231,184,229,210,104,135,71,78,128,254,174,166,201,115,200,83,7,132,250,253,199,247,85}))
end
name = _v380(name)
if name == (_V9({})) then
return false, (_V9({226,114,156,80,28,200,254,253,229,200,114,142,92,9,200,241,188,235,194}))
end
_v151()
local data = {}
for _, _v385 in ipairs(_v30) do
if type(_v104[_v385]) == (_V9({211,125,138,89,11})) then
data[_v385] = _v150(_v104[_v385])
end
end
local _v311, json = pcall(function()
return game:GetService((_V9({239,104,156,69,61,141,237,171,239,196,121}))):JSONEncode(data)
end)
if not _v311 then
return false, (_V9({226,114,139,90,10,141,191,187,231,206,112,141,81,84,200})) .. tostring(json)
end
local _v314, err = pcall(writefile, _v335(name), json)
if not _v314 then
return false, (_V9({240,110,129,65,11,200,249,188,239,203,121,140,15,78})) .. tostring(err)
end
return true, name
end
function _v8.load(name, _v104)
if not _v176() then
return false, (_V9({243,116,129,70,78,141,231,184,229,210,104,135,71,78,128,254,174,166,201,115,200,83,7,132,250,253,199,247,85}))
end
name = _v380(name)
if name == (_V9({})) then
return false, (_V9({226,114,156,80,28,200,254,253,229,200,114,142,92,9,200,241,188,235,194}))
end
local _v334 = _v335(name)
if type(isfile) == (_V9({193,105,134,86,26,129,240,179})) then
local _v310, exists = pcall(isfile, _v334)
if _v310 and not exists then
local _v235 = _v236(name)
local _v312, legacyExists = pcall(isfile, _v235)
if _v312 and legacyExists then
_v334 = _v235
else
return false, (_V9({233,115,200,86,1,134,249,180,225,135,114,137,88,11,140,191,250})) .. name .. (_V9({128}))
end
end
end
local _v313, raw = pcall(readfile, _v334)
if not _v313 or type(raw) ~= (_V9({212,104,154,92,0,143})) then
return false, (_V9({245,121,137,81,78,142,254,180,234,194,120}))
end
local _v311, data = pcall(function()
return game:GetService((_V9({239,104,156,69,61,141,237,171,239,196,121}))):JSONDecode(raw)
end)
if not _v311 or type(data) ~= (_V9({211,125,138,89,11})) then
return false, (_V9({243,116,137,65,78,142,246,177,227,135,117,155,91,73,156,191,171,231,203,117,140,21,36,187,208,147}))
end
for _, _v385 in ipairs(_v30) do
if type(data[_v385]) == (_V9({211,125,138,89,11})) and type(_v104[_v385]) == (_V9({211,125,138,89,11})) then
_v57(_v104[_v385], data[_v385])
end
end
return true, name
end
function _v8.delete(name)
name = _v380(name)
if name == (_V9({})) then
return false, (_V9({226,114,156,80,28,200,254,253,229,200,114,142,92,9,200,241,188,235,194}))
end
if type(delfile) ~= (_V9({193,105,134,86,26,129,240,179})) then
return false, (_V9({243,116,129,70,78,141,231,184,229,210,104,135,71,78,139,254,179,161,211,60,140,80,2,141,235,184,166,193,117,132,80,29}))
end
local _v307, err = pcall(delfile, _v335(name))
if not _v307 then
return false, tostring(err)
end
return true, name
end
return _v8
end)()
Utility = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v34 = game:GetService((_V9({243,121,132,80,30,135,237,169,213,194,110,158,92,13,141})))
local _v22 = _v24.LocalPlayer
local Utility = {}
local _v34 = game:GetService((_V9({243,121,132,80,30,135,237,169,213,194,110,158,92,13,141})))
local _v462
function Utility:Init(_v104)
if _v462 then
return
end
local _v480 = (type(VirtualUser) ~= (_V9({201,117,132})) and VirtualUser) or nil
if not _v480 then
pcall(function()
_v480 = game:GetService((_V9({241,117,154,65,27,137,243,136,245,194,110})))
end)
end
if not _v480 then
return
end
_v462 = _v22.Idled:Connect(function()
if _v104.AntiAFK then
_v480:CaptureController()
_v480:ClickButton2(Vector2.new())
end
end)
end
function Utility:Cleanup()
if _v462 then
_v462:Disconnect()
_v462 = nil
end
end
function Utility:ServerHop()
local _v307, err = pcall(function()
_v34:Teleport(game.PlaceId, _v22)
end)
if not _v307 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,213,194,110,158,80,28,200,247,178,246,135,122,137,92,2,141,251,231})), err)
end
return _v307
end
function Utility:Rejoin()
local _v307, err = pcall(function()
_v34:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v22)
end)
if not _v307 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,212,194,118,135,92,0,200,249,188,239,203,121,140,15})), err)
end
return _v307
end
function Utility.getGuiParent()
local _v307, hidden = pcall(function()
return gethui and gethui()
end)
if _v307 and hidden then
return hidden
end
local _v308, coreGui = pcall(function()
return game:GetService((_V9({228,115,154,80,41,157,246})))
end)
if _v308 and coreGui then
return coreGui
end
return _v22:WaitForChild((_V9({247,112,137,76,11,154,216,168,239})))
end
return Utility
end)()
_v7 = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v39 = game:GetService((_V9({240,115,154,94,29,152,254,190,227})))
local _v22 = _v24.LocalPlayer
local _v7 = {}
_v7.LocalRootPos = nil
local frame = {}
local _v3 = 0.5
local _v67 = {}
local _v68 = -math.huge
function _v7.GetBotCharacters()
local _v290 = os.clock()
if _v290 - _v68 < _v3 then
return _v67
end
_v68 = _v290
table.clear(_v67)
for _, _v125 in ipairs(_v39:GetDescendants()) do
if _v125:IsA((_V9({234,115,140,80,2})))
and _v125:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
and not _v24:GetPlayerFromCharacter(_v125)
then
table.insert(_v67, _v125)
end
end
return _v67
end
local function _v373(_v95, humanoid)
return humanoid.RootPart
or _v95:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
or _v95:FindFirstChild((_V9({243,115,154,70,1})))
or _v95:FindFirstChild((_V9({242,108,152,80,28,188,240,175,245,200})))
or _v95.PrimaryPart
end
local _v27 = {
Head = { (_V9({239,121,137,81})) },
Torso = { (_V9({242,108,152,80,28,188,240,175,245,200})), (_V9({235,115,159,80,28,188,240,175,245,200})), (_V9({243,115,154,70,1})), (_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})) },
Arms = {
(_V9({235,121,142,65,38,137,241,185})), (_V9({245,117,143,93,26,160,254,179,226})),
(_V9({235,121,142,65,34,135,232,184,244,230,110,133})), (_V9({245,117,143,93,26,164,240,170,227,213,93,154,88})),
(_V9({235,121,142,65,59,152,239,184,244,230,110,133})), (_V9({245,117,143,93,26,189,239,173,227,213,93,154,88})),
(_V9({235,121,142,65,78,169,237,176})), (_V9({245,117,143,93,26,200,222,175,235})),
},
Legs = {
(_V9({235,121,142,65,40,135,240,169})), (_V9({245,117,143,93,26,174,240,178,242})),
(_V9({235,121,142,65,34,135,232,184,244,235,121,143})), (_V9({245,117,143,93,26,164,240,170,227,213,80,141,82})),
(_V9({235,121,142,65,59,152,239,184,244,235,121,143})), (_V9({245,117,143,93,26,189,239,173,227,213,80,141,82})),
(_V9({235,121,142,65,78,164,250,186})), (_V9({245,117,143,93,26,200,211,184,225})),
},
}
local _v26 = { (_V9({239,121,137,81})), (_V9({243,115,154,70,1})), (_V9({230,110,133,70})), (_V9({235,121,143,70})) }
local function _v338(_v95, _v357)
local _v286 = _v27[_v357]
if not _v286 then
return nil
end
for _, name in ipairs(_v286) do
local _v333 = _v95:FindFirstChild(name)
if _v333 and _v333:IsA((_V9({229,125,155,80,62,137,237,169}))) then
return _v333
end
end
return nil
end
local function _v337(_v95)
for _, _v357 in ipairs(_v26) do
local _v333 = _v338(_v95, _v357)
if _v333 then
return _v333
end
end
for _, _v125 in ipairs(_v95:GetDescendants()) do
if _v125:IsA((_V9({229,125,155,80,62,137,237,169}))) then
return _v125
end
end
return nil
end
local function _v54(_v95, _v192, hrp)
return _v192
or hrp
or _v95:FindFirstChild((_V9({242,108,152,80,28,188,240,175,245,200})))
or _v95:FindFirstChild((_V9({243,115,154,70,1})))
or _v337(_v95)
end
local function _v73(_v95, _v342, _v80, _v81)
local humanoid = _v95 and _v95:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v192 = _v95:FindFirstChild((_V9({239,121,137,81})))
local hrp = _v95:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
local _v372 = _v373(_v95, humanoid)
local _v53 = _v54(_v95, _v192, hrp)
local _v154 = {
Player = _v342,
Character = _v95,
Humanoid = humanoid,
Head = _v192,
RootPart = _v372,
HRP = hrp,
Anchor = _v53,
}
if _v53 then
_v154.WorldDistance = (_v53.Position - _v81).Magnitude
local _v412, vis = _v80:WorldToViewportPoint(_v53.Position)
_v154.AnchorScreen = _v412
_v154.AnchorOnScreen = vis
end
if _v372 then
local _v445 = _v192 and (_v192.Position + Vector3.new(0, _v192.Size.Y, 0))
or (_v372.Position + Vector3.new(0, 3, 0))
local _v450, tvis = _v80:WorldToViewportPoint(_v445)
_v154.TopScreen = _v450
_v154.TopOnScreen = tvis
_v154.BotScreen = _v80:WorldToViewportPoint(_v372.Position - Vector3.new(0, 3.2, 0))
end
return _v154
end
function _v7:Update(_v82, _v156)
table.clear(frame)
local _v80 = _v39.CurrentCamera
local _v281 = _v22.Character
local _v282 = _v281 and _v281:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
_v7.LocalRootPos = _v282 and _v282.Position or nil
if not _v80 then
return
end
local _v81 = _v80.CFrame.Position
for _, _v342 in ipairs(_v24:GetPlayers()) do
if _v342 ~= _v22 then
local _v154 = _v73(_v342.Character, _v342, _v80, _v81)
if _v154 then
table.insert(frame, _v154)
end
end
end
if _v82 and _v82.TargetBots then
for _, _v95 in ipairs(_v7.GetBotCharacters()) do
local _v154 = _v73(_v95, nil, _v80, _v81)
if _v154 then
table.insert(frame, _v154)
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
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v39 = game:GetService((_V9({240,115,154,94,29,152,254,190,227})))
local _v22 = _v24.LocalPlayer
local Utility = Utility
local _v7 = _v7
local _v6 = {}
local Camera = _v39.CurrentCamera
local _v90 = Random.new()
local _v27 = {
Head = { (_V9({239,121,137,81})) },
Torso = { (_V9({242,108,152,80,28,188,240,175,245,200})), (_V9({235,115,159,80,28,188,240,175,245,200})), (_V9({243,115,154,70,1})), (_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})) },
Arms = {
(_V9({235,121,142,65,38,137,241,185})), (_V9({245,117,143,93,26,160,254,179,226})),
(_V9({235,121,142,65,34,135,232,184,244,230,110,133})), (_V9({245,117,143,93,26,164,240,170,227,213,93,154,88})),
(_V9({235,121,142,65,59,152,239,184,244,230,110,133})), (_V9({245,117,143,93,26,189,239,173,227,213,93,154,88})),
(_V9({235,121,142,65,78,169,237,176})), (_V9({245,117,143,93,26,200,222,175,235})),
},
Legs = {
(_V9({235,121,142,65,40,135,240,169})), (_V9({245,117,143,93,26,174,240,178,242})),
(_V9({235,121,142,65,34,135,232,184,244,235,121,143})), (_V9({245,117,143,93,26,164,240,170,227,213,80,141,82})),
(_V9({235,121,142,65,59,152,239,184,244,235,121,143})), (_V9({245,117,143,93,26,189,239,173,227,213,80,141,82})),
(_V9({235,121,142,65,78,164,250,186})), (_V9({245,117,143,93,26,200,211,184,225})),
},
}
local _v26 = { (_V9({239,121,137,81})), (_V9({243,115,154,70,1})), (_V9({230,110,133,70})), (_V9({235,121,143,70})) }
local _v369 = Random.new()
local function _v338(_v95, _v357)
local _v286 = _v27[_v357]
if not _v286 then
return nil
end
for _, name in ipairs(_v286) do
local _v333 = _v95:FindFirstChild(name)
if _v333 and _v333:IsA((_V9({229,125,155,80,62,137,237,169}))) then
return _v333
end
end
return nil
end
local function _v337(_v95)
for _, _v357 in ipairs(_v26) do
local _v333 = _v338(_v95, _v357)
if _v333 then
return _v333
end
end
for _, _v125 in ipairs(_v95:GetDescendants()) do
if _v125:IsA((_V9({229,125,155,80,62,137,237,169}))) then
return _v125
end
end
return nil
end
local function _v55(_v95)
return _v95:FindFirstChild((_V9({239,121,137,81})))
or _v95:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
or _v95:FindFirstChild((_V9({242,108,152,80,28,188,240,175,245,200})))
or _v95:FindFirstChild((_V9({243,115,154,70,1})))
or _v337(_v95)
end
local function _v371(_v483)
local _v446 = 0
for _, _v357 in ipairs(_v26) do
_v446 = _v446 + math.max(0, (_v483 and _v483[_v357]) or 0)
end
if _v446 <= 0 then
return (_V9({239,121,137,81}))
end
local _v370 = _v369:NextNumber() * _v446
local _v40 = 0
for _, _v357 in ipairs(_v26) do
_v40 = _v40 + math.max(0, _v483[_v357] or 0)
if _v370 <= _v40 then
return _v357
end
end
return (_V9({239,121,137,81}))
end
local function _v182(_v489)
local _v469, visible = Camera:WorldToViewportPoint(_v489)
if not visible or _v469.Z < 0 then
return math.huge
end
local _v383 = Vector2.new(_v469.X, _v469.Y)
local _v91 = Camera.ViewportSize / 2
return (_v383 - _v91).Magnitude
end
local function _v224(_v345, _v95)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v22.Character }
local _v367 = _v39:Raycast(Camera.CFrame.Position, _v345 - Camera.CFrame.Position, params)
return not _v367 or _v367.Instance:IsDescendantOf(_v95)
end
local _v15 = Color3.fromRGB(132, 62, 190)
local _v169, _v170, fovStroke
local function _v152()
if _v170 and _v170.Parent then
return _v170
end
_v169 = Instance.new((_V9({244,127,154,80,11,134,216,168,239})))
_v169.Name = (_V9({241,125,134,92,26,145,216,184,232,194,110,137,89,40,167,201}))
_v169.ResetOnSpawn = false
_v169.IgnoreGuiInset = true
_v169.DisplayOrder = 998
local _v307 = pcall(function()
_v169.Parent = Utility.getGuiParent()
end)
if not _v307 or not _v169.Parent then
_v169.Parent = _v22:WaitForChild((_V9({247,112,137,76,11,154,216,168,239})))
end
_v170 = Instance.new((_V9({225,110,137,88,11})))
_v170.Name = (_V9({245,117,134,82}))
_v170.AnchorPoint = Vector2.new(0.5, 0.5)
_v170.Position = UDim2.fromScale(0.5, 0.5)
_v170.BackgroundTransparency = 1
_v170.BorderSizePixel = 0
_v170.Parent = _v169
local _v110 = Instance.new((_V9({242,85,171,90,28,134,250,175})))
_v110.CornerRadius = UDim.new(1, 0)
_v110.Parent = _v170
fovStroke = Instance.new((_V9({242,85,187,65,28,135,244,184})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v15
fovStroke.Parent = _v170
return _v170
end
local function _v457(_v104)
local _v394 = _v104.FOVCircle
if not _v394 then
if _v170 then
_v170.Visible = false
end
return
end
local _v368 = _v152()
if not _v368 then
return
end
local _v130 = math.max(0, _v104.FOV or 0) * 2
_v368.Size = UDim2.fromOffset(_v130, _v130)
_v368.Visible = true
end
local function _v129()
if _v169 then
pcall(function()
_v169:Destroy()
end)
end
_v169, _v170, fovStroke = nil, nil, nil
end
local function _v159(_v95, _v342, _v104)
if not _v95 then
return nil
end
if _v104.TeamCheck and _v342 and _v342.Team ~= nil and _v342.Team == _v22.Team then
return nil
end
local humanoid = _v95:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v53 = _v55(_v95)
if not _v53 then
return nil
end
local _v136 = _v182(_v53.Position)
if _v136 >= (_v104.FOV or 200) then
return nil
end
local _v488 = (_v53.Position - Camera.CFrame.Position).Magnitude
if _v488 > _v104.MaxDistance then
return nil
end
if _v104.WallCheck and not _v224(_v53.Position, _v95) then
return nil
end
return { Player = _v342, Character = _v95, Anchor = _v53, ScreenDistance = _v136 }
end
local function _v384(_v84)
if not _v84.AnchorOnScreen or _v84.AnchorScreen.Z < 0 then
return math.huge
end
local _v383 = Vector2.new(_v84.AnchorScreen.X, _v84.AnchorScreen.Y)
local _v91 = Camera.ViewportSize / 2
return (_v383 - _v91).Magnitude
end
local function _v158(_v84, _v104)
local _v342 = _v84.Player
if _v104.TeamCheck and _v342 and _v342.Team ~= nil and _v342.Team == _v22.Team then
return nil
end
local _v53 = _v84.Anchor
if not _v53 then
return nil
end
local _v136 = _v384(_v84)
if _v136 >= (_v104.FOV or 200) then
return nil
end
if (_v84.WorldDistance or math.huge) > _v104.MaxDistance then
return nil
end
if _v104.WallCheck and not _v224(_v53.Position, _v84.Character) then
return nil
end
return { Player = _v342, Character = _v84.Character, Anchor = _v53, ScreenDistance = _v136 }
end
function _v6:FindBestTarget(_v104)
local _v63
local _v64 = math.huge
for _, _v84 in ipairs(_v7:Get()) do
local _v85 = _v158(_v84, _v104)
if _v85 and _v85.ScreenDistance < _v64 then
_v64 = _v85.ScreenDistance
_v63 = _v85
end
end
return _v63
end
local _v20 = 50
function _v6:GetLookTarget(_v156, _v82)
local _v63
local _v64 = _v20
local _v283 = _v7.LocalRootPos
local _v263 = (_v156 and _v156.MaxDistance) or math.huge
local _v438 = _v82 and _v82.TeamCheck
for _, _v84 in ipairs(_v7:Get()) do
local _v342 = _v84.Player
if not (_v438 and _v342 and _v342.Team ~= nil and _v342.Team == _v22.Team) then
local _v53 = _v84.Anchor
if _v53 and not (_v283 and (_v53.Position - _v283).Magnitude > _v263) then
local _v136 = _v384(_v84)
if _v136 <= _v64 then
_v64 = _v136
_v63 = _v342 or _v84.Character
end
end
end
end
return _v63
end
function _v6:_resolveRegion(_v95, _v104)
local _v268 = _v104.Hitbox
if _v268 and _v268 ~= (_V9({245,125,134,81,1,133,191,245,209,194,117,143,93,26,141,251,244})) and _v27[_v268] then
return _v268
end
if self._lockedChar ~= _v95 then
self._lockedChar = _v95
self._rolledRegion = _v371(_v104.TargetWeights)
end
return self._rolledRegion or (_V9({239,121,137,81}))
end
function _v6:PointCamera(_v428, _v399)
local _v126 = CFrame.lookAt(Camera.CFrame.Position, _v428)
local _v52 = math.clamp(1 - (_v399 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v126, _v52)
end
function _v6:Update(_v104, debug)
Camera = _v39.CurrentCamera
_v457(_v104)
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
if not self._stickyPlayer or self._stickyPlayer.Parent == _v24 then
target = _v159(self._stickyCharacter, self._stickyPlayer, _v104)
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
local _v357 = self:_resolveRegion(target.Character, _v104)
local _v48 = _v338(target.Character, _v357) or _v337(target.Character)
if not _v48 then
self._currentTarget = nil
return
end
local _v49 = _v48.Position
local _v488 = (_v49 - Camera.CFrame.Position).Magnitude
if (_v104.Prediction or 0) > 0 then
_v49 = _v49 + _v48.AssemblyLinearVelocity * _v104.Prediction * (_v488 / 500)
end
local _v399 = _v104.Smoothness
if _v104.Humanize then
_v399 = _v399 * (0.9 + _v90:NextNumber() * 0.2)
_v49 = _v49 + _v90:NextUnitVector() * (_v488 * math.rad(_v90:NextNumber() * 0.25))
end
self:PointCamera(_v49, _v399)
target.Part = _v48
target.Region = _v357
self._currentTarget = target
if debug then
print((_V9({243,110,137,86,5,129,241,186,188})), target.Character.Name, (_V9({245,121,143,92,1,134,165})), _v357, (_V9({227,117,155,65,15,134,252,184,188})), math.floor(target.ScreenDistance))
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
_v129()
end
_v6.GetBotCharacters = _v7.GetBotCharacters
return _v6
end)()
ESP = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v39 = game:GetService((_V9({240,115,154,94,29,152,254,190,227})))
local _v22 = _v24.LocalPlayer
local _v9 = _v9
local Utility = Utility
local _v7 = _v7
local ESP = {}
local _v153 = {}
local _v109
local _v70
local _v12 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v218(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v157(_v95)
local _v209 = _v95:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
return (_v209 and _v209.RootPart)
or _v95:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
or _v95:FindFirstChild((_V9({243,115,154,70,1})))
or _v95:FindFirstChild((_V9({242,108,152,80,28,188,240,175,245,200})))
or _v95.PrimaryPart
end
local function _v179()
if _v70 and _v70.Parent then
return _v70
end
_v70 = Instance.new((_V9({244,127,154,80,11,134,216,168,239})))
_v70.Name = (_V9({241,125,134,92,26,145,216,184,232,194,110,137,89,44,135,231,184,245}))
_v70.ResetOnSpawn = false
_v70.IgnoreGuiInset = true
_v70.DisplayOrder = 996
local _v307 = pcall(function()
_v70.Parent = Utility.getGuiParent()
end)
if not _v307 or not _v70.Parent then
_v70.Parent = _v22:WaitForChild((_V9({247,112,137,76,11,154,216,168,239})))
end
return _v70
end
local function _v456(_v154, _v95, _v104, _v84)
local _v80 = _v39.CurrentCamera
local root = _v84 and _v84.RootPart or _v157(_v95)
if not _v80 or not root or not _v154.box then
if _v154.box then
_v154.box.Visible = false
end
return
end
local _v444, onScreen, botV
if _v84 then
if not _v84.TopScreen then
_v154.box.Visible = false
return
end
_v444, onScreen, botV = _v84.TopScreen, _v84.TopOnScreen, _v84.BotScreen
else
local _v192 = _v95:FindFirstChild((_V9({239,121,137,81})))
local _v445 = _v192 and (_v192.Position + Vector3.new(0, _v192.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v69 = root.Position - Vector3.new(0, 3.2, 0)
_v444, onScreen = _v80:WorldToViewportPoint(_v445)
botV = _v80:WorldToViewportPoint(_v69)
end
if not onScreen or _v444.Z <= 0 then
_v154.box.Visible = false
return
end
local _v196 = math.abs(botV.Y - _v444.Y)
local _v484 = _v196 * 0.62
local _v112 = (_v444.X + botV.X) * 0.5
local _v113 = (_v444.Y + botV.Y) * 0.5
_v154.box.Size = UDim2.fromOffset(_v484, _v196)
_v154.box.Position = UDim2.fromOffset(_v112 - _v484 * 0.5, _v113 - _v196 * 0.5)
_v154.box.BackgroundColor3 = _v104.FillColor
_v154.box.BackgroundTransparency = _v104.Filled and (1 - _v104.FillOpacity) or 1
_v154.boxStroke.Color = _v104.OutlineColor
_v154.boxStroke.Transparency = 1 - _v104.OutlineOpacity
_v154.box.Visible = true
end
local function _v254(_v154, name, _v192, _v104)
local _v425 = Instance.new((_V9({229,117,132,89,12,135,254,175,226,224,105,129})))
_v425.Name = (_V9({241,91,161,91,8,135}))
_v425.Size = UDim2.fromOffset(200, 46)
_v425.StudsOffset = Vector3.new(0, 2.7, 0)
_v425.AlwaysOnTop = true
_v425.Adornee = _v192
_v425.Parent = _v192
local _v202 = Instance.new((_V9({225,110,137,88,11})))
_v202.BackgroundTransparency = 1
_v202.Size = UDim2.fromScale(1, 1)
_v202.Parent = _v425
local _v232 = Instance.new((_V9({242,85,164,92,29,156,211,188,255,200,105,156})))
_v232.SortOrder = Enum.SortOrder.LayoutOrder
_v232.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v232.VerticalAlignment = Enum.VerticalAlignment.Center
_v232.Parent = _v202
local _v285 = Instance.new((_V9({243,121,144,65,34,137,253,184,234})))
_v285.LayoutOrder = 1
_v285.BackgroundTransparency = 1
_v285.Size = UDim2.new(1, 0, 0, 16)
_v285.Font = Enum.Font.GothamBold
_v285.TextSize = 13
_v285.TextColor3 = _v104.OutlineColor
_v285.TextStrokeTransparency = 0.35
_v285.Text = name
_v285.Visible = false
_v285.Parent = _v202
local _v135 = Instance.new((_V9({243,121,144,65,34,137,253,184,234})))
_v135.LayoutOrder = 2
_v135.BackgroundTransparency = 1
_v135.Size = UDim2.new(1, 0, 0, 14)
_v135.Font = Enum.Font.Gotham
_v135.TextSize = 12
_v135.TextColor3 = _v104.OutlineColor
_v135.TextStrokeTransparency = 0.4
_v135.Text = (_V9({}))
_v135.Visible = false
_v135.Parent = _v202
local _v194 = Instance.new((_V9({225,110,137,88,11})))
_v194.LayoutOrder = 3
_v194.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v194.BackgroundTransparency = 0.3
_v194.BorderSizePixel = 0
_v194.Size = UDim2.new(0.55, 0, 0, 5)
_v194.Visible = false
_v194.Parent = _v202
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v194, CornerRadius = UDim.new(1, 0) })
local _v195 = Instance.new((_V9({225,110,137,88,11})))
_v195.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v195.BorderSizePixel = 0
_v195.Size = UDim2.fromScale(1, 1)
_v195.Parent = _v194
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v195, CornerRadius = UDim.new(1, 0) })
_v154.nameTag = _v425
_v154.nameLabel = _v285
_v154.distanceLabel = _v135
_v154.healthBack = _v194
_v154.healthFill = _v195
_v154.nameHead = _v192
end
local function _v458(name, _v154, _v95, _v104, _v84)
local _v192 = _v84 and (_v84.Head or _v84.HRP)
or _v95:FindFirstChild((_V9({239,121,137,81})))
or _v95:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
if not _v192 then
if _v154.nameTag then
_v154.nameTag.Enabled = false
end
return
end
if not _v154.nameTag or not _v154.nameTag.Parent or _v154.nameHead ~= _v192 then
if _v154.nameTag then
pcall(function()
_v154.nameTag:Destroy()
end)
end
_v254(_v154, name, _v192, _v104)
end
_v154.nameLabel.TextColor3 = _v104.OutlineColor
_v154.nameLabel.Visible = _v104.Names or _v104.NameTags
_v154.distanceLabel.Visible = _v104.Distance or _v104.DistanceTags
if _v154.distanceLabel.Visible then
_v154.distanceLabel.TextColor3 = _v104.OutlineColor
local _v283, hrp
if _v84 then
_v283, hrp = _v7.LocalRootPos, _v84.HRP
else
local _v281 = _v22.Character
local _v282 = _v281 and _v281:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
_v283 = _v282 and _v282.Position
hrp = _v95:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
end
local d = (_v283 and hrp) and math.floor((hrp.Position - _v283).Magnitude + 0.5) or 0
_v154.distanceLabel.Text = (_V9({252})) .. d .. (_V9({202,65}))
end
_v154.healthBack.Visible = _v104.HealthBars
if _v104.HealthBars then
local humanoid = _v84 and _v84.Humanoid or _v95:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
local _v174 = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v154.healthFill.Size = UDim2.fromScale(_v174, 1)
_v154.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v174)
end
_v154.nameTag.Enabled = true
end
local function _v199(_v154)
_v154.hl.Enabled = false
if _v154.box then
_v154.box.Visible = false
end
if _v154.nameTag then
_v154.nameTag.Enabled = false
end
end
local function _v361(_v154, _v95, name, _v104, _v84)
if _v104.Outlines then
if _v154.hl.Adornee ~= _v95 then
_v154.hl.Adornee = _v95
end
_v154.hl.OutlineColor = _v104.OutlineColor
_v154.hl.FillColor = _v104.FillColor
_v154.hl.OutlineTransparency = 1 - _v104.OutlineOpacity
_v154.hl.FillTransparency = _v104.Filled and (1 - _v104.FillOpacity) or 1
_v154.hl.DepthMode = _v12
_v154.hl.Enabled = true
else
_v154.hl.Enabled = false
end
if _v104.Boxes then
_v456(_v154, _v95, _v104, _v84)
elseif _v154.box then
_v154.box.Visible = false
end
if _v104.Names or _v104.Distance or _v104.NameTags or _v104.DistanceTags or _v104.HealthBars then
_v458(name, _v154, _v95, _v104, _v84)
elseif _v154.nameTag then
_v154.nameTag.Enabled = false
end
end
local function _v137(_v333)
local _v281 = _v22.Character
local _v282 = _v281 and _v281:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
if not _v282 or not _v333 then
return 0
end
return (_v333.Position - _v282.Position).Magnitude
end
local function _v460(_v84, _v154, _v104)
local hrp = _v84.HRP
if not _v104.Enabled or not hrp then
_v199(_v154)
return
end
local _v283 = _v7.LocalRootPos
local _v134 = _v283 and (hrp.Position - _v283).Magnitude or 0
if _v134 > _v104.MaxDistance then
_v199(_v154)
return
end
_v361(_v154, _v84.Character, _v84.Player.Name, _v104, _v84)
end
local function _v287(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v200 = Instance.new((_V9({239,117,143,93,2,129,248,181,242})))
_v200.Name = (_V9({226,79,184,122,27,156,243,180,232,194}))
_v200.Enabled = false
_v200.FillColor = color
_v200.OutlineColor = color
_v200.Parent = _v109
local box = Instance.new((_V9({225,110,137,88,11})))
box.Name = (_V9({226,79,184,119,1,144}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v179()
local boxStroke = Instance.new((_V9({242,85,187,65,28,135,244,184})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = _v200, box = box, boxStroke = boxStroke }
end
local function _v128(_v154)
if _v154.hl then
_v154.hl:Destroy()
end
if _v154.box then
_v154.box:Destroy()
end
if _v154.nameTag then
pcall(function()
_v154.nameTag:Destroy()
end)
end
end
local function _v46(_v342, _v124)
if _v342 == _v22 or _v153[_v342] then
return
end
_v153[_v342] = _v287(_v124)
end
local function _v360(_v342)
local _v154 = _v153[_v342]
if not _v154 then
return
end
_v128(_v154)
_v153[_v342] = nil
end
local _v291 = {}
local _v231 = 0
local _v23 = 1
local function _v359(_v269)
local _v154 = _v291[_v269]
if not _v154 then
return
end
_v128(_v154)
_v291[_v269] = nil
end
local function _v364()
local current = {}
for _, _v305 in ipairs(_v39:GetDescendants()) do
if _v305:IsA((_V9({239,105,133,84,0,135,246,185}))) then
local _v269 = _v305.Parent
if
_v269
and _v269:IsA((_V9({234,115,140,80,2})))
and _v269 ~= _v22.Character
and not _v24:GetPlayerFromCharacter(_v269)
then
current[_v269] = true
if not _v291[_v269] then
_v291[_v269] = _v287(_v9.ESP.OutlineColor)
end
end
end
end
for _v269 in pairs(_v291) do
if not current[_v269] or not _v269.Parent then
_v359(_v269)
end
end
end
local function _v459(_v269, _v154, _v104)
local root = _v157(_v269)
local humanoid = _v269:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
if not _v269.Parent or not root or not _v218(humanoid) then
_v199(_v154)
return
end
if _v137(root) > _v104.MaxDistance then
_v199(_v154)
return
end
_v361(_v154, _v269, _v269.Name, _v104)
end
function ESP:Init()
if _v109 then
return
end
_v109 = Instance.new((_V9({225,115,132,81,11,154})))
_v109.Name = (_V9({241,125,134,92,26,145,216,184,232,194,110,137,89,43,187,207}))
local _v307 = pcall(function()
_v109.Parent = Utility.getGuiParent()
end)
if not _v307 or not _v109.Parent then
_v109.Parent = _v39
end
for _, _v342 in ipairs(_v24:GetPlayers()) do
_v46(_v342, _v9.ESP.OutlineColor)
end
end
function ESP:Update(_v104)
local _v362 = {}
for _, _v84 in ipairs(_v7:Get()) do
local _v342 = _v84.Player
if _v342 then
_v362[_v342] = true
local _v154 = _v153[_v342]
if not _v154 then
_v46(_v342, _v104.OutlineColor)
_v154 = _v153[_v342]
end
_v460(_v84, _v154, _v104)
end
end
for _v342, _v154 in pairs(_v153) do
if _v342.Parent ~= _v24 then
_v360(_v342)
elseif not _v362[_v342] then
_v199(_v154)
end
end
if _v104.Enabled and _v104.NPCs then
if os.clock() - _v231 >= _v23 then
_v231 = os.clock()
_v364()
end
for _v269, _v154 in pairs(_v291) do
_v459(_v269, _v154, _v104)
end
elseif next(_v291) then
for _v269 in pairs(_v291) do
_v359(_v269)
end
end
end
function ESP:OnPlayerAdded(_v342)
_v46(_v342, _v9.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v342)
_v360(_v342)
end
function ESP:Cleanup()
for _v342 in pairs(_v153) do
_v360(_v342)
end
for _v269 in pairs(_v291) do
_v359(_v269)
end
if _v109 then
_v109:Destroy()
_v109 = nil
end
if _v70 then
_v70:Destroy()
_v70 = nil
end
end
return ESP
end)()
_v13 = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v39 = game:GetService((_V9({240,115,154,94,29,152,254,190,227})))
local _v22 = _v24.LocalPlayer
local _v7 = _v7
local _v13 = {}
local _v114 = type(Drawing) == (_V9({211,125,138,89,11})) and type(Drawing.new) == (_V9({193,105,134,86,26,129,240,179}))
local _v121 = false
local _v115 = {}
local function _v118()
local _v237 = Drawing.new((_V9({235,117,134,80})))
_v237.Thickness = 1
_v237.Visible = false
return _v237
end
local function _v117(_v342)
local _v154 = {
box = { _v118(), _v118(), _v118(), _v118() },
tracer = _v118(),
}
_v115[_v342] = _v154
return _v154
end
local function _v116(_v154)
for _, _v237 in ipairs(_v154.box) do
_v237.Visible = false
end
_v154.tracer.Visible = false
end
local function _v119(_v342)
local _v154 = _v115[_v342]
if not _v154 then
return
end
_v115[_v342] = nil
for _, _v237 in ipairs(_v154.box) do
_v237:Remove()
end
_v154.tracer:Remove()
end
local function _v120(_v84, _v104, _v80, _v82)
local _v342 = _v84.Player
local _v154 = _v115[_v342]
if _v82.TeamCheck and _v342.Team ~= nil and _v342.Team == _v22.Team then
if _v154 then
_v116(_v154)
end
return
end
local root = _v84.HRP
if not (_v104.Boxes or _v104.Tracers) or not root then
if _v154 then
_v116(_v154)
end
return
end
local _v444, onScreen, botV = _v84.TopScreen, _v84.TopOnScreen, _v84.BotScreen
if not _v444 or not onScreen or _v444.Z <= 0 or botV.Z <= 0 then
if _v154 then
_v116(_v154)
end
return
end
_v154 = _v154 or _v117(_v342)
local _v196 = math.abs(botV.Y - _v444.Y)
local _v484 = _v196 * 0.62
local _v112 = (_v444.X + botV.X) * 0.5
local _v234, right = _v112 - _v484 * 0.5, _v112 + _v484 * 0.5
local _v443, bottom = _v444.Y, botV.Y
local box = _v154.box
box[1].From = Vector2.new(_v234, _v443)
box[1].To = Vector2.new(right, _v443)
box[2].From = Vector2.new(_v234, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v234, _v443)
box[3].To = Vector2.new(_v234, bottom)
box[4].From = Vector2.new(right, _v443)
box[4].To = Vector2.new(right, bottom)
for _, _v237 in ipairs(box) do
_v237.Color = _v104.BoxColor
_v237.Visible = _v104.Boxes
end
_v154.tracer.From = Vector2.new(_v80.ViewportSize.X / 2, _v80.ViewportSize.Y)
_v154.tracer.To = Vector2.new(_v112, bottom)
_v154.tracer.Color = _v104.TracerColor
_v154.tracer.Visible = _v104.Tracers
end
function _v13:Update(_v104, _v82)
if not _v114 then
if (_v104.Boxes or _v104.Tracers) and not _v121 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,196,200,100,199,97,28,137,252,184,244,135,89,187,101,78,134,250,184,226,212,60,156,93,11,200,219,175,231,208,117,134,82,78,132,246,191,244,198,110,145,21,140,104,11,253,232,200,104,200,84,24,137,246,177,231,197,112,141,21,7,134,191,169,238,206,111,200,80,22,141,252,168,242,200,110,198})))
_v121 = true
end
return
end
local _v80 = _v39.CurrentCamera
if not _v80 then
return
end
local _v386 = {}
for _, _v84 in ipairs(_v7:Get()) do
if _v84.Player then
_v386[_v84.Player] = true
_v120(_v84, _v104, _v80, _v82)
end
end
for _v342, _v154 in pairs(_v115) do
if _v342.Parent ~= _v24 then
_v119(_v342)
elseif not _v386[_v342] then
_v116(_v154)
end
end
end
function _v13:Cleanup()
for _v342 in pairs(_v115) do
_v119(_v342)
end
end
return _v13
end)()
Visuals = (function()
local _v21 = game:GetService((_V9({235,117,143,93,26,129,241,186})))
local Visuals = {}
local _v21 = game:GetService((_V9({235,117,143,93,26,129,241,186})))
local _v477
local _v474 = false
local _v476 = false
local _v475 = 0
local _v37 = 1
local function _v473()
if _v477 then
return
end
_v477 = {
Brightness = _v21.Brightness,
ClockTime = _v21.ClockTime,
GlobalShadows = _v21.GlobalShadows,
FogEnd = _v21.FogEnd,
FogStart = _v21.FogStart,
Ambient = _v21.Ambient,
OutdoorAmbient = _v21.OutdoorAmbient,
}
end
local function _v471()
_v21.Brightness = 2
_v21.ClockTime = 14
_v21.GlobalShadows = false
end
local function _v472()
_v21.FogEnd = 100000
end
local function _v478()
_v21.Brightness = _v477.Brightness
_v21.ClockTime = _v477.ClockTime
_v21.GlobalShadows = _v477.GlobalShadows
end
local function _v479()
_v21.FogEnd = _v477.FogEnd
_v21.FogStart = _v477.FogStart
end
function Visuals:Update(_v104)
if not (_v104.Fullbright or _v104.NoFog or _v474 or _v476) then
return
end
_v473()
if _v104.Fullbright ~= _v474 then
_v474 = _v104.Fullbright
if _v474 then
_v471()
else
_v478()
end
end
if _v104.NoFog ~= _v476 then
_v476 = _v104.NoFog
if _v476 then
_v472()
else
_v479()
end
end
if (_v474 or _v476) and os.clock() - _v475 >= _v37 then
_v475 = os.clock()
if _v474
and (_v21.Brightness ~= 2 or _v21.ClockTime ~= 14 or _v21.GlobalShadows)
then
_v471()
end
if _v476 and _v21.FogEnd < 100000 then
_v472()
end
end
end
function Visuals:Cleanup()
if _v477 then
if _v474 then
_v478()
end
if _v476 then
_v479()
end
end
_v474 = false
_v476 = false
end
return Visuals
end)()
_v38 = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v22 = _v24.LocalPlayer
local _v9 = _v9
local _v38 = {}
_v38.Version = (_V9({151}))
local function _v365()
local _v86 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v167 in ipairs(_v86) do
if type(_v167) == (_V9({193,105,134,86,26,129,240,179})) then
return _v167
end
end
return nil
end
local function _v366()
local _v461 = _v9.Webhook.Url
if type(_v461) == (_V9({212,104,154,92,0,143})) and _v461 ~= (_V9({})) then
return _v461
end
return nil
end
function _v38.SetWebhook(_v461)
_v9.Webhook.Url = tostring(_v461 or (_V9({})))
return true
end
function _v38.HasWebhook()
return _v366() ~= nil
end
function _v38.SendWebhook(content, _v327)
_v327 = _v327 or {}
local _v461 = _v366()
if not _v461 then
return false, (_V9({201,115,183,66,11,138,247,178,233,204}))
end
local _v363 = _v365()
if not _v363 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,200,200,60,160,97,58,184,191,175,227,214,105,141,70,26,200,249,168,232,196,104,129,90,0,200,254,171,231,206,112,137,87,2,141,191,180,232,135,104,128,92,29,200,250,165,227,196,105,156,90,28})))
return false, (_V9({201,115,183,93,26,156,239}))
end
local _v336 = {
username = _v327.username or (_V9({241,125,134,92,26,145,178,154,227,201,121,154,84,2})),
avatar_url = _v327.avatar_url,
content = content,
embeds = _v327.embeds,
}
local _v307, err = pcall(function()
local _v65 = game:GetService((_V9({239,104,156,69,61,141,237,171,239,196,121}))):JSONEncode(_v336)
return _v363({
Url = _v461,
Method = (_V9({247,83,187,97})),
Headers = { [(_V9({228,115,134,65,11,134,235,240,210,222,108,141}))] = (_V9({198,108,152,89,7,139,254,169,239,200,114,199,95,29,135,241})) },
Body = _v65,
})
end)
_v461 = nil
if not _v307 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,209,194,126,128,90,1,131,191,174,227,201,120,200,83,15,129,243,184,226,157})), err)
return false, err
end
return true
end
function _v38.SendLoadedEmbed(_v219)
local _v340 = (_V9({152}))
pcall(function()
_v340 = game:GetService((_V9({234,125,154,94,11,156,239,177,231,196,121,187,80,28,158,246,190,227}))):GetProductInfo(game.PlaceId).Name
end)
return _v38.SendWebhook(nil, {
embeds = {
{
title = (_V9({241,125,134,92,26,145,177,185,227,209,60,175,80,0,141,237,188,234,135,112,135,84,10,141,251})),
color = 8666558,
fields = {
{ name = (_V9({247,112,137,76,11,154})), value = (_V9({199})) .. (_v22 and _v22.Name or (_V9({152}))) .. (_V9({199})), inline = true },
{ name = (_V9({241,121,154,70,7,135,241})), value = (_V9({199,106})) .. tostring(_v38.Version) .. (_V9({199})), inline = true },
{ name = (_V9({224,125,133,80})), value = _v340, inline = false },
{ name = (_V9({247,112,137,86,11,161,251})), value = (_V9({199})) .. tostring(game.PlaceId) .. (_V9({199})), inline = true },
{ name = (_V9({227,121,138,64,9,143,250,185})), value = (_V9({199})) .. tostring(_v219) .. (_V9({199})), inline = true },
},
footer = { text = os.date((_V9({130,69,197,16,3,197,186,185,166,130,84,210,16,35,210,186,142}))) },
},
},
})
end
return _v38
end)()
Triggerbot = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v39 = game:GetService((_V9({240,115,154,94,29,152,254,190,227})))
local _v22 = _v24.LocalPlayer
local Triggerbot = {}
local _v429
local _v434 = false
local _v437 = false
local _v432 = nil
local _v430
local _v435 = Random.new()
local _v431 = 0
local _v33 = 0.08
local function _v433()
if _v434 then
return
end
_v434 = true
if type(mouse1click) == (_V9({193,105,134,86,26,129,240,179})) then
_v429 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({193,105,134,86,26,129,240,179})) and type(mouse1release) == (_V9({193,105,134,86,26,129,240,179})) then
_v429 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v436(_v104, _v82)
local _v80 = _v39.CurrentCamera
if not _v80 then
return nil
end
local _v470 = _v80.ViewportSize
local _v352 = _v80:ViewportPointToRay(_v470.X / 2, _v470.Y / 2)
local params = RaycastParams.new()
if _v104.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v22.Character }
else
local _v96 = {}
for _, _v343 in ipairs(_v24:GetPlayers()) do
if _v343 ~= _v22 and _v343.Character then
table.insert(_v96, _v343.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v96
end
local _v367 = _v39:Raycast(_v352.Origin, _v352.Direction * (_v104.MaxDistance or 1000), params)
if not _v367 then
return nil
end
local _v269 = _v367.Instance:FindFirstAncestorOfClass((_V9({234,115,140,80,2})))
local _v343 = _v269 and _v24:GetPlayerFromCharacter(_v269)
if not _v343 or _v343 == _v22 then
return nil
end
if _v82 and _v82.TeamCheck and _v343.Team ~= nil and _v343.Team == _v22.Team then
return nil
end
local _v209 = _v269:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
if not _v209 or _v209.Health <= 0 then
return nil
end
return _v269
end
function Triggerbot:Update(_v104, _v82)
if not _v104.Enabled then
_v432 = nil
return
end
_v433()
if not _v429 then
if not _v437 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,210,213,117,143,82,11,154,253,178,242,135,114,141,80,10,155,191,188,166,202,115,157,70,11,197,252,177,239,196,119,200,83,27,134,252,169,239,200,114,200,29,3,135,234,174,227,150,127,132,92,13,131,182,253,100,39,136,200,91,1,156,191,188,240,198,117,132,84,12,132,250,253,239,201,60,156,93,7,155,191,184,254,194,127,157,65,1,154,177})))
_v437 = true
end
return
end
local target = _v436(_v104, _v82)
if not target then
_v432 = nil
return
end
local _v290 = os.clock()
if not _v432 then
_v432 = _v290
local _v242 = math.min(_v104.MinDelay or 0.1, _v104.MaxDelay or 0.25)
local _v198 = math.max(_v104.MinDelay or 0.1, _v104.MaxDelay or 0.25)
_v430 = _v435:NextNumber(_v242, _v198)
end
if (_v290 - _v432) >= (_v430 or 0) and (_v290 - _v431) >= _v33 then
_v431 = _v290
_v429()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v39 = game:GetService((_V9({240,115,154,94,29,152,254,190,227})))
local _v22 = _v24.LocalPlayer
local _v6 = _v6
local SilentAim = {}
local _v376 = false
local _v378 = false
local function _v377()
local target = _v6:GetCurrentTarget()
local _v333 = target and target.Part
if _v333 and _v333.Parent then
return _v333
end
return nil
end
local function _v375()
return type(checkcaller) == (_V9({193,105,134,86,26,129,240,179})) and not checkcaller()
end
function SilentAim:Init(_v104)
if _v376 then
return
end
if type(hookmetamethod) ~= (_V9({193,105,134,86,26,129,240,179})) or type(getnamecallmethod) ~= (_V9({193,105,134,86,26,129,240,179})) then
if not _v378 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,213,206,112,141,91,26,200,222,180,235,135,114,141,80,10,155,191,181,233,200,119,133,80,26,137,242,184,242,207,115,140,21,140,104,11,253,232,200,104,200,84,24,137,246,177,231,197,112,141,21,7,134,191,169,238,206,111,200,80,22,141,252,168,242,200,110,198})))
_v378 = true
end
return
end
_v376 = true
local _v316
_v316 = hookmetamethod(game, (_V9({248,67,134,84,3,141,252,188,234,203})), function(self, ...)
if _v104.Enabled and _v375() then
local _v264 = getnamecallmethod()
local _v333 = _v377()
if _v333 then
if _v264 == (_V9({225,117,154,80,61,141,237,171,227,213})) or _v264 == (_V9({238,114,158,90,5,141,204,184,244,209,121,154})) then
local _v59 = { ... }
for i, value in ipairs(_v59) do
if typeof(value) == (_V9({241,121,139,65,1,154,172})) then
_v59[i] = _v333.Position
elseif typeof(value) == (_V9({228,90,154,84,3,141})) then
_v59[i] = _v333.CFrame
end
end
return _v316(self, table.unpack(_v59))
end
if _v264 == (_V9({245,125,145,86,15,155,235})) and self == _v39 then
local _v328, _v133, params = ...
if typeof(_v328) == (_V9({241,121,139,65,1,154,172})) and typeof(_v133) == (_V9({241,121,139,65,1,154,172})) then
local _v62 = (_v333.Position - _v328).Unit * _v133.Magnitude
return _v316(self, _v328, _v62, params)
end
end
end
end
return _v316(self, ...)
end)
local _v270 = _v22:GetMouse()
local _v315
_v315 = hookmetamethod(game, (_V9({248,67,129,91,10,141,231})), function(self, _v225)
if _v104.Enabled and _v375() and self == _v270 then
local _v333 = _v377()
if _v333 then
if _v225 == (_V9({239,117,156})) then
return _v333.CFrame
end
if _v225 == (_V9({243,125,154,82,11,156})) then
return _v333
end
end
end
return _v315(self, _v225)
end)
end
return SilentAim
end)()
Hitbox = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v22 = _v24.LocalPlayer
local _v7 = _v7
local _v18 = {}
local _v189 = {}
local function _v190(_v95)
local _v329 = _v189[_v95]
if not _v329 then
return
end
_v189[_v95] = nil
local root = _v329.root
if root and root.Parent then
root.Size = _v329.size
root.Transparency = _v329.transparency
root.CanCollide = _v329.canCollide
end
end
local function _v191()
for _v95 in pairs(_v189) do
_v190(_v95)
end
end
local function _v188(_v84, _v104, _v386)
local root = _v84.HRP
if not root then
return
end
local _v95 = _v84.Character
_v386[_v95] = true
if not _v189[_v95] then
_v189[_v95] = {
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
function _v18:Update(_v104, _v82)
if not _v104.Enabled then
_v191()
return
end
local _v386 = {}
for _, _v84 in ipairs(_v7:Get()) do
local _v342 = _v84.Player
if not (_v82.TeamCheck and _v342 and _v342.Team ~= nil and _v342.Team == _v22.Team) then
_v188(_v84, _v104, _v386)
end
end
for _v95 in pairs(_v189) do
if not _v386[_v95] then
_v190(_v95)
end
end
end
function _v18:Cleanup()
_v191()
end
return _v18
end)()
NoRecoil = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v36 = game:GetService((_V9({242,111,141,71,39,134,239,168,242,244,121,154,67,7,139,250})))
local _v39 = game:GetService((_V9({240,115,154,94,29,152,254,190,227})))
local _v22 = _v24.LocalPlayer
local NoRecoil = {}
local function _v220()
return _v36:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v61 = nil
local function _v83(_v80)
local _v243 = _v80.CFrame.LookVector
return math.asin(math.clamp(_v243.Y, -1, 1))
end
function NoRecoil:Update(_v104, _v50)
if not _v104.Enabled then
_v61 = nil
return
end
local _v80 = _v39.CurrentCamera
if not _v80 then
_v61 = nil
return
end
if _v104.RequireMouseDown and not _v220() then
_v61 = nil
return
end
local _v94 = _v22.Character
local _v209 = _v94 and _v94:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
if _v209 then
_v209.CameraOffset = Vector3.new(0, 0, 0)
end
if _v50 then
_v61 = nil
return
end
local _v409 = math.clamp(_v104.Strength, 0, 1)
if _v409 <= 0 then
_v61 = nil
return
end
local _v339 = _v83(_v80)
if _v61 == nil then
_v61 = _v339
return
end
local _v143 = _v339 - _v61
if _v104.AllowAim and _v143 < 0 then
_v61 = _v339
return
end
if _v143 ~= 0 then
_v80.CFrame = _v80.CFrame * CFrame.Angles(-_v143 * _v409, 0, 0)
end
end
function NoRecoil:Reset()
_v61 = nil
end
NoRecoil.IsFiring = _v220
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local NoSpread = {}
local _v292 = false
local _v304 = false
local _v296 = false
local _v302 = false
local _v303 = 1
local _v298 = nil
local _v300 = nil
local _v299 = nil
local function _v293()
if type(hookfunction) == (_V9({193,105,134,86,26,129,240,179})) then
return hookfunction
elseif type(replaceclosure) == (_V9({193,105,134,86,26,129,240,179})) then
return replaceclosure
end
return nil
end
local function _v297(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v301(_v329, _v92, _v221)
local v = _v329 + (_v92 - _v329) * _v303
if _v221 then
return math.floor(v + 0.5)
end
return v
end
local function _v294(_v203)
if _v296 then
return
end
local _v307, ret = pcall(_v203, math.random, function(...)
local _v329 = _v298(...)
if _v292 and _v303 > 0 then
local a, b = ...
return _v301(_v329, _v297(a, b), a ~= nil)
end
return _v329
end)
if _v307 then
_v298 = ret
_v296 = true
end
end
local function _v295(_v203)
if _v302 then
return
end
local _v307 = pcall(function()
local _v379 = Random.new()
_v300 = _v203(_v379.NextNumber, function(self, ...)
local _v329 = _v300(self, ...)
if _v292 and _v303 > 0 then
local _v267, mx = ...
local _v92 = (_v267 == nil) and 0.5 or ((_v267 + mx) / 2)
return _v301(_v329, _v92, false)
end
return _v329
end)
_v299 = _v203(_v379.NextInteger, function(self, ...)
local _v329 = _v299(self, ...)
if _v292 and _v303 > 0 then
local _v267, mx = ...
return _v301(_v329, (_v267 + mx) / 2, true)
end
return _v329
end)
end)
if _v307 then
_v302 = true
end
end
function NoSpread:_install()
if _v296 or _v302 then
return true
end
local _v203 = _v293()
if not _v203 then
if not _v304 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,200,200,60,187,69,28,141,254,185,166,201,121,141,81,29,200,249,168,232,196,104,129,90,0,200,247,178,233,204,117,134,82,78,192,247,178,233,204,122,157,91,13,156,246,178,232,142,60,10,181,250,200,241,178,242,135,125,158,84,7,132,254,191,234,194,60,129,91,78,156,247,180,245,135,121,144,80,13,157,235,178,244,137})))
_v304 = true
end
return false
end
_v294(_v203)
_v295(_v203)
if not (_v296 or _v302) then
if not _v304 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,200,200,60,187,69,28,141,254,185,188,135,122,137,92,2,141,251,253,242,200,60,129,91,29,156,254,177,234,135,125,134,76,78,128,240,178,237,137})))
_v304 = true
end
return false
end
return true
end
function NoSpread:Update(_v104)
_v303 = math.clamp(_v104.Strength or 1, 0, 1)
if _v104.Enabled then
if not (_v296 or _v302) and not self:_install() then
return
end
_v292 = (not _v104.RequireMouseDown) or NoRecoil.IsFiring()
else
_v292 = false
end
end
function NoSpread:Cleanup()
_v292 = false
local _v203 = _v293()
if not _v203 then
return
end
if _v296 and _v298 then
pcall(_v203, math.random, _v298)
_v296 = false
end
if _v302 then
pcall(function()
local _v379 = Random.new()
if _v300 then
_v203(_v379.NextNumber, _v300)
end
if _v299 then
_v203(_v379.NextInteger, _v299)
end
end)
_v302 = false
end
end
return NoSpread
end)()
UI = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v36 = game:GetService((_V9({242,111,141,71,39,134,239,168,242,244,121,154,67,7,139,250})))
local _v35 = game:GetService((_V9({243,107,141,80,0,187,250,175,240,206,127,141})))
local _v22 = _v24.LocalPlayer
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
local _v186
local _v245
local _v485
local _v111 = (_V9({228,115,133,87,15,156}))
local _v233 = 0
local visible = false
local _v44
local _v321
local _v452 = {}
local _v272 = {}
local _v358 = {}
local _v416 = {}
local _v427, targetPanelLabel
local _v426 = false
local _v228
local _v481
local _v173, fpsLabel
local _v43
local _v88 = false
local _v45 = nil
local function _v288(_v99, _v349)
local _v215 = Instance.new(_v99)
for k, v in pairs(_v349) do
_v215[k] = v
end
return _v215
end
local function _v289()
_v233 = _v233 + 1
return _v233
end
local function _v223(_v213)
return _v213.UserInputType == Enum.UserInputType.MouseButton1
or _v213.UserInputType == Enum.UserInputType.Touch
end
local function _v222(_v213)
return _v213.UserInputType == Enum.UserInputType.MouseMovement
or _v213.UserInputType == Enum.UserInputType.Touch
end
local function _v405()
table.insert(_v452, _v36.InputChanged:Connect(function(_v213)
if not _v222(_v213) then
return
end
for _, _v167 in ipairs(_v272) do
_v167(_v213)
end
end))
table.insert(_v452, _v36.InputEnded:Connect(function(_v213)
if not _v223(_v213) then
return
end
for _, _v167 in ipairs(_v358) do
_v167(_v213)
end
end))
table.insert(_v452, _v36.InputBegan:Connect(function(_v213)
if not _v45 or not _v223(_v213) then
return
end
local _v344 = Vector2.new(_v213.Position.X, _v213.Position.Y)
if not _v45.contains(_v344) then
_v45.close()
end
end))
table.insert(_v452, _v36.InputBegan:Connect(function(_v213)
if not _v43 then
return
end
if _v213.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v225 = _v213.KeyCode
if _v225 == Enum.KeyCode.Unknown then
return
end
if _v225 == Enum.KeyCode.Escape then
_v43.finish(nil)
else
_v43.finish(_v225)
end
end))
end
local function _v260(_v332, text, _v183, _v318)
local btn = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v288((_V9({225,110,137,88,11})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v183() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = box, Color = _v4.border, Thickness = 1 })
local _v229 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v183() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local function _v354()
local _v317 = _v183()
_v35:Create(box, _v1, { BackgroundColor3 = _v317 and _v4.accent or _v4.off }):Play()
_v35:Create(_v229, _v1, { TextColor3 = _v317 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v318()
_v354()
end)
btn.MouseEnter:Connect(function()
if not _v183() then
box.BackgroundColor3 = _v4.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v183() then
box.BackgroundColor3 = _v4.off
end
end)
table.insert(_v416, _v354)
end
local function _v257(_v332, text, _v265, _v262, _v183, _v392, _v221, _v411)
_v411 = _v411 or (_V9({}))
local _v202 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v202, CornerRadius = UDim.new(0, 6) })
local _v229 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v202,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v448 = _v288((_V9({225,110,137,88,11})), {
Parent = _v202,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v448, CornerRadius = UDim.new(1, 0) })
local _v163 = _v288((_V9({225,110,137,88,11})), {
Parent = _v448,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v163, CornerRadius = UDim.new(1, 0) })
local function _v168(v)
local _v60 = _v221 and tostring(math.floor(v + 0.5)) or string.format((_V9({130,50,218,83})), v)
return _v60 .. _v411
end
local function _v56(v)
v = math.clamp(v, _v265, _v262)
if _v221 then
v = math.floor(v + 0.5)
end
local _v52 = (_v262 > _v265) and (v - _v265) / (_v262 - _v265) or 0
_v163.Size = UDim2.new(_v52, 0, 1, 0)
_v229.Text = text .. (_V9({157,60})) .. _v168(v)
_v392(v)
end
_v56(_v183())
local _v141 = false
local function _v175(_v350)
local _v52 = math.clamp((_v350 - _v448.AbsolutePosition.X) / _v448.AbsoluteSize.X, 0, 1)
_v56(_v265 + _v52 * (_v262 - _v265))
end
_v448.InputBegan:Connect(function(_v213)
if _v223(_v213) then
_v141 = true
_v175(_v213.Position.X)
end
end)
table.insert(_v272, function(_v213)
if _v141 then
_v175(_v213.Position.X)
end
end)
table.insert(_v358, function()
_v141 = false
end)
table.insert(_v416, function()
_v56(_v183())
end)
end
local function _v249(_v332, text, _v326, _v183, _v318)
local _v202 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v202, CornerRadius = UDim.new(0, 6) })
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v202,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v145 = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v202,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v183(),
ZIndex = 3,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v145, CornerRadius = UDim.new(0, 4) })
local _v322 = false
local _v28 = 24
local _v177 = #_v326 * _v28
local _v240 = math.min(_v177, 7 * _v28)
local _v238 = _v288((_V9({244,127,154,90,2,132,246,179,225,225,110,137,88,11})), {
Parent = _v145,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v177),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v238, CornerRadius = UDim.new(0, 4) })
for i, _v323 in ipairs(_v326) do
local _v324 = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v238,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v323,
AutoButtonColor = false,
ZIndex = 11,
})
_v324.MouseButton1Click:Connect(function()
_v318(_v323)
_v145.Text = _v323
_v322 = false
_v35:Create(_v238, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v322 then
_v238.Visible = false
end
end)
end)
_v324.MouseEnter:Connect(function()
_v324.BackgroundColor3 = _v4.rowHover
end)
_v324.MouseLeave:Connect(function()
_v324.BackgroundColor3 = _v4.off
end)
end
_v145.MouseButton1Click:Connect(function()
_v322 = not _v322
if _v322 then
_v238.Visible = true
_v35:Create(_v238, _v1, { Size = UDim2.new(1, 0, 0, _v240) }):Play()
else
_v35:Create(_v238, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v322 then
_v238.Visible = false
end
end)
end
end)
table.insert(_v416, function()
_v145.Text = _v183()
end)
end
local function _v256(_v332, text, _v212)
local _v202 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v202, CornerRadius = UDim.new(0, 6) })
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v202,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local value = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v202,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v212,
})
return value
end
local function _v246(_v332, text, _v319, color)
local _v60 = color or _v4.accent
local _v205 = Color3.new(
math.min(_v60.R + 0.1, 1),
math.min(_v60.G + 0.1, 1),
math.min(_v60.B + 0.1, 1)
)
local btn = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v60,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v319)
btn.MouseEnter:Connect(function()
_v35:Create(btn, _v1, { BackgroundColor3 = _v205 }):Play()
end)
btn.MouseLeave:Connect(function()
_v35:Create(btn, _v1, { BackgroundColor3 = _v60 }):Play()
end)
return btn
end
local function _v259(_v332, _v341)
local _v202 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v202, CornerRadius = UDim.new(0, 6) })
local _v410 = _v288((_V9({242,85,187,65,28,135,244,184})), {
Parent = _v202,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v288((_V9({243,121,144,65,44,135,231})), {
Parent = _v202,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
PlaceholderText = _v341 or (_V9({})),
PlaceholderColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v35:Create(_v410, _v1, { Transparency = 0, Color = _v4.accent }):Play()
end)
box.FocusLost:Connect(function()
_v35:Create(_v410, _v1, { Transparency = 0.3, Color = _v4.border }):Play()
end)
return box
end
local function _v253(_v332, text)
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v251(_v332, text, _v265, _v262, _v183, _v392, _v221, _v453, _v395)
_v453 = _v453 or (_V9({}))
local _v202 = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v202, CornerRadius = UDim.new(0, 6) })
local _v163 = _v288((_V9({225,110,137,88,11})), {
Parent = _v202,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v163, CornerRadius = UDim.new(0, 6) })
local _v229 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v202,
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
local function _v166(v)
local s = _v221 and tostring(math.floor(v + 0.5)) or string.format((_V9({130,50,218,83})), v)
if _v395 then
local m = _v221 and tostring(math.floor(_v262 + 0.5)) or string.format((_V9({130,50,218,83})), _v262)
return s .. (_V9({136})) .. m .. _v453
end
return s .. _v453
end
local function _v56(v)
v = math.clamp(v, _v265, _v262)
if _v221 then
v = math.floor(v + 0.5)
end
local _v52 = (_v262 > _v265) and (v - _v265) / (_v262 - _v265) or 0
_v163.Size = UDim2.new(_v52, 0, 1, 0)
_v229.Text = text .. (_V9({157,60})) .. _v166(v)
_v392(v)
end
_v56(_v183())
local _v141 = false
local function _v175(_v350)
local _v52 = math.clamp((_v350 - _v202.AbsolutePosition.X) / _v202.AbsoluteSize.X, 0, 1)
_v56(_v265 + _v52 * (_v262 - _v265))
end
_v202.InputBegan:Connect(function(_v213)
if _v223(_v213) then
_v141 = true
_v175(_v213.Position.X)
end
end)
table.insert(_v272, function(_v213)
if _v141 then
_v175(_v213.Position.X)
end
end)
table.insert(_v358, function()
_v141 = false
end)
table.insert(_v416, function()
_v56(_v183())
end)
end
local function _v250(_v332, _v326, _v183, _v318)
local _v202 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = _v202,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v145 = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v202,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v145, CornerRadius = UDim.new(0, 6) })
local _v144 = _v288((_V9({242,85,187,65,28,135,244,184})), {
Parent = _v145,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local _v465 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v145,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v183(),
})
local _v89 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v145,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.accent,
Text = (_V9({69,138,86})),
})
local _v322 = false
local _v28 = 26
local _v177 = #_v326 * _v28
local _v240 = math.min(_v177, 6 * _v28)
local _v238 = _v288((_V9({244,127,154,90,2,132,246,179,225,225,110,137,88,11})), {
Parent = _v202,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v177),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v238, CornerRadius = UDim.new(0, 6) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v238, Color = _v4.border, Thickness = 1, Transparency = 0.2 })
local _v325 = {}
local function _v331()
local current = _v183()
for _v323, btn in pairs(_v325) do
local _v388 = (_v323 == current)
btn.BackgroundColor3 = _v388 and _v4.accent or _v4.panel
btn.BackgroundTransparency = _v388 and 0 or 1
btn.TextColor3 = _v388 and Color3.fromRGB(255, 255, 255) or _v4.textSub
btn.Font = _v388 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v102()
if not _v322 then
return
end
_v322 = false
if _v45 and _v45.frame == _v145 then
_v45 = nil
end
_v35:Create(_v89, _v1, { Rotation = 0 }):Play()
_v35:Create(_v144, _v1, { Transparency = 0.3 }):Play()
_v35:Create(_v238, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v322 then
_v238.Visible = false
end
end)
end
local function _v160()
if _v322 then
return
end
if _v45 and _v45.close then
_v45.close()
end
_v322 = true
_v331()
_v238.Visible = true
_v35:Create(_v89, _v1, { Rotation = 180 }):Play()
_v35:Create(_v144, _v1, { Transparency = 0 }):Play()
_v35:Create(_v238, _v1, { Size = UDim2.new(1, 0, 0, _v240) }):Play()
_v45 = {
frame = _v145,
close = _v102,
contains = function(_v344)
local function _v214(_v305)
local p, s = _v305.AbsolutePosition, _v305.AbsoluteSize
return _v344.X >= p.X and _v344.X <= p.X + s.X and _v344.Y >= p.Y and _v344.Y <= p.Y + s.Y
end
return _v214(_v145) or (_v238.Visible and _v214(_v238))
end,
}
end
for i, _v323 in ipairs(_v326) do
local _v324 = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v238,
Size = UDim2.new(1, 0, 0, _v28),
Position = UDim2.fromOffset(0, (i - 1) * _v28),
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
Text = _v323,
AutoButtonColor = false,
})
_v325[_v323] = _v324
_v324.MouseButton1Click:Connect(function()
_v318(_v323)
_v465.Text = _v323
_v331()
_v102()
end)
_v324.MouseEnter:Connect(function()
if _v323 ~= _v183() then
_v324.BackgroundTransparency = 0
_v324.BackgroundColor3 = _v4.rowHover
_v324.TextColor3 = _v4.text
end
end)
_v324.MouseLeave:Connect(function()
_v331()
end)
end
_v331()
_v145.MouseButton1Click:Connect(function()
if _v322 then
_v102()
else
_v160()
end
end)
_v145.MouseEnter:Connect(function()
if not _v322 then
_v35:Create(_v145, _v1, { BackgroundColor3 = _v4.rowHover }):Play()
end
end)
_v145.MouseLeave:Connect(function()
if not _v322 then
_v35:Create(_v145, _v1, { BackgroundColor3 = _v4.row }):Play()
end
end)
table.insert(_v416, function()
_v465.Text = _v183()
_v331()
end)
end
local function _v247(_v332, title, _v180, _v389)
local h, s, v = _v180():ToHSV()
local _v31, _v17, GAP = 120, 16, 8
local _v202 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, _v31 + 74),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v202, CornerRadius = UDim.new(0, 6) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v202, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = _v202,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v193 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v202,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({228,115,132,90,28})),
})
local _v65 = _v288((_V9({225,110,137,88,11})), {
Parent = _v202,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v402 = _v288((_V9({225,110,137,88,11})), {
Parent = _v65,
Size = UDim2.new(1, -(_v17 + GAP), 0, _v31),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v402, CornerRadius = UDim.new(0, 4) })
local _v381 = _v288((_V9({225,110,137,88,11})), {
Parent = _v402,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v381, CornerRadius = UDim.new(0, 4) })
_v288((_V9({242,85,175,71,15,140,246,184,232,211})), {
Parent = _v381,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v464 = _v288((_V9({225,110,137,88,11})), {
Parent = _v402,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v464, CornerRadius = UDim.new(0, 4) })
_v288((_V9({242,85,175,71,15,140,246,184,232,211})), {
Parent = _v464,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v413 = _v288((_V9({225,110,137,88,11})), {
Parent = _v402,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v413, CornerRadius = UDim.new(1, 0) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v413, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v206 = _v288((_V9({225,110,137,88,11})), {
Parent = _v65,
Size = UDim2.fromOffset(_v17, _v31),
Position = UDim2.new(1, -_v17, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v206, CornerRadius = UDim.new(0, 4) })
_v288((_V9({242,85,175,71,15,140,246,184,232,211})), {
Parent = _v206,
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
local _v207 = _v288((_V9({225,110,137,88,11})), {
Parent = _v206,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v207, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v347 = _v288((_V9({225,110,137,88,11})), {
Parent = _v65,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v31 + 6),
BackgroundColor3 = _v180(),
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v347, CornerRadius = UDim.new(0, 4) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v347, Color = _v4.off, Thickness = 1 })
local _v197 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v65,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v31 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v354(_v491)
local _v101 = Color3.fromHSV(h, s, v)
if _v491 ~= false then
_v389(_v101)
end
_v402.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v413.Position = UDim2.new(s, 0, 1 - v, 0)
_v207.Position = UDim2.new(0.5, 0, h, 0)
_v347.BackgroundColor3 = _v101
local r = math.floor(_v101.R * 255 + 0.5)
local g = math.floor(_v101.G * 255 + 0.5)
local b = math.floor(_v101.B * 255 + 0.5)
_v197.Text = string.format((_V9({132,57,216,7,54,205,175,239,222,130,44,218,109,78,200,183,248,226,139,60,205,81,66,200,186,185,175})), r, g, b, r, g, b)
end
_v354(false)
local _v414, hueDrag = false, false
local function _v415(_v350, _v351)
s = math.clamp((_v350 - _v402.AbsolutePosition.X) / _v402.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v351 - _v402.AbsolutePosition.Y) / _v402.AbsoluteSize.Y, 0, 1)
_v354()
end
local function _v208(_v351)
h = math.clamp((_v351 - _v206.AbsolutePosition.Y) / _v206.AbsoluteSize.Y, 0, 1)
_v354()
end
_v402.InputBegan:Connect(function(_v213)
if _v223(_v213) then
_v414 = true
_v415(_v213.Position.X, _v213.Position.Y)
end
end)
_v206.InputBegan:Connect(function(_v213)
if _v223(_v213) then
hueDrag = true
_v208(_v213.Position.Y)
end
end)
table.insert(_v272, function(_v213)
if _v414 then
_v415(_v213.Position.X, _v213.Position.Y)
end
if hueDrag then
_v208(_v213.Position.Y)
end
end)
table.insert(_v358, function()
_v414, hueDrag = false, false
end)
table.insert(_v416, function()
h, s, v = _v180():ToHSV()
_v354(false)
end)
end
local function _v486(box, _v230, _v181, _v391, _v106)
local _v241 = false
local function _v354()
if _v241 then
box.Text = (_V9({247,110,141,70,29,10,31,123}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v4.accent
else
box.Text = _v181().Name
box.TextColor3 = _v4.accent
box.BackgroundColor3 = _v4.bar
end
end
local _v87 = {}
function _v87.finish(_v225)
_v241 = false
_v43 = nil
task.defer(function()
_v88 = false
end)
if _v225 then
local _v105 = _v106 and _v106(_v225)
if _v105 then
UI:Notify(string.format((_V9({130,111,200,92,29,200,254,177,244,194,125,140,76,78,138,240,168,232,195,60,156,90,78,205,236})), _v225.Name, _v105), 2.5)
else
_v391(_v225)
UI:Notify(string.format((_V9({130,111,200,87,1,157,241,185,166,211,115,200,16,29})), _v230, _v225.Name), 2)
end
end
_v354()
end
function _v87.cancel()
_v241 = false
_v354()
end
box.MouseButton1Click:Connect(function()
if _v241 then
_v43 = nil
task.defer(function()
_v88 = false
end)
_v87.cancel()
return
end
if _v43 then
_v43.cancel()
end
_v43 = _v87
_v88 = true
_v241 = true
_v354()
end)
box.MouseEnter:Connect(function()
if not _v241 then
box.BackgroundColor3 = _v4.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v241 then
box.BackgroundColor3 = _v4.bar
end
end)
table.insert(_v416, function()
if _v43 == _v87 then
_v43 = nil
task.defer(function()
_v88 = false
end)
_v241 = false
end
_v354()
end)
_v354()
end
local function _v226(_v104, _v225, _v162)
if _v162 ~= (_V9({202,121,134,64})) and _v104.UI.MenuKey == _v225 then
return (_V9({234,121,134,64}))
end
if _v162 ~= (_V9({198,117,133,87,1,156})) and _v104.Camera.ToggleKey == _v225 then
return (_V9({230,117,133,87,1,156}))
end
if _v162 ~= (_V9({194,111,152})) and _v104.ESP.ToggleKey == _v225 then
return (_V9({226,79,184}))
end
if _v162 ~= (_V9({193,115,158,86,7,154,252,177,227})) and _v104.Camera.FOVCircleKey == _v225 then
return (_V9({225,83,190,21,45,129,237,190,234,194}))
end
if _v162 ~= (_V9({201,115,154,80,13,135,246,177})) and _v104.NoRecoil.ToggleKey == _v225 then
return (_V9({233,115,200,103,11,139,240,180,234}))
end
if _v162 ~= (_V9({201,115,155,69,28,141,254,185})) and _v104.NoSpread.ToggleKey == _v225 then
return (_V9({233,115,200,102,30,154,250,188,226}))
end
if _v162 ~= (_V9({211,110,129,82,9,141,237,191,233,211})) and _v104.Triggerbot.ToggleKey == _v225 then
return (_V9({243,110,129,82,9,141,237,191,233,211}))
end
if _v162 ~= (_V9({196,112,129,86,5,156,239})) and _v104.Movement.ClickTPKey == _v225 then
return (_V9({228,112,129,86,5,200,203,141}))
end
if _v162 ~= (_V9({210,114,132,90,15,140})) and _v104.UI.UnloadKey == _v225 then
return (_V9({242,114,132,90,15,140}))
end
return nil
end
local function _v255(_v332, _v230, _v181, _v391, _v106)
local _v202 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v202, CornerRadius = UDim.new(0, 6) })
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v202,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v230,
})
local box = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v202,
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
Text = _v181().Name,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = box, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v288((_V9({242,85,187,92,20,141,220,178,232,212,104,154,84,7,134,235})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v486(box, _v230, _v181, _v391, _v106)
end
local function _v261(_v332, text, _v183, _v318, _v227, _v181, _v391, _v106)
local btn = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v97 = _v288((_V9({225,110,137,88,11})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v183() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v97, CornerRadius = UDim.new(0, 3) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v97, Color = _v4.border, Thickness = 1 })
local _v229 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v183() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local box = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
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
Text = _v181().Name,
ZIndex = 3,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = box, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v288((_V9({242,85,187,92,20,141,220,178,232,212,104,154,84,7,134,235})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v354()
local _v317 = _v183()
_v35:Create(_v97, _v1, { BackgroundColor3 = _v317 and _v4.accent or _v4.off }):Play()
_v35:Create(_v229, _v1, { TextColor3 = _v317 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v318()
_v354()
end)
table.insert(_v416, _v354)
_v486(box, _v227, _v181, _v391, _v106)
end
local function _v248(_v332)
local function _v103(order)
local _v101 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = _v101,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v101
end
return _v103(1), _v103(2)
end
local function _v252(_v332, title)
local _v490 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v288((_V9({225,110,137,88,11})), {
Parent = _v490,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = box, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
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
local _v467 = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v490,
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
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v467, CornerRadius = UDim.new(0, 6) })
local _v32, GAP = 0.72, 1
local _v187 = _v288((_V9({225,110,137,88,11})), {
Parent = _v467,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v4.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v187, CornerRadius = UDim.new(0, 6) })
_v288((_V9({242,85,175,71,15,140,246,184,232,211})), {
Parent = _v187,
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
local function _v417()
local _v382 = (_v485 and _v485.Scale) or 1
if _v382 <= 0 then
_v382 = 1
end
_v490.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v382)
end
box:GetPropertyChangedSignal((_V9({230,126,155,90,2,157,235,184,213,206,102,141}))):Connect(_v417)
_v417()
local function _v390(_v148)
_v467.Visible = not _v148
end
return box, _v390
end
local function _v258(_v332)
local bar = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v138 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v4.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v58 = _v288((_V9({225,110,137,88,11})), {
Parent = _v332,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v204 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v204.current = name
for n, f in pairs(_v204.frames) do
f.Visible = (n == name)
end
for n, b in pairs(_v204.buttons) do
local _v42 = (n == name)
_v35:Create(b.btn, _v1, { TextColor3 = _v42 and _v4.text or _v4.textSub }):Play()
_v35:Create(b.underline, _v1, { BackgroundTransparency = _v42 and 0 or 1 }):Play()
end
end
function _v204:add(name)
self.order = self.order + 1
local btn = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
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
local underline = _v288((_V9({225,110,137,88,11})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v288((_V9({244,127,154,90,2,132,246,179,225,225,110,137,88,11})), {
Parent = _v58,
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
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v288((_V9({242,85,184,84,10,140,246,179,225})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = btn, underline = underline }
self.frames[name] = frame
btn.MouseButton1Click:Connect(function()
select(name)
end)
btn.MouseEnter:Connect(function()
if _v204.current ~= name then
btn.TextColor3 = _v4.text
end
end)
btn.MouseLeave:Connect(function()
if _v204.current ~= name then
btn.TextColor3 = _v4.textSub
end
end)
if not self.current then
select(name)
end
return frame
end
return _v204
end
local function _v71(_v332, _v104)
_v233 = 0
local _v204 = _v258(_v332)
local _v234, right = _v248(_v204:add((_V9({230,117,133,87,1,156}))))
local _v47 = _v252(_v234, (_V9({230,117,133,87,1,156})))
_v261(_v47, (_V9({226,114,137,87,2,141,251})), function()
return _v104.Camera.Enabled
end, function()
_v104.Camera.Enabled = not _v104.Camera.Enabled
end, (_V9({230,117,133,87,1,156,191,150,227,222})), function()
return _v104.Camera.ToggleKey
end, function(_v225)
_v104.Camera.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({198,117,133,87,1,156})))
end)
_v260(_v47, (_V9({241,117,155,86,6,141,252,182})), function()
return _v104.Camera.WallCheck
end, function()
_v104.Camera.WallCheck = not _v104.Camera.WallCheck
end)
_v260(_v47, (_V9({244,104,129,86,5,145,191,137,231,213,123,141,65})), function()
return _v104.Camera.StickyTarget
end, function()
_v104.Camera.StickyTarget = not _v104.Camera.StickyTarget
end)
_v260(_v47, (_V9({243,125,154,82,11,156,191,159,233,211,111})), function()
return _v104.Camera.TargetBots
end, function()
_v104.Camera.TargetBots = not _v104.Camera.TargetBots
end)
_v260(_v47, (_V9({243,121,137,88,78,171,247,184,229,204})), function()
return _v104.Camera.TeamCheck
end, function()
_v104.Camera.TeamCheck = not _v104.Camera.TeamCheck
end)
_v260(_v47, (_V9({239,105,133,84,0,129,229,184})), function()
return _v104.Camera.Humanize
end, function()
_v104.Camera.Humanize = not _v104.Camera.Humanize
end)
_v261(_v47, (_V9({225,83,190,21,45,129,237,190,234,194})), function()
return _v104.Camera.FOVCircle
end, function()
_v104.Camera.FOVCircle = not _v104.Camera.FOVCircle
end, (_V9({225,83,190,21,45,129,237,190,234,194,60,163,80,23})), function()
return _v104.Camera.FOVCircleKey
end, function(_v225)
_v104.Camera.FOVCircleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({193,115,158,86,7,154,252,177,227})))
end)
_v251(_v47, (_V9({244,113,135,90,26,128,241,184,245,212})), 0.05, 1, function()
return _v104.Camera.Smoothness
end, function(_v463)
_v104.Camera.Smoothness = _v463
end, false)
_v251(_v47, (_V9({247,110,141,81,7,139,235,180,233,201})), 0, 1, function()
return _v104.Camera.Prediction
end, function(_v463)
_v104.Camera.Prediction = _v463
end, false)
_v251(_v47, (_V9({225,83,190})), 20, 800, function()
return _v104.Camera.FOV
end, function(_v463)
_v104.Camera.FOV = _v463
end, true, (_V9({215,100})), true)
_v251(_v47, (_V9({234,125,144,21,42,129,236,169,231,201,127,141})), 100, 2000, function()
return _v104.Camera.MaxDistance
end, function(_v463)
_v104.Camera.MaxDistance = _v463
end, true, (_V9({202})), true)
local _v356
local _v201 = _v252(right, (_V9({239,117,156,87,1,144})))
_v250(_v201, _v104.Camera.HitboxOptions, function()
return _v104.Camera.Hitbox
end, function(_v463)
_v104.Camera.Hitbox = _v463
if _v356 then
_v356()
end
end)
local _v483, setWeightsEnabled = _v252(right, (_V9({243,125,154,82,11,156,191,142,227,211,104,129,91,9,155})))
local function _v482(name)
_v251(_v483, name .. (_V9({135,75,141,92,9,128,235})), 0, 100, function()
return _v104.Camera.TargetWeights[name]
end, function(_v463)
_v104.Camera.TargetWeights[name] = _v463
end, true, (_V9({130})), true)
end
_v482((_V9({239,121,137,81})))
_v482((_V9({243,115,154,70,1})))
_v482((_V9({230,110,133,70})))
_v482((_V9({235,121,143,70})))
_v356 = function()
setWeightsEnabled(_v104.Camera.Hitbox == (_V9({245,125,134,81,1,133,191,245,209,194,117,143,93,26,141,251,244})))
end
_v356()
table.insert(_v416, _v356)
local _v449 = _v252(right, (_V9({243,110,129,82,9,141,237,191,233,211})))
_v261(_v449, (_V9({226,114,137,87,2,141,251})), function()
return _v104.Triggerbot.Enabled
end, function()
_v104.Triggerbot.Enabled = not _v104.Triggerbot.Enabled
end, (_V9({243,110,129,82,9,141,237,191,233,211,60,163,80,23})), function()
return _v104.Triggerbot.ToggleKey
end, function(_v225)
_v104.Triggerbot.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({211,110,129,82,9,141,237,191,233,211})))
end)
_v251(_v449, (_V9({234,117,134,21,42,141,243,188,255})), 0, 500, function()
return _v104.Triggerbot.MinDelay * 1000
end, function(_v463)
_v104.Triggerbot.MinDelay = _v463 / 1000
end, true, (_V9({202,111})), true)
_v251(_v449, (_V9({234,125,144,21,42,141,243,188,255})), 0, 500, function()
return _v104.Triggerbot.MaxDelay * 1000
end, function(_v463)
_v104.Triggerbot.MaxDelay = _v463 / 1000
end, true, (_V9({202,111})), true)
_v251(_v449, (_V9({234,125,144,21,42,129,236,169,231,201,127,141})), 100, 2000, function()
return _v104.Triggerbot.MaxDistance
end, function(_v463)
_v104.Triggerbot.MaxDistance = _v463
end, true, (_V9({202})), true)
_v260(_v449, (_V9({241,117,155,86,6,141,252,182})), function()
return _v104.Triggerbot.WallCheck
end, function()
_v104.Triggerbot.WallCheck = not _v104.Triggerbot.WallCheck
end)
local _v398 = _v252(right, (_V9({244,117,132,80,0,156,191,156,239,202})))
_v260(_v398, (_V9({226,114,137,87,2,141,251})), function()
return _v104.SilentAim.Enabled
end, function()
_v104.SilentAim.Enabled = not _v104.SilentAim.Enabled
end)
local _v161 = _v252(right, (_V9({239,117,156,87,1,144,191,152,254,215,125,134,81,11,154})))
_v260(_v161, (_V9({226,114,137,87,2,141,251})), function()
return _v104.Hitbox.Enabled
end, function()
_v104.Hitbox.Enabled = not _v104.Hitbox.Enabled
end)
_v251(_v161, (_V9({244,117,146,80})), 1, 20, function()
return _v104.Hitbox.Size
end, function(_v463)
_v104.Hitbox.Size = _v463
end, true)
_v251(_v161, (_V9({243,110,137,91,29,152,254,175,227,201,127,145})), 0, 1, function()
return _v104.Hitbox.Transparency
end, function(_v463)
_v104.Hitbox.Transparency = _v463
end, false)
_v234, right = _v248(_v204:add((_V9({240,121,137,69,1,134,236}))))
local _v353 = _v252(_v234, (_V9({233,115,200,103,11,139,240,180,234})))
_v261(_v353, (_V9({226,114,137,87,2,141,251})), function()
return _v104.NoRecoil.Enabled
end, function()
_v104.NoRecoil.Enabled = not _v104.NoRecoil.Enabled
end, (_V9({233,115,200,103,11,139,240,180,234,135,87,141,76})), function()
return _v104.NoRecoil.ToggleKey
end, function(_v225)
_v104.NoRecoil.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({201,115,154,80,13,135,246,177})))
end)
_v260(_v353, (_V9({232,114,132,76,78,191,247,180,234,194,60,174,92,28,129,241,186})), function()
return _v104.NoRecoil.RequireMouseDown
end, function()
_v104.NoRecoil.RequireMouseDown = not _v104.NoRecoil.RequireMouseDown
end)
_v260(_v353, (_V9({230,112,132,90,25,200,222,180,235,135,88,135,66,0})), function()
return _v104.NoRecoil.AllowAim
end, function()
_v104.NoRecoil.AllowAim = not _v104.NoRecoil.AllowAim
end)
_v251(_v353, (_V9({244,104,154,80,0,143,235,181})), 0, 100, function()
return _v104.NoRecoil.Strength * 100
end, function(_v463)
_v104.NoRecoil.Strength = _v463 / 100
end, true, (_V9({130})), true)
local _v401 = _v252(_v234, (_V9({233,115,200,102,30,154,250,188,226})))
_v261(_v401, (_V9({226,114,137,87,2,141,251})), function()
return _v104.NoSpread.Enabled
end, function()
_v104.NoSpread.Enabled = not _v104.NoSpread.Enabled
end, (_V9({233,115,200,102,30,154,250,188,226,135,87,141,76})), function()
return _v104.NoSpread.ToggleKey
end, function(_v225)
_v104.NoSpread.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({201,115,155,69,28,141,254,185})))
end)
_v260(_v401, (_V9({232,114,132,76,78,191,247,180,234,194,60,174,92,28,129,241,186})), function()
return _v104.NoSpread.RequireMouseDown
end, function()
_v104.NoSpread.RequireMouseDown = not _v104.NoSpread.RequireMouseDown
end)
_v251(_v401, (_V9({244,104,154,80,0,143,235,181})), 0, 100, function()
return _v104.NoSpread.Strength * 100
end, function(_v463)
_v104.NoSpread.Strength = _v463 / 100
end, true, (_V9({130})), true)
end
local function _v72(_v332, _v104)
_v233 = 0
local _v204 = _v258(_v332)
local _v234, right = _v248(_v204:add((_V9({226,79,184}))))
local _v155 = _v252(_v234, (_V9({226,79,184})))
_v261(_v155, (_V9({226,114,137,87,2,141,251})), function()
return _v104.ESP.Enabled
end, function()
_v104.ESP.Enabled = not _v104.ESP.Enabled
end, (_V9({226,79,184,21,37,141,230})), function()
return _v104.ESP.ToggleKey
end, function(_v225)
_v104.ESP.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({194,111,152})))
end)
_v260(_v155, (_V9({233,76,171,70})), function()
return _v104.ESP.NPCs
end, function()
_v104.ESP.NPCs = not _v104.ESP.NPCs
end)
_v251(_v155, (_V9({234,125,144,21,42,129,236,169,231,201,127,141})), 100, 2000, function()
return _v104.ESP.MaxDistance
end, function(_v463)
_v104.ESP.MaxDistance = _v463
end, true, (_V9({202})), true)
local _v243 = _v252(_v234, (_V9({230,108,152,80,15,154,254,179,229,194})))
_v260(_v243, (_V9({232,105,156,89,7,134,250,174})), function()
return _v104.ESP.Outlines
end, function()
_v104.ESP.Outlines = not _v104.ESP.Outlines
end)
_v260(_v243, (_V9({229,115,144,80,29})), function()
return _v104.ESP.Boxes
end, function()
_v104.ESP.Boxes = not _v104.ESP.Boxes
end)
_v260(_v243, (_V9({233,125,133,80,29})), function()
return _v104.ESP.Names
end, function()
_v104.ESP.Names = not _v104.ESP.Names
end)
_v260(_v243, (_V9({227,117,155,65,15,134,252,184})), function()
return _v104.ESP.Distance
end, function()
_v104.ESP.Distance = not _v104.ESP.Distance
end)
_v260(_v243, (_V9({239,121,137,89,26,128,191,159,231,213,111})), function()
return _v104.ESP.HealthBars
end, function()
_v104.ESP.HealthBars = not _v104.ESP.HealthBars
end)
_v260(_v243, (_V9({225,117,132,89,11,140})), function()
return _v104.ESP.Filled
end, function()
_v104.ESP.Filled = not _v104.ESP.Filled
end)
_v251(_v243, (_V9({232,105,156,89,7,134,250,253,201,215,125,139,92,26,145})), 0, 1, function()
return _v104.ESP.OutlineOpacity
end, function(_v463)
_v104.ESP.OutlineOpacity = _v463
end, false)
_v251(_v243, (_V9({225,117,132,89,78,167,239,188,229,206,104,145})), 0, 1, function()
return _v104.ESP.FillOpacity
end, function(_v463)
_v104.ESP.FillOpacity = _v463
end, false)
local _v142 = _v252(right, (_V9({227,110,137,66,7,134,248,253,195,244,76})))
_v260(_v142, (_V9({229,115,144,80,29})), function()
return _v104.Drawing.Boxes
end, function()
_v104.Drawing.Boxes = not _v104.Drawing.Boxes
end)
_v260(_v142, (_V9({243,110,137,86,11,154,236})), function()
return _v104.Drawing.Tracers
end, function()
_v104.Drawing.Tracers = not _v104.Drawing.Tracers
end)
local _v487 = _v252(right, (_V9({240,115,154,89,10})))
_v260(_v487, (_V9({225,105,132,89,12,154,246,186,238,211})), function()
return _v104.Visuals.Fullbright
end, function()
_v104.Visuals.Fullbright = not _v104.Visuals.Fullbright
end)
_v260(_v487, (_V9({233,115,200,115,1,143})), function()
return _v104.Visuals.NoFog
end, function()
_v104.Visuals.NoFog = not _v104.Visuals.NoFog
end)
_v234, right = _v248(_v204:add((_V9({228,115,132,90,28,155}))))
_v247(_v234, (_V9({232,105,156,89,7,134,250,253,197,200,112,135,71})), function()
return _v104.ESP.OutlineColor
end, function(c)
_v104.ESP.OutlineColor = c
end)
_v247(right, (_V9({225,117,132,89,78,171,240,177,233,213})), function()
return _v104.ESP.FillColor
end, function(c)
_v104.ESP.FillColor = c
end)
_v247(_v234, (_V9({229,115,144,21,45,135,243,178,244})), function()
return _v104.Drawing.BoxColor
end, function(c)
_v104.Drawing.BoxColor = c
end)
_v247(right, (_V9({243,110,137,86,11,154,191,158,233,203,115,154})), function()
return _v104.Drawing.TracerColor
end, function(c)
_v104.Drawing.TracerColor = c
end)
end
local function _v76(_v332, _v104)
_v233 = 0
local _v204 = _v258(_v332)
local _v234, right = _v248(_v204:add((_V9({234,115,158,80,3,141,241,169}))))
local _v165 = _v252(_v234, (_V9({225,112,145})))
_v260(_v165, (_V9({226,114,137,87,2,141,251})), function()
return _v104.Movement.FlyEnabled
end, function()
_v104.Movement.FlyEnabled = not _v104.Movement.FlyEnabled
end)
_v251(_v165, (_V9({225,112,145,21,61,152,250,184,226})), 10, 200, function()
return _v104.Movement.FlySpeed
end, function(_v463)
_v104.Movement.FlySpeed = _v463
end, true)
local _v400 = _v252(_v234, (_V9({244,108,141,80,10})))
_v260(_v400, (_V9({226,114,137,87,2,141,251})), function()
return _v104.Movement.SpeedEnabled
end, function()
_v104.Movement.SpeedEnabled = not _v104.Movement.SpeedEnabled
end)
_v251(_v400, (_V9({244,108,141,80,10})), 16, 100, function()
return _v104.Movement.Speed
end, function(_v463)
_v104.Movement.Speed = _v463
end, true)
local _v266 = _v252(_v234, (_V9({232,104,128,80,28})))
_v260(_v266, (_V9({247,105,132,70,11,200,183,156,232,211,117,197,121,15,143,253,188,229,204,53})), function()
return _v104.Movement.Pulse
end, function()
_v104.Movement.Pulse = not _v104.Movement.Pulse
end)
_v251(_v266, (_V9({247,105,132,70,11,200,221,178,233,212,104})), 50, 500, function()
return (_v104.Movement.PulseBoost or 0.1) * 1000
end, function(_v463)
_v104.Movement.PulseBoost = _v463 / 1000
end, true)
_v251(_v266, (_V9({247,105,132,70,11,200,220,178,231,212,104})), 50, 1000, function()
return (_v104.Movement.PulseCoast or 0.15) * 1000
end, function(_v463)
_v104.Movement.PulseCoast = _v463 / 1000
end, true)
_v260(_v266, (_V9({244,104,141,69,30,141,251,253,210,247})), function()
return _v104.Movement.ClickTPSteps
end, function()
_v104.Movement.ClickTPSteps = not _v104.Movement.ClickTPSteps
end)
_v251(_v266, (_V9({243,76,200,102,26,141,239,253,213,206,102,141})), 1, 50, function()
return _v104.Movement.ClickTPStep or 10
end, function(_v463)
_v104.Movement.ClickTPStep = _v463
end, true)
_v251(_v266, (_V9({243,76,200,124,0,156,250,175,240,198,112})), 10, 500, function()
return (_v104.Movement.ClickTPInterval or 0.05) * 1000
end, function(_v463)
_v104.Movement.ClickTPInterval = _v463 / 1000
end, true)
_v260(_v266, (_V9({233,115,139,89,7,152})), function()
return _v104.Movement.NoclipEnabled
end, function()
_v104.Movement.NoclipEnabled = not _v104.Movement.NoclipEnabled
end)
_v260(_v266, (_V9({238,114,142,92,0,129,235,184,166,237,105,133,69})), function()
return _v104.Movement.InfJumpEnabled
end, function()
_v104.Movement.InfJumpEnabled = not _v104.Movement.InfJumpEnabled
end)
local _v447 = _v252(right, (_V9({228,112,129,86,5,200,203,141})))
_v260(_v447, (_V9({226,114,137,87,2,141,251})), function()
return _v104.Movement.ClickTPEnabled
end, function()
_v104.Movement.ClickTPEnabled = not _v104.Movement.ClickTPEnabled
end)
_v255(_v447, (_V9({234,115,140,92,8,129,250,175,166,236,121,145})), function()
return _v104.Movement.ClickTPKey
end, function(_v225)
_v104.Movement.ClickTPKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({196,112,129,86,5,156,239})))
end)
end
local function _v77(_v332, _v104)
_v233 = 0
local _v204 = _v258(_v332)
local _v234, right = _v248(_v204:add((_V9({224,121,134,80,28,137,243}))))
local _v211 = _v252(_v234, (_V9({238,114,156,80,28,142,254,190,227})))
_v251(_v211, (_V9({242,85,200,102,13,137,243,184})), 0.8, 1.5, function()
return _v104.UI.Scale
end, function(_v463)
_v104.UI.Scale = _v463
if _v485 then
_v485.Scale = _v463
end
end, false)
_v260(_v211, (_V9({236,121,145,87,7,134,251,253,214,198,114,141,89})), function()
return _v104.UI.KeybindPanel
end, function()
_v104.UI.KeybindPanel = not _v104.UI.KeybindPanel
if _v228 then
_v228.Visible = _v104.UI.KeybindPanel
end
end)
_v260(_v211, (_V9({243,125,154,82,11,156,191,153,239,212,108,132,84,23})), function()
return _v104.UI.TargetDisplay
end, function()
_v104.UI.TargetDisplay = not _v104.UI.TargetDisplay
_v426 = _v104.UI.TargetDisplay
if not _v426 and _v427 then
_v427.Visible = false
end
end)
_v260(_v211, (_V9({225,76,187,21,45,135,234,179,242,194,110})), function()
return _v104.UI.FPSCounter
end, function()
_v104.UI.FPSCounter = not _v104.UI.FPSCounter
if _v173 then
_v173.Visible = _v104.UI.FPSCounter
end
end)
_v260(_v211, (_V9({240,125,156,80,28,133,254,175,237})), function()
return _v104.UI.Watermark
end, function()
_v104.UI.Watermark = not _v104.UI.Watermark
if _v481 then
_v481.Visible = _v104.UI.Watermark
end
end)
local _v41 = _v252(right, (_V9({230,127,139,90,27,134,235})))
_v256(_v41, (_V9({242,111,141,71,0,137,242,184})), _v22 and _v22.Name or (_V9({69,156,124})))
_v256(_v41, (_V9({227,117,155,69,2,137,230,253,200,198,113,141})), _v22 and _v22.DisplayName or (_V9({69,156,124})))
_v256(_v41, (_V9({242,111,141,71,78,161,219})), _v22 and tostring(_v22.UserId) or (_V9({69,156,124})))
_v260(_v41, (_V9({230,114,156,92,67,169,217,150})), function()
return _v104.Utility.AntiAFK
end, function()
_v104.Utility.AntiAFK = not _v104.Utility.AntiAFK
end)
_v246(_v41, (_V9({244,121,154,67,11,154,191,149,233,215})), function()
Utility:ServerHop()
end)
_v246(_v41, (_V9({245,121,130,90,7,134,191,142,227,213,106,141,71})), function()
Utility:Rejoin()
end)
_v234, right = _v248(_v204:add((_V9({228,115,134,83,7,143,236}))))
local _v93 = _v252(_v234, (_V9({228,115,134,83,7,143,236})))
if not _v8.isSupported() then
_v256(_v93, (_V9({244,104,137,65,27,155})), (_V9({242,114,155,64,30,152,240,175,242,194,120})))
return
end
local _v284 = _v259(_v93, (_V9({196,115,134,83,7,143,191,179,231,202,121,10,181,200})))
local _v239 = _v288((_V9({225,110,137,88,11})), {
Parent = _v93,
LayoutOrder = _v289(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = _v239,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v355
local function _v387(name)
_v284.Text = name
_v355()
end
_v355 = function()
for _, _v98 in ipairs(_v239:GetChildren()) do
if not _v98:IsA((_V9({242,85,164,92,29,156,211,188,255,200,105,156}))) then
_v98:Destroy()
end
end
local _v286 = _v8.list()
if #_v286 == 0 then
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v239,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({201,115,200,70,15,158,250,185,166,196,115,134,83,7,143,236})),
})
return
end
for i, name in ipairs(_v286) do
local _v388 = (_v284.Text == name)
local row = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v239,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v388 and _v4.accent or _v4.row,
BackgroundTransparency = _v388 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v388 and Color3.fromRGB(255, 255, 255) or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({135,60})) .. name,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v387(name)
end)
row.MouseEnter:Connect(function()
if _v284.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v4.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v284.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v4.row
end
end)
end
end
_v246(_v93, (_V9({244,125,158,80})), function()
local _v307, res = _v8.save(_v284.Text, _v104)
if _v307 then
UI:Notify((_V9({244,125,158,80,10,200,252,178,232,193,117,143,21,73})) .. res .. (_V9({128})), 2)
_v355()
else
UI:Notify(tostring(res), 3)
end
end)
_v246(_v93, (_V9({235,115,137,81})), function()
local _v307, res = _v8.load(_v284.Text, _v104)
if _v307 then
if _v485 then
_v485.Scale = _v104.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({235,115,137,81,11,140,191,190,233,201,122,129,82,78,207})) .. res .. (_V9({128})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v246(_v93, (_V9({227,121,132,80,26,141})), function()
local _v307, res = _v8.delete(_v284.Text)
if _v307 then
UI:Notify((_V9({227,121,132,80,26,141,251,253,229,200,114,142,92,9,200,184})) .. res .. (_V9({128})), 2)
_v284.Text = (_V9({}))
_v355()
else
UI:Notify(tostring(res), 3)
end
end, _v4.danger)
_v355()
end
local function _v78(_v104)
_v427 = _v288((_V9({225,110,137,88,11})), {
Parent = _v186,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v427, CornerRadius = UDim.new(0, 6) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v427, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = _v427,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = _v427,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v139 = _v288((_V9({225,110,137,88,11})), {
Parent = _v427,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v139, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v427,
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
local _v141, _v140, _v406
_v427.InputBegan:Connect(function(_v213)
if _v223(_v213) then
_v141 = true
_v140 = _v213.Position
_v406 = _v427.Position
end
end)
table.insert(_v272, function(_v213)
if _v141 and _v427 then
local delta = _v213.Position - _v140
_v427.Position = UDim2.new(
_v406.X.Scale,
_v406.X.Offset + delta.X,
_v406.Y.Scale,
_v406.Y.Offset + delta.Y
)
end
end)
table.insert(_v358, function()
_v141 = false
end)
table.insert(_v416, function()
_v426 = _v104.UI.TargetDisplay
if not _v426 and _v427 then
_v427.Visible = false
end
end)
_v426 = _v104.UI.TargetDisplay
end
local function _v74(_v104)
_v173 = _v288((_V9({225,110,137,88,11})), {
Parent = _v186,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v173, CornerRadius = UDim.new(0, 6) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v173, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = _v173,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = _v173,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v139 = _v288((_V9({225,110,137,88,11})), {
Parent = _v173,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v139, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v173,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({138,49,200,83,30,155})),
})
table.insert(_v416, function()
if _v173 then
_v173.Visible = _v104.UI.FPSCounter
end
end)
_v173.Visible = _v104.UI.FPSCounter
end
local function _v79(_v104)
_v481 = _v288((_V9({238,113,137,82,11,164,254,191,227,203})), {
Parent = _v186,
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
table.insert(_v416, function()
if _v481 then
_v481.Visible = _v104.UI.Watermark
end
end)
_v481.Visible = _v104.UI.Watermark
end
local function _v75(_v104)
_v233 = 0
_v228 = _v288((_V9({225,110,137,88,11})), {
Parent = _v186,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
Visible = false,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v228, CornerRadius = UDim.new(0, 8) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v228, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), {
Parent = _v228,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = _v228,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v288((_V9({225,110,137,88,11})), {
Parent = _v228,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({236,121,145,87,7,134,251,174})),
})
local _v141, _v140, _v406
bar.InputBegan:Connect(function(_v213)
if _v223(_v213) then
_v141 = true
_v140 = _v213.Position
_v406 = _v228.Position
end
end)
table.insert(_v272, function(_v213)
if _v141 and _v228 then
local delta = _v213.Position - _v140
_v228.Position = UDim2.new(
_v406.X.Scale,
_v406.X.Offset + delta.X,
_v406.Y.Scale,
_v406.Y.Offset + delta.Y
)
end
end)
table.insert(_v358, function()
_v141 = false
end)
_v255(_v228, (_V9({234,121,134,64})), function()
return _v104.UI.MenuKey
end, function(_v225)
_v104.UI.MenuKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({202,121,134,64})))
end)
_v255(_v228, (_V9({230,117,133,87,1,156})), function()
return _v104.Camera.ToggleKey
end, function(_v225)
_v104.Camera.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({198,117,133,87,1,156})))
end)
_v255(_v228, (_V9({226,79,184})), function()
return _v104.ESP.ToggleKey
end, function(_v225)
_v104.ESP.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({194,111,152})))
end)
_v255(_v228, (_V9({225,83,190,21,45,129,237,190,234,194})), function()
return _v104.Camera.FOVCircleKey
end, function(_v225)
_v104.Camera.FOVCircleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({193,115,158,86,7,154,252,177,227})))
end)
_v255(_v228, (_V9({233,115,200,103,11,139,240,180,234})), function()
return _v104.NoRecoil.ToggleKey
end, function(_v225)
_v104.NoRecoil.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({201,115,154,80,13,135,246,177})))
end)
_v255(_v228, (_V9({233,115,200,102,30,154,250,188,226})), function()
return _v104.NoSpread.ToggleKey
end, function(_v225)
_v104.NoSpread.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({201,115,155,69,28,141,254,185})))
end)
_v255(_v228, (_V9({243,110,129,82,9,141,237,191,233,211})), function()
return _v104.Triggerbot.ToggleKey
end, function(_v225)
_v104.Triggerbot.ToggleKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({211,110,129,82,9,141,237,191,233,211})))
end)
_v255(_v228, (_V9({242,114,132,90,15,140})), function()
return _v104.UI.UnloadKey
end, function(_v225)
_v104.UI.UnloadKey = _v225
end, function(_v225)
return _v226(_v104, _v225, (_V9({210,114,132,90,15,140})))
end)
table.insert(_v416, function()
if _v228 then
_v228.Visible = _v104.UI.KeybindPanel
end
end)
_v228.Visible = _v104.UI.KeybindPanel
end
local function _v393(_v407)
if not _v245 or _v407 == visible then
return
end
visible = _v407
if _v44 and _v44.UI then
_v44.UI.Visible = _v407
end
if _v407 then
_v245.Visible = true
_v245.GroupTransparency = 1
_v35:Create(_v245, TweenInfo.new(_v14), { GroupTransparency = 0 }):Play()
else
local _v451 = _v35:Create(_v245, TweenInfo.new(_v14), { GroupTransparency = 1 })
_v451.Completed:Once(function()
if not visible and _v245 then
_v245.Visible = false
end
end)
_v451:Play()
end
end
function UI:Init(_v104, _v320)
if _v186 then
return
end
_v44 = _v104
_v321 = _v320
_v405()
_v186 = _v288((_V9({244,127,154,80,11,134,216,168,239})), {
Name = (_V9({241,125,134,92,26,145,216,184,232,194,110,137,89,59,161})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v307 = pcall(function()
_v186.Parent = Utility.getGuiParent()
end)
if not _v307 or not _v186.Parent then
_v186.Parent = _v22:WaitForChild((_V9({247,112,137,76,11,154,216,168,239})))
end
_v245 = _v288((_V9({228,125,134,67,15,155,216,175,233,210,108})), {
Parent = _v186,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v485 = _v288((_V9({242,85,187,86,15,132,250})), { Parent = _v245, Scale = _v104.UI.Scale })
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v245, CornerRadius = UDim.new(0, 8) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v245, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
local _v439 = _v288((_V9({225,110,137,88,11})), {
Parent = _v245,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v439, CornerRadius = UDim.new(0, 8) })
_v288((_V9({225,110,137,88,11})), {
Parent = _v439,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
local _v139 = _v288((_V9({225,110,137,88,11})), {
Parent = _v439,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v139, CornerRadius = UDim.new(1, 0) })
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v439,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({241,125,134,92,26,145,163,187,233,201,104,200,86,1,132,240,175,187,133,63,208,1,93,173,221,152,164,153,50,140,80,24,212,176,187,233,201,104,214,21,41,141,241,184,244,198,112}))
.. (_V9({155,122,135,91,26,200,252,178,234,200,110,213,23,77,208,222,234,197,230,44,202,11,78,200,191,31,49,135,60,200,67,94,212,176,187,233,201,104,214})),
ZIndex = 2,
})
_v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v439,
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
local _v141, _v140, _v406
_v439.InputBegan:Connect(function(_v213)
if _v223(_v213) then
_v141 = true
_v140 = _v213.Position
_v406 = _v245.Position
end
end)
table.insert(_v272, function(_v213)
if _v141 then
local delta = _v213.Position - _v140
_v245.Position = UDim2.new(
_v406.X.Scale,
_v406.X.Offset + delta.X,
_v406.Y.Scale,
_v406.Y.Offset + delta.Y
)
end
end)
table.insert(_v358, function()
_v141 = false
end)
local _v397 = _v288((_V9({225,110,137,88,11})), {
Parent = _v245,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v397, CornerRadius = UDim.new(0, 6) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v397, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = _v397,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v422 = _v288((_V9({225,110,137,88,11})), {
Parent = _v397,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v288((_V9({242,85,164,92,29,156,211,188,255,200,105,156})), { Parent = _v422, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v454 = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v397,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.danger,
Text = (_V9({242,114,132,90,15,140})),
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v454, CornerRadius = UDim.new(0, 6) })
local _v455 = _v288((_V9({242,85,187,65,28,135,244,184})), {
Parent = _v454,
Color = _v4.danger,
Thickness = 1,
Transparency = 0.55,
})
_v454.MouseButton1Click:Connect(function()
if _v321 then
_v321()
end
end)
_v454.MouseEnter:Connect(function()
_v35:Create(_v454, _v1, {
BackgroundColor3 = _v4.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v35:Create(_v455, _v1, { Transparency = 0 }):Play()
end)
_v454.MouseLeave:Connect(function()
_v35:Create(_v454, _v1, {
BackgroundColor3 = _v4.row,
TextColor3 = _v4.danger,
}):Play()
_v35:Create(_v455, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v288((_V9({225,110,137,88,11})), {
Parent = _v245,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v288((_V9({242,85,184,84,10,140,246,179,225})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v424 = { (_V9({228,115,133,87,15,156})), (_V9({241,117,155,64,15,132})), (_V9({234,115,158,80,3,141,241,169})), (_V9({244,121,156,65,7,134,248,174})) }
local _v421 = {}
for i, _v423 in ipairs(_v424) do
local _v217 = _v111 == _v423
local _v419 = _v288((_V9({243,121,144,65,44,157,235,169,233,201})), {
Parent = _v422,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.rowHover,
BackgroundTransparency = _v217 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v217 and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({135,60,200,21})) .. _v423,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v419, CornerRadius = UDim.new(0, 6) })
local stripe = _v288((_V9({225,110,137,88,11})), {
Parent = _v419,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
Visible = _v217,
ZIndex = 2,
})
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v420 = _v288((_V9({225,110,137,88,11})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v217,
})
_v421[_v423] = { btn = _v419, frame = _v420, stripe = stripe }
_v419.MouseButton1Click:Connect(function()
_v111 = _v423
for name, _v418 in pairs(_v421) do
local _v42 = name == _v423
_v418.frame.Visible = _v42
_v418.stripe.Visible = _v42
_v35:Create(_v418.btn, _v1, {
BackgroundTransparency = _v42 and 0 or 1,
TextColor3 = _v42 and _v4.text or _v4.textSub,
}):Play()
end
end)
_v419.MouseEnter:Connect(function()
if _v111 ~= _v423 then
_v35:Create(_v419, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v419.MouseLeave:Connect(function()
if _v111 ~= _v423 then
_v35:Create(_v419, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v71(_v421[(_V9({228,115,133,87,15,156}))].frame, _v104)
_v72(_v421[(_V9({241,117,155,64,15,132}))].frame, _v104)
_v76(_v421[(_V9({234,115,158,80,3,141,241,169}))].frame, _v104)
_v77(_v421[(_V9({244,121,156,65,7,134,248,174}))].frame, _v104)
_v75(_v104)
_v78(_v104)
_v74(_v104)
_v79(_v104)
if _v104.UI.Visible then
_v393(true)
end
end
function UI:Toggle()
_v393(not visible)
end
function UI:Show()
_v393(true)
end
function UI:Hide()
_v393(false)
end
function UI:SetCurrentTarget(name)
if not _v427 then
return
end
if _v427.Visible ~= _v426 then
_v427.Visible = _v426
end
if not _v426 or not targetPanelLabel then
return
end
local _v396, colour
if name and name ~= (_V9({})) and name ~= (_V9({233,115,134,80})) then
_v396, colour = name, (_V9({132,36,220,6,43,170,218}))
else
_v396, colour = (_V9({242,114,163,91,1,159,241})), (_V9({132,36,169,2,45,169,175}))
end
local text = (_V9({243,125,154,82,11,156,165,253,186,193,115,134,65,78,139,240,177,233,213,33,202})) .. colour .. (_V9({133,34})) .. _v396 .. (_V9({155,51,142,90,0,156,161}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v171)
if not fpsLabel or not _v173 or not _v173.Visible then
return
end
local text = string.format((_V9({155,122,135,91,26,200,252,178,234,200,110,213,23,77,208,171,238,195,229,89,202,11,75,140,163,242,224,200,114,156,11,78,142,239,174})), _v171 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v210)
if not _v481 then
return
end
local _v131 = tostring(_v210 or (_V9({}))):match((_V9({130,120,195})))
_v481.Image = _v131 and ((_V9({213,126,144,84,29,155,250,169,239,195,38,199,26})) .. _v131) or (_V9({}))
end
function UI:SyncControls()
for _, _v167 in ipairs(_v416) do
_v167()
end
end
function UI:IsCapturingKey()
return _v88
end
function UI:Notify(text, _v147)
if not _v186 then
return
end
_v147 = _v147 or 3
local _v440 = _v288((_V9({243,121,144,65,34,137,253,184,234})), {
Parent = _v186,
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
_v288((_V9({242,85,171,90,28,134,250,175})), { Parent = _v440, CornerRadius = UDim.new(0, 8) })
_v288((_V9({242,85,187,65,28,135,244,184})), { Parent = _v440, Color = _v4.accent, Thickness = 1, Transparency = 0.3 })
_v35:Create(_v440, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v147, function()
if _v440 and _v440.Parent then
local _v330 = _v35:Create(_v440, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v330.Completed:Once(function()
if _v440 then
_v440:Destroy()
end
end)
_v330:Play()
end
end)
end
function UI:Cleanup()
for _, _v107 in ipairs(_v452) do
_v107:Disconnect()
end
table.clear(_v452)
table.clear(_v272)
table.clear(_v358)
table.clear(_v416)
_v43 = nil
_v88 = false
_v45 = nil
_v427, targetPanelLabel = nil, nil
_v426 = false
_v228 = nil
_v481 = nil
_v173, fpsLabel = nil, nil
_v485 = nil
if _v186 then
_v186:Destroy()
_v186 = nil
_v245 = nil
end
visible = false
end
return UI
end)()
Movement = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v36 = game:GetService((_V9({242,111,141,71,39,134,239,168,242,244,121,154,67,7,139,250})))
local _v39 = game:GetService((_V9({240,115,154,94,29,152,254,190,227})))
local _v22 = _v24.LocalPlayer
local UI = UI
local Movement = {}
local _v2 = 16
local _v19 = 50
local _v276
local _v274
local _v280 = 0
local function _v273()
local _v95 = _v22.Character
local root = _v95 and _v95:FindFirstChild((_V9({239,105,133,84,0,135,246,185,212,200,115,156,101,15,154,235})))
local humanoid = _v95 and _v95:FindFirstChildOfClass((_V9({239,105,133,84,0,135,246,185})))
if not (_v95 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v95, root, humanoid
end
local function _v275(_v80)
local _v243 = _v80.CFrame.LookVector
local _v164 = Vector3.new(_v243.X, 0, _v243.Z)
if _v164.Magnitude < 0.001 then
_v164 = Vector3.new(0, 0, -1)
else
_v164 = _v164.Unit
end
local right = _v80.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v271 = Vector3.zero
if _v36:IsKeyDown(Enum.KeyCode.W) then
_v271 = _v271 + _v164
end
if _v36:IsKeyDown(Enum.KeyCode.S) then
_v271 = _v271 - _v164
end
if _v36:IsKeyDown(Enum.KeyCode.D) then
_v271 = _v271 + right
end
if _v36:IsKeyDown(Enum.KeyCode.A) then
_v271 = _v271 - right
end
if _v36:IsKeyDown(Enum.KeyCode.Space) then
_v271 = _v271 + Vector3.yAxis
end
if _v36:IsKeyDown(Enum.KeyCode.LeftShift) then
_v271 = _v271 - Vector3.yAxis
end
if _v271.Magnitude > 0 then
return _v271.Unit
end
return nil
end
local function _v279(_v104)
if _v104.Pulse == false then
return true
end
local _v66 = _v104.PulseBoost or 0.1
local _v100 = _v104.PulseCoast or 0.15
return (os.clock() % (_v66 + _v100)) < _v66
end
function Movement:Update(_v146, _v104)
local _v95, root, humanoid = _v273()
if _v104.NoclipEnabled and _v95 then
for _, _v333 in ipairs(_v95:GetDescendants()) do
if _v333:IsA((_V9({229,125,155,80,62,137,237,169}))) then
_v333.CanCollide = false
end
end
end
if not root then
return
end
if _v104.FlyEnabled then
local _v80 = _v39.CurrentCamera
if _v80 then
local _v468 = Vector3.zero
if not UI:IsCapturingKey() then
local _v132 = _v275(_v80)
if _v132 then
local _v400 = _v104.FlySpeed or 50
if not _v279(_v104) then
_v400 = math.min(_v400, _v2)
end
_v468 = _v132 * _v400
end
end
root.AssemblyLinearVelocity = _v468
end
return
end
if _v104.SpeedEnabled then
local _v400 = _v104.Speed or _v2
local _v271 = humanoid.MoveDirection
if _v400 > _v2 and _v271.Magnitude > 0 and _v279(_v104) then
local _v468 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v271.X * _v400, _v468.Y, _v271.Z * _v400)
end
end
end
local function _v278(_v104)
if not _v104.InfJumpEnabled then
return
end
local _, root = _v273()
if root then
local _v468 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v468.X, _v19, _v468.Z)
end
end
local function _v277(_v104, _v213, _v178)
if _v178 or UI:IsCapturingKey() then
return
end
if not _v104.ClickTPEnabled then
return
end
if _v213.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v36:IsKeyDown(_v104.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _, root = _v273()
local _v270 = _v22:GetMouse()
if not (root and _v270 and _v270.Hit) then
return
end
local _v127 = _v270.Hit.Position + Vector3.new(0, 3, 0)
if not _v104.ClickTPSteps then
root.CFrame = CFrame.new(_v127)
return
end
_v280 = _v280 + 1
local _v442 = _v280
local _v408 = _v104.ClickTPStep or 10
local _v216 = _v104.ClickTPInterval or 0.05
task.spawn(function()
while _v442 == _v280 do
local _, currentRoot = _v273()
if not currentRoot then
return
end
local _v306 = _v127 - currentRoot.CFrame.Position
if _v306.Magnitude <= _v408 then
currentRoot.CFrame = CFrame.new(_v127)
return
end
currentRoot.CFrame = currentRoot.CFrame + _v306.Unit * _v408
task.wait(_v216)
end
end)
end
function Movement:Init(_v104)
if not _v276 then
_v276 = _v36.JumpRequest:Connect(function()
_v278(_v104)
end)
end
if not _v274 then
_v274 = _v36.InputBegan:Connect(function(_v213, _v178)
_v277(_v104, _v213, _v178)
end)
end
end
function Movement:Cleanup()
if _v276 then
_v276:Disconnect()
_v276 = nil
end
if _v274 then
_v274:Disconnect()
_v274 = nil
end
end
return Movement
end)()
_v10 = (function()
local _v24 = game:GetService((_V9({247,112,137,76,11,154,236})))
local _v29 = game:GetService((_V9({245,105,134,102,11,154,233,180,229,194})))
local _v36 = game:GetService((_V9({242,111,141,71,39,134,239,168,242,244,121,154,67,7,139,250})))
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
_v10.Version = (_V9({151}))
_v10.Config = _v9
_v38.Version = _v10.Version
local _v374 = false
local _v108 = {}
local _v51 = false
local _v25 = (_V9({241,125,134,92,26,145,216,184,232,194,110,137,89,60,141,252,178,239,203}))
local _v184 = {}
local _v16 = 5
local function _v185(name, _v167, ...)
local _v307, res = pcall(_v167, ...)
if _v307 then
local _v404 = _v184[name]
if _v404 then
_v404.failures = 0
end
return true, res
end
local _v404 = _v184[name]
if not _v404 then
_v404 = { failures = 0, lastWarn = -math.huge }
_v184[name] = _v404
end
_v404.failures = _v404.failures + 1
local _v290 = os.clock()
if _v290 - _v404.lastWarn >= _v16 then
_v404.lastWarn = _v290
warn(string.format((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,163,212,60,142,84,7,132,250,185,166,143,100,205,81,71,210,191,248,245})), name, _v404.failures, tostring(res)))
end
return false, nil
end
function _v10.IsRunning()
return _v374
end
function _v10.SaveConfig(name)
return _v8.save(name, _v9)
end
function _v10.LoadConfig(name)
local _v307, res = _v8.load(name, _v9)
if _v307 then
pcall(function()
UI:SyncControls()
end)
end
return _v307, res
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
function _v10.SetWatermarkImage(_v210)
_v9.UI.WatermarkImageId = tostring(_v210 or (_V9({})))
UI:SetWatermarkImage(_v9.UI.WatermarkImageId)
return _v10
end
function _v10.SetWebhook(_v461)
return _v38.SetWebhook(_v461)
end
function _v10.HasWebhook()
return _v38.HasWebhook()
end
function _v10.SendWebhook(content, _v327)
return _v38.SendWebhook(content, _v327)
end
function _v10.SendLoadedEmbed(_v219)
return _v38.SendLoadedEmbed(_v219)
end
function _v10.Start()
if _v374 then
return _v10
end
_v374 = true
local _v307, err = pcall(function()
ESP:Init()
UI:Init(_v9, function()
_v10.Stop()
end)
Movement:Init(_v9.Movement)
SilentAim:Init(_v9.SilentAim)
Utility:Init(_v9.Utility)
table.insert(_v108, _v24.PlayerAdded:Connect(function(_v342)
_v185((_V9({247,112,137,76,11,154,222,185,226,194,120})), ESP.OnPlayerAdded, ESP, _v342)
end))
table.insert(_v108, _v24.PlayerRemoving:Connect(function(_v342)
_v185((_V9({247,112,137,76,11,154,205,184,235,200,106,129,91,9})), ESP.OnPlayerRemoving, ESP, _v342)
end))
table.insert(_v108, _v36.InputBegan:Connect(function(_v213, _v178)
if _v178 or UI:IsCapturingKey() then
return
end
_v185((_V9({236,121,145,87,7,134,251,174})), function()
local _v225 = _v213.KeyCode
if _v225 == _v9.UI.MenuKey then
UI:Toggle()
elseif _v225 == _v9.UI.UnloadKey then
_v10.Stop()
else
local _v441 = {
{ _v9.Camera, (_V9({226,114,137,87,2,141,251})), _v9.Camera.ToggleKey },
{ _v9.ESP, (_V9({226,114,137,87,2,141,251})), _v9.ESP.ToggleKey },
{ _v9.Camera, (_V9({225,83,190,118,7,154,252,177,227})), _v9.Camera.FOVCircleKey },
{ _v9.NoRecoil, (_V9({226,114,137,87,2,141,251})), _v9.NoRecoil.ToggleKey },
{ _v9.NoSpread, (_V9({226,114,137,87,2,141,251})), _v9.NoSpread.ToggleKey },
{ _v9.Triggerbot, (_V9({226,114,137,87,2,141,251})), _v9.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v441) do
if _v225 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v172, fpsFrames = 0, 0
table.insert(_v108, _v29.RenderStepped:Connect(function(_v146)
_v185((_V9({228,125,134,81,7,140,254,169,227,212})), _v7.Update, _v7, _v9.Camera, _v9.ESP)
_v185((_V9({226,79,184})), ESP.Update, ESP, _v9.ESP)
local _v309, target = _v185((_V9({230,117,133,87,1,156})), _v6.Update, _v6, _v9.Camera, _v9.Debug)
if not _v309 then
target = nil
end
if _v9.UI.TargetDisplay then
_v185((_V9({243,125,154,82,11,156,191,185,239,212,108,132,84,23})), function()
local _v244 = _v6:GetLookTarget(_v9.ESP, _v9.Camera)
UI:SetCurrentTarget(_v244 and _v244.Name or nil)
end)
end
_v51 = _v9.Camera.Enabled and target ~= nil
_v185((_V9({233,115,187,69,28,141,254,185})), NoSpread.Update, NoSpread, _v9.NoSpread)
_v185((_V9({243,110,129,82,9,141,237,191,233,211})), Triggerbot.Update, Triggerbot, _v9.Triggerbot, _v9.Camera)
_v185((_V9({234,115,158,80,3,141,241,169})), Movement.Update, Movement, _v146, _v9.Movement)
_v185((_V9({239,117,156,87,1,144})), _v18.Update, _v18, _v9.Hitbox, _v9.Camera)
_v185((_V9({227,110,137,66,7,134,248,253,195,244,76})), _v13.Update, _v13, _v9.Drawing, _v9.Camera)
_v185((_V9({241,117,155,64,15,132,236})), Visuals.Update, Visuals, _v9.Visuals)
_v172 = _v172 + _v146
fpsFrames = fpsFrames + 1
if _v172 >= 0.25 then
local _v171 = math.floor(fpsFrames / _v172 + 0.5)
_v172, fpsFrames = 0, 0
if _v9.UI.FPSCounter then
_v185((_V9({225,76,187,21,13,135,234,179,242,194,110})), UI.UpdateFPS, UI, _v171)
end
end
end))
pcall(function()
_v29:UnbindFromRenderStep(_v25)
end)
pcall(function()
_v29:BindToRenderStep(_v25, Enum.RenderPriority.Camera.Value + 1, function()
_v185((_V9({233,115,186,80,13,135,246,177})), NoRecoil.Update, NoRecoil, _v9.NoRecoil, _v51)
end)
end)
end)
if not _v307 then
warn((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,192,198,117,132,80,10,200,235,178,166,212,104,137,71,26,210})), err)
_v10.Stop()
return _v10
end
if getgenv then
getgenv().VanityGeneral = _v10
end
UI:Notify(string.format((_V9({241,125,134,92,26,145,178,154,227,201,121,154,84,2,200,243,178,231,195,121,140,21,78,10,31,127,166,135,76,154,80,29,155,191,248,245})), _v9.UI.MenuKey.Name), 4)
print(string.format((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,212,210,114,134,92,0,143,191,245,240,130,111,193})), _v10.Version))
print(string.format((_V9({234,121,134,64,84,200,186,174,166,135,96,200,21,45,137,242,184,244,198,38,200,16,29,200,191,161,166,135,73,134,89,1,137,251,231,166,130,111})),
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
if not _v374 then
return _v10
end
_v374 = false
for _, _v107 in ipairs(_v108) do
pcall(function()
_v107:Disconnect()
end)
end
table.clear(_v108)
pcall(function()
_v29:UnbindFromRenderStep(_v25)
end)
_v51 = false
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
table.clear(_v184)
print((_V9({252,74,137,91,7,156,230,240,193,194,114,141,71,15,132,194,253,213,211,115,152,69,11,140})))
return _v10
end
function _v10.Toggle()
if _v374 then
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
local _v348 = getgenv().VanityGeneral
if _v348 and _v348 ~= _v10 and type(_v348.Stop) == (_V9({193,105,134,86,26,129,240,179})) then
pcall(_v348.Stop)
end
end
pcall(function()
_v10.Start()
end)
return _v10
end
