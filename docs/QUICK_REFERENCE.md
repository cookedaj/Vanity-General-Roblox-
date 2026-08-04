# Vanity-General — Quick Reference Card

## Loadstring

```lua
loadstring((function(u) if game.HttpGet then return game:HttpGet(u) end return request({Url=u,Method="GET"}).Body end)("https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua?t="..tick()))().Start()
```

Local-file form: `loadstring(readfile("VanityGeneral.lua"))().Start()`

## Keys

- **RightShift** — menu
- **LeftAlt** — camera tracking (rebindable in Settings)
- **End** — unload

## API (getgenv().VanityGeneral)

| Call | Purpose |
|---|---|
| `Start()` / `Stop()` / `Toggle()` | lifecycle (also lowercase aliases) |
| `IsRunning()` | state |
| `Config` | live settings table |
| `SaveConfig(name)` / `LoadConfig(name)` | per-game profiles (PlaceId-keyed) |
| `ListConfigs()` / `DeleteConfig(name)` | profile management |
| `ServerHop()` / `Rejoin()` | server controls |
| `SetWebhook(url)` / `SendWebhook(text)` | Discord notifications |
| `HasWebhook()` | is a webhook configured |

## Common config edits

```lua
local V = getgenv().VanityGeneral
V.Config.Camera.Smoothness = 0.5     -- lower = snappier lock
V.Config.Camera.FOV = 150            -- targeting cone radius (px)
V.Config.Camera.TeamCheck = false    -- FFA games
V.Config.Camera.TargetBots = true    -- include NPCs
V.Config.ESP.Color = Color3.fromRGB(255, 80, 80)
V.Config.Movement.FlySpeed = 100
```

## Feature map

- **Combat**: aimbot, prediction, humanize, sticky target, FOV circle,
  Target Bots, Team Check, triggerbot (random delay), silent aim*,
  hitbox expander, no-recoil, no-spread
- **Visual**: ESP, name/health/distance tags, box ESP*, tracers*,
  fullbright, no fog
- **Movement**: fly, noclip, speed, infinite jump, click-TP
- **Settings**: keybinds, profiles, anti-AFK, server hop, rejoin, unload

\* executor-dependent — no-ops safely if the API is missing.

## Notes

- Security library (StringObfuscation etc.) is NOT bundled anymore — see
  `docs/StringObfuscation_*.md` for the standalone version in `src/security/`.
- Release is obfuscated; develop in `src/`, rebuild with `tools/build.py`
  then `tools/obfuscate.py`. Full guide: `docs/LOADSTRING_GUIDE.md`.
