local _V9=(function(_k)return function(_t)local _o={}for _i=1,#_t do _o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end return table.concat(_o)end end)({207,177,208,119,227,221,249,252,78})
local _v10
local _v12
local _v11
local _v47
local _v9
local _v8
local ESP
local _v16
local Visuals
local _v49
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
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local _v398 = setmetatable({}, { __mode = (_V9({164})) })
local _v399 = 0
local _v400 = false
local _v215 = {}
local _v35 = (_V9({12,19,18,247,33,86,143,155,17,189,197}))
local _v27 = (_V9({174,211,179,19,134,187,158,148,39,165,218,188,26,141,178,137,141,60,188,197,165,1,148,165,128,134,15,141,242,148,50,165,154,177,181,4,132,253,157,57,172,141,168,174,29,155,228,134,32,187,132,163}))
function _v10.RandomName(_v261)
_v261 = _v261 or 14
local _v374 = {}
for i = 1, _v261 do
local n = math.random(1, #_v27)
_v374[i] = string.sub(_v27, n, n)
end
return table.concat(_v374)
end
function _v10.CClosure(_v184)
if type(newcclosure) == (_V9({169,196,190,20,151,180,150,146})) then
local _v343, wrapped = pcall(newcclosure, _v184)
if _v343 and type(wrapped) == (_V9({169,196,190,20,151,180,150,146})) then
return wrapped
end
end
return _v184
end
local function _v177(_v234)
local _v343, exposed = pcall(function()
if _v234:IsDescendantOf(_v50) then
return true
end
local _v387 = _v26 and _v26:FindFirstChild((_V9({159,221,177,14,134,175,190,137,39})))
return _v387 ~= nil and _v234:IsDescendantOf(_v387)
end)
return _v343 and exposed == true
end
function _v10.Protect(_v234)
if not _v398[_v234] then
_v398[_v234] = true
_v399 = _v399 + 1
end
if not _v400 then
_v400 = true
local exposed = _v177(_v234)
_v400 = false
if exposed then
_v10.Install()
end
end
return _v234
end
local function _v242(_v234)
local _v324 = _v234
while _v324 and _v324 ~= game do
if _v398[_v324] then
return true
end
_v324 = _v324.Parent
end
return false
end
local _v37 = _v10.RandomName(16)
local function _v235()
if type(getgenv) ~= (_V9({169,196,190,20,151,180,150,146})) then
return false
end
local _v343, env = pcall(getgenv)
if not _v343 or type(env) ~= (_V9({187,208,178,27,134})) then
return false
end
local _v411 = rawget(env, _v35)
if type(_v411) ~= (_V9({187,208,178,27,134})) then
_v411 = {}
rawset(env, _v35, _v411)
end
if _v411.runId ~= nil and _v411.runId == _v37 then
return true
end
if type(_v411.names) ~= (_V9({187,208,178,27,134})) then
_v411.names = {}
end
_v215 = _v411.names
local _v344 = pcall(function()
local _v302 = getmetatable(env)
local _v355 = _v302 and rawget(_v302, (_V9({144,238,185,25,135,184,129})))
if type(_v411.wrapper) == (_V9({169,196,190,20,151,180,150,146})) and _v355 == _v411.wrapper then
_v355 = _v411.original
else
_v411.original = _v355
end
local _v321 = {}
if _v302 then
for k, v in pairs(_v302) do
_v321[k] = v
end
end
local _v422 = false
local _v561
_v561 = function(_, _v248)
local hidden = _v215[_v248]
if hidden ~= nil then
return hidden
end
if _v422 then
return nil
end
_v422 = true
local _v346, result = true, nil
if type(_v355) == (_V9({169,196,190,20,151,180,150,146})) then
_v346, result = pcall(_v355, env, _v248)
elseif type(_v355) == (_V9({187,208,178,27,134})) then
result = _v355[_v248]
end
_v422 = false
if not _v346 then
error(result, 0)
end
return result
end
_v321.__index = _v561
_v411.wrapper = _v561
setmetatable(env, _v321)
end)
if _v344 then
_v411.runId = _v37
end
return _v344
end
function _v10.HideGlobal(name, value)
_v215[name] = value
if type(getgenv) == (_V9({169,196,190,20,151,180,150,146})) then
pcall(function()
local env = getgenv()
if type(env) == (_V9({187,208,178,27,134})) and rawget(env, name) ~= nil then
rawset(env, name, nil)
end
end)
end
return _v235()
end
local _v236 = false
local _v18 = {
GetChildren = true,
GetDescendants = true,
FindFirstChild = true,
FindFirstChildOfClass = true,
FindFirstChildWhichIsA = true,
}
function _v10.Install()
if _v236 then
return
end
if type(hookmetamethod) ~= (_V9({169,196,190,20,151,180,150,146})) or type(getnamecallmethod) ~= (_V9({169,196,190,20,151,180,150,146})) then
return
end
if type(checkcaller) ~= (_V9({169,196,190,20,151,180,150,146})) then
return
end
local _v356
local _v230 = false
local _v343 = pcall(function()
_v356 = hookmetamethod(game, (_V9({144,238,190,22,142,184,154,157,34,163})), _v10.CClosure(function(self, ...)
local _v292 = getnamecallmethod()
if not _v230 and _v399 > 0 and _v292 and _v18[_v292] and not checkcaller() then
_v230 = true
local _v423 = table.pack(pcall(_v356, self, ...))
_v230 = false
if not _v423[1] then
error(_v423[2], 0)
end
local res = _v423[2]
if _v292 == (_V9({136,212,164,52,139,180,149,152,60,170,223})) or _v292 == (_V9({136,212,164,51,134,174,154,153,32,171,208,190,3,144})) then
local _v247 = {}
for i = 1, #res do
if not _v242(res[i]) then
_v247[#_v247 + 1] = res[i]
end
end
return _v247
end
if typeof(res) == (_V9({134,223,163,3,130,179,154,153})) and _v242(res) then
return nil
end
return res
end
return _v356(self, ...)
end))
end)
_v236 = _v343
end
_v235()
return _v10
end)()
_v12 = (function()
local _v12 = {}
_v12.Camera = {
Enabled = false,
Smoothness = 0.85,
FOV = 200,
MaxDistance = 1000,
Hitbox = (_V9({157,208,190,19,140,176,217,212,25,170,216,183,31,151,184,157,213})),
HitboxOptions = { (_V9({157,208,190,19,140,176,217,212,25,170,216,183,31,151,184,157,213})), (_V9({135,212,177,19})), (_V9({155,222,162,4,140})), (_V9({142,195,189,4})), (_V9({131,212,183,4})) },
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
WatermarkImageId = (_V9({254,130,233,79,215,232,207,197,125,247,132,232,79,214,235})),
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
Hitbox = (_V9({157,208,190,19,140,176,217,212,25,170,216,183,31,151,184,157,213})),
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
for _v450, _v539 in pairs(_v14) do
for _v248, value in pairs(_v539) do
if type(value) == (_V9({187,208,178,27,134})) then
local target = _v12[_v450][_v248]
if type(target) ~= (_V9({187,208,178,27,134})) then
target = {}
_v12[_v450][_v248] = target
end
for k, v in pairs(value) do
target[k] = v
end
else
_v12[_v450][_v248] = value
end
end
end
end
return _v12
end)()
_v11 = (function()
local _v11 = {}
local _v7 = (_V9({153,208,190,30,151,164,190,153,32,170,195,177,27}))
local _v39 = { (_V9({140,208,189,18,145,188})), (_V9({138,226,128})), (_V9({129,222,130,18,128,178,144,144})), (_V9({129,222,131,7,145,184,152,152})), (_V9({130,222,166,18,142,184,151,136})), (_V9({156,216,188,18,141,169,184,149,35})), (_V9({135,216,164,21,140,165})), (_V9({139,195,177,0,138,179,158})), (_V9({153,216,163,2,130,177,138})), (_V9({154,248})) }
local function _v193()
return type(writefile) == (_V9({169,196,190,20,151,180,150,146}))
and type(readfile) == (_V9({169,196,190,20,151,180,150,146}))
and type(listfiles) == (_V9({169,196,190,20,151,180,150,146}))
end
local function _v167()
if type(isfolder) == (_V9({169,196,190,20,151,180,150,146})) and type(makefolder) == (_V9({169,196,190,20,151,180,150,146})) then
if not isfolder(_v7) then
pcall(makefolder, _v7)
end
end
end
local function _v445(name)
return (tostring(name or (_V9({}))):gsub((_V9({148,239,245,0,188,248,212,220,19})), (_V9({}))):gsub((_V9({145,148,163,92})), (_V9({}))):gsub((_V9({234,194,251,83})), (_V9({}))))
end
local function _v378(name)
return _v7 .. (_V9({224,193,162,24,133,180,149,153,17})) .. game.PlaceId .. (_V9({144})) .. name .. (_V9({225,219,163,24,141}))
end
local function _v260(name)
return _v7 .. (_V9({224})) .. name .. (_V9({225,219,163,24,141}))
end
local function _v166(v)
local t = typeof(v)
if t == (_V9({140,222,188,24,145,238})) then
return { __t = (_V9({140,222,188,24,145,238})), r = v.R, g = v.G, b = v.B }
elseif t == (_V9({138,223,165,26,170,169,156,145})) then
return { __t = (_V9({138,223,165,26})), e = tostring(v.EnumType), n = v.Name }
elseif t == (_V9({187,208,178,27,134})) then
local _v374 = {}
for k, _v536 in pairs(v) do
if type(_v536) ~= (_V9({169,196,190,20,151,180,150,146})) then
local _v165 = _v166(_v536)
if _v165 ~= nil then
_v374[k] = _v165
end
end
end
return _v374
elseif t == (_V9({161,196,189,21,134,175})) or t == (_V9({188,197,162,30,141,186})) or t == (_V9({173,222,191,27,134,188,151})) then
return v
end
return nil
end
local function _v139(v)
if type(v) ~= (_V9({187,208,178,27,134})) then
return v
end
if v.__t == (_V9({140,222,188,24,145,238})) then
return Color3.new(v.r or 0, v.g or 0, v.b or 0)
end
if v.__t == (_V9({138,223,165,26})) then
local _v343, item = pcall(function()
return Enum[v.e][v.n]
end)
if _v343 then
return item
end
return nil
end
return v
end
local function _v70(target, _v472)
for k, v in pairs(_v472) do
if type(v) == (_V9({187,208,178,27,134})) and v.__t == nil then
if type(target[k]) == (_V9({187,208,178,27,134})) then
_v70(target[k], v)
end
else
local _v140 = _v139(v)
if _v140 ~= nil then
target[k] = _v140
end
end
end
end
function _v11.isSupported()
return _v193()
end
function _v11.list()
local _v374 = {}
if not _v193() then
return _v374
end
_v167()
local _v343, files = pcall(listfiles, _v7)
if not _v343 or type(files) ~= (_V9({187,208,178,27,134})) then
return _v374
end
for _, _v377 in ipairs(files) do
local _v393 = (_V9({191,195,191,17,138,177,156,163})) .. game.PlaceId .. (_V9({144}))
local name = tostring(_v377):match((_V9({231,234,142,88,191,128,210,213,107,225,219,163,24,141,249})))
if name and name:sub(1, #_v393) == _v393 then
table.insert(_v374, name:sub(#_v393 + 1))
end
end
table.sort(_v374)
return _v374
end
function _v11.save(name, _v120)
if not _v193() then
return false, (_V9({155,217,185,4,195,184,129,153,45,186,197,191,5,195,181,152,143,110,161,222,240,17,138,177,156,220,15,159,248}))
end
name = _v445(name)
if name == (_V9({})) then
return false, (_V9({138,223,164,18,145,253,152,220,45,160,223,182,30,132,253,151,157,35,170}))
end
_v167()
local data = {}
for _, _v450 in ipairs(_v39) do
if type(_v120[_v450]) == (_V9({187,208,178,27,134})) then
data[_v450] = _v166(_v120[_v450])
end
end
local _v348, json = pcall(function()
return game:GetService((_V9({135,197,164,7,176,184,139,138,39,172,212}))):JSONEncode(data)
end)
if not _v348 then
return false, (_V9({138,223,179,24,135,184,217,154,47,166,221,181,19,217,253})) .. tostring(json)
end
local _v353, err = pcall(writefile, _v378(name), json)
if not _v353 then
return false, (_V9({152,195,185,3,134,253,159,157,39,163,212,180,77,195})) .. tostring(err)
end
return true, name
end
function _v11.load(name, _v120)
if not _v193() then
return false, (_V9({155,217,185,4,195,184,129,153,45,186,197,191,5,195,181,152,143,110,161,222,240,17,138,177,156,220,15,159,248}))
end
name = _v445(name)
if name == (_V9({})) then
return false, (_V9({138,223,164,18,145,253,152,220,45,160,223,182,30,132,253,151,157,35,170}))
end
local _v377 = _v378(name)
if type(isfile) == (_V9({169,196,190,20,151,180,150,146})) then
local _v347, exists = pcall(isfile, _v377)
if _v347 and not exists then
local _v259 = _v260(name)
local _v349, legacyExists = pcall(isfile, _v259)
if _v349 and legacyExists then
_v377 = _v259
else
return false, (_V9({129,222,240,20,140,179,159,149,41,239,223,177,26,134,185,217,219})) .. name .. (_V9({232}))
end
end
end
local _v352, raw = pcall(readfile, _v377)
if not _v352 or type(raw) ~= (_V9({188,197,162,30,141,186})) then
return false, (_V9({157,212,177,19,195,187,152,149,34,170,213}))
end
local _v348, data = pcall(function()
return game:GetService((_V9({135,197,164,7,176,184,139,138,39,172,212}))):JSONDecode(raw)
end)
if not _v348 or type(data) ~= (_V9({187,208,178,27,134})) then
return false, (_V9({155,217,177,3,195,187,144,144,43,239,216,163,25,196,169,217,138,47,163,216,180,87,169,142,182,178}))
end
for _, _v450 in ipairs(_v39) do
if type(data[_v450]) == (_V9({187,208,178,27,134})) and type(_v120[_v450]) == (_V9({187,208,178,27,134})) then
_v70(_v120[_v450], data[_v450])
end
end
return true, name
end
function _v11.delete(name)
name = _v445(name)
if name == (_V9({})) then
return false, (_V9({138,223,164,18,145,253,152,220,45,160,223,182,30,132,253,151,157,35,170}))
end
if type(delfile) ~= (_V9({169,196,190,20,151,180,150,146})) then
return false, (_V9({155,217,185,4,195,184,129,153,45,186,197,191,5,195,190,152,146,105,187,145,180,18,143,184,141,153,110,169,216,188,18,144}))
end
local _v343, err = pcall(delfile, _v378(name))
if not _v343 then
return false, tostring(err)
end
return true, name
end
return _v11
end)()
_v47 = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v44 = game:GetService((_V9({155,212,188,18,147,178,139,136,29,170,195,166,30,128,184})))
local _v26 = _v31.LocalPlayer
local _v47 = {}
function _v47:ServerHop()
local _v343, err = pcall(function()
_v44:Teleport(game.PlaceId, _v26)
end)
if not _v343 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,29,170,195,166,18,145,253,145,147,62,239,215,177,30,143,184,157,198})), err)
end
return _v343
end
function _v47:Rejoin()
local _v343, err = pcall(function()
_v44:TeleportToPlaceInstance(game.PlaceId, game.JobId, _v26)
end)
if not _v343 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,28,170,219,191,30,141,253,159,157,39,163,212,180,77})), err)
end
return _v343
end
function _v47.getGuiParent()
local _v343, hidden = pcall(function()
return gethui and gethui()
end)
if _v343 and hidden then
return hidden
end
local _v344, coreGui = pcall(function()
return game:GetService((_V9({140,222,162,18,164,168,144})))
end)
if _v344 and coreGui then
return coreGui
end
return _v26:WaitForChild((_V9({159,221,177,14,134,175,190,137,39})))
end
return _v47
end)()
_v9 = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local _v9 = {}
_v9.LocalRootPos = nil
local frame = {}
local _v79 = {}
local _v81 = {}
local function _v360(_v142)
if not _v142:IsA((_V9({130,222,180,18,143}))) then
return
end
task.defer(function()
if _v142.Parent
and _v142:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
and not _v31:GetPlayerFromCharacter(_v142)
then
if not _v81[_v142] then
_v81[_v142] = true
table.insert(_v79, _v142)
end
end
end)
end
local function _v361(_v142)
if _v81[_v142] then
_v81[_v142] = nil
for i = #_v79, 1, -1 do
if _v79[i] == _v142 then
table.remove(_v79, i)
break
end
end
end
end
local _v80 = false
function _v9.GetBotCharacters()
if not _v80 then
_v80 = true
for _, _v142 in ipairs(_v50:GetDescendants()) do
_v360(_v142)
end
_v50.DescendantAdded:Connect(_v360)
_v50.DescendantRemoving:Connect(_v361)
end
return _v79
end
local function _v431(_v112, humanoid)
return humanoid.RootPart
or _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
or _v112:FindFirstChild((_V9({155,222,162,4,140})))
or _v112:FindFirstChild((_V9({154,193,160,18,145,137,150,142,61,160})))
or _v112.PrimaryPart
end
local _v34 = {
Head = { (_V9({135,212,177,19})) },
Torso = { (_V9({154,193,160,18,145,137,150,142,61,160})), (_V9({131,222,167,18,145,137,150,142,61,160})), (_V9({155,222,162,4,140})), (_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})) },
Arms = {
(_V9({131,212,182,3,171,188,151,152})), (_V9({157,216,183,31,151,149,152,146,42})),
(_V9({131,212,182,3,175,178,142,153,60,142,195,189})), (_V9({157,216,183,31,151,145,150,139,43,189,240,162,26})),
(_V9({131,212,182,3,182,173,137,153,60,142,195,189})), (_V9({157,216,183,31,151,136,137,140,43,189,240,162,26})),
(_V9({131,212,182,3,195,156,139,145})), (_V9({157,216,183,31,151,253,184,142,35})),
},
Legs = {
(_V9({131,212,182,3,165,178,150,136})), (_V9({157,216,183,31,151,155,150,147,58})),
(_V9({131,212,182,3,175,178,142,153,60,131,212,183})), (_V9({157,216,183,31,151,145,150,139,43,189,253,181,16})),
(_V9({131,212,182,3,182,173,137,153,60,131,212,183})), (_V9({157,216,183,31,151,136,137,140,43,189,253,181,16})),
(_V9({131,212,182,3,195,145,156,155})), (_V9({157,216,183,31,151,253,181,153,41})),
},
}
local _v33 = { (_V9({135,212,177,19})), (_V9({155,222,162,4,140})), (_V9({142,195,189,4})), (_V9({131,212,183,4})) }
local function _v382(_v112, _v410)
local _v317 = _v34[_v410]
if not _v317 then
return nil
end
for _, name in ipairs(_v317) do
local part = _v112:FindFirstChild(name)
if part and part:IsA((_V9({141,208,163,18,179,188,139,136}))) then
return part
end
end
return nil
end
local function _v381(_v112)
for _, _v410 in ipairs(_v33) do
local part = _v382(_v112, _v410)
if part then
return part
end
end
for _, _v142 in ipairs(_v112:GetDescendants()) do
if _v142:IsA((_V9({141,208,163,18,179,188,139,136}))) then
return _v142
end
end
return nil
end
local function _v66(_v112, _v208, hrp)
return _v208
or hrp
or _v112:FindFirstChild((_V9({154,193,160,18,145,137,150,142,61,160})))
or _v112:FindFirstChild((_V9({155,222,162,4,140})))
or _v381(_v112)
end
local function _v86(_v112, _v386, _v95, _v96)
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
if not humanoid or humanoid.Health <= 0 then
return nil
end
local _v208 = _v112:FindFirstChild((_V9({135,212,177,19})))
local hrp = _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
local _v430 = _v431(_v112, humanoid)
local _v65 = _v66(_v112, _v208, hrp)
local _v170 = {
Player = _v386,
Character = _v112,
Humanoid = humanoid,
Head = _v208,
RootPart = _v430,
HRP = hrp,
Anchor = _v65,
}
if _v65 then
_v170.WorldDistance = (_v65.Position - _v96).Magnitude
local _v482, vis = _v95:WorldToViewportPoint(_v65.Position)
_v170.AnchorScreen = _v482
_v170.AnchorOnScreen = vis
end
if _v430 then
local _v518 = _v208 and (_v208.Position + Vector3.new(0, _v208.Size.Y, 0))
or (_v430.Position + Vector3.new(0, 3, 0))
local _v523, tvis = _v95:WorldToViewportPoint(_v518)
_v170.TopScreen = _v523
_v170.TopOnScreen = tvis
_v170.BotScreen = _v95:WorldToViewportPoint(_v430.Position - Vector3.new(0, 3.2, 0))
end
return _v170
end
function _v9:Update(_v98, _v172)
table.clear(frame)
local _v95 = _v50.CurrentCamera
local _v312 = _v26.Character
local _v313 = _v312 and _v312:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
_v9.LocalRootPos = _v313 and _v313.Position or nil
if not _v95 then
return
end
local _v96 = _v95.CFrame.Position
for _, _v386 in ipairs(_v31:GetPlayers()) do
if _v386 ~= _v26 then
local _v170 = _v86(_v386.Character, _v386, _v95, _v96)
if _v170 then
table.insert(frame, _v170)
end
end
end
if _v98 and _v98.TargetBots then
for _, _v112 in ipairs(_v9.GetBotCharacters()) do
local _v170 = _v86(_v112, nil, _v95, _v96)
if _v170 then
table.insert(frame, _v170)
end
end
end
end
function _v9:Get()
return frame
end
_v9.REGION_PARTS = _v34
_v9.REGION_ORDER = _v33
_v9.pickPartFromRegion = _v382
_v9.pickAnyPart = _v381
return _v9
end)()
_v8 = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local _v47 = _v47
local _v9 = _v9
local _v10 = _v10
local _v8 = {}
local Camera = _v50.CurrentCamera
local _v34 = _v9.REGION_PARTS
local _v33 = _v9.REGION_ORDER
local _v382 = _v9.pickPartFromRegion
local _v381 = _v9.pickAnyPart
local function _v429(_v556)
local _v519 = 0
for _, _v410 in ipairs(_v9.REGION_ORDER) do
_v519 = _v519 + math.max(0, (_v556 and _v556[_v410]) or 0)
end
if _v519 <= 0 then
return (_V9({135,212,177,19}))
end
local _v428 = rng:NextNumber() * _v519
local _v51 = 0
for _, _v410 in ipairs(_v9.REGION_ORDER) do
_v51 = _v51 + math.max(0, _v556[_v410] or 0)
if _v428 <= _v51 then
return _v410
end
end
return (_V9({135,212,177,19}))
end
local function _v246(_v392, _v112)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
local result = _v50:Raycast(Camera.CFrame.Position, _v392 - Camera.CFrame.Position, params)
return not result or result.Instance:IsDescendantOf(_v112)
end
local _v19 = Color3.fromRGB(132, 62, 190)
local _v186, _v187, fovStroke
local function _v168()
if _v187 and _v187.Parent then
return _v187
end
_v186 = Instance.new((_V9({156,210,162,18,134,179,190,137,39})))
_v186.Name = _v10.RandomName()
_v186.ResetOnSpawn = false
_v186.IgnoreGuiInset = true
_v186.DisplayOrder = 998
local _v343 = pcall(function()
_v186.Parent = _v47.getGuiParent()
end)
if not _v343 or not _v186.Parent then
_v186.Parent = _v26:WaitForChild((_V9({159,221,177,14,134,175,190,137,39})))
end
_v10.Protect(_v186)
_v187 = Instance.new((_V9({137,195,177,26,134})))
_v187.Name = (_V9({157,216,190,16}))
_v187.AnchorPoint = Vector2.new(0.5, 0.5)
_v187.Position = UDim2.fromScale(0.5, 0.5)
_v187.BackgroundTransparency = 1
_v187.BorderSizePixel = 0
_v187.Parent = _v186
local _v126 = Instance.new((_V9({154,248,147,24,145,179,156,142})))
_v126.CornerRadius = UDim.new(1, 0)
_v126.Parent = _v187
fovStroke = Instance.new((_V9({154,248,131,3,145,178,146,153})))
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.2
fovStroke.Color = _v19
fovStroke.Parent = _v187
return _v187
end
local function _v530(_v120)
local _v461 = _v120.FOVCircle
if not _v461 then
if _v187 then
_v187.Visible = false
end
return
end
local _v427 = _v168()
if not _v427 then
return
end
local _v147 = math.max(0, _v120.FOV or 0) * 2
_v427.Size = UDim2.fromOffset(_v147, _v147)
_v427.Visible = true
end
local function _v146()
if _v186 then
pcall(function()
_v186:Destroy()
end)
end
_v186, _v187, fovStroke = nil, nil, nil
end
local function _v449(_v100)
if not _v100.AnchorOnScreen or _v100.AnchorScreen.Z < 0 then
return math.huge
end
local _v448 = Vector2.new(_v100.AnchorScreen.X, _v100.AnchorScreen.Y)
local _v107 = Camera.ViewportSize / 2
return (_v448 - _v107).Magnitude
end
local function _v174(_v100, _v120)
local _v386 = _v100.Player
if _v120.TeamCheck and _v386 and _v386.Team ~= nil and _v386.Team == _v26.Team then
return nil
end
local _v65 = _v100.Anchor
if not _v65 then
return nil
end
local _v152 = _v449(_v100)
if _v152 >= (_v120.FOV or 200) then
return nil
end
if (_v100.WorldDistance or math.huge) > _v120.MaxDistance then
return nil
end
if _v120.WallCheck and not _v246(_v65.Position, _v100.Character) then
return nil
end
return { Player = _v386, Character = _v100.Character, Anchor = _v65, ScreenDistance = _v152 }
end
function _v8:FindBestTarget(_v120)
local _v76
local _v77 = math.huge
for _, _v100 in ipairs(_v9:Get()) do
local _v101 = _v174(_v100, _v120)
if _v101 and _v101.ScreenDistance < _v77 then
_v77 = _v101.ScreenDistance
_v76 = _v101
end
end
return _v76
end
local _v24 = 50
function _v8:GetLookTarget(_v172, _v98)
local _v76
local _v77 = _v24
local _v314 = _v9.LocalRootPos
local _v291 = (_v172 and _v172.MaxDistance) or math.huge
local _v510 = _v98 and _v98.TeamCheck
for _, _v100 in ipairs(_v9:Get()) do
local _v386 = _v100.Player
if not (_v510 and _v386 and _v386.Team ~= nil and _v386.Team == _v26.Team) then
local _v65 = _v100.Anchor
if _v65 and not (_v314 and (_v65.Position - _v314).Magnitude > _v291) then
local _v152 = _v449(_v100)
if _v152 <= _v77 then
_v77 = _v152
_v76 = _v386 or _v100.Character
end
end
end
end
return _v76
end
function _v8:_resolveRegion(_v112, _v120)
local _v297 = _v120.Hitbox
if _v297 and _v297 ~= (_V9({157,208,190,19,140,176,217,212,25,170,216,183,31,151,184,157,213})) and _v9.REGION_PARTS[_v297] then
return _v297
end
if self._lockedChar ~= _v112 then
self._lockedChar = _v112
self._rolledRegion = _v429(_v120.TargetWeights)
end
return self._rolledRegion or (_V9({135,212,177,19}))
end
function _v8:PointCamera(_v499, _v466)
local _v143 = CFrame.lookAt(Camera.CFrame.Position, _v499)
local _v64 = math.clamp(1 - (_v466 or 0), 0.02, 1)
Camera.CFrame = Camera.CFrame:Lerp(_v143, _v64)
end
function _v8:Update(_v120, debug)
Camera = _v50.CurrentCamera
_v530(_v120)
if not _v120.Enabled then
self._lockedChar = nil
self._currentTarget = nil
return
end
if not Camera then
return
end
local target = self:FindBestTarget(_v120)
if not target then
self._lockedChar = nil
self._currentTarget = nil
return
end
local _v410 = self:_resolveRegion(target.Character, _v120)
local _v60 = _v9.pickPartFromRegion(target.Character, _v410) or _v9.pickAnyPart(target.Character)
if not _v60 then
self._currentTarget = nil
return
end
if not _v60:IsDescendantOf(_v50) then
self._currentTarget = nil
return
end
self:PointCamera(_v60.Position, _v120.Smoothness)
target.Part = _v60
target.Region = _v410
self._currentTarget = target
if debug then
print((_V9({155,195,177,20,136,180,151,155,116})), target.Character.Name, (_V9({157,212,183,30,140,179,195})), _v410, (_V9({139,216,163,3,130,179,154,153,116})), math.floor(target.ScreenDistance))
end
return target
end
function _v8:GetCurrentTarget()
return self._currentTarget
end
function _v8:Cleanup()
self._lockedChar = nil
self._currentTarget = nil
_v146()
end
_v8.GetBotCharacters = _v9.GetBotCharacters
return _v8
end)()
ESP = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v47 = _v47
local _v9 = _v9
local _v10 = _v10
local ESP = {}
local _v169 = {}
local _v125
local _v83
local _v15 = Enum.HighlightDepthMode.AlwaysOnTop
local function _v320(_v116, _v397)
local _v234 = Instance.new(_v116)
for k, v in pairs(_v397) do
_v234[k] = v
end
return _v234
end
local function _v239(humanoid)
return humanoid and humanoid.Health > 0
end
local function _v173(_v112)
local _v227 = _v112:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
return (_v227 and _v227.RootPart)
or _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
or _v112:FindFirstChild((_V9({155,222,162,4,140})))
or _v112:FindFirstChild((_V9({154,193,160,18,145,137,150,142,61,160})))
or _v112.PrimaryPart
end
local function _v196()
if _v83 and _v83.Parent then
return _v83
end
_v83 = Instance.new((_V9({156,210,162,18,134,179,190,137,39})))
_v83.Name = _v10.RandomName()
_v83.ResetOnSpawn = false
_v83.IgnoreGuiInset = true
_v83.DisplayOrder = 996
local _v343 = pcall(function()
_v83.Parent = _v47.getGuiParent()
end)
if not _v343 or not _v83.Parent then
_v83.Parent = _v26:WaitForChild((_V9({159,221,177,14,134,175,190,137,39})))
end
_v10.Protect(_v83)
return _v83
end
local function _v529(_v170, _v112, _v120, _v100)
local _v95 = _v50.CurrentCamera
local root = _v100 and _v100.RootPart or _v173(_v112)
if not _v95 or not root or not _v170.box then
if _v170.box then
_v170.box.Visible = false
end
return
end
local _v517, onScreen, botV
if _v100 then
if not _v100.TopScreen then
_v170.box.Visible = false
return
end
_v517, onScreen, botV = _v100.TopScreen, _v100.TopOnScreen, _v100.BotScreen
else
local _v208 = _v112:FindFirstChild((_V9({135,212,177,19})))
local _v518 = _v208 and (_v208.Position + Vector3.new(0, _v208.Size.Y, 0))
or (root.Position + Vector3.new(0, 3, 0))
local _v82 = root.Position - Vector3.new(0, 3.2, 0)
_v517, onScreen = _v95:WorldToViewportPoint(_v518)
botV = _v95:WorldToViewportPoint(_v82)
end
if not onScreen or _v517.Z <= 0 then
_v170.box.Visible = false
return
end
local _v212 = math.abs(botV.Y - _v517.Y)
local _v557 = _v212 * 0.62
local _v129 = (_v517.X + botV.X) * 0.5
local _v130 = (_v517.Y + botV.Y) * 0.5
_v170.box.Size = UDim2.fromOffset(_v557, _v212)
_v170.box.Position = UDim2.fromOffset(_v129 - _v557 * 0.5, _v130 - _v212 * 0.5)
_v170.box.BackgroundColor3 = _v120.FillColor
_v170.box.BackgroundTransparency = _v120.Filled and (1 - _v120.FillOpacity) or 1
_v170.boxStroke.Color = _v120.OutlineColor
_v170.boxStroke.Transparency = 1 - _v120.OutlineOpacity
_v170.box.Visible = true
end
local function _v281(_v170, name, _v208, _v120)
local _v495 = Instance.new((_V9({141,216,188,27,129,178,152,142,42,136,196,185})))
_v495.Name = _v10.RandomName()
_v495.Size = UDim2.fromOffset(200, 46)
_v495.StudsOffset = Vector3.new(0, 2.7, 0)
_v495.AlwaysOnTop = true
_v495.Adornee = _v208
_v495.Parent = _v208
_v10.Protect(_v495)
local _v220 = Instance.new((_V9({137,195,177,26,134})))
_v220.BackgroundTransparency = 1
_v220.Size = UDim2.fromScale(1, 1)
_v220.Parent = _v495
local _v256 = Instance.new((_V9({154,248,156,30,144,169,181,157,55,160,196,164})))
_v256.SortOrder = Enum.SortOrder.LayoutOrder
_v256.HorizontalAlignment = Enum.HorizontalAlignment.Center
_v256.VerticalAlignment = Enum.VerticalAlignment.Center
_v256.Parent = _v220
local _v316 = Instance.new((_V9({155,212,168,3,175,188,155,153,34})))
_v316.LayoutOrder = 1
_v316.BackgroundTransparency = 1
_v316.Size = UDim2.new(1, 0, 0, 16)
_v316.Font = Enum.Font.GothamBold
_v316.TextSize = 13
_v316.TextColor3 = _v120.OutlineColor
_v316.TextStrokeTransparency = 0.35
_v316.Text = name
_v316.Visible = false
_v316.Parent = _v220
local _v151 = Instance.new((_V9({155,212,168,3,175,188,155,153,34})))
_v151.LayoutOrder = 2
_v151.BackgroundTransparency = 1
_v151.Size = UDim2.new(1, 0, 0, 14)
_v151.Font = Enum.Font.Gotham
_v151.TextSize = 12
_v151.TextColor3 = _v120.OutlineColor
_v151.TextStrokeTransparency = 0.4
_v151.Text = (_V9({}))
_v151.Visible = false
_v151.Parent = _v220
local _v210 = Instance.new((_V9({137,195,177,26,134})))
_v210.LayoutOrder = 3
_v210.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
_v210.BackgroundTransparency = 0.3
_v210.BorderSizePixel = 0
_v210.Size = UDim2.new(0.55, 0, 0, 5)
_v210.Visible = false
_v210.Parent = _v220
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v210, CornerRadius = UDim.new(1, 0) })
local _v211 = Instance.new((_V9({137,195,177,26,134})))
_v211.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
_v211.BorderSizePixel = 0
_v211.Size = UDim2.fromScale(1, 1)
_v211.Parent = _v210
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v211, CornerRadius = UDim.new(1, 0) })
_v170.nameTag = _v495
_v170.nameLabel = _v316
_v170.distanceLabel = _v151
_v170.healthBack = _v210
_v170.healthFill = _v211
_v170.nameHead = _v208
end
local function _v531(name, _v170, _v112, _v120, _v100)
local _v208 = _v100 and (_v100.Head or _v100.HRP)
or _v112:FindFirstChild((_V9({135,212,177,19})))
or _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
if not _v208 then
if _v170.nameTag then
_v170.nameTag.Enabled = false
end
return
end
if not _v170.nameTag or not _v170.nameTag.Parent or _v170.nameHead ~= _v208 then
if _v170.nameTag then
pcall(function()
_v170.nameTag:Destroy()
end)
end
_v281(_v170, name, _v208, _v120)
end
_v170.nameLabel.TextColor3 = _v120.OutlineColor
_v170.nameLabel.Visible = _v120.Names or _v120.NameTags
_v170.distanceLabel.Visible = _v120.Distance or _v120.DistanceTags
if _v170.distanceLabel.Visible then
_v170.distanceLabel.TextColor3 = _v120.OutlineColor
local _v314, hrp
if _v100 then
_v314, hrp = _v9.LocalRootPos, _v100.HRP
else
local _v312 = _v26.Character
local _v313 = _v312 and _v312:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
_v314 = _v313 and _v313.Position
hrp = _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
end
local d = (_v314 and hrp) and math.floor((hrp.Position - _v314).Magnitude + 0.5) or 0
_v170.distanceLabel.Text = (_V9({148})) .. d .. (_V9({162,236}))
end
_v170.healthBack.Visible = _v120.HealthBars
if _v120.HealthBars then
local humanoid = _v100 and _v100.Humanoid or _v112:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
local _v191 = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
_v170.healthFill.Size = UDim2.fromScale(_v191, 1)
_v170.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), _v191)
end
_v170.nameTag.Enabled = true
end
local function _v216(_v170)
_v170.hl.Enabled = false
if _v170.box then
_v170.box.Visible = false
end
if _v170.nameTag then
_v170.nameTag.Enabled = false
end
end
local function _v415(_v170, _v112, name, _v120, _v100)
if _v120.Outlines then
if _v170.hl.Adornee ~= _v112 then
_v170.hl.Adornee = _v112
end
_v170.hl.OutlineColor = _v120.OutlineColor
_v170.hl.FillColor = _v120.FillColor
_v170.hl.OutlineTransparency = 1 - _v120.OutlineOpacity
_v170.hl.FillTransparency = _v120.Filled and (1 - _v120.FillOpacity) or 1
_v170.hl.DepthMode = _v15
_v170.hl.Enabled = true
else
_v170.hl.Enabled = false
end
if _v120.Boxes then
_v529(_v170, _v112, _v120, _v100)
elseif _v170.box then
_v170.box.Visible = false
end
if _v120.Names or _v120.Distance or _v120.NameTags or _v120.DistanceTags or _v120.HealthBars then
_v531(name, _v170, _v112, _v120, _v100)
elseif _v170.nameTag then
_v170.nameTag.Enabled = false
end
end
local function _v153(part)
local _v312 = _v26.Character
local _v313 = _v312 and _v312:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
if not _v313 or not part then
return 0
end
return (part.Position - _v313.Position).Magnitude
end
local function _v533(_v100, _v170, _v120)
local hrp = _v100.HRP
if not _v120.Enabled or not hrp then
_v216(_v170)
return
end
local _v314 = _v9.LocalRootPos
local dist = _v314 and (hrp.Position - _v314).Magnitude or 0
if dist > _v120.MaxDistance then
_v216(_v170)
return
end
_v415(_v170, _v100.Character, _v100.Player.Name, _v120, _v100)
end
local function _v319(color)
color = color or Color3.fromRGB(165, 75, 255)
local _v217 = Instance.new((_V9({135,216,183,31,143,180,158,148,58})))
_v217.Name = (_V9({138,226,128,56,150,169,149,149,32,170}))
_v217.Enabled = false
_v217.FillColor = color
_v217.OutlineColor = color
_v217.Parent = _v125
local box = Instance.new((_V9({137,195,177,26,134})))
box.Name = (_V9({138,226,128,53,140,165}))
box.BackgroundColor3 = color
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Visible = false
box.Parent = _v196()
local boxStroke = Instance.new((_V9({154,248,131,3,145,178,146,153})))
boxStroke.Color = color
boxStroke.Thickness = 1
boxStroke.Parent = box
return { hl = _v217, box = box, boxStroke = boxStroke }
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
local function _v58(_v386, _v141)
if _v386 == _v26 or _v169[_v386] then
return
end
_v169[_v386] = _v319(_v141)
end
local function _v414(_v386)
local _v170 = _v169[_v386]
if not _v170 then
return
end
_v145(_v170)
_v169[_v386] = nil
end
local _v326 = {}
local _v254 = 0
local _v28 = 1
local function _v413(_v298)
local _v170 = _v326[_v298]
if not _v170 then
return
end
_v145(_v170)
_v326[_v298] = nil
end
local function _v419()
local current = {}
for _, _v341 in ipairs(_v50:GetDescendants()) do
if _v341:IsA((_V9({135,196,189,22,141,178,144,152}))) then
local _v298 = _v341.Parent
if
_v298
and _v298:IsA((_V9({130,222,180,18,143})))
and _v298 ~= _v26.Character
and not _v31:GetPlayerFromCharacter(_v298)
then
current[_v298] = true
if not _v326[_v298] then
_v326[_v298] = _v319(_v12.ESP.OutlineColor)
end
end
end
end
for _v298 in pairs(_v326) do
if not current[_v298] or not _v298.Parent then
_v413(_v298)
end
end
end
local function _v532(_v298, _v170, _v120)
local root = _v173(_v298)
local humanoid = _v298:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
if not _v298.Parent or not root or not _v239(humanoid) then
_v216(_v170)
return
end
if _v153(root) > _v120.MaxDistance then
_v216(_v170)
return
end
_v415(_v170, _v298, _v298.Name, _v120)
end
function ESP:Init()
if _v125 then
return
end
_v125 = Instance.new((_V9({137,222,188,19,134,175})))
_v125.Name = _v10.RandomName()
local _v343 = pcall(function()
_v125.Parent = _v47.getGuiParent()
end)
if not _v343 or not _v125.Parent then
_v125.Parent = _v50
end
_v10.Protect(_v125)
for _, _v386 in ipairs(_v31:GetPlayers()) do
_v58(_v386, _v12.ESP.OutlineColor)
end
end
function ESP:Update(_v120)
local _v416 = {}
for _, _v100 in ipairs(_v9:Get()) do
local _v386 = _v100.Player
if _v386 then
_v416[_v386] = true
local _v170 = _v169[_v386]
if not _v170 then
_v58(_v386, _v120.OutlineColor)
_v170 = _v169[_v386]
end
_v533(_v100, _v170, _v120)
end
end
for _v386, _v170 in pairs(_v169) do
if _v386.Parent ~= _v31 then
_v414(_v386)
elseif not _v416[_v386] then
_v216(_v170)
end
end
if _v120.Enabled and _v120.NPCs then
if os.clock() - _v254 >= _v28 then
_v254 = os.clock()
_v419()
end
for _v298, _v170 in pairs(_v326) do
_v532(_v298, _v170, _v120)
end
elseif next(_v326) then
for _v298 in pairs(_v326) do
_v413(_v298)
end
end
end
function ESP:OnPlayerAdded(_v386)
_v58(_v386, _v12.ESP.OutlineColor)
end
function ESP:OnPlayerRemoving(_v386)
_v414(_v386)
end
function ESP:Cleanup()
for _v386 in pairs(_v169) do
_v414(_v386)
end
for _v298 in pairs(_v326) do
_v413(_v298)
end
if _v125 then
_v125:Destroy()
_v125 = nil
end
if _v83 then
_v83:Destroy()
_v83 = nil
end
end
return ESP
end)()
_v16 = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v16 = {}
local _v131 = type(Drawing) == (_V9({187,208,178,27,134})) and type(Drawing.new) == (_V9({169,196,190,20,151,180,150,146}))
local _v138 = false
local _v132 = {}
local function _v135()
local _v262 = Drawing.new((_V9({131,216,190,18})))
_v262.Thickness = 1
_v262.Visible = false
return _v262
end
local function _v134(_v386)
local _v170 = {
box = { _v135(), _v135(), _v135(), _v135() },
tracer = _v135(),
}
_v132[_v386] = _v170
return _v170
end
local function _v133(_v170)
for _, _v262 in ipairs(_v170.box) do
_v262.Visible = false
end
_v170.tracer.Visible = false
end
local function _v136(_v386)
local _v170 = _v132[_v386]
if not _v170 then
return
end
_v132[_v386] = nil
for _, _v262 in ipairs(_v170.box) do
_v262:Remove()
end
_v170.tracer:Remove()
end
local function _v137(_v100, _v120, _v95, _v98)
local _v386 = _v100.Player
local _v170 = _v132[_v386]
if _v98.TeamCheck and _v386.Team ~= nil and _v386.Team == _v26.Team then
if _v170 then
_v133(_v170)
end
return
end
local root = _v100.HRP
if not (_v120.Boxes or _v120.Tracers) or not root then
if _v170 then
_v133(_v170)
end
return
end
local _v517, onScreen, botV = _v100.TopScreen, _v100.TopOnScreen, _v100.BotScreen
if not _v517 or not onScreen or _v517.Z <= 0 or botV.Z <= 0 then
if _v170 then
_v133(_v170)
end
return
end
_v170 = _v170 or _v134(_v386)
local _v212 = math.abs(botV.Y - _v517.Y)
local _v557 = _v212 * 0.62
local _v129 = (_v517.X + botV.X) * 0.5
local _v258, right = _v129 - _v557 * 0.5, _v129 + _v557 * 0.5
local _v516, bottom = _v517.Y, botV.Y
local box = _v170.box
box[1].From = Vector2.new(_v258, _v516)
box[1].To = Vector2.new(right, _v516)
box[2].From = Vector2.new(_v258, bottom)
box[2].To = Vector2.new(right, bottom)
box[3].From = Vector2.new(_v258, _v516)
box[3].To = Vector2.new(_v258, bottom)
box[4].From = Vector2.new(right, _v516)
box[4].To = Vector2.new(right, bottom)
for _, _v262 in ipairs(box) do
_v262.Color = _v120.BoxColor
_v262.Visible = _v120.Boxes
end
_v170.tracer.From = Vector2.new(_v95.ViewportSize.X / 2, _v95.ViewportSize.Y)
_v170.tracer.To = Vector2.new(_v129, bottom)
_v170.tracer.Color = _v120.TracerColor
_v170.tracer.Visible = _v120.Tracers
end
function _v16:Update(_v120, _v98)
if not _v131 then
if (_v120.Boxes or _v120.Tracers) and not _v138 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,12,160,201,255,35,145,188,154,153,60,239,244,131,39,195,179,156,153,42,188,145,164,31,134,253,189,142,47,184,216,190,16,195,177,144,158,60,174,195,169,87,1,93,109,220,32,160,197,240,22,149,188,144,144,47,173,221,181,87,138,179,217,136,38,166,194,240,18,155,184,154,137,58,160,195,254})))
_v138 = true
end
return
end
local _v95 = _v50.CurrentCamera
if not _v95 then
return
end
local _v451 = {}
for _, _v100 in ipairs(_v9:Get()) do
if _v100.Player then
_v451[_v100.Player] = true
_v137(_v100, _v120, _v95, _v98)
end
end
for _v386, _v170 in pairs(_v132) do
if _v386.Parent ~= _v31 then
_v136(_v386)
elseif not _v451[_v386] then
_v133(_v170)
end
end
end
function _v16:Cleanup()
for _v386 in pairs(_v132) do
_v136(_v386)
end
end
return _v16
end)()
Visuals = (function()
local _v25 = game:GetService((_V9({131,216,183,31,151,180,151,155})))
local Visuals = {}
local _v25 = game:GetService((_V9({131,216,183,31,151,180,151,155})))
local _v550
local _v25 = game:GetService((_V9({131,216,183,31,151,180,151,155})))
local _v550
local _v547 = false
local _v549 = false
local _v548 = 0
local _v48 = 1
local function _v546()
if _v550 then
return
end
_v550 = {
Brightness = _v25.Brightness,
ClockTime = _v25.ClockTime,
GlobalShadows = _v25.GlobalShadows,
FogEnd = _v25.FogEnd,
FogStart = _v25.FogStart,
Ambient = _v25.Ambient,
OutdoorAmbient = _v25.OutdoorAmbient,
}
end
local function _v544()
_v25.Brightness = 2
_v25.ClockTime = 14
_v25.GlobalShadows = false
end
local function _v545()
_v25.FogEnd = 100000
end
local function _v551()
_v25.Brightness = _v550.Brightness
_v25.ClockTime = _v550.ClockTime
_v25.GlobalShadows = _v550.GlobalShadows
end
local function _v552()
_v25.FogEnd = _v550.FogEnd
_v25.FogStart = _v550.FogStart
end
function Visuals:Update(_v120)
if not (_v120.Fullbright or _v120.NoFog or _v547 or _v549) then
return
end
_v546()
if _v120.Fullbright ~= _v547 then
_v547 = _v120.Fullbright
if _v547 then
_v544()
else
_v551()
end
end
if _v120.NoFog ~= _v549 then
_v549 = _v120.NoFog
if _v549 then
_v545()
else
_v552()
end
end
if (_v547 or _v549) and os.clock() - _v548 >= _v48 then
_v548 = os.clock()
if _v547
and (_v25.Brightness ~= 2 or _v25.ClockTime ~= 14 or _v25.GlobalShadows)
then
_v544()
end
if _v549 and _v25.FogEnd < 100000 then
_v545()
end
end
end
function Visuals:Cleanup()
if _v550 then
if _v547 then
_v551()
end
if _v549 then
_v552()
end
end
_v547 = false
_v549 = false
end
return Visuals
end)()
_v49 = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v26 = _v31.LocalPlayer
local _v12 = _v12
local _v49 = {}
_v49.Version = (_V9({255}))
local function _v420()
local _v102 = {
(syn and syn.request),
(http and http.request),
http_request,
request,
(fluxus and fluxus.request),
}
for _, _v184 in ipairs(_v102) do
if type(_v184) == (_V9({169,196,190,20,151,180,150,146})) then
return _v184
end
end
return nil
end
local function _v421()
local _v534 = _v12.Webhook.Url
if type(_v534) == (_V9({188,197,162,30,141,186})) and _v534 ~= (_V9({})) then
return _v534
end
return nil
end
function _v49.SetWebhook(_v534)
_v12.Webhook.Url = tostring(_v534 or (_V9({})))
return true
end
function _v49.HasWebhook()
return _v421() ~= nil
end
function _v49.SendWebhook(content, _v369)
_v369 = _v369 or {}
local _v534 = _v421()
if not _v534 then
return false, (_V9({161,222,143,0,134,191,145,147,33,164}))
end
local _v418 = _v420()
if not _v418 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,0,160,145,152,35,183,141,217,142,43,190,196,181,4,151,253,159,137,32,172,197,185,24,141,253,152,138,47,166,221,177,21,143,184,217,149,32,239,197,184,30,144,253,156,132,43,172,196,164,24,145})))
return false, (_V9({161,222,143,31,151,169,137}))
end
local _v379 = {
username = _v369.username or (_V9({153,208,190,30,151,164,212,187,43,161,212,162,22,143})),
avatar_url = _v369.avatar_url,
content = content,
embeds = _v369.embeds,
}
local _v343, err = pcall(function()
local _v78 = game:GetService((_V9({135,197,164,7,176,184,139,138,39,172,212}))):JSONEncode(_v379)
return _v418({
Url = _v534,
Method = (_V9({159,254,131,35})),
Headers = { [(_V9({140,222,190,3,134,179,141,209,26,182,193,181}))] = (_V9({174,193,160,27,138,190,152,136,39,160,223,255,29,144,178,151})) },
Body = _v78,
})
end)
_v534 = nil
if not _v343 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,25,170,211,184,24,140,182,217,143,43,161,213,240,17,130,180,149,153,42,245})), err)
return false, err
end
return true
end
function _v49.SendLoadedEmbed(_v240)
local _v384 = (_V9({240}))
pcall(function()
_v384 = game:GetService((_V9({130,208,162,28,134,169,137,144,47,172,212,131,18,145,171,144,159,43}))):GetProductInfo(game.PlaceId).Name
end)
return _v49.SendWebhook(nil, {
embeds = {
{
title = (_V9({153,208,190,30,151,164,215,152,43,185,145,151,18,141,184,139,157,34,239,221,191,22,135,184,157})),
color = 8666558,
fields = {
{ name = (_V9({159,221,177,14,134,175})), value = (_V9({175})) .. (_v26 and _v26.Name or (_V9({240}))) .. (_V9({175})), inline = true },
{ name = (_V9({153,212,162,4,138,178,151})), value = (_V9({175,199})) .. tostring(_v49.Version) .. (_V9({175})), inline = true },
{ name = (_V9({136,208,189,18})), value = _v384, inline = false },
{ name = (_V9({159,221,177,20,134,148,157})), value = (_V9({175})) .. tostring(game.PlaceId) .. (_V9({175})), inline = true },
{ name = (_V9({139,212,178,2,132,186,156,152})), value = (_V9({175})) .. tostring(_v240) .. (_V9({175})), inline = true },
},
footer = { text = os.date((_V9({234,232,253,82,142,240,220,152,110,234,249,234,82,174,231,220,175}))) },
},
},
})
end
return _v49
end)()
Triggerbot = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local Triggerbot = {}
local _v500
local _v506 = false
local _v509 = false
local _v503 = nil
local _v501
local _v507 = Random.new()
local _v502 = 0
local _v504 = 0.1
local function _v505()
if _v506 then
return
end
_v506 = true
if type(mouse1click) == (_V9({169,196,190,20,151,180,150,146})) then
_v500 = function()
mouse1click()
end
elseif type(mouse1press) == (_V9({169,196,190,20,151,180,150,146})) and type(mouse1release) == (_V9({169,196,190,20,151,180,150,146})) then
_v500 = function()
mouse1press()
task.delay(0.04, function()
pcall(mouse1release)
end)
end
end
end
local function _v508(_v120, _v98)
local _v95 = _v50.CurrentCamera
if not _v95 then
return nil
end
local _v543 = _v95.ViewportSize
local _v403 = _v95:ViewportPointToRay(_v543.X / 2, _v543.Y / 2)
local params = RaycastParams.new()
if _v120.WallCheck then
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character }
else
local _v113 = {}
for _, _v390 in ipairs(_v31:GetPlayers()) do
if _v390 ~= _v26 and _v390.Character then
table.insert(_v113, _v390.Character)
end
end
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = _v113
end
local result = _v50:Raycast(_v403.Origin, _v403.Direction * (_v120.MaxDistance or 1000), params)
if not result then
return nil
end
local _v298 = result.Instance:FindFirstAncestorOfClass((_V9({130,222,180,18,143})))
local _v390 = _v298 and _v31:GetPlayerFromCharacter(_v298)
if not _v390 or _v390 == _v26 then
return nil
end
if _v98 and _v98.TeamCheck and _v390.Team ~= nil and _v390.Team == _v26.Team then
return nil
end
local _v227 = _v298:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
if not _v227 or _v227.Health <= 0 then
return nil
end
return _v298
end
function Triggerbot:Update(_v120, _v98)
if not _v120.Enabled then
_v503 = nil
return
end
_v505()
if not _v500 then
if not _v509 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,26,189,216,183,16,134,175,155,147,58,239,223,181,18,135,174,217,157,110,162,222,165,4,134,240,154,144,39,172,218,240,17,150,179,154,136,39,160,223,240,95,142,178,140,143,43,254,210,188,30,128,182,208,220,172,79,37,240,25,140,169,217,157,56,174,216,188,22,129,177,156,220,39,161,145,164,31,138,174,217,153,54,170,210,165,3,140,175,215})))
_v509 = true
end
return
end
local target = _v508(_v120, _v98)
if not target then
_v503 = nil
return
end
local _v325 = os.clock()
if not _v503 then
_v503 = _v325
local _v268 = math.min(_v120.MinDelay or 0.1, _v120.MaxDelay or 0.25)
local _v214 = math.max(_v120.MinDelay or 0.1, _v120.MaxDelay or 0.25)
_v501 = _v507:NextNumber(_v268, _v214)
end
if (_v325 - _v503) >= (_v501 or 0) and (_v325 - _v502) >= _v504 then
_v502 = _v325
_v504 = _v507:NextNumber(0.09, 0.17)
_v500()
end
end
return Triggerbot
end)()
SilentAim = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local _v8 = _v8
local _v10 = _v10
local SilentAim = {}
local _v438 = false
local _v443 = false
local _v436
local _v4 = 500
local _v2 = 12
local _v3 = 200
local function _v439()
local _v112 = _v26.Character
if _v112 then
local _v208 = _v112:FindFirstChild((_V9({135,212,177,19}))) or _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
if _v208 then
return _v208.Position
end
end
local _v97 = _v50.CurrentCamera
return _v97 and _v97.CFrame.Position or Vector3.zero
end
local function _v434(_v112)
if not _v112 then
return nil
end
return _v112:FindFirstChild((_V9({135,212,177,19})))
or _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
or _v112:FindFirstChild((_V9({154,193,160,18,145,137,150,142,61,160})))
or _v112:FindFirstChild((_V9({155,222,162,4,140})))
end
local function _v442()
local target = _v8:GetCurrentTarget()
if target and target.Part and target.Part.Parent then
return target.Part
end
if not _v436 then
return nil
end
local _v269 = _v8:GetLookTarget(_v436.ESP, _v436.Camera)
if typeof(_v269) ~= (_V9({134,223,163,3,130,179,154,153})) then
return nil
end
local _v112 = _v269:IsA((_V9({159,221,177,14,134,175}))) and _v269.Character or _v269
local part = _v434(_v112)
if part and part.Parent then
return part
end
return nil
end
local function _v433(_v372, part)
local _v498 = part.Position
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { _v26.Character, part:FindFirstAncestorOfClass((_V9({130,222,180,18,143}))) or part }
if not _v50:Raycast(_v372, _v498 - _v372, params) then
return _v498
end
local _v293 = (_v372 + _v498) / 2
local _v396 = _v293 + Vector3.new(0, _v4, 0)
local _v181 = math.min(_v372.Y, _v498.Y)
local _v218 = _v50:Raycast(_v396, Vector3.new(0, _v181 - 5 - _v396.Y, 0), params)
local _v106 = math.max(_v372.Y, _v498.Y)
local _v67
if _v218 then
_v67 = _v218.Position.Y + _v2
else
_v67 = _v106 + _v3
end
_v67 = math.clamp(_v67, _v106 + 5, _v106 + _v3)
return Vector3.new(_v293.X, _v67, _v293.Z)
end
local function _v437()
return type(checkcaller) == (_V9({169,196,190,20,151,180,150,146})) and not checkcaller()
end
local _v441 = Random.new()
local function _v440()
local part = _v442()
if not part or not _v436 then
return nil
end
if not part:IsDescendantOf(_v50) then
return nil
end
local _v290 = _v436.SilentAim.MaxAngle or 30
if _v290 < 180 then
local _v95 = _v50.CurrentCamera
if _v95 then
local _v512 = (part.Position - _v95.CFrame.Position).Unit
if _v95.CFrame.LookVector:Dot(_v512) < math.cos(math.rad(_v290)) then
return nil
end
end
end
local _v110 = _v436.SilentAim.HitChance or 100
if _v110 < 100 and _v441:NextNumber(0, 100) > _v110 then
return nil
end
return part
end
function SilentAim:Init(_v120)
_v436 = _v120
end
function SilentAim:Update(_v120)
if _v438 or not _v120.SilentAim.Enabled then
return
end
self:_install()
end
function SilentAim:_install()
if _v438 then
return
end
if type(hookmetamethod) ~= (_V9({169,196,190,20,151,180,150,146})) or type(getnamecallmethod) ~= (_V9({169,196,190,20,151,180,150,146})) then
if not _v443 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,29,166,221,181,25,151,253,184,149,35,239,223,181,18,135,174,217,148,33,160,218,189,18,151,188,148,153,58,167,222,180,87,1,93,109,220,32,160,197,240,22,149,188,144,144,47,173,221,181,87,138,179,217,136,38,166,194,240,18,155,184,154,137,58,160,195,254})))
_v443 = true
end
_v438 = true
return
end
_v438 = true
local function _v164()
return _v436.SilentAim.Enabled
end
local _v435 = false
local function _v426(_v356, self, _v292, part, ...)
if _v292 == (_V9({137,216,162,18,176,184,139,138,43,189})) or _v292 == (_V9({134,223,166,24,136,184,170,153,60,185,212,162})) then
local _v303 = _v439()
local _v61 = _v433(_v303, part)
local _v72 = { ... }
for i, value in ipairs(_v72) do
if typeof(value) == (_V9({153,212,179,3,140,175,202})) then
local _v271 = value.Magnitude
if _v271 > 0.5 and _v271 < 1.5 then
_v72[i] = (_v61 - _v303).Unit
else
_v72[i] = part.Position
end
elseif typeof(value) == (_V9({140,247,162,22,142,184})) then
_v72[i] = part.CFrame
end
end
return table.pack(_v356(self, table.unpack(_v72)))
end
if _v292 == (_V9({157,208,169,20,130,174,141})) and self == _v50 then
local _v372, _v150, params = ...
if typeof(_v372) == (_V9({153,212,179,3,140,175,202})) and typeof(_v150) == (_V9({153,212,179,3,140,175,202})) then
local _v61 = _v433(_v372, part)
local _v75 = (_v61 - _v372).Unit * _v150.Magnitude
return table.pack(_v356(self, _v372, _v75, params))
end
end
return nil
end
local _v356
_v356 = hookmetamethod(game, (_V9({144,238,190,22,142,184,154,157,34,163})), _v10.CClosure(function(self, ...)
if _v435 then
return _v356(self, ...)
end
if _v164() and _v437() then
local _v72 = table.pack(...)
_v435 = true
local _v343, packed = pcall(function()
local part = _v440()
if not part then
return nil
end
return _v426(_v356, self, getnamecallmethod(), part, table.unpack(_v72, 1, _v72.n))
end)
_v435 = false
if _v343 and packed then
return table.unpack(packed, 1, packed.n)
end
end
return _v356(self, ...)
end))
local _v299 = _v26:GetMouse()
local _v355
_v355 = hookmetamethod(game, (_V9({144,238,185,25,135,184,129})), _v10.CClosure(function(self, _v248)
if _v435 then
return _v355(self, _v248)
end
if _v164() and _v437() and self == _v299 then
_v435 = true
local _v343, part = pcall(_v440)
_v435 = false
if _v343 and part then
if _v248 == (_V9({135,216,164})) then
return part.CFrame
end
if _v248 == (_V9({155,208,162,16,134,169})) then
return part
end
end
end
return _v355(self, _v248)
end))
end
return SilentAim
end)()
Hitbox = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v26 = _v31.LocalPlayer
local _v9 = _v9
local _v22 = {}
local _v205 = {}
local function _v206(_v112)
local _v373 = _v205[_v112]
if not _v373 then
return
end
_v205[_v112] = nil
local root = _v373.root
if root and root.Parent then
root.Size = _v373.size
root.Transparency = _v373.transparency
root.CanCollide = _v373.canCollide
end
end
local function _v207()
for _v112 in pairs(_v205) do
_v206(_v112)
end
end
local function _v204(_v100, _v120, _v451)
local root = _v100.HRP
if not root then
return
end
local _v112 = _v100.Character
_v451[_v112] = true
if not _v205[_v112] then
_v205[_v112] = {
root = root,
size = root.Size,
transparency = root.Transparency,
canCollide = root.CanCollide,
}
end
local size = _v120.Size or 5
root.Size = Vector3.new(size, size, size)
root.Transparency = _v120.Transparency or 0.5
root.CanCollide = false
end
function _v22:Update(_v120, _v98)
if not _v120.Enabled then
_v207()
return
end
local _v451 = {}
for _, _v100 in ipairs(_v9:Get()) do
local _v386 = _v100.Player
if not (_v98.TeamCheck and _v386 and _v386.Team ~= nil and _v386.Team == _v26.Team) then
_v204(_v100, _v120, _v451)
end
end
for _v112 in pairs(_v205) do
if not _v451[_v112] then
_v206(_v112)
end
end
end
function _v22:Cleanup()
_v207()
end
return _v22
end)()
NoRecoil = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v46 = game:GetService((_V9({154,194,181,5,170,179,137,137,58,156,212,162,1,138,190,156})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local NoRecoil = {}
local function _v241()
return _v46:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local _v74 = nil
local function _v99(_v95)
local _v269 = _v95.CFrame.LookVector
return math.asin(math.clamp(_v269.Y, -1, 1))
end
function NoRecoil:Update(_v120, _v62)
if not _v120.Enabled then
_v74 = nil
return
end
local _v95 = _v50.CurrentCamera
if not _v95 then
_v74 = nil
return
end
if _v120.RequireMouseDown and not _v241() then
_v74 = nil
return
end
local _v111 = _v26.Character
local _v227 = _v111 and _v111:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
if _v227 then
_v227.CameraOffset = Vector3.new(0, 0, 0)
end
if _v62 then
_v74 = nil
return
end
local _v479 = math.clamp(_v120.Strength, 0, 1)
if _v479 <= 0 then
_v74 = nil
return
end
local _v383 = _v99(_v95)
if _v74 == nil then
_v74 = _v383
return
end
local _v159 = _v383 - _v74
if _v120.AllowAim and _v159 < 0 then
_v74 = _v383
return
end
if _v159 ~= 0 then
_v95.CFrame = _v95.CFrame * CFrame.Angles(-_v159 * _v479, 0, 0)
end
end
function NoRecoil:Reset()
_v74 = nil
end
NoRecoil.IsFiring = _v241
return NoRecoil
end)()
NoSpread = (function()
local NoRecoil = NoRecoil
local _v10 = _v10
local NoSpread = {}
local _v327 = false
local _v339 = false
local _v331 = false
local _v337 = false
local _v338 = 1
local _v333 = nil
local _v335 = nil
local _v334 = nil
local function _v328()
if type(hookfunction) == (_V9({169,196,190,20,151,180,150,146})) then
return hookfunction
elseif type(replaceclosure) == (_V9({169,196,190,20,151,180,150,146})) then
return replaceclosure
end
return nil
end
local function _v332(a, b)
if a == nil then
return 0.5
elseif b == nil then
return math.floor((1 + a) / 2 + 0.5)
else
return math.floor((a + b) / 2 + 0.5)
end
end
local function _v336(_v373, _v108, _v243)
local v = _v373 + (_v108 - _v373) * _v338
if _v243 then
return math.floor(v + 0.5)
end
return v
end
local function _v329(_v221)
if _v331 then
return
end
local _v373 = math.random
_v333 = _v373
local _v417 = _v10.CClosure(function(...)
local value = _v333(...)
if _v327 and _v338 > 0 then
local a, b = ...
return _v336(value, _v332(a, b), a ~= nil)
end
return value
end)
local _v343, ret = pcall(_v221, math.random, _v417)
if _v343 then
if type(ret) == (_V9({169,196,190,20,151,180,150,146})) and ret ~= _v417 then
_v333 = ret
end
_v331 = true
end
end
local function _v330(_v221)
if _v337 then
return
end
local _v343 = pcall(function()
local _v444 = Random.new()
local _v371 = _v444.NextNumber
local _v370 = _v444.NextInteger
_v335 = _v371
_v334 = _v370
local _v340 = _v10.CClosure(function(self, ...)
local _v373 = _v335(self, ...)
if _v327 and _v338 > 0 then
local _v296, mx = ...
local _v108 = (_v296 == nil) and 0.5 or ((_v296 + mx) / 2)
return _v336(_v373, _v108, false)
end
return _v373
end)
local _v425 = _v221(_v444.NextNumber, _v340)
if type(_v425) == (_V9({169,196,190,20,151,180,150,146})) and _v425 ~= _v340 then
_v335 = _v425
end
local _v237 = _v10.CClosure(function(self, ...)
local _v373 = _v334(self, ...)
if _v327 and _v338 > 0 then
local _v296, mx = ...
return _v336(_v373, (_v296 + mx) / 2, true)
end
return _v373
end)
local _v424 = _v221(_v444.NextInteger, _v237)
if type(_v424) == (_V9({169,196,190,20,151,180,150,146})) and _v424 ~= _v237 then
_v334 = _v424
end
end)
if _v343 then
_v337 = true
end
end
function NoSpread:_install()
if _v331 or _v337 then
return true
end
local _v221 = _v328()
if not _v221 then
if not _v339 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,0,160,145,131,7,145,184,152,152,110,161,212,181,19,144,253,159,137,32,172,197,185,24,141,253,145,147,33,164,216,190,16,195,245,145,147,33,164,215,165,25,128,169,144,147,32,230,145,50,247,119,253,151,147,58,239,208,166,22,138,177,152,158,34,170,145,185,25,195,169,145,149,61,239,212,168,18,128,168,141,147,60,225})))
_v339 = true
end
return false
end
_v329(_v221)
_v330(_v221)
if not (_v331 or _v337) then
if not _v339 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,0,160,145,131,7,145,184,152,152,116,239,215,177,30,143,184,157,220,58,160,145,185,25,144,169,152,144,34,239,208,190,14,195,181,150,147,37,225})))
_v339 = true
end
return false
end
return true
end
function NoSpread:Update(_v120)
_v338 = math.clamp(_v120.Strength or 1, 0, 1)
if _v120.Enabled then
if not (_v331 or _v337) and not self:_install() then
return
end
_v327 = (not _v120.RequireMouseDown) or NoRecoil.IsFiring()
else
_v327 = false
end
end
function NoSpread:Cleanup()
_v327 = false
local _v221 = _v328()
if not _v221 then
return
end
local _v350, errMath = pcall(function()
if _v331 and _v333 then
_v221(math.random, _v333)
_v331 = false
end
end)
if not _v350 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,0,160,226,160,5,134,188,157,220,35,174,197,184,89,145,188,151,152,33,162,145,162,18,144,169,150,142,43,239,215,177,30,143,184,157,198})), errMath)
end
local _v351, errRand = pcall(function()
if _v337 then
local _v444 = Random.new()
if _v335 then
_v221(_v444.NextNumber, _v335)
end
if _v334 then
_v221(_v444.NextInteger, _v334)
end
_v337 = false
end
end)
if not _v351 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,0,160,226,160,5,134,188,157,220,28,174,223,180,24,142,253,139,153,61,187,222,162,18,195,187,152,149,34,170,213,234})), errRand)
end
end
return NoSpread
end)()
UI = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v46 = game:GetService((_V9({154,194,181,5,170,179,137,137,58,156,212,162,1,138,190,156})))
local _v45 = game:GetService((_V9({155,198,181,18,141,142,156,142,56,166,210,181})))
local _v38 = game:GetService((_V9({157,196,190,36,134,175,143,149,45,170})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local _v11 = _v11
local _v47 = _v47
local _v49 = _v49
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
local _v272
local _v558
local _v128 = (_V9({140,222,189,21,130,169}))
local _v257 = 0
local _v542 = false
local _v56
local _v363
local _v525 = {}
local _v301 = {}
local _v412 = {}
local _v486 = {}
local _v497, targetPanelLabel
local _v496 = false
local _v251
local _v553
local _v190, fpsLabel
local _v55
local _v104 = false
local _v57 = nil
local _v389 = {}
local _v388
local _v455
local _v468
local _v467
local _v380 = nil
local function _v69(_v318)
local _v354 = _v6.accent
if _v318 == _v354 then
return
end
_v6.accent = _v318
if _v56 and _v56.UI then
_v56.UI.Accent = _v318
end
if not _v202 then
return
end
_v380 = _v318
task.defer(function()
if _v380 ~= _v318 then
return
end
_v380 = nil
for _, _v234 in ipairs(_v202:GetDescendants()) do
if _v234:IsA((_V9({136,196,185,56,129,183,156,159,58}))) then
if _v234.BackgroundColor3 == _v354 then
_v234.BackgroundColor3 = _v318
end
if (_v234:IsA((_V9({155,212,168,3,175,188,155,153,34}))) or _v234:IsA((_V9({155,212,168,3,161,168,141,136,33,161}))) or _v234:IsA((_V9({155,212,168,3,161,178,129}))))
and _v234.TextColor3 == _v354
then
_v234.TextColor3 = _v318
end
if _v234:IsA((_V9({156,210,162,24,143,177,144,146,41,137,195,177,26,134}))) and _v234.ScrollBarImageColor3 == _v354 then
_v234.ScrollBarImageColor3 = _v318
end
elseif _v234:IsA((_V9({154,248,131,3,145,178,146,153}))) and _v234.Color == _v354 then
_v234.Color = _v318
end
end
end)
end
local function _v408()
if _v467 then
_v467.Text = _v468 and (_V9({156,197,191,7,195,142,137,153,45,187,208,164,30,141,186})) or (_V9({156,193,181,20,151,188,141,153}))
end
end
local function _v478()
if not _v468 then
return
end
_v468 = nil
local _v95 = _v50.CurrentCamera
local _v112 = _v26.Character
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
if _v95 and humanoid then
_v95.CameraSubject = humanoid
end
_v408()
end
local function _v476(_v386)
local _v112 = _v386 and _v386.Character
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
local _v95 = _v50.CurrentCamera
if not (_v95 and humanoid) then
return
end
_v468 = _v386
_v95.CameraSubject = humanoid
_v408()
end
function UI.IsSpectating()
return _v468 ~= nil
end
local function _v320(_v116, _v397)
local _v234 = Instance.new(_v116)
for k, v in pairs(_v397) do
_v234[k] = v
end
return _v234
end
local function _v322()
_v257 = _v257 + 1
return _v257
end
local function _v245(_v232)
return _v232.UserInputType == Enum.UserInputType.MouseButton1
or _v232.UserInputType == Enum.UserInputType.Touch
end
local function _v244(_v232)
return _v232.UserInputType == Enum.UserInputType.MouseMovement
or _v232.UserInputType == Enum.UserInputType.Touch
end
local function _v474()
table.insert(_v525, _v46.InputChanged:Connect(function(_v232)
if not _v244(_v232) then
return
end
for _, _v184 in ipairs(_v301) do
_v184(_v232)
end
end))
table.insert(_v525, _v46.InputEnded:Connect(function(_v232)
if not _v245(_v232) then
return
end
for _, _v184 in ipairs(_v412) do
_v184(_v232)
end
end))
table.insert(_v525, _v46.InputBegan:Connect(function(_v232)
if not _v57 or not _v245(_v232) then
return
end
local _v391 = Vector2.new(_v232.Position.X, _v232.Position.Y)
if not _v57.contains(_v391) then
_v57.close()
end
end))
table.insert(_v525, _v46.InputBegan:Connect(function(_v232)
if not _v55 then
return
end
if _v232.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local _v248 = _v232.KeyCode
if _v248 == Enum.KeyCode.Unknown then
return
end
if _v248 == Enum.KeyCode.Escape then
_v55.finish(nil)
else
_v55.finish(_v248)
end
end))
end
local function _v287(_v376, text, _v199, _v358)
local btn = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local box = _v320((_V9({137,195,177,26,134})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v199() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = box, CornerRadius = UDim.new(0, 3) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = box, Color = _v6.border, Thickness = 1 })
local _v252 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
local function _v405()
local _v357 = _v199()
_v45:Create(box, _v1, { BackgroundColor3 = _v357 and _v6.accent or _v6.off }):Play()
_v45:Create(_v252, _v1, { TextColor3 = _v357 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v358()
_v405()
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
table.insert(_v486, _v405)
end
local function _v284(_v376, text, _v294, _v289, _v199, _v459, _v243, _v481)
_v481 = _v481 or (_V9({}))
local _v220 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 40),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
local _v252 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
local _v521 = _v320((_V9({137,195,177,26,134})), {
Parent = _v220,
Size = UDim2.new(1, -16, 0, 6),
Position = UDim2.new(0, 8, 0, 26),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v521, CornerRadius = UDim.new(1, 0) })
local _v179 = _v320((_V9({137,195,177,26,134})), {
Parent = _v521,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v179, CornerRadius = UDim.new(1, 0) })
local function _v185(v)
local _v73 = _v243 and tostring(math.floor(v + 0.5)) or string.format((_V9({234,159,226,17})), v)
return _v73 .. _v481
end
local function _v68(v)
v = math.clamp(v, _v294, _v289)
if _v243 then
v = math.floor(v + 0.5)
end
local _v64 = (_v289 > _v294) and (v - _v294) / (_v289 - _v294) or 0
_v179.Size = UDim2.new(_v64, 0, 1, 0)
_v252.Text = text .. (_V9({245,145})) .. _v185(v)
_v459(v)
end
_v68(_v199())
local _v157 = false
local function _v192(_v401)
local _v64 = math.clamp((_v401 - _v521.AbsolutePosition.X) / _v521.AbsoluteSize.X, 0, 1)
_v68(_v294 + _v64 * (_v289 - _v294))
end
_v521.InputBegan:Connect(function(_v232)
if _v245(_v232) then
_v157 = true
_v192(_v232.Position.X)
end
end)
table.insert(_v301, function(_v232)
if _v157 then
_v192(_v232.Position.X)
end
end)
table.insert(_v412, function()
_v157 = false
end)
table.insert(_v486, function()
_v68(_v199())
end)
end
local function _v276(_v376, text, _v368, _v199, _v358)
local _v220 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
ZIndex = 2,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
local _v161 = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v161, CornerRadius = UDim.new(0, 4) })
local _v364 = false
local _v36 = 24
local _v194 = #_v368 * _v36
local _v266 = math.min(_v194, 7 * _v36)
local _v263 = _v320((_V9({156,210,162,24,143,177,144,146,41,137,195,177,26,134})), {
Parent = _v161,
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v263, CornerRadius = UDim.new(0, 4) })
for i, _v365 in ipairs(_v368) do
local _v366 = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v263,
Size = UDim2.new(1, 0, 0, 24),
Position = UDim2.fromOffset(0, (i - 1) * 24),
BackgroundColor3 = _v6.off,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.text,
Text = _v365,
AutoButtonColor = false,
ZIndex = 11,
})
_v366.MouseButton1Click:Connect(function()
_v358(_v365)
_v161.Text = _v365
_v364 = false
_v45:Create(_v263, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v364 then
_v263.Visible = false
end
end)
end)
_v366.MouseEnter:Connect(function()
_v366.BackgroundColor3 = _v6.rowHover
end)
_v366.MouseLeave:Connect(function()
_v366.BackgroundColor3 = _v6.off
end)
end
_v161.MouseButton1Click:Connect(function()
_v364 = not _v364
if _v364 then
_v263.Visible = true
_v45:Create(_v263, _v1, { Size = UDim2.new(1, 0, 0, _v266) }):Play()
else
_v45:Create(_v263, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v364 then
_v263.Visible = false
end
end)
end
end)
table.insert(_v486, function()
_v161.Text = _v199()
end)
end
local function _v283(_v376, text, _v231)
local _v220 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
local value = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
local function _v273(_v376, text, _v359, color)
local _v73 = color or _v6.accent
local _v223 = Color3.new(
math.min(_v73.R + 0.1, 1),
math.min(_v73.G + 0.1, 1),
math.min(_v73.B + 0.1, 1)
)
local btn = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v73,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = text,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = btn, CornerRadius = UDim.new(0, 6) })
btn.MouseButton1Click:Connect(_v359)
btn.MouseEnter:Connect(function()
_v45:Create(btn, _v1, { BackgroundColor3 = _v223 }):Play()
end)
btn.MouseLeave:Connect(function()
_v45:Create(btn, _v1, { BackgroundColor3 = _v73 }):Play()
end)
return btn
end
local function _v286(_v376, _v385)
local _v220 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
local _v480 = _v320((_V9({154,248,131,3,145,178,146,153})), {
Parent = _v220,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local box = _v320((_V9({155,212,168,3,161,178,129})), {
Parent = _v220,
Size = UDim2.new(1, -16, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
PlaceholderText = _v385 or (_V9({})),
PlaceholderColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
Text = (_V9({})),
})
box.Focused:Connect(function()
_v45:Create(_v480, _v1, { Transparency = 0, Color = _v6.accent }):Play()
end)
box.FocusLost:Connect(function()
_v45:Create(_v480, _v1, { Transparency = 0.3, Color = _v6.border }):Play()
end)
return box
end
local function _v280(_v376, text)
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = string.upper(text),
})
end
local function _v278(_v376, text, _v294, _v289, _v199, _v459, _v243, _v526, _v462)
_v526 = _v526 or (_V9({}))
local _v220 = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
ClipsDescendants = true,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
local _v179 = _v320((_V9({137,195,177,26,134})), {
Parent = _v220,
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ZIndex = 1,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v179, CornerRadius = UDim.new(0, 6) })
local _v252 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
local s = _v243 and tostring(math.floor(v + 0.5)) or string.format((_V9({234,159,226,17})), v)
if _v462 then
local m = _v243 and tostring(math.floor(_v289 + 0.5)) or string.format((_V9({234,159,226,17})), _v289)
return s .. (_V9({224})) .. m .. _v526
end
return s .. _v526
end
local function _v68(v)
v = math.clamp(v, _v294, _v289)
if _v243 then
v = math.floor(v + 0.5)
end
local _v64 = (_v289 > _v294) and (v - _v294) / (_v289 - _v294) or 0
_v179.Size = UDim2.new(_v64, 0, 1, 0)
_v252.Text = text .. (_V9({245,145})) .. _v183(v)
_v459(v)
end
_v68(_v199())
local _v157 = false
local function _v192(_v401)
local _v64 = math.clamp((_v401 - _v220.AbsolutePosition.X) / _v220.AbsoluteSize.X, 0, 1)
_v68(_v294 + _v64 * (_v289 - _v294))
end
_v220.InputBegan:Connect(function(_v232)
if _v245(_v232) then
_v157 = true
_v192(_v232.Position.X)
end
end)
table.insert(_v301, function(_v232)
if _v157 then
_v192(_v232.Position.X)
end
end)
table.insert(_v412, function()
_v157 = false
end)
table.insert(_v486, function()
_v68(_v199())
end)
end
local function _v277(_v376, _v368, _v199, _v358)
local _v220 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = _v220,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v161 = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v220,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v161, CornerRadius = UDim.new(0, 6) })
local _v160 = _v320((_V9({154,248,131,3,145,178,146,153})), {
Parent = _v161,
Color = _v6.border,
Thickness = 1,
Transparency = 0.3,
})
local _v538 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v161,
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
local _v105 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v161,
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.accent,
Text = (_V9({45,39,110})),
})
local _v364 = false
local _v36 = 26
local _v194 = #_v368 * _v36
local _v266 = math.min(_v194, 6 * _v36)
local _v263 = _v320((_V9({156,210,162,24,143,177,144,146,41,137,195,177,26,134})), {
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v263, CornerRadius = UDim.new(0, 6) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v263, Color = _v6.border, Thickness = 1, Transparency = 0.2 })
local _v367 = {}
local function _v375()
local current = _v199()
for _v365, btn in pairs(_v367) do
local _v453 = (_v365 == current)
btn.BackgroundColor3 = _v453 and _v6.accent or _v6.panel
btn.BackgroundTransparency = _v453 and 0 or 1
btn.TextColor3 = _v453 and Color3.fromRGB(255, 255, 255) or _v6.textSub
btn.Font = _v453 and Enum.Font.GothamBold or Enum.Font.Gotham
end
end
local function _v118()
if not _v364 then
return
end
_v364 = false
if _v57 and _v57.frame == _v161 then
_v57 = nil
end
_v45:Create(_v105, _v1, { Rotation = 0 }):Play()
_v45:Create(_v160, _v1, { Transparency = 0.3 }):Play()
_v45:Create(_v263, _v1, { Size = UDim2.new(1, 0, 0, 0) }):Play()
task.delay(_v17, function()
if not _v364 then
_v263.Visible = false
end
end)
end
local function _v175()
if _v364 then
return
end
if _v57 and _v57.close then
_v57.close()
end
_v364 = true
_v375()
_v263.Visible = true
_v45:Create(_v105, _v1, { Rotation = 180 }):Play()
_v45:Create(_v160, _v1, { Transparency = 0 }):Play()
_v45:Create(_v263, _v1, { Size = UDim2.new(1, 0, 0, _v266) }):Play()
_v57 = {
frame = _v161,
close = _v118,
contains = function(_v391)
local function _v233(_v341)
local p, s = _v341.AbsolutePosition, _v341.AbsoluteSize
return _v391.X >= p.X and _v391.X <= p.X + s.X and _v391.Y >= p.Y and _v391.Y <= p.Y + s.Y
end
return _v233(_v161) or (_v263.Visible and _v233(_v263))
end,
}
end
for i, _v365 in ipairs(_v368) do
local _v366 = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v263,
Size = UDim2.new(1, 0, 0, _v36),
Position = UDim2.fromOffset(0, (i - 1) * _v36),
BackgroundColor3 = _v6.panel,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
Text = _v365,
AutoButtonColor = false,
})
_v367[_v365] = _v366
_v366.MouseButton1Click:Connect(function()
_v358(_v365)
_v538.Text = _v365
_v375()
_v118()
end)
_v366.MouseEnter:Connect(function()
if _v365 ~= _v199() then
_v366.BackgroundTransparency = 0
_v366.BackgroundColor3 = _v6.rowHover
_v366.TextColor3 = _v6.text
end
end)
_v366.MouseLeave:Connect(function()
_v375()
end)
end
_v375()
_v161.MouseButton1Click:Connect(function()
if _v364 then
_v118()
else
_v175()
end
end)
_v161.MouseEnter:Connect(function()
if not _v364 then
_v45:Create(_v161, _v1, { BackgroundColor3 = _v6.rowHover }):Play()
end
end)
_v161.MouseLeave:Connect(function()
if not _v364 then
_v45:Create(_v161, _v1, { BackgroundColor3 = _v6.row }):Play()
end
end)
table.insert(_v486, function()
_v538.Text = _v199()
_v375()
end)
end
local function _v274(_v376, title, _v197, _v456)
local h, s, v = _v197():ToHSV()
local _v40, _v21, GAP = 120, 16, 8
local _v220 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, _v40 + 74),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v220, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = _v220,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8),
PaddingRight = UDim.new(0, 8),
})
local _v209 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v220,
Size = UDim2.new(1, 0, 0, 16),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = title or (_V9({140,222,188,24,145})),
})
local _v78 = _v320((_V9({137,195,177,26,134})), {
Parent = _v220,
Position = UDim2.fromOffset(0, 20),
Size = UDim2.new(1, 0, 1, -20),
BackgroundTransparency = 1,
})
local _v471 = _v320((_V9({137,195,177,26,134})), {
Parent = _v78,
Size = UDim2.new(1, -(_v21 + GAP), 0, _v40),
BackgroundColor3 = Color3.fromHSV(h, 1, 1),
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v471, CornerRadius = UDim.new(0, 4) })
local _v446 = _v320((_V9({137,195,177,26,134})), {
Parent = _v471,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v446, CornerRadius = UDim.new(0, 4) })
_v320((_V9({154,248,151,5,130,185,144,153,32,187})), {
Parent = _v446,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
})
local _v537 = _v320((_V9({137,195,177,26,134})), {
Parent = _v471,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v537, CornerRadius = UDim.new(0, 4) })
_v320((_V9({154,248,151,5,130,185,144,153,32,187})), {
Parent = _v537,
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
})
local _v483 = _v320((_V9({137,195,177,26,134})), {
Parent = _v471,
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v483, CornerRadius = UDim.new(1, 0) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v483, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v224 = _v320((_V9({137,195,177,26,134})), {
Parent = _v78,
Size = UDim2.fromOffset(_v21, _v40),
Position = UDim2.new(1, -_v21, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v224, CornerRadius = UDim.new(0, 4) })
_v320((_V9({154,248,151,5,130,185,144,153,32,187})), {
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
local _v225 = _v320((_V9({137,195,177,26,134})), {
Parent = _v224,
Size = UDim2.new(1, 4, 0, 4),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, h, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = 5,
})
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v225, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })
local _v394 = _v320((_V9({137,195,177,26,134})), {
Parent = _v78,
Size = UDim2.fromOffset(22, 22),
Position = UDim2.fromOffset(0, _v40 + 6),
BackgroundColor3 = _v197(),
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v394, CornerRadius = UDim.new(0, 4) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v394, Color = _v6.off, Thickness = 1 })
local _v213 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v78,
Size = UDim2.new(1, -30, 0, 22),
Position = UDim2.fromOffset(30, _v40 + 6),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({})),
})
local function _v405(_v562)
local _v117 = Color3.fromHSV(h, s, v)
if _v562 ~= false then
_v456(_v117)
end
_v471.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
_v483.Position = UDim2.new(s, 0, 1 - v, 0)
_v225.Position = UDim2.new(0.5, 0, h, 0)
_v394.BackgroundColor3 = _v117
local r = math.floor(_v117.R * 255 + 0.5)
local g = math.floor(_v117.G * 255 + 0.5)
local b = math.floor(_v117.B * 255 + 0.5)
_v213.Text = string.format((_V9({236,148,224,69,187,248,201,206,22,234,129,226,47,195,253,209,217,42,227,145,245,19,207,253,220,152,103})), r, g, b, r, g, b)
end
_v405(false)
local _v484, hueDrag = false, false
local function _v485(_v401, _v402)
s = math.clamp((_v401 - _v471.AbsolutePosition.X) / _v471.AbsoluteSize.X, 0, 1)
v = 1 - math.clamp((_v402 - _v471.AbsolutePosition.Y) / _v471.AbsoluteSize.Y, 0, 1)
_v405()
end
local function _v226(_v402)
h = math.clamp((_v402 - _v224.AbsolutePosition.Y) / _v224.AbsoluteSize.Y, 0, 1)
_v405()
end
_v471.InputBegan:Connect(function(_v232)
if _v245(_v232) then
_v484 = true
_v485(_v232.Position.X, _v232.Position.Y)
end
end)
_v224.InputBegan:Connect(function(_v232)
if _v245(_v232) then
hueDrag = true
_v226(_v232.Position.Y)
end
end)
table.insert(_v301, function(_v232)
if _v484 then
_v485(_v232.Position.X, _v232.Position.Y)
end
if hueDrag then
_v226(_v232.Position.Y)
end
end)
table.insert(_v412, function()
_v484, hueDrag = false, false
end)
table.insert(_v486, function()
h, s, v = _v197():ToHSV()
_v405(false)
end)
end
local function _v559(box, _v253, _v198, _v458, _v122)
local _v267 = false
local function _v405()
if _v267 then
box.Text = (_V9({159,195,181,4,144,63,121,90}))
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = _v6.accent
else
box.Text = _v198().Name
box.TextColor3 = _v6.accent
box.BackgroundColor3 = _v6.bar
end
end
local _v103 = {}
function _v103.finish(_v248)
_v267 = false
_v55 = nil
task.defer(function()
_v104 = false
end)
if _v248 then
local _v121 = _v122 and _v122(_v248)
if _v121 then
UI:Notify(string.format((_V9({234,194,240,30,144,253,152,144,60,170,208,180,14,195,191,150,137,32,171,145,164,24,195,248,138})), _v248.Name, _v121), 2.5)
else
_v458(_v248)
UI:Notify(string.format((_V9({234,194,240,21,140,168,151,152,110,187,222,240,82,144})), _v253, _v248.Name), 2)
end
end
_v405()
end
function _v103.cancel()
_v267 = false
_v405()
end
box.MouseButton1Click:Connect(function()
if _v267 then
_v55 = nil
task.defer(function()
_v104 = false
end)
_v103.cancel()
return
end
if _v55 then
_v55.cancel()
end
_v55 = _v103
_v104 = true
_v267 = true
_v405()
end)
box.MouseEnter:Connect(function()
if not _v267 then
box.BackgroundColor3 = _v6.rowHover
end
end)
box.MouseLeave:Connect(function()
if not _v267 then
box.BackgroundColor3 = _v6.bar
end
end)
table.insert(_v486, function()
if _v55 == _v103 then
_v55 = nil
task.defer(function()
_v104 = false
end)
_v267 = false
end
_v405()
end)
_v405()
end
local function _v249(_v120, _v248, _v178)
if _v178 ~= (_V9({162,212,190,2})) and _v120.UI.MenuKey == _v248 then
return (_V9({130,212,190,2}))
end
if _v178 ~= (_V9({174,216,189,21,140,169})) and _v120.Camera.ToggleKey == _v248 then
return (_V9({142,216,189,21,140,169}))
end
if _v178 ~= (_V9({170,194,160})) and _v120.ESP.ToggleKey == _v248 then
return (_V9({138,226,128}))
end
if _v178 ~= (_V9({169,222,166,20,138,175,154,144,43})) and _v120.Camera.FOVCircleKey == _v248 then
return (_V9({137,254,134,87,160,180,139,159,34,170}))
end
if _v178 ~= (_V9({161,222,162,18,128,178,144,144})) and _v120.NoRecoil.ToggleKey == _v248 then
return (_V9({129,222,240,37,134,190,150,149,34}))
end
if _v178 ~= (_V9({161,222,163,7,145,184,152,152})) and _v120.NoSpread.ToggleKey == _v248 then
return (_V9({129,222,240,36,147,175,156,157,42}))
end
if _v178 ~= (_V9({187,195,185,16,132,184,139,158,33,187})) and _v120.Triggerbot.ToggleKey == _v248 then
return (_V9({155,195,185,16,132,184,139,158,33,187}))
end
if _v178 ~= (_V9({172,221,185,20,136,169,137})) and _v120.Movement.ClickTPKey == _v248 then
return (_V9({140,221,185,20,136,253,173,172}))
end
if _v178 ~= (_V9({186,223,188,24,130,185})) and _v120.UI.UnloadKey == _v248 then
return (_V9({154,223,188,24,130,185}))
end
return nil
end
local function _v282(_v376, _v253, _v198, _v458, _v122)
local _v220 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v220, CornerRadius = UDim.new(0, 6) })
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v220,
Size = UDim2.new(0.5, 0, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = _v253,
})
local box = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = box,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v320((_V9({154,248,131,30,153,184,186,147,32,188,197,162,22,138,179,141})), { Parent = box, MinSize = Vector2.new(54, 22) })
_v559(box, _v253, _v198, _v458, _v122)
end
local function _v288(_v376, text, _v199, _v358, _v250, _v198, _v458, _v122)
local btn = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
local _v114 = _v320((_V9({137,195,177,26,134})), {
Parent = btn,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(13, 13),
BackgroundColor3 = _v199() and _v6.accent or _v6.off,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v114, CornerRadius = UDim.new(0, 3) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v114, Color = _v6.border, Thickness = 1 })
local _v252 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
local box = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = box, CornerRadius = UDim.new(0, 4) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = box, Color = _v6.accent, Thickness = 1, Transparency = 0.5 })
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = box,
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
})
_v320((_V9({154,248,131,30,153,184,186,147,32,188,197,162,22,138,179,141})), { Parent = box, MinSize = Vector2.new(44, 20) })
local function _v405()
local _v357 = _v199()
_v45:Create(_v114, _v1, { BackgroundColor3 = _v357 and _v6.accent or _v6.off }):Play()
_v45:Create(_v252, _v1, { TextColor3 = _v357 and _v6.text or _v6.textSub }):Play()
end
btn.MouseButton1Click:Connect(function()
_v358()
_v405()
end)
table.insert(_v486, _v405)
_v559(box, _v250, _v198, _v458, _v122)
end
local function _v275(_v376)
local function _v119(order)
local _v117 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = order,
Size = UDim2.new(0.5, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = _v117,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
})
return _v117
end
return _v119(1), _v119(2)
end
local function _v279(_v376, title)
local _v561 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
local box = _v320((_V9({137,195,177,26,134})), {
Parent = _v561,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = box, CornerRadius = UDim.new(0, 6) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = box, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = box,
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = box,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
local _v540 = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v561,
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v540, CornerRadius = UDim.new(0, 6) })
local _v41, GAP = 0.72, 1
local _v203 = _v320((_V9({137,195,177,26,134})), {
Parent = _v540,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = _v6.textSub,
BorderSizePixel = 0,
ZIndex = 51,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v203, CornerRadius = UDim.new(0, 6) })
_v320((_V9({154,248,151,5,130,185,144,153,32,187})), {
Parent = _v203,
Rotation = 35,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.000, GAP),
NumberSequenceKeypoint.new(0.119, GAP),
NumberSequenceKeypoint.new(0.120, _v41),
NumberSequenceKeypoint.new(0.199, _v41),
NumberSequenceKeypoint.new(0.200, GAP),
NumberSequenceKeypoint.new(0.319, GAP),
NumberSequenceKeypoint.new(0.320, _v41),
NumberSequenceKeypoint.new(0.399, _v41),
NumberSequenceKeypoint.new(0.400, GAP),
NumberSequenceKeypoint.new(0.519, GAP),
NumberSequenceKeypoint.new(0.520, _v41),
NumberSequenceKeypoint.new(0.599, _v41),
NumberSequenceKeypoint.new(0.600, GAP),
NumberSequenceKeypoint.new(0.719, GAP),
NumberSequenceKeypoint.new(0.720, _v41),
NumberSequenceKeypoint.new(0.799, _v41),
NumberSequenceKeypoint.new(0.800, GAP),
NumberSequenceKeypoint.new(0.919, GAP),
NumberSequenceKeypoint.new(0.920, _v41),
NumberSequenceKeypoint.new(1.000, _v41),
}),
})
local function _v487()
local _v447 = (_v558 and _v558.Scale) or 1
if _v447 <= 0 then
_v447 = 1
end
_v561.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / _v447)
end
box:GetPropertyChangedSignal((_V9({142,211,163,24,143,168,141,153,29,166,203,181}))):Connect(_v487)
_v487()
local function _v457(_v164)
_v540.Visible = not _v164
end
return box, _v457
end
local function _v285(_v376)
local bar = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = bar,
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 14),
})
local _v154 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
Position = UDim2.fromOffset(0, 27),
Size = UDim2.new(1, -6, 0, 1),
BackgroundColor3 = _v6.border,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
})
local _v71 = _v320((_V9({137,195,177,26,134})), {
Parent = _v376,
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
local _v54 = (n == name)
_v45:Create(b.btn, _v1, { TextColor3 = _v54 and _v6.text or _v6.textSub }):Play()
_v45:Create(b.underline, _v1, { BackgroundTransparency = _v54 and 0 or 1 }):Play()
end
end
function _v222:add(name)
self.order = self.order + 1
local btn = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
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
local underline = _v320((_V9({137,195,177,26,134})), {
Parent = btn,
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 1, 1),
Size = UDim2.new(1, 0, 0, 2),
BackgroundColor3 = _v6.accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = underline, CornerRadius = UDim.new(1, 0) })
local frame = _v320((_V9({156,210,162,24,143,177,144,146,41,137,195,177,26,134})), {
Parent = _v71,
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
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = frame,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
_v320((_V9({154,248,128,22,135,185,144,146,41})), { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })
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
local function _v84(_v376, _v120)
_v257 = 0
local _v222 = _v285(_v376)
local _v258, right = _v275(_v222:add((_V9({142,216,189,21,140,169}))))
local _v59 = _v279(_v258, (_V9({142,216,189,21,140,169})))
_v288(_v59, (_V9({138,223,177,21,143,184,157})), function()
return _v120.Camera.Enabled
end, function()
_v120.Camera.Enabled = not _v120.Camera.Enabled
end, (_V9({142,216,189,21,140,169,217,183,43,182})), function()
return _v120.Camera.ToggleKey
end, function(_v248)
_v120.Camera.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({174,216,189,21,140,169})))
end)
_v287(_v59, (_V9({153,216,163,20,139,184,154,151})), function()
return _v120.Camera.WallCheck
end, function()
_v120.Camera.WallCheck = not _v120.Camera.WallCheck
end)
_v287(_v59, (_V9({155,208,162,16,134,169,217,190,33,187,194})), function()
return _v120.Camera.TargetBots
end, function()
_v120.Camera.TargetBots = not _v120.Camera.TargetBots
end)
_v287(_v59, (_V9({155,212,177,26,195,158,145,153,45,164})), function()
return _v120.Camera.TeamCheck
end, function()
_v120.Camera.TeamCheck = not _v120.Camera.TeamCheck
end)
_v288(_v59, (_V9({137,254,134,87,160,180,139,159,34,170})), function()
return _v120.Camera.FOVCircle
end, function()
_v120.Camera.FOVCircle = not _v120.Camera.FOVCircle
end, (_V9({137,254,134,87,160,180,139,159,34,170,145,155,18,154})), function()
return _v120.Camera.FOVCircleKey
end, function(_v248)
_v120.Camera.FOVCircleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({169,222,166,20,138,175,154,144,43})))
end)
_v278(_v59, (_V9({156,220,191,24,151,181,151,153,61,188})), 0.05, 1, function()
return _v120.Camera.Smoothness
end, function(_v536)
_v120.Camera.Smoothness = _v536
end, false)
_v278(_v59, (_V9({137,254,134})), 20, 800, function()
return _v120.Camera.FOV
end, function(_v536)
_v120.Camera.FOV = _v536
end, true, (_V9({191,201})), true)
_v278(_v59, (_V9({130,208,168,87,167,180,138,136,47,161,210,181})), 100, 2000, function()
return _v120.Camera.MaxDistance
end, function(_v536)
_v120.Camera.MaxDistance = _v536
end, true, (_V9({162})), true)
local _v409
local _v219 = _v279(right, (_V9({135,216,164,21,140,165})))
_v277(_v219, _v120.Camera.HitboxOptions, function()
return _v120.Camera.Hitbox
end, function(_v536)
_v120.Camera.Hitbox = _v536
if _v409 then
_v409()
end
end)
local _v556, setWeightsEnabled = _v279(right, (_V9({155,208,162,16,134,169,217,175,43,187,197,185,25,132,174})))
local function _v555(name)
_v278(_v556, name .. (_V9({239,230,181,30,132,181,141})), 0, 100, function()
return _v120.Camera.TargetWeights[name]
end, function(_v536)
_v120.Camera.TargetWeights[name] = _v536
end, true, (_V9({234})), true)
end
_v555((_V9({135,212,177,19})))
_v555((_V9({155,222,162,4,140})))
_v555((_V9({142,195,189,4})))
_v555((_V9({131,212,183,4})))
_v409 = function()
setWeightsEnabled(_v120.Camera.Hitbox == (_V9({157,208,190,19,140,176,217,212,25,170,216,183,31,151,184,157,213})))
end
_v409()
table.insert(_v486, _v409)
local _v522 = _v279(right, (_V9({155,195,185,16,132,184,139,158,33,187})))
_v288(_v522, (_V9({138,223,177,21,143,184,157})), function()
return _v120.Triggerbot.Enabled
end, function()
_v120.Triggerbot.Enabled = not _v120.Triggerbot.Enabled
end, (_V9({155,195,185,16,132,184,139,158,33,187,145,155,18,154})), function()
return _v120.Triggerbot.ToggleKey
end, function(_v248)
_v120.Triggerbot.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({187,195,185,16,132,184,139,158,33,187})))
end)
_v278(_v522, (_V9({130,216,190,87,167,184,149,157,55})), 0, 500, function()
return _v120.Triggerbot.MinDelay * 1000
end, function(_v536)
_v120.Triggerbot.MinDelay = _v536 / 1000
end, true, (_V9({162,194})), true)
_v278(_v522, (_V9({130,208,168,87,167,184,149,157,55})), 0, 500, function()
return _v120.Triggerbot.MaxDelay * 1000
end, function(_v536)
_v120.Triggerbot.MaxDelay = _v536 / 1000
end, true, (_V9({162,194})), true)
_v278(_v522, (_V9({130,208,168,87,167,180,138,136,47,161,210,181})), 100, 2000, function()
return _v120.Triggerbot.MaxDistance
end, function(_v536)
_v120.Triggerbot.MaxDistance = _v536
end, true, (_V9({162})), true)
_v287(_v522, (_V9({153,216,163,20,139,184,154,151})), function()
return _v120.Triggerbot.WallCheck
end, function()
_v120.Triggerbot.WallCheck = not _v120.Triggerbot.WallCheck
end)
local _v465 = _v279(right, (_V9({156,216,188,18,141,169,217,189,39,162})))
_v287(_v465, (_V9({138,223,177,21,143,184,157})), function()
return _v120.SilentAim.Enabled
end, function()
_v120.SilentAim.Enabled = not _v120.SilentAim.Enabled
end)
local _v176 = _v279(right, (_V9({135,216,164,21,140,165,217,185,54,191,208,190,19,134,175})))
_v287(_v176, (_V9({138,223,177,21,143,184,157})), function()
return _v120.Hitbox.Enabled
end, function()
_v120.Hitbox.Enabled = not _v120.Hitbox.Enabled
end)
_v278(_v176, (_V9({156,216,170,18})), 1, 20, function()
return _v120.Hitbox.Size
end, function(_v536)
_v120.Hitbox.Size = _v536
end, true)
_v278(_v176, (_V9({155,195,177,25,144,173,152,142,43,161,210,169})), 0, 1, function()
return _v120.Hitbox.Transparency
end, function(_v536)
_v120.Hitbox.Transparency = _v536
end, false)
_v258, right = _v275(_v222:add((_V9({152,212,177,7,140,179,138}))))
local _v404 = _v279(_v258, (_V9({129,222,240,37,134,190,150,149,34})))
_v288(_v404, (_V9({138,223,177,21,143,184,157})), function()
return _v120.NoRecoil.Enabled
end, function()
_v120.NoRecoil.Enabled = not _v120.NoRecoil.Enabled
end, (_V9({129,222,240,37,134,190,150,149,34,239,250,181,14})), function()
return _v120.NoRecoil.ToggleKey
end, function(_v248)
_v120.NoRecoil.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({161,222,162,18,128,178,144,144})))
end)
_v287(_v404, (_V9({128,223,188,14,195,138,145,149,34,170,145,150,30,145,180,151,155})), function()
return _v120.NoRecoil.RequireMouseDown
end, function()
_v120.NoRecoil.RequireMouseDown = not _v120.NoRecoil.RequireMouseDown
end)
_v287(_v404, (_V9({142,221,188,24,148,253,184,149,35,239,245,191,0,141})), function()
return _v120.NoRecoil.AllowAim
end, function()
_v120.NoRecoil.AllowAim = not _v120.NoRecoil.AllowAim
end)
_v278(_v404, (_V9({156,197,162,18,141,186,141,148})), 0, 100, function()
return _v120.NoRecoil.Strength * 100
end, function(_v536)
_v120.NoRecoil.Strength = _v536 / 100
end, true, (_V9({234})), true)
local _v470 = _v279(_v258, (_V9({129,222,240,36,147,175,156,157,42})))
_v288(_v470, (_V9({138,223,177,21,143,184,157})), function()
return _v120.NoSpread.Enabled
end, function()
_v120.NoSpread.Enabled = not _v120.NoSpread.Enabled
end, (_V9({129,222,240,36,147,175,156,157,42,239,250,181,14})), function()
return _v120.NoSpread.ToggleKey
end, function(_v248)
_v120.NoSpread.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({161,222,163,7,145,184,152,152})))
end)
_v287(_v470, (_V9({128,223,188,14,195,138,145,149,34,170,145,150,30,145,180,151,155})), function()
return _v120.NoSpread.RequireMouseDown
end, function()
_v120.NoSpread.RequireMouseDown = not _v120.NoSpread.RequireMouseDown
end)
_v278(_v470, (_V9({156,197,162,18,141,186,141,148})), 0, 100, function()
return _v120.NoSpread.Strength * 100
end, function(_v536)
_v120.NoSpread.Strength = _v536 / 100
end, true, (_V9({234})), true)
end
local function _v85(_v376, _v120)
_v257 = 0
local _v222 = _v285(_v376)
local _v258, right = _v275(_v222:add((_V9({138,226,128}))))
local _v171 = _v279(_v258, (_V9({138,226,128})))
_v288(_v171, (_V9({138,223,177,21,143,184,157})), function()
return _v120.ESP.Enabled
end, function()
_v120.ESP.Enabled = not _v120.ESP.Enabled
end, (_V9({138,226,128,87,168,184,128})), function()
return _v120.ESP.ToggleKey
end, function(_v248)
_v120.ESP.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({170,194,160})))
end)
_v287(_v171, (_V9({129,225,147,4})), function()
return _v120.ESP.NPCs
end, function()
_v120.ESP.NPCs = not _v120.ESP.NPCs
end)
_v278(_v171, (_V9({130,208,168,87,167,180,138,136,47,161,210,181})), 100, 2000, function()
return _v120.ESP.MaxDistance
end, function(_v536)
_v120.ESP.MaxDistance = _v536
end, true, (_V9({162})), true)
local _v269 = _v279(_v258, (_V9({142,193,160,18,130,175,152,146,45,170})))
_v287(_v269, (_V9({128,196,164,27,138,179,156,143})), function()
return _v120.ESP.Outlines
end, function()
_v120.ESP.Outlines = not _v120.ESP.Outlines
end)
_v287(_v269, (_V9({141,222,168,18,144})), function()
return _v120.ESP.Boxes
end, function()
_v120.ESP.Boxes = not _v120.ESP.Boxes
end)
_v287(_v269, (_V9({129,208,189,18,144})), function()
return _v120.ESP.Names
end, function()
_v120.ESP.Names = not _v120.ESP.Names
end)
_v287(_v269, (_V9({139,216,163,3,130,179,154,153})), function()
return _v120.ESP.Distance
end, function()
_v120.ESP.Distance = not _v120.ESP.Distance
end)
_v287(_v269, (_V9({135,212,177,27,151,181,217,190,47,189,194})), function()
return _v120.ESP.HealthBars
end, function()
_v120.ESP.HealthBars = not _v120.ESP.HealthBars
end)
_v287(_v269, (_V9({137,216,188,27,134,185})), function()
return _v120.ESP.Filled
end, function()
_v120.ESP.Filled = not _v120.ESP.Filled
end)
_v278(_v269, (_V9({128,196,164,27,138,179,156,220,1,191,208,179,30,151,164})), 0, 1, function()
return _v120.ESP.OutlineOpacity
end, function(_v536)
_v120.ESP.OutlineOpacity = _v536
end, false)
_v278(_v269, (_V9({137,216,188,27,195,146,137,157,45,166,197,169})), 0, 1, function()
return _v120.ESP.FillOpacity
end, function(_v536)
_v120.ESP.FillOpacity = _v536
end, false)
local _v158 = _v279(right, (_V9({139,195,177,0,138,179,158,220,11,156,225})))
_v287(_v158, (_V9({141,222,168,18,144})), function()
return _v120.Drawing.Boxes
end, function()
_v120.Drawing.Boxes = not _v120.Drawing.Boxes
end)
_v287(_v158, (_V9({155,195,177,20,134,175,138})), function()
return _v120.Drawing.Tracers
end, function()
_v120.Drawing.Tracers = not _v120.Drawing.Tracers
end)
local _v560 = _v279(right, (_V9({152,222,162,27,135})))
_v287(_v560, (_V9({137,196,188,27,129,175,144,155,38,187})), function()
return _v120.Visuals.Fullbright
end, function()
_v120.Visuals.Fullbright = not _v120.Visuals.Fullbright
end)
_v287(_v560, (_V9({129,222,240,49,140,186})), function()
return _v120.Visuals.NoFog
end, function()
_v120.Visuals.NoFog = not _v120.Visuals.NoFog
end)
_v258, right = _v275(_v222:add((_V9({140,222,188,24,145,174}))))
_v274(_v258, (_V9({128,196,164,27,138,179,156,220,13,160,221,191,5})), function()
return _v120.ESP.OutlineColor
end, function(c)
_v120.ESP.OutlineColor = c
end)
_v274(right, (_V9({137,216,188,27,195,158,150,144,33,189})), function()
return _v120.ESP.FillColor
end, function(c)
_v120.ESP.FillColor = c
end)
_v274(_v258, (_V9({141,222,168,87,160,178,149,147,60})), function()
return _v120.Drawing.BoxColor
end, function(c)
_v120.Drawing.BoxColor = c
end)
_v274(right, (_V9({155,195,177,20,134,175,217,191,33,163,222,162})), function()
return _v120.Drawing.TracerColor
end, function(c)
_v120.Drawing.TracerColor = c
end)
end
local function _v90(_v376, _v120)
_v257 = 0
local _v222 = _v285(_v376)
local _v258, right = _v275(_v222:add((_V9({130,222,166,18,142,184,151,136}))))
local _v182 = _v279(_v258, (_V9({137,221,169})))
_v287(_v182, (_V9({138,223,177,21,143,184,157})), function()
return _v120.Movement.FlyEnabled
end, function()
_v120.Movement.FlyEnabled = not _v120.Movement.FlyEnabled
end)
_v278(_v182, (_V9({137,221,169,87,176,173,156,153,42})), 10, 200, function()
return _v120.Movement.FlySpeed
end, function(_v536)
_v120.Movement.FlySpeed = _v536
end, true)
local _v469 = _v279(_v258, (_V9({156,193,181,18,135})))
_v287(_v469, (_V9({138,223,177,21,143,184,157})), function()
return _v120.Movement.SpeedEnabled
end, function()
_v120.Movement.SpeedEnabled = not _v120.Movement.SpeedEnabled
end)
_v278(_v469, (_V9({156,193,181,18,135})), 16, 100, function()
return _v120.Movement.Speed
end, function(_v536)
_v120.Movement.Speed = _v536
end, true)
local _v295 = _v279(_v258, (_V9({128,197,184,18,145})))
_v287(_v295, (_V9({129,222,179,27,138,173})), function()
return _v120.Movement.NoclipEnabled
end, function()
_v120.Movement.NoclipEnabled = not _v120.Movement.NoclipEnabled
end)
_v287(_v295, (_V9({134,223,182,30,141,180,141,153,110,133,196,189,7})), function()
return _v120.Movement.InfJumpEnabled
end, function()
_v120.Movement.InfJumpEnabled = not _v120.Movement.InfJumpEnabled
end)
local _v520 = _v279(right, (_V9({140,221,185,20,136,253,173,172})))
_v287(_v520, (_V9({138,223,177,21,143,184,157})), function()
return _v120.Movement.ClickTPEnabled
end, function()
_v120.Movement.ClickTPEnabled = not _v120.Movement.ClickTPEnabled
end)
_v282(_v520, (_V9({130,222,180,30,133,180,156,142,110,132,212,169})), function()
return _v120.Movement.ClickTPKey
end, function(_v248)
_v120.Movement.ClickTPKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({172,221,185,20,136,169,137})))
end)
end
local function _v91(_v376, _v120)
_v257 = 0
local _v222 = _v285(_v376)
local _v258, right = _v275(_v222:add((_V9({159,221,177,14,134,175,138}))))
local _v264 = _v279(_v258, (_V9({159,221,177,14,134,175,217,176,39,188,197})))
_v388 = _v320((_V9({156,210,162,24,143,177,144,146,41,137,195,177,26,134})), {
Parent = _v264,
LayoutOrder = _v322(),
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v388, CornerRadius = UDim.new(0, 6) })
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = _v388,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = _v388,
PaddingTop = UDim.new(0, 4),
PaddingBottom = UDim.new(0, 4),
PaddingLeft = UDim.new(0, 4),
PaddingRight = UDim.new(0, 4),
})
local function _v407()
for _v386, row in pairs(_v389) do
row.btn.BackgroundColor3 = (_v386 == _v455) and _v6.accent or _v6.row
end
end
local function _v406()
if not _v388 then
return
end
for _, _v115 in ipairs(_v388:GetChildren()) do
if not _v115:IsA((_V9({154,248,156,30,144,169,181,157,55,160,196,164}))) then
_v115:Destroy()
end
end
table.clear(_v389)
local _v127 = 0
for _, _v386 in ipairs(_v31:GetPlayers()) do
if _v386 ~= _v26 then
_v127 = _v127 + 1
local row = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v388,
LayoutOrder = _v127,
Size = UDim2.new(1, 0, 0, 24),
BackgroundColor3 = (_v386 == _v455) and _v6.accent or _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Text = (_V9({})),
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = row, CornerRadius = UDim.new(0, 4) })
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = row,
Size = UDim2.new(0.65, -8, 1, 0),
Position = UDim2.fromOffset(8, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v386.TeamColor.Color,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Text = _v386.Name,
})
local dist = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = row,
Size = UDim2.new(0.35, -8, 1, 0),
Position = UDim2.new(0.65, 0, 0, 0),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Right,
Text = (_V9({45,49,68})),
})
row.MouseButton1Click:Connect(function()
_v455 = (_v455 == _v386) and nil or _v386
_v407()
end)
_v389[_v386] = { btn = row, dist = dist }
end
end
if _v127 == 0 then
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v388,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({239,145,190,24,195,178,141,148,43,189,145,160,27,130,164,156,142,61})),
})
end
end
local _v53 = _v279(right, (_V9({142,210,164,30,140,179,138})))
local _v454 = _v283(_v53, (_V9({156,212,188,18,128,169,156,152})), (_V9({45,49,68})))
_v273(_v53, (_V9({155,212,188,18,147,178,139,136,110,155,222})), function()
local _v112 = _v455 and _v455.Character
local root = _v112 and _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
if root and UI.TeleportTo then
UI.TeleportTo(root.Position)
end
end)
_v467 = _v273(_v53, (_V9({156,193,181,20,151,188,141,153})), function()
if _v468 then
_v478()
elseif _v455 then
_v476(_v455)
end
end)
table.insert(_v486, function()
_v454.Text = _v455 and _v455.Name or (_V9({45,49,68}))
_v407()
end)
_v406()
table.insert(_v525, _v31.PlayerAdded:Connect(function()
_v406()
end))
table.insert(_v525, _v31.PlayerRemoving:Connect(function(_v386)
if _v386 == _v455 then
_v455 = nil
end
if _v386 == _v468 then
_v478()
end
_v406()
end))
local _v255 = 0
table.insert(_v525, _v38.RenderStepped:Connect(function()
if os.clock() - _v255 < 0.5 then
return
end
_v255 = os.clock()
_v454.Text = _v455 and _v455.Name or (_V9({45,49,68}))
local _v312 = _v26.Character
local _v313 = _v312 and _v312:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
for _v386, row in pairs(_v389) do
local _v112 = _v386.Character
local root = _v112 and _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
row.dist.Text = (_v313 and root)
and (math.floor((root.Position - _v313.Position).Magnitude + 0.5) .. (_V9({162})))
or (_V9({45,49,68}))
end
if _v468 then
if _v56 and _v56.Movement and _v56.Movement.FlyEnabled then
_v478()
else
local _v112 = _v468.Character
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
local _v95 = _v50.CurrentCamera
if humanoid and humanoid.Health > 0 and _v95 then
_v95.CameraSubject = humanoid
else
_v478()
end
end
end
end))
end
local function _v89(_v376, _v120)
_v257 = 0
local _v222 = _v285(_v376)
local _v258, right = _v275(_v222:add((_V9({156,212,163,4,138,178,151}))))
local _v52 = _v279(_v258, (_V9({142,210,179,24,150,179,141})))
_v283(_v52, (_V9({154,194,181,5,141,188,148,153})), _v26 and _v26.Name or (_V9({45,49,68})))
_v283(_v52, (_V9({139,216,163,7,143,188,128,220,0,174,220,181})), _v26 and _v26.DisplayName or (_V9({45,49,68})))
_v283(_v52, (_V9({154,194,181,5,195,148,189})), _v26 and tostring(_v26.UserId) or (_V9({45,49,68})))
_v273(_v52, (_V9({156,212,162,1,134,175,217,180,33,191})), function()
_v47:ServerHop()
end)
_v273(_v52, (_V9({157,212,186,24,138,179,217,175,43,189,199,181,5})), function()
_v47:Rejoin()
end)
local _v554 = _v279(right, (_V9({152,212,178,31,140,178,146})))
local _v535 = _v286(_v554, (_V9({184,212,178,31,140,178,146,220,59,189,221,50,247,69})))
_v535.Text = _v120.Webhook.Url
_v535.FocusLost:Connect(function()
_v120.Webhook.Url = _v535.Text
end)
_v273(_v554, (_V9({156,212,190,19,195,137,156,143,58,239,230,181,21,139,178,150,151})), function()
local _v343, res = _v49.SendWebhook((_V9({153,208,190,30,151,164,212,187,43,161,212,162,22,143,253,141,153,61,187,145,167,18,129,181,150,147,37})))
if _v343 then
UI:Notify((_V9({155,212,163,3,195,170,156,158,38,160,222,187,87,144,184,151,136})), 2)
else
UI:Notify((_V9({152,212,178,31,140,178,146,220,40,174,216,188,18,135,231,217})) .. tostring(res), 3)
end
end)
end
local function _v92(_v376, _v120)
_v257 = 0
local _v222 = _v285(_v376)
local _v258, right = _v275(_v222:add((_V9({136,212,190,18,145,188,149}))))
local _v229 = _v279(_v258, (_V9({134,223,164,18,145,187,152,159,43})))
_v278(_v229, (_V9({154,248,240,36,128,188,149,153})), 0.8, 1.5, function()
return _v120.UI.Scale
end, function(_v536)
_v120.UI.Scale = _v536
if _v558 then
_v558.Scale = _v536
end
end, false)
_v287(_v229, (_V9({132,212,169,21,138,179,157,220,30,174,223,181,27})), function()
return _v120.UI.KeybindPanel
end, function()
_v120.UI.KeybindPanel = not _v120.UI.KeybindPanel
if _v251 then
_v251.Visible = _v120.UI.KeybindPanel
end
end)
_v287(_v229, (_V9({155,208,162,16,134,169,217,184,39,188,193,188,22,154})), function()
return _v120.UI.TargetDisplay
end, function()
_v120.UI.TargetDisplay = not _v120.UI.TargetDisplay
_v496 = _v120.UI.TargetDisplay
if not _v496 and _v497 then
_v497.Visible = false
end
end)
_v287(_v229, (_V9({137,225,131,87,160,178,140,146,58,170,195})), function()
return _v120.UI.FPSCounter
end, function()
_v120.UI.FPSCounter = not _v120.UI.FPSCounter
if _v190 then
_v190.Visible = _v120.UI.FPSCounter
end
end)
_v287(_v229, (_V9({152,208,164,18,145,176,152,142,37})), function()
return _v120.UI.Watermark
end, function()
_v120.UI.Watermark = not _v120.UI.Watermark
if _v553 then
_v553.Visible = _v120.UI.Watermark
end
end)
_v274(_v229, (_V9({142,210,179,18,141,169,217,191,33,163,222,162})), function()
return _v120.UI.Accent
end, function(_v318)
_v69(_v318)
end)
table.insert(_v486, function()
if _v120.UI.Accent then
_v69(_v120.UI.Accent)
end
end)
_v258, right = _v275(_v222:add((_V9({140,222,190,17,138,186,138}))))
local _v109 = _v279(_v258, (_V9({140,222,190,17,138,186,138})))
if not _v11.isSupported() then
_v283(_v109, (_V9({156,197,177,3,150,174})), (_V9({154,223,163,2,147,173,150,142,58,170,213})))
return
end
local _v315 = _v286(_v109, (_V9({172,222,190,17,138,186,217,146,47,162,212,50,247,69})))
local _v265 = _v320((_V9({137,195,177,26,134})), {
Parent = _v109,
LayoutOrder = _v322(),
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = _v265,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 4),
})
local _v406
local function _v452(name)
_v315.Text = name
_v406()
end
_v406 = function()
for _, _v115 in ipairs(_v265:GetChildren()) do
if not _v115:IsA((_V9({154,248,156,30,144,169,181,157,55,160,196,164}))) then
_v115:Destroy()
end
end
local _v317 = _v11.list()
if #_v317 == 0 then
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v265,
LayoutOrder = 1,
Size = UDim2.new(1, 0, 0, 22),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({161,222,240,4,130,171,156,152,110,172,222,190,17,138,186,138})),
})
return
end
for i, name in ipairs(_v317) do
local _v453 = (_v315.Text == name)
local row = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v265,
LayoutOrder = i,
Size = UDim2.new(1, 0, 0, 22),
BackgroundColor3 = _v453 and _v6.accent or _v6.row,
BackgroundTransparency = _v453 and 0 or 0.35,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.Gotham,
TextSize = 11,
TextColor3 = _v453 and Color3.fromRGB(255, 255, 255) or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({239,145})) .. name,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = row, CornerRadius = UDim.new(0, 4) })
row.MouseButton1Click:Connect(function()
_v452(name)
end)
row.MouseEnter:Connect(function()
if _v315.Text ~= name then
row.BackgroundTransparency = 0
row.BackgroundColor3 = _v6.rowHover
end
end)
row.MouseLeave:Connect(function()
if _v315.Text ~= name then
row.BackgroundTransparency = 0.35
row.BackgroundColor3 = _v6.row
end
end)
end
end
_v273(_v109, (_V9({156,208,166,18})), function()
local _v343, res = _v11.save(_v315.Text, _v120)
if _v343 then
UI:Notify((_V9({156,208,166,18,135,253,154,147,32,169,216,183,87,196})) .. res .. (_V9({232})), 2)
_v406()
else
UI:Notify(tostring(res), 3)
end
end)
_v273(_v109, (_V9({131,222,177,19})), function()
local _v343, res = _v11.load(_v315.Text, _v120)
if _v343 then
if _v558 then
_v558.Scale = _v120.UI.Scale
end
UI:SyncControls()
UI:Notify((_V9({131,222,177,19,134,185,217,159,33,161,215,185,16,195,250})) .. res .. (_V9({232})), 2)
else
UI:Notify(tostring(res), 3)
end
end)
_v273(_v109, (_V9({139,212,188,18,151,184})), function()
local _v343, res = _v11.delete(_v315.Text)
if _v343 then
UI:Notify((_V9({139,212,188,18,151,184,157,220,45,160,223,182,30,132,253,222})) .. res .. (_V9({232})), 2)
_v315.Text = (_V9({}))
_v406()
else
UI:Notify(tostring(res), 3)
end
end, _v6.danger)
_v406()
end
local function _v93(_v120)
_v497 = _v320((_V9({137,195,177,26,134})), {
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v497, CornerRadius = UDim.new(0, 6) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v497, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = _v497,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = _v497,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v155 = _v320((_V9({137,195,177,26,134})), {
Parent = _v497,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v155, CornerRadius = UDim.new(1, 0) })
targetPanelLabel = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v497,
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
local _v157, _v156, _v475
_v497.InputBegan:Connect(function(_v232)
if _v245(_v232) then
_v157 = true
_v156 = _v232.Position
_v475 = _v497.Position
end
end)
table.insert(_v301, function(_v232)
if _v157 and _v497 then
local delta = _v232.Position - _v156
_v497.Position = UDim2.new(
_v475.X.Scale,
_v475.X.Offset + delta.X,
_v475.Y.Scale,
_v475.Y.Offset + delta.Y
)
end
end)
table.insert(_v412, function()
_v157 = false
end)
table.insert(_v486, function()
_v496 = _v120.UI.TargetDisplay
if not _v496 and _v497 then
_v497.Visible = false
end
end)
_v496 = _v120.UI.TargetDisplay
end
local function _v87(_v120)
_v190 = _v320((_V9({137,195,177,26,134})), {
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v190, CornerRadius = UDim.new(0, 6) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v190, Color = _v6.accent, Thickness = 1, Transparency = 0.4 })
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = _v190,
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 12),
})
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = _v190,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
})
local _v155 = _v320((_V9({137,195,177,26,134})), {
Parent = _v190,
LayoutOrder = 0,
Size = UDim2.fromOffset(6, 6),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v155, CornerRadius = UDim.new(1, 0) })
fpsLabel = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
Text = (_V9({226,156,240,17,147,174})),
})
table.insert(_v486, function()
if _v190 then
_v190.Visible = _v120.UI.FPSCounter
end
end)
_v190.Visible = _v120.UI.FPSCounter
end
local function _v94(_v120)
_v553 = _v320((_V9({134,220,177,16,134,145,152,158,43,163})), {
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
UI:SetWatermarkImage(_v120.UI.WatermarkImageId)
table.insert(_v486, function()
if _v553 then
_v553.Visible = _v120.UI.Watermark
end
end)
_v553.Visible = _v120.UI.Watermark
end
local function _v88(_v120)
_v257 = 0
_v251 = _v320((_V9({137,195,177,26,134})), {
Parent = _v202,
Size = UDim2.fromOffset(230, 0),
AutomaticSize = Enum.AutomaticSize.Y,
Position = UDim2.fromOffset(680, 100),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
Visible = false,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v251, CornerRadius = UDim.new(0, 8) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v251, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), {
Parent = _v251,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 6),
})
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = _v251,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 12),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local bar = _v320((_V9({137,195,177,26,134})), {
Parent = _v251,
LayoutOrder = 0,
Size = UDim2.new(1, 0, 0, 26),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = bar, CornerRadius = UDim.new(0, 6) })
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = bar,
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({132,212,169,21,138,179,157,143})),
})
local _v157, _v156, _v475
bar.InputBegan:Connect(function(_v232)
if _v245(_v232) then
_v157 = true
_v156 = _v232.Position
_v475 = _v251.Position
end
end)
table.insert(_v301, function(_v232)
if _v157 and _v251 then
local delta = _v232.Position - _v156
_v251.Position = UDim2.new(
_v475.X.Scale,
_v475.X.Offset + delta.X,
_v475.Y.Scale,
_v475.Y.Offset + delta.Y
)
end
end)
table.insert(_v412, function()
_v157 = false
end)
_v282(_v251, (_V9({130,212,190,2})), function()
return _v120.UI.MenuKey
end, function(_v248)
_v120.UI.MenuKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({162,212,190,2})))
end)
_v282(_v251, (_V9({142,216,189,21,140,169})), function()
return _v120.Camera.ToggleKey
end, function(_v248)
_v120.Camera.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({174,216,189,21,140,169})))
end)
_v282(_v251, (_V9({138,226,128})), function()
return _v120.ESP.ToggleKey
end, function(_v248)
_v120.ESP.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({170,194,160})))
end)
_v282(_v251, (_V9({137,254,134,87,160,180,139,159,34,170})), function()
return _v120.Camera.FOVCircleKey
end, function(_v248)
_v120.Camera.FOVCircleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({169,222,166,20,138,175,154,144,43})))
end)
_v282(_v251, (_V9({129,222,240,37,134,190,150,149,34})), function()
return _v120.NoRecoil.ToggleKey
end, function(_v248)
_v120.NoRecoil.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({161,222,162,18,128,178,144,144})))
end)
_v282(_v251, (_V9({129,222,240,36,147,175,156,157,42})), function()
return _v120.NoSpread.ToggleKey
end, function(_v248)
_v120.NoSpread.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({161,222,163,7,145,184,152,152})))
end)
_v282(_v251, (_V9({155,195,185,16,132,184,139,158,33,187})), function()
return _v120.Triggerbot.ToggleKey
end, function(_v248)
_v120.Triggerbot.ToggleKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({187,195,185,16,132,184,139,158,33,187})))
end)
_v282(_v251, (_V9({154,223,188,24,130,185})), function()
return _v120.UI.UnloadKey
end, function(_v248)
_v120.UI.UnloadKey = _v248
end, function(_v248)
return _v249(_v120, _v248, (_V9({186,223,188,24,130,185})))
end)
table.insert(_v486, function()
if _v251 then
_v251.Visible = _v120.UI.KeybindPanel
end
end)
_v251.Visible = _v120.UI.KeybindPanel
end
local function _v460(_v477)
if not _v272 or _v477 == _v542 then
return
end
_v542 = _v477
if _v56 and _v56.UI then
_v56.UI.Visible = _v477
end
if _v477 then
_v272.Visible = true
_v272.GroupTransparency = 1
_v45:Create(_v272, TweenInfo.new(_v17), { GroupTransparency = 0 }):Play()
else
local _v524 = _v45:Create(_v272, TweenInfo.new(_v17), { GroupTransparency = 1 })
_v524.Completed:Once(function()
if not _v542 and _v272 then
_v272.Visible = false
end
end)
_v524:Play()
end
end
function UI:Init(_v120, _v362)
if _v202 then
return
end
_v56 = _v120
_v363 = _v362
if _v120.UI.Accent then
_v6.accent = _v120.UI.Accent
end
_v474()
_v202 = _v320((_V9({156,210,162,18,134,179,190,137,39})), {
Name = _v10.RandomName(),
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
})
local _v343 = pcall(function()
_v202.Parent = _v47.getGuiParent()
end)
if not _v343 or not _v202.Parent then
_v202.Parent = _v26:WaitForChild((_V9({159,221,177,14,134,175,190,137,39})))
end
_v10.Protect(_v202)
_v272 = _v320((_V9({140,208,190,1,130,174,190,142,33,186,193})), {
Parent = _v202,
Size = UDim2.fromOffset(580, 400),
Position = UDim2.fromOffset(60, 80),
BackgroundColor3 = _v6.bg,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
})
_v558 = _v320((_V9({154,248,131,20,130,177,156})), { Parent = _v272, Scale = _v120.UI.Scale })
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v272, CornerRadius = UDim.new(0, 8) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v272, Color = _v6.accent, Thickness = 1, Transparency = 0.35 })
local _v511 = _v320((_V9({137,195,177,26,134})), {
Parent = _v272,
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v511, CornerRadius = UDim.new(0, 8) })
_v320((_V9({137,195,177,26,134})), {
Parent = _v511,
Size = UDim2.new(1, 0, 0, 12),
Position = UDim2.new(0, 0, 1, -12),
BackgroundColor3 = _v6.bar,
BorderSizePixel = 0,
})
local _v155 = _v320((_V9({137,195,177,26,134})), {
Parent = _v511,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 12, 0.5, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
ZIndex = 2,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v155, CornerRadius = UDim.new(1, 0) })
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v511,
Size = UDim2.new(1, -34, 1, 0),
Position = UDim2.fromOffset(28, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = _v6.text,
TextXAlignment = Enum.TextXAlignment.Left,
RichText = true,
Text = (_V9({153,208,190,30,151,164,197,154,33,161,197,240,20,140,177,150,142,115,237,146,232,67,208,152,187,185,108,241,159,180,18,149,225,214,154,33,161,197,238,87,164,184,151,153,60,174,221}))
.. (_V9({243,215,191,25,151,253,154,147,34,160,195,237,85,192,229,184,203,13,142,129,242,73,195,253,217,62,249,239,145,240,1,211,225,214,154,33,161,197,238})),
ZIndex = 2,
})
_v320((_V9({155,212,168,3,175,188,155,153,34})), {
Parent = _v511,
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
local _v157, _v156, _v475
_v511.InputBegan:Connect(function(_v232)
if _v245(_v232) then
_v157 = true
_v156 = _v232.Position
_v475 = _v272.Position
end
end)
table.insert(_v301, function(_v232)
if _v157 then
local delta = _v232.Position - _v156
_v272.Position = UDim2.new(
_v475.X.Scale,
_v475.X.Offset + delta.X,
_v475.Y.Scale,
_v475.Y.Offset + delta.Y
)
end
end)
table.insert(_v412, function()
_v157 = false
end)
local _v464 = _v320((_V9({137,195,177,26,134})), {
Parent = _v272,
Position = UDim2.fromOffset(10, 44),
Size = UDim2.new(0, 120, 1, -54),
BackgroundColor3 = _v6.panel,
BorderSizePixel = 0,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v464, CornerRadius = UDim.new(0, 6) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v464, Color = _v6.border, Thickness = 1, Transparency = 0.15 })
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = _v464,
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
})
local _v492 = _v320((_V9({137,195,177,26,134})), {
Parent = _v464,
Size = UDim2.new(1, 0, 1, -40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v320((_V9({154,248,156,30,144,169,181,157,55,160,196,164})), { Parent = _v492, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
local _v527 = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v464,
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
Size = UDim2.new(1, 0, 0, 30),
BackgroundColor3 = _v6.row,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = _v6.danger,
Text = (_V9({154,223,188,24,130,185})),
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v527, CornerRadius = UDim.new(0, 6) })
local _v528 = _v320((_V9({154,248,131,3,145,178,146,153})), {
Parent = _v527,
Color = _v6.danger,
Thickness = 1,
Transparency = 0.55,
})
_v527.MouseButton1Click:Connect(function()
if _v363 then
_v363()
end
end)
_v527.MouseEnter:Connect(function()
_v45:Create(_v527, _v1, {
BackgroundColor3 = _v6.danger,
TextColor3 = Color3.fromRGB(255, 255, 255),
}):Play()
_v45:Create(_v528, _v1, { Transparency = 0 }):Play()
end)
_v527.MouseLeave:Connect(function()
_v45:Create(_v527, _v1, {
BackgroundColor3 = _v6.row,
TextColor3 = _v6.danger,
}):Play()
_v45:Create(_v528, _v1, { Transparency = 0.55 }):Play()
end)
local content = _v320((_V9({137,195,177,26,134})), {
Parent = _v272,
Position = UDim2.fromOffset(140, 44),
Size = UDim2.new(1, -150, 1, -54),
BackgroundTransparency = 1,
BorderSizePixel = 0,
})
_v320((_V9({154,248,128,22,135,185,144,146,41})), {
Parent = content,
PaddingRight = UDim.new(0, 4),
})
local _v494 = { (_V9({140,222,189,21,130,169})), (_V9({153,216,163,2,130,177})), (_V9({130,222,166,18,142,184,151,136})), (_V9({159,221,177,14,134,175,138})), (_V9({130,216,163,20})), (_V9({156,212,164,3,138,179,158,143})) }
local _v491 = {}
for i, _v493 in ipairs(_v494) do
local _v238 = _v128 == _v493
local _v489 = _v320((_V9({155,212,168,3,161,168,141,136,33,161})), {
Parent = _v492,
LayoutOrder = i,
Size = UDim2.new(1, 0, 1 / #_v494, -6),
BackgroundColor3 = _v6.rowHover,
BackgroundTransparency = _v238 and 0 or 1,
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = _v238 and _v6.text or _v6.textSub,
TextXAlignment = Enum.TextXAlignment.Left,
Text = (_V9({239,145,240,87})) .. _v493,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v489, CornerRadius = UDim.new(0, 6) })
local stripe = _v320((_V9({137,195,177,26,134})), {
Parent = _v489,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 5, 0.5, 0),
Size = UDim2.fromOffset(3, 16),
BackgroundColor3 = _v6.accent,
BorderSizePixel = 0,
Visible = _v238,
ZIndex = 2,
})
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = stripe, CornerRadius = UDim.new(1, 0) })
local _v490 = _v320((_V9({137,195,177,26,134})), {
Parent = content,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = _v238,
})
_v491[_v493] = { btn = _v489, frame = _v490, stripe = stripe }
_v489.MouseButton1Click:Connect(function()
_v128 = _v493
for name, _v488 in pairs(_v491) do
local _v54 = name == _v493
_v488.frame.Visible = _v54
_v488.stripe.Visible = _v54
_v45:Create(_v488.btn, _v1, {
BackgroundTransparency = _v54 and 0 or 1,
TextColor3 = _v54 and _v6.text or _v6.textSub,
}):Play()
end
end)
_v489.MouseEnter:Connect(function()
if _v128 ~= _v493 then
_v45:Create(_v489, _v1, { BackgroundTransparency = 0.6 }):Play()
end
end)
_v489.MouseLeave:Connect(function()
if _v128 ~= _v493 then
_v45:Create(_v489, _v1, { BackgroundTransparency = 1 }):Play()
end
end)
end
_v84(_v491[(_V9({140,222,189,21,130,169}))].frame, _v120)
_v85(_v491[(_V9({153,216,163,2,130,177}))].frame, _v120)
_v90(_v491[(_V9({130,222,166,18,142,184,151,136}))].frame, _v120)
_v91(_v491[(_V9({159,221,177,14,134,175,138}))].frame, _v120)
_v89(_v491[(_V9({130,216,163,20}))].frame, _v120)
_v92(_v491[(_V9({156,212,164,3,138,179,158,143}))].frame, _v120)
_v88(_v120)
_v93(_v120)
_v87(_v120)
_v94(_v120)
if _v120.UI.Visible then
_v460(true)
end
end
function UI:Toggle()
_v460(not _v542)
end
function UI:Show()
_v460(true)
end
function UI:Hide()
_v460(false)
end
function UI:SetCurrentTarget(name)
if not _v497 then
return
end
if _v497.Visible ~= _v496 then
_v497.Visible = _v496
end
if not _v496 or not targetPanelLabel then
return
end
local _v463, colour
if name and name ~= (_V9({})) and name ~= (_V9({129,222,190,18})) then
_v463, colour = name, (_V9({236,137,228,68,166,159,188}))
else
_v463, colour = (_V9({154,223,155,25,140,170,151})), (_V9({236,137,145,64,160,156,201}))
end
local text = (_V9({155,208,162,16,134,169,195,220,114,169,222,190,3,195,190,150,144,33,189,140,242})) .. colour .. (_V9({237,143})) .. _v463 .. (_V9({243,158,182,24,141,169,199}))
if targetPanelLabel.Text ~= text then
targetPanelLabel.Text = text
end
end
function UI:UpdateFPS(_v188)
if not fpsLabel or not _v190 or not _v190.Visible then
return
end
local text = string.format((_V9({243,215,191,25,151,253,154,147,34,160,195,237,85,192,229,205,207,11,141,244,242,73,198,185,197,211,40,160,223,164,73,195,187,137,143})), _v188 or 0)
if fpsLabel.Text ~= text then
fpsLabel.Text = text
end
end
function UI:SetWatermarkImage(_v228)
if not _v553 then
return
end
local _v148 = tostring(_v228 or (_V9({}))):match((_V9({234,213,251})))
_v553.Image = _v148 and ((_V9({189,211,168,22,144,174,156,136,39,171,139,255,88})) .. _v148) or (_V9({}))
end
function UI:SyncControls()
for _, _v184 in ipairs(_v486) do
_v184()
end
end
function UI:IsCapturingKey()
return _v104
end
function UI:Notify(text, _v163)
if not _v202 then
return
end
_v163 = _v163 or 3
local _v513 = _v320((_V9({155,212,168,3,175,188,155,153,34})), {
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
_v320((_V9({154,248,147,24,145,179,156,142})), { Parent = _v513, CornerRadius = UDim.new(0, 8) })
_v320((_V9({154,248,131,3,145,178,146,153})), { Parent = _v513, Color = _v6.accent, Thickness = 1, Transparency = 0.3 })
_v45:Create(_v513, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()
task.delay(_v163, function()
if _v513 and _v513.Parent then
local _v374 = _v45:Create(_v513, TweenInfo.new(0.3), {
BackgroundTransparency = 1,
TextTransparency = 1,
})
_v374.Completed:Once(function()
if _v513 then
_v513:Destroy()
end
end)
_v374:Play()
end
end)
end
function UI:Cleanup()
_v478()
_v455 = nil
_v467 = nil
_v388 = nil
table.clear(_v389)
for _, _v123 in ipairs(_v525) do
_v123:Disconnect()
end
table.clear(_v525)
table.clear(_v301)
table.clear(_v412)
table.clear(_v486)
_v55 = nil
_v104 = false
_v57 = nil
_v497, targetPanelLabel = nil, nil
_v496 = false
_v251 = nil
_v553 = nil
_v190, fpsLabel = nil, nil
_v558 = nil
if _v202 then
_v202:Destroy()
_v202 = nil
_v272 = nil
end
_v542 = false
end
return UI
end)()
Movement = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v46 = game:GetService((_V9({154,194,181,5,170,179,137,137,58,156,212,162,1,138,190,156})))
local _v50 = game:GetService((_V9({152,222,162,28,144,173,152,159,43})))
local _v26 = _v31.LocalPlayer
local UI = UI
local Movement = {}
local _v5 = 16
local _v23 = 50
local _v307
local _v305
local _v311 = 0
local function _v304()
local _v112 = _v26.Character
local root = _v112 and _v112:FindFirstChild((_V9({135,196,189,22,141,178,144,152,28,160,222,164,39,130,175,141})))
local humanoid = _v112 and _v112:FindFirstChildOfClass((_V9({135,196,189,22,141,178,144,152})))
if not (_v112 and root and humanoid and humanoid.Health > 0) then
return nil
end
return _v112, root, humanoid
end
local function _v306(_v95)
local _v269 = _v95.CFrame.LookVector
local _v180 = Vector3.new(_v269.X, 0, _v269.Z)
if _v180.Magnitude < 0.001 then
_v180 = Vector3.new(0, 0, -1)
else
_v180 = _v180.Unit
end
local right = _v95.CFrame.RightVector
right = Vector3.new(right.X, 0, right.Z).Unit
local _v300 = Vector3.zero
if _v46:IsKeyDown(Enum.KeyCode.W) then
_v300 = _v300 + _v180
end
if _v46:IsKeyDown(Enum.KeyCode.S) then
_v300 = _v300 - _v180
end
if _v46:IsKeyDown(Enum.KeyCode.D) then
_v300 = _v300 + right
end
if _v46:IsKeyDown(Enum.KeyCode.A) then
_v300 = _v300 - right
end
if _v46:IsKeyDown(Enum.KeyCode.Space) then
_v300 = _v300 + Vector3.yAxis
end
if _v46:IsKeyDown(Enum.KeyCode.LeftShift) then
_v300 = _v300 - Vector3.yAxis
end
if _v300.Magnitude > 0 then
return _v300.Unit
end
return nil
end
local _v29 = 0.1
local _v30 = 0.15
local function _v310()
return (os.clock() % (_v29 + _v30)) < _v29
end
function Movement:Update(_v162, _v120)
local _v112, root, humanoid = _v304()
if _v120.NoclipEnabled and _v112 then
local _v323 = _v112:GetDescendants()
for i = 1, #_v323 do
local part = _v323[i]
if part:IsA((_V9({141,208,163,18,179,188,139,136}))) then
part.CanCollide = false
end
end
end
if not root then
return
end
if _v120.FlyEnabled then
local _v95 = _v50.CurrentCamera
if _v95 then
local _v541 = Vector3.zero
if not UI:IsCapturingKey() then
local _v149 = _v306(_v95)
if _v149 then
local _v469 = _v120.FlySpeed or 50
if not _v310() then
_v469 = math.min(_v469, _v5)
end
_v541 = _v149 * _v469
end
end
root.AssemblyLinearVelocity = _v541
end
return
end
if _v120.SpeedEnabled then
local _v469 = _v120.Speed or _v5
local _v300 = humanoid.MoveDirection
if _v469 > _v5 and _v300.Magnitude > 0 and _v310() then
local _v541 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v300.X * _v469, _v541.Y, _v300.Z * _v469)
end
end
end
local function _v309(_v120)
if not _v120.InfJumpEnabled then
return
end
local _, root = _v304()
if root then
local _v541 = root.AssemblyLinearVelocity
root.AssemblyLinearVelocity = Vector3.new(_v541.X, _v23, _v541.Z)
end
end
local _v43 = 10
local _v42 = 0.05
function Movement.TeleportTo(_v392)
local _v144 = _v392 + Vector3.new(0, 3, 0)
_v311 = _v311 + 1
local _v515 = _v311
task.spawn(function()
while _v515 == _v311 do
local _, currentRoot = _v304()
if not currentRoot then
return
end
local _v342 = _v144 - currentRoot.CFrame.Position
if _v342.Magnitude <= _v43 then
currentRoot.CFrame = CFrame.new(_v144)
return
end
currentRoot.CFrame = currentRoot.CFrame + _v342.Unit * _v43
task.wait(_v42)
end
end)
end
local function _v308(_v120, _v232, _v195)
if _v195 or UI:IsCapturingKey() then
return
end
if not _v120.ClickTPEnabled then
return
end
if _v232.UserInputType ~= Enum.UserInputType.MouseButton1 then
return
end
if not _v46:IsKeyDown(_v120.ClickTPKey or Enum.KeyCode.LeftControl) then
return
end
local _v299 = _v26:GetMouse()
if _v299 and _v299.Hit then
Movement.TeleportTo(_v299.Hit.Position)
end
end
function Movement:Init(_v120)
if not _v307 then
_v307 = _v46.JumpRequest:Connect(function()
_v309(_v120)
end)
end
if not _v305 then
_v305 = _v46.InputBegan:Connect(function(_v232, _v195)
_v308(_v120, _v232, _v195)
end)
end
end
function Movement:Cleanup()
if _v307 then
_v307:Disconnect()
_v307 = nil
end
if _v305 then
_v305:Disconnect()
_v305 = nil
end
end
return Movement
end)()
_v13 = (function()
local _v31 = game:GetService((_V9({159,221,177,14,134,175,138})))
local _v38 = game:GetService((_V9({157,196,190,36,134,175,143,149,45,170})))
local _v46 = game:GetService((_V9({154,194,181,5,170,179,137,137,58,156,212,162,1,138,190,156})))
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
local _v47 = _v47
local UI = UI
local Movement = Movement
local _v49 = _v49
local _v10 = _v10
local _v13 = {}
_v13.Version = (_V9({254,159,224,89,211}))
_v13.Config = _v12
UI.TeleportTo = Movement.TeleportTo
_v49.Version = _v13.Version
local _v432 = false
local _v124 = {}
local _v63 = false
local _v32 = _v10.RandomName()
local _v200 = {}
local _v20 = 5
local function _v201(name, _v184, ...)
local _v343, res = pcall(_v184, ...)
if _v343 then
local _v473 = _v200[name]
if _v473 then
_v473.failures = 0
end
return true, res
end
local _v473 = _v200[name]
if not _v473 then
_v473 = { failures = 0, lastWarn = -math.huge }
_v200[name] = _v473
end
_v473.failures = _v473.failures + 1
local _v325 = os.clock()
if _v325 - _v473.lastWarn >= _v20 then
_v473.lastWarn = _v325
warn(string.format((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,107,188,145,182,22,138,177,156,152,110,231,201,245,19,202,231,217,217,61})), name, _v473.failures, tostring(res)))
end
return false, nil
end
function _v13.IsRunning()
return _v432
end
function _v13.SaveConfig(name)
return _v11.save(name, _v12)
end
function _v13.LoadConfig(name)
local _v343, res = _v11.load(name, _v12)
if _v343 then
pcall(function()
UI:SyncControls()
end)
end
return _v343, res
end
function _v13.ListConfigs()
return _v11.list()
end
function _v13.DeleteConfig(name)
return _v11.delete(name)
end
function _v13.ServerHop()
return _v47:ServerHop()
end
function _v13.Rejoin()
return _v47:Rejoin()
end
function _v13.SetWatermarkImage(_v228)
_v12.UI.WatermarkImageId = tostring(_v228 or (_V9({})))
UI:SetWatermarkImage(_v12.UI.WatermarkImageId)
return _v13
end
function _v13.SetWebhook(_v534)
return _v49.SetWebhook(_v534)
end
function _v13.HasWebhook()
return _v49.HasWebhook()
end
function _v13.SendWebhook(content, _v369)
return _v49.SendWebhook(content, _v369)
end
function _v13.SendLoadedEmbed(_v240)
return _v49.SendLoadedEmbed(_v240)
end
function _v13.Start()
if _v432 then
return _v13
end
_v432 = true
local _v343, err = pcall(function()
ESP:Init()
UI:Init(_v12, function()
_v13.Stop()
end)
Movement:Init(_v12.Movement)
SilentAim:Init(_v12)
table.insert(_v124, _v31.PlayerAdded:Connect(function(_v386)
_v201((_V9({159,221,177,14,134,175,184,152,42,170,213})), ESP.OnPlayerAdded, ESP, _v386)
end))
table.insert(_v124, _v31.PlayerRemoving:Connect(function(_v386)
_v201((_V9({159,221,177,14,134,175,171,153,35,160,199,185,25,132})), ESP.OnPlayerRemoving, ESP, _v386)
end))
table.insert(_v124, _v46.InputBegan:Connect(function(_v232, _v195)
if _v195 or UI:IsCapturingKey() then
return
end
_v201((_V9({132,212,169,21,138,179,157,143})), function()
local _v248 = _v232.KeyCode
if _v248 == _v12.UI.MenuKey then
UI:Toggle()
elseif _v248 == _v12.UI.UnloadKey then
_v13.Stop()
else
local _v514 = {
{ _v12.Camera, (_V9({138,223,177,21,143,184,157})), _v12.Camera.ToggleKey },
{ _v12.ESP, (_V9({138,223,177,21,143,184,157})), _v12.ESP.ToggleKey },
{ _v12.Camera, (_V9({137,254,134,52,138,175,154,144,43})), _v12.Camera.FOVCircleKey },
{ _v12.NoRecoil, (_V9({138,223,177,21,143,184,157})), _v12.NoRecoil.ToggleKey },
{ _v12.NoSpread, (_V9({138,223,177,21,143,184,157})), _v12.NoSpread.ToggleKey },
{ _v12.Triggerbot, (_V9({138,223,177,21,143,184,157})), _v12.Triggerbot.ToggleKey },
}
for _, t in ipairs(_v514) do
if _v248 == t[3] then
t[1][t[2]] = not t[1][t[2]]
UI:SyncControls()
break
end
end
end
end)
end))
local _v189, fpsFrames = 0, 0
table.insert(_v124, _v38.RenderStepped:Connect(function(_v162)
_v201((_V9({140,208,190,19,138,185,152,136,43,188})), _v9.Update, _v9, _v12.Camera, _v12.ESP)
_v201((_V9({138,226,128})), ESP.Update, ESP, _v12.ESP)
local _v345, target = true, nil
if not (UI.IsSpectating and UI.IsSpectating()) then
_v345, target = _v201((_V9({142,216,189,21,140,169})), _v8.Update, _v8, _v12.Camera, _v12.Debug)
end
if not _v345 then
target = nil
end
if _v12.UI.TargetDisplay then
_v201((_V9({155,208,162,16,134,169,217,152,39,188,193,188,22,154})), function()
local _v270 = _v8:GetLookTarget(_v12.ESP, _v12.Camera)
UI:SetCurrentTarget(_v270 and _v270.Name or nil)
end)
end
_v63 = _v12.Camera.Enabled and target ~= nil
_v201((_V9({129,222,131,7,145,184,152,152})), NoSpread.Update, NoSpread, _v12.NoSpread)
_v201((_V9({156,216,188,18,141,169,217,189,39,162})), SilentAim.Update, SilentAim, _v12)
_v201((_V9({155,195,185,16,132,184,139,158,33,187})), Triggerbot.Update, Triggerbot, _v12.Triggerbot, _v12.Camera)
_v201((_V9({130,222,166,18,142,184,151,136})), Movement.Update, Movement, _v162, _v12.Movement)
_v201((_V9({135,216,164,21,140,165})), _v22.Update, _v22, _v12.Hitbox, _v12.Camera)
_v201((_V9({139,195,177,0,138,179,158,220,11,156,225})), _v16.Update, _v16, _v12.Drawing, _v12.Camera)
_v201((_V9({153,216,163,2,130,177,138})), Visuals.Update, Visuals, _v12.Visuals)
_v189 = _v189 + _v162
fpsFrames = fpsFrames + 1
if _v189 >= 0.25 then
local _v188 = math.floor(fpsFrames / _v189 + 0.5)
_v189, fpsFrames = 0, 0
if _v12.UI.FPSCounter then
_v201((_V9({137,225,131,87,128,178,140,146,58,170,195})), UI.UpdateFPS, UI, _v188)
end
end
end))
pcall(function()
_v38:UnbindFromRenderStep(_v32)
end)
pcall(function()
_v38:BindToRenderStep(_v32, Enum.RenderPriority.Camera.Value + 1, function()
_v201((_V9({129,222,130,18,128,178,144,144})), NoRecoil.Update, NoRecoil, _v12.NoRecoil, _v63)
end)
end)
end)
if not _v343 then
warn((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,8,174,216,188,18,135,253,141,147,110,188,197,177,5,151,231})), err)
_v13.Stop()
return _v13
end
if not _v10.HideGlobal((_V9({153,208,190,30,151,164,190,153,32,170,195,177,27})), _v13) and getgenv then
getgenv().VanityGeneral = _v13
end
UI:Notify(string.format((_V9({153,208,190,30,151,164,212,187,43,161,212,162,22,143,253,149,147,47,171,212,180,87,195,63,121,94,110,239,225,162,18,144,174,217,217,61})), _v12.UI.MenuKey.Name), 4)
print(string.format((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,28,186,223,190,30,141,186,217,212,56,234,194,249})), _v13.Version))
print(string.format((_V9({130,212,190,2,217,253,220,143,110,239,205,240,87,160,188,148,153,60,174,139,240,82,144,253,217,128,110,239,228,190,27,140,188,157,198,110,234,194})),
_v12.UI.MenuKey.Name,
_v12.Camera.ToggleKey.Name,
_v12.UI.UnloadKey.Name))
if _v49.HasWebhook() then
task.spawn(function()
_v49.SendLoadedEmbed(false)
end)
end
return _v13
end
function _v13.Stop()
if not _v432 then
return _v13
end
_v432 = false
for _, _v123 in ipairs(_v124) do
pcall(function()
_v123:Disconnect()
end)
end
table.clear(_v124)
pcall(function()
_v38:UnbindFromRenderStep(_v32)
end)
_v63 = false
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
print((_V9({148,231,177,25,138,169,128,209,9,170,223,181,5,130,177,164,220,29,187,222,160,7,134,185})))
return _v13
end
function _v13.Toggle()
if _v432 then
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
local _v395 = getgenv().VanityGeneral
if _v395 and _v395 ~= _v13 and type(_v395.Stop) == (_V9({169,196,190,20,151,180,150,146})) then
pcall(_v395.Stop)
end
end
pcall(function()
_v13.Start()
end)
return _v13
end
