# Vanity-General — Quick Start

Get running in under two minutes, two ways.

## Option A — Executor (recommended)

Paste into your executor:

```lua
loadstring((function(u) if game.HttpGet then return game:HttpGet(u) end return request({Url=u,Method="GET"}).Body end)("https://raw.githubusercontent.com/cookedaj/vanity-release/main/VanityGeneral.lua?t="..tick()))().Start()
```

Then: **RightShift** opens the menu, **LeftAlt** toggles camera tracking,
**End** unloads.

If your executor has no HTTP function, copy `release/VanityGeneral.lua` into
its workspace folder and use `loadstring(readfile("VanityGeneral.lua"))().Start()`.

## Option B — Roblox Studio (development)

1. In `ReplicatedStorage`, create a Folder named `VanityGeneral`.
2. Add every `src/*.lua` file as a **ModuleScript** inside it (Main.lua too).
3. Add a **LocalScript** in `StarterPlayer > StarterPlayerScripts`:

```lua
local Controller = require(game.ReplicatedStorage.VanityGeneral.Main)
-- Main auto-starts on require and returns the controller
```

Studio is where you develop: errors point at real files/lines instead of the
bundled blob.

## First-run checklist

- [ ] Menu opens with RightShift
- [ ] ESP tab → Enabled shows highlights on players
- [ ] Aimbot tab → Camera Tracking + LeftAlt tracks the nearest visible enemy
- [ ] Movement tab → Fly steers with WASD + Space/Shift
- [ ] End unloads cleanly (no leftover UI/ESP)

## Where to go next

- `docs/QUICK_REFERENCE.md` — one-page cheat sheet
- `docs/LOADSTRING_GUIDE.md` — full runtime API + FAQ
- `docs/ARCHITECTURE.md` — module graph, bundler, release pipeline
- `README.md` — full feature list and development workflow

## Updating (maintainers)

```bash
.venv-obf/Scripts/python.exe tools/build.py src dist/VanityGeneral_INTEGRATED.lua
.venv-obf/Scripts/python.exe tools/obfuscate.py dist/VanityGeneral_INTEGRATED.lua release/VanityGeneral.lua
# push release/VanityGeneral.lua to the public vanity-release repo
```

Users get the update on their next inject — no loader change needed.
