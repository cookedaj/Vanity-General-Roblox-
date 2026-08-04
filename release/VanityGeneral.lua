local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({103,192,12,121,161,211,157,203,125})
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
Hitbox = (_V9({53,161,98,29,206,190,189,227,42,2,169,107,17,213,182,249,226})),
HitboxOptions = { (_V9({53,161,98,29,206,190,189,227,42,2,169,107,17,213,182,249,226})), (_V9({47,165,109,29})), (_V9({51,175,126,10,206})), (_V9({38,178,97,10})), (_V9({43,165,107,10})) },
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
WatermarkImageId = (_V9({86,243,53,65,149,230,171,242,78,95,245,52,65,148,229})),
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
Hitbox = (_V9({53,161,98,29,206,190,189,227,42,2,169,107,17,213,182,249,226})),
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
for _v378, _v457 in pairs(_v11) do
for _v221, value in pairs(_v457) do
if type(value) == (_V9({19,161,110,21,196})) then
local target = _v9[_v378][_v221]
if type(target) ~= (_V9({19,161,110,21,196})) then
target = {}
_v9[_v378][_v221] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v9[_v378][_v221] = value
end
end
end
end
return _v9
end)()
_v8 = (function()
local _v8 = {}
local _v5 = (_V9({49,161,98,16,213,170,218,174,19,2,178,109,21}))
local _v30 = { (_V9({36,161,97,28,211,178})), (_V9({34,147,92})), (_V9({41,175,94,28,194,188,244,167})), (_V9({41,175,95,9,211,182,252,175})), (_V9({42,175,122,28,204,182,243,191})), (_V9({52,169,96,28,207,167,220,162,16})), (_V9({47,169,120,27,206,171})), (_V9({35,178,109,14,200,189,250})), (_V9({49,169,127,12,192,191,238})), (_V9({50,180,101,21,200,167,228})), (_V9({50,137})) }
local function _v173()
return type(writefile) == (_V9({1,181,98,26,213,186,242,165}))
and type(readfile) == (_V9({1,181,98,26,213,186,242,165}))
and type(listfiles) == (_V9({1,181,98,26,213,186,242,165}))
end
local function _v148()
if type(isfolder) == (_V9({1,181,98,26,213,186,242,165})) and type(makefolder) == (_V9({1,181,98,26,213,186,242,165})) then
if not isfolder(_v5) then
pcall(makefolder, _v5)
end
end
end
local function _v373(name)
return (tostring(name or (_V9({}))):gsub((_V9({60,158,41,14,254,246,176,235,32})), (_V9({}))):gsub((_V9({57,229,127,82})), (_V9({}))):gsub((_V9({66,179,39,93})), (_V9({}))))
end
local function _v328(name)
return _v5 .. (_V9({72,176,126,22,199,186,241,174,34})) .. game.PlaceId .. (_V9({56})) .. name .. (_V9({73,170,127,22,207}))
end
local function _v232(name)
return _v5 .. (_V9({72})) .. name .. (_V9({73,170,127,22,207}))
end
local function _v147(v)
local t = typeof(v)
if t == (_V9({36,175,96,22,211,224})) then
return { __t = (_V9({36,175,96,22,211,224})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({34,174,121,20,232,167,248,166})) then
return { __t = (_V9({34,174,121,20})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({19,161,110,21,196})) then
local _v323 = {}
for k, _v454 in pairs(v) do
if type(_v454) ~= (_V9({1,181,98,26,213,186,242,165})) then
local _v146 = _v147(_v454)
if _v146 ~= nil then
_v323[k] = _v146
end
end
end
return _v323
elseif t == (_V9({9,181,97,27,196,161})) or t == (_V9({20,180,126,16,207,180})) or t == (_V9({5,175,99,21,196,178,243})) then
return v
end
return nil
end
local function _v120(v)
if type(v) ~= (_V9({19,161,110,21,196})) then
return v
end
if v.__t == (_V9({36,175,96,22,211,224})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({34,174,121,20})) then
local _v300, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v300 then
return item
end
return nil
end
return v
end
local function _v57(target, _v396)
for k, v in pairs(_v396) do
if type(v) == (_V9({19,161,110,21,196})) and v.__t == nil then
if type(target[k]) == (_V9({19,161,110,21,196})) then
_v57(target[k], v)
end
else
local _v121 = _v120(v)
if _v121 ~= nil then
target[k] = _v121
end
end
end
end
function _v8.isSupported()
return _v173()
end
function _v8.list()
local _v323 = {}
if not _v173() then
return _v323
end
_v148()
local _v300, files = pcall(listfiles, _v5)
if not _v300 or type(files) ~= (_V9({19,161,110,21,196})) then
return _v323
end
for _, _v327 in ipairs(files) do
local _v339 = (_V9({23,178,99,31,200,191,248,148})) .. game.PlaceId .. (_V9({56}))
local name = tostring(_v327):match((_V9({79,155,82,86,253,142,182,226,88,73,170,127,22,207,247})))
if name and name:sub(1, #_v339) == _v339 then
table.insert(_v323, name:sub(#_v339 + 1))
end
end
table.sort(_v323)
return _v323
end
function _v8.save(name, _v102)
if not _v173() then
return false, (_V9({51,168,101,10,129,182,229,174,30,18,180,99,11,129,187,252,184,93,9,175,44,31,200,191,248,235,60,55,137}))
end
name = _v373(name)
if name == (_V9({})) then
return false, (_V9({34,174,120,28,211,243,252,235,30,8,174,106,16,198,243,243,170,16,2}))
end
_v148()
local data = {}
for _, _v378 in ipairs(_v30) do
if type(_v102[_v378]) == (_V9({19,161,110,21,196})) then
data[_v378] = _v147(_v102[_v378])
end
end
local _v304, json = pcall(function()
return game:GetService((_V9({47,180,120,9,242,182,239,189,20,4,165}))):JSONEncode(data)
end)
if not _v304 then
return false, (_V9({34,174,111,22,197,182,189,173,28,14,172,105,29,155,243})) .. tostring(json)
end
local _v307, err = pcall(writefile, _v328(name), json)
if not _v307 then
return false, (_V9({48,178,101,13,196,243,251,170,20,11,165,104,67,129})) .. tostring(err)
end
return true, name
end
function _v8.load(name, _v102)
if not _v173() then
return false, (_V9({51,168,101,10,129,182,229,174,30,18,180,99,11,129,187,252,184,93,9,175,44,31,200,191,248,235,60,55,137}))
end
name = _v373(name)
if name == (_V9({})) then
return false, (_V9({34,174,120,28,211,243,252,235,30,8,174,106,16,198,243,243,170,16,2}))
end
local _v327 = _v328(name)
if type(isfile) == (_V9({1,181,98,26,213,186,242,165})) then
local _v303, exists = pcall(isfile, _v327)
if _v303 and not exists then
local _v231 = _v232(name)
local _v305, legacyExists = pcall(isfile, _v231)
if _v305 and legacyExists then
_v327 = _v231
else
return false, (_V9({41,175,44,26,206,189,251,162,26,71,174,109,20,196,183,189,236})) .. name .. (_V9({64}))
end
end
end
local _v306, raw = pcall(readfile, _v327)
if not _v306 or type(raw) ~= (_V9({20,180,126,16,207,180})) then
return false, (_V9({53,165,109,29,129,181,252,162,17,2,164}))
end
local _v304, data = pcall(function()
return game:GetService((_V9({47,180,120,9,242,182,239,189,20,4,165}))):JSONDecode(raw)
end)
if not _v304 or type(data) ~= (_V9({19,161,110,21,196})) then
return false, (_V9({51,168,109,13,129,181,244,167,24,71,169,127,23,134,167,189,189,28,11,169,104,89,235,128,210,133}))
end
for _, _v378 in ipairs(_v30) do
if type(data[_v378]) == (_V9({19,161,110,21,196})) and type(_v102[_v378]) == (_V9({19,161,110,21,196})) then
_v57(_v102[_v378], data[_v378])
end
end
return true, name
end
function _v8.delete(name)
name = _v373(name)
if name == (_V9({})) then
return false, (_V9({34,174,120,28,211,243,252,235,30,8,174,106,16,198,243,243,170,16,2}))
end
if type(delfile) ~= (_V9({1,181,98,26,213,186,242,165})) then
return false, (_V9({51,168,101,10,129,182,229,174,30,18,180,99,11,129,176,252,165,90,19,224,104,28,205,182,233,174,93,1,169,96,28,210}))
end
local _v300, err = pcall(delfile, _v328(name))
if not _v300 then
return false, tostring(err)
end
return true, name
end
return _v8
end)()
Utility = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v34 = game:GetService((_V9({51,165,96,28,209,188,239,191,46,2,178,122,16,194,182})))
local _v22 = _v24.LocalPlayer
local Utility = {}
local _v34 = game:GetService((_V9({51,165,96,28,209,188,239,191,46,2,178,122,16,194,182})))
local _v453
function Utility:Init(_v102)
if _v453 then
return
end
local _v471 = (type(VirtualUser) ~= (_V9({9,169,96})) and VirtualUser) or nil
if not _v471 then
pcall(function()
_v471 = game:GetService((_V9({49,169,126,13,212,178,241,158,14,2,178})))
end)
end
if not _v471 then
return
end
_v453 = _v22.Idled:Connect(function()
if _v102.AntiAFK then
_v471:CaptureController()
_v471:ClickButton2(Vector2.new())
end
end)
end
function Utility:Cleanup()
if _v453 then
_v453:Disconnect()
_v453 = nil
end
end
function Utility:ServerHop()
local _v300, err = pcall(function()
_v34:Teleport(game.PlaceId, _v22)
end)
if not _v300 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,46,2,178,122,28,211,243,245,164,13,71,166,109,16,205,182,249,241})), err)
end
return _v300
end
function Utility:Rejoin()
local _v300, err = pcall(function()
_v34:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v22)
end)
if not _v300 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,47,2,170,99,16,207,243,251,170,20,11,165,104,67})), err)
end
return _v300
end
function Utility.getGuiParent()
local _v300, hidden = pcall(function()
return gethui and gethui()
end)
if _v300 and hidden then
return hidden
end
local _v301, coreGui = pcall(function()
return game:GetService((_V9({36,175,126,28,230,166,244})))
end)
if _v301 and coreGui then
return coreGui
end
return _v22:WaitForChild((_V9({55,172,109,0,196,161,218,190,20})))
end
return Utility
end)()
_v7 = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v39 = game:GetService((_V9({48,175,126,18,210,163,252,168,24})))
local _v22 = _v24.LocalPlayer
local _v7 = {}
_v7.LocalRootPos = nil
local frame = {}
local _v3 = 0.5
local _v66 = {}
local _v67 = -math.huge
function _v7.GetBotCharacters()
local _v284 = os.clock()
if _v284 - _v67 < _v3 then
return _v66
end
_v67 = _v284
table.clear(_v66)
for _, _v123 in ipairs(_v39:GetDescendants()) do
if _v123:IsA((_V9({42,175,104,28,205})))
and _v123:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
and not _v24:GetPlayerFromCharacter(_v123)
then
table.insert(_v66, _v123)
end
end
return _v66
end
local function _v366(_v94, humanoid)
return humanoid.RootPart
or _v94:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
or _v94:FindFirstChild((_V9({51,175,126,10,206})))
or _v94:FindFirstChild((_V9({50,176,124,28,211,135,242,185,14,8})))
or _v94.PrimaryPart
end
local _v27 = {
Head = { (_V9({47,165,109,29})) },
Torso = { (_V9({50,176,124,28,211,135,242,185,14,8})), (_V9({43,175,123,28,211,135,242,185,14,8})), (_V9({51,175,126,10,206})), (_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})) },
Arms = {
(_V9({43,165,106,13,233,178,243,175})), (_V9({53,169,107,17,213,155,252,165,25})),
(_V9({43,165,106,13,237,188,234,174,15,38,178,97})), (_V9({53,169,107,17,213,159,242,188,24,21,129,126,20})),
(_V9({43,165,106,13,244,163,237,174,15,38,178,97})), (_V9({53,169,107,17,213,134,237,187,24,21,129,126,20})),
(_V9({43,165,106,13,129,146,239,166})), (_V9({53,169,107,17,213,243,220,185,16})),
},
Legs = {
(_V9({43,165,106,13,231,188,242,191})), (_V9({53,169,107,17,213,149,242,164,9})),
(_V9({43,165,106,13,237,188,234,174,15,43,165,107})), (_V9({53,169,107,17,213,159,242,188,24,21,140,105,30})),
(_V9({43,165,106,13,244,163,237,174,15,43,165,107})), (_V9({53,169,107,17,213,134,237,187,24,21,140,105,30})),
(_V9({43,165,106,13,129,159,248,172})), (_V9({53,169,107,17,213,243,209,174,26})),
},
}
local _v26 = { (_V9({47,165,109,29})), (_V9({51,175,126,10,206})), (_V9({38,178,97,10})), (_V9({43,165,107,10})) }
local function _v331(_v94, _v350)
local _v280 = _v27[_v350]
if not _v280 then
return nil
end
for _, name in ipairs(_v280) do
local _v326 = _v94:FindFirstChild(name)
if _v326 and _v326:IsA((_V9({37,161,127,28,241,178,239,191}))) then
return _v326
end
end
return nil
end
local function _v330(_v94)
for _, _v350 in ipairs(_v26) do
local _v326 = _v331(_v94, _v350)
if _v326 then
return _v326
end
end
for _, _v123 in ipairs(_v94:GetDescendants()) do
if _v123:IsA((_V9({37,161,127,28,241,178,239,191}))) then
return _v123
end
end
return nil
end
local function _v54(_v94, _v189, hrp)
return _v189
or hrp
or _v94:FindFirstChild((_V9({50,176,124,28,211,135,242,185,14,8})))
or _v94:FindFirstChild((_V9({51,175,126,10,206})))
or _v330(_v94)
end
local function _v72(_v94, _v335, _v79, _v80)
local humanoid = _v94 and _v94:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v189 = _v94:FindFirstChild((_V9({47,165,109,29})))
local hrp = _v94:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
local _v365 = _v366(_v94, humanoid)
local _v53 = _v54(_v94, _v189, hrp)
local _v151 = {
Player = _v335,
Character = _v94,
Humanoid = humanoid,
Head = _v189,
RootPart = _v365,
HRP = hrp,
Anchor = _v53,
}
if _v53 then
_v151.WorldDistance = (_v53.Position - _v80).Magnitude
local _v404, vis = _v79:WorldToViewportPoint(_v53.Position)
_v151.AnchorScreen = _v404
_v151.AnchorOnScreen = vis
end
if _v365 then
local _v436 = _v189 and (_v189.Position + Vector3.new(0, _v189.Size.Y, 0))
or (_v365.Position + Vector3.new(0, 3, 0))
local _v441, tvis = _v79:WorldToViewportPoint(_v436)
_v151.TopScreen = _v441
_v151.TopOnScreen = tvis
_v151.BotScreen = _v79:WorldToViewportPoint(_v365.Position - Vector3.new(0, 3.2, 0))
end
return _v151
end
function _v7:Update(_v81, _v153)
table.clear(frame)
local _v79 = _v39.CurrentCamera
local _v275 = _v22.Character
local _v276 = _v275 and _v275:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
_v7.LocalRootPos = _v276 and _v276.Position or nil
if not _v79 then
return
end
local _v80 = _v79.CFrame.Position
for _, _v335 in ipairs(_v24:GetPlayers()) do
if _v335 ~= _v22 then
local _v151 = _v72(_v335.Character, _v335, _v79, _v80)
if _v151 then
table.insert(frame, _v151)
end
end
end
if _v81 and _v81.TargetBots then
for _, _v94 in ipairs(_v7.GetBotCharacters()) do
local _v151 = _v72(_v94, nil, _v79, _v80)
if _v151 then
table.insert(frame, _v151)
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
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v39 = game:GetService((_V9({48,175,126,18,210,163,252,168,24})))
local _v22 = _v24.LocalPlayer
local Utility = Utility
local _v7 = _v7
local _v6 = {}
local Camera = _v39.CurrentCamera
local _v89 = Random.new()
local _v27 = {
Head = { (_V9({47,165,109,29})) },
Torso = { (_V9({50,176,124,28,211,135,242,185,14,8})), (_V9({43,175,123,28,211,135,242,185,14,8})), (_V9({51,175,126,10,206})), (_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})) },
Arms = {
(_V9({43,165,106,13,233,178,243,175})), (_V9({53,169,107,17,213,155,252,165,25})),
(_V9({43,165,106,13,237,188,234,174,15,38,178,97})), (_V9({53,169,107,17,213,159,242,188,24,21,129,126,20})),
(_V9({43,165,106,13,244,163,237,174,15,38,178,97})), (_V9({53,169,107,17,213,134,237,187,24,21,129,126,20})),
(_V9({43,165,106,13,129,146,239,166})), (_V9({53,169,107,17,213,243,220,185,16})),
},
Legs = {
(_V9({43,165,106,13,231,188,242,191})), (_V9({53,169,107,17,213,149,242,164,9})),
(_V9({43,165,106,13,237,188,234,174,15,43,165,107})), (_V9({53,169,107,17,213,159,242,188,24,21,140,105,30})),
(_V9({43,165,106,13,244,163,237,174,15,43,165,107})), (_V9({53,169,107,17,213,134,237,187,24,21,140,105,30})),
(_V9({43,165,106,13,129,159,248,172})), (_V9({53,169,107,17,213,243,209,174,26})),
},
}
local _v26 = { (_V9({47,165,109,29})), (_V9({51,175,126,10,206})), (_V9({38,178,97,10})), (_V9({43,165,107,10})) }
local _v362 = Random.new()
local function _v331(_v94, _v350)
local _v280 = _v27[_v350]
if not _v280 then
return nil
end
for _, name in ipairs(_v280) do
local _v326 = _v94:FindFirstChild(name)
if _v326 and _v326:IsA((_V9({37,161,127,28,241,178,239,191}))) then
return _v326
end
end
return nil
end
local function _v330(_v94)
for _, _v350 in ipairs(_v26) do
local _v326 = _v331(_v94, _v350)
if _v326 then
return _v326
end
end
for _, _v123 in ipairs(_v94:GetDescendants()) do
if _v123:IsA((_V9({37,161,127,28,241,178,239,191}))) then
return _v123
end
end
return nil
end
local function _v55(_v94)
return _v94:FindFirstChild((_V9({47,165,109,29})))
or _v94:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
or _v94:FindFirstChild((_V9({50,176,124,28,211,135,242,185,14,8})))
or _v94:FindFirstChild((_V9({51,175,126,10,206})))
or _v330(_v94)
end
local function _v364(_v474)
local _v437 = 0
for _, _v350 in ipairs(_v26) do
_v437 = _v437 + math.max(0, (_v474 and _v474[_v350]) or 0)
end
if _v437 <= 0 then
return (_V9({47,165,109,29}))
end
local _v363 = _v362:NextNumber() * _v437
local _v40 = 0
for _, _v350 in ipairs(_v26) do
_v40 = _v40 + math.max(0, _v474[_v350] or 0)
if _v363 <= _v40 then
return _v350
end
end
return (_V9({47,165,109,29}))
end
local function _v179(_v480)
local _v460, visible = Camera:WorldToViewportPoint(_v480)
if not visible or _v460.Z < 0 then
return math.huge
end
local _v376 = Vector2.new(_v460.X, _v460.Y)
local _v90 = Camera.ViewportSize / 2
return (_v376 - _v90).Magnitude
end
local function _v220(_v338, _v94)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v22.Character }
local _v360 = _v39:Raycast(Camera.CFrame.Position, _v338 - Camera.CFrame.Position, params)
return not _v360 or _v360.Instance:IsDescendantOf(_v94)
end
local _v15 = Color3.fromRGB(132, 62, 190)
local _v166, _v167, fovStroke
local function _v149()
if _v167 and _v167.Parent then
return _v167
end
_v166 = Instance.new((_V9({52,163,126,28,196,189,218,190,20})))
_v166.Name = (_V9({49,161,98,16,213,170,218,174,19,2,178,109,21,231,156,203}))
_v166.ResetOnSpawn = false
_v166.IgnoreGuiInset = true
_v166.DisplayOrder = 998
local _v300 = pcall(function()
_v166.Parent = Utility.getGuiParent()
end)
if not _v300 or not _v166.Parent then
_v166.Parent = _v22:WaitForChild((_V9({55,172,109,0,196,161,218,190,20})))
end
_v167 = Instance.new((_V9({33,178,109,20,196})))
_v167.Name = (_V9({53,169,98,30}))
_v167.AnchorPoint = Vector2.new(0.5, 0.5)
_v167.Position = UDim2.fromScale(0.5, 0.5)
_v167.BackgroundTransparency = 1
_v167.BorderSizePixel = 0
_v167.Parent = _v166
local _v108 = Instance.new((_V9({50,137,79,22,211,189,248,185})))
_v108.CornerRadius = UDim.new(1, 0)
_v108.Parent = _v167
fovStroke = Instance.new((_V9({50,137,95,13,211,188,246,174})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v15
fovStroke.Parent = _v167
return _v167
end
local function _v448(_v102)
local _v387 = _v102.FOVCircle
if not _v387 then
if _v167 then
_v167.Visible = false
end
return
end
local _v361 = _v149()
if not _v361 then
return
end
local _v127 = math.max(0, _v102.FOV or 0) * 2
_v361.Size = UDim2.fromOffset(_v127, _v127)
_v361.Visible = true
end
local function _v126()
if _v166 then
pcall(function()
_v166:Destroy()
end)
end
_v166, _v167, fovStroke = nil, nil, nil
end
local function _v156(_v94, _v335, _v102)
if not _v94 then
return nil
end
if _v102.TeamCheck and _v335 and _v335.Team ~= nil and _v335.Team == _v22.Team then
return nil
end
local humanoid = _v94:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v53 = _v55(_v94)
if not _v53 then
return nil
end
local _v133 = _v179(_v53.Position)
if _v133 >= (_v102.FOV or 200) then
return nil
end
local _v479 = (_v53.Position - Camera.CFrame.Position).Magnitude
if _v479 > _v102.MaxDistance then
return nil
end
if _v102.WallCheck and not _v220(_v53.Position, _v94) then
return nil
end
return { Player = _v335, Character = _v94, Anchor = _v53, ScreenDistance = _v133 }
end
local function _v377(_v83)
if not _v83.AnchorOnScreen or _v83.AnchorScreen.Z < 0 then
return math.huge
end
local _v376 = Vector2.new(_v83.AnchorScreen.X, _v83.AnchorScreen.Y)
local _v90 = Camera.ViewportSize / 2
return (_v376 - _v90).Magnitude
end
local function _v155(_v83, _v102)
local _v335 = _v83.Player
if _v102.TeamCheck and _v335 and _v335.Team ~= nil and _v335.Team == _v22.Team then
return nil
end
local _v53 = _v83.Anchor
if not _v53 then
return nil
end
local _v133 = _v377(_v83)
if _v133 >= (_v102.FOV or 200) then
return nil
end
if (_v83.WorldDistance or math.huge) > _v102.MaxDistance then
return nil
end
if _v102.WallCheck and not _v220(_v53.Position, _v83.Character) then
return nil
end
return { Player = _v335, Character = _v83.Character, Anchor = _v53, ScreenDistance = _v133 }
end
function _v6:FindBestTarget(_v102)
local _v63
local _v64 = math.huge
for _, _v83 in ipairs(_v7:Get()) do
local _v84 = _v155(_v83, _v102)
if _v84 and _v84.ScreenDistance < _v64 then
_v64 = _v84.ScreenDistance
_v63 = _v84
end
end
return _v63
end
local _v20 = 50
function _v6:GetLookTarget(_v153, _v81)
local _v63
local _v64 = _v20
local _v277 = _v7.LocalRootPos
local _v259 = (_v153 and _v153.MaxDistance) or math.huge
local _v430 = _v81 and _v81.TeamCheck
for _, _v83 in ipairs(_v7:Get()) do
local _v335 = _v83.Player
if not (_v430 and _v335 and _v335.Team ~= nil and _v335.Team == _v22.Team) then
local _v53 = _v83.Anchor
if _v53 and not (_v277 and (_v53.Position - _v277).Magnitude > _v259) then
local _v133 = _v377(_v83)
if _v133 <= _v64 then
_v64 = _v133
_v63 = _v335 or _v83.Character
end
end
end
end
return _v63
end
function _v6:_resolveRegion(_v94, _v102)
local _v264 = _v102.Hitbox
if _v264 and _v264 ~= (_V9({53,161,98,29,206,190,189,227,42,2,169,107,17,213,182,249,226})) and _v27[_v264] then
return _v264
end
if self._lockedChar ~= _v94 then
self._lockedChar = _v94
self._rolledRegion = _v364(_v102.TargetWeights)
end
return self._rolledRegion or (_V9({47,165,109,29}))
end
function _v6:PointCamera(_v420, _v392)
local _v124 = CFrame.lookAt(Camera.CFrame.Position, _v420)
local _v52 = math.clamp(1 - (_v392 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v124, _v52)
end
function _v6:Update(_v102, debug)
Camera = _v39.CurrentCamera
_v448(_v102)
if not _v102.Enabled then
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
if _v102.StickyTarget and self._stickyCharacter then
if not self._stickyPlayer or self._stickyPlayer.Parent == _v24 then
target = _v156(self._stickyCharacter, self._stickyPlayer, _v102)
end
end
if not target then
target = self:FindBestTarget(_v102)
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
local _v350 = self:_resolveRegion(target.Character, _v102)
local _v48 = _v331(target.Character, _v350) or _v330(target.Character)
if not _v48 then
self._currentTarget = nil
return
end
local _v49 = _v48.Position
local _v479 = (_v49 - Camera.CFrame.Position).Magnitude
if (_v102.Prediction or 0) > 0 then
_v49 = _v49 + _v48.AssemblyLinearVelocity * _v102.Prediction * (_v479 / 500)
end
local _v392 = _v102.Smoothness
if _v102.Humanize then
_v392 = _v392 * (0.9 + _v89:NextNumber() * 0.2)
_v49 = _v49 + _v89:NextUnitVector() * (_v479 * math.rad(_v89:NextNumber() * 0.25))
end
self:PointCamera(_v49, _v392)
target.Part = _v48
target.Region = _v350
self._currentTarget = target
if debug then
print((_V9({51,178,109,26,202,186,243,172,71})), target.Character.Name, (_V9({53,165,107,16,206,189,167})), _v350, (_V9({35,169,127,13,192,189,254,174,71})), math.floor(target.ScreenDistance))
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
_v126()
end
_v6.GetBotCharacters = _v7.GetBotCharacters
return _v6
end)()
ESP = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v39 = game:GetService((_V9({48,175,126,18,210,163,252,168,24})))
local _v22 = _v24.LocalPlayer
local _v9 = _v9
local Utility = Utility
local _v7 = _v7
local ESP = {}
local _v150 = {}
local _v107
local _v69
local _v12 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v214(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v154(_v94)
local _v206 = _v94:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
return (_v206 and _v206.RootPart)
or _v94:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
or _v94:FindFirstChild((_V9({51,175,126,10,206})))
or _v94:FindFirstChild((_V9({50,176,124,28,211,135,242,185,14,8})))
or _v94.PrimaryPart
end
local function _v176()
if _v69 and _v69.Parent then
return _v69
end
_v69 = Instance.new((_V9({52,163,126,28,196,189,218,190,20})))
_v69.Name = (_V9({49,161,98,16,213,170,218,174,19,2,178,109,21,227,188,229,174,14}))
_v69.ResetOnSpawn = false
_v69.IgnoreGuiInset = true
_v69.DisplayOrder = 996
local _v300 = pcall(function()
_v69.Parent = Utility.getGuiParent()
end)
if not _v300 or not _v69.Parent then
_v69.Parent = _v22:WaitForChild((_V9({55,172,109,0,196,161,218,190,20})))
end
return _v69
end
local function _v447(_v151, _v94, _v102, _v83)
local _v79 = _v39.CurrentCamera
local root = _v83 and _v83.RootPart or _v154(_v94)
if not _v79 or not root or not _v151.box then
if _v151.box then
_v151.box.Visible = false
end
return
end
local _v435, onScreen, botV
if _v83 then
if not _v83.TopScreen then
_v151.box.Visible = false
return
end
_v435, onScreen, botV = _v83.TopScreen, _v83.TopOnScreen, _v83.BotScreen
else
local _v189 = _v94:FindFirstChild((_V9({47,165,109,29})))
local _v436 = _v189 and (_v189.Position + Vector3.new(0, _v189.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v68 = root.Position - Vector3.new(0, 3.2, 0)
_v435, onScreen = _v79:WorldToViewportPoint(_v436)
botV = _v79:WorldToViewportPoint(_v68)
end
if not onScreen or _v435.Z <= 0 then
_v151.box.Visible = false
return
end
local _v193 = math.abs(botV.Y - _v435.Y)
local _v475 = _v193 * 0.62
local _v110 = (_v435.X + botV.X) * 0.5
local _v111 = (_v435.Y + botV.Y) * 0.5
_v151.box.Size = UDim2.fromOffset(_v475, _v193)
_v151.box.Position = UDim2.fromOffset(_v110 - _v475 * 0.5, _v111 - _v193 * 0.5)
_v151.box.BackgroundColor3 = _v102.FillColor
_v151.box.BackgroundTransparency = _v102.Filled and (1 - _v102.FillOpacity) or 1
_v151.boxStroke.Color = _v102.OutlineColor
_v151.boxStroke.Transparency = 1 - _v102.OutlineOpacity
_v151.box.Visible = true
end
local function _v250(_v151, name, _v189, _v102)
local _v417 = Instance.new((_V9({37,169,96,21,195,188,252,185,25,32,181,101})))
_v417.Name = (_V9({49,135,69,23,199,188}))
_v417.Size = UDim2.fromOffset(200, 46)
_v417.StudsOffset = Vector3.new(0, 2.7, 0)
_v417.AlwaysOnTop = true
_v417.Adornee = _v189
_v417.Parent = _v189
local _v199 = Instance.new((_V9({33,178,109,20,196})))
_v199.BackgroundTransparency = 1
_v199.Size = UDim2.fromScale(1, 1)
_v199.Parent = _v417
local _v228 = Instance.new((_V9({50,137,64,16,210,167,209,170,4,8,181,120})))
_v228.SortOrder = Enum.SortOrder.LayoutOrder
_v228.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v228.VerticalAlignment = Enum.VerticalAlignment.Center
_v228.Parent = _v199
local _v279 = Instance.new((_V9({51,165,116,13,237,178,255,174,17})))
_v279.LayoutOrder = 1
_v279.BackgroundTransparency = 1
_v279.Size = UDim2.new(1, 0, 0, 16)
_v279.Font = Enum.Font.GothamBold
_v279.TextSize = 13
_v279.TextColor3 = _v102.OutlineColor
_v279.TextStrokeTransparency = 0.35
_v279.Text = name
_v279.Visible = false
_v279.Parent = _v199
local _v132 = Instance.new((_V9({51,165,116,13,237,178,255,174,17})))
_v132.LayoutOrder = 2
_v132.BackgroundTransparency = 1
_v132.Size = UDim2.new(1, 0, 0, 14)
_v132.Font = Enum.Font.Gotham
_v132.TextSize = 12
_v132.TextColor3 = _v102.OutlineColor
_v132.TextStrokeTransparency = 0.4
_v132.Text = (_V9({}))
_v132.Visible = false
_v132.Parent = _v199
local _v191 = Instance.new((_V9({33,178,109,20,196})))
_v191.LayoutOrder = 3
_v191.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v191.BackgroundTransparency = 0.3
_v191.BorderSizePixel = 0
_v191.Size = UDim2.new(0.55, 0, 0, 5)
_v191.Visible = false
_v191.Parent = _v199
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v191, CornerRadius = UDim.new(1, 0) })
local _v192 = Instance.new((_V9({33,178,109,20,196})))
_v192.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v192.BorderSizePixel = 0
_v192.Size = UDim2.fromScale(1, 1)
_v192.Parent = _v191
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v192, CornerRadius = UDim.new(1, 0) })
_v151.nameTag = _v417
_v151.nameLabel = _v279
_v151.distanceLabel = _v132
_v151.healthBack = _v191
_v151.healthFill = _v192
_v151.nameHead = _v189
end
local function _v449(name, _v151, _v94, _v102, _v83)
local _v189 = _v83 and (_v83.Head or _v83.HRP)
or _v94:FindFirstChild((_V9({47,165,109,29})))
or _v94:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
if not _v189 then
if _v151.nameTag then
_v151.nameTag.Enabled = false
end
return
end
if not _v151.nameTag or not _v151.nameTag.Parent or _v151.nameHead ~= _v189 then
if _v151.nameTag then
pcall(function()
_v151.nameTag:Destroy()
end)
end
_v250(_v151, name, _v189, _v102)
end
_v151.nameLabel.TextColor3 = _v102.OutlineColor
_v151.nameLabel.Visible = _v102.Names or _v102.NameTags
_v151.distanceLabel.Visible = _v102.Distance or _v102.DistanceTags
if _v151.distanceLabel.Visible then
_v151.distanceLabel.TextColor3 = _v102.OutlineColor
local _v277, hrp
if _v83 then
_v277, hrp = _v7.LocalRootPos, _v83.HRP
else
local _v275 = _v22.Character
local _v276 = _v275 and _v275:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
_v277 = _v276 and _v276.Position
hrp = _v94:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
end
local d = (_v277 and hrp) and math.floor((hrp.Position - _v277).Magnitude + 0.5) or 0
_v151.distanceLabel.Text = (_V9({60})) .. d .. (_V9({10,157}))
end
_v151.healthBack.Visible = _v102.HealthBars
if _v102.HealthBars then
local humanoid = _v83 and _v83.Humanoid or _v94:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
local _v171 = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v151.healthFill.Size = UDim2.fromScale(_v171, 1)
_v151.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v171)
end
_v151.nameTag.Enabled = true
end
local function _v196(_v151)
_v151.hl.Enabled = false
if _v151.box then
_v151.box.Visible = false
end
if _v151.nameTag then
_v151.nameTag.Enabled = false
end
end
local function _v354(_v151, _v94, name, _v102, _v83)
if _v102.Outlines then
if _v151.hl.Adornee ~= _v94 then
_v151.hl.Adornee = _v94
end
_v151.hl.OutlineColor = _v102.OutlineColor
_v151.hl.FillColor = _v102.FillColor
_v151.hl.OutlineTransparency = 1 - _v102.OutlineOpacity
_v151.hl.FillTransparency = _v102.Filled and (1 - _v102.FillOpacity) or 1
_v151.hl.DepthMode = _v12
_v151.hl.Enabled = true
else
_v151.hl.Enabled = false
end
if _v102.Boxes then
_v447(_v151, _v94, _v102, _v83)
elseif _v151.box then
_v151.box.Visible = false
end
if _v102.Names or _v102.Distance or _v102.NameTags or _v102.DistanceTags or _v102.HealthBars then
_v449(name, _v151, _v94, _v102, _v83)
elseif _v151.nameTag then
_v151.nameTag.Enabled = false
end
end
local function _v134(_v326)
local _v275 = _v22.Character
local _v276 = _v275 and _v275:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
if not _v276 or not _v326 then
return 0
end
return (_v326.Position - _v276.Position).Magnitude
end
local function _v451(_v83, _v151, _v102)
local hrp = _v83.HRP
if not _v102.Enabled or not hrp then
_v196(_v151)
return
end
local _v277 = _v7.LocalRootPos
local _v131 = _v277 and (hrp.Position - _v277).Magnitude or 0
if _v131 > _v102.MaxDistance then
_v196(_v151)
return
end
_v354(_v151, _v83.Character, _v83.Player.Name, _v102, _v83)
end
local function _v281(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v197 = Instance.new((_V9({47,169,107,17,205,186,250,163,9})))
_v197.Name = (_V9({34,147,92,54,212,167,241,162,19,2}))
_v197.Enabled = false
_v197.FillColor = color
_v197.OutlineColor = color
_v197.Parent = _v107
local box = Instance.new((_V9({33,178,109,20,196})))
box.Name = (_V9({34,147,92,59,206,171}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v176()
local boxStroke = Instance.new((_V9({50,137,95,13,211,188,246,174})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = _v197, box = box, boxStroke = boxStroke }
end
local function _v125(_v151)
if _v151.hl then
_v151.hl:Destroy()
end
if _v151.box then
_v151.box:Destroy()
end
if _v151.nameTag then
pcall(function()
_v151.nameTag:Destroy()
end)
end
end
local function _v46(_v335, _v122)
if _v335 == _v22 or _v150[_v335] then
return
end
_v150[_v335] = _v281(_v122)
end
local function _v353(_v335)
local _v151 = _v150[_v335]
if not _v151 then
return
end
_v125(_v151)
_v150[_v335] = nil
end
local _v285 = {}
local _v227 = 0
local _v23 = 1
local function _v352(_v265)
local _v151 = _v285[_v265]
if not _v151 then
return
end
_v125(_v151)
_v285[_v265] = nil
end
local function _v357()
local current = {}
for _, _v299 in ipairs(_v39:GetDescendants()) do
if _v299:IsA((_V9({47,181,97,24,207,188,244,175}))) then
local _v265 = _v299.Parent
if
_v265
and _v265:IsA((_V9({42,175,104,28,205})))
and _v265 ~= _v22.Character
and not _v24:GetPlayerFromCharacter(_v265)
then
current[_v265] = true
if not _v285[_v265] then
_v285[_v265] = _v281(_v9.ESP.OutlineColor)
end
end
end
end
for _v265 in pairs(_v285) do
if not current[_v265] or not _v265.Parent then
_v352(_v265)
end
end
end
local function _v450(_v265, _v151, _v102)
local root = _v154(_v265)
local humanoid = _v265:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
if not _v265.Parent or not root or not _v214(humanoid) then
_v196(_v151)
return
end
if _v134(root) > _v102.MaxDistance then
_v196(_v151)
return
end
_v354(_v151, _v265, _v265.Name, _v102)
end
function ESP:Init()
if _v107 then
return
end
_v107 = Instance.new((_V9({33,175,96,29,196,161})))
_v107.Name = (_V9({49,161,98,16,213,170,218,174,19,2,178,109,21,228,128,205}))
local _v300 = pcall(function()
_v107.Parent = Utility.getGuiParent()
end)
if not _v300 or not _v107.Parent then
_v107.Parent = _v39
end
for _, _v335 in ipairs(_v24:GetPlayers()) do
_v46(_v335, _v9.ESP.OutlineColor)
end
end
function ESP:Update(_v102)
local _v355 = {}
for _, _v83 in ipairs(_v7:Get()) do
local _v335 = _v83.Player
if _v335 then
_v355[_v335] = true
local _v151 = _v150[_v335]
if not _v151 then
_v46(_v335, _v102.OutlineColor)
_v151 = _v150[_v335]
end
_v451(_v83, _v151, _v102)
end
end
for _v335, _v151 in pairs(_v150) do
if _v335.Parent ~= _v24 then
_v353(_v335)
elseif not _v355[_v335] then
_v196(_v151)
end
end
if _v102.Enabled and _v102.NPCs then
if os.clock() - _v227 >= _v23 then
_v227 = os.clock()
_v357()
end
for _v265, _v151 in pairs(_v285) do
_v450(_v265, _v151, _v102)
end
elseif next(_v285) then
for _v265 in pairs(_v285) do
_v352(_v265)
end
end
end
function ESP:OnPlayerAdded(_v335)
_v46(_v335, _v9.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v335)
_v353(_v335)
end
function ESP:Cleanup()
for _v335 in pairs(_v150) do
_v353(_v335)
end
for _v265 in pairs(_v285) do
_v352(_v265)
end
if _v107 then
_v107:Destroy()
_v107 = nil
end
if _v69 then
_v69:Destroy()
_v69 = nil
end
end
return ESP
end)()
_v13 = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v39 = game:GetService((_V9({48,175,126,18,210,163,252,168,24})))
local _v22 = _v24.LocalPlayer
local _v7 = _v7
local _v13 = {}
local _v112 = type(Drawing) == (_V9({19,161,110,21,196})) and type(Drawing.new) == (_V9({1,181,98,26,213,186,242,165}))
local _v119 = false
local _v113 = {}
local function _v116()
local _v233 = Drawing.new((_V9({43,169,98,28})))
_v233.Thickness = 1
_v233.Visible = false
return _v233
end
local function _v115(_v335)
local _v151 = {
box = { _v116(), _v116(), _v116(), _v116() },
tracer = _v116(),
}
_v113[_v335] = _v151
return _v151
end
local function _v114(_v151)
for _, _v233 in ipairs(_v151.box) do
_v233.Visible = false
end
_v151.tracer.Visible = false
end
local function _v117(_v335)
local _v151 = _v113[_v335]
if not _v151 then
return
end
_v113[_v335] = nil
for _, _v233 in ipairs(_v151.box) do
_v233:Remove()
end
_v151.tracer:Remove()
end
local function _v118(_v83, _v102, _v79, _v81)
local _v335 = _v83.Player
local _v151 = _v113[_v335]
if _v81.TeamCheck and _v335.Team ~= nil and _v335.Team == _v22.Team then
if _v151 then
_v114(_v151)
end
return
end
local root = _v83.HRP
if not (_v102.Boxes or _v102.Tracers) or not root then
if _v151 then
_v114(_v151)
end
return
end
local _v435, onScreen, botV = _v83.TopScreen, _v83.TopOnScreen, _v83.BotScreen
if not _v435 or not onScreen or _v435.Z <= 0 or botV.Z <= 0 then
if _v151 then
_v114(_v151)
end
return
end
_v151 = _v151 or _v115(_v335)
local _v193 = math.abs(botV.Y - _v435.Y)
local _v475 = _v193 * 0.62
local _v110 = (_v435.X + botV.X) * 0.5
local _v230, right = _v110 - _v475 * 0.5, _v110 + _v475 * 0.5
local _v434, bottom = _v435.Y, botV.Y
local box = _v151.box
box[1].From = Vector2.new(_v230, _v434)
box[1].To = Vector2.new(right, _v434)
box[2].From = Vector2.new(_v230, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v230, _v434)
box[3].To = Vector2.new(_v230, bottom)
box[4].From = Vector2.new(right, _v434)
box[4].To = Vector2.new(right, bottom)
for _, _v233 in ipairs(box) do
_v233.Color = _v102.BoxColor
_v233.Visible = _v102.Boxes
end
_v151.tracer.From = Vector2.new(_v79.ViewportSize.X / 2, _v79.ViewportSize.Y)
_v151.tracer.To = Vector2.new(_v110, bottom)
_v151.tracer.Color = _v102.TracerColor
_v151.tracer.Visible = _v102.Tracers
end
function _v13:Update(_v102, _v81)
if not _v112 then
if (_v102.Boxes or _v102.Tracers) and not _v119 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,63,8,184,35,45,211,178,254,174,15,71,133,95,41,129,189,248,174,25,20,224,120,17,196,243,217,185,28,16,169,98,30,129,191,244,169,15,6,178,117,89,67,83,9,235,19,8,180,44,24,215,178,244,167,28,5,172,105,89,200,189,189,191,21,14,179,44,28,217,182,254,190,9,8,178,34})))
_v119 = true
end
return
end
local _v79 = _v39.CurrentCamera
if not _v79 then
return
end
local _v379 = {}
for _, _v83 in ipairs(_v7:Get()) do
if _v83.Player then
_v379[_v83.Player] = true
_v118(_v83, _v102, _v79, _v81)
end
end
for _v335, _v151 in pairs(_v113) do
if _v335.Parent ~= _v24 then
_v117(_v335)
elseif not _v379[_v335] then
_v114(_v151)
end
end
end
function _v13:Cleanup()
for _v335 in pairs(_v113) do
_v117(_v335)
end
end
return _v13
end)()
Visuals = (function()
local _v21 = game:GetService((_V9({43,169,107,17,213,186,243,172})))
local Visuals = {}
local _v21 = game:GetService((_V9({43,169,107,17,213,186,243,172})))
local _v468
local _v465 = false
local _v467 = false
local _v466 = 0
local _v37 = 1
local function _v464()
if _v468 then
return
end
_v468 = {
Brightness = _v21.Brightness,
ClockTime = _v21.ClockTime,
GlobalShadows = _v21.GlobalShadows,
FogEnd = _v21.FogEnd,
FogStart = _v21.FogStart,
Ambient = _v21.Ambient,
OutdoorAmbient = _v21.OutdoorAmbient,
}
end
local function _v462()
_v21.Brightness = 2
_v21.ClockTime = 14
_v21.GlobalShadows = false
end
local function _v463()
_v21.FogEnd = 100000
end
local function _v469()
_v21.Brightness = _v468.Brightness
_v21.ClockTime = _v468.ClockTime
_v21.GlobalShadows = _v468.GlobalShadows
end
local function _v470()
_v21.FogEnd = _v468.FogEnd
_v21.FogStart = _v468.FogStart
end
function Visuals:Update(_v102)
if not (_v102.Fullbright or _v102.NoFog or _v465 or _v467) then
return
end
_v464()
if _v102.Fullbright ~= _v465 then
_v465 = _v102.Fullbright
if _v465 then
_v462()
else
_v469()
end
end
if _v102.NoFog ~= _v467 then
_v467 = _v102.NoFog
if _v467 then
_v463()
else
_v470()
end
end
if (_v465 or _v467) and os.clock() - _v466 >= _v37 then
_v466 = os.clock()
if _v465
and (_v21.Brightness ~= 2 or _v21.ClockTime ~= 14 or _v21.GlobalShadows)
then
_v462()
end
if _v467 and _v21.FogEnd < 100000 then
_v463()
end
end
end
function Visuals:Cleanup()
if _v468 then
if _v465 then
_v469()
end
if _v467 then
_v470()
end
end
_v465 = false
_v467 = false
end
return Visuals
end)()
_v38 = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v22 = _v24.LocalPlayer
local _v9 = _v9
local _v38 = {}
_v38.Version = (_V9({87}))
local function _v358()
local _v85 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v164 in ipairs(_v85) do
if type(_v164) == (_V9({1,181,98,26,213,186,242,165})) then
return _v164
end
end
return nil
end
local function _v359()
local _v452 = _v9.Webhook.Url
if type(_v452) == (_V9({20,180,126,16,207,180})) and _v452 ~= (_V9({})) then
return _v452
end
return nil
end
function _v38.SetWebhook(_v452)
_v9.Webhook.Url = tostring(_v452 or (_V9({})))
return true
end
function _v38.HasWebhook()
return _v359() ~= nil
end
function _v38.SendWebhook(content, _v320)
_v320 = _v320 or {}
local _v452 = _v359()
if not _v452 then
return false, (_V9({9,175,83,14,196,177,245,164,18,12}))
end
local _v356 = _v358()
if not _v356 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,51,8,224,68,45,245,131,189,185,24,22,181,105,10,213,243,251,190,19,4,180,101,22,207,243,252,189,28,14,172,109,27,205,182,189,162,19,71,180,100,16,210,243,248,179,24,4,181,120,22,211})))
return false, (_V9({9,175,83,17,213,167,237}))
end
local _v329 = {
username = _v320.username or (_V9({49,161,98,16,213,170,176,140,24,9,165,126,24,205})),
avatar_url = _v320.avatar_url,
content = content,
embeds = _v320.embeds,
}
local _v300, err = pcall(function()
local _v65 = game:GetService((_V9({47,180,120,9,242,182,239,189,20,4,165}))):JSONEncode(_v329)
return _v356({
Url = _v452,
Method = (_V9({55,143,95,45})),
Headers = { [(_V9({36,175,98,13,196,189,233,230,41,30,176,105}))] = (_V9({6,176,124,21,200,176,252,191,20,8,174,35,19,210,188,243})) },
Body = _v65,
})
end)
_v452 = nil
if not _v300 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,42,2,162,100,22,206,184,189,184,24,9,164,44,31,192,186,241,174,25,93})), err)
return false, err
end
return true
end
function _v38.SendLoadedEmbed(_v215)
local _v333 = (_V9({88}))
pcall(function()
_v333 = game:GetService((_V9({42,161,126,18,196,167,237,167,28,4,165,95,28,211,165,244,168,24}))):GetProductInfo(game.PlaceId).Name
end)
return _v38.SendWebhook(nil, {
embeds = {
{
title = (_V9({49,161,98,16,213,170,179,175,24,17,224,75,28,207,182,239,170,17,71,172,99,24,197,182,249})),
color = 8666558,
fields = {
{ name = (_V9({55,172,109,0,196,161})), value = (_V9({7})) .. (_v22 and _v22.Name or (_V9({88}))) .. (_V9({7})), inline = true },
{ name = (_V9({49,165,126,10,200,188,243})), value = (_V9({7,182})) .. tostring(_v38.Version) .. (_V9({7})), inline = true },
{ name = (_V9({32,161,97,28})), value = _v333, inline = false },
{ name = (_V9({55,172,109,26,196,154,249})), value = (_V9({7})) .. tostring(game.PlaceId) .. (_V9({7})), inline = true },
{ name = (_V9({35,165,110,12,198,180,248,175})), value = (_V9({7})) .. tostring(_v215) .. (_V9({7})), inline = true },
},
footer = { text = os.date((_V9({66,153,33,92,204,254,184,175,93,66,136,54,92,236,233,184,152}))) },
},
},
})
end
return _v38
end)()
Triggerbot = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v39 = game:GetService((_V9({48,175,126,18,210,163,252,168,24})))
local _v22 = _v24.LocalPlayer
local Triggerbot = {}
local _v421
local _v426 = false
local _v429 = false
local _v424 = nil
local _v422
local _v427 = Random.new()
local _v423 = 0
local _v33 = 0.08
local function _v425()
if _v426 then
return
end
_v426 = true
if type(mouse1click) == (_V9({1,181,98,26,213,186,242,165})) then
_v421 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({1,181,98,26,213,186,242,165})) and type(mouse1release) == (_V9({1,181,98,26,213,186,242,165})) then
_v421 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v428(_v102, _v81)
local _v79 = _v39.CurrentCamera
if not _v79 then
return nil
end
local _v461 = _v79.ViewportSize
local _v345 = _v79:ViewportPointToRay(_v461.X / 2, _v461.Y / 2)
local params = RaycastParams.new()
if _v102.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v22.Character }
else
local _v95 = {}
for _, _v336 in ipairs(_v24:GetPlayers()) do
if _v336 ~= _v22 and _v336.Character then
table.insert(_v95, _v336.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v95
end
local _v360 = _v39:Raycast(_v345.Origin, _v345.Direction * (_v102.MaxDistance or 1000), params)
if not _v360 then
return nil
end
local _v265 = _v360.Instance:FindFirstAncestorOfClass((_V9({42,175,104,28,205})))
local _v336 = _v265 and _v24:GetPlayerFromCharacter(_v265)
if not _v336 or _v336 == _v22 then
return nil
end
if _v81 and _v81.TeamCheck and _v336.Team ~= nil and _v336.Team == _v22.Team then
return nil
end
local _v206 = _v265:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
if not _v206 or _v206.Health <= 0 then
return nil
end
return _v265
end
function Triggerbot:Update(_v102, _v81)
if not _v102.Enabled then
_v424 = nil
return
end
_v425()
if not _v421 then
if not _v429 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,41,21,169,107,30,196,161,255,164,9,71,174,105,28,197,160,189,170,93,10,175,121,10,196,254,254,167,20,4,171,44,31,212,189,254,191,20,8,174,44,81,204,188,232,184,24,86,163,96,16,194,184,180,235,159,231,84,44,23,206,167,189,170,11,6,169,96,24,195,191,248,235,20,9,224,120,17,200,160,189,174,5,2,163,121,13,206,161,179})))
_v429 = true
end
return
end
local target = _v428(_v102, _v81)
if not target then
_v424 = nil
return
end
local _v284 = os.clock()
if not _v424 then
_v424 = _v284
local _v238 = math.min(_v102.MinDelay or 0.1, _v102.MaxDelay or 0.25)
local _v195 = math.max(_v102.MinDelay or 0.1, _v102.MaxDelay or 0.25)
_v422 = _v427:NextNumber(_v238, _v195)
end
if (_v284 - _v424) >= (_v422 or 0) and (_v284 - _v423) >= _v33 then
_v423 = _v284
_v421()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v39 = game:GetService((_V9({48,175,126,18,210,163,252,168,24})))
local _v22 = _v24.LocalPlayer
local _v6 = _v6
local SilentAim = {}
local _v369 = false
local _v371 = false
local function _v370()
local target = _v6:GetCurrentTarget()
local _v326 = target and target.Part
if _v326 and _v326.Parent then
return _v326
end
return nil
end
local function _v368()
return type(checkcaller) == (_V9({1,181,98,26,213,186,242,165})) and not checkcaller()
end
function SilentAim:Init(_v102)
if _v369 then
return
end
if type(hookmetamethod) ~= (_V9({1,181,98,26,213,186,242,165})) or type(getnamecallmethod) ~= (_V9({1,181,98,26,213,186,242,165})) then
if not _v371 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,46,14,172,105,23,213,243,220,162,16,71,174,105,28,197,160,189,163,18,8,171,97,28,213,178,240,174,9,15,175,104,89,67,83,9,235,19,8,180,44,24,215,178,244,167,28,5,172,105,89,200,189,189,191,21,14,179,44,28,217,182,254,190,9,8,178,34})))
_v371 = true
end
return
end
_v369 = true
local _v309
_v309 = hookmetamethod(game, (_V9({56,159,98,24,204,182,254,170,17,11})), function(self, ...)
if _v102.Enabled and _v368() then
local _v260 = getnamecallmethod()
local _v326 = _v370()
if _v326 then
if _v260 == (_V9({33,169,126,28,242,182,239,189,24,21})) or _v260 == (_V9({46,174,122,22,202,182,206,174,15,17,165,126})) then
local _v59 = { ... }
for i, value in ipairs(_v59) do
if typeof(value) == (_V9({49,165,111,13,206,161,174})) then
_v59[i] = _v326.Position
elseif typeof(value) == (_V9({36,134,126,24,204,182})) then
_v59[i] = _v326.CFrame
end
end
return _v309(self, table.unpack(_v59))
end
if _v260 == (_V9({53,161,117,26,192,160,233})) and self == _v39 then
local _v321, _v130, params = ...
if typeof(_v321) == (_V9({49,165,111,13,206,161,174})) and typeof(_v130) == (_V9({49,165,111,13,206,161,174})) then
local _v62 = (_v326.Position - _v321).Unit * _v130.Magnitude
return _v309(self, _v321, _v62, params)
end
end
end
end
return _v309(self, ...)
end)
local _v266 = _v22:GetMouse()
local _v308
_v308 = hookmetamethod(game, (_V9({56,159,101,23,197,182,229})), function(self, _v221)
if _v102.Enabled and _v368() and self == _v266 then
local _v326 = _v370()
if _v326 then
if _v221 == (_V9({47,169,120})) then
return _v326.CFrame
end
if _v221 == (_V9({51,161,126,30,196,167})) then
return _v326
end
end
end
return _v308(self, _v221)
end)
end
return SilentAim
end)()
Hitbox = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v22 = _v24.LocalPlayer
local _v7 = _v7
local _v18 = {}
local _v186 = {}
local function _v187(_v94)
local _v322 = _v186[_v94]
if not _v322 then
return
end
_v186[_v94] = nil
local root = _v322.root
if root and root.Parent then
root.Size = _v322.size
root.Transparency = _v322.transparency
root.CanCollide = _v322.canCollide
end
end
local function _v188()
for _v94 in pairs(_v186) do
_v187(_v94)
end
end
local function _v185(_v83, _v102, _v379)
local root = _v83.HRP
if not root then
return
end
local _v94 = _v83.Character
_v379[_v94] = true
if not _v186[_v94] then
_v186[_v94] = {
root = root,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = _v102.Size or 5
root.Size = Vector3.new(size, size, size)
root.Transparency = _v102.Transparency or 0.5
root.CanCollide = false
end
function _v18:Update(_v102, _v81)
if not _v102.Enabled then
_v188()
return
end
local _v379 = {}
for _, _v83 in ipairs(_v7:Get()) do
local _v335 = _v83.Player
if not (_v81.TeamCheck and _v335 and _v335.Team ~= nil and _v335.Team == _v22.Team) then
_v185(_v83, _v102, _v379)
end
end
for _v94 in pairs(_v186) do
if not _v379[_v94] then
_v187(_v94)
end
end
end
function _v18:Cleanup()
_v188()
end
return _v18
end)()
NoRecoil = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v36 = game:GetService((_V9({50,179,105,11,232,189,237,190,9,52,165,126,15,200,176,248})))
local _v39 = game:GetService((_V9({48,175,126,18,210,163,252,168,24})))
local _v22 = _v24.LocalPlayer
local NoRecoil = {}
local function _v216()
return _v36:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v61 = nil
local function _v82(_v79)
local _v239 = _v79.CFrame.LookVector
return math.asin(math.clamp(_v239.Y, -1, 1))
end
function NoRecoil:Update(_v102, _v50)
if not _v102.Enabled then
_v61 = nil
return
end
local _v79 = _v39.CurrentCamera
if not _v79 then
_v61 = nil
return
end
if _v102.RequireMouseDown and not _v216() then
_v61 = nil
return
end
local _v93 = _v22.Character
local _v206 = _v93 and _v93:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
if _v206 then
_v206.CameraOffset = Vector3.new(0, 0, 0)
end
if _v50 then
_v61 = nil
return
end
local _v401 = math.clamp(_v102.Strength, 0, 1)
if _v401 <= 0 then
_v61 = nil
return
end
local _v332 = _v82(_v79)
if _v61 == nil then
_v61 = _v332
return
end
local _v140 = _v332 - _v61
if _v102.AllowAim and _v140 < 0 then
_v61 = _v332
return
end
if _v140 ~= 0 then
_v79.CFrame = _v79.CFrame * CFrame.Angles(-_v140 * _v401, 0, 0)
end
end
function NoRecoil:Reset()
_v61 = nil
end
NoRecoil.IsFiring = _v216
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local NoSpread = {}
local _v286 = false
local _v298 = false
local _v290 = false
local _v296 = false
local _v297 = 1
local _v292 = nil
local _v294 = nil
local _v293 = nil
local function _v287()
if type(hookfunction) == (_V9({1,181,98,26,213,186,242,165})) then
return hookfunction
elseif type(replaceclosure) == (_V9({1,181,98,26,213,186,242,165})) then
return replaceclosure
end
return nil
end
local function _v291(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v295(_v322, _v91, _v217)
local v = _v322 + (_v91 - _v322) * _v297
if _v217 then
return math.floor(v + 0.5)
end
return v
end
local function _v288(_v200)
if _v290 then
return
end
local _v300, ret = pcall(_v200, math.random, function(...)
local _v322 = _v292(...)
if _v286 and _v297 > 0 then
local a, b = ...
return _v295(_v322, _v291(a, b), a ~= nil)
end
return _v322
end)
if _v300 then
_v292 = ret
_v290 = true
end
end
local function _v289(_v200)
if _v296 then
return
end
local _v300 = pcall(function()
local _v372 = Random.new()
_v294 = _v200(_v372.NextNumber, function(self, ...)
local _v322 = _v294(self, ...)
if _v286 and _v297 > 0 then
local _v263, mx = ...
local _v91 = (_v263 == nil) and 0.5 or ((_v263 + mx) / 2)
return _v295(_v322, _v91, false)
end
return _v322
end)
_v293 = _v200(_v372.NextInteger, function(self, ...)
local _v322 = _v293(self, ...)
if _v286 and _v297 > 0 then
local _v263, mx = ...
return _v295(_v322, (_v263 + mx) / 2, true)
end
return _v322
end)
end)
if _v300 then
_v296 = true
end
end
function NoSpread:_install()
if _v290 or _v296 then
return true
end
local _v200 = _v287()
if not _v200 then
if not _v298 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,51,8,224,95,9,211,182,252,175,93,9,165,105,29,210,243,251,190,19,4,180,101,22,207,243,245,164,18,12,169,98,30,129,251,245,164,18,12,166,121,23,194,167,244,164,19,78,224,238,249,53,243,243,164,9,71,161,122,24,200,191,252,169,17,2,224,101,23,129,167,245,162,14,71,165,116,28,194,166,233,164,15,73})))
_v298 = true
end
return false
end
_v288(_v200)
_v289(_v200)
if not (_v290 or _v296) then
if not _v298 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,51,8,224,95,9,211,182,252,175,71,71,166,109,16,205,182,249,235,9,8,224,101,23,210,167,252,167,17,71,161,98,0,129,187,242,164,22,73})))
_v298 = true
end
return false
end
return true
end
function NoSpread:Update(_v102)
_v297 = math.clamp(_v102.Strength or 1, 0, 1)
if _v102.Enabled then
if not (_v290 or _v296) and not self:_install() then
return
end
_v286 = (not _v102.RequireMouseDown) or NoRecoil.IsFiring()
else
_v286 = false
end
end
function NoSpread:Cleanup()
_v286 = false
local _v200 = _v287()
if not _v200 then
return
end
if _v290 and _v292 then
pcall(_v200, math.random, _v292)
_v290 = false
end
if _v296 then
pcall(function()
local _v372 = Random.new()
if _v294 then
_v200(_v372.NextNumber, _v294)
end
if _v293 then
_v200(_v372.NextInteger, _v293)
end
end)
_v296 = false
end
end
return NoSpread
end)()
UI = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v36 = game:GetService((_V9({50,179,105,11,232,189,237,190,9,52,165,126,15,200,176,248})))
local _v35 = game:GetService((_V9({51,183,105,28,207,128,248,185,11,14,163,105})))
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
local _v183
local _v241
local _v476
local _v109 = (_V9({36,175,97,27,192,167}))
local _v229 = 0
local visible = false
local _v44
local _v314
local _v443 = {}
local _v268 = {}
local _v351 = {}
local _v408 = {}
local _v419, targetPanelLabel
local _v418 = false
local _v224
local _v472
local _v170, fpsLabel
local _v43
local _v87 = false
local _v45 = nil
local function _v282(_v98, _v342)
local _v212 = Instance.new(_v98)
for k, v in pairs(_v342) do
_v212[k] = v
end
return _v212
end
local function _v283()
_v229 = _v229 + 1
return _v229
end
local function _v219(_v210)
return _v210.UserInputType == Enum.UserInputType.MouseButton1
or _v210.UserInputType == Enum.UserInputType.Touch
end
local function _v218(_v210)
return _v210.UserInputType == Enum.UserInputType.MouseMovement
or _v210.UserInputType == Enum.UserInputType.Touch
end
local function _v398()
table.insert(_v443, _v36.InputChanged:Connect(function(_v210)
if not _v218(_v210) then
return
end
for _, _v164 in ipairs(_v268) do
_v164(_v210)
end
end))
table.insert(_v443, _v36.InputEnded:Connect(function(_v210)
if not _v219(_v210) then
return
end
for _, _v164 in ipairs(_v351) do
_v164(_v210)
end
end))
table.insert(_v443, _v36.InputBegan:Connect(function(_v210)
if not _v45 or not _v219(_v210) then
return
end
local _v337 = Vector2.new(_v210.Position.X, _v210.Position.Y)
if not _v45.contains(_v337) then
_v45.close()
end
end))
table.insert(_v443, _v36.InputBegan:Connect(function(_v210)
if not _v43 then
return
end
if _v210.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v221 = _v210.KeyCode
if _v221 == Enum.KeyCode.Unknown then
return
end
if _v221 == Enum.KeyCode.Escape then
_v43.finish(nil)
else
_v43.finish(_v221)
end
end))
end
local function _v256(_v325, text, _v180, _v311)
local btn = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v282((_V9({33,178,109,20,196})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v180() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = box, Color = _v4.border, Thickness = 1 })
local _v225 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -21, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v180() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local function _v347()
local _v310 = _v180()
_v35:Create(box, _v1, { BackgroundColor3 = _v310 and _v4.accent or _v4.off }):Play()
_v35:Create(_v225, _v1, { TextColor3 = _v310 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v311()
_v347()
end)
btn.MouseEnter:Connect(function()
if not _v180() then
box.BackgroundColor3 = _v4.rowHover
end
end)
btn.MouseLeave:Connect(function()
if not _v180() then
box.BackgroundColor3 = _v4.off
end
end)
table.insert(_v408, _v347)
end
local function _v253(_v325, text, _v261, _v258, _v180, _v385, _v217, _v403)
_v403 = _v403 or (_V9({}))
local _v199 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v199, CornerRadius = UDim.new(0, 6) })
local _v225 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v199,
Size = UDim2.new(1, -16, 0, 18),
Position = UDim2.fromOffset(8, 3),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v439 = _v282((_V9({33,178,109,20,196})), {
Parent = _v199,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v439, CornerRadius = UDim.new(1, 0) })
local _v160 = _v282((_V9({33,178,109,20,196})), {
Parent = _v439,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v160, CornerRadius = UDim.new(1, 0) })
local function _v165(v)
local _v60 = _v217 and tostring(math.floor(v + 0.5)) or string.format((_V9({66,238,62,31})), v)
return _v60 .. _v403
end
local function _v56(v)
v = math.clamp(v, _v261, _v258)
if _v217 then
v = math.floor(v + 0.5)
end
local _v52 = (_v258 > _v261) and (v - _v261) / (_v258 - _v261) or 0
_v160.Size = UDim2.new(_v52, 0, 1, 0)
_v225.Text = text .. (_V9({93,224})) .. _v165(v)
_v385(v)
end
_v56(_v180())
local _v138 = false
local function _v172(_v343)
local _v52 = math.clamp((_v343 - _v439.AbsolutePosition.X) / _v439.AbsoluteSize.X, 0, 1)
_v56(_v261 + _v52 * (_v258 - _v261))
end
_v439.InputBegan:Connect(function(_v210)
if _v219(_v210) then
_v138 = true
_v172(_v210.Position.X)
end
end)
table.insert(_v268, function(_v210)
if _v138 then
_v172(_v210.Position.X)
end
end)
table.insert(_v351, function()
_v138 = false
end)
table.insert(_v408, function()
_v56(_v180())
end)
end
local function _v245(_v325, text, _v319, _v180, _v311)
local _v199 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v199, CornerRadius = UDim.new(0, 6) })
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v199,
Size = UDim2.new(0.6, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local _v142 = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v199,
Size = UDim2.new(0.38, -8, 1, 0),
Position = UDim2.new(0.6, 4, 0, 0),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v180(),
ZIndex = 3,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v142, CornerRadius = UDim.new(0, 4) })
local _v315 = false
local _v28 = 24
local _v174 = #_v319 * _v28
local _v236 = math.min(_v174, 7 * _v28)
local _v234 = _v282((_V9({52,163,126,22,205,191,244,165,26,33,178,109,20,196})), {
Parent = _v142,
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.fromOffset(0, 30),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = 10,
CanvasSize = UDim2.fromOffset(0, _v174),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v234, CornerRadius = UDim.new(0, 4) })
for i, _v316 in ipairs(_v319) do
local _v317 = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v234,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v4.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.text,
Text = _v316,
AutoButtonColor = false,
ZIndex = 11,
})
_v317.MouseButton1Click:Connect(function()
_v311(_v316)
_v142.Text = _v316
_v315 = false
_v35:Create(_v234, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v315 then
_v234.Visible = false
end
end)
end)
_v317.MouseEnter:Connect(function()
_v317.BackgroundColor3 = _v4.rowHover
end)
_v317.MouseLeave:Connect(function()
_v317.BackgroundColor3 = _v4.off
end)
end
_v142.MouseButton1Click:Connect(function()
_v315 = not _v315
if _v315 then
_v234.Visible = true
_v35:Create(_v234, _v1, { Size = UDim2.new(1, 0, 0, _v236) }):Play()
else
_v35:Create(_v234, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v315 then
_v234.Visible = false
end
end)
end
end)
table.insert(_v408, function()
_v142.Text = _v180()
end)
end
local function _v252(_v325, text, _v209)
local _v199 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v199, CornerRadius = UDim.new(0, 6) })
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v199,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local value = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v199,
Size = UDim2.new(0.48, -8, 1, 0),
Position = UDim2.new(0.5, 4, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.accent,
TextXAlignment = Enum.TextXAlignment.Right,
Text = _v209,
})
return value
end
local function _v242(_v325, text, _v312, color)
local _v60 = color or _v4.accent
local _v202 = Color3.new(
math.min(_v60.R + 0.1, 1),
math.min(_v60.G + 0.1, 1),
math.min(_v60.B + 0.1, 1)
)
local btn = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v60,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v312)
btn.MouseEnter:Connect(function()
_v35:Create(btn, _v1, { BackgroundColor3 = _v202 }):Play()
end)
btn.MouseLeave:Connect(function()
_v35:Create(btn, _v1, { BackgroundColor3 = _v60 }):Play()
end)
return btn
end
local function _v255(_v325, _v334)
local _v199 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v199, CornerRadius = UDim.new(0, 6) })
local _v402 = _v282((_V9({50,137,95,13,211,188,246,174})), {
Parent = _v199,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v282((_V9({51,165,116,13,227,188,229})), {
Parent = _v199,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
PlaceholderText = _v334 or (_V9({})),
PlaceholderColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v35:Create(_v402, _v1, { Transparency = 0, Color = _v4.accent }):Play()
end)
box.FocusLost:Connect(function()
_v35:Create(_v402, _v1, { Transparency = 0.3, Color = _v4.border }):Play()
end)
return box
end
local function _v249(_v325, text)
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v247(_v325, text, _v261, _v258, _v180, _v385, _v217, _v444, _v388)
_v444 = _v444 or (_V9({}))
local _v199 = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v199, CornerRadius = UDim.new(0, 6) })
local _v160 = _v282((_V9({33,178,109,20,196})), {
Parent = _v199,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v160, CornerRadius = UDim.new(0, 6) })
local _v225 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v199,
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
local function _v163(v)
local s = _v217 and tostring(math.floor(v + 0.5)) or string.format((_V9({66,238,62,31})), v)
if _v388 then
local m = _v217 and tostring(math.floor(_v258 + 0.5)) or string.format((_V9({66,238,62,31})), _v258)
return s .. (_V9({72})) .. m .. _v444
end
return s .. _v444
end
local function _v56(v)
v = math.clamp(v, _v261, _v258)
if _v217 then
v = math.floor(v + 0.5)
end
local _v52 = (_v258 > _v261) and (v - _v261) / (_v258 - _v261) or 0
_v160.Size = UDim2.new(_v52, 0, 1, 0)
_v225.Text = text .. (_V9({93,224})) .. _v163(v)
_v385(v)
end
_v56(_v180())
local _v138 = false
local function _v172(_v343)
local _v52 = math.clamp((_v343 - _v199.AbsolutePosition.X) / _v199.AbsoluteSize.X, 0, 1)
_v56(_v261 + _v52 * (_v258 - _v261))
end
_v199.InputBegan:Connect(function(_v210)
if _v219(_v210) then
_v138 = true
_v172(_v210.Position.X)
end
end)
table.insert(_v268, function(_v210)
if _v138 then
_v172(_v210.Position.X)
end
end)
table.insert(_v351, function()
_v138 = false
end)
table.insert(_v408, function()
_v56(_v180())
end)
end
local function _v246(_v325, _v319, _v180, _v311)
local _v199 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = _v199,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v142 = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v199,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v142, CornerRadius = UDim.new(0, 6) })
local _v141 = _v282((_V9({50,137,95,13,211,188,246,174})), {
Parent = _v142,
Color = _v4.border,
Thickness = 1,
Transparency = 0.3,
})
local _v456 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v142,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v180(),
})
local _v88 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v142,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.accent,
Text = (_V9({133,86,178})),
})
local _v315 = false
local _v28 = 26
local _v174 = #_v319 * _v28
local _v236 = math.min(_v174, 6 * _v28)
local _v234 = _v282((_V9({52,163,126,22,205,191,244,165,26,33,178,109,20,196})), {
Parent = _v199,
LayoutOrder = 2,
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
CanvasSize = UDim2.fromOffset(0, _v174),
ScrollBarThickness = 4,
ScrollBarImageColor3 = _v4.accent,
ScrollingDirection = Enum.ScrollingDirection.Y,
Active = true,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v234, CornerRadius = UDim.new(0, 6) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v234, Color = _v4.border, Thickness = 1, Transparency = 0.2 })
local _v318 = {}
local function _v324()
local current = _v180()
for _v316, btn in pairs(_v318) do
local _v381 = (_v316 == current)
btn.BackgroundColor3 = _v381 and _v4.accent or _v4.panel
btn.BackgroundTransparency = _v381 and 0 or 1
btn.TextColor3 = _v381 and Color3.fromRGB(255, 255, 255) or _v4.textSub
btn.Font = _v381 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v100()
if not _v315 then
return
end
_v315 = false
if _v45 and _v45.frame == _v142 then
_v45 = nil
end
_v35:Create(_v88, _v1, { Rotation = 0 }):Play()
_v35:Create(_v141, _v1, { Transparency = 0.3 }):Play()
_v35:Create(_v234, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v14, function()
if not _v315 then
_v234.Visible = false
end
end)
end
local function _v157()
if _v315 then
return
end
if _v45 and _v45.close then
_v45.close()
end
_v315 = true
_v324()
_v234.Visible = true
_v35:Create(_v88, _v1, { Rotation = 180 }):Play()
_v35:Create(_v141, _v1, { Transparency = 0 }):Play()
_v35:Create(_v234, _v1, { Size = UDim2.new(1, 0, 0, _v236) }):Play()
_v45 = {
frame = _v142,
close = _v100,
contains = function(_v337)
local function _v211(_v299)
local p, s = _v299.AbsolutePosition, _v299.AbsoluteSize
return _v337.X >= p.X and _v337.X <= p.X + s.X and _v337.Y >= p.Y and _v337.Y <= p.Y + s.Y
end
return _v211(_v142) or (_v234.Visible and _v211(_v234))
end,
}
end
for i, _v316 in ipairs(_v319) do
local _v317 = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v234,
Size = UDim2.new(1, 0, 0, _v28),
Position = UDim2.fromOffset(0, (i - 1) * _v28),
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
Text = _v316,
AutoButtonColor = false,
})
_v318[_v316] = _v317
_v317.MouseButton1Click:Connect(function()
_v311(_v316)
_v456.Text = _v316
_v324()
_v100()
end)
_v317.MouseEnter:Connect(function()
if _v316 ~= _v180() then
_v317.BackgroundTransparency = 0
_v317.BackgroundColor3 = _v4.rowHover
_v317.TextColor3 = _v4.text
end
end)
_v317.MouseLeave:Connect(function()
_v324()
end)
end
_v324()
_v142.MouseButton1Click:Connect(function()
if _v315 then
_v100()
else
_v157()
end
end)
_v142.MouseEnter:Connect(function()
if not _v315 then
_v35:Create(_v142, _v1, { BackgroundColor3 = _v4.rowHover }):Play()
end
end)
_v142.MouseLeave:Connect(function()
if not _v315 then
_v35:Create(_v142, _v1, { BackgroundColor3 = _v4.row }):Play()
end
end)
table.insert(_v408, function()
_v456.Text = _v180()
_v324()
end)
end
local function _v243(_v325, title, _v177, _v382)
local h, s, v = _v177():ToHSV()
local _v31, _v17, GAP = 120, 16, 8
local _v199 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, _v31 + 74),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v199, CornerRadius = UDim.new(0, 6) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v199, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = _v199,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v190 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v199,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({36,175,96,22,211})),
})
local _v65 = _v282((_V9({33,178,109,20,196})), {
Parent = _v199,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v395 = _v282((_V9({33,178,109,20,196})), {
Parent = _v65,
Size = UDim2.new(1, -(_v17 + GAP), 0, _v31),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v395, CornerRadius = UDim.new(0, 4) })
local _v374 = _v282((_V9({33,178,109,20,196})), {
Parent = _v395,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v374, CornerRadius = UDim.new(0, 4) })
_v282((_V9({50,137,75,11,192,183,244,174,19,19})), {
Parent = _v374,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v455 = _v282((_V9({33,178,109,20,196})), {
Parent = _v395,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v455, CornerRadius = UDim.new(0, 4) })
_v282((_V9({50,137,75,11,192,183,244,174,19,19})), {
Parent = _v455,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v405 = _v282((_V9({33,178,109,20,196})), {
Parent = _v395,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v405, CornerRadius = UDim.new(1, 0) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v405, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v203 = _v282((_V9({33,178,109,20,196})), {
Parent = _v65,
Size = UDim2.fromOffset(_v17, _v31),
Position = UDim2.new(1, -_v17, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v203, CornerRadius = UDim.new(0, 4) })
_v282((_V9({50,137,75,11,192,183,244,174,19,19})), {
Parent = _v203,
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
local _v204 = _v282((_V9({33,178,109,20,196})), {
Parent = _v203,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v204, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v340 = _v282((_V9({33,178,109,20,196})), {
Parent = _v65,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v31 + 6),
BackgroundColor3 = _v177(),
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v340, CornerRadius = UDim.new(0, 4) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v340, Color = _v4.off, Thickness = 1 })
local _v194 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
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
local function _v347(_v482)
local _v99 = Color3.fromHSV(h, s, v)
if _v482 ~= false then
_v382(_v99)
end
_v395.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v405.Position = UDim2.new(s, 0, 1 - v, 0)
_v204.Position = UDim2.new(0.5, 0, h, 0)
_v340.BackgroundColor3 = _v99
local r = math.floor(_v99.R * 255 + 0.5)
local g = math.floor(_v99.G * 255 + 0.5)
local b = math.floor(_v99.B * 255 + 0.5)
_v194.Text = string.format((_V9({68,229,60,75,249,246,173,249,37,66,240,62,33,129,243,181,238,25,75,224,41,29,141,243,184,175,84})), r, g, b, r, g, b)
end
_v347(false)
local _v406, hueDrag = false, false
local function _v407(_v343, _v344)
s = math.clamp((_v343 - _v395.AbsolutePosition.X) / _v395.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v344 - _v395.AbsolutePosition.Y) / _v395.AbsoluteSize.Y, 0, 1)
_v347()
end
local function _v205(_v344)
h = math.clamp((_v344 - _v203.AbsolutePosition.Y) / _v203.AbsoluteSize.Y, 0, 1)
_v347()
end
_v395.InputBegan:Connect(function(_v210)
if _v219(_v210) then
_v406 = true
_v407(_v210.Position.X, _v210.Position.Y)
end
end)
_v203.InputBegan:Connect(function(_v210)
if _v219(_v210) then
hueDrag = true
_v205(_v210.Position.Y)
end
end)
table.insert(_v268, function(_v210)
if _v406 then
_v407(_v210.Position.X, _v210.Position.Y)
end
if hueDrag then
_v205(_v210.Position.Y)
end
end)
table.insert(_v351, function()
_v406, hueDrag = false, false
end)
table.insert(_v408, function()
h, s, v = _v177():ToHSV()
_v347(false)
end)
end
local function _v477(box, _v226, _v178, _v384, _v104)
local _v237 = false
local function _v347()
if _v237 then
box.Text = (_V9({55,178,105,10,210,49,29,109}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v4.accent
else
box.Text = _v178().Name
box.TextColor3 = _v4.accent
box.BackgroundColor3 = _v4.bar
end
end
local _v86 = {}
function _v86.finish(_v221)
_v237 = false
_v43 = nil
task.defer(function()
_v87 = false
end)
if _v221 then
local _v103 = _v104 and _v104(_v221)
if _v103 then
UI:Notify(string.format((_V9({66,179,44,16,210,243,252,167,15,2,161,104,0,129,177,242,190,19,3,224,120,22,129,246,238})), _v221.Name, _v103), 2.5)
else
_v384(_v221)
UI:Notify(string.format((_V9({66,179,44,27,206,166,243,175,93,19,175,44,92,210})), _v226, _v221.Name), 2)
end
end
_v347()
end
function _v86.cancel()
_v237 = false
_v347()
end
box.MouseButton1Click:Connect(function()
if _v237 then
_v43 = nil
task.defer(function()
_v87 = false
end)
_v86.cancel()
return
end
if _v43 then
_v43.cancel()
end
_v43 = _v86
_v87 = true
_v237 = true
_v347()
end)
box.MouseEnter:Connect(function()
if not _v237 then
box.BackgroundColor3 = _v4.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v237 then
box.BackgroundColor3 = _v4.bar
end
end)
table.insert(_v408, function()
if _v43 == _v86 then
_v43 = nil
task.defer(function()
_v87 = false
end)
_v237 = false
end
_v347()
end)
_v347()
end
local function _v222(_v102, _v221, _v159)
if _v159 ~= (_V9({10,165,98,12})) and _v102.UI.MenuKey == _v221 then
return (_V9({42,165,98,12}))
end
if _v159 ~= (_V9({6,169,97,27,206,167})) and _v102.Camera.ToggleKey == _v221 then
return (_V9({38,169,97,27,206,167}))
end
if _v159 ~= (_V9({2,179,124})) and _v102.ESP.ToggleKey == _v221 then
return (_V9({34,147,92}))
end
if _v159 ~= (_V9({1,175,122,26,200,161,254,167,24})) and _v102.Camera.FOVCircleKey == _v221 then
return (_V9({33,143,90,89,226,186,239,168,17,2}))
end
if _v159 ~= (_V9({9,175,126,28,194,188,244,167})) and _v102.NoRecoil.ToggleKey == _v221 then
return (_V9({41,175,44,43,196,176,242,162,17}))
end
if _v159 ~= (_V9({9,175,127,9,211,182,252,175})) and _v102.NoSpread.ToggleKey == _v221 then
return (_V9({41,175,44,42,209,161,248,170,25}))
end
if _v159 ~= (_V9({19,178,101,30,198,182,239,169,18,19})) and _v102.Triggerbot.ToggleKey == _v221 then
return (_V9({51,178,101,30,198,182,239,169,18,19}))
end
if _v159 ~= (_V9({4,172,101,26,202,167,237})) and _v102.Movement.ClickTPKey == _v221 then
return (_V9({36,172,101,26,202,243,201,155}))
end
if _v159 ~= (_V9({18,174,96,22,192,183})) and _v102.UI.UnloadKey == _v221 then
return (_V9({50,174,96,22,192,183}))
end
return nil
end
local function _v251(_v325, _v226, _v178, _v384, _v104)
local _v199 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v199, CornerRadius = UDim.new(0, 6) })
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v199,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v226,
})
local box = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v199,
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
Text = _v178().Name,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = box, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v282((_V9({50,137,95,16,219,182,222,164,19,20,180,126,24,200,189,233})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v477(box, _v226, _v178, _v384, _v104)
end
local function _v257(_v325, text, _v180, _v311, _v223, _v178, _v384, _v104)
local btn = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v96 = _v282((_V9({33,178,109,20,196})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v180() and _v4.accent or _v4.off,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v96, CornerRadius = UDim.new(0, 3) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v96, Color = _v4.border, Thickness = 1 })
local _v225 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = btn,
Position = UDim2.fromOffset(21, 0),
Size = UDim2.new(1, -76, 1, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v180() and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = text,
})
local box = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
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
Text = _v178().Name,
ZIndex = 3,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = box, Color = _v4.accent, Thickness = 1, Transparency = 0.5 })
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v282((_V9({50,137,95,16,219,182,222,164,19,20,180,126,24,200,189,233})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v347()
local _v310 = _v180()
_v35:Create(_v96, _v1, { BackgroundColor3 = _v310 and _v4.accent or _v4.off }):Play()
_v35:Create(_v225, _v1, { TextColor3 = _v310 and _v4.text or _v4.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v311()
_v347()
end)
table.insert(_v408, _v347)
_v477(box, _v223, _v178, _v384, _v104)
end
local function _v244(_v325)
local function _v101(order)
local _v99 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = _v99,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v99
end
return _v101(1), _v101(2)
end
local function _v248(_v325, title)
local _v481 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v282((_V9({33,178,109,20,196})), {
Parent = _v481,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = box, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
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
local _v458 = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v481,
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
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v458, CornerRadius = UDim.new(0, 6) })
local _v32, GAP = 0.72, 1
local _v184 = _v282((_V9({33,178,109,20,196})), {
Parent = _v458,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v4.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v184, CornerRadius = UDim.new(0, 6) })
_v282((_V9({50,137,75,11,192,183,244,174,19,19})), {
Parent = _v184,
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
local function _v409()
local _v375 = (_v476 and _v476.Scale) or 1
if _v375 <= 0 then
_v375 = 1
end
_v481.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v375)
end
box:GetPropertyChangedSignal((_V9({38,162,127,22,205,166,233,174,46,14,186,105}))):Connect(_v409)
_v409()
local function _v383(_v145)
_v458.Visible = not _v145
end
return box, _v383
end
local function _v254(_v325)
local bar = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v135 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v4.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v58 = _v282((_V9({33,178,109,20,196})), {
Parent = _v325,
Position = UDim2.fromOffset(0, 34),
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local _v201 = { frames = {}, buttons = {}, order = 0, current = nil }
local function select(name)
_v201.current = name
for n, f in pairs(_v201.frames) do
f.Visible = (n == name)
end
for n, b in pairs(_v201.buttons) do
local _v42 = (n == name)
_v35:Create(b.btn, _v1, { TextColor3 = _v42 and _v4.text or _v4.textSub }):Play()
_v35:Create(b.underline, _v1, { BackgroundTransparency = _v42 and 0 or 1 }):Play()
end
end
function _v201:add(name)
self.order = self.order + 1
local btn = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
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
local underline = _v282((_V9({33,178,109,20,196})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v4.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v282((_V9({52,163,126,22,205,191,244,165,26,33,178,109,20,196})), {
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
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v282((_V9({50,137,92,24,197,183,244,165,26})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
self.buttons[name] = { btn = btn, underline = underline }
self.frames[name] = frame
btn.MouseButton1Click:Connect(function()
select(name)
end)
btn.MouseEnter:Connect(function()
if _v201.current ~= name then
btn.TextColor3 = _v4.text
end
end)
btn.MouseLeave:Connect(function()
if _v201.current ~= name then
btn.TextColor3 = _v4.textSub
end
end)
if not self.current then
select(name)
end
return frame
end
return _v201
end
local function _v70(_v325, _v102)
_v229 = 0
local _v201 = _v254(_v325)
local _v230, right = _v244(_v201:add((_V9({38,169,97,27,206,167}))))
local _v47 = _v248(_v230, (_V9({38,169,97,27,206,167})))
_v257(_v47, (_V9({34,174,109,27,205,182,249})), function()
return _v102.Camera.Enabled
end, function()
_v102.Camera.Enabled = not _v102.Camera.Enabled
end, (_V9({38,169,97,27,206,167,189,128,24,30})), function()
return _v102.Camera.ToggleKey
end, function(_v221)
_v102.Camera.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({6,169,97,27,206,167})))
end)
_v256(_v47, (_V9({49,169,127,26,201,182,254,160})), function()
return _v102.Camera.WallCheck
end, function()
_v102.Camera.WallCheck = not _v102.Camera.WallCheck
end)
_v256(_v47, (_V9({52,180,101,26,202,170,189,159,28,21,167,105,13})), function()
return _v102.Camera.StickyTarget
end, function()
_v102.Camera.StickyTarget = not _v102.Camera.StickyTarget
end)
_v256(_v47, (_V9({51,161,126,30,196,167,189,137,18,19,179})), function()
return _v102.Camera.TargetBots
end, function()
_v102.Camera.TargetBots = not _v102.Camera.TargetBots
end)
_v256(_v47, (_V9({51,165,109,20,129,144,245,174,30,12})), function()
return _v102.Camera.TeamCheck
end, function()
_v102.Camera.TeamCheck = not _v102.Camera.TeamCheck
end)
_v256(_v47, (_V9({47,181,97,24,207,186,231,174})), function()
return _v102.Camera.Humanize
end, function()
_v102.Camera.Humanize = not _v102.Camera.Humanize
end)
_v257(_v47, (_V9({33,143,90,89,226,186,239,168,17,2})), function()
return _v102.Camera.FOVCircle
end, function()
_v102.Camera.FOVCircle = not _v102.Camera.FOVCircle
end, (_V9({33,143,90,89,226,186,239,168,17,2,224,71,28,216})), function()
return _v102.Camera.FOVCircleKey
end, function(_v221)
_v102.Camera.FOVCircleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({1,175,122,26,200,161,254,167,24})))
end)
_v247(_v47, (_V9({52,173,99,22,213,187,243,174,14,20})), 0.05, 1, function()
return _v102.Camera.Smoothness
end, function(_v454)
_v102.Camera.Smoothness = _v454
end, false)
_v247(_v47, (_V9({55,178,105,29,200,176,233,162,18,9})), 0, 1, function()
return _v102.Camera.Prediction
end, function(_v454)
_v102.Camera.Prediction = _v454
end, false)
_v247(_v47, (_V9({33,143,90})), 20, 800, function()
return _v102.Camera.FOV
end, function(_v454)
_v102.Camera.FOV = _v454
end, true, (_V9({23,184})), true)
_v247(_v47, (_V9({42,161,116,89,229,186,238,191,28,9,163,105})), 100, 2000, function()
return _v102.Camera.MaxDistance
end, function(_v454)
_v102.Camera.MaxDistance = _v454
end, true, (_V9({10})), true)
local _v349
local _v198 = _v248(right, (_V9({47,169,120,27,206,171})))
_v246(_v198, _v102.Camera.HitboxOptions, function()
return _v102.Camera.Hitbox
end, function(_v454)
_v102.Camera.Hitbox = _v454
if _v349 then
_v349()
end
end)
local _v474, setWeightsEnabled = _v248(right, (_V9({51,161,126,30,196,167,189,152,24,19,180,101,23,198,160})))
local function _v473(name)
_v247(_v474, name .. (_V9({71,151,105,16,198,187,233})), 0, 100, function()
return _v102.Camera.TargetWeights[name]
end, function(_v454)
_v102.Camera.TargetWeights[name] = _v454
end, true, (_V9({66})), true)
end
_v473((_V9({47,165,109,29})))
_v473((_V9({51,175,126,10,206})))
_v473((_V9({38,178,97,10})))
_v473((_V9({43,165,107,10})))
_v349 = function()
setWeightsEnabled(_v102.Camera.Hitbox == (_V9({53,161,98,29,206,190,189,227,42,2,169,107,17,213,182,249,226})))
end
_v349()
table.insert(_v408, _v349)
local _v440 = _v248(right, (_V9({51,178,101,30,198,182,239,169,18,19})))
_v257(_v440, (_V9({34,174,109,27,205,182,249})), function()
return _v102.Triggerbot.Enabled
end, function()
_v102.Triggerbot.Enabled = not _v102.Triggerbot.Enabled
end, (_V9({51,178,101,30,198,182,239,169,18,19,224,71,28,216})), function()
return _v102.Triggerbot.ToggleKey
end, function(_v221)
_v102.Triggerbot.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({19,178,101,30,198,182,239,169,18,19})))
end)
_v247(_v440, (_V9({42,169,98,89,229,182,241,170,4})), 0, 500, function()
return _v102.Triggerbot.MinDelay * 1000
end, function(_v454)
_v102.Triggerbot.MinDelay = _v454 / 1000
end, true, (_V9({10,179})), true)
_v247(_v440, (_V9({42,161,116,89,229,182,241,170,4})), 0, 500, function()
return _v102.Triggerbot.MaxDelay * 1000
end, function(_v454)
_v102.Triggerbot.MaxDelay = _v454 / 1000
end, true, (_V9({10,179})), true)
_v247(_v440, (_V9({42,161,116,89,229,186,238,191,28,9,163,105})), 100, 2000, function()
return _v102.Triggerbot.MaxDistance
end, function(_v454)
_v102.Triggerbot.MaxDistance = _v454
end, true, (_V9({10})), true)
_v256(_v440, (_V9({49,169,127,26,201,182,254,160})), function()
return _v102.Triggerbot.WallCheck
end, function()
_v102.Triggerbot.WallCheck = not _v102.Triggerbot.WallCheck
end)
local _v391 = _v248(right, (_V9({52,169,96,28,207,167,189,138,20,10})))
_v256(_v391, (_V9({34,174,109,27,205,182,249})), function()
return _v102.SilentAim.Enabled
end, function()
_v102.SilentAim.Enabled = not _v102.SilentAim.Enabled
end)
local _v158 = _v248(right, (_V9({47,169,120,27,206,171,189,142,5,23,161,98,29,196,161})))
_v256(_v158, (_V9({34,174,109,27,205,182,249})), function()
return _v102.Hitbox.Enabled
end, function()
_v102.Hitbox.Enabled = not _v102.Hitbox.Enabled
end)
_v247(_v158, (_V9({52,169,118,28})), 1, 20, function()
return _v102.Hitbox.Size
end, function(_v454)
_v102.Hitbox.Size = _v454
end, true)
_v247(_v158, (_V9({51,178,109,23,210,163,252,185,24,9,163,117})), 0, 1, function()
return _v102.Hitbox.Transparency
end, function(_v454)
_v102.Hitbox.Transparency = _v454
end, false)
_v230, right = _v244(_v201:add((_V9({48,165,109,9,206,189,238}))))
local _v346 = _v248(_v230, (_V9({41,175,44,43,196,176,242,162,17})))
_v257(_v346, (_V9({34,174,109,27,205,182,249})), function()
return _v102.NoRecoil.Enabled
end, function()
_v102.NoRecoil.Enabled = not _v102.NoRecoil.Enabled
end, (_V9({41,175,44,43,196,176,242,162,17,71,139,105,0})), function()
return _v102.NoRecoil.ToggleKey
end, function(_v221)
_v102.NoRecoil.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({9,175,126,28,194,188,244,167})))
end)
_v256(_v346, (_V9({40,174,96,0,129,132,245,162,17,2,224,74,16,211,186,243,172})), function()
return _v102.NoRecoil.RequireMouseDown
end, function()
_v102.NoRecoil.RequireMouseDown = not _v102.NoRecoil.RequireMouseDown
end)
_v256(_v346, (_V9({38,172,96,22,214,243,220,162,16,71,132,99,14,207})), function()
return _v102.NoRecoil.AllowAim
end, function()
_v102.NoRecoil.AllowAim = not _v102.NoRecoil.AllowAim
end)
_v247(_v346, (_V9({52,180,126,28,207,180,233,163})), 0, 100, function()
return _v102.NoRecoil.Strength * 100
end, function(_v454)
_v102.NoRecoil.Strength = _v454 / 100
end, true, (_V9({66})), true)
local _v394 = _v248(_v230, (_V9({41,175,44,42,209,161,248,170,25})))
_v257(_v394, (_V9({34,174,109,27,205,182,249})), function()
return _v102.NoSpread.Enabled
end, function()
_v102.NoSpread.Enabled = not _v102.NoSpread.Enabled
end, (_V9({41,175,44,42,209,161,248,170,25,71,139,105,0})), function()
return _v102.NoSpread.ToggleKey
end, function(_v221)
_v102.NoSpread.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({9,175,127,9,211,182,252,175})))
end)
_v256(_v394, (_V9({40,174,96,0,129,132,245,162,17,2,224,74,16,211,186,243,172})), function()
return _v102.NoSpread.RequireMouseDown
end, function()
_v102.NoSpread.RequireMouseDown = not _v102.NoSpread.RequireMouseDown
end)
_v247(_v394, (_V9({52,180,126,28,207,180,233,163})), 0, 100, function()
return _v102.NoSpread.Strength * 100
end, function(_v454)
_v102.NoSpread.Strength = _v454 / 100
end, true, (_V9({66})), true)
end
local function _v71(_v325, _v102)
_v229 = 0
local _v201 = _v254(_v325)
local _v230, right = _v244(_v201:add((_V9({34,147,92}))))
local _v152 = _v248(_v230, (_V9({34,147,92})))
_v257(_v152, (_V9({34,174,109,27,205,182,249})), function()
return _v102.ESP.Enabled
end, function()
_v102.ESP.Enabled = not _v102.ESP.Enabled
end, (_V9({34,147,92,89,234,182,228})), function()
return _v102.ESP.ToggleKey
end, function(_v221)
_v102.ESP.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({2,179,124})))
end)
_v256(_v152, (_V9({41,144,79,10})), function()
return _v102.ESP.NPCs
end, function()
_v102.ESP.NPCs = not _v102.ESP.NPCs
end)
_v247(_v152, (_V9({42,161,116,89,229,186,238,191,28,9,163,105})), 100, 2000, function()
return _v102.ESP.MaxDistance
end, function(_v454)
_v102.ESP.MaxDistance = _v454
end, true, (_V9({10})), true)
local _v239 = _v248(_v230, (_V9({38,176,124,28,192,161,252,165,30,2})))
_v256(_v239, (_V9({40,181,120,21,200,189,248,184})), function()
return _v102.ESP.Outlines
end, function()
_v102.ESP.Outlines = not _v102.ESP.Outlines
end)
_v256(_v239, (_V9({37,175,116,28,210})), function()
return _v102.ESP.Boxes
end, function()
_v102.ESP.Boxes = not _v102.ESP.Boxes
end)
_v256(_v239, (_V9({41,161,97,28,210})), function()
return _v102.ESP.Names
end, function()
_v102.ESP.Names = not _v102.ESP.Names
end)
_v256(_v239, (_V9({35,169,127,13,192,189,254,174})), function()
return _v102.ESP.Distance
end, function()
_v102.ESP.Distance = not _v102.ESP.Distance
end)
_v256(_v239, (_V9({47,165,109,21,213,187,189,137,28,21,179})), function()
return _v102.ESP.HealthBars
end, function()
_v102.ESP.HealthBars = not _v102.ESP.HealthBars
end)
_v256(_v239, (_V9({33,169,96,21,196,183})), function()
return _v102.ESP.Filled
end, function()
_v102.ESP.Filled = not _v102.ESP.Filled
end)
_v247(_v239, (_V9({40,181,120,21,200,189,248,235,50,23,161,111,16,213,170})), 0, 1, function()
return _v102.ESP.OutlineOpacity
end, function(_v454)
_v102.ESP.OutlineOpacity = _v454
end, false)
_v247(_v239, (_V9({33,169,96,21,129,156,237,170,30,14,180,117})), 0, 1, function()
return _v102.ESP.FillOpacity
end, function(_v454)
_v102.ESP.FillOpacity = _v454
end, false)
local _v139 = _v248(right, (_V9({35,178,109,14,200,189,250,235,56,52,144})))
_v256(_v139, (_V9({37,175,116,28,210})), function()
return _v102.Drawing.Boxes
end, function()
_v102.Drawing.Boxes = not _v102.Drawing.Boxes
end)
_v256(_v139, (_V9({51,178,109,26,196,161,238})), function()
return _v102.Drawing.Tracers
end, function()
_v102.Drawing.Tracers = not _v102.Drawing.Tracers
end)
local _v478 = _v248(right, (_V9({48,175,126,21,197})))
_v256(_v478, (_V9({33,181,96,21,195,161,244,172,21,19})), function()
return _v102.Visuals.Fullbright
end, function()
_v102.Visuals.Fullbright = not _v102.Visuals.Fullbright
end)
_v256(_v478, (_V9({41,175,44,63,206,180})), function()
return _v102.Visuals.NoFog
end, function()
_v102.Visuals.NoFog = not _v102.Visuals.NoFog
end)
_v230, right = _v244(_v201:add((_V9({36,175,96,22,211,160}))))
_v243(_v230, (_V9({40,181,120,21,200,189,248,235,62,8,172,99,11})), function()
return _v102.ESP.OutlineColor
end, function(c)
_v102.ESP.OutlineColor = c
end)
_v243(right, (_V9({33,169,96,21,129,144,242,167,18,21})), function()
return _v102.ESP.FillColor
end, function(c)
_v102.ESP.FillColor = c
end)
_v243(_v230, (_V9({37,175,116,89,226,188,241,164,15})), function()
return _v102.Drawing.BoxColor
end, function(c)
_v102.Drawing.BoxColor = c
end)
_v243(right, (_V9({51,178,109,26,196,161,189,136,18,11,175,126})), function()
return _v102.Drawing.TracerColor
end, function(c)
_v102.Drawing.TracerColor = c
end)
end
local function _v75(_v325, _v102)
_v229 = 0
local _v201 = _v254(_v325)
local _v230, right = _v244(_v201:add((_V9({42,175,122,28,204,182,243,191}))))
local _v162 = _v248(_v230, (_V9({33,172,117})))
_v256(_v162, (_V9({34,174,109,27,205,182,249})), function()
return _v102.Movement.FlyEnabled
end, function()
_v102.Movement.FlyEnabled = not _v102.Movement.FlyEnabled
end)
_v247(_v162, (_V9({33,172,117,89,242,163,248,174,25})), 10, 200, function()
return _v102.Movement.FlySpeed
end, function(_v454)
_v102.Movement.FlySpeed = _v454
end, true)
local _v393 = _v248(_v230, (_V9({52,176,105,28,197})))
_v256(_v393, (_V9({34,174,109,27,205,182,249})), function()
return _v102.Movement.SpeedEnabled
end, function()
_v102.Movement.SpeedEnabled = not _v102.Movement.SpeedEnabled
end)
_v247(_v393, (_V9({52,176,105,28,197})), 16, 100, function()
return _v102.Movement.Speed
end, function(_v454)
_v102.Movement.Speed = _v454
end, true)
local _v262 = _v248(_v230, (_V9({40,180,100,28,211})))
_v256(_v262, (_V9({41,175,111,21,200,163})), function()
return _v102.Movement.NoclipEnabled
end, function()
_v102.Movement.NoclipEnabled = not _v102.Movement.NoclipEnabled
end)
_v256(_v262, (_V9({46,174,106,16,207,186,233,174,93,45,181,97,9})), function()
return _v102.Movement.InfJumpEnabled
end, function()
_v102.Movement.InfJumpEnabled = not _v102.Movement.InfJumpEnabled
end)
local _v438 = _v248(right, (_V9({36,172,101,26,202,243,201,155})))
_v256(_v438, (_V9({34,174,109,27,205,182,249})), function()
return _v102.Movement.ClickTPEnabled
end, function()
_v102.Movement.ClickTPEnabled = not _v102.Movement.ClickTPEnabled
end)
_v251(_v438, (_V9({42,175,104,16,199,186,248,185,93,44,165,117})), function()
return _v102.Movement.ClickTPKey
end, function(_v221)
_v102.Movement.ClickTPKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({4,172,101,26,202,167,237})))
end)
end
local function _v76(_v325, _v102)
_v229 = 0
local _v201 = _v254(_v325)
local _v230, right = _v244(_v201:add((_V9({32,165,98,28,211,178,241}))))
local _v208 = _v248(_v230, (_V9({46,174,120,28,211,181,252,168,24})))
_v247(_v208, (_V9({50,137,44,42,194,178,241,174})), 0.8, 1.5, function()
return _v102.UI.Scale
end, function(_v454)
_v102.UI.Scale = _v454
if _v476 then
_v476.Scale = _v454
end
end, false)
_v256(_v208, (_V9({44,165,117,27,200,189,249,235,45,6,174,105,21})), function()
return _v102.UI.KeybindPanel
end, function()
_v102.UI.KeybindPanel = not _v102.UI.KeybindPanel
if _v224 then
_v224.Visible = _v102.UI.KeybindPanel
end
end)
_v256(_v208, (_V9({51,161,126,30,196,167,189,143,20,20,176,96,24,216})), function()
return _v102.UI.TargetDisplay
end, function()
_v102.UI.TargetDisplay = not _v102.UI.TargetDisplay
_v418 = _v102.UI.TargetDisplay
if not _v418 and _v419 then
_v419.Visible = false
end
end)
_v256(_v208, (_V9({33,144,95,89,226,188,232,165,9,2,178})), function()
return _v102.UI.FPSCounter
end, function()
_v102.UI.FPSCounter = not _v102.UI.FPSCounter
if _v170 then
_v170.Visible = _v102.UI.FPSCounter
end
end)
_v256(_v208, (_V9({48,161,120,28,211,190,252,185,22})), function()
return _v102.UI.Watermark
end, function()
_v102.UI.Watermark = not _v102.UI.Watermark
if _v472 then
_v472.Visible = _v102.UI.Watermark
end
end)
local _v41 = _v248(right, (_V9({38,163,111,22,212,189,233})))
_v252(_v41, (_V9({50,179,105,11,207,178,240,174})), _v22 and _v22.Name or (_V9({133,64,152})))
_v252(_v41, (_V9({35,169,127,9,205,178,228,235,51,6,173,105})), _v22 and _v22.DisplayName or (_V9({133,64,152})))
_v252(_v41, (_V9({50,179,105,11,129,154,217})), _v22 and tostring(_v22.UserId) or (_V9({133,64,152})))
_v256(_v41, (_V9({38,174,120,16,140,146,219,128})), function()
return _v102.Utility.AntiAFK
end, function()
_v102.Utility.AntiAFK = not _v102.Utility.AntiAFK
end)
_v242(_v41, (_V9({52,165,126,15,196,161,189,131,18,23})), function()
Utility:ServerHop()
end)
_v242(_v41, (_V9({53,165,102,22,200,189,189,152,24,21,182,105,11})), function()
Utility:Rejoin()
end)
_v230, right = _v244(_v201:add((_V9({36,175,98,31,200,180,238}))))
local _v92 = _v248(_v230, (_V9({36,175,98,31,200,180,238})))
if not _v8.isSupported() then
_v252(_v92, (_V9({52,180,109,13,212,160})), (_V9({50,174,127,12,209,163,242,185,9,2,164})))
return
end
local _v278 = _v255(_v92, (_V9({4,175,98,31,200,180,189,165,28,10,165,238,249,7})))
local _v235 = _v282((_V9({33,178,109,20,196})), {
Parent = _v92,
LayoutOrder = _v283(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = _v235,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v348
local function _v380(name)
_v278.Text = name
_v348()
end
_v348 = function()
for _, _v97 in ipairs(_v235:GetChildren()) do
if not _v97:IsA((_V9({50,137,64,16,210,167,209,170,4,8,181,120}))) then
_v97:Destroy()
end
end
local _v280 = _v8.list()
if #_v280 == 0 then
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v235,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({9,175,44,10,192,165,248,175,93,4,175,98,31,200,180,238})),
})
return
end
for i, name in ipairs(_v280) do
local _v381 = (_v278.Text == name)
local row = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v235,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v381 and _v4.accent or _v4.row,
BackgroundTransparency = _v381 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v381 and Color3.fromRGB(255, 255, 255) or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({71,224})) .. name,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v380(name)
end)
row.MouseEnter:Connect(function()
if _v278.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v4.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v278.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v4.row
end
end)
end
end
_v242(_v92, (_V9({52,161,122,28})), function()
local _v300, res = _v8.save(_v278.Text, _v102)
if _v300 then
UI:Notify((_V9({52,161,122,28,197,243,254,164,19,1,169,107,89,134})) .. res .. (_V9({64})), 2)
_v348()
else
UI:Notify(tostring(res), 3)
end
end)
_v242(_v92, (_V9({43,175,109,29})), function()
local _v300, res = _v8.load(_v278.Text, _v102)
if _v300 then
if _v476 then
_v476.Scale = _v102.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({43,175,109,29,196,183,189,168,18,9,166,101,30,129,244})) .. res .. (_V9({64})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v242(_v92, (_V9({35,165,96,28,213,182})), function()
local _v300, res = _v8.delete(_v278.Text)
if _v300 then
UI:Notify((_V9({35,165,96,28,213,182,249,235,30,8,174,106,16,198,243,186})) .. res .. (_V9({64})), 2)
_v278.Text = (_V9({}))
_v348()
else
UI:Notify(tostring(res), 3)
end
end, _v4.danger)
_v348()
end
local function _v77(_v102)
_v419 = _v282((_V9({33,178,109,20,196})), {
Parent = _v183,
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 90),
Size = UDim2.fromOffset(0, 30),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v419, CornerRadius = UDim.new(0, 6) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v419, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = _v419,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = _v419,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v136 = _v282((_V9({33,178,109,20,196})), {
Parent = _v419,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v136, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v419,
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
local _v138, _v137, _v399
_v419.InputBegan:Connect(function(_v210)
if _v219(_v210) then
_v138 = true
_v137 = _v210.Position
_v399 = _v419.Position
end
end)
table.insert(_v268, function(_v210)
if _v138 and _v419 then
local delta = _v210.Position - _v137
_v419.Position = UDim2.new(
_v399.X.Scale,
_v399.X.Offset + delta.X,
_v399.Y.Scale,
_v399.Y.Offset + delta.Y
)
end
end)
table.insert(_v351, function()
_v138 = false
end)
table.insert(_v408, function()
_v418 = _v102.UI.TargetDisplay
if not _v418 and _v419 then
_v419.Visible = false
end
end)
_v418 = _v102.UI.TargetDisplay
end
local function _v73(_v102)
_v170 = _v282((_V9({33,178,109,20,196})), {
Parent = _v183,
AnchorPoint = Vector2.new(1, 1),
Position = UDim2.new(1, -14, 1, -14),
Size = UDim2.fromOffset(0, 26),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = _v4.panel,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v170, CornerRadius = UDim.new(0, 6) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v170, Color = _v4.accent, Thickness = 1, Transparency = 0.4 })
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = _v170,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = _v170,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v136 = _v282((_V9({33,178,109,20,196})), {
Parent = _v170,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v136, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v170,
LayoutOrder = 1,
Size = UDim2.new(0, 0, 1, 0),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({74,237,44,31,209,160})),
})
table.insert(_v408, function()
if _v170 then
_v170.Visible = _v102.UI.FPSCounter
end
end)
_v170.Visible = _v102.UI.FPSCounter
end
local function _v78(_v102)
_v472 = _v282((_V9({46,173,109,30,196,159,252,169,24,11})), {
Parent = _v183,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 14, 1, -14),
Size = UDim2.fromOffset(180, 64),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Fit,
Image = (_V9({})),
Visible = false,
})
UI:SetWatermarkImage(_v102.UI.WatermarkImageId)
table.insert(_v408, function()
if _v472 then
_v472.Visible = _v102.UI.Watermark
end
end)
_v472.Visible = _v102.UI.Watermark
end
local function _v74(_v102)
_v229 = 0
_v224 = _v282((_V9({33,178,109,20,196})), {
Parent = _v183,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
Visible = false,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v224, CornerRadius = UDim.new(0, 8) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v224, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), {
Parent = _v224,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = _v224,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v282((_V9({33,178,109,20,196})), {
Parent = _v224,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({44,165,117,27,200,189,249,184})),
})
local _v138, _v137, _v399
bar.InputBegan:Connect(function(_v210)
if _v219(_v210) then
_v138 = true
_v137 = _v210.Position
_v399 = _v224.Position
end
end)
table.insert(_v268, function(_v210)
if _v138 and _v224 then
local delta = _v210.Position - _v137
_v224.Position = UDim2.new(
_v399.X.Scale,
_v399.X.Offset + delta.X,
_v399.Y.Scale,
_v399.Y.Offset + delta.Y
)
end
end)
table.insert(_v351, function()
_v138 = false
end)
_v251(_v224, (_V9({42,165,98,12})), function()
return _v102.UI.MenuKey
end, function(_v221)
_v102.UI.MenuKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({10,165,98,12})))
end)
_v251(_v224, (_V9({38,169,97,27,206,167})), function()
return _v102.Camera.ToggleKey
end, function(_v221)
_v102.Camera.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({6,169,97,27,206,167})))
end)
_v251(_v224, (_V9({34,147,92})), function()
return _v102.ESP.ToggleKey
end, function(_v221)
_v102.ESP.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({2,179,124})))
end)
_v251(_v224, (_V9({33,143,90,89,226,186,239,168,17,2})), function()
return _v102.Camera.FOVCircleKey
end, function(_v221)
_v102.Camera.FOVCircleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({1,175,122,26,200,161,254,167,24})))
end)
_v251(_v224, (_V9({41,175,44,43,196,176,242,162,17})), function()
return _v102.NoRecoil.ToggleKey
end, function(_v221)
_v102.NoRecoil.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({9,175,126,28,194,188,244,167})))
end)
_v251(_v224, (_V9({41,175,44,42,209,161,248,170,25})), function()
return _v102.NoSpread.ToggleKey
end, function(_v221)
_v102.NoSpread.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({9,175,127,9,211,182,252,175})))
end)
_v251(_v224, (_V9({51,178,101,30,198,182,239,169,18,19})), function()
return _v102.Triggerbot.ToggleKey
end, function(_v221)
_v102.Triggerbot.ToggleKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({19,178,101,30,198,182,239,169,18,19})))
end)
_v251(_v224, (_V9({50,174,96,22,192,183})), function()
return _v102.UI.UnloadKey
end, function(_v221)
_v102.UI.UnloadKey = _v221
end, function(_v221)
return _v222(_v102, _v221, (_V9({18,174,96,22,192,183})))
end)
table.insert(_v408, function()
if _v224 then
_v224.Visible = _v102.UI.KeybindPanel
end
end)
_v224.Visible = _v102.UI.KeybindPanel
end
local function _v386(_v400)
if not _v241 or _v400 == visible then
return
end
visible = _v400
if _v44 and _v44.UI then
_v44.UI.Visible = _v400
end
if _v400 then
_v241.Visible = true
_v241.GroupTransparency = 1
_v35:Create(_v241, TweenInfo.new(_v14), { GroupTransparency = 0 }):Play()
else
local _v442 = _v35:Create(_v241, TweenInfo.new(_v14), { GroupTransparency = 1 })
_v442.Completed:Once(function()
if not visible and _v241 then
_v241.Visible = false
end
end)
_v442:Play()
end
end
function UI:Init(_v102, _v313)
if _v183 then
return
end
_v44 = _v102
_v314 = _v313
_v398()
_v183 = _v282((_V9({52,163,126,28,196,189,218,190,20})), {
Name = (_V9({49,161,98,16,213,170,218,174,19,2,178,109,21,244,154})),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v300 = pcall(function()
_v183.Parent = Utility.getGuiParent()
end)
if not _v300 or not _v183.Parent then
_v183.Parent = _v22:WaitForChild((_V9({55,172,109,0,196,161,218,190,20})))
end
_v241 = _v282((_V9({36,161,98,15,192,160,218,185,18,18,176})), {
Parent = _v183,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v4.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v476 = _v282((_V9({50,137,95,26,192,191,248})), { Parent = _v241, Scale = _v102.UI.Scale })
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v241, CornerRadius = UDim.new(0, 8) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v241, Color = _v4.accent, Thickness = 1, Transparency = 0.35 })
local _v431 = _v282((_V9({33,178,109,20,196})), {
Parent = _v241,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v431, CornerRadius = UDim.new(0, 8) })
_v282((_V9({33,178,109,20,196})), {
Parent = _v431,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v4.bar,
BorderSizePixel = 0,
})
local _v136 = _v282((_V9({33,178,109,20,196})), {
Parent = _v431,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v136, CornerRadius = UDim.new(1, 0) })
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v431,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v4.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({49,161,98,16,213,170,161,173,18,9,180,44,26,206,191,242,185,64,69,227,52,77,146,150,223,142,95,89,238,104,28,215,239,178,173,18,9,180,50,89,230,182,243,174,15,6,172}))
.. (_V9({91,166,99,23,213,243,254,164,17,8,178,49,91,130,235,220,252,62,38,240,46,71,129,243,189,9,202,71,224,44,15,145,239,178,173,18,9,180,50})),
ZIndex = 2,
})
_v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v431,
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
local _v138, _v137, _v399
_v431.InputBegan:Connect(function(_v210)
if _v219(_v210) then
_v138 = true
_v137 = _v210.Position
_v399 = _v241.Position
end
end)
table.insert(_v268, function(_v210)
if _v138 then
local delta = _v210.Position - _v137
_v241.Position = UDim2.new(
_v399.X.Scale,
_v399.X.Offset + delta.X,
_v399.Y.Scale,
_v399.Y.Offset + delta.Y
)
end
end)
table.insert(_v351, function()
_v138 = false
end)
local _v390 = _v282((_V9({33,178,109,20,196})), {
Parent = _v241,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v4.panel,
BorderSizePixel = 0,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v390, CornerRadius = UDim.new(0, 6) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v390, Color = _v4.border, Thickness = 1, Transparency = 0.15 })
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = _v390,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v414 = _v282((_V9({33,178,109,20,196})), {
Parent = _v390,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v282((_V9({50,137,64,16,210,167,209,170,4,8,181,120})), { Parent = _v414, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v445 = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v390,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v4.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v4.danger,
Text = (_V9({50,174,96,22,192,183})),
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v445, CornerRadius = UDim.new(0, 6) })
local _v446 = _v282((_V9({50,137,95,13,211,188,246,174})), {
Parent = _v445,
Color = _v4.danger,
Thickness = 1,
Transparency = 0.55,
})
_v445.MouseButton1Click:Connect(function()
if _v314 then
_v314()
end
end)
_v445.MouseEnter:Connect(function()
_v35:Create(_v445, _v1, {
BackgroundColor3 = _v4.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v35:Create(_v446, _v1, { Transparency = 0 }):Play()
end)
_v445.MouseLeave:Connect(function()
_v35:Create(_v445, _v1, {
BackgroundColor3 = _v4.row,
TextColor3 = _v4.danger,
}):Play()
_v35:Create(_v446, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v282((_V9({33,178,109,20,196})), {
Parent = _v241,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v282((_V9({50,137,92,24,197,183,244,165,26})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v416 = { (_V9({36,175,97,27,192,167})), (_V9({49,169,127,12,192,191})), (_V9({42,175,122,28,204,182,243,191})), (_V9({52,165,120,13,200,189,250,184})) }
local _v413 = {}
for i, _v415 in ipairs(_v416) do
local _v213 = _v109 == _v415
local _v411 = _v282((_V9({51,165,116,13,227,166,233,191,18,9})), {
Parent = _v414,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v4.rowHover,
BackgroundTransparency = _v213 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v213 and _v4.text or _v4.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({71,224,44,89})) .. _v415,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v411, CornerRadius = UDim.new(0, 6) })
local stripe = _v282((_V9({33,178,109,20,196})), {
Parent = _v411,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v4.accent,
BorderSizePixel = 0,
Visible = _v213,
ZIndex = 2,
})
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v412 = _v282((_V9({33,178,109,20,196})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v213,
})
_v413[_v415] = { btn = _v411, frame = _v412, stripe = stripe }
_v411.MouseButton1Click:Connect(function()
_v109 = _v415
for name, _v410 in pairs(_v413) do
local _v42 = name == _v415
_v410.frame.Visible = _v42
_v410.stripe.Visible = _v42
_v35:Create(_v410.btn, _v1, {
BackgroundTransparency = _v42 and 0 or 1,
TextColor3 = _v42 and _v4.text or _v4.textSub,
}):Play()
end
end)
_v411.MouseEnter:Connect(function()
if _v109 ~= _v415 then
_v35:Create(_v411, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v411.MouseLeave:Connect(function()
if _v109 ~= _v415 then
_v35:Create(_v411, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v70(_v413[(_V9({36,175,97,27,192,167}))].frame, _v102)
_v71(_v413[(_V9({49,169,127,12,192,191}))].frame, _v102)
_v75(_v413[(_V9({42,175,122,28,204,182,243,191}))].frame, _v102)
_v76(_v413[(_V9({52,165,120,13,200,189,250,184}))].frame, _v102)
_v74(_v102)
_v77(_v102)
_v73(_v102)
_v78(_v102)
if _v102.UI.Visible then
_v386(true)
end
end
function UI:Toggle()
_v386(not visible)
end
function UI:Show()
_v386(true)
end
function UI:Hide()
_v386(false)
end
function UI:SetCurrentTarget(name)
if not _v419 then
return
end
if _v419.Visible ~= _v418 then
_v419.Visible = _v418
end
if not _v418 or not targetPanelLabel then
return
end
local _v389, colour
if name and name ~= (_V9({})) and name ~= (_V9({41,175,98,28})) then
_v389, colour = name, (_V9({68,248,56,74,228,145,216}))
else
_v389, colour = (_V9({50,174,71,23,206,164,243})), (_V9({68,248,77,78,226,146,173}))
end
local text = (_V9({51,161,126,30,196,167,167,235,65,1,175,98,13,129,176,242,167,18,21,253,46})) .. colour .. (_V9({69,254})) .. _v389 .. (_V9({91,239,106,22,207,167,163}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v168)
if not fpsLabel or not _v170 or not _v170.Visible then
return
end
local text = string.format((_V9({91,166,99,23,213,243,254,164,17,8,178,49,91,130,235,169,248,56,37,133,46,71,132,183,161,228,27,8,174,120,71,129,181,237,184})), _v168 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v207)
if not _v472 then
return
end
local _v128 = tostring(_v207 or (_V9({}))):match((_V9({66,164,39})))
_v472.Image = _v128 and ((_V9({21,162,116,24,210,160,248,191,20,3,250,35,86})) .. _v128) or (_V9({}))
end
function UI:SyncControls()
for _, _v164 in ipairs(_v408) do
_v164()
end
end
function UI:IsCapturingKey()
return _v87
end
function UI:Notify(text, _v144)
if not _v183 then
return
end
_v144 = _v144 or 3
local _v432 = _v282((_V9({51,165,116,13,237,178,255,174,17})), {
Parent = _v183,
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
_v282((_V9({50,137,79,22,211,189,248,185})), { Parent = _v432, CornerRadius = UDim.new(0, 8) })
_v282((_V9({50,137,95,13,211,188,246,174})), { Parent = _v432, Color = _v4.accent, Thickness = 1, Transparency = 0.3 })
_v35:Create(_v432, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v144, function()
if _v432 and _v432.Parent then
local _v323 = _v35:Create(_v432, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v323.Completed:Once(function()
if _v432 then
_v432:Destroy()
end
end)
_v323:Play()
end
end)
end
function UI:Cleanup()
for _, _v105 in ipairs(_v443) do
_v105:Disconnect()
end
table.clear(_v443)
table.clear(_v268)
table.clear(_v351)
table.clear(_v408)
_v43 = nil
_v87 = false
_v45 = nil
_v419, targetPanelLabel = nil, nil
_v418 = false
_v224 = nil
_v472 = nil
_v170, fpsLabel = nil, nil
_v476 = nil
if _v183 then
_v183:Destroy()
_v183 = nil
_v241 = nil
end
visible = false
end
return UI
end)()
Movement = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v36 = game:GetService((_V9({50,179,105,11,232,189,237,190,9,52,165,126,15,200,176,248})))
local _v39 = game:GetService((_V9({48,175,126,18,210,163,252,168,24})))
local _v22 = _v24.LocalPlayer
local UI = UI
local Movement = {}
local _v2 = 16
local _v19 = 50
local _v272
local _v270
local function _v269()
local _v94 = _v22.Character
local root = _v94 and _v94:FindFirstChild((_V9({47,181,97,24,207,188,244,175,47,8,175,120,41,192,161,233})))
local humanoid = _v94 and _v94:FindFirstChildOfClass((_V9({47,181,97,24,207,188,244,175})))
if not (_v94 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v94, root, humanoid
end
local function _v271(_v79)
local _v239 = _v79.CFrame.LookVector
local _v161 = Vector3.new(_v239.X, 0, _v239.Z)
if _v161.Magnitude < 0.001 then
_v161 = Vector3.new(0, 0, -1)
else
_v161 = _v161.Unit
end
local right = _v79.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v267 = Vector3.zero
if _v36:IsKeyDown(Enum.KeyCode.W) then
_v267 = _v267 + _v161
end
if _v36:IsKeyDown(Enum.KeyCode.S) then
_v267 = _v267 - _v161
end
if _v36:IsKeyDown(Enum.KeyCode.D) then
_v267 = _v267 + right
end
if _v36:IsKeyDown(Enum.KeyCode.A) then
_v267 = _v267 - right
end
if _v36:IsKeyDown(Enum.KeyCode.Space) then
_v267 = _v267 + Vector3.yAxis
end
if _v36:IsKeyDown(Enum.KeyCode.LeftShift) then
_v267 = _v267 - Vector3.yAxis
end
if _v267.Magnitude > 0 then
return _v267.Unit
end
return nil
end
function Movement:Update(_v143, _v102)
local _v94, root, humanoid = _v269()
if _v102.NoclipEnabled and _v94 then
for _, _v326 in ipairs(_v94:GetDescendants()) do
if _v326:IsA((_V9({37,161,127,28,241,178,239,191}))) then
_v326.CanCollide = false
end
end
end
if not root then
return
end
if _v102.FlyEnabled then
local _v79 = _v39.CurrentCamera
if _v79 then
local _v459 = Vector3.zero
if not UI:IsCapturingKey() then
local _v129 = _v271(_v79)
if _v129 then
_v459 = _v129 * (_v102.FlySpeed or 50)
end
end
root.AssemblyLinearVelocity = _v459
end
return
end
if _v102.SpeedEnabled then
local _v393 = _v102.Speed or _v2
local _v267 = humanoid.MoveDirection
if _v393 > _v2 and _v267.Magnitude > 0 then
local _v459 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v267.X * _v393, _v459.Y, _v267.Z * _v393)
end
end
end
local function _v274(_v102)
if not _v102.InfJumpEnabled then
return
end
local _, root = _v269()
if root then
local _v459 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v459.X, _v19, _v459.Z)
end
end
local function _v273(_v102, _v210, _v175)
if _v175 or UI:IsCapturingKey() then
return
end
if not _v102.ClickTPEnabled then
return
end
if _v210.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v36:IsKeyDown(_v102.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _, root = _v269()
local _v266 = _v22:GetMouse()
if root and _v266 and _v266.Hit then
root.CFrame = CFrame.new(_v266.Hit.Position + Vector3.new(0, 3, 0))
end
end
function Movement:Init(_v102)
if not _v272 then
_v272 = _v36.JumpRequest:Connect(function()
_v274(_v102)
end)
end
if not _v270 then
_v270 = _v36.InputBegan:Connect(function(_v210, _v175)
_v273(_v102, _v210, _v175)
end)
end
end
function Movement:Cleanup()
if _v272 then
_v272:Disconnect()
_v272 = nil
end
if _v270 then
_v270:Disconnect()
_v270 = nil
end
end
return Movement
end)()
_v10 = (function()
local _v24 = game:GetService((_V9({55,172,109,0,196,161,238})))
local _v29 = game:GetService((_V9({53,181,98,42,196,161,235,162,30,2})))
local _v36 = game:GetService((_V9({50,179,105,11,232,189,237,190,9,52,165,126,15,200,176,248})))
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
_v10.Version = (_V9({87}))
_v10.Config = _v9
_v38.Version = _v10.Version
local _v367 = false
local _v106 = {}
local _v51 = false
local _v25 = (_V9({49,161,98,16,213,170,218,174,19,2,178,109,21,243,182,254,164,20,11}))
local _v181 = {}
local _v16 = 5
local function _v182(name, _v164, ...)
local _v300, res = pcall(_v164, ...)
if _v300 then
local _v397 = _v181[name]
if _v397 then
_v397.failures = 0
end
return true, res
end
local _v397 = _v181[name]
if not _v397 then
_v397 = { failures = 0, lastWarn = -math.huge }
_v181[name] = _v397
end
_v397.failures = _v397.failures + 1
local _v284 = os.clock()
if _v284 - _v397.lastWarn >= _v16 then
_v397.lastWarn = _v284
warn(string.format((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,88,20,224,106,24,200,191,248,175,93,79,184,41,29,136,233,189,238,14})), name, _v397.failures, tostring(res)))
end
return false, nil
end
function _v10.IsRunning()
return _v367
end
function _v10.SaveConfig(name)
return _v8.save(name, _v9)
end
function _v10.LoadConfig(name)
local _v300, res = _v8.load(name, _v9)
if _v300 then
pcall(function()
UI:SyncControls()
end)
end
return _v300, res
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
function _v10.SetWatermarkImage(_v207)
_v9.UI.WatermarkImageId = tostring(_v207 or (_V9({})))
UI:SetWatermarkImage(_v9.UI.WatermarkImageId)
return _v10
end
function _v10.SetWebhook(_v452)
return _v38.SetWebhook(_v452)
end
function _v10.HasWebhook()
return _v38.HasWebhook()
end
function _v10.SendWebhook(content, _v320)
return _v38.SendWebhook(content, _v320)
end
function _v10.SendLoadedEmbed(_v215)
return _v38.SendLoadedEmbed(_v215)
end
function _v10.Start()
if _v367 then
return _v10
end
_v367 = true
local _v300, err = pcall(function()
ESP:Init()
UI:Init(_v9, function()
_v10.Stop()
end)
Movement:Init(_v9.Movement)
SilentAim:Init(_v9.SilentAim)
Utility:Init(_v9.Utility)
table.insert(_v106, _v24.PlayerAdded:Connect(function(_v335)
_v182((_V9({55,172,109,0,196,161,220,175,25,2,164})), ESP.OnPlayerAdded, ESP, _v335)
end))
table.insert(_v106, _v24.PlayerRemoving:Connect(function(_v335)
_v182((_V9({55,172,109,0,196,161,207,174,16,8,182,101,23,198})), ESP.OnPlayerRemoving, ESP, _v335)
end))
table.insert(_v106, _v36.InputBegan:Connect(function(_v210, _v175)
if _v175 or UI:IsCapturingKey() then
return
end
_v182((_V9({44,165,117,27,200,189,249,184})), function()
local _v221 = _v210.KeyCode
if _v221 == _v9.UI.MenuKey then
UI:Toggle()
elseif _v221 == _v9.UI.UnloadKey then
_v10.Stop()
else
local _v433 = {
{ _v9.Camera, (_V9({34,174,109,27,205,182,249})), _v9.Camera.ToggleKey },
{ _v9.ESP, (_V9({34,174,109,27,205,182,249})), _v9.ESP.ToggleKey },
{ _v9.Camera, (_V9({33,143,90,58,200,161,254,167,24})), _v9.Camera.FOVCircleKey },
{ _v9.NoRecoil, (_V9({34,174,109,27,205,182,249})), _v9.NoRecoil.ToggleKey },
{ _v9.NoSpread, (_V9({34,174,109,27,205,182,249})), _v9.NoSpread.ToggleKey },
{ _v9.Triggerbot, (_V9({34,174,109,27,205,182,249})), _v9.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v433) do
if _v221 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v169, fpsFrames = 0, 0
table.insert(_v106, _v29.RenderStepped:Connect(function(_v143)
_v182((_V9({36,161,98,29,200,183,252,191,24,20})), _v7.Update, _v7, _v9.Camera, _v9.ESP)
_v182((_V9({34,147,92})), ESP.Update, ESP, _v9.ESP)
local _v302, target = _v182((_V9({38,169,97,27,206,167})), _v6.Update, _v6, _v9.Camera, _v9.Debug)
if not _v302 then
target = nil
end
if _v9.UI.TargetDisplay then
_v182((_V9({51,161,126,30,196,167,189,175,20,20,176,96,24,216})), function()
local _v240 = _v6:GetLookTarget(_v9.ESP, _v9.Camera)
UI:SetCurrentTarget(_v240 and _v240.Name or nil)
end)
end
_v51 = _v9.Camera.Enabled and target ~= nil
_v182((_V9({41,175,95,9,211,182,252,175})), NoSpread.Update, NoSpread, _v9.NoSpread)
_v182((_V9({51,178,101,30,198,182,239,169,18,19})), Triggerbot.Update, Triggerbot, _v9.Triggerbot, _v9.Camera)
_v182((_V9({42,175,122,28,204,182,243,191})), Movement.Update, Movement, _v143, _v9.Movement)
_v182((_V9({47,169,120,27,206,171})), _v18.Update, _v18, _v9.Hitbox, _v9.Camera)
_v182((_V9({35,178,109,14,200,189,250,235,56,52,144})), _v13.Update, _v13, _v9.Drawing, _v9.Camera)
_v182((_V9({49,169,127,12,192,191,238})), Visuals.Update, Visuals, _v9.Visuals)
_v169 = _v169 + _v143
fpsFrames = fpsFrames + 1
if _v169 >= 0.25 then
local _v168 = math.floor(fpsFrames / _v169 + 0.5)
_v169, fpsFrames = 0, 0
if _v9.UI.FPSCounter then
_v182((_V9({33,144,95,89,194,188,232,165,9,2,178})), UI.UpdateFPS, UI, _v168)
end
end
end))
pcall(function()
_v29:UnbindFromRenderStep(_v25)
end)
pcall(function()
_v29:BindToRenderStep(_v25, Enum.RenderPriority.Camera.Value + 1, function()
_v182((_V9({41,175,94,28,194,188,244,167})), NoRecoil.Update, NoRecoil, _v9.NoRecoil, _v51)
end)
end)
end)
if not _v300 then
warn((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,59,6,169,96,28,197,243,233,164,93,20,180,109,11,213,233})), err)
_v10.Stop()
return _v10
end
if getgenv then
getgenv().VanityGeneral = _v10
end
UI:Notify(string.format((_V9({49,161,98,16,213,170,176,140,24,9,165,126,24,205,243,241,164,28,3,165,104,89,129,49,29,105,93,71,144,126,28,210,160,189,238,14})), _v9.UI.MenuKey.Name), 4)
print(string.format((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,47,18,174,98,16,207,180,189,227,11,66,179,37})), _v10.Version))
print(string.format((_V9({42,165,98,12,155,243,184,184,93,71,188,44,89,226,178,240,174,15,6,250,44,92,210,243,189,183,93,71,149,98,21,206,178,249,241,93,66,179})),
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
if not _v367 then
return _v10
end
_v367 = false
for _, _v105 in ipairs(_v106) do
pcall(function()
_v105:Disconnect()
end)
end
table.clear(_v106)
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
table.clear(_v181)
print((_V9({60,150,109,23,200,167,228,230,58,2,174,105,11,192,191,192,235,46,19,175,124,9,196,183})))
return _v10
end
function _v10.Toggle()
if _v367 then
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
local _v341 = getgenv().VanityGeneral
if _v341 and _v341 ~= _v10 and type(_v341.Stop) == (_V9({1,181,98,26,213,186,242,165})) then
pcall(_v341.Stop)
end
end
pcall(function()
_v10.Start()
end)
return _v10
end
