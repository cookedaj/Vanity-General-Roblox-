-- Vanity-General loader
-- Local test (VanityGeneral.lua in your executor's workspace folder):
--   local VanityGeneral = loadstring(readfile("VanityGeneral.lua"))()
--   VanityGeneral.Start()
--
-- Hosted — works across executors with different HTTP APIs:
local URL = "https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua?t=" .. tick()

local source
if game.HttpGet then
	source = game:HttpGet(URL)
else
	local req = (syn and syn.request) or (http and http.request) or request or (fluxus and fluxus.request)
	assert(req, "[Vanity-General] No HTTP function available in this executor")
	local res = req({ Url = URL, Method = "GET" })
	source = res.Body or res.body
end

local VanityGeneral = loadstring(source)()
VanityGeneral.Start()
