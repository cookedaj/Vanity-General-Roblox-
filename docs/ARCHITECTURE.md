# Vanity-General - Architecture

This document describes the current design: the modular source in `src/` (the
single source of truth), the Controller/Main entry model, the bundler that
generates `dist/`, and the release pipeline that produces `release/`.

## Big Picture

```
src/ (17 modules, edit these)
   │
   │  python tools/build.py
   ▼
dist/VanityGeneral_INTEGRATED.lua   (GENERATED — do not edit)
   │
   │  python tools/obfuscate.py dist/VanityGeneral_INTEGRATED.lua release/VanityGeneral.lua
   ▼
release/VanityGeneral.lua           (obfuscated public release)
   ▲
   │  fetched over HTTP at runtime
release/loader.lua                  (cross-executor loadstring; what users paste)
```

The security modules in `src/security/` (StringObfuscation, DebuggerDetection,
ProtectedSecrets) are a **standalone library** — they are not required by any
`src/` module and are not in the bundle. String protection happens at release
time in `tools/obfuscate.py` instead.

## Module Graph

Requires are top-of-file `local X = require(script.Y)` (this is also the
bundler's contract). Arrows mean "requires":

```
Configuration    (leaf — settings, DEFAULTS, reset)
ConfigManager    (leaf — per-game JSON profiles)
Utility          (leaf — anti-AFK, server hop/rejoin, GUI parent)
NoRecoil         (leaf — recoil suppression)
Triggerbot       (leaf — auto-fire)
DrawingESP       (leaf — executor Drawing boxes/tracers)
Visuals          (leaf — fullbright/no fog)

Webhook          → Configuration
ESP              → Configuration, Utility
CameraDirector   → Utility
Hitbox           → CameraDirector
SilentAim        → CameraDirector
NoSpread         → NoRecoil
UI               → ConfigManager, Utility
Movement         → UI
Controller       → Configuration, ConfigManager, CameraDirector, Hitbox,
                   SilentAim, NoRecoil, NoSpread, Triggerbot, ESP,
                   DrawingESP, Visuals, Utility, UI, Movement, Webhook
Main             → Controller
```

`Main` is the entry chunk: it stops any previously injected copy (found via
`getgenv().VanityGeneral`) and calls `Controller.Start()`, then returns the
Controller table so `loadstring(...)()` yields the public API.

## Module Responsibilities

### Configuration
- Single source of truth for every setting (`Camera`, `ESP`, `NoRecoil`,
  `NoSpread`, `Triggerbot`, `Movement`, `SilentAim`, `Hitbox`, `Drawing`,
  `Visuals`, `Utility`, `UI`, `Webhook`)
- Owns `DEFAULTS` and `reset()`; keybinds, option lists, and the webhook URL
  are deliberately excluded from reset
- All sections are plain data — no logic

### ConfigManager
- Saves/loads Configuration sections to the executor filesystem as JSON
- Profiles are **per-game**: `VanityGeneral/profile_<PlaceId>_<name>.json`,
  with a read-only legacy-path fallback for pre-per-game saves
- Color3/EnumItem values are tagged (`__t`) and rebuilt on load; unknown enum
  names are skipped so a bad profile can't wipe a keybind
- Degrades gracefully on executors without file APIs (`isSupported()`)

### CameraDirector (aimbot)
- `FindBestTarget(config)`: alive check, Team Check, Target Bots (NPCs),
  wall check, world-range filter, FOV cone filter, sticky-target retention,
  hitbox region resolution (`Random (Weighted)` chance weights or a fixed
  region), velocity prediction lead
- `PointCamera(position, smoothness)`: CFrame lerp toward the target
- `Update(config, debug)`: resolves the target each frame and steers the
  camera; applies humanize jitter; returns the current target
- `GetLookTarget(espConfig, cameraConfig)`: who you're *looking* at (feeds the
  target display, independent of aimbot lock)
- Owns the FOV circle drawing; `Cleanup()` removes it

### ESP / DrawingESP / Visuals
- **ESP**: Highlight outlines/fill, 2D boxes, name/health/distance billboard
  tags; player join/leave/respawn handling; NPC support
- **DrawingESP**: executor `Drawing` boxes and tracers; no-op where the
  Drawing library is missing
- **Visuals**: fullbright / no-fog lighting watches; restores original
  Lighting properties on cleanup

### Combat helpers
- **Triggerbot**: fires when the crosshair sits on a valid target for a random
  delay sampled between `MinDelay`/`MaxDelay`; vischeck + max-distance options
- **SilentAim**: hooks `game`'s metatable (`__namecall`, `__index`) via
  `hookmetamethod` to rewrite position-like args onto the aimbot's target.
  Fully guarded: no-ops without `hookmetamethod`/`getnamecallmethod`, and
  only rewrites calls from game scripts (`checkcaller`)
- **Hitbox**: client-side inflation of enemy root parts (size/transparency),
  driven by the aimbot's candidate set; restores originals on cleanup
- **NoRecoil**: locks the camera against recoil climb; runs on a
  `BindToRenderStep` at `Camera + 1` priority so the correction lands *after*
  the game's own camera update; stands down while the aimbot owns the camera
- **NoSpread**: wraps `math.random` to pull spread rolls toward centre while
  the fire button is held; restores the original on cleanup

### Movement
- Fly, noclip, speed (only the surplus over stock WalkSpeed), infinite jump,
  click-TP (modifier key + left click)
- CFrame-driven half runs inside the controller's RenderStepped loop;
  event-driven halves (jump, click) run on their own connections from
  `Movement:Init`

### Webhook
- Sends Discord messages/embeds through whatever HTTP-POST function the
  executor exposes (`syn.request`, `http.request`, `http_request`, `request`,
  `fluxus.request`)
- URL is plain config: `Configuration.Webhook.Url` (set directly or via
  `Controller.SetWebhook`); `SendLoadedEmbed` fires the "loaded" ping

### UI
- Four tabs: **Combat**, **Visual**, **Movement**, **Settings**
- Overlays: keybind panel, target display, FPS counter, watermark
- Keybind-capture system (`UI:IsCapturingKey()`): an armed keybind box
  consumes the next press as a rebind; conflicts with existing binds are
  rejected (`keyConflict`)
- `SyncControls()` re-reads config into every control (after profile load,
  reset, or hotkey toggle); window visibility is written back to
  `Configuration.UI.Visible`
- Settings tab: interface options, config profile save/load/delete, Anti-AFK
  toggle, Server Hop / Rejoin buttons, Unload button

### Controller (orchestrator + public API)
- `Start()`: inits ESP/UI/Movement/SilentAim/Utility, connects player and
  input handlers, starts the single RenderStepped loop, binds NoRecoil after
  the camera, exports itself to `getgenv().VanityGeneral`, fires the webhook
  "loaded" embed if configured
- **Single RenderStepped loop** drives ESP, aimbot, target display, NoSpread,
  Triggerbot, Movement, Hitbox, DrawingESP, Visuals, and the FPS counter
- **Crash guard**: every subsystem call goes through `guarded(name, fn, ...)`,
  which swallows per-frame errors and warns at most once per 5s per site — a
  destroyed part mid-respawn can't kill the loop or spam the console
- **Data-driven keybinds**: one table maps toggle keys to config flags
  (camera, ESP, FOV circle, NoRecoil, NoSpread, Triggerbot), plus MenuKey →
  `UI:Toggle()` and UnloadKey → `Stop()`
- `Stop()`: disconnects everything, unbinds NoRecoil, and calls every
  module's Cleanup (each restores what it touched — Lighting, hitboxes,
  `math.random`, jump/click listeners)
- API: `Version`, `Config`, `IsRunning`, `Start/Stop/Toggle` (+ lowercase
  aliases), `SaveConfig/LoadConfig/ListConfigs/DeleteConfig`,
  `ServerHop/Rejoin`, `SetWebhook/HasWebhook/SendWebhook/SendLoadedEmbed`,
  `SetWatermarkImage`

## The Bundler (tools/build.py)

Generates `dist/VanityGeneral_INTEGRATED.lua` from `src/`. Rules:

- `MODULES` (top of build.py) is the bundle order = dependency order; every
  module must be listed
- `local X = require(script.Y)` becomes `local X = Y` against hoisted module
  locals; requiring a module not in `MODULES` is a build error
- Each module body keeps its `return <Table>` and is wrapped as
  `Name = (function() ... end)()`; `Main` is wrapped in `do ... end` and its
  `return Controller` survives, so the whole bundle evaluates to the API table
- Module locals are hoisted to bundle top-level; per-module function wrapping
  keeps the bundle under Luau's 200-local register limit
- Output carries a GENERATED do-not-edit header

## The Obfuscator (tools/obfuscate.py)

`python tools/obfuscate.py <in.lua> <out.lua>` (requires `luaparser`):

1. Strips all comments (quote-aware)
2. Replaces every string literal with `(_V9({...}))` — XOR-encrypted bytes
   decoded at runtime (hides webhook URLs, UI text, service/key names)
3. Flattens indentation and blank lines
4. **Self-verifies**: re-parses the output and decrypts every emitted string
   table against the original; any mismatch aborts before writing
5. Refuses Luau-only syntax it can't parse (e.g. `continue`) rather than
   emitting a broken file

Honest limitation (documented in the script): the decoder ships in the file,
so this stops casual copying and string-grepping, not determined reversers.

## Release Pipeline

```
edit src/  →  python tools/build.py  →  test dist build (bootstrap.lua)
           →  python tools/obfuscate.py dist/VanityGeneral_INTEGRATED.lua release/VanityGeneral.lua
           →  push release/VanityGeneral.lua to the public repo
```

`release/loader.lua` fetches the release with a `?t=tick()` cache-buster,
trying `game:HttpGet`, `game:HttpGetAsync`, then the `request()` family
(`syn`, `http`, plain, `http_request`, `fluxus`, `delta`) until one returns
the script, then `loadstring(source)()` and `Start()`.

## Performance Characteristics

- One RenderStepped connection for all per-frame systems (plus the
  post-camera NoRecoil bind)
- Per-subsystem error guarding with throttled warnings
- No periodic work when features are off (each Update early-outs on its
  Enabled flag; target display resolves only while visible)
- No network traffic except the optional webhook

## Extension Points

- **New setting** → add to `Configuration` (+ `DEFAULTS` if resettable)
- **New toggle hotkey** → one row in the keybind table in `Controller.Start()`
- **New per-frame system** → new module + one `guarded(...)` line in the
  RenderStepped loop + Cleanup call in `Stop()` + entry in `MODULES` in
  tools/build.py
- **New UI control** → control factory in the relevant `build*Tab` in UI.lua
