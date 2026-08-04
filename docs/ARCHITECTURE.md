# Vanity-General - Architecture

This document describes the current design: the modular source in `src/` (the
single source of truth), the Controller/Main entry model, the bundler that
generates `dist/`, and the release pipeline that produces `release/`.

## Big Picture

```
src/ (18 modules, edit these)
   │
   │  python tools/build.py
   ▼
dist/VanityGeneral_INTEGRATED.lua   (GENERATED — do not edit)
   │
   │  python tools/obfuscate.py dist/VanityGeneral_INTEGRATED.lua dist/VanityGeneral_OBF.lua
   ▼
dist/VanityGeneral_OBF.lua          (GENERATED — strings encrypted, names mangled)
   │
   │  python tools/encrypt.py dist/VanityGeneral_OBF.lua release/VanityGeneral.lua
   ▼
release/VanityGeneral.lua           (encrypted self-decrypting public release)
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
Utility          (leaf — server hop/rejoin, GUI parent)
Cloak            (leaf — environment hiding: hidden globals, instance filters)
NoRecoil         (leaf — recoil suppression)
Triggerbot       (leaf — auto-fire)
DrawingESP       (leaf — executor Drawing boxes/tracers)
Visuals          (leaf — fullbright/no fog)

Webhook          → Configuration
ESP              → Configuration, Utility, Candidates, Cloak
CameraDirector   → Utility, Candidates, Cloak
Hitbox           → CameraDirector
SilentAim        → CameraDirector
NoSpread         → NoRecoil
UI               → ConfigManager, Utility, Webhook, Cloak
Movement         → UI
Controller       → Configuration, ConfigManager, CameraDirector, Hitbox,
                   SilentAim, NoRecoil, NoSpread, Triggerbot, ESP,
                   DrawingESP, Visuals, Utility, UI, Movement, Webhook, Cloak
Main             → Controller
```

`Main` is the entry chunk: it stops any previously injected copy (found via
`getgenv().VanityGeneral`, which the Cloak serves through the environment
metatable) and calls `Controller.Start()`, then returns the
Controller table so `loadstring(...)()` yields the public API.

## Module Responsibilities

### Configuration
- Single source of truth for every setting (`Camera`, `ESP`, `NoRecoil`,
  `NoSpread`, `Triggerbot`, `Movement`, `SilentAim`, `Hitbox`, `Drawing`,
  `Visuals`, `UI`, `Webhook`)
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

### Cloak (environment hiding)
- `HideGlobal(name, value)`: serves `getgenv().VanityGeneral` through a
  metatable `__index` instead of a raw key, so reads work but `pairs()` scans
  of the environment never enumerate it; re-executions wrap the previous
  chunk's `__index`, which is how Main still finds the old copy to stop it
- `Protect(inst)` + `Install()`: hooks `game`'s `__namecall` so GAME threads
  (`checkcaller() == false`) get `GetChildren`/`GetDescendants`/
  `FindFirstChild*` results filtered of registered instances and their
  subtrees; our own threads see everything. Chains under the Silent Aim hook.
  The filter installs **on demand** — only when a protected instance is
  actually game-visible (under Workspace or PlayerGui); with `gethui`
  available and everything disabled, the game's metatable is never touched
- `RandomName()`: throwaway alphabetic names for every DataModel object the
  script creates (ESP container/boxes/tags, FOV ring, UI root, the NoRecoil
  render bind), so no "Vanity*" string exists for name-signature scans
- `CClosure(fn)`: wraps hook replacements in `newcclosure` so they present as
  C functions — `islclosure()` false, no Lua source in `debug.getinfo`,
  `string.dump` fails, no Lua frames in a game's `debug.traceback`. Used by
  every hook in the bundle (Cloak, Silent Aim, NoSpread); plain-function
  fallback where `newcclosure` is missing
- All best-effort: without `hookmetamethod`/`getnamecallmethod`/`checkcaller`
  the filters never install and the script behaves as before

### CameraDirector (aimbot)
- `FindBestTarget(config)`: alive check, Team Check, Target Bots (NPCs),
  wall check, world-range filter, FOV cone filter, hitbox region resolution
  (`Random (Weighted)` chance weights or a fixed region)
- `PointCamera(position, smoothness)`: CFrame lerp toward the target
- `Update(config, debug)`: resolves the target each frame and steers the
  camera; returns the current target
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
  delay sampled between `MinDelay`/`MaxDelay`; vischeck + max-distance options.
  The refire interval is re-sampled per shot (~6-11 clicks/s) so server-side
  timing analysis sees human jitter, not a fixed metronome
- **SilentAim**: hooks `game`'s metatable (`__namecall`, `__index`) via
  `hookmetamethod` — installed **lazily on first enable** (a per-frame
  `Update` from the controller loop), never at load — to rewrite shots onto
  the target — the aimbot's lock, or
  else whoever the crosshair is nearest (no wall check). When the line to the
  target is blocked, the launch direction is raised over an arc apex probed
  above the obstruction, so gravity drops the shot onto the target; clear
  lines stay flat. **Network plausibility gate**: only targets within
  `MaxAngle` of the real camera aim get rewritten, and only `HitChance`% of
  those — shots outside the cone go out unbent as legit misses, so the server
  never sees hit claims it can't reconcile with your look direction, and your
  hit rate stays statistically human. Fully guarded: no-ops without
  `hookmetamethod`/`getnamecallmethod`, and only rewrites calls from game
  scripts (`checkcaller`)
- **Hitbox**: client-side inflation of enemy root parts (size/transparency),
  driven by the aimbot's candidate set; restores originals on cleanup. Note:
  inflation is inherently irreconcilable if the server raycasts hit claims
  against true positions — keep `Size` modest on servers that validate
- **NoRecoil**: locks the camera against recoil climb; runs on a
  `BindToRenderStep` at `Camera + 1` priority so the correction lands *after*
  the game's own camera update; stands down while the aimbot owns the camera
- **NoSpread**: wraps `math.random` to pull spread rolls toward centre while
  the fire button is held; restores the original on cleanup

### Movement
- Fly, noclip, speed (only the surplus over stock WalkSpeed), infinite jump,
  click-TP (modifier key + left click)
- Anti-lagback pulse (100 ms boost / 150 ms coast) is always on for fly/speed,
  and click-TP always hops in fixed 10-stud steps — no configuration
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
- Settings tab: interface options, config profile save/load/delete,
  Server Hop / Rejoin buttons, Unload button

### Controller (orchestrator + public API)
- `Start()`: inits ESP/UI/Movement/SilentAim, connects player and
  input handlers, starts the single RenderStepped loop, binds NoRecoil after
  the camera, exports itself as `getgenv().VanityGeneral` (hidden from
  enumeration via the Cloak), fires the webhook
  "loaded" embed if configured. No metatable hooks at Start — the Cloak
  filter installs on first game-visible Protect, Silent Aim on first enable
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

## The Encrypter (tools/encrypt.py)

`python tools/encrypt.py <in.lua> <out.lua>` — final release stage. Encrypts
the obfuscated build into a self-decrypting stub: the payload ships as
XOR-encrypted byte tables under a random per-build key, and a small loader
decrypts it in memory and `loadstring`s it, so the released file contains no
readable Lua at all. Self-verifies (decrypts and compares against the input)
before writing. Deterrence, not cryptography — the key ships in the file.

## Release Pipeline

```
edit src/  →  python tools/build.py  →  test dist build (bootstrap.lua)
           →  python tools/obfuscate.py dist/VanityGeneral_INTEGRATED.lua dist/VanityGeneral_OBF.lua
           →  python tools/encrypt.py dist/VanityGeneral_OBF.lua release/VanityGeneral.lua
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
