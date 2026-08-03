--==============================================================================
-- SECURE WEBHOOK
-- On load the script pings a Discord webhook (player name / game / etc).
--
-- SECURITY NOTE: the old single-file build stored the URL as an encrypted
-- cipher and gated reveals behind StringObfuscation/DebuggerDetection. Those
-- modules left the bundle — obfuscation now happens at release build time —
-- so the URL lives in plain config: Configuration.Webhook.Url (set it directly,
-- or via Webhook.SetWebhook at runtime).
--==============================================================================

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Configuration = require(script.Configuration)

local Webhook = {}
Webhook.Version = "0" -- stamped by the controller on load (used in the embed)

-- Finds whatever HTTP-POST function this executor exposes.
local function resolveHttpRequest()
	local candidates = {
		(syn and syn.request),
		(http and http.request),
		http_request,
		request,
		(fluxus and fluxus.request),
	}
	for _, fn in ipairs(candidates) do
		if type(fn) == "function" then
			return fn
		end
	end
	return nil
end

-- The configured URL, or nil when none is set.
local function resolveWebhookUrl()
	local url = Configuration.Webhook.Url
	if type(url) == "string" and url ~= "" then
		return url
	end
	return nil
end

-- Store/replace the webhook URL at runtime.
function Webhook.SetWebhook(url)
	Configuration.Webhook.Url = tostring(url or "")
	return true
end

-- True if a URL is configured.
function Webhook.HasWebhook()
	return resolveWebhookUrl() ~= nil
end

-- Sends a Discord message. Returns false (never throws) when unconfigured or
-- the executor has no HTTP function.
function Webhook.SendWebhook(content, opts)
	opts = opts or {}

	local url = resolveWebhookUrl()
	if not url then
		return false, "no_webhook"
	end

	local req = resolveHttpRequest()
	if not req then
		warn("[Vanity-General] No HTTP request function available in this executor")
		return false, "no_http"
	end

	local payload = {
		username = opts.username or "Vanity-General",
		avatar_url = opts.avatar_url,
		content = content,
		embeds = opts.embeds,
	}

	local ok, err = pcall(function()
		local body = game:GetService("HttpService"):JSONEncode(payload)
		return req({
			Url = url,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = body,
		})
	end)
	url = nil -- drop the reference promptly

	if not ok then
		warn("[Vanity-General] Webhook send failed:", err)
		return false, err
	end
	return true
end

-- The nice "loaded" embed. Kept here so both Start and manual calls can reuse it.
function Webhook.SendLoadedEmbed(isDebugged)
	local placeName = "?"
	pcall(function()
		placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	end)

	return Webhook.SendWebhook(nil, {
		embeds = {
			{
				title = "Vanity.dev General loaded",
				color = 8666558, -- accent purple (0x843EBE)
				fields = {
					{ name = "Player", value = "`" .. (LocalPlayer and LocalPlayer.Name or "?") .. "`", inline = true },
					{ name = "Version", value = "`v" .. tostring(Webhook.Version) .. "`", inline = true },
					{ name = "Game", value = placeName, inline = false },
					{ name = "PlaceId", value = "`" .. tostring(game.PlaceId) .. "`", inline = true },
					{ name = "Debugged", value = "`" .. tostring(isDebugged) .. "`", inline = true },
				},
				footer = { text = os.date("%Y-%m-%d %H:%M:%S") },
			},
		},
	})
end

return Webhook
