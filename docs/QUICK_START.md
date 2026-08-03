# Quick Start Guide

## Executor / loadstring Setup (single file)

1. **Put `dist/VanityGeneral_INTEGRATED.lua`** in your executor's workspace folder (where `readfile` reads from).

2. **Run this in the executor**:
   ```lua
   local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
   VanityGeneral.Start()
   ```
   Or just execute `bootstrap.lua`, which does the above with error reporting.

3. **Keys**: `RightShift` = menu · `LeftAlt` = camera tracking · `End` = unload

**Re-running is safe** — it stops the previous copy first, so you never stack
duplicate windows or render loops.

Control it from anywhere via the global handle:
```lua
getgenv().VanityGeneral.Stop()      -- tear everything down
getgenv().VanityGeneral.Toggle()    -- start/stop in one call
getgenv().VanityGeneral.IsRunning() -- true / false
```

---

## 30-Second Setup (Roblox Studio, modular)

1. **Create folder**: `StarterPlayer > StarterPlayerScripts > VanityGeneral`

2. **Add these ModuleScripts** (copy code from the files in `src/`):
   - `Configuration`
   - `CameraDirector`
   - `ESP`
   - `UI`

3. **Add MainController as LocalScript** in the `VanityGeneral` folder

4. **Play game** → Press RightShift to open menu

Done! ✅

---

## Quick API Reference

### Configuration (Read/Write)
```lua
local Config = require(game.StarterPlayer.StarterPlayerScripts.VanityGeneral.Configuration)

-- Read values
print(Config.Camera.Enabled)
print(Config.ESP.Color)

-- Change values
Config.Camera.Smoothness = 0.2
Config.ESP.MaxDistance = 500
```

### CameraDirector (Read-Only)
```lua
local Camera = require(game.StarterPlayer.StarterPlayerScripts.VanityGeneral.CameraDirector)

-- Find target
local target = Camera:FindBestTarget(config)
if target then
    print("Tracking:", target.Character.Name)
end

-- Update (called by MainController)
Camera:Update(config, debug)
```

### ESP (Read-Only)
```lua
local ESP = require(game.StarterPlayer.StarterPlayerScripts.VanityGeneral.ESP)

-- Initialize
ESP:Init()

-- Update (called by MainController)
ESP:Update(config)

-- Cleanup
ESP:Cleanup()
```

### UI (Read-Only)
```lua
local UI = require(game.StarterPlayer.StarterPlayerScripts.VanityGeneral.UI)

-- Show/hide
UI:Toggle()
UI:Show()
UI:Hide()
```

---

## Common Customizations

### Change Menu Key
**File**: src/Configuration.lua
```lua
Config.UI.MenuKey = Enum.KeyCode.F5  -- Changed from RightShift
```

### Change Camera Smoothness
**File**: src/Configuration.lua
```lua
Config.Camera.Smoothness = 0.3  -- Higher = faster tracking
```

### Change ESP Color
**File**: src/Configuration.lua
```lua
Config.ESP.Color = Color3.fromRGB(255, 0, 0)  -- Red
```

### Change Max Distance
**File**: src/Configuration.lua
```lua
Config.Camera.MaxDistance = 500  -- Increase range (studs)

Config.ESP.MaxDistance = 2000  -- Different for ESP
```

### Disable Specific Feature on Startup
**File**: src/MainController.lua (in init() function)
```lua
-- Add after UI:Init()
Configuration.Camera.Enabled = false  -- Start with camera off
Configuration.ESP.Enabled = false     -- Start with ESP off
```

---

## Adding Features

### Example: Add Toggle Keybind
**File**: src/MainController.lua (in init() function)
```lua
inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if UI:IsCapturingKey() then return end

    if input.KeyCode == Configuration.UI.MenuKey then
        UI:Toggle()
    end

    -- NEW: Add E key for quick camera toggle
    if input.KeyCode == Enum.KeyCode.E then
        Configuration.Camera.Enabled = not Configuration.Camera.Enabled
        print("Camera:", Configuration.Camera.Enabled and "ON" or "OFF")
    end
end)
```

### Example: Add Team Filtering
**File**: src/CameraDirector.lua (modify FindBestTarget)
```lua
for _, player in ipairs(Players:GetPlayers()) do
    if player == LocalPlayer then
        continue
    end
    
    -- NEW: Skip players on same team
    if player.Team == LocalPlayer.Team then
        continue
    end
    
    local character = player.Character
    -- ... rest of code
end
```

### Example: Add Distance-Based ESP Opacity
**File**: src/ESP.lua (modify updatePlayer function)
```lua
-- Calculate distance
local distance = (hrp.Position - myRoot.Position).Magnitude

-- Set opacity based on distance
local distanceFactor = 1 - math.min(distance / config.MaxDistance, 1)
local adjustedOutlineOpacity = config.OutlineOpacity * distanceFactor

entry.hl.OutlineTransparency = 1 - adjustedOutlineOpacity
```

### Example: Add Current Target Display
**File**: src/UI.lua (in makeLabel for the Aimbot tab)
```lua
local targetLabel = makeLabel(parent, "Current Target", function()
    -- Would need to pass target from MainController to UI
    return "None"  -- For now
end)
```

---

## Troubleshooting

### Symptoms: Nothing happens when I press RightShift
**Solution**: 
- Check that UI module is in the correct folder
- Verify MainController is loading all modules
- Check Output tab for errors

### Symptoms: Camera tracking very jittery
**Solution**:
- Increase Camera.Smoothness (0.2 or higher)
- Decrease Camera.MaxDistance (200 or lower)
- Check if target is obstructed

### Symptoms: ESP doesn't highlight anyone
**Solution**:
- Check ESP.Enabled is true in UI
- Verify players are within MaxDistance
- Check Outline Opacity is > 0
- Make sure highlight color is not black/invisible

### Symptoms: High latency/lag
**Solution**:
- Disable ESP or lower MaxDistance
- Disable thick outlines (use Thickness = 1)
- Disable Fill mode
- Reduce number of players in game

---

## Performance Tips

1. **Default thickness to 1** (no shells)
   ```lua
   Config.ESP.Thickness = 1
   ```

2. **Reduce max distances** if lagging
   ```lua
   Config.ESP.MaxDistance = 500  -- Down from 1000
   ```

3. **Keep outline opacity high** (less transparency)
   ```lua
   Config.ESP.OutlineOpacity = 1  -- Full opacity
   ```

4. **Disable fill mode** for performance
   ```lua
   Config.ESP.Filled = false
   ```

---

## Module File Locations

```
StarterPlayer
└── StarterPlayerScripts
    └── VanityGeneral (Folder)
        ├── Configuration (ModuleScript)
        ├── CameraDirector (ModuleScript)
        ├── ESP (ModuleScript)
        ├── UI (ModuleScript)
        └── MainController (LocalScript) ← STARTS HERE
```

---

## Code Examples

### Print Current Config
```lua
local Config = require(game.StarterPlayer.StarterPlayerScripts.VanityGeneral.Configuration)
print(game:GetService("HttpService"):JSONEncode(Config))
```

### Disable ESP Temporarily
```lua
local Config = require(game.StarterPlayer.StarterPlayerScripts.VanityGeneral.Configuration)
Config.ESP.Enabled = false
```

### Get Current Target
```lua
local Camera = require(game.StarterPlayer.StarterPlayerScripts.VanityGeneral.CameraDirector)
local Config = require(game.StarterPlayer.StarterPlayerScripts.VanityGeneral.Configuration)
local target = Camera:FindBestTarget(Config.Camera)
if target then
    print("Tracking:", target.Character.Name)
end
```

---

## What's Next?

- Read docs/SETUP.md for detailed installation
- Read docs/ARCHITECTURE.md to understand data flow
- Read docs/history/REFACTORING_SUMMARY.md for technical details
- Modify src/Configuration.lua to customize settings
- Extend modules to add features

---

**Need help?** Check the Output console for error messages.
**Want to contribute?** The modular system makes it easy to improve individual components!
