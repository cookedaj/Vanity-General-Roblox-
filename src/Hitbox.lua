--==============================================================================
-- HITBOX EXPANDER
-- Inflates enemy HumanoidRootParts so they're easier to hit. These are
-- CLIENT-SIDE writes on other players' characters: whether hits actually
-- register depends on the game (it works where the server trusts client
-- physics). Originals are stored per character and restored on disable,
-- cleanup, or when the character leaves the candidate set.
--==============================================================================

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Candidates = require(script.Candidates)

local HitboxExpander = {}
local hb_originals = {} -- [character] = { root, size, transparency, canCollide }

local function hb_restore(character)
	local original = hb_originals[character]
	if not original then
		return
	end
	hb_originals[character] = nil
	local root = original.root
	if root and root.Parent then
		root.Size = original.size
		root.Transparency = original.transparency
		root.CanCollide = original.canCollide
	end
end

local function hb_restoreAll()
	for character in pairs(hb_originals) do
		hb_restore(character)
	end
end

local function hb_apply(cand, config, seen)
	-- The pool guarantees a living humanoid; only the HRP presence gate remains.
	local root = cand.HRP
	if not root then
		return
	end

	local character = cand.Character
	seen[character] = true
	if not hb_originals[character] then
		hb_originals[character] = {
			root = root,
			size = root.Size,
			transparency = root.Transparency,
			canCollide = root.CanCollide,
		}
	end

	local size = config.Size or 5
	root.Size = Vector3.new(size, size, size)
	root.Transparency = config.Transparency or 0.5
	root.CanCollide = false
end

-- The candidate set mirrors the aimbot's: teammates skipped while Team Check is
-- on, NPCs included only while Target Bots is on (they're in the pool then).
function HitboxExpander:Update(config, cameraConfig)
	if not config.Enabled then
		hb_restoreAll()
		return
	end

	local seen = {}
	for _, cand in ipairs(Candidates:Get()) do
		local player = cand.Player
		if not (cameraConfig.TeamCheck and player and player.Team ~= nil and player.Team == LocalPlayer.Team) then
			hb_apply(cand, config, seen)
		end
	end

	-- Restore anyone who left the candidate set (died, left, switched teams).
	for character in pairs(hb_originals) do
		if not seen[character] then
			hb_restore(character)
		end
	end
end

function HitboxExpander:Cleanup()
	hb_restoreAll()
end

return HitboxExpander
