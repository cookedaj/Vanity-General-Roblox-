# Vanity-General Setup Guide

A full client-side combat/visuals/movement suite for Roblox.

There are two ways to run it:

- **Executor** (the intended path) — paste the loader, get the obfuscated
  release.
- **Roblox Studio** (for development) — install the modular source.

## Executor Setup

Paste the contents of `release/loader.lua` into your executor and run. It
fetches the latest release and starts it, trying every common HTTP API
(`game:HttpGet`, `syn.request`, `http.request`, `request`, `http_request`,
`fluxus`, `delta`) until one works.

Minimal form (if your executor has `game:HttpGet`):

```lua
local VanityGeneral = loadstring(game:HttpGet("https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua"))()
VanityGeneral.Start()
```

- Press **RightShift** to open the menu.
- Re-running is safe — the previously injected copy is stopped first.

### Testing a local dev build instead

1. `python tools/build.py` → `dist/VanityGeneral_INTEGRATED.lua`
2. Copy that file into your executor's workspace folder
3. Run `bootstrap.lua`, or inline:

   ```lua
   local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
   VanityGeneral.Start()
   ```

## Roblox Studio Setup (modular source)

`src/` is the single source of truth — 17 modules. The old
`MainController.lua`/`Loader.lua` entry points are gone; `Main.lua` is the
only entry.

1. Create a folder: `StarterPlayer > StarterPlayerScripts > VanityGeneral`

2. Copy these `src/` files as **ModuleScripts** in the folder
   (name each exactly after its file):

   `Configuration`, `ConfigManager`, `Utility`, `CameraDirector`, `ESP`,
   `DrawingESP`, `Visuals`, `Webhook`, `Triggerbot`, `SilentAim`, `Hitbox`,
   `NoRecoil`, `NoSpread`, `UI`, `Movement`, `Controller`

3. Copy `src/Main.lua` as a **LocalScript** in the same folder

4. Play → the suite starts automatically; press RightShift for the menu

Notes:

- `src/security/` is a standalone library and is **not** needed — nothing in
  `src/` requires it.
- Some features are executor-only and quietly no-op in Studio: Silent Aim
  (needs `hookmetamethod`), Drawing ESP (needs the `Drawing` library), and
  config profiles (needs file APIs). The webhook needs an HTTP `request`
  function.

## Controls

- **RightShift** — toggle menu
- **LeftAlt** — toggle aimbot
- **RightAlt** — toggle ESP
- **F1** — toggle FOV circle
- **F2** — toggle No Recoil
- **F3** — toggle No Spread
- **F4** — toggle Triggerbot
- **LeftControl + left click** — click teleport (when Click TP is enabled)
- **End** — unload / tear everything down

Every hotkey is rebindable from the UI; conflicting binds are rejected.

## Configuration

All defaults live in `src/Configuration.lua`, one section per system:
`Camera` (aimbot), `NoRecoil`, `NoSpread`, `Triggerbot`, `Movement`,
`SilentAim`, `Hitbox`, `Drawing`, `Visuals`, `Utility` (anti-AFK), `ESP`,
`UI`, `Webhook`. `Configuration.reset()` restores the tunables in `DEFAULTS`
(keybinds and the webhook URL survive a reset).

You normally don't edit this file at runtime — use the menu, or save a
**per-game profile** (Settings tab → Configs, or
`VanityGeneral.SaveConfig("name")`). Profiles are JSON keyed by PlaceId, so
each game gets its own settings.

## Troubleshooting

### Nothing happens after executing
- Check the console for `[Vanity-General]` warnings/errors
- If loading from a URL: the loader prints an assert when no HTTP function
  worked — try another executor or the local-file path

### Menu won't open
- Press RightShift (or your rebound MenuKey — check the keybind panel)
- In Studio, verify `Main` is a LocalScript and all 16 ModuleScripts are
  named exactly as above

### Silent Aim / Drawing ESP does nothing
- Both require executor-only APIs; without them they no-op (Silent Aim warns
  once). This is expected in Studio.

### Settings don't save
- Config profiles need `writefile`/`readfile`/`listfiles`; the Configs group
  in the Settings tab says when the executor has no file API

### Webhook never fires
- Set a URL first: `VanityGeneral.SetWebhook("https://discord.com/api/webhooks/...")`
  (or `Configuration.Webhook.Url = ...`)
- The executor must expose an HTTP POST function (`request`, `syn.request`, …)

---

**Created for educational purposes in Roblox development.**
