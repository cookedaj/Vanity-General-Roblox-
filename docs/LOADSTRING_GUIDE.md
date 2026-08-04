# Vanity-General — Loadstring Guide

The release build is served from the public `vanity-release` repo and works on
any executor with an HTTP function.

## The loadstring

```lua
loadstring((function(u) if game.HttpGet then return game:HttpGet(u) end return request({Url=u,Method="GET"}).Body end)("https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua?t="..tick()))().Start()
```

The `?t=` cache-buster makes every inject fetch the latest release.

If your executor has no HTTP function at all, put `VanityGeneral.lua` in its
workspace folder and use the local form:

```lua
loadstring(readfile("VanityGeneral.lua"))().Start()
```

## Keys

| Key | Action |
|---|---|
| RightShift | Open/close the menu |
| LeftAlt | Toggle camera tracking (rebindable) |
| End | Unload everything |

## Runtime API

The loadstring returns the controller (also at `getgenv().VanityGeneral`):

```lua
local VanityGeneral = getgenv().VanityGeneral

VanityGeneral.Start()          -- start (idempotent; re-inject stops the old copy)
VanityGeneral.Stop()           -- full teardown
VanityGeneral.Toggle()         -- start/stop
VanityGeneral.IsRunning()

VanityGeneral.Config           -- live config table (edit fields directly)

VanityGeneral.SaveConfig(name) -- per-game profiles (keyed by PlaceId)
VanityGeneral.LoadConfig(name)
VanityGeneral.ListConfigs()
VanityGeneral.DeleteConfig(name)

VanityGeneral.ServerHop()      -- join a different server
VanityGeneral.Rejoin()         -- rejoin this server

VanityGeneral.SetWebhook(url)  -- Discord webhook for the loaded notification
VanityGeneral.HasWebhook()
VanityGeneral.SendWebhook(content, opts)
```

## Features by tab

- **Combat** — aimbot (smoothness, FOV, target part), Target Bots (NPCs),
  Team Check, triggerbot (randomized min/max delay), silent aim (curves shots
  over obstacles; needs `hookmetamethod`), hitbox expander,
  no-recoil / no-spread.
- **Visual** — ESP highlights, name/health/distance tags (players and NPCs),
  box ESP + tracers (needs the `Drawing` library), fullbright, no fog.
- **Movement** — fly, noclip, speed, infinite jump, click-TP (hold the
  modifier key + left-click).
- **Settings** — keybinds, per-game config profiles, anti-AFK (on by
  default), server hop, rejoin, unload.

Executor-only features (silent aim, Drawing ESP, config save/load) no-op
safely when the executor lacks the API.

## FAQ

**Q: `:1: attempt to call a nil value` when running the loadstring?**
A: The fetch failed or returned an error page. Check the URL in a browser;
try the local-file form above.

**Q: A toggle does nothing?**
A: Check the console — every subsystem runs through a guarded wrapper that
prints the failing feature's name. Report that line.

**Q: Does it work in every game?**
A: The feature set is game-agnostic. Games with server-side validation will
defeat specific features (silent aim, speed, hitbox) — that's inherent.

## Notes

- The StringObfuscation / DebuggerDetection library is **not** part of the
  build anymore. It lives in `src/security/` as a standalone library — see
  `docs/StringObfuscation_*.md` if you want to use it in your own scripts.
- The release file is obfuscated (encrypted strings, mangled names) and then
  fully encrypted into a self-decrypting stub (`tools/encrypt.py`). Edit
  `src/` and rebuild — never edit the release directly.
