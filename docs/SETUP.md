# Vanity-General Setup Guide

A professional, unified camera tracking and player ESP system for Roblox.

This guide covers the modular source in `src/`. For the single-file executor
build, see `docs/LOADSTRING_GUIDE.md` and `bootstrap.lua`.

## Installation

### Method 1: Using MainController (Recommended)

1. Create a folder in `StarterPlayer > StarterCharacterScripts` or `StarterPlayer > StarterPlayerScripts`
   - Name it `VanityGeneral`

2. Copy these files from `src/` as **ModuleScripts** inside the folder:
   - `Configuration`
   - `CameraDirector`
   - `ESP`
   - `UI`

3. Copy `src/MainController.lua` as a **LocalScript** in the same folder

4. The system will initialize automatically on spawn

(No other modules are required — Configuration and ESP no longer depend on
StringObfuscation. The modules in `src/security/` are optional and only used
by the integrated executor build.)

### Method 2: Using Loader Script

1. Create a folder in `StarterPlayer > StarterPlayerScripts`
   - Name it `VanityGeneral`

2. Add all module scripts as listed above

3. Copy `src/Loader.lua` as a **LocalScript** in `StarterPlayer > StarterPlayerScripts`

   (Loader and MainController are alternative entry points — use ONE of them,
   never both.)

## Features

### Camera Tracking
- **Smooth camera targeting** toward selected player
- **Multiple target parts**: any standard rig part (full R15 + R6 list)
- **Visibility checks** via raycasting
- **Adjustable smoothness** (0.05 - 1.0)
- **Max distance filtering** (100 - 500 studs)
- **Toggle on/off** from UI or the LeftAlt keybind

### ESP System
- **Player outlines** with color picker
- **Optional fill** highlighting
- **Adjustable thickness** (1 - 6)
- **Separate outline and fill opacity** controls
- **Max distance filtering** (100 - 2000 studs)
- **Shell rendering** for thick outlines
- **Automatic respawn handling**

### UI System
- **Modern dark theme** with smooth animations
- **Tabbed interface**: Aimbot, ESP, Settings
- **Draggable window**
- **Full color picker** with HSV selector
- **Live value displays**
- **Rebindable hotkeys** (menu, camera toggle, unload)
- **Settings reset button**
- **Smooth toggle animations**

## Controls

- **RightShift**: Open/close menu
- **LeftAlt**: Toggle camera tracking
- **End**: Unload / tear everything down
- **Mouse/Touch**: Interact with UI elements

## Configuration

All settings are in the **Configuration** module (`src/Configuration.lua`):

```lua
Config.Camera = {
    Enabled = false,                    -- Camera tracking on/off
    Smoothness = 0.15,                  -- Camera interpolation speed
    MaxDistance = 300,                  -- Max target range (studs)
    TargetPart = "Head",                -- Target body part
    TargetPartOptions = { ... },        -- Available parts
    ToggleKey = Enum.KeyCode.LeftAlt,   -- Camera tracking toggle key
}

Config.ESP = {
    Enabled = false,                    -- ESP on/off
    Color = Color3.fromRGB(165, 75, 255), -- Default highlight color
    Filled = false,                     -- Fill toggle
    Thickness = 1,                      -- Outline thickness
    OutlineOpacity = 1,                 -- Outline transparency (0-1)
    FillOpacity = 0.4,                  -- Fill transparency (0-1)
    MaxDistance = 1000,                 -- Max render distance
}

Config.UI = {
    Scale = 1,                          -- UI scale factor
    MenuKey = Enum.KeyCode.RightShift,  -- Toggle key
    UnloadKey = Enum.KeyCode.End,       -- Panic key: full teardown
    Visible = false,                    -- Initial visibility
}
```

## Architecture

### Modules

**Configuration**
- Centralized settings for all systems
- Single source of truth for all values

**CameraDirector**
- Target detection and prioritization
- Viewport distance calculations
- Visibility raycasting
- Smooth camera interpolation

**ESP**
- Player highlight management
- Shell rendering for thick outlines
- Frame-by-frame synchronization
- Memory-efficient cleanup

**UI**
- Modern tabbed interface
- Live control updates
- Color picker with HSV selector
- Draggable window with smooth animations

**MainController** / **Loader**
- Orchestrates all systems
- Single RenderStepped loop for performance
- Unified input handling
- Proper cleanup on player leave

## Performance

- **Single RenderStepped connection** for both camera and ESP
- **Cached references** to avoid expensive lookups
- **Proper disconnection** of all connections on cleanup
- **Shell cleanup** when disabled or player disconnects
- **No duplicate functions** or unnecessary cloning

## Customization

### Change Menu Key
Edit `src/Configuration.lua`:
```lua
Config.UI.MenuKey = Enum.KeyCode.F5  -- Change to desired key
```

### Change Default Colors
Edit `src/Configuration.lua`:
```lua
Config.ESP.Color = Color3.fromRGB(255, 0, 0)  -- Red instead of purple
```

### Adjust Default Distances
Edit `src/Configuration.lua`:
```lua
Config.Camera.MaxDistance = 500  -- Increase range (studs)

Config.ESP.MaxDistance = 2000  -- Increase ESP range
```

## Troubleshooting

### Systems not initializing
- Verify all modules are correctly named
- Check that modules are placed in correct location
- Look for errors in Output console

### Camera not tracking
- Ensure camera tracking is toggled ON in UI
- Verify target players are visible and alive
- Check MaxDistance and TargetPart settings

### ESP not showing
- Enable ESP toggle in the ESP tab
- Verify players are within MaxDistance
- Check Color is not transparent
- Ensure Outline Opacity is > 0

### UI not opening
- Press RightShift (or configured MenuKey)
- Verify UI module loaded without errors
- Check game's GUI rendering is enabled

## Code Quality

- **Professional Lua standards** throughout
- **Proper memory management** with cleanup
- **Error handling** at system boundaries
- **Comments** explaining WHY not WHAT
- **No unnecessary abstractions**
- **Local variables** throughout
- **Proper scope management**

## Future Enhancements

Possible additions without modifying core architecture:
- Player list with clickable targeting
- Hotkey support for quick toggles
- Save/load settings from file
- Different ESP modes (bones, skeletal)
- Sound ESP
- Distance-based opacity
- Custom alert notifications

---

**Created for educational purposes in Roblox development.**
