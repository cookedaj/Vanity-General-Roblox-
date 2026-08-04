# Vanity-General

A full client-side combat/visuals/movement suite for Roblox, built as 17 focused
modules and shipped as a single obfuscated executor script.

## 🎯 What This Is

**Vanity-General** is a modular Roblox framework with four UI tabs:

- **Combat** → Aimbot, triggerbot, silent aim, hitbox expander, no-recoil, no-spread
- **Visual** → Player/NPC ESP (highlights, boxes, name/health/distance tags), Drawing boxes & tracers, fullbright, no fog
- **Movement** → Fly, noclip, speed, infinite jump, click-teleport
- **Settings** → Rebindable keys, per-game config profiles, anti-AFK, server hop / rejoin, unload

`src/` is the single source of truth. The executor builds are **generated** —
never edited directly.

---

## ✨ Features

### Combat
- 🎯 **Aimbot** — smooth camera lock with adjustable smoothness, velocity
  prediction (0–1 lead), humanize jitter, FOV radius + on-screen FOV circle
  (F1), sticky target, hitbox mode (`Random (Weighted)` with per-region
  chance weights, or Head/Torso/Arms/Legs), wall check, Team Check,
  Target Bots (NPCs), world-range limit in studs
- 🔫 **Triggerbot** (F4) — auto-fires when the crosshair sits on a target,
  with a humanized random delay sampled between Min/MaxDelay, max-distance
  and vischeck options
- 🤫 **Silent Aim** — redirects shots onto the aimbot's target without moving
  the camera; executor-only (`hookmetamethod`/`getnamecallmethod`, guarded —
  no-ops cleanly where unsupported)
- 📦 **Hitbox Expander** — inflates enemy root parts (size/transparency)
- 🧲 **No Recoil** (F2) — post-camera render bind fully undoes recoil climb;
  strength, require-mouse-down, and allow-aim options
- 🎲 **No Spread** (F3) — pulls spread rolls toward centre while firing

### Visual
- 🟪 **ESP** (RightAlt) — Highlight outlines/fill, 2D boxes, name tags,
  health bars, distance tags — including NPCs — with color/opacity/range
  controls
- 📐 **Drawing ESP** — executor `Drawing` boxes and tracers (no-op without
  the Drawing library)
- 💡 **Fullbright & No Fog** — lighting watches that restore on unload

### Movement
- 🕊️ **Fly** (speed-adjustable)
- 👻 **Noclip**
- 🏃 **Speed** boost (only the surplus over stock 16 WalkSpeed)
- ♾️ **Infinite Jump**
- ⚡ **Click TP** — hold LeftControl + left-click to teleport

### Settings / QoL
- ⌨️ Every hotkey rebindable from the UI, with conflict detection
- 💾 **Per-game config profiles** — saved as JSON per PlaceId, so one executor
  folder holds settings for every game (`SaveConfig`/`LoadConfig`/…)
- 😴 **Anti-AFK** — on by default
- 🌐 **Server Hop / Rejoin** buttons
- 🖥️ Keybind panel, target display, FPS counter, watermark (custom image id)
- 🔔 Discord **webhook** "loaded" embed (plain `Configuration.Webhook.Url`)

---

## 📁 Project Structure

```
Vanity-General/
├── bootstrap.lua                  (Local test entry; loads the dist build via readfile)
├── README.md                      (This file)
│
├── src/                           (SOURCE OF TRUTH — 17 modules, edit these)
│   ├── Configuration.lua          (All settings + defaults + reset)
│   ├── ConfigManager.lua          (Per-game JSON config profiles, keyed by PlaceId)
│   ├── Utility.lua                (Anti-AFK, server hop / rejoin, GUI parent helper)
│   ├── CameraDirector.lua         (Aimbot targeting + camera steering)
│   ├── ESP.lua                    (Highlight/box/tag ESP, players + NPCs)
│   ├── DrawingESP.lua             (Executor Drawing boxes/tracers)
│   ├── Visuals.lua                (Fullbright / no fog)
│   ├── Webhook.lua                (Discord webhook sender)
│   ├── Triggerbot.lua             (Auto-fire on crosshair target)
│   ├── SilentAim.lua              (hookmetamethod shot redirection)
│   ├── Hitbox.lua                 (Root-part inflation)
│   ├── NoRecoil.lua               (Recoil suppression)
│   ├── NoSpread.lua               (Spread suppression)
│   ├── UI.lua                     (Four-tab menu, keybind capture, overlays)
│   ├── Movement.lua               (Fly / noclip / speed / inf jump / click TP)
│   ├── Controller.lua             (Orchestrator + public API)
│   ├── Main.lua                   (Entry point: safe-restart, then Controller.Start())
│   └── security/                  (Standalone library — NOT in the bundle)
│       ├── StringObfuscation.lua
│       ├── DebuggerDetection.lua
│       └── ProtectedSecrets.lua
│
├── tools/
│   ├── build.py                   (Bundler: src/ → dist/VanityGeneral_INTEGRATED.lua)
│   └── obfuscate.py               (Obfuscator: dist → release/VanityGeneral.lua)
│
├── dist/
│   └── VanityGeneral_INTEGRATED.lua   (GENERATED — do not edit; ~183KB)
│
├── release/
│   ├── VanityGeneral.lua          (Obfuscated public release — GENERATED)
│   └── loader.lua                 (Cross-executor loadstring; paste this)
│
├── tests/                         (StringObfuscation test suite and demo)
├── docs/                          (All guides — see Documentation below)
│   └── history/                   (Archived changelogs)
├── reference/cpp/                 (C++ reference implementations)
└── archive/                       (Stale older monoliths)
```

---

## 🚀 Quick Start

### Executor (recommended)

Paste the contents of `release/loader.lua` into your executor. It fetches the
obfuscated release and starts it, trying every common HTTP API until one works:

```lua
local VanityGeneral = loadstring(game:HttpGet("https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua"))()
VanityGeneral.Start()
```

(The snippet above is the minimal form; `release/loader.lua` adds
`request()`-family fallbacks and a cache-buster.)

- Press **RightShift** to open the menu.
- Re-running is safe — the previous copy is stopped first.

### Local testing of a dev build

1. `python tools/build.py` → writes `dist/VanityGeneral_INTEGRATED.lua`
2. Put that file in your executor's workspace folder
3. Run `bootstrap.lua` (or `loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()`)

### Roblox Studio (modular)

1. Create folder: `StarterPlayer > StarterPlayerScripts > VanityGeneral`
2. Copy all of `src/` (except `Main.lua` and `security/`) as **ModuleScripts**
3. Copy `src/Main.lua` as a **LocalScript** in the same folder
4. Play → RightShift for the menu

See docs/SETUP.md for details.

---

## 🎮 Controls

| Control | Action |
|---------|--------|
| **RightShift** | Toggle menu |
| **LeftAlt** | Toggle aimbot |
| **RightAlt** | Toggle ESP |
| **F1** | Toggle FOV circle |
| **F2** | Toggle No Recoil |
| **F3** | Toggle No Spread |
| **F4** | Toggle Triggerbot |
| **LeftControl + LMB** | Click teleport (when enabled) |
| **End** | Unload / tear everything down |

All hotkeys are rebindable from the UI (per-tab keybind rows + the keybind
panel); conflicts are rejected.

---

## 💻 Public API

The entry chunk returns the Controller (also exported as
`getgenv().VanityGeneral`):

```lua
local VanityGeneral = loadstring(game:HttpGet("https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua"))()

VanityGeneral.Start()          -- start (also .start())
VanityGeneral.Stop()           -- full teardown (also .stop())
VanityGeneral.Toggle()         -- start/stop (also .toggle())
VanityGeneral.IsRunning()      -- true/false
VanityGeneral.Version          -- version string
VanityGeneral.Config           -- the live Configuration table

-- Per-game config profiles (keyed by PlaceId)
VanityGeneral.SaveConfig("legit")
VanityGeneral.LoadConfig("legit")
VanityGeneral.ListConfigs()
VanityGeneral.DeleteConfig("legit")

-- Teleport helpers
VanityGeneral.ServerHop()
VanityGeneral.Rejoin()

-- Webhook + watermark
VanityGeneral.SetWebhook("https://discord.com/api/webhooks/...")
VanityGeneral.HasWebhook()
VanityGeneral.SendWebhook("hello")
VanityGeneral.SendLoadedEmbed(false)
VanityGeneral.SetWatermarkImage("139845693858856")
```

---

## 🔧 Development Workflow

`dist/` and `release/` are **generated artifacts** — never edit them.

1. **Edit** modules in `src/`
2. **Build**: `python tools/build.py` → `dist/VanityGeneral_INTEGRATED.lua`
   (bundle order/dependency list lives in `MODULES` at the top of build.py)
3. **Test** locally via `bootstrap.lua` (or in Studio with the modular layout)
4. **Obfuscate**: `python tools/obfuscate.py dist/VanityGeneral_INTEGRATED.lua release/VanityGeneral.lua`
   (strips comments, XOR-encrypts every string literal, verifies the round-trip
   before writing; requires `pip install luaparser`)
5. **Release**: push `release/VanityGeneral.lua` to the public repo the loader
   fetches from (`release/loader.lua` points at it)

Module contract the bundler relies on: each module ends with
`return <Table>`, and cross-module references are top-of-file
`local X = require(script.Y)`.

---

## 📖 Documentation

| Document | Purpose |
|----------|---------|
| **docs/QUICK_START.md** | Get running + common customizations |
| **docs/SETUP.md** | Detailed Studio & executor installation |
| **docs/ARCHITECTURE.md** | Module graph, bundler, release pipeline |
| **docs/LOADSTRING_GUIDE.md** | Executor/loadstring usage and API |
| **docs/QUICK_REFERENCE.md** | Copy-paste reference card |
| **docs/DebuggerDetection_GUIDE.md** | Standalone debugger-detection library |
| **docs/StringObfuscation_*.md** | Standalone string-obfuscation library |
| **docs/history/** | Archived changelogs |

---

## ❓ FAQ

**Q: Will this get me banned?**
A: This is an educational tool for understanding Roblox client-side systems. Use responsibly in appropriate contexts.

**Q: Why is Silent Aim not doing anything?**
A: It needs an executor with `hookmetamethod`/`getnamecallmethod`. Without them it no-ops (a warning is printed once).

**Q: Where did StringObfuscation/DebuggerDetection go?**
A: They're still in `src/security/` as a standalone library (docs in
`docs/StringObfuscation_*.md`), but they're no longer bundled — string
protection now happens at release time via `tools/obfuscate.py`.

**Q: Do my settings save?**
A: Yes — config profiles are per-game (keyed by PlaceId) JSON files in the
executor's `VanityGeneral/` folder. Save/load from the Settings tab or the API.

**Q: Is it multiplayer safe?**
A: Fully client-side, no network calls except the optional Discord webhook. Zero impact on other players.

**Q: How do I troubleshoot?**
A: Check the console for `[Vanity-General]` warnings. See docs/SETUP.md.

---

## 📝 License

Created for educational purposes in Roblox development.

---

**Ready to start?** See docs/QUICK_START.md for immediate setup instructions! 🚀
