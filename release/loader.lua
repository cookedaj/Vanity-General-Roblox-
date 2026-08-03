-- Vanity-General loader
-- Local test (VanityGeneral.lua in your executor's workspace folder):
--   local VanityGeneral = loadstring(readfile("VanityGeneral.lua"))()
--   VanityGeneral.Start()
--
-- Hosted — tries every known executor HTTP API until one works:
local URL = "https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua?t=" .. tick()

local function bodyOf(res)
	return type(res) == "table" and (res.Body or res.body) or nil
end

local attempts = {
	function() return game:HttpGet(URL) end,
	function() return game:HttpGetAsync(URL) end,
	function() return bodyOf(syn.request({ Url = URL, Method = "GET" })) end,
	function() return bodyOf(http.request({ Url = URL, Method = "GET" })) end,
	function() return bodyOf(request({ Url = URL, Method = "GET" })) end,
	function() return bodyOf(http_request({ Url = URL, Method = "GET" })) end,
	function() return bodyOf(fluxus.request({ Url = URL, Method = "GET" })) end,
	function() return bodyOf((delta and delta.request)({ Url = URL, Method = "GET" })) end,
}

local source
for _, attempt in ipairs(attempts) do
	local ok, res = pcall(attempt)
	if ok and type(res) == "string" and #res > 1000 then
		source = res
		break
	end
end

assert(source, "[Vanity-General] No working HTTP function found in this executor")

local VanityGeneral = loadstring(source)()
VanityGeneral.Start()
