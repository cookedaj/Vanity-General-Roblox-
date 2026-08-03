-- Vanity-General loader
-- Local test (VanityGeneral.lua in your executor's workspace folder):
--   local VanityGeneral = loadstring(readfile("VanityGeneral.lua"))()
--   VanityGeneral.Start()
--
-- Hosted (after the public repo is up):
local VanityGeneral = loadstring(game:HttpGet("https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua?t=" .. tick()))()
VanityGeneral.Start()
